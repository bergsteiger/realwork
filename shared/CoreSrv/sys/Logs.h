////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/Logs.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::sys::Logs
//
// расширение работы с Логами для CORBA
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SYS_LOGS_H__
#define __SHARED_CORESRV_SYS_LOGS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/sys/Logs.h"

//#UC START# *45FF9E0B031C_USER_INCLUDES*
#include "tao/Exception.h"
//#UC END# *45FF9E0B031C_USER_INCLUDES*

namespace CoreSrv {

//#UC START# *45FF9E0B031C_USER_DEFINITION*
void log_corba_exception (const CORBA::Exception& ex, const ACE_TCHAR *format_str, ...);

#ifndef GDS_NLOG_CORBAEXCEPTION
#define LOG_CEX(X) CoreSrv::log_corba_exception X
#else 
#define LOG_CEX(X)
#endif // GDS_NLOG_CORBAEXCEPTION

#if defined(GDS_NLOG_DEBUG) || defined(GDS_NLOG_CORBAEXCEPTION)
#define LOG_CEXD(X)
#else 
#define LOG_CEXD(X) CoreSrv::log_corba_exception X
#endif //GDS_NLOG_DEBUG


#ifdef STD_CATCH_AND_LOG
#undef STD_CATCH_AND_LOG

#undef CATCH_AND_LOG
#define CATCH_AND_LOG(MESSAGE) \
	catch (std::exception& ex) { \
		LOG_SEX ((ex, MESSAGE)); \
	} catch (CORBA::Exception& ex) { \
		LOG_CEX ((ex, MESSAGE)); \
	} catch (...) { \
		LOG_UEX ((MESSAGE)); \
	}

#undef CATCH_LOG_AND_DO
#define CATCH_LOG_AND_DO(MESSAGE,CODE) \
	catch (std::exception& ex) { \
		LOG_SEX ((ex, MESSAGE)); \
		CODE\
	} catch (CORBA::Exception& ex) { \
		LOG_CEX ((ex, MESSAGE)); \
		CODE\
	} catch (...) { \
		LOG_UEX ((MESSAGE)); \
		CODE\
	}

#endif


//#UC END# *45FF9E0B031C_USER_DEFINITION*

} // namespace CoreSrv


#endif //__SHARED_CORESRV_SYS_LOGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
