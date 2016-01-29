////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/EmptyHelper_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::EmptyHelper
// Заголовк реализации фабрик интерфеса ConverterHelper для серванта EmptyHelper
//
// Заглушка, не выполняющая дополнительных преобразований
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_FCTR_H__
#define __SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"

namespace GCI {
namespace UnicodeHelper_i {

/// Interface-factory implementation for EmptyHelper
class EmptyHelper_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public UnicodeHelper::ConverterHelperAbstractFactory
{
public:
	EmptyHelper_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const I18N::SupportedLocales key () const;

	UnicodeHelper::ConverterHelper* make ();

};

typedef ::Core::Var<EmptyHelper_factory> EmptyHelper_factory_var;

} // namespace UnicodeHelper_i
} // namespace GCI


#endif //__SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

