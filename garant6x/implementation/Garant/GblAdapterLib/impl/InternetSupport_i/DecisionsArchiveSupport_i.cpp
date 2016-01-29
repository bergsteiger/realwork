////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::DecisionsArchiveSupport_i
//
// поддержка доступа к архивам судебных решений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DecisionsArchiveSupport_i::DecisionsArchiveSupport_i ()
//#UC START# *4F71CF610077_4F71D0930146_4F71CFDD002D_BASE_INIT*
: m_archive_available (boost::indeterminate)
//#UC END# *4F71CF610077_4F71D0930146_4F71CFDD002D_BASE_INIT*
{
	//#UC START# *4F71CF610077_4F71D0930146_4F71CFDD002D_BODY*
	//#UC END# *4F71CF610077_4F71D0930146_4F71CFDD002D_BODY*
}

DecisionsArchiveSupport_i::~DecisionsArchiveSupport_i () {
	//#UC START# *4F71CFDD002D_DESTR_BODY*
	//#UC END# *4F71CFDD002D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void DecisionsArchiveSupport_i::clear_cache () {
	//#UC START# *45702DA9037A_4F71CFDD002D*
	m_archive_available = boost::indeterminate;
	//#UC END# *45702DA9037A_4F71CFDD002D*
}

// implemented method from DecisionsArchiveSupport
// архив судебных решений доступен
bool DecisionsArchiveSupport_i::archive_available () const {
	//#UC START# *4F71DD6B03AA_4F71CFDD002D*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_archive_available)) {
		m_archive_available = ApplicationHelper::instance ()->get_cached_decisions_archive_support()->archive_available ();
	}
	return m_archive_available;	
	//#UC END# *4F71DD6B03AA_4F71CFDD002D*
}

// implemented method from DecisionsArchiveSupport
// получить ссылку для перехода на архив судебных решений
GCI::IO::String* DecisionsArchiveSupport_i::get_archive_url () const {
	//#UC START# *4F71D47D0086_4F71CFDD002D*
	CORBA::String_var url (ApplicationHelper::instance ()->get_cached_decisions_archive_support ()->archive_url ());
	return GCI::IO::StringFactory::make (url.in ());
	//#UC END# *4F71D47D0086_4F71CFDD002D*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

