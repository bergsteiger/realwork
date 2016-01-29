////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FlashDocument
//
// Документ-флеш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FlashDocument::FlashDocument (GblPilot::Document* document)
//#UC START# *4857C25202B6_BASE_INIT*
	: DocumentMaster (document)
	, Document_i (document)
//#UC END# *4857C25202B6_BASE_INIT*
{
	//#UC START# *4857C25202B6_BODY*
	//#UC END# *4857C25202B6_BODY*
}

FlashDocument::FlashDocument (const GCD::PID& pid, const char* name)
//#UC START# *49B9356E0016_BASE_INIT*
: DocumentMaster (pid, name)
, Document_i (name)
//#UC END# *49B9356E0016_BASE_INIT*
{
	//#UC START# *49B9356E0016_BODY*
	//#UC END# *49B9356E0016_BODY*
}

FlashDocument::~FlashDocument () {
	//#UC START# *4857C21E0230_DESTR_BODY*
	//#UC END# *4857C21E0230_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
DocumentType FlashDocument::get_doc_type () const {
	//#UC START# *460B80CF0201_4857C21E0230_GET*
	return DT_FLASH;
	//#UC END# *460B80CF0201_4857C21E0230_GET*
}

// overloaded method from Document
// Получение флеш-ролика
ExternalObject* FlashDocument::get_flash () const {
	//#UC START# *4857C59403C6_4857C21E0230*
	GblPilot::FlashDocument_var flash_document = GblPilot::FlashDocument::_narrow (this->get_server_doc ());
	GDS_ASSERT (!CORBA::is_nil (flash_document.in ()));
	GblPilot::InternalObj_var internal_obj = flash_document->get_flash ();

	if (!CORBA::is_nil (internal_obj.in ())) {
		try {
			ExternalObject_var external_object = ExternalObjectFactory::make (internal_obj.in ());
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_obj.in ());
			return external_object._retn ();
		} catch (CORBA::BAD_OPERATION&) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_obj.in ());
			throw CanNotFindData ();
		} catch (GCD::CanNotFindData&) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_obj.in ());
			throw CanNotFindData ();
		}
	}
	throw CanNotFindData ();
	//#UC END# *4857C59403C6_4857C21E0230*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

