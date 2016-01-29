////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfoNode_i
// Заголовк реализации фабрик интерфеса ComplectInfoNode для серванта ComplectInfoNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFONODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFONODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/ComplectFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/Complect_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i.h"

/// Servant-factory implementation for ComplectInfoNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ComplectInfo_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ComplectInfoNode_iServantFactory {
	friend class Tree< ComplectInfoNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	friend class ComplectInfo_i;

	static ComplectInfoNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static ComplectInfoNode_i* make ();

	static ComplectInfoNode_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for ComplectInfoNode_i
class ComplectInfoNode_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ComplectInfoNodeAbstractFactory
{
	friend class ComplectInfoNode_iServantFactory;

public:
	ComplectInfoNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ComplectInfoNode_i_factory* s_instance;

	const char* key () const;

	ComplectInfoNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<ComplectInfoNode_i_factory> ComplectInfoNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ComplectInfoNode_i> {
	typedef GblAdapterLib::ComplectInfoNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFONODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

