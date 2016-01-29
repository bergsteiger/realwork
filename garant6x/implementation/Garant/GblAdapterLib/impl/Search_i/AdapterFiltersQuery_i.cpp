////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AdapterFiltersQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AdapterFiltersQuery_i::AdapterFiltersQuery_i (QueryType type)
//#UC START# *4CAD90040266_4CAD902603A1_4CAD908002AB_BASE_INIT*
: FiltersQueryHelper (type), QueryHelper (type)
//#UC END# *4CAD90040266_4CAD902603A1_4CAD908002AB_BASE_INIT*
{
	//#UC START# *4CAD90040266_4CAD902603A1_4CAD908002AB_BODY*
	m_name = GCI::IO::StringFactory::make ("New Filter");
	//#UC END# *4CAD90040266_4CAD902603A1_4CAD908002AB_BODY*
}

AdapterFiltersQuery_i::~AdapterFiltersQuery_i () {
	//#UC START# *4CAD908002AB_DESTR_BODY*
	//#UC END# *4CAD908002AB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void AdapterFiltersQuery_i::check_saved_query () {
	//#UC START# *4CAD9735001C*
	//#UC END# *4CAD9735001C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool AdapterFiltersQuery_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_4CAD908002AB_GET*
	return false;
	//#UC END# *456EB3E1017C_4CAD908002AB_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* AdapterFiltersQuery_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_4CAD908002AB*
	GDS_ASSERT (false && "can't save new query to base. Use FiltersManager::add_query");
	return 0;
	//#UC END# *456EB3E10178_4CAD908002AB*
}

// implemented method from Query
Query* AdapterFiltersQuery_i::clone () {
	//#UC START# *45EEE1450288_4CAD908002AB*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEE1450288_4CAD908002AB*
}

// implemented method from Query
const GCI::IO::String* AdapterFiltersQuery_i::get_name () const {
	//#UC START# *4762B6E401CD_4CAD908002AB*
	return m_name._sretn ();
	//#UC END# *4762B6E401CD_4CAD908002AB*
}

// implemented method from Query
void AdapterFiltersQuery_i::set_name (GCI::IO::String* name) {
	//#UC START# *4762B6A10258_4CAD908002AB*
	m_name = GCI::IO::String::_duplicate (name);
	//#UC END# *4762B6A10258_4CAD908002AB*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

