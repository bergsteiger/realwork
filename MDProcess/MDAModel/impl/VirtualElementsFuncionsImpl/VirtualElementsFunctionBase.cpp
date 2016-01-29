////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::VirtualElementsFunctionBase
//
// ������� ����� ��� ���� ������� ������ � ������������ ����������. ��� ���������� �������
// ���������� ������ ������������� �� ����!
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

VirtualElementsFunctionBase::VirtualElementsFunctionBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AF7C2750184_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AF7C2750184_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AF7C2750184_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AF7C2750184_BODY*
}

VirtualElementsFunctionBase::~VirtualElementsFunctionBase () {
	//#UC START# *4AF7C2750184_DESTR_BODY*
	//#UC END# *4AF7C2750184_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ��������� ����� UID �� ��������� �������� ��������.
const std::string VirtualElementsFunctionBase::make_uid (
	const AbstractDumperBase* self
	, const std::string& prefix
	, const std::string& suffix
) const {
	//#UC START# *4AF7C37501A0*
	GDS_ASSERT(self);
	std::string self_uid = self->get_model_unique_id_str ();

	return prefix + self_uid + suffix;
	//#UC END# *4AF7C37501A0*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ����� ���������� ����� ������ ���������� �������
void VirtualElementsFunctionBase::post_execute () const {
	//#UC START# *4AF7C25002E4_4AF7C2750184*
	//#UC END# *4AF7C25002E4_4AF7C2750184*
}

// overloaded method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ����� ���������� ����� ������� ���������� �������
void VirtualElementsFunctionBase::pre_execute () const {
	//#UC START# *4AF7C219001D_4AF7C2750184*
	//#UC END# *4AF7C219001D_4AF7C2750184*
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

