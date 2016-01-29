////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/EmptyHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::EmptyHelper
// Заголовок реализации класса серванта для интерфеса ConverterHelper
//
// Заглушка, не выполняющая дополнительных преобразований
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_H__
#define __SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

class EmptyHelper; // self forward Var
typedef ::Core::Var<EmptyHelper> EmptyHelper_var;
typedef ::Core::Var<const EmptyHelper> EmptyHelper_cvar;

class EmptyHelper_factory;

// Заглушка, не выполняющая дополнительных преобразований
class EmptyHelper:
	virtual public UnicodeHelper::ConverterHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (EmptyHelper)
	friend class EmptyHelper_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	EmptyHelper ();

	virtual ~EmptyHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UnicodeHelper::ConverterHelper
	// дополнительные (специфический для локали) преобразования
	virtual void add_specific (wchar_t* buffer) const;

	// implemented method from UnicodeHelper::ConverterHelper
	// удаляет из Unicode-строки дополнителное, специфическое для локали преобразование
	virtual const std::wstring remove_specific (const std::wstring& in) const;
}; // class EmptyHelper

} // namespace UnicodeHelper_i
} // namespace GCI


#endif //__SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
