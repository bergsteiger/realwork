////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsTreeNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.h"

namespace GblAdapterLib {

TipsTreeNode_i_factory* TipsTreeNode_i_factory::s_instance = 0;

TipsTreeNode_i_factory::TipsTreeNode_i_factory () {
}

void TipsTreeNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* TipsTreeNode_i_factory::key () const {
	return "TipsTreeNode_i";
}

NodeBase* TipsTreeNode_i_factory::make () /*throw (CanNotFindData)*/ {
	TipsTreeNode_i_var ret = new TipsTreeNode_i ();
	return ret._retn ();
}

NodeBase* TipsTreeNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	TipsTreeNode_i_var ret = new TipsTreeNode_i (owner_tree, snode);
	return ret._retn ();
}

TipsTreeNode_i* TipsTreeNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (TipsTreeNode_i_factory::s_instance) {
		return dynamic_cast<TipsTreeNode_i*>(TipsTreeNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Tips_i::TipsTreeNode_i_factory");
	}
}

TipsTreeNode_i* TipsTreeNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (TipsTreeNode_i_factory::s_instance) {
		return dynamic_cast<TipsTreeNode_i*>(TipsTreeNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Tips_i::TipsTreeNode_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

