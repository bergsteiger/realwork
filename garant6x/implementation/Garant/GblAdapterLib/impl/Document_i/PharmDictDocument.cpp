////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDictDocument
//
// Документ толкование медицинского толкового словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PharmDictDocument::PharmDictDocument (GblPilot::Document* document)
//#UC START# *47EBBA7702B0_BASE_INIT*
: DocumentMaster (document)
, Document_i (document)
//#UC END# *47EBBA7702B0_BASE_INIT*
{
	//#UC START# *47EBBA7702B0_BODY*
	//#UC END# *47EBBA7702B0_BODY*
}

PharmDictDocument::PharmDictDocument (const GCD::PID& pid, const char* name)
//#UC START# *49B935250078_BASE_INIT*
: DocumentMaster (pid, name)
, Document_i (name)
//#UC END# *49B935250078_BASE_INIT*
{
	//#UC START# *49B935250078_BODY*
	//#UC END# *49B935250078_BODY*
}

PharmDictDocument::~PharmDictDocument () {
	//#UC START# *47EBBA510379_DESTR_BODY*
	//#UC END# *47EBBA510379_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType PharmDictDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_47EBBA510379_GET*
	return DT_MEDICAL_EXPLANATORY;
	//#UC END# *460B80CF0201_47EBBA510379_GET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

