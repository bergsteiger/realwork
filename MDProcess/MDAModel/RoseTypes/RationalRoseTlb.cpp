////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseTypes/RationalRoseTlb.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseTypes::RationalRoseTlb
// ���� ���������� ���������� ������ RationalRoseTlb
//
// ���� �������� ��� ��������� ���-������� �������� ���������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *4571DD8C003E_CUSTOM_INCLUDES*
#import "X:\support\import\RationalRose.tlb"                                            \
	no_namespace                                                                    \
	rename ("GetClassName", "GetRoseClassName")                                     \
	rename ("GetProfileString", "GetRoseProfileString")                             \
	rename ("WriteProfileString", "WriteRoseProfileString")				\
	rename ("GetUniqueID", "DeprecatedGetUniqueID")					\
	implementation_only
//#UC END# *4571DD8C003E_CUSTOM_INCLUDES*


//#UC START# *4571DD8C003E*
//#UC END# *4571DD8C003E*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

bool RoseElementComparator::operator () (const RoseElementWrapper& first_param_, const RoseElementWrapper& second_param_) const {
	//#UC START# *47D8D9830155_IMPL*
	return get_rose_element_uid(first_param_.element) < get_rose_element_uid(second_param_.element);
	//#UC END# *47D8D9830155_IMPL*
}


// �����������, ���� ������� ��� ���������
RoseElementWrapper::RoseElementWrapper (IRoseElementPtr elem)
//#UC START# *47D8F66A0388_INIT_CTOR_BASE_INIT*
//#UC END# *47D8F66A0388_INIT_CTOR_BASE_INIT*
{
	//#UC START# *47D8F66A0388_CTOR_BODY*
	element = elem;
	//#UC END# *47D8F66A0388_CTOR_BODY*
}


// ���������� ������������� ��������. �.� ��� ����������� ��������� ��������� ���������� �������
// ������ ������� � ��������� �����, ��� ���� �������� ������������� ��������, ��� �������� �
// ���������� ������������ - "���������" ���� ������. ��� ������� ���� ��������, ��� �����
// ����������� � �������� ������ �������� �� ����� Base::STORED_UID_KEY ������������ �������������
// ���������� ��������. � ����� � ����, ���� ��� ������ ������������ ������ ���� ����� ���
// ��������� ��������������
const std::string get_rose_element_uid (IRoseElementPtr elem) {
	//#UC START# *4BAC9F21036C*
	std::string uid (static_cast<const char*>(elem->GetPropertyValue (TOOL_NAME, Base::STORED_UID_KEY.c_str ())));
	if (uid.empty ()) {
		uid = static_cast<const char*>(elem->DeprecatedGetUniqueID ());
	}

	return uid;
	//#UC END# *4BAC9F21036C*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

