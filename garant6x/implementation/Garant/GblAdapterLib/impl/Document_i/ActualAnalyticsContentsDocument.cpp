////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ActualAnalyticsContentsDocument
//
// ААК-содержание
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ActualAnalyticsContentsDocument::ActualAnalyticsContentsDocument (const GCD::PID& pid, const char* name)
//#UC START# *4FE861EF0276_BASE_INIT*
: DocumentMaster (pid, name)
, Document_i (name)
//#UC END# *4FE861EF0276_BASE_INIT*
{
	//#UC START# *4FE861EF0276_BODY*
	//#UC END# *4FE861EF0276_BODY*
}

ActualAnalyticsContentsDocument::ActualAnalyticsContentsDocument (GblPilot::Document* document)
//#UC START# *4FE861E20199_BASE_INIT*
: DocumentMaster (document)
, Document_i (document)
//#UC END# *4FE861E20199_BASE_INIT*
{
	//#UC START# *4FE861E20199_BODY*
	//#UC END# *4FE861E20199_BODY*
}

ActualAnalyticsContentsDocument::~ActualAnalyticsContentsDocument () {
	//#UC START# *4FE8619103CE_DESTR_BODY*
	//#UC END# *4FE8619103CE_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType ActualAnalyticsContentsDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_4FE8619103CE_GET*
	return DT_ACTUAL_ANALYTICS_CONTENTS;
	//#UC END# *460B80CF0201_4FE8619103CE_GET*
}

// overloaded method from Document_i
DocumentTextProvider* ActualAnalyticsContentsDocument::make_text_provider (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) const {
	//#UC START# *504DDBB6016A_4FE8619103CE*
	return DTPWithCachedDataServantFactory::make (server_doc, handle, all_at_once);
	//#UC END# *504DDBB6016A_4FE8619103CE*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

