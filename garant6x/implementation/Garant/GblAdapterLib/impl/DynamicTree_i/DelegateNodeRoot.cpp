////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeRoot
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DelegateNodeRoot::DelegateNodeRoot (TreeBase* owner_tree)
//#UC START# *45FE9032035B_BASE_INIT*
: DefaultNodeBase (owner_tree), NodeDelegate (owner_tree), DelegateNodeBase (owner_tree)
//#UC END# *45FE9032035B_BASE_INIT*
{
	//#UC START# *45FE9032035B_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (NodeDelegate*)this));
	m_owner_view = dynamic_cast <ViewBase*> (owner_tree); // take ownership
	GDS_ASSERT (m_owner_view.ptr ());
	//#UC END# *45FE9032035B_BODY*
}

DelegateNodeRoot::~DelegateNodeRoot () {
	//#UC START# *45FE8E720000_DESTR_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (NodeDelegate*)this));
	// ������ ����� �������� InvalidOwnerTree � ������ ���������� ����:
	// 1. �������� ����������� �� ���������� ����.
	// 2. �� ���� ����������� �������� ������ �� Common get_new_main_menu,
	// ������� �������� ��� �������
	// 3. �������� ��������� ��� ���, ��� �������� �������� ���� ����������,
	// � � root_is_dead ������� ���������� � ������.
	try {
		m_owner_view->root_is_dead ();
	} catch (TreeBase::InvalidOwnerTree&) {
	}
	//#UC END# *45FE8E720000_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from DefaultNodeBase
bool DelegateNodeRoot::apply_change_delta (GTree::ChangeDelta& delta) {
	//#UC START# *45F95B9A0000_45FE8E720000*
	// ��� ��� � ������� �� ��������� ���� ������ ������ �� ����,
	// �� ������������ �� ������
	// (������ �������� ��� ��������� ��������� ����� ����������� ����������,
	// ����� ������ �����������, ���������� ��� ������)

	return false;
	//#UC END# *45F95B9A0000_45FE8E720000*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

