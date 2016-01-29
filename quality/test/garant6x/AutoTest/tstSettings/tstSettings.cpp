#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/Start/StartUnit.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "Garant/GblAdapter/Document/DataReadingStream_i.h"
#include "Garant/GblAdapter/Search/QueryTagNode_i.h"
#include "Garant/GblAdapter/Search/Query_i.h"

#include "helpers/logs.h"
#include <map>
#include <conio.h>
#include <stdexcept>
#include <time.h>
#include <process.h>
#include <string.h>

#define MAX_THREAD 1
#define GetRandom( min, max ) ((rand() % (int)(((max) + 1) - (min))) + (min))
#define MAX_READ_BUFFER 500000L
#define DEFAULT_COUNT_SETTINGS 1000L

char sett_str[] = "Setting N%d";
typedef std::pair <char*, char*> PCHAR_Pair;	

using namespace GCL;

class ThreadParam
{
public:
	ThreadParam(int s1=1,int s2=1)
	{
	};
	char user_login[100];
	char user_pass[100];
	long count_settings;
	GblAdapter::ISettings* settings;

};

bool TryConnect (GblAdapter::IAuthorization* authorization, ThreadParam* par, GblAdapter::ICommon*& common_interfaces)
{
	while (1) {
		try {
			authorization->login(par->user_login,par->user_pass, common_interfaces);
			LOG_D(("login()::User login, login=%s, pass=%s",par->user_login,par->user_pass));
			break;
		} catch (GblAdapter::WrongAuthentication) {
			try {
					authorization->autoregistration("Kirill",par->user_login,par->user_pass,"pugin@garant.ru",common_interfaces);
					LOG_D(("autoregistration()::UserRegistred, login=%s, pass=%s",par->user_login,par->user_pass));
					break;
			}	catch (GblAdapter::LoginDuplicate){
					LOG_D(("User %s already in user's base",par->user_login));
					return false;
			}	catch (GblAdapter::WrongAuthentication) {
					LOG_ERR(("WrongAuthentication"));
					return false;
			}	catch (...) {
				LOG_UEX(("Can't create new user"));
				return false;
			}
	
		}	catch (GblAdapter::AlreadyLogged) {
			LOG_D(("User %s already logged in",par->user_login));
			return false;
		}	catch (...) {
				LOG_UEX(("Can't create new user"));
				return false;
		}

	}
	return true;
}
DWORD WINAPI SettingsWork(LPVOID Param)
{
	ThreadParam* par = (ThreadParam*)Param;
	GblAdapter::IString_var i_string;
	char strSettings[1000];
	char Settings_value[1000];
	unsigned long k = 1;
	while (1)
	{
		{
			StopWatch sw("work with settings, %d of %d", k, par->count_settings);
			sprintf(strSettings,sett_str,/*GetRandom(0,1000000)*/k);
			sprintf(Settings_value,"%d",/*GetRandom(0,100000)*/k);
			try {
					par->settings->set_string(strSettings,Settings_value);
					try {
						par->settings->get_string(strSettings,i_string.out());
						
					} catch (GblAdapter::InvalidValueType &e) {
							LOG_ERR (("get_string()::InvalidValueType %s:, %s = %s", e.id(), strSettings));
					} catch (GblAdapter::Exception& ex) {
						LOG_CEX (((CORBA::Exception&) ex,"Can't read settings"));
					} catch (GblAdapter::NoServer&) {
						LOG_ERR(("Server was dead"));
						return -3;
					} catch (...) {
							LOG_ERR (("get_string()::UNKNOWN_EX: %s = %s, ",strSettings,Settings_value));
							if (MessageBox(NULL, "Can't read settings!!!", "Error in get_string()", MB_OKCANCEL) != IDOK)
								return -1;
					}
			} catch (GblAdapter::InvalidValueType &e) {
							LOG_ERR (("set_string()::InvalidValueType %s: %s = %s",e.id (),strSettings,Settings_value));
			} catch (GblAdapter::ConstantModify &e) {
							LOG_ERR (("set_string()::ConstantModify %s: %s = %s", e.id (), strSettings,Settings_value));
			} catch (GblAdapter::Exception& ex) {
						LOG_CEX (((CORBA::Exception&) ex,"Can't write settings"));
			} catch (GblSettings::PropertyValueNotDefined&) {
						LOG_ERR (("set_string()::PropertyValueNotDefined: %s = %s",strSettings,Settings_value));
			} catch (GblAdapter::NoServer&) {
						LOG_ERR(("Server was dead"));
						return -3;
			} catch (...) {
						LOG_ERR (("set_string()::UNKNOWN_EX: %s = %s",strSettings,Settings_value));
						if (MessageBox(NULL, "Can't write settings!!!", "Error in set_string()", MB_OKCANCEL) != IDOK)
							return -2;
			}
			
		}
		if ((par->count_settings >0) && (k++>par->count_settings))
			break;
	} 
	MessageBox(NULL, "Complete work with settings!!!\n Close the console window please.", "Complete", MB_OK);
	return 0;
}
int main(int argc, char* argv[])
{	

	try {
		gbladapter_init();
	} catch ( GblAdapter::NoServer& ) {
		LOG_W (("No server"));
		_getch();
		return 0;
	} catch (GblAdapter::IPAddressNotFound& ) {
		LOG_W (("Failed to find IP"));
		_getch();
		return 0;
	} catch (GblAdapter::NoMoreConnections& ) {
		LOG_W (("No more connections to server"));
		_getch();
		return 0;
	} catch (GblAdapter::Exception& ex) {
		LOG_CEX (((CORBA::Exception&) ex,"Can't attach to facet"));
		_getch();
		return 0;
	} catch (...) {
		LOG_UEX (( "Unable to inicialize Adapter"));
		_getch();
		return 0;
	}


	ThreadParam par;
	GblAdapter::ISettings_var settings;
	GblAdapter::ICommon_var common_interfaces;
	GblAdapter::IAuthorization_var authorization;
	HANDLE ThreadHandle;
	DWORD dwThreadId;
	if ((argc-3)>=0)
	{
		sprintf(par.user_login,argv[1]);
		sprintf(par.user_pass,argv[2]);
		if ((argc-4)>=0)
		{
			par.count_settings = atol(argv[3]);
		} else {
			par.count_settings = DEFAULT_COUNT_SETTINGS;
		}
		gbladapter_make_interface(authorization.out());
		if (!TryConnect(authorization.in(), &par, common_interfaces.out()))
		{	
			return -1;
		}
		common_interfaces->get_settings(settings.out());
		par.settings = settings.in();
		ThreadHandle = CreateThread( 
			NULL,                        // default security attributes 
			0,                           // use default stack size  
			SettingsWork,                  // thread function 
			&par,                // argument to thread function 
			0,                           // use default creation flags 
			&dwThreadId);  
	}
	while (!_kbhit());
	TerminateThread(ThreadHandle, 0);
	authorization->logout();
	gbladapter_done();
	return 0;	
}