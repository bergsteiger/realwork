////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/TatarHelper_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::TatarHelper
// Заголовк реализации фабрик интерфеса ConverterHelper для серванта TatarHelper
//
// Дополнительные преобразования для татарского языка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_I_TATARHELPER_FCTR_H__
#define __SHARED_GCI_UNICODEHELPER_I_TATARHELPER_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"

namespace GCI {
namespace UnicodeHelper_i {

/// Interface-factory implementation for TatarHelper
class TatarHelper_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public UnicodeHelper::ConverterHelperAbstractFactory
{
public:
	TatarHelper_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const I18N::SupportedLocales key () const;

	UnicodeHelper::ConverterHelper* make ();

};

typedef ::Core::Var<TatarHelper_factory> TatarHelper_factory_var;

} // namespace UnicodeHelper_i
} // namespace GCI


#endif //__SHARED_GCI_UNICODEHELPER_I_TATARHELPER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

