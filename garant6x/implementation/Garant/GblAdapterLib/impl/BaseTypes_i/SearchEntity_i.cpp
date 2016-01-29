////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::SearchEntity_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i.h"

//#UC START# *456EE2440148_CUSTOM_INCLUDES*
//#UC END# *456EE2440148_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *456EE2440148*
//#UC END# *456EE2440148*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearchEntity_i::SearchEntity_i (
	SearchResultType result_type
	, size_t document_count
	, size_t entry_count
	, size_t edition_count
)
//#UC START# *4602A20D0177_BASE_INIT*
: m_result_type (result_type)
, m_document_count (document_count)
, m_entry_count (entry_count)
, m_edition_count (edition_count)
//#UC END# *4602A20D0177_BASE_INIT*
{
	//#UC START# *4602A20D0177_BODY*
	//#UC END# *4602A20D0177_BODY*
}

SearchEntity_i::~SearchEntity_i () {
	//#UC START# *456EE2440148_DESTR_BODY*
	//#UC END# *456EE2440148_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from SearchEntity
// Количество найденных документов
size_t SearchEntity_i::get_document_count () const {
	//#UC START# *456ECA9603AB_456EE2440148_GET*
	return m_document_count;
	//#UC END# *456ECA9603AB_456EE2440148_GET*
}

// implemented method from SearchEntity
// количество редакций
size_t SearchEntity_i::get_edition_count () const {
	//#UC START# *46286B3A029F_456EE2440148_GET*
	return m_edition_count;
	//#UC END# *46286B3A029F_456EE2440148_GET*
}

// implemented method from SearchEntity
// Количество вхождений
size_t SearchEntity_i::get_entry_count () const {
	//#UC START# *4602A0A801F4_456EE2440148_GET*
	return m_entry_count;
	//#UC END# *4602A0A801F4_456EE2440148_GET*
}

// implemented method from SearchEntity
// Тип результата поиска (список, автореферат, консультация)
SearchResultType SearchEntity_i::get_result_type () const {
	//#UC START# *456ECA9603AA_456EE2440148_GET*
	return m_result_type;
	//#UC END# *456ECA9603AA_456EE2440148_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

