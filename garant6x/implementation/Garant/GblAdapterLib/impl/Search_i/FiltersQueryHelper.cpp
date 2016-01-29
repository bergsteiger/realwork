////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQueryHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FiltersQueryHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQueryHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FiltersQueryHelper::FiltersQueryHelper (QueryType type) : QueryHelper(type)
//#UC START# *45EEE145027B_45FFA1AA01D0_4CAD934E029B_BASE_INIT*
//#UC END# *45EEE145027B_45FFA1AA01D0_4CAD934E029B_BASE_INIT*
{
	//#UC START# *45EEE145027B_45FFA1AA01D0_4CAD934E029B_BODY*
	//#UC END# *45EEE145027B_45FFA1AA01D0_4CAD934E029B_BODY*
}

FiltersQueryHelper::~FiltersQueryHelper () {
	//#UC START# *4CAD934E029B_DESTR_BODY*
	//#UC END# *4CAD934E029B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* FiltersQueryHelper::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_4CAD934E029B*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *456EB3E1017A_4CAD934E029B*
}

// implemented method from EntityBase
// идентификатор
const unsigned long FiltersQueryHelper::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_4CAD934E029B_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *456EE084033C_4CAD934E029B_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool FiltersQueryHelper::get_is_changed () const {
	//#UC START# *456EB3E1017D_4CAD934E029B_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *456EB3E1017D_4CAD934E029B_GET*
}

// implemented method from Query
const QueryAttributeList& FiltersQueryHelper::get_attributes () const {
	//#UC START# *45EEE262018E_4CAD934E029B_GET*
	const_cast<FiltersQueryHelper*> (this)->check_saved_query ();
	return m_attributes;
	//#UC END# *45EEE262018E_4CAD934E029B_GET*
}

// implemented method from Query
// Количество найденных документов при последнем поиске.
unsigned long FiltersQueryHelper::get_count () const {
	//#UC START# *45EEE145028F_4CAD934E029B_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEE145028F_4CAD934E029B_GET*
}

// implemented method from Query
const Date& FiltersQueryHelper::get_date () const {
	//#UC START# *45EEE19A0122_4CAD934E029B_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEE19A0122_4CAD934E029B_GET*
}

// implemented method from Query
void FiltersQueryHelper::execute (
	DynList* filtrate_list
	, SearchProgressIndicator::ProgressIndicatorForSearch* progress
	, SearchProgressIndicator::CancelSearch*& cancel_process
) {
	//#UC START# *45FF9F9D01F5_4CAD934E029B*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45FF9F9D01F5_4CAD934E029B*
}

// implemented method from Query
GCI::IO::String* FiltersQueryHelper::get_comment () const {
	//#UC START# *4762B73103AB_4CAD934E029B*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4762B73103AB_4CAD934E029B*
}

// implemented method from Query
// получен ли запрос с фильтра
bool FiltersQueryHelper::is_filter_query () const {
	//#UC START# *4CB6EAED0168_4CAD934E029B*
	return true;
	//#UC END# *4CB6EAED0168_4CAD934E029B*
}

// implemented method from Query
// Отправить запрос на консультацию
void FiltersQueryHelper::send_query () {
	//#UC START# *45EEE1450289_4CAD934E029B*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEE1450289_4CAD934E029B*
}

// implemented method from Query
void FiltersQueryHelper::set_comment (GCI::IO::String* comment) {
	//#UC START# *4762B7150252_4CAD934E029B*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4762B7150252_4CAD934E029B*
}

// implemented method from Query
QueryType FiltersQueryHelper::get_type () const {
	//#UC START# *45EEE16E01DE_4CAD934E029B_GET*
	return QueryHelper::get_type ();
	//#UC END# *45EEE16E01DE_4CAD934E029B_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

