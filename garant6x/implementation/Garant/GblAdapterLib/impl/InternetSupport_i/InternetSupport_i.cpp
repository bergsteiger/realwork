////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::InternetSupport_i
//
// поддержка работы пользователей через internet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InternetSupport_i::InternetSupport_i ()
//#UC START# *4BD1331201C8_4BD1393B0146_4BD138D00215_BASE_INIT*
	: m_revision_check_enabled (boost::indeterminate)
	, m_show_warning (boost::indeterminate)
//#UC END# *4BD1331201C8_4BD1393B0146_4BD138D00215_BASE_INIT*
{
	//#UC START# *4BD1331201C8_4BD1393B0146_4BD138D00215_BODY*
	//#UC END# *4BD1331201C8_4BD1393B0146_4BD138D00215_BODY*
}

InternetSupport_i::~InternetSupport_i () {
	//#UC START# *4BD138D00215_DESTR_BODY*
	//#UC END# *4BD138D00215_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void InternetSupport_i::clear_cache () {
	//#UC START# *45702DA9037A_4BD138D00215*
	m_revision_check_enabled = boost::indeterminate;
	m_show_warning = boost::indeterminate;
	//#UC END# *45702DA9037A_4BD138D00215*
}

// implemented method from InternetSupport
// получить URL для заданного документа
GCI::IO::String* InternetSupport_i::get_url_for_document (unsigned long doc_id, unsigned long para_id) const {
	//#UC START# *4BD133E40285_4BD138D00215*
	CORBA::String_var url (ApplicationHelper::instance ()->get_cached_remote_document_support ()->get_url_for_document (doc_id, para_id));
	return GCI::IO::StringFactory::make (url.in ());
	//#UC END# *4BD133E40285_4BD138D00215*
}

// implemented method from InternetSupport
// получить URL для интранет версии
GCI::IO::String* InternetSupport_i::get_url_for_internet_version () const {
	//#UC START# *4BD1456303BC_4BD138D00215*
	return this->get_url_for_document (0, 0);
	//#UC END# *4BD1456303BC_4BD138D00215*
}

// implemented method from InternetSupport
// Разрешен ли Интернет-Агент.
bool InternetSupport_i::is_internet_agent_enabled () const {
	//#UC START# *4BD1396400A3_4BD138D00215*
	static int internet_agent_status = -1;

	if (internet_agent_status == -1) {
		internet_agent_status = (
			ApplicationHelper::instance ()->get_cached_function_manager ()->is_internet_agent_enabled ()
		) ? (1) : (0);
	}

	return (internet_agent_status != 0);
	//#UC END# *4BD1396400A3_4BD138D00215*
}

// implemented method from InternetSupport
// Разрешена ли онлайн проверка ревизий документов (для супермобильной версии)
bool InternetSupport_i::revision_check_enabled () const {
	//#UC START# *4BD133C102AD_4BD138D00215*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_revision_check_enabled)) {
		m_revision_check_enabled = ApplicationHelper::instance ()->get_cached_remote_document_support ()->revision_check_enabled ();
	}
	return m_revision_check_enabled;
	//#UC END# *4BD133C102AD_4BD138D00215*
}

// implemented method from InternetSupport
// Нужно ли показывать блямбу об отключении онлайн проверки
bool InternetSupport_i::show_warning () const {
	//#UC START# *4D6648D000C3_4BD138D00215*
	// Блямбу показываем, если разрешена проверка ревизий и база устарела
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_show_warning)) {
		m_show_warning = ApplicationHelper::instance ()->get_cached_remote_document_support ()->base_not_valid_for_online_check ();
	}
	return m_show_warning;
	//#UC END# *4D6648D000C3_4BD138D00215*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

