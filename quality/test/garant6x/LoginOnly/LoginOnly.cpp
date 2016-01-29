#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/Start/StartUnit.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "helpers/logs.h"
#include <map>
#include <conio.h>
#include <stdexcept>
#include <time.h>



int main(int argc, char* argv[])
{	
	if (argc<3)
		return -1;
	try {
		gbladapter_init();
	} catch (...) {
		LOG_ERR(("Can'y init adapter!!!"));
	}

	GblAdapter::IAuthorization_var m_authorization;
	GblAdapter::ICommon_var m_common_interfaces;
	gbladapter_make_interface(m_authorization.out());
	if (m_authorization.in() == NULL)
		return -5;
	try {
			m_authorization->login(argv[1], argv[2], m_common_interfaces.out());
			LOG_D(("login()::User login, login=%s, pass=%s",argv[1],argv[2]));
		} catch (GblAdapter::WrongAuthentication) {
			try {
					m_authorization->autoregistration("Kirill",argv[1], argv[2],"pugin@garant.ru",m_common_interfaces.out());
					LOG_D(("autoregistration()::UserRegistred, login=%s, pass=%s",argv[1],argv[2]));
			}	catch (GblAdapter::LoginDuplicate){
					LOG_D(("User %s already in user's base",argv[1]));
					return -4;
			}	catch (GblAdapter::WrongAuthentication) {
					LOG_UEX(("Can't create new user"));
					return -3;
			}	catch (...) {
					LOG_ERR(("Can't authorizate user: %d...", argv[1]));
			}
				
		}	catch (GblAdapter::AlreadyLogged) {
			LOG_D(("User %s already logged in", argv[1]));
			return -2;
		}	catch (...) {
			LOG_ERR(("Can't login user: %d...", argv[1]));
		}
	//убиваем процесс
	TerminateProcess(GetCurrentProcess(), 0);
	return 0;
}