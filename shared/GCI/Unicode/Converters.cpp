////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/Unicode/Converters.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCI::Unicode::Converters
// Файл реализации утилитного набора Converters
//
// методы конвертации строк
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/Unicode/Converters.h"
// by <<uses>> dependencies
#include "shared/GCI/UnicodeHelper/UnicodeHelper.h"

namespace GCI {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// переводит строку в UTF-16, используя текущую локаль
const std::wstring cp_to_utf16 (const std::string& in) {
	//#UC START# *4869FCA503BC*
	const size_t size = in.size () + 1;
	Core::Aptr <wchar_t, Core::ArrayDeleteDestructor<wchar_t> > buffer (new wchar_t [size]);
	std::mbstowcs (buffer.ptr (), in.c_str (), size);
	buffer.ptr () [size - 1] = 0;
																		 
	UnicodeHelper::ConverterHelper_var helper = UnicodeHelper::ConverterHelperFactory::make (); // using current locale
	helper->add_specific (buffer.ptr ());
	return std::wstring (buffer.in ());
	//#UC END# *4869FCA503BC*
}

// переводит строку в однобайтовую кодировку, используя текущую локаль
const std::string utf16_to_cp (const std::wstring& in) {
	//#UC START# *4869FCAA0279*
	UnicodeHelper::ConverterHelper_var helper = UnicodeHelper::ConverterHelperFactory::make (); // using current locale
	std::wstring patched = helper->remove_specific (in);

	const size_t size = patched.size () + 1;
	Core::Aptr <char, Core::ArrayDeleteDestructor<char> > buffer (new char [size]);
	std::wcstombs (buffer.ptr (), patched.c_str (), size);
	buffer.ptr () [size - 1] = 0;
	return std::string (buffer.in ());
	//#UC END# *4869FCAA0279*
}

} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

