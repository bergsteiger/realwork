////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfoNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ComplectInfoNode_i::ComplectInfoNode_i ()
//#UC START# *4756B62902B3_BASE_INIT*
//#UC END# *4756B62902B3_BASE_INIT*
{
	//#UC START# *4756B62902B3_BODY*
	GDS_ASSERT (false);
	//#UC END# *4756B62902B3_BODY*
}

ComplectInfoNode_i::ComplectInfoNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *462892F202CE_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)
	, NodeBase_i (owner_tree, snode)
//#UC END# *462892F202CE_BASE_INIT*
{
	//#UC START# *462892F202CE_BODY*
	if (snode.value.in ()) {
		GblPilotDef::ComplectInfoValue* ci_value = GblPilotDef::ComplectInfoValue::_downcast (snode.value.in ());
		CORBA::String_var temp = ci_value->info ();
		m_info = GCI::IO::StringFactory::make (temp.in ());
	}	
	//#UC END# *462892F202CE_BODY*
}

ComplectInfoNode_i::~ComplectInfoNode_i () {
	//#UC START# *457452CE02CE_DESTR_BODY*
	//#UC END# *457452CE02CE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ComplectInfoNode
const GCI::IO::String* ComplectInfoNode_i::get_info () const {
	//#UC START# *45F54F6B0213_457452CE02CE_GET*
	return m_info._sretn ();
	//#UC END# *45F54F6B0213_457452CE02CE_GET*
}

GCI::IO::String* ComplectInfoNode_i::get_info () {
	return const_cast<GCI::IO::String*>(((const ComplectInfoNode_i*)this)->get_info ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

