#ifndef _SWITCHBASE_H_
#define _SWITCHBASE_H_

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "Business/GblPilot/Home/Client.h"
#include "Services/GslUserManager/Home/Client.h"
#include "Services/GslSecurity/Home/Client.h"
#include "Global/Core/Home/Common.h"
#include "Global/Defines/Home/Define.h"

#if defined (_GCD_CLIENT)
#include "Services/GslSessionHandlerClient/Home/Client.h"
#include "Services/GslSessionHandlerClient/Home/Server.h"
#endif
#include <ace/Thread_Manager.h>
#include <ace/Synch.h>
#endif


#if defined (_GCD_CLIENT) || defined (PILOT)
class BaseSwitcher : public GCM::GCMSimpleServer {
public:
		std::string _login, _pass;
        GslUserManager::UserManager_var um;
		GblPilot::BaseSwitch_var bs;
        short updateType;
        BaseSwitcher();
        void execute();
        void terminate_exit ();
        void logout_current ();
private:
        bool m_logged;		
};
#endif

#endif //_SWITCHBASE_H_