////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::LocalPageLogin_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/LibHome.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i.h"

namespace BuildTestLib {
namespace OnBuildDone {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LocalPageLogin_i::LocalPageLogin_i (
	const std::string& login
	, const std::string& passwd
	, ServerGate::Contents::PageId page_id
)
//#UC START# *4C90AE95033F_4C90AF1901C0_4C90AF8C0118_BASE_INIT*
: m_id (page_id)
//#UC END# *4C90AE95033F_4C90AF1901C0_4C90AF8C0118_BASE_INIT*
{
	//#UC START# *4C90AE95033F_4C90AF1901C0_4C90AF8C0118_BODY*
	bool complete = false;
	int try_count = 0;
	while ((try_count < 10) && (!complete)) {
		try {
			LOG_I (("%s (): CoreSrv::SessionFactory::get ().login", GDS_CURRENT_FUNCTION));
			CoreSrv::SessionFactory::get ().login (login, passwd);
			complete = true;
		} catch (::CoreSrv::AlreadyLogged& e) {
			LOG_I (("%s (): Error while login: %s", GDS_CURRENT_FUNCTION, e._name()));
			try_count++;
			Sleep(10000);
		}
	}
	//#UC END# *4C90AE95033F_4C90AF1901C0_4C90AF8C0118_BODY*
}

LocalPageLogin_i::~LocalPageLogin_i () {
	//#UC START# *4C90AF8C0118_DESTR_BODY*
	try {
		LOG_I (("%s (): CoreSrv::SessionFactory::get ().logout", GDS_CURRENT_FUNCTION));
		CoreSrv::SessionFactory::get ().logout ();
	} CATCH_AND_LOG ("~LocalPageLogin ()")
	//#UC END# *4C90AF8C0118_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from LocalPageLogin
// ссылка на страницу
ServerGate::Contents::KPage* LocalPageLogin_i::get_p () const {
	//#UC START# *4C90AED600E4_4C90AF8C0118_GET*
	return &ServerGate::Contents::KPageFactory::get (m_id);
	//#UC END# *4C90AED600E4_4C90AF8C0118_GET*
}
} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

