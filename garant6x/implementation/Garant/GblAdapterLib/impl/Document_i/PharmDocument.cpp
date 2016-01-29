////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDocument
//
// Перапарат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PharmDocument::PharmDocument (GblPilot::Document* document)
//#UC START# *47EBBD3703AB_BASE_INIT*
	: DocumentMaster (document)
	, Document_i (document)
	, m_has_same (boost::indeterminate)														 
//#UC END# *47EBBD3703AB_BASE_INIT*
{
	//#UC START# *47EBBD3703AB_BODY*
	//#UC END# *47EBBD3703AB_BODY*
}

PharmDocument::PharmDocument (const GCD::PID& pid, const char* name)
//#UC START# *49B935DF0222_BASE_INIT*
	: DocumentMaster (pid, name)
	, Document_i (name)
	, m_has_same (boost::indeterminate)														 
//#UC END# *49B935DF0222_BASE_INIT*
{
	//#UC START# *49B935DF0222_BODY*
	//#UC END# *49B935DF0222_BODY*
}

PharmDocument::~PharmDocument () {
	//#UC START# *47EBBD0E00A2_DESTR_BODY*
	//#UC END# *47EBBD0E00A2_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from BaseUpdateChecker_i
void PharmDocument::clear_cache () {
	//#UC START# *45702DA9037A_47EBBD0E00A2*
	m_has_same = boost::indeterminate;
	//#UC END# *45702DA9037A_47EBBD0E00A2*
}

// overloaded method from Document
DocumentType PharmDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_47EBBD0E00A2_GET*
	return DT_MEDICAL_DOCUMENT;
	//#UC END# *460B80CF0201_47EBBD0E00A2_GET*
}

// overloaded method from Document
// Получить список похожих документов
void PharmDocument::get_same_documents (CatalogBase*& out_list) const {
	//#UC START# *45EEB65201E1_47EBBD0E00A2*
	try {
		GblPilot::PharmDocument_var server_document = GblPilot::PharmDocument::_narrow (this->get_server_doc ());
		GblDocList::DocListTree_var list (server_document->get_same_documents ());
		out_list = DynListFactory::make (list.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB65201E1_47EBBD0E00A2*
}

// overloaded method from Document
// Проверка наличия похожих документов
bool PharmDocument::has_same_documents () const {
	//#UC START# *45EEB65201E0_47EBBD0E00A2*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_has_same)) {
		try {
			GblPilot::PharmDocument_var server_document = GblPilot::PharmDocument::_narrow (this->get_server_doc ());
			m_has_same = server_document->has_same_documents ();
		} catch (...) {
			m_has_same = false;
		}
	}
	return m_has_same;
	//#UC END# *45EEB65201E0_47EBBD0E00A2*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

