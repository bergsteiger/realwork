////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNodeDelegate
// Заголовк реализации фабрик интерфеса ContentsNode для серванта ContentsNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODEDELEGATE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODEDELEGATE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"

/// Servant-factory implementation for ContentsNodeDelegate
namespace GblAdapterLib {
	class ContentsTree; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ContentsView; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ContentsNodeDelegateServantFactory {
	friend class ContentsTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	friend class ContentsView;
	template <class NodeDelegateType_> friend class View;


	static ContentsNodeDelegate* make ();

	static ContentsNodeDelegate* make (TreeBase* owner_tree);
};

/// Interface-factory implementation for ContentsNodeDelegate
class ContentsNodeDelegate_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ContentsNodeAbstractFactory
{
	friend class ContentsNodeDelegateServantFactory;

public:
	ContentsNodeDelegate_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ContentsNodeDelegate_factory* s_instance;

	const char* key () const;

	ContentsNode* make ();

};

typedef ::Core::Var<ContentsNodeDelegate_factory> ContentsNodeDelegate_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ContentsNodeDelegate> {
	typedef GblAdapterLib::ContentsNodeDelegateServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODEDELEGATE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

