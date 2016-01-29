////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DictDocument
//
// Документ - толкование толкового словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DictDocument::DictDocument (GblPilot::Document* document)
//#UC START# *47EBBB0702A4_BASE_INIT*
: DocumentMaster (document)
, Document_i (document)
//#UC END# *47EBBB0702A4_BASE_INIT*
{
	//#UC START# *47EBBB0702A4_BODY*
	//#UC END# *47EBBB0702A4_BODY*
}

DictDocument::DictDocument (const GCD::PID& pid, const char* name)
//#UC START# *49B935A900F3_BASE_INIT*
: DocumentMaster (pid, name)
, Document_i (name)
//#UC END# *49B935A900F3_BASE_INIT*
{
	//#UC START# *49B935A900F3_BODY*
	//#UC END# *49B935A900F3_BODY*
}

DictDocument::~DictDocument () {
	//#UC START# *47EBBAD202AB_DESTR_BODY*
	//#UC END# *47EBBAD202AB_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType DictDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_47EBBAD202AB_GET*
	return DT_EXPLANATORY;
	//#UC END# *460B80CF0201_47EBBAD202AB_GET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

