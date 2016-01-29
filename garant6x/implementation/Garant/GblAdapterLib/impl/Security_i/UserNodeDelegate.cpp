////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNodeDelegate
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserNodeDelegate::UserNodeDelegate (TreeBase* owner_tree)
//#UC START# *49E58127026C_BASE_INIT*
: DefaultNodeBase (owner_tree), DelegateNodeBase (owner_tree), NodeDelegate (owner_tree)
//#UC END# *49E58127026C_BASE_INIT*
{
	//#UC START# *49E58127026C_BODY*
	//#UC END# *49E58127026C_BODY*
}

UserNodeDelegate::~UserNodeDelegate () {
	//#UC START# *49E57FD50219_DESTR_BODY*
	//#UC END# *49E57FD50219_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ProfileNode
Uid UserNodeDelegate::get_uid () const {
	//#UC START# *465EC3DA036B_49E57FD50219*
	const ProfileNode* master_node = dynamic_cast<const ProfileNode*> (this->cached_master_node ());
	GDS_ASSERT (master_node);
	return master_node->get_uid ();
	//#UC END# *465EC3DA036B_49E57FD50219*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// ���������� ���� �� �������� ������� ������������ �������
NodeBase* UserNodeDelegate::get_by_visible_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D8_49E57FD50219*
	// �������� � ���, ��� �������� reset_delta, ������� ������� �� ��� ��� ����,
	// �������� �� �������� �����������. �������� ����� ����������� � ������� � ������ 
	// get_by_visible_index �� �������� ����. ��� ���������� �������� ������� �� �����, � 
	// � ����� ������ �������� �� �������� - ������ ��� �����������.  � ���� � ���� ��� 
	// ������� � ������, ��� �������� � ������� �� ������ �� ����� ���������� �������.
	// (��. NodeDelegate::get_by_visible_index - ��� ���� ������� � �����������, ������� �� �������) .
	if (!dynamic_cast<const FlagNodeBase*>(m_parent)) {
		LOG_W (("call %s at chang�d tree", GDS_CURRENT_FUNCTION));
		return 0;
	}

	// �278839378 - ��������� ����� � ������ ����������� ������ � ��������� �����������
	if ((ind < 0) && !dynamic_cast<const FlagNodeBase*>(m_prev)) {
		LOG_W (("call %s at chang�d tree", GDS_CURRENT_FUNCTION));
		return 0;
	}

	return NodeDelegate::get_by_visible_index (ind);
	//#UC END# *45EEB95901D8_49E57FD50219*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

