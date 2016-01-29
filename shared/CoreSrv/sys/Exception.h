////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/Exception.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::sys::Exception
//
// расширение работы с Иключениями для CORBA
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SYS_EXCEPTION_H__
#define __SHARED_CORESRV_SYS_EXCEPTION_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/sys/Exception.h"

//#UC START# *4600026B033C_USER_INCLUDES*
#include "tao/Exception.h"
#include "tao/SystemException.h"
//#UC END# *4600026B033C_USER_INCLUDES*

namespace CoreSrv {

//#UC START# *4600026B033C_USER_DEFINITION*
class Exception {
public:
	class CorbaExHandler: virtual public Core::RefCountObjectBase {
	public:
		virtual bool do_handle (CORBA::Exception& ex, bool must_throw) = 0;
	};

	typedef std::vector < Core::Var<CorbaExHandler> > CorbaExHandlers;
	typedef ACE_Singleton <CorbaExHandlers, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;

public:
	static void register_corba_ex_handler (CorbaExHandler* ch);

	static bool corba_ex_handler (CORBA::Exception& ex, bool must_throw);
};

class ConstViolation : public CORBA::SystemException {
public:
	static const CORBA::ULong CONST_VIOLATION_CODE;

	ConstViolation();
	
	virtual void _raise (void) const;

	static ConstViolation* _narrow(CORBA::SystemException* exception);
};

#ifdef _STD_EX_DEFINES
#undef _STD_EX_DEFINES

#undef _SAFE_CATCH
#define _SAFE_CATCH                      \
	} catch (std::exception& ex) {           \
		ACE_DEBUG ((LM_ERROR, "(%P|%t) STD EXCEPTION: %s, %s:%s\n", ex.what (), __FILE__, __LINE__));   \
	} catch (CORBA::Exception& ex) {         \
		ACE_PRINT_EXCEPTION (ex, __FILE__);  \
	} catch (...) {                          \
		ACE_DEBUG ((LM_ERROR, "(%P|%t) UNKNOWN EXCEPTION, %s:%s\n", __FILE__, __LINE__));  \
	}

#undef _DLL_TRY
#define _DLL_TRY                         \
try_agane:                                   \
	try {

#undef _DLL_CATCH
#define _DLL_CATCH                       \
	} catch (CORBA::Exception& ex) {         \
		if (CoreSrv::Exception::corba_ex_handler (ex, true)) {   \
			goto try_agane;                  \
		}                                    \
		throw;                               \
	} catch (std::exception& ex) {           \
		Core::Exception::std_ex_handler(ex);  \
		throw;                               \
	} catch (...) {                          \
		Core::Exception::unknown_ex_handler(); \
		throw;                               \
	}

#undef _DLL_CATCH_RETURNED
#define _DLL_CATCH_RETURNED              \
	} catch (CORBA::Exception& ex) {         \
		if (CoreSrv::Exception::corba_ex_handler (ex, false)) {  \
			goto try_agane;                  \
		}                                    \
	} catch (std::exception& ex) {           \
		Core::Exception::std_ex_handler(ex);  \
		throw;                               \
	} catch (...) {                          \
		Core::Exception::unknown_ex_handler(); \
		throw;                               \
	}

#endif

//#UC END# *4600026B033C_USER_DEFINITION*

} // namespace CoreSrv


#endif //__SHARED_CORESRV_SYS_EXCEPTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
