////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/Messages_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::Messages_i
// Заголовк реализации фабрик интерфеса Messages для серванта Messages_i
//
// Реализация работы с локализованными строками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_MESSAGES_I_FCTR_H__
#define __SHARED_GCI_I18N_I_MESSAGES_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18NFactories.h"
#include "shared/GCI/impl/I18N_i/I18N_i.h"

namespace GCI {
namespace I18N_i {

/// Interface-factory implementation for Messages_i
class Messages_i_factory: virtual public ::Core::RefCountObjectBase, virtual public I18N::MessagesAbstractFactory {
public:
	Messages_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	I18N::Messages* messages ();

};

typedef ::Core::Var<Messages_i_factory> Messages_i_factory_var;

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_MESSAGES_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

