#include <string>
#include <sstream> 
#include <Timer.h>
#include <Threads.h>
#include "VM300.h"

void VM300::Login(std::function<void()> onComplete)
{
	_onLoginComplete = onComplete;

	Comms::Http.Post(
		"http://" + string(WifiDataPtr->Hostname) + "/goform/login",
		"username=" + string(WifiDataPtr->Username) + "&z999=z999&password=" + string(WifiDataPtr->Password) + "&Login=&platform=pc",
		std::bind(&VM300::LoginResponse, this, _1));
}

void VM300::LoginResponse(HttpResponse& response)
{
	if (response.Success)
	{
		_onLoginComplete();
	}
	else
	{
		DoError("Login: " + response.ErrorMsg);
	}
}

void VM300::GetNetworks()
{
	Login(std::bind(&VM300::GetConnectedNetworkRequest, this));
}

void VM300::GetConnectedNetworkRequest()
{
	Comms::Http.Get(
		"http://" + string(WifiDataPtr->Hostname) + "/adm/status.asp",
		std::bind(&VM300::GetConnectedNetworkResponse, this, _1));
}

void VM300::GetConnectedNetworkResponse(HttpResponse& response)
{
	if (response.Success)
	{
		if (response.StatusCode == 200)
		{
			string searchStart = "SSID</td>\r\n        <td>";
			size_t startLength = searchStart.length();
			size_t start = response.Content.find(searchStart);
			size_t end;

			_currentSsid = "";

			if (start != string::npos)
			{
				end = response.Content.find("</td>", start + startLength);

				_currentSsid = response.Content.substr(
					start + startLength,
					end - start - startLength);
			}

			GetNetworksRequest();
		}
		else
		{
			DoError("GetConnectedNetwork: " + std::to_string(response.StatusCode) + " status returned.");
		}
	}
	else
	{
		DoError("GetConnectedNetwork: " + response.ErrorMsg);
	}
}

void VM300::GetNetworksRequest()
{
	Comms::Http.Get(
		"http://" + string(WifiDataPtr->Hostname) + "/goform/get_web_hotspots_list",
		std::bind(&VM300::GetNetworksResponse, this, _1));
}

void VM300::GetNetworksResponse(HttpResponse& response)
{
	if (response.Success)
	{
		if (response.StatusCode == 200)
		{
			WifiDataPtr->Networks.clear();

			stringstream ss;
			string line;

			ss.str(response.Content);

			while (std::getline(ss, line))
			{
				stringstream linestream(line);
				string name, temp, enc, mode;

				std::getline(linestream, name, '\t');
				linestream >> temp; // Column 2 = ID
				linestream >> temp; // Column 3 = Channel
				linestream >> temp; // Column 4 = Strength
				linestream >> enc;  // Column 5 = Encryption
				linestream >> mode; // Column 6 = Mode

				bool exists = false;
				for (std::vector<Network>::iterator it = WifiDataPtr->Networks.begin(); it != WifiDataPtr->Networks.end(); ++it)
				{
					if (it->Name == name)
					{
						exists = true;
						break;
					}
				}

				if (!exists && name != "[HiddenSSID]")
				{
					Network network;
					network.Name = name;
					network.Encryption = GetEncryption(enc);
					network.Mode = GetWifiMode(mode);
					network.Connected = (name == _currentSsid);
					WifiDataPtr->Networks.push_back(network);
				}
			}

			WifiDataPtr->Status = Idle;
			WifiDataPtr->UpdateUI = true;
		}
		else
		{
			DoError("GetNetworks: " + std::to_string(response.StatusCode) + " status returned.");
		}
	}
	else
	{
		DoError("GetNetworks: " + response.ErrorMsg);
	}
}

void VM300::Connect(string name, string id, WifiMode mode, WifiEncryption encryption, string pwd)
{
	_ssid = name;
	_mode = mode;
	_encryption = encryption;
	_pwd = pwd;

	Login(std::bind(&VM300::DeleteHotspotsRequest, this));
}

void VM300::DeleteHotspotsRequest()
{
	Comms::Http.Post(
		"http://" + string(WifiDataPtr->Hostname) + "/goform/deleteAllHotspots", "",
		std::bind(&VM300::DeleteHotspotsResponse, this, _1));
}

void VM300::DeleteHotspotsResponse(HttpResponse& response)
{
	if (response.Success)
	{
		if (response.StatusCode == 200)
		{
			ConnectRequest();
		}
		else
		{
			DoError("DeleteHotspots: " + std::to_string(response.StatusCode) + " status returned.");
		}
	}
	else
	{
		DoError("DeleteHotspots: " + response.ErrorMsg);
	}
}

void VM300::ConnectRequest()
{
	Comms::Http.Post(
		"http://" + string(WifiDataPtr->Hostname) + "/goform/wirelessBrdgApcli",
		"apcli_ssid=" + Util::UrlEncode(_ssid) +
		"&apcli_mode=" + GetWifiModeStr(_mode) +
		"&apcli_enc=" + GetEncryptionStr(_encryption) +
		"&apcli_ishide=0"
		"&apcli_wpapsk=" + Util::UrlEncode(_pwd) +
		"&apcli_issyn=1"
		"&apcli_repeaterssid=" + Util::UrlEncode(_ssid) + "_64"
		"&ra_off=0"
		"&EnDynamicMatchPara=1"
		"&isDnsNeedChange=1"
		"&allow_motion_dect=0"
		"&dhcpEnableButton=0"
		"&ApcliMatchMode=2"
		"&ApcliBlkCount=0",
		std::bind(&VM300::ConnectResponse, this, _1));
}

void VM300::ConnectResponse(HttpResponse& response)
{
	if (response.Success)
	{
		if (response.StatusCode == 200)
		{
			Restart();
		}
		else
		{
			DoError("Connect: " + std::to_string(response.StatusCode) + " status returned.");
		}
	}
	else
	{
		DoError("Connect: " + response.ErrorMsg);
	}
}

void VM300::Restart()
{
	Login(std::bind(&VM300::RestartRequest, this));
}

void VM300::RestartRequest()
{
	Comms::Http.Post(
		"http://" + string(WifiDataPtr->Hostname) + "/goform/SystemCommand",
		"command=reboot&SystemCommandSubmit=Restart",
		std::bind(&VM300::RestartResponse, this, _1));
}

void VM300::RestartResponse(HttpResponse& response)
{
	if (response.Success)
	{
		if (response.StatusCode == 200)
		{
			// Reboot takes about 60 secs - lets wait 80
			const double waitTime = (80 * 1000000);
			UnsignedWide startTime, curTime, diff;
			double timeDiff;

			Microseconds(&startTime);

			do
			{
				Microseconds(&curTime);
				timeDiff = Util::MicrosecondToDouble(&curTime) - Util::MicrosecondToDouble(&startTime);
				YieldToAnyThread();
			} while (timeDiff < waitTime);

			// Flag restart required for the Mac to get its new IP
			WifiDataPtr->Status = RestartRequired;
			WifiDataPtr->UpdateUI = true;
		}
		else
		{
			DoError("Restart: " + std::to_string(response.StatusCode) + " status returned.");
		}
	}
	else
	{
		DoError("Restart: " + response.ErrorMsg);
	}
}

void VM300::GetTunnel(string connect, function<void(GetTunnelResult)> onComplete)
{
	GetTunnelResult result;

	result.Success = false;
	result.ErrorMsg = "stunnel not supported by VM300 device.";

	onComplete(result);
}

string VM300::GetWifiModeStr(WifiMode& mode)
{
	switch (mode)
	{
	case WPA2:
		return "WPA2PSK";

	case WPA:
		return "WPAPSKWPA2PSK";

	default:
		return "OPEN";
	}
}

WifiMode VM300::GetWifiMode(string& mode)
{
	if (mode == "WPA2-PSK")
		return WPA2;

	if (mode == "WPAPSK-WPA2PSK")
		return WPA;

	return Open;
}

string VM300::GetEncryptionStr(WifiEncryption& encryption)
{
	switch (encryption)
	{
	case AES:
		return "AES";

	case TKIP:
		return "TKIPAES";

	default:
		return "NONE";
	}
}

WifiEncryption VM300::GetEncryption(string& encryption)
{
	if (encryption == "AES")
		return AES;

	if (encryption == "TKIPAES")
		return TKIP;

	return None;
}