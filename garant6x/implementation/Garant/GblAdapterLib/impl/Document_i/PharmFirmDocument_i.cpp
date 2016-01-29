////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmFirmDocument_i
//
// Фирма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PharmFirmDocument_i::PharmFirmDocument_i (const GCD::PID& pid, const char* name)
//#UC START# *47F09944011E_BASE_INIT*
	: Document_i(name)
	, DocumentMaster (pid, name)
	, SimpleDocument (0)
//#UC END# *47F09944011E_BASE_INIT*
{
	//#UC START# *47F09944011E_BODY*
	//#UC END# *47F09944011E_BODY*
}

PharmFirmDocument_i::PharmFirmDocument_i (GblPilot::Document* document)
//#UC START# *47EBB7AE0288_BASE_INIT*
	: Document_i(document)
	, DocumentMaster (document)
	, SimpleDocument (document)
//#UC END# *47EBB7AE0288_BASE_INIT*
{
	//#UC START# *47EBB7AE0288_BODY*
	//#UC END# *47EBB7AE0288_BODY*
}

PharmFirmDocument_i::~PharmFirmDocument_i () {
	//#UC START# *47EBB73000F1_DESTR_BODY*
	//#UC END# *47EBB73000F1_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Document
const NodeBase* PharmFirmDocument_i::get_attributes_root () const {
	//#UC START# *45EEC00F006F_47EBB73000F1_GET*
	return DocumentMaster::get_attributes_root ();
	//#UC END# *45EEC00F006F_47EBB73000F1_GET*
}

NodeBase* PharmFirmDocument_i::get_attributes_root () {
	return const_cast<NodeBase*>(((const PharmFirmDocument_i*)this)->get_attributes_root ());
}

// overloaded method from Document
DocumentType PharmFirmDocument_i::get_doc_type () const {
	//#UC START# *460B80CF0201_47EBB73000F1_GET*
	return DT_MEDICAL_FIRM;
	//#UC END# *460B80CF0201_47EBB73000F1_GET*
}

// overloaded method from Document
// Получить список выпускаемых фирмой препаратов
CatalogBase* PharmFirmDocument_i::get_drug_list () const /*throw (CanNotFindData)*/ {
	//#UC START# *47EBB17D009B_47EBB73000F1*
	try {
		GblPilot::PharmFirmDocument_var server_document = GblPilot::PharmFirmDocument::_narrow (this->get_server_doc ());
		GblDocList::DocListTree_var drug_list (server_document->get_drug_list ());
		return DynListFactory::make (drug_list.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *47EBB17D009B_47EBB73000F1*
}

// overloaded method from Document
// Проверка возможности отображения атрибутов документа для текущего документа.
// Возвращает true в случае, если показ атрибутов разрешен.
// 
// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции )
bool PharmFirmDocument_i::may_show_attributes () const {
	//#UC START# *45EEB65201D6_47EBB73000F1*
	return DocumentMaster::may_show_attributes ();
	//#UC END# *45EEB65201D6_47EBB73000F1*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

