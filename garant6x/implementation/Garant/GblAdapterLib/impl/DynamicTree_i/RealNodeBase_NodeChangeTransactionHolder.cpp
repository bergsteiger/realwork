////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase_NodeChangeTransactionHolder.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeBase::NodeChangeTransactionHolder
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

RealNodeBase::NodeChangeTransactionHolder::NodeChangeTransactionHolder (RealNodeBase* node)
//#UC START# *45FF99D90203_BASE_INIT*
//#UC END# *45FF99D90203_BASE_INIT*
{
	//#UC START# *45FF99D90203_BODY*
	m_transaction = node->get_current_transaction();
	m_transaction->open();
	//#UC END# *45FF99D90203_BODY*
}

RealNodeBase::NodeChangeTransactionHolder::~NodeChangeTransactionHolder () {
	//#UC START# *45FF99BC0399_DESTR_BODY*
	m_transaction->close();
	//#UC END# *45FF99BC0399_DESTR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

