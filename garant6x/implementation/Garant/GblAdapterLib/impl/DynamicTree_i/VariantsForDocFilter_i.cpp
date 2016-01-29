////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::VariantsForDocFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

VariantsForDocFilter_i::VariantsForDocFilter_i (unsigned long doc_id)
//#UC START# *4AA0FE420344_4AA0FEB300BC_4AA10071013D_BASE_INIT*
: m_doc_id (doc_id)
//#UC END# *4AA0FE420344_4AA0FEB300BC_4AA10071013D_BASE_INIT*
{
	//#UC START# *4AA0FE420344_4AA0FEB300BC_4AA10071013D_BODY*
	//#UC END# *4AA0FE420344_4AA0FEB300BC_4AA10071013D_BODY*
}

VariantsForDocFilter_i::VariantsForDocFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_4AA10071013D_BASE_INIT*
//#UC END# *45EEBB9B01F4_45F6A01A007D_4AA10071013D_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_4AA10071013D_BODY*
	GDS_ASSERT (false);
	//#UC END# *45EEBB9B01F4_45F6A01A007D_4AA10071013D_BODY*
}

VariantsForDocFilter_i::~VariantsForDocFilter_i () {
	//#UC START# *4AA10071013D_DESTR_BODY*
	//#UC END# *4AA10071013D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from VariantsForDocFilter
// идентификатор документа
const unsigned long VariantsForDocFilter_i::get_doc_id () const {
	//#UC START# *4AA103F302DE_4AA10071013D_GET*
	return m_doc_id;
	//#UC END# *4AA103F302DE_4AA10071013D_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

