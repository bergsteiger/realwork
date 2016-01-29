////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/CPUInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::CPUInfo
// Заголовок реализации класса серванта для интерфеса CPUInfo
//
// считывает информацию о процессоре из реестра ОС
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_RESOURCEINFOWIN32IMPL_CPUINFO_H__
#define __SHARED_GCI_RESOURCEINFOWIN32IMPL_CPUINFO_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfo.h"

#if defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

class CPUInfo; // self forward Var
typedef ::Core::Var<CPUInfo> CPUInfo_var;
typedef ::Core::Var<const CPUInfo> CPUInfo_cvar;

class CPUInfo_factory;

// считывает информацию о процессоре из реестра ОС
class CPUInfo:
	virtual public ResourceInfo::CPUInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CPUInfo)
	friend class CPUInfo_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// константы в реестре для получения информации о процессоре.
	static const char* CPU_REG_SUBKEY; // ветка ресстра, в которой находится информация о процессе
	static const char* CPU_IDENTIFIER; // ключ в реестре, по которому указан идентификатор процессора
	static const char* CPU_NAME; // ключ в реестре, по которому указано имя процессора.
	static const char* CPU_FREQUENCY; // ключ в реестре, по которому указана частота процессора

	// auto ptr для HKEY
	struct HKEY_aptr {
		// дескриптор
		HKEY h_key;

		~HKEY_aptr ();

		HKEY_aptr (HKEY key);
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CPUInfo ();

	virtual ~CPUInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// открывает ветку в реестре, в случае успеха возвращает дескриптор ветки, в случае неудачи бросае
	// исключение.
	virtual HKEY open_cpu_reg_key () const /*throw (ResourceInfo::ResourceSystemError)*/;

	// читает сточку в реестре по ключу
	virtual const std::string read_string_from_reg (
		HKEY h_key
		, const char* key
	) const /*throw (
		ResourceInfo::ResourceSystemError
	)*/;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ResourceInfo::CPUInfo
	// частота процессора в MHz.
	virtual unsigned long get_frequency () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::CPUInfo
	// идентификатор процессора
	virtual const std::string get_identifier () const
		/*throw (ResourceInfo::ResourceSystemError)*/;

	// implemented method from ResourceInfo::CPUInfo
	// имя процессора
	virtual const std::string get_name () const
		/*throw (ResourceInfo::ResourceSystemError)*/;
}; // class CPUInfo

} // namespace ResourceInfoWin32Impl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_RESOURCEINFOWIN32IMPL_CPUINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
