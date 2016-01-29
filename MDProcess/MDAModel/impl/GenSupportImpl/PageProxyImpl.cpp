////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::PageProxyImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl.h"

namespace GenSupportImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PageProxyImpl::PageProxyImpl (ServerGate::GenerationContents::ModelElementId_const page_guid)
//#UC START# *4B39CFBB015A_4B39D0D700F1_4B39D17B006E_BASE_INIT*
: m_guid (page_guid), m_delegate (0)
//#UC END# *4B39CFBB015A_4B39D0D700F1_4B39D17B006E_BASE_INIT*
{
	//#UC START# *4B39CFBB015A_4B39D0D700F1_4B39D17B006E_BODY*
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	//#UC END# *4B39CFBB015A_4B39D0D700F1_4B39D17B006E_BODY*
}

PageProxyImpl::~PageProxyImpl () {
	//#UC START# *4B39D17B006E_DESTR_BODY*
	//#UC END# *4B39D17B006E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& PageProxyImpl::get_guid () const {
	//#UC START# *4B39D1A60147_GET_ACCESSOR*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	return m_guid;
	//#UC END# *4B39D1A60147_GET_ACCESSOR*
}

ServerGate::GenerationContents::Page* PageProxyImpl::get_delegate () const {
	//#UC START# *4B39D2100167_GET_ACCESSOR*
	if (m_delegate == 0) {
		m_delegate = &ServerGate::GenerationContents::PageFactory::get (this->get_guid ().c_str ());
	}

	return m_delegate;
	//#UC END# *4B39D2100167_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GenSupport::PageProxy
// добавляет диаграмму в аттач
void PageProxyImpl::add_diagram (
	const char* name
	, const ServerGate::GenerationContents::Diagram& d
) /*throw (
	ServerGate::GenerationContents::TransactionConflict
	, ServerGate::GenerationContents::ReadOnlyContent
)*/ {
	//#UC START# *4B39EE920344_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);

	m_is_modified.reset ();
	this->get_delegate ()->add_diagram (name, d);
	//#UC END# *4B39EE920344_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// добавляет или заменяет свойства элемента генерации
void PageProxyImpl::add_property_map (
	const ServerGate::GenerationContents::PropertyMapEntryList& map
) /*throw (
	ServerGate::GenerationContents::TransactionConflict
	, ServerGate::GenerationContents::ReadOnlyContent
	, ServerGate::GenerationContents::ContentUpdateError
	, ServerGate::GenerationContents::PathNotValid
)*/ {
	//#UC START# *4B39EE9C0363_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);

	m_is_modified.reset ();
	this->get_delegate ()->add_property_map (map);
	//#UC END# *4B39EE9C0363_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// генерируемая часть текста страницы (без UC). Изменения данного атрибта реально будут произведены
// только при операции commit.  При чтении атрибута используются данные транзакции если читаем из
// тойже сессии, или персистентные в противном случае. Попытка конкурентной записи приводит к
// исключению
const std::string& PageProxyImpl::get_generated_text () const {
	//#UC START# *4B39EF5601B8_4B39D17B006E_GET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	if (!m_generated_text.get ()) {
		//Core::GDS::StopWatchEx sw ("PageProxyImpl::get_generated_text (remote)");
		CORBA::String_var generated_text = this->get_delegate ()->get_generated_text ();
		m_generated_text.reset (new std::string (generated_text.in ()));
	}

	return *m_generated_text;
	//#UC END# *4B39EF5601B8_4B39D17B006E_GET*
}

void PageProxyImpl::set_generated_text (const std::string& generated_text)
	/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/
{
	//#UC START# *4B39EF5601B8_4B39D17B006E_SET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	m_generated_text.reset (new std::string (generated_text));
	m_is_modified.reset ();
	this->get_delegate ()->set_generated_text (generated_text.c_str ());
	//#UC END# *4B39EF5601B8_4B39D17B006E_SET*
}

// implemented method from GenSupport::PageProxy
// возвращает контрольную сумму для всех свойств элемента генерации (нужно для того, чтобы понять,
// что значения или набор свойств изменились с прошлой генерации)
long long PageProxyImpl::get_all_property_cheksum () const {
	//#UC START# *4B39EEDB00B7_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	return this->get_delegate ()->get_all_property_cheksum ();
	//#UC END# *4B39EEDB00B7_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// по имени диаграммы возвращает ее хэш
char* PageProxyImpl::get_diagram_hash (
	const char* name
) const /*throw (
	ServerGate::GenerationContents::ReadOnlyContent
)*/ {
	//#UC START# *4B39EEE30119_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	return this->get_delegate ()->get_diagram_hash (name);
	//#UC END# *4B39EEE30119_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// возвращает тру если страница была изменена
bool PageProxyImpl::is_modified () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ {
	//#UC START# *4B39EEEA00F4_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	/*if (m_is_modified.is_nil ())*/ {
		//Core::GDS::StopWatchEx sw ("PageProxyImpl::is_modified (remote)");
		m_is_modified = this->get_delegate ()->is_modified ();
	}

	return *m_is_modified;
	//#UC END# *4B39EEEA00F4_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// возвращает тру если страница новая
bool PageProxyImpl::is_new_page () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ {
	//#UC START# *4B39EF460312_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	if (m_is_new_page.is_nil ()) {
		//Core::GDS::StopWatchEx sw ("PageProxyImpl::is_new_page (remote)");
		m_is_new_page = this->get_delegate ()->is_new_page ();
	}
	return *m_is_new_page;
	//#UC END# *4B39EF460312_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// перечисление лэйблов через запятую
const std::string& PageProxyImpl::get_labels () const {
	//#UC START# *4B39EF5C0110_4B39D17B006E_GET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	if (!m_labels.get ()) {
		//Core::GDS::StopWatchEx sw ("PageProxyImpl::get_labels (remote)");
		CORBA::String_var labels = this->get_delegate ()->get_labels ();
		m_labels.reset (new std::string (labels.in ()));
	}

	return *m_labels;
	//#UC END# *4B39EF5C0110_4B39D17B006E_GET*
}

void PageProxyImpl::set_labels (const std::string& labels)
	/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/
{
	//#UC START# *4B39EF5C0110_4B39D17B006E_SET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	m_labels.reset (new std::string (labels));
	m_is_modified.reset ();
	this->get_delegate ()->set_labels (labels.c_str ());
	//#UC END# *4B39EF5C0110_4B39D17B006E_SET*
}

// implemented method from GenSupport::PageProxy
// помечает страницу на удаление. Реальное удаление произайдет при коммите
void PageProxyImpl::mark_for_remove () /*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ {
	//#UC START# *4B39EEC500BC_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	this->reset ();
	this->get_delegate ()->mark_for_remove ();
	//#UC END# *4B39EEC500BC_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
// r/o экземпляр страницы до не прокоммиченых изменений
ServerGate::GenerationContents::Page* PageProxyImpl::get_page_before_changes () const {
	//#UC START# *4B39EF6201BA_4B39D17B006E_GET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	return this->get_delegate ()->get_page_before_changes ();
	//#UC END# *4B39EF6201BA_4B39D17B006E_GET*
}

// implemented method from GenSupport::PageProxy
const std::string& PageProxyImpl::get_path () const {
	//#UC START# *4B39F33F0192_4B39D17B006E_GET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	if (!m_path.get ()) {
		//Core::GDS::StopWatchEx sw ("PageProxyImpl::get_path (remote)");
		CORBA::String_var path = this->get_delegate ()->get_path ();
		m_path.reset (new std::string (path.in ()));
	}

	return *m_path;
	//#UC END# *4B39F33F0192_4B39D17B006E_GET*
}

void PageProxyImpl::set_path (const std::string& path) {
	//#UC START# *4B39F33F0192_4B39D17B006E_SET*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	m_path.reset ();
	m_is_modified.reset ();
	this->get_delegate ()->set_path (path.c_str ());
	//#UC END# *4B39F33F0192_4B39D17B006E_SET*
}

// implemented method from GenSupport::PageProxy
// сбрасывает все кэши прокси
void PageProxyImpl::reset () {
	//#UC START# *4B4C46A402EA_4B39D17B006E*
	m_is_modified.reset ();
	m_is_new_page.reset ();
	m_labels.reset ();
	m_generated_text.reset ();
	m_path.reset ();
	//#UC END# *4B4C46A402EA_4B39D17B006E*
}

// implemented method from GenSupport::PageProxy
void PageProxyImpl::rollback_all_changes () /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ {
	//#UC START# *4B4C4650039C_4B39D17B006E*
	//Core::GDS::StopWatchEx sw_all ("PageProxyImpl TOTAL");
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	this->reset ();
	this->get_delegate ()->rollback_all_changes ();
	//#UC END# *4B4C4650039C_4B39D17B006E*
}
} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

