////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ActualAnalyticsDocument
//
// ААК
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ActualAnalyticsDocument::ActualAnalyticsDocument (const GCD::PID& pid, const char* name)
//#UC START# *4FE8626502C3_BASE_INIT*
: DocumentMaster (pid, name)
, Document_i (name)
//#UC END# *4FE8626502C3_BASE_INIT*
{
	//#UC START# *4FE8626502C3_BODY*
	//#UC END# *4FE8626502C3_BODY*
}

ActualAnalyticsDocument::ActualAnalyticsDocument (GblPilot::Document* document)
//#UC START# *4FE8625C01BD_BASE_INIT*
: DocumentMaster (document)
, Document_i (document)
//#UC END# *4FE8625C01BD_BASE_INIT*
{
	//#UC START# *4FE8625C01BD_BODY*
	//#UC END# *4FE8625C01BD_BODY*
}

ActualAnalyticsDocument::~ActualAnalyticsDocument () {
	//#UC START# *4FE8620402D3_DESTR_BODY*
	//#UC END# *4FE8620402D3_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType ActualAnalyticsDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_4FE8620402D3_GET*
	return DT_ACTUAL_ANALYTICS;
	//#UC END# *460B80CF0201_4FE8620402D3_GET*
}

// overloaded method from Document_i
DocumentTextProvider* ActualAnalyticsDocument::make_text_provider (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) const {
	//#UC START# *504DDBB6016A_4FE8620402D3*
	return DTPWithCachedDataServantFactory::make (server_doc, handle, all_at_once);
	//#UC END# *504DDBB6016A_4FE8620402D3*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

