#ifndef _WIFI_MODULE_
#define _WIFI_MODULE_

#include <string>
#include <vector>
#include <functional>
#include <MacHTTP/HttpClient.h>
#include "../Comms.h"
#include "../Network.h"

using namespace std::placeholders;

enum WifiMode
{
	WPA2PSK
};

enum WifiEncryption
{
	AES
};

class WifiModule
{
	public:
		virtual void GetNetworks() = 0;
		virtual void Connect(std::string ssid, WifiMode mode, WifiEncryption encryption, std::string pwd) = 0;

	protected:
		void SaveNetworks(std::vector<Network> networks);
		void SaveError(std::string errorMsg);
};

#endif // _WIFI_MODULE_ 