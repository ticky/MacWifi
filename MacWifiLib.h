#ifndef __MACWIFI__
#define __MACWIFI__

#include <string>
#include <functional>
#include <map>
#include "WifiEvents.h"

using namespace std;

class MacWifiResponse
{
	public:
		bool Success;
		unsigned int StatusCode;
		string ErrorMsg;
		string Content;
};

class MacWifiLib
{
	public:
		void Get(string requestUri, function<void(MacWifiResponse)> onComplete);
		void Post(string requestUri, string content, function<void(MacWifiResponse)> onComplete);
		OSErr ProcessReply(AppleEvent* appleEvent);

	private:
		OSType _appSig;
		map<int, function<void(MacWifiResponse)>> _callbacks;
		void SendRequestEvent(string method, string uri, string content, function<void(MacWifiResponse)> onComplete);
		void GetEventAddress(AEAddressDesc* address);
		OSErr SendEvent(AppleEvent* appleEvent);
};

#endif