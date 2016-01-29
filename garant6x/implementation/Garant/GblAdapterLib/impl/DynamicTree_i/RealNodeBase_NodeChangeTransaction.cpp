////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase_NodeChangeTransaction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeBase::NodeChangeTransaction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"

namespace GblAdapterLib {
class RealNodeBase;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RealNodeBase::NodeChangeTransaction::NodeChangeTransaction (RealNodeBase* node)
//#UC START# *45FF97C502FD_BASE_INIT*
: m_nested_count (0), m_node (node)
//#UC END# *45FF97C502FD_BASE_INIT*
{
	//#UC START# *45FF97C502FD_BODY*
	m_transaction_data.change_mask = 0;
	m_transaction_data.name.enc = GCD::CP1251;
	//#UC END# *45FF97C502FD_BODY*
}

RealNodeBase::NodeChangeTransaction::~NodeChangeTransaction () {
	//#UC START# *45FF97A70109_DESTR_BODY*
	//#UC END# *45FF97A70109_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void RealNodeBase::NodeChangeTransaction::close () {
	//#UC START# *45FF97EA030D*
	GDS_ASSERT (m_nested_count);
	m_nested_count--;

	if (!m_nested_count) {
		// commit
		m_node->commit_and_remove_transaction ();
	}
	//#UC END# *45FF97EA030D*
}

void RealNodeBase::NodeChangeTransaction::open () {
	//#UC START# *45FF97E20251*
	m_nested_count++;
	//#UC END# *45FF97E20251*
}

void RealNodeBase::NodeChangeTransaction::set_entity (const GTree::NodeEntity& entity) {
	//#UC START# *45FF990800AB*
	m_transaction_data.entity = entity;
	m_transaction_data.change_mask |= GTree::CMC_ENTITY_CHANGED;
	//#UC END# *45FF990800AB*
}

void RealNodeBase::NodeChangeTransaction::set_name (const char* name) {
	//#UC START# *45FF97F2031C*
	m_transaction_data.name.data = CORBA::string_dup (name);
	m_transaction_data.change_mask |= GTree::CMC_NAME_CHANGED;
	//#UC END# *45FF97F2031C*
}

const GTree::NodeValueData& RealNodeBase::NodeChangeTransaction::set_value () {
	//#UC START# *45FF9837030D*
	m_transaction_data.change_mask |= GTree::CMC_VALUE_CHANGED;
	return m_transaction_data.value;			
	//#UC END# *45FF9837030D*
}

const GTree::ChangeNodeData& RealNodeBase::NodeChangeTransaction::transaction_data () const {
	//#UC START# *45FF991B038A*
	return m_transaction_data;
	//#UC END# *45FF991B038A*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

