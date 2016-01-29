////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TipDocument
//
// Документ Совета дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TipDocument::TipDocument (const GCD::PID& pid, const char* name)
//#UC START# *47F0994D0312_BASE_INIT*
	: Document_i(name)
	, DocumentMaster (pid, name)
	, SimpleDocument (0)
//#UC END# *47F0994D0312_BASE_INIT*
{
	//#UC START# *47F0994D0312_BODY*
	//#UC END# *47F0994D0312_BODY*
}

TipDocument::TipDocument (GblPilot::Document* document)
//#UC START# *47BC1662029E_BASE_INIT*
	: Document_i(document)
	, DocumentMaster (document)
	, SimpleDocument (document)
//#UC END# *47BC1662029E_BASE_INIT*
{
	//#UC START# *47BC1662029E_BODY*
	//#UC END# *47BC1662029E_BODY*
}

TipDocument::~TipDocument () {
	//#UC START# *47BC15EC02BE_DESTR_BODY*
	//#UC END# *47BC15EC02BE_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType TipDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_47BC15EC02BE_GET*
	return DT_TIP;
	//#UC END# *460B80CF0201_47BC15EC02BE_GET*
}

// overloaded method from Document
// возвращает evd поток документа - совета дня или evd поток заглушки для отсутствующего в базе
// документа или документа запрещенного к просмотру
GCI::IO::Stream* TipDocument::get_evd_stream () const {
	//#UC START# *4CE3E9DF02B0_47BC15EC02BE*
	GCD::SeqOctet_var data;
	try {
		GblPilot::TipDocument_var tip_doc = GblPilot::TipDocument::_narrow (get_server_doc ());
		data = tip_doc->get_evd_stream ();
	} catch (GCD::CanNotFindData&) {
		return 0;
	}

	GDS_ASSERT (data->length ());
	return MemoryStreamFactory::make (data, true /*with_copy*/);
	//#UC END# *4CE3E9DF02B0_47BC15EC02BE*
}

// overloaded method from Document
// для документов типа DT_BOOK возвращает false,
// для остальных true
bool TipDocument::has_attributes () const {
	//#UC START# *45EEB65201C9_47BC15EC02BE*
	return false;
	//#UC END# *45EEB65201C9_47BC15EC02BE*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

