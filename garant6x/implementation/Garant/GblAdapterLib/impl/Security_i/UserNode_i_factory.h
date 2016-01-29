////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNode_i
// Заголовк реализации фабрик интерфеса ProfileNode для серванта UserNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.h"

/// Servant-factory implementation for UserNode_i
namespace GblAdapterLib {
	class UsersTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class UserNode_iServantFactory {
	friend class UsersTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static UserNode_i* make ();

	static UserNode_i* make (TreeBase* owner_tree, const GTree::Node& snode);

	static UserNode_i* servant_make ();
};

/// Interface-factory implementation for UserNode_i
class UserNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ProfileNodeAbstractFactory {
	friend class UserNode_iServantFactory;

public:
	UserNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static UserNode_i_factory* s_instance;

	const char* key () const;

	ProfileNode* make ();

};

typedef ::Core::Var<UserNode_i_factory> UserNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::UserNode_i> {
	typedef GblAdapterLib::UserNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

