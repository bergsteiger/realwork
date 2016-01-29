////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/PhysicalMemoryInfoImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::PhysicalMemoryInfoImpl
// Заголовок реализации класса серванта для интерфеса PhysicalMemoryInfo
//
// получает информацию о доступной памяти используя API windows
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOWIN32IMPL_PHYSICALMEMORYINFOIMPL_H__
#define __SHARED_GCI_RESOURCEINFOWIN32IMPL_PHYSICALMEMORYINFOIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

//#UC START# *4999102600DB_CUSTOM_INCLUDES*
//#UC END# *4999102600DB_CUSTOM_INCLUDES*

#if defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

class PhysicalMemoryInfoImpl; // self forward Var
typedef ::Core::Var<PhysicalMemoryInfoImpl> PhysicalMemoryInfoImpl_var;
typedef ::Core::Var<const PhysicalMemoryInfoImpl> PhysicalMemoryInfoImpl_cvar;

class PhysicalMemoryInfoImpl_factory;

// получает информацию о доступной памяти используя API windows
class PhysicalMemoryInfoImpl:
	virtual public ResourceInfo::PhysicalMemoryInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PhysicalMemoryInfoImpl)
	friend class PhysicalMemoryInfoImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PhysicalMemoryInfoImpl ();

	virtual ~PhysicalMemoryInfoImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// доступный размер физической памяти на машине (в байтах)
	virtual ACE_UINT64 get_available_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// Доступный объем виртуальной памяти на компьютере (в байтах)
	virtual const ACE_UINT64 get_available_page_file_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// размер доступного адрессного пространства для процесса на машине (в байтах)
	virtual ACE_UINT64 get_available_virtual_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// общий размер физической памяти на машине (в байтах)
	virtual ACE_UINT64 get_full_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// информация о памяти в системе
	virtual const ResourceInfo::SystemMemoryData get_memory_info () const;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// Общий объем виртуальной памяти на компьютере (в байтах)
	virtual const ACE_UINT64 get_total_page_file_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::PhysicalMemoryInfo
	// размер адрессного пространства для процесса на машине (в байтах)
	virtual ACE_UINT64 get_virtual_memory_size () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

//#UC START# *4999102600DB*
//#UC END# *4999102600DB*
}; // class PhysicalMemoryInfoImpl

} // namespace ResourceInfoWin32Impl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_RESOURCEINFOWIN32IMPL_PHYSICALMEMORYINFOIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
