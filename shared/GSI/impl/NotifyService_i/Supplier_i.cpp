////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/Supplier_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Supplier_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/LibHome.h"
#include "shared/GSI/impl/NotifyService_i/Supplier_i.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"
// by <<uses>> dependencies
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"

namespace GSI {
namespace NotifyService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Supplier_i::Supplier_i ()
//#UC START# *44B2076B03C8_44B2083C03C8_44B26F310177_BASE_INIT*
//#UC END# *44B2076B03C8_44B2083C03C8_44B26F310177_BASE_INIT*
{
	//#UC START# *44B2076B03C8_44B2083C03C8_44B26F310177_BODY*
	//#UC END# *44B2076B03C8_44B2083C03C8_44B26F310177_BODY*
}

Supplier_i::~Supplier_i () {
	//#UC START# *44B26F310177_DESTR_BODY*
	//#UC END# *44B26F310177_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NotifyService::Supplier
// ������� ������� ���������, ������� ����� �������� ���� �����������.
void Supplier_i::send_common_notify_ (
	const CORBA::Any& notify
) const /*throw (
	NotifyService::InternalError
	, NotifyService::NotInitialized
)*/ {
	//#UC START# *44B207CC001E_44B26F310177*
	ManagerLocal& mng = ManagerLocalFactory::make ();
	mng.send_common_notify (notify);
	//#UC END# *44B207CC001E_44B26F310177*
}

// implemented method from NotifyService::Supplier
// ������� ������������ ���������, ������� ����� �������� ������ �����������, ������� ��� ��������
// �� ��������� ������ �������� prs_id
void Supplier_i::send_personal_notify_ (
	const CORBA::Any& notify
	, NotifyService::PersonalID prs_id
) const /*throw (
	NotifyService::InternalError
	, NotifyService::NotInitialized
)*/ {
	//#UC START# *44B207DD0147_44B26F310177*
	ManagerLocal& mng = ManagerLocalFactory::make ();
	mng.send_personal_notify (notify, prs_id);
	//#UC END# *44B207DD0147_44B26F310177*
}
} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

