////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/Base/Base.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Base
//
// пакет базовых типов (в будущем это должен быть пакет с интерфейсами дамперов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/Base/Base.h"

namespace Base {


FatalError::FatalError (const std::string& info)
	: m_info (info)
//#UC START# *47D7B583003F_BASE_INIT*
//#UC END# *47D7B583003F_BASE_INIT*
{
	//#UC START# *47D7B583003F_BODY*
	//#UC END# *47D7B583003F_BODY*
}

FatalError::~FatalError () throw () {
}

const char* FatalError::uid () const /*throw ()*/ {
	return "E2C106F2-4D63-4E26-9A01-37A37ACF5595";
}

const char* FatalError::what () const throw () {
	//#UC START# *47D7B583003F_WHAT_IMPL*
	return m_info.c_str ();
	//#UC END# *47D7B583003F_WHAT_IMPL*
}


MultipleUCSections::MultipleUCSections (const std::string& info)
	: m_info (info)
//#UC START# *4BE001E802FD_BASE_INIT*
//#UC END# *4BE001E802FD_BASE_INIT*
{
	//#UC START# *4BE001E802FD_BODY*
	//#UC END# *4BE001E802FD_BODY*
}

MultipleUCSections::~MultipleUCSections () throw () {
}

const char* MultipleUCSections::uid () const /*throw ()*/ {
	return "66E20F8D-9277-412B-947C-89A0586D276E";
}

const char* MultipleUCSections::what () const throw () {
	//#UC START# *4BE001E802FD_WHAT_IMPL*
	return m_info.c_str ();
	//#UC END# *4BE001E802FD_WHAT_IMPL*
}

} // namespace Base

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

