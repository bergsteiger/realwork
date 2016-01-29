////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::UserJournal_i
// Заголовк реализации фабрик интерфеса UserJournal для серванта UserJournal_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_USERJOURNAL_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_USERJOURNAL_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournalFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for UserJournal_i
class UserJournal_i_factory: virtual public ::Core::RefCountObjectBase, virtual public UserJournalAbstractFactory {
public:
	UserJournal_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	UserJournal* make ();

};

typedef ::Core::Var<UserJournal_i_factory> UserJournal_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_USERJOURNAL_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

