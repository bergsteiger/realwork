////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/sys/Exception.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::sys::Exception
// Файл реализации утилитного набора Exception
//
// расширение работы с Иключениями для CORBA
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/sys/Exception.h"

//#UC START# *4600026B033C_CUSTOM_INCLUDES*
//#UC END# *4600026B033C_CUSTOM_INCLUDES*

namespace CoreSrv {

//#UC START# *4600026B033C*
void Exception::register_corba_ex_handler (CorbaExHandler* ch) {
	Singleton::instance()->push_back (CorbaExHandler::_duplicate(ch));
}

bool Exception::corba_ex_handler (CORBA::Exception& ex, bool must_throw) {
	for (CorbaExHandlers::iterator it = Singleton::instance()->begin(); it != Singleton::instance()->end(); ++it) {
		if ((*it)->do_handle (ex, must_throw)) {
			return true;
		}
	}
#ifdef WIN32
	try {
		LOG_CEX ((ex, "Exception raises through DLL border"));
	} catch (...) {
	}
	GDS_ASSERT (0);

	const char* rep_id = ex._rep_id ();
	const size_t rep_id_size = ACE_OS_String::strlen (rep_id)+sizeof (char);

	const void* buffer = ::CoTaskMemAlloc ((ULONG)rep_id_size);
	if (buffer != 0) {
		try {
			ACE_OS_String::strncpy ((char*)buffer, rep_id, rep_id_size);
		} catch (...) {
			::CoTaskMemFree ((void*)buffer);
			buffer = 0;
		}
	}

	if (buffer != 0) {
		::RaiseException (0xE0040202UL, EXCEPTION_NONCONTINUABLE, 1, (const ULONG_PTR*)&buffer);
	} else {
		GDS_ASSERT (false);
	}
#endif
	return false;
}

const CORBA::ULong ConstViolation::CONST_VIOLATION_CODE = CORBA::OMGVMCID | 0x7D8;

ConstViolation::ConstViolation(): CORBA::SystemException (CONST_VIOLATION_CODE, CORBA::COMPLETED_NO) {
}

void ConstViolation::_raise (void) const {
	throw *this;
}

ConstViolation* ConstViolation::_narrow(CORBA::SystemException* exception) {
	return (exception->minor () == CONST_VIOLATION_CODE) ? static_cast <ConstViolation*> (exception) : 0;
}
//#UC END# *4600026B033C*

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

