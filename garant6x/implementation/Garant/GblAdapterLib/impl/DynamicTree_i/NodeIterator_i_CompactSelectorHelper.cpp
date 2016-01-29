////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_CompactSelectorHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeIterator_i::CompactSelectorHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"

namespace GblAdapterLib {
class NodeIterator_i;
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

void NodeIterator_i::CompactSelectorHelper::open_selector (GTree::CompactSelector& selector, IndexInParent index) {
	//#UC START# *45FFA0B40177*
	GDS_ASSERT (!selector.count);
	selector.from.child_index = index;
	//#UC END# *45FFA0B40177*
}

void NodeIterator_i::CompactSelectorHelper::close_selector (GTree::CompactSelector& selector, CompactSelectorList& selector_list) {
	//#UC START# *45FFA1A2036B*
	GDS_ASSERT (selector.count);
	selector_list.push_back (selector);
	selector.count = 0;
	selector.include_subtree = false;
	//#UC END# *45FFA1A2036B*
}

void NodeIterator_i::CompactSelectorHelper::try_close_selector (GTree::CompactSelector& selector, CompactSelectorList& selector_list) {
	//#UC START# *45FFA1CD0128*
	if (selector.count) {
		close_selector (selector, selector_list);
	}	
	//#UC END# *45FFA1CD0128*
}

long NodeIterator_i::CompactSelectorHelper::get_stub_count (GCL::StaticNode* child) {
	//#UC START# *45FFA1E003D8*
	const GCL::StaticNodeStubBase* stub = dynamic_cast<const GCL::StaticNodeStubBase*> (child);
	GDS_ASSERT (stub);
	
	long count = stub->stub_count() > 0 ? stub->stub_count() : 1;           // либо положительная заглушка, 
	                                                                        // либо одинокая "отрицательная" (-1);
	if (stub->stub_count() > 1) {                                           // положительная со stub_count > 1 
		GDS_ASSERT (stub->has_pair());                                        // должна иметь отрицательную пару:
		++count;                                                              // учитываем ее
	}
	
	return count;
	//#UC END# *45FFA1E003D8*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NodeIterator_i::CompactSelectorHelper::~CompactSelectorHelper () {
	//#UC START# *45FFA09300CB_DESTR_BODY*
	//#UC END# *45FFA09300CB_DESTR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

