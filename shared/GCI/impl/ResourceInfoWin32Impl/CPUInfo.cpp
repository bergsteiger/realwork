////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/ResourceInfoWin32Impl/CPUInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::ResourceInfoWin32Impl::CPUInfo
//
// считывает информацию о процессоре из реестра ОС
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/CPUInfo.h"

#if defined(WIN32)
namespace GCI {
namespace ResourceInfoWin32Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// константы в реестре для получения информации о процессоре.
const char* CPUInfo::CPU_REG_SUBKEY = "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0"; // ветка ресстра, в которой находится информация о процессе
const char* CPUInfo::CPU_IDENTIFIER = "Identifier"; // ключ в реестре, по которому указан идентификатор процессора
const char* CPUInfo::CPU_NAME = "ProcessorNameString"; // ключ в реестре, по которому указано имя процессора.
const char* CPUInfo::CPU_FREQUENCY = "~MHz"; // ключ в реестре, по которому указана частота процессора

CPUInfo::HKEY_aptr::~HKEY_aptr () {
	//#UC START# *4999222802A0_DCTOR*
	if (h_key != NULL) {
		::RegCloseKey (h_key);
	}
	//#UC END# *4999222802A0_DCTOR*
}

CPUInfo::HKEY_aptr::HKEY_aptr (HKEY key)
//#UC START# *499922D20080_INIT_CTOR_BASE_INIT*
: h_key (key)
//#UC END# *499922D20080_INIT_CTOR_BASE_INIT*
{
	//#UC START# *499922D20080_CTOR_BODY*
	//#UC END# *499922D20080_CTOR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CPUInfo::CPUInfo ()
//#UC START# *49990ACD0310_49990CD60399_49990F8E0394_BASE_INIT*
//#UC END# *49990ACD0310_49990CD60399_49990F8E0394_BASE_INIT*
{
	//#UC START# *49990ACD0310_49990CD60399_49990F8E0394_BODY*
	//#UC END# *49990ACD0310_49990CD60399_49990F8E0394_BODY*
}

CPUInfo::~CPUInfo () {
	//#UC START# *49990F8E0394_DESTR_BODY*
	//#UC END# *49990F8E0394_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// открывает ветку в реестре, в случае успеха возвращает дескриптор ветки, в случае неудачи бросае
// исключение.
HKEY CPUInfo::open_cpu_reg_key () const /*throw (ResourceInfo::ResourceSystemError)*/ {
	//#UC START# *4999209200C2*
	HKEY h_key;
	LONG ret = ::RegOpenKeyEx (HKEY_LOCAL_MACHINE, CPU_REG_SUBKEY, 0, KEY_READ, &h_key);
	if (ret != ERROR_SUCCESS) {
		throw GCI::ResourceInfo::ResourceSystemError ();
	}

	return h_key;
	//#UC END# *4999209200C2*
}

// читает сточку в реестре по ключу
const std::string CPUInfo::read_string_from_reg (
	HKEY h_key
	, const char* key
) const /*throw (
	ResourceInfo::ResourceSystemError
)*/ {
	//#UC START# *4999251201B5*
	if (h_key != NULL) {
		DWORD type;
		DWORD size = 0;		
		if (
			(::RegQueryValueEx (h_key,	key, 0, &type, 0, &size) != ERROR_SUCCESS)
			|| (size == 0)
		) {
			throw GCI::ResourceInfo::ResourceSystemError ();
		}

		Core::Aptr<TCHAR, Core::ArrayDeleteDestructor<TCHAR> > identifier = new TCHAR [size];

		if (::RegQueryValueEx (h_key, key, 0, &type, (LPBYTE)identifier.ptr (), &size) != ERROR_SUCCESS) {
			throw GCI::ResourceInfo::ResourceSystemError ();
		}
		return std::string (identifier.ptr ());
	}

	return std::string ();
	//#UC END# *4999251201B5*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ResourceInfo::CPUInfo
// частота процессора в MHz.
unsigned long CPUInfo::get_frequency () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49990B00015E_49990F8E0394_GET*
	unsigned long frequency = 0;
	HKEY_aptr h_key = open_cpu_reg_key ();
	if (h_key.h_key != NULL) {
		DWORD type;
		DWORD size = sizeof (frequency);

		if (RegQueryValueEx (h_key.h_key, CPU_FREQUENCY, 0, &type, (LPBYTE)&frequency, &size) != ERROR_SUCCESS) {
			throw GCI::ResourceInfo::ResourceSystemError ();
		}
	}

	return frequency;
	//#UC END# *49990B00015E_49990F8E0394_GET*
}

// implemented method from ResourceInfo::CPUInfo
// идентификатор процессора
const std::string CPUInfo::get_identifier () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49990B8E01D8_49990F8E0394_GET*
	HKEY_aptr h_key = open_cpu_reg_key ();
	return read_string_from_reg (h_key.h_key, CPU_IDENTIFIER);
	//#UC END# *49990B8E01D8_49990F8E0394_GET*
}

// implemented method from ResourceInfo::CPUInfo
// имя процессора
const std::string CPUInfo::get_name () const
	/*throw (ResourceInfo::ResourceSystemError)*/
{
	//#UC START# *49990BB60060_49990F8E0394_GET*
	HKEY_aptr h_key = open_cpu_reg_key ();
	return read_string_from_reg (h_key.h_key, CPU_NAME);
	//#UC END# *49990BB60060_49990F8E0394_GET*
}
} // namespace ResourceInfoWin32Impl
} // namespace GCI

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

