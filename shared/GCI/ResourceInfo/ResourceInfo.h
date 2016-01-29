////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/ResourceInfo/ResourceInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::ResourceInfo
//
// набор интерфейсов для предоставления информации о системе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFO_H__
#define __SHARED_GCI_RESOURCEINFO_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace ResourceInfo {

// не смогли получить системную информацию о ресурсах
class ResourceSystemError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// метод на данной ОС ещё не реализован
class NotSupported : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class CPUInfo;
typedef ::Core::Var<CPUInfo> CPUInfo_var;
typedef ::Core::Var<const CPUInfo> CPUInfo_cvar;
// информация о загрузке процессора
class CPUInfo
	: virtual public ::Core::IObject
{
public:
	// частота процессора в MHz.
	virtual unsigned long get_frequency () const
		/*throw (ResourceSystemError)*/ = 0;

	// идентификатор процессора
	virtual const std::string get_identifier () const
		/*throw (ResourceSystemError)*/ = 0;

	// имя процессора
	virtual const std::string get_name () const
		/*throw (ResourceSystemError)*/ = 0;
};

/// factory interface for CPUInfo
class CPUInfoFactory {
public:
	// получить объект
	static CPUInfo& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/;
};

#pragma pack (push, 1)

// информация о памяти в системе
struct SystemMemoryData {
	// доступный размер физической памяти на машине (в байтах)
	ACE_UINT64 available_memory_size;
	// размер доступного адрессного пространства для процесса на машине (в байтах)
	ACE_UINT64 available_virtual_memory_size;
	// общий размер физической памяти на машине (в байтах)
	ACE_UINT64 full_memory_size;
	// размер адрессного пространства для процесса на машине (в байтах)
	ACE_UINT64 virtual_memory_size;
	// Общий объем виртуальной памяти на компьютере (в байтах)
	ACE_UINT64 total_page_file_size;
	// Доступный объем виртуальной памяти на компьютере (в байтах)
	ACE_UINT64 available_page_file_size;
};

#pragma pack (pop)

#pragma pack (push, 1)

// информация о занимаемой памяти
struct ProcessMemoryData {
	// текущее количество используемой памяти (в байтах)
	ACE_UINT64 current_usage;
	// Максимальное количество используемой памяти (в байтах)
	ACE_UINT64 max_usage;
	// Счетчик отказов страниц
	unsigned long page_fault_count;
	// Размер адресного пространства, отведённого процессу (в байтах)
	ACE_UINT64 vm_usage;
};

#pragma pack (pop)

class ProcessMemoryInfo;
typedef ::Core::Var<ProcessMemoryInfo> ProcessMemoryInfo_var;
typedef ::Core::Var<const ProcessMemoryInfo> ProcessMemoryInfo_cvar;
// данные о памяти, используемой процессом
class ProcessMemoryInfo
	: virtual public ::Core::IObject
{
public:
	// текущее количество используемой памяти (в байтах)
	virtual ACE_UINT64 get_current_usage () const
		/*throw (ResourceSystemError)*/ = 0;

	// Максимальное количество используемой памяти (в байтах)
	virtual ACE_UINT64 get_max_usage () const
		/*throw (ResourceSystemError)*/ = 0;

	// Размер адресного пространства, отведённого процессу (в байтах)
	virtual ACE_UINT64 get_vm_usage () const
		/*throw (ResourceSystemError)*/ = 0;

	// Счетчик отказов страниц
	virtual unsigned long get_page_fault_count () const
		/*throw (ResourceSystemError)*/ = 0;

	// информация о памяти занимаемой процессом
	virtual const ProcessMemoryData get_memory_info () const = 0;
};

/// factory interface for ProcessMemoryInfo
class ProcessMemoryInfoFactory {
public:
	// получить объект
	static ProcessMemoryInfo& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/;
};

class PhysicalMemoryInfo;
typedef ::Core::Var<PhysicalMemoryInfo> PhysicalMemoryInfo_var;
typedef ::Core::Var<const PhysicalMemoryInfo> PhysicalMemoryInfo_cvar;
// Информация о физической памяти на машине
class PhysicalMemoryInfo
	: virtual public ::Core::IObject
{
public:
	// общий размер физической памяти на машине (в байтах)
	virtual ACE_UINT64 get_full_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// доступный размер физической памяти на машине (в байтах)
	virtual ACE_UINT64 get_available_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// размер адрессного пространства для процесса на машине (в байтах)
	virtual ACE_UINT64 get_virtual_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// размер доступного адрессного пространства для процесса на машине (в байтах)
	virtual ACE_UINT64 get_available_virtual_memory_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// информация о памяти в системе
	virtual const SystemMemoryData get_memory_info () const = 0;

	// Общий объем виртуальной памяти на компьютере (в байтах)
	virtual const ACE_UINT64 get_total_page_file_size () const
		/*throw (ResourceSystemError)*/ = 0;

	// Доступный объем виртуальной памяти на компьютере (в байтах)
	virtual const ACE_UINT64 get_available_page_file_size () const
		/*throw (ResourceSystemError)*/ = 0;
};

/// factory interface for PhysicalMemoryInfo
class PhysicalMemoryInfoFactory {
public:
	// получить объект
	static PhysicalMemoryInfo& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NotSupported)*/;
};

} // namespace ResourceInfo
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::ResourceInfo::CPUInfo> {
	typedef GCI::ResourceInfo::CPUInfoFactory Factory;
};
template <>
struct TypeTraits <GCI::ResourceInfo::ProcessMemoryInfo> {
	typedef GCI::ResourceInfo::ProcessMemoryInfoFactory Factory;
};
template <>
struct TypeTraits <GCI::ResourceInfo::PhysicalMemoryInfo> {
	typedef GCI::ResourceInfo::PhysicalMemoryInfoFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_RESOURCEINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
