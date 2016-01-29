////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/UnicodeHelper/UnicodeHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::UnicodeHelper
//
// вспомогательные интерфейсы для работы с Unicode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_H__
#define __SHARED_GCI_UNICODEHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCI/I18N/I18N.h"

namespace GCI {
namespace UnicodeHelper {

class ConverterHelper;
typedef ::Core::Var<ConverterHelper> ConverterHelper_var;
typedef ::Core::Var<const ConverterHelper> ConverterHelper_cvar;
// Методы необходимые для конвертации, зависящей от локали
// см. http://mdp.garant.ru/x/GwDVBQ
class ConverterHelper
	: virtual public ::Core::IObject
{
public:
	// дополнительные (специфический для локали) преобразования
	virtual void add_specific (wchar_t* buffer) const = 0;

	// удаляет из Unicode-строки дополнителное, специфическое для локали преобразование
	virtual const std::wstring remove_specific (const std::wstring& in) const = 0;
};

/// factory interface for ConverterHelper
class ConverterHelperFactory {
public:
	typedef std::vector<I18N::SupportedLocales> KeySet;
	
	static KeySet* keys ();
public:
	// фабрика полагается на установленную в системе локаль
	static ConverterHelper* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace UnicodeHelper
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::UnicodeHelper::ConverterHelper> {
	typedef GCI::UnicodeHelper::ConverterHelperFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_UNICODEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
