////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i_ListOfDeletedConsultations.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Consulting_i::Consultation_i::ListOfDeletedConsultations
//
// список удалённых консультаций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.h"

namespace GblAdapterLib {
class Consultation_i;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Consultation_i::ListOfDeletedConsultations::~ListOfDeletedConsultations () {
	//#UC START# *4AC0B1C1005A_DESTR_BODY*
	//#UC END# *4AC0B1C1005A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Consultation_i::ListOfDeletedConsultations::add_node (NodeId data) {
	//#UC START# *4AC0B36101CE*
	if (std::find (m_nodes.begin (), m_nodes.end (), data) == m_nodes.end ()) {
		m_nodes.push_back (data);
	}
	//#UC END# *4AC0B36101CE*
}

bool Consultation_i::ListOfDeletedConsultations::is_deleted (NodeId data) const {
	//#UC START# *4AC0B378006B*
	return std::find (m_nodes.begin (), m_nodes.end (), data) != m_nodes.end ();
	//#UC END# *4AC0B378006B*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

