////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/CPUInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::CPUInfo
//
// считывает информацию о процессоре из реестра ОС
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/ResourceInfoImpl/CPUInfo.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CPUInfo::CPUInfo ()
//#UC START# *49990ACD0310_49990CD60399_4999175801C6_BASE_INIT*
//#UC END# *49990ACD0310_49990CD60399_4999175801C6_BASE_INIT*
{
	//#UC START# *49990ACD0310_49990CD60399_4999175801C6_BODY*
	throw GCI::ResourceInfo::NotSupported ();
	//#UC END# *49990ACD0310_49990CD60399_4999175801C6_BODY*
}

CPUInfo::~CPUInfo () {
	//#UC START# *4999175801C6_DESTR_BODY*
	//#UC END# *4999175801C6_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ResourceInfo::CPUInfo
// частота процессора в MHz.
unsigned long CPUInfo::get_frequency () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49990B00015E_4999175801C6_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49990B00015E_4999175801C6_GET*
}

// implemented method from ResourceInfo::CPUInfo
// идентификатор процессора
const std::string CPUInfo::get_identifier () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49990B8E01D8_4999175801C6_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49990B8E01D8_4999175801C6_GET*
}

// implemented method from ResourceInfo::CPUInfo
// имя процессора
const std::string CPUInfo::get_name () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49990BB60060_4999175801C6_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49990BB60060_4999175801C6_GET*
}
} // namespace ResourceInfoImpl
} // namespace GCI

#endif //!WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

