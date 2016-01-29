////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalNode
// Заголовк реализации фабрик интерфеса  для серванта JournalNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALNODE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALNODE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.h"

/// Servant-factory implementation for JournalNode
namespace GblAdapterLib {
	class JournalTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class JournalNodeServantFactory {
	friend class JournalTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static JournalNode* make () /*throw (CanNotFindData)*/;

	static JournalNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for JournalNode
class JournalNode_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class JournalNodeServantFactory;

public:
	JournalNode_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static JournalNode_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<JournalNode_factory> JournalNode_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::JournalNode> {
	typedef GblAdapterLib::JournalNodeServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALNODE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

