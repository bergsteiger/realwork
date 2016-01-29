////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmListEntry_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PharmFirmListEntry_i::PharmFirmListEntry_i (GCD::ObjectID id)
//#UC START# *47E8DE4300AE_47E8E000004D_47E8E2D900D9_BASE_INIT*
: m_document_id (id)
//#UC END# *47E8DE4300AE_47E8E000004D_47E8E2D900D9_BASE_INIT*
{
	//#UC START# *47E8DE4300AE_47E8E000004D_47E8E2D900D9_BODY*
	//#UC END# *47E8DE4300AE_47E8E000004D_47E8E2D900D9_BODY*
}

PharmFirmListEntry_i::~PharmFirmListEntry_i () {
	//#UC START# *47E8E2D900D9_DESTR_BODY*
	//#UC END# *47E8E2D900D9_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// ��������� � ����  ���������� ��������� �������.
// ��������� � � ����� ������������ �������
EntityStorage* PharmFirmListEntry_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_47E8E2D900D9*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_47E8E2D900D9*
}

// implemented method from EntityBase
// �������������
const unsigned long PharmFirmListEntry_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_47E8E2D900D9_GET*
	return 0;
	//#UC END# *456EE084033C_47E8E2D900D9_GET*
}

// implemented method from EntityBase
// �������� �����������
bool PharmFirmListEntry_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_47E8E2D900D9_GET*
	return true;
	//#UC END# *456EB3E1017D_47E8E2D900D9_GET*
}

// implemented method from EntityBase
// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
// ������ ����������.
bool PharmFirmListEntry_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_47E8E2D900D9_GET*
	return false;
	//#UC END# *456EB3E1017C_47E8E2D900D9_GET*
}

// implemented method from EntityBase
// ������������ �������� ������� ���������.
EntityStorage* PharmFirmListEntry_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_47E8E2D900D9*
	throw Unsupported ();
	//#UC END# *456EB3E10178_47E8E2D900D9*
}

// implemented method from PharmFirmListEntry
Document* PharmFirmListEntry_i::get_document () const {
	//#UC START# *47E8E09A02D3_47E8E2D900D9*
	GDS_ASSERT (m_document_id != 0);
	GCD::PID pid;
	pid.m_class_id = Defines::CI_TOPIC;
	pid.m_object_id = m_document_id;
	return DocumentFactory::make (pid, true, 0, DocumentFactoryKeyHelper::PID_to_key (pid));
	//#UC END# *47E8E09A02D3_47E8E2D900D9*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

