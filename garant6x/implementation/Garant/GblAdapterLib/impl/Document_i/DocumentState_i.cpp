////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentState_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LanguagesTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/RedactionInfoListHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocWithPid.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"

//#UC START# *460A59CD0328_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
//#UC END# *460A59CD0328_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *460A59CD0328*
bool DocumentState_i::operator == (const DocumentState_i& other) const {
	return m_new_state.language == other.m_new_state.language
		&& m_new_state.has_extruct == other.m_new_state.has_extruct
		&& is_list_data_equivalent (m_new_state.appropriate_entry_in_list.ptr (), other.m_new_state.appropriate_entry_in_list.ptr ())
		&& ((!m_new_state.redaction && !other.m_new_state.redaction) || this->redaction() == other.redaction ());
}
 
DocumentState_i& DocumentState_i::operator = (const DocumentState_i& copy) {
	if (this != &copy) {
		m_new_state = copy.m_new_state;
		m_source_doc = copy.m_source_doc;
	}
	return *this;
}

DocumentState_i::DocumentState_i (const DocumentState_i& copy) {
	*this = copy;
}

bool DocumentState_i::is_actual_redaction (RedactionType type) {
	return type == RT_ACTUAL || type == RT_ACTUAL_ABOLISHED || type == RT_ACTUAL_PREACTIVE;
}
//#UC END# *460A59CD0328*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
DocumentState_i::State::State (const State& copy) 
//#UC START# *461A555F0213_COPY_CTOR_BASE_INIT*
//#UC END# *461A555F0213_COPY_CTOR_BASE_INIT*
{
	//#UC START# *461A555F0213_COPY_CTOR*
	*this = copy;
	//#UC END# *461A555F0213_COPY_CTOR*
}

DocumentState_i::State& DocumentState_i::State::operator = (const State& copy) {
	//#UC START# *461A555F0213_ASSIGN_OP*
	if (this != &copy) {
		redaction = copy.redaction;
		language = copy.language;
		has_extruct = copy.has_extruct;
		appropriate_entry_in_list = copy.appropriate_entry_in_list;
		prev_redaction_info_list = new RedactionInfoList (*copy.prev_redaction_info_list);
		cur_and_next_redaction_info_list = new RedactionInfoList (*copy.cur_and_next_redaction_info_list);
	}	
	//#UC END# *461A555F0213_ASSIGN_OP*
	return *this;
}

DocumentState_i::State::State ()
//#UC START# *462874F5036D_INIT_CTOR_BASE_INIT*
	: redaction (0)
	, language (GblPilotDef::dl_Russian)
	, has_extruct (false)
	, prev_redaction_info_list (new RedactionInfoList)
	, cur_and_next_redaction_info_list (new RedactionInfoList)
//#UC END# *462874F5036D_INIT_CTOR_BASE_INIT*
{
	//#UC START# *462874F5036D_CTOR_BODY*
	//#UC END# *462874F5036D_CTOR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentState_i::DocumentState_i (Document* source_doc)
//#UC START# *45EED80E0086_4628CE6F02EA_460A59CD0328_BASE_INIT*
//#UC END# *45EED80E0086_4628CE6F02EA_460A59CD0328_BASE_INIT*
{
	//#UC START# *45EED80E0086_4628CE6F02EA_460A59CD0328_BODY*
	m_source_doc = dynamic_cast<Document_i*>(source_doc);
	m_new_state = m_source_doc->m_current_state->m_new_state;
	//#UC END# *45EED80E0086_4628CE6F02EA_460A59CD0328_BODY*
}

DocumentState_i::DocumentState_i ()
//#UC START# *45EED80E0086_4756B7190023_460A59CD0328_BASE_INIT*
	: m_source_doc (0)
//#UC END# *45EED80E0086_4756B7190023_460A59CD0328_BASE_INIT*
{
	//#UC START# *45EED80E0086_4756B7190023_460A59CD0328_BODY*
	//#UC END# *45EED80E0086_4756B7190023_460A59CD0328_BODY*
}

DocumentState_i::~DocumentState_i () {
	//#UC START# *460A59CD0328_DESTR_BODY*
	//#UC END# *460A59CD0328_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

bool DocumentState_i::is_list_data_equivalent (const ListEntryInfo* lei1, const ListEntryInfo* lei2) const {
	//#UC START# *4628CE0D0387*
	if (lei1 && lei2) {
		return dynamic_cast<const ListEntryInfo_i*>(lei1)->operator == (dynamic_cast<const ListEntryInfo_i*>(lei2));
	}

	if (lei1) {
		return !lei1->get_entry_list ().length () && !lei1->get_relevance_words_list ().length ();
	}

	if (lei2) {
		return !lei2->get_entry_list ().length () && !lei2->get_relevance_words_list ().length ();
	}

	return true;
	//#UC END# *4628CE0D0387*
}

GblPilotDef::DictLanguage DocumentState_i::language () const {
	//#UC START# *4628CC360176*
	return m_new_state.language;
	//#UC END# *4628CC360176*
}

void DocumentState_i::set_appropriate_list_info (const ListEntryInfo* lei) {
	//#UC START# *462C92D5026B*
	m_new_state.appropriate_entry_in_list = ListEntryInfo::_duplicate (const_cast<ListEntryInfo*> (lei));
	//#UC END# *462C92D5026B*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocumentState
// [$178325284]
bool DocumentState_i::can_compare_with_any_other_redaction () const {
	//#UC START# *4B54571C028B_460A59CD0328*
	// {{{ [$190678297]
	return m_source_doc->get_current_redaction_info ().is_comparable;
	// }}}

	// {{{ [$186351839]
	//const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();
	//int ind = RedactionInfoListHelper::find_redaction (redactions_list, this->redaction ());
	//if (ind < 0 || static_cast <size_t> (ind) >= redactions_list.size ()) {
	//  throw RedactionNotFound ();
	//}
	//
	//const ActiveIntervalList& active_intervals = redactions_list [ind].active_intervals;
	//if (active_intervals.empty () || (active_intervals [0].start == Date () && active_intervals [0].finish == Date ()))	{
	//  return false;
	//}
	//
	//[$183796244] : has anyone to compare	?
	//for (size_t i = 0; i < redactions_list.size (); ++i) {
	//  const ActiveIntervalList& active_intervals = redactions_list [i].active_intervals;
	//  if (i == ind || active_intervals.empty () || (active_intervals [0].start == Date () && active_intervals [0].finish == Date ())) {
	//    continue;
	//  } else {
	//    return true; // has
	//  }
	//}
	//return false;    // has no
	//}}}
	//#UC END# *4B54571C028B_460A59CD0328*
}

// implemented method from DocumentState
DocumentState* DocumentState_i::clone () const {
	//#UC START# *4A8130CE0320_460A59CD0328*
	return new DocumentState_i (*this);
	//#UC END# *4A8130CE0320_460A59CD0328*
}

// implemented method from DocumentState
// [$178324034]
const RedactionInfoList& DocumentState_i::get_cur_and_next_redactions_list () const {
	//#UC START# *4B556B8F02C1_460A59CD0328_GET*
	m_new_state.cur_and_next_redaction_info_list->clear ();
	RedactionInfoList& list = *m_new_state.cur_and_next_redaction_info_list;
	RedactionInfoListHelper::cur_and_next_redactions (
		m_source_doc->get_redactions_list ()
		, this->redaction ()
		, list
	);

	// {{{ [$186351839]
	//list.erase (                                                                                    // {{{ [$178324052]
	//  std::remove_if (list.begin (), list.end (), RedactionInfoListHelper::NoActivityInterval ())
	//  , list.end ()
	//);                                                                                              // }}}
	// }}}
	std::reverse (list.begin (), list.end ());                                                      // [$184287322]

	return list;
	//#UC END# *4B556B8F02C1_460A59CD0328_GET*
}

// implemented method from DocumentState
DiffData* DocumentState_i::diff_with_redaction_by_id (RedactionID id) const {
	//#UC START# *4CC972C00194_460A59CD0328*
	GCD::PID pid;
	pid.m_class_id = Defines::CI_TOPIC; // or CI_EDITION ?! 
	pid.m_object_id = id;
	return static_cast<Document*> (m_source_doc)->diff (pid); 
	//#UC END# *4CC972C00194_460A59CD0328*
}

// implemented method from DocumentState
RedactionInfo* DocumentState_i::get_current_redaction () const {
	//#UC START# *46320AD6033A_460A59CD0328*
	//LOG_D (("DocumentState_i[%d]::get_current_redaction", this));
	Core::Aptr<RedactionInfo> current_redaction (new RedactionInfo);
	try {
		const RedactionInfo& curr_red = m_source_doc->get_current_redaction_info ();
		
		current_redaction->name = curr_red.name;
		current_redaction->actual_type = curr_red.actual_type;
		current_redaction->active_intervals = curr_red.active_intervals; 
		current_redaction->id = curr_red.id;
		current_redaction->time_machine_date = curr_red.time_machine_date;
		current_redaction->doc_date = curr_red.doc_date; 
		current_redaction->not_sure_intervals = curr_red.not_sure_intervals; 

	} catch (CanNotFindData&) {
		current_redaction->name = GCI::IO::StringFactory::make ("no name");
		current_redaction->actual_type = RT_ACTUAL;
		current_redaction->id = 0;
	}
	return current_redaction.forget ();
	//#UC END# *46320AD6033A_460A59CD0328*
}

// implemented method from DocumentState
// возвращает true, если эта редакция актуальная, т. е. имеет тип:
// - RT_ACTUAL
// - RT_ACTUAL_ABOLISHED
// - RT_ACTUAL_PREACTIVE
bool DocumentState_i::is_actual () const {
	//#UC START# *4EE7512C0058_460A59CD0328*
	try {
		const RedactionInfo& info = m_source_doc->get_current_redaction_info ();
		return is_actual_redaction (info.actual_type);
	} catch (CanNotFindData&) {
		return true;
	}
	//#UC END# *4EE7512C0058_460A59CD0328*
}

// implemented method from DocumentState
bool DocumentState_i::is_same_redactions (const DocumentState* other) const {
	//#UC START# *4628CAEB0169_460A59CD0328*
	const DocumentState_i* other_i = dynamic_cast<const DocumentState_i*> (other);
	GDS_ASSERT (other_i);
	return (m_new_state.redaction == 0 && other_i->m_new_state.redaction == 0)
		|| (this->redaction () == other->redaction ());
	//#UC END# *4628CAEB0169_460A59CD0328*
}

// implemented method from DocumentState
Languages DocumentState_i::get_language () const {
	//#UC START# *460A40CB01F0_460A59CD0328_GET*
	return LanguagesTranslatorSingleton::instance ()->get (m_new_state.language);
	//#UC END# *460A40CB01F0_460A59CD0328_GET*
}

void DocumentState_i::set_language (Languages language) {
	//#UC START# *460A40CB01F0_460A59CD0328_SET*
	m_new_state.language = LanguagesTranslatorSingleton::instance ()->get (language);
	//#UC END# *460A40CB01F0_460A59CD0328_SET*
}

// implemented method from DocumentState
const RedactionInfoList& DocumentState_i::get_prev_redactions_list () const {
	//#UC START# *4A81280E02DE_460A59CD0328_GET*
	m_new_state.prev_redaction_info_list->clear ();
	RedactionInfoList& list = *m_new_state.prev_redaction_info_list;
	RedactionInfoListHelper::prev_redactions (
		m_source_doc->get_redactions_list ()
		, this->redaction ()
		, list
	);

	// {{{ [$186351839]
	//list.erase (                                                                                    // {{{ [$178324052]
	//  std::remove_if (list.begin (), list.end (), RedactionInfoListHelper::NoActivityInterval ())
	//  , list.end ()
	//);                                                                                              // }}}
	// }}}
	return list;
	//#UC END# *4A81280E02DE_460A59CD0328_GET*
}

// implemented method from DocumentState
RedactionID DocumentState_i::redaction () const {
	//#UC START# *46289947018D_460A59CD0328*
	if (m_new_state.redaction) {
		return m_new_state.redaction;
	} else {
		return dynamic_cast<const DocWithPid*> (m_source_doc)->get_document_pid ().m_object_id;
	}
	//#UC END# *46289947018D_460A59CD0328*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей редакцию, актуальную редакцию для данного документа.
// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
// что и до вызова метода.
void DocumentState_i::set_actual_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E008D_460A59CD0328*
	const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();

	int ind = RedactionInfoListHelper::find_actual_redaction (redactions_list);
	if (ind >= 0) {
		m_new_state.redaction = redactions_list [ind].id;
		return;
	}

	throw RedactionNotFound();
	//#UC END# *45EED80E008D_460A59CD0328*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей следующую редакцию объекта.
// Если следующей редакции нет, то возвращается RedactionNotFound.
void DocumentState_i::set_next_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E0088_460A59CD0328*
	const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();
	int ind = RedactionInfoListHelper::find_redaction (redactions_list, this->redaction ());
	if (ind > 0) {
		m_new_state.redaction = redactions_list [ind - 1].id;
	} else {
		throw RedactionNotFound ();
	}
	//#UC END# *45EED80E0088_460A59CD0328*
}

// implemented method from DocumentState
// GetБлижайшаяДействующаяРедакцияВниз. [$178325284]
void DocumentState_i::set_prev_active_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *4B545717011B_460A59CD0328*
	this->set_prev_redaction ();
	// {{{ [$186351839]
	//const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();
	//int ind = RedactionInfoListHelper::find_redaction (redactions_list, this->redaction ());
	//if (ind < 0 || static_cast <size_t> (ind) >= redactions_list.size ())	{
	//  throw RedactionNotFound ();
	//}
	//
	//while (static_cast <size_t> (++ind) < redactions_list.size ()) {
	//  const ActiveIntervalList& active_intervals = redactions_list [ind].active_intervals;
	//  if (!active_intervals.empty () && (active_intervals [0].start != Date () || active_intervals [0].finish != Date ())) {
	//    m_new_state.redaction = redactions_list [ind].id;
	//    return;
	//  }
	//}
	//
	//throw RedactionNotFound ();
	// }}}
	//#UC END# *4B545717011B_460A59CD0328*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей предыдущую редакцию объекта.
// Если предыдущей редакции нет, то возвращается RedactionNotFound.
void DocumentState_i::set_prev_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E0087_460A59CD0328*
	const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();
	int ind = RedactionInfoListHelper::find_redaction (redactions_list, this->redaction ());
	if (ind >= 0 && static_cast <size_t> (ind) < redactions_list.size () - 1) {
		m_new_state.redaction = redactions_list [ind + 1].id;
	} else {
		throw RedactionNotFound ();
	}
	//#UC END# *45EED80E0087_460A59CD0328*
}

// implemented method from DocumentState
void DocumentState_i::set_redaction_on_date (const Date& date) const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E0089_460A59CD0328*
	if (date == Date ()) {
		throw RedactionNotFound ();
	}
		
	const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();
	long length = redactions_list.size ();
	if (!length) {
		throw RedactionNotFound ();
	}

	int i = 0; // GARANT_FORSCOPING
	for (i = 0; i < length; i++) {
		const RedactionInfo& red_info = redactions_list [i]; 
		for (long j = 0; static_cast<size_t> (j) < red_info.active_intervals.size (); j++) {	
			
			const DateInterval& date_int = red_info.active_intervals [j];
			
			bool is_activity_interval = (date_int.start != Date () || date_int.finish != Date ());
			
			// [dk]:
			// у будущих редакций тоже может не быть интервала активности! может надо реагировать не на нулевые даты,
			// а на команды ACTIVE/NOACTIVE ?
			
			if (!is_activity_interval && red_info.actual_type == RT_OLD) {
				continue;
			}

			if (date_int.start <= date && date <= date_int.finish) {
				m_new_state.redaction = red_info.id;
				return; // check changing!
			}
		}
	}

	// is this realy need? first and second cycle must be merged!!!

	Date start;
	
	bool first_redactions_skipped = true; // patch for "первоначальная редакция без интервалов активности"

	i = length - 1;
	for (; i >= 0; --i) {
		
		const RedactionInfo& data_ref = redactions_list [i];
		const ActiveIntervalList& intervals = data_ref.active_intervals;

		long activity_length = intervals.size ();
		const DateInterval& first_date_interval = intervals [0];

		// skip redaction if it was not used 
		if (activity_length == 1 && first_date_interval.start == Date () && first_date_interval.finish == Date ()) {
			continue;
		}
		
		const DateInterval& last_date_interval = intervals [activity_length-1];

		Date finish = last_date_interval.finish;

		if (date < last_date_interval.start && first_redactions_skipped) { // patch
			i = length - 1;
			break;
		}

		first_redactions_skipped = false; // patch 

		if (start < date && date < finish || start < date && finish == Date ()) { // add open interval processing
			break;
		}

		start = finish;
	}

	m_new_state.redaction = redactions_list [i >= 0 ? i : 0].id;
	//#UC END# *45EED80E0089_460A59CD0328*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей редакцию с заданным идентификатором.
// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
// что и до вызова метода.
// Если задан неверный идентификатор редакции, то возвращается InvalidRedactionId.
void DocumentState_i::set_redaction_on_id (RedactionID id) const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E008B_460A59CD0328*
	if (this->redaction() == id) {
		return;
	}
	
	const RedactionInfoList& redactions_list = m_source_doc->get_redactions_list ();
	int ind = RedactionInfoListHelper::find_redaction (redactions_list, id);
	if (ind >= 0) {
		m_new_state.redaction = redactions_list[ind].id;
		return;
	} 

	throw RedactionNotFound();
	//#UC END# *45EED80E008B_460A59CD0328*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

