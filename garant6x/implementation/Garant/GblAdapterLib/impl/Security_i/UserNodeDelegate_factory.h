////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNodeDelegate
// Заголовк реализации фабрик интерфеса ProfileNode для серванта UserNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODEDELEGATE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODEDELEGATE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"

/// Servant-factory implementation for UserNodeDelegate
namespace GblAdapterLib {
	class UsersTree; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class UserNodeDelegateServantFactory {
	friend class UsersTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	friend class View< UserNodeDelegate >;
	template <class NodeDelegateType_> friend class View;


	static UserNodeDelegate* make ();

	static UserNodeDelegate* make (TreeBase* owner_tree);
};

/// Interface-factory implementation for UserNodeDelegate
class UserNodeDelegate_factory: virtual public ::Core::RefCountObjectBase, virtual public ProfileNodeAbstractFactory {
	friend class UserNodeDelegateServantFactory;

public:
	UserNodeDelegate_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static UserNodeDelegate_factory* s_instance;

	const char* key () const;

	ProfileNode* make ();

};

typedef ::Core::Var<UserNodeDelegate_factory> UserNodeDelegate_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::UserNodeDelegate> {
	typedef GblAdapterLib::UserNodeDelegateServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODEDELEGATE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

