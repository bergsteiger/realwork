////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNode_i
// Заголовк реализации фабрик интерфеса ContentsNode для серванта ContentsNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.h"

/// Servant-factory implementation for ContentsNode_i
namespace GblAdapterLib {
	class ContentsTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ContentsNode_iServantFactory {
	friend class ContentsTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static ContentsNode_i* make ();

	static ContentsNode_i* make (TreeBase* owner_tree, const GTree::Node& snode);

	static ContentsNode_i* make_servant ();
};

/// Interface-factory implementation for ContentsNode_i
class ContentsNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ContentsNodeAbstractFactory {
	friend class ContentsNode_iServantFactory;

public:
	ContentsNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ContentsNode_i_factory* s_instance;

	const char* key () const;

	ContentsNode* make ();

};

typedef ::Core::Var<ContentsNode_i_factory> ContentsNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ContentsNode_i> {
	typedef GblAdapterLib::ContentsNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

