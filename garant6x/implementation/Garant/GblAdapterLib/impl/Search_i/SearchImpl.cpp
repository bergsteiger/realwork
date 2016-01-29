////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::SearchImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearchImpl::SearchImpl ()
//#UC START# *45EEE0A401FF_460125C20341_460125FD00EF_BASE_INIT*
	: m_example_text_count (std::numeric_limits <unsigned long>::max ())
	, m_is_morpho_exist (boost::logic::indeterminate)
//#UC END# *45EEE0A401FF_460125C20341_460125FD00EF_BASE_INIT*
{
	//#UC START# *45EEE0A401FF_460125C20341_460125FD00EF_BODY*
	//#UC END# *45EEE0A401FF_460125C20341_460125FD00EF_BODY*
}

SearchImpl::~SearchImpl () {
	//#UC START# *460125FD00EF_DESTR_BODY*
	//#UC END# *460125FD00EF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void SearchImpl::clear_cache () {
	//#UC START# *45702DA9037A_460125FD00EF*
	m_is_morpho_exist = boost::logic::indeterminate;
	m_example_text_count = std::numeric_limits <unsigned long>::max ();
	//#UC END# *45702DA9037A_460125FD00EF*
}

// implemented method from Search
// Возвращает список слов, которые не смогли скорректировать и скорректированную строку
ContextWordList* SearchImpl::correct_context (
	const ContextWordList& context_for_check
	, bool for_inpharm
	, ContextWordList*& corrected_context
) const {
	//#UC START# *48284BC700D9_460125FD00EF*
	GblPilotDef::WordList_var corrected;
	GblPilotDef::WordList strings_for_check;

	size_t context_for_check_size = context_for_check.size ();
	strings_for_check.length (context_for_check_size);
	for (size_t i = 0; i < context_for_check_size; ++i) {
		strings_for_check[i] = context_for_check[i]->get_data ();
	}

	GblPilotDef::WordList_var bad_list (
		ApplicationHelper::instance ()->get_cached_search_manager ()->correct_context (strings_for_check, for_inpharm, corrected.out ())
	);

	Core::Aptr<ContextWordList> context_word_list (new ContextWordList);
	for (size_t i = 0; i < bad_list->length (); ++i) {
		context_word_list->push_back (GCI::IO::StringFactory::make (bad_list [i]));
	}

	size_t corrected_context_size = corrected->length ();
	corrected_context = new ContextWordList ();
	corrected_context->reserve (corrected_context_size);
	for (size_t i = 0; i < corrected_context_size; ++i) {
		corrected_context->push_back (GCI::IO::StringFactory::make (corrected[i]));
	}

	return context_word_list.forget ();
	//#UC END# *48284BC700D9_460125FD00EF*
}

// implemented method from Search
// Создать новый поисковый запрос. В созданном поисковом запросе по умолчанию создаеться корневой
// QueryOperationNode с опреацией LO_AND.
Query* SearchImpl::create_query (QueryType type) const {
	//#UC START# *45EEE0A40202_460125FD00EF*
	return QueryFactory::make (type);
	//#UC END# *45EEE0A40202_460125FD00EF*
}

// implemented method from Search
AttributeInfo* SearchImpl::get_attribute_info (AttributeTag_const tag) const {
	//#UC START# *45EEE0A40204_460125FD00EF*
	return AttributeInfoFactory::make (tag);
	//#UC END# *45EEE0A40204_460125FD00EF*
}

// implemented method from Search
// Список документов без команды CLASS
DynList* SearchImpl::get_documents_without_class () const {
	//#UC START# *4746F7020272_460125FD00EF*
	try {
		GblDocList::DocListTree_var doc_list_tree = 
			ApplicationHelper::instance ()->get_cached_search_manager ()->get_special_document_list (::GblPilotQueryDef::WITHOUT_CLASS);
		return DynListFactory::make (doc_list_tree.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} /*catch (...) {//ловить серверный VersionMismatch
		throw VersionMismatch ();
	}*/
	//#UC END# *4746F7020272_460125FD00EF*
}

// implemented method from Search
// Cписок документов с командой vanonced и без команды vincluded
DynList* SearchImpl::get_documents_without_included () const {
	//#UC START# *4746F7450002_460125FD00EF*
	try {
		GblDocList::DocListTree_var doc_list_tree = 
			ApplicationHelper::instance ()->get_cached_search_manager ()->get_special_document_list (::GblPilotQueryDef::WITHOUT_INCLUDED);
		return DynListFactory::make (doc_list_tree.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} /*catch (...) {//ловить серверный VersionMismatch
		throw VersionMismatch ();
	}*/
	//#UC END# *4746F7450002_460125FD00EF*
}

// implemented method from Search
// Cписок документов без команды key
DynList* SearchImpl::get_documents_without_key () const {
	//#UC START# *4746F76A0308_460125FD00EF*
	try {
		GblDocList::DocListTree_var doc_list_tree = 
			ApplicationHelper::instance ()->get_cached_search_manager ()->get_special_document_list (::GblPilotQueryDef::WITHOUT_KEY);
		return DynListFactory::make (doc_list_tree.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} /*catch (...) {//ловить серверный VersionMismatch
		throw VersionMismatch ();
	}*/
	//#UC END# *4746F76A0308_460125FD00EF*
}

// implemented method from Search
// получить текст примера по заданной позиции pos
GCI::IO::String* SearchImpl::get_example_text (unsigned long pos) const /*throw (CanNotFindData)*/ {
	//#UC START# *467790F3005D_460125FD00EF*
	try {
		CORBA::String_var text = ApplicationHelper::instance ()->get_cached_search_manager ()->get_example_text (pos);
		return GCI::IO::StringFactory::make (text.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *467790F3005D_460125FD00EF*
}

// implemented method from Search
// Получить количество примеров
unsigned long SearchImpl::get_example_text_count () const {
	//#UC START# *467790D2006D_460125FD00EF*
	this->check_update_and_clear_cache ();
	if (m_example_text_count == std::numeric_limits <unsigned long>::max ()) {
		m_example_text_count = ApplicationHelper::instance ()->get_cached_search_manager ()->get_example_text_count ();
	}
	return m_example_text_count;
	//#UC END# *467790D2006D_460125FD00EF*
}

// implemented method from Search
bool SearchImpl::get_is_morpho_exist () const {
	//#UC START# *45EEE0A4020D_460125FD00EF_GET*
	this->check_update_and_clear_cache ();
	
	if (boost::logic::indeterminate (m_is_morpho_exist)) {
		m_is_morpho_exist = ApplicationHelper::instance ()->get_cached_search_manager ()->is_morpho_exist ();
	}
	
	return m_is_morpho_exist;
	//#UC END# *45EEE0A4020D_460125FD00EF_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

