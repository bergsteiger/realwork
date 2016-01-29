////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoImpl::ProcessMemoryInfoImpl
//
// получает информацию о занимаемой процессом памяти используя функции библиотеки psapi
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl.h"

#if !defined(WIN32)
namespace GCI {
namespace ResourceInfoImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ProcessMemoryInfoImpl::ProcessMemoryInfoImpl ()
//#UC START# *46DBF5D002FD_49990E8E0265_4999175E02D3_BASE_INIT*
//#UC END# *46DBF5D002FD_49990E8E0265_4999175E02D3_BASE_INIT*
{
	//#UC START# *46DBF5D002FD_49990E8E0265_4999175E02D3_BODY*
	throw GCI::ResourceInfo::NotSupported ();
	//#UC END# *46DBF5D002FD_49990E8E0265_4999175E02D3_BODY*
}

ProcessMemoryInfoImpl::~ProcessMemoryInfoImpl () {
	//#UC START# *4999175E02D3_DESTR_BODY*
	//#UC END# *4999175E02D3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ResourceInfo::ProcessMemoryInfo
// текущее количество используемой памяти (в байтах)
ACE_UINT64 ProcessMemoryInfoImpl::get_current_usage () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DBF5F302EE_4999175E02D3_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DBF5F302EE_4999175E02D3_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// Максимальное количество используемой памяти (в байтах)
ACE_UINT64 ProcessMemoryInfoImpl::get_max_usage () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DBF63501D4_4999175E02D3_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DBF63501D4_4999175E02D3_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// информация о памяти занимаемой процессом
const ResourceInfo::ProcessMemoryData ProcessMemoryInfoImpl::get_memory_info () const {
	//#UC START# *499955A7031A_4999175E02D3_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *499955A7031A_4999175E02D3_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// Счетчик отказов страниц
unsigned long ProcessMemoryInfoImpl::get_page_fault_count () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49253ADF0279_4999175E02D3_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49253ADF0279_4999175E02D3_GET*
}

// implemented method from ResourceInfo::ProcessMemoryInfo
// Размер адресного пространства, отведённого процессу (в байтах)
ACE_UINT64 ProcessMemoryInfoImpl::get_vm_usage () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *46DBF6DA004E_4999175E02D3_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *46DBF6DA004E_4999175E02D3_GET*
}
} // namespace ResourceInfoImpl
} // namespace GCI

#endif //!WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

