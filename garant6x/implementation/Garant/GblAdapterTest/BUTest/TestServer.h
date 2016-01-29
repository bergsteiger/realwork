#ifndef _TESTSERVER_H
#define _TESTSERVER_H

#if defined (_GCD_CLIENT)
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Services/GslSecurity/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Client.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Server.h"
#else
	#error preprocessor definitions _GCD_CLIENT must defined;
#endif


class TestServer : public GCM::GCMSimpleServer {
public:
	TestServer ();
	void execute();
};

#endif