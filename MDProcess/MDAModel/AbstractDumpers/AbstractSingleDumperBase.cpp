////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSingleDumperBase
//
// ������� ����� ��� "������" �������� - ��� ������� ����������� ������� ������, � �� ���������� ��.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"

//#UC START# *4571A32201A5_CUSTOM_INCLUDES*
#include <limits>
//#UC END# *4571A32201A5_CUSTOM_INCLUDES*


//#UC START# *4571A32201A5*
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_scopes(const AbstractDumperBase* main_scope) const {
	ADList* ret = new ADList ();
	return ret;
}

std::ostream* AbstractSingleDumperBase::get_output () const {
	return NULL;
}


//#UC END# *4571A32201A5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractSingleDumperBase::~AbstractSingleDumperBase () {
	//#UC START# *4571A32201A5_DESTR_BODY*
	//#UC END# *4571A32201A5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// ��������� ���� ������
void AbstractSingleDumperBase::add_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
	, const AbstractDumperBase::UserCode& uc
) const {
	//#UC START# *4666BE6D01C5_4571A32201A5*
	//#UC END# *4666BE6D01C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��������������� ��� ���
bool AbstractSingleDumperBase::am_i_registred () const {
	//#UC START# *4665554F00BB_4571A32201A5*
	return true;
	//#UC END# *4665554F00BB_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ����� ������ ���������, ���������� �������� � ���� ����� ������.
// items - ��������� ��������� ��������, ��� ������������ ������������� ����
// diagram_hash - ��� ���������, ������������� �� ������ ���� view - ��������� �� ��������
CxMemFile* AbstractSingleDumperBase::dump_diagram (
	AbstractDumperBase::DiagramItemCollection& items
	, std::string& diagram_hash
) const {
	//#UC START# *4642AC6B0138_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4642AC6B0138_4571A32201A5*
}

// implemented method from AbstractDumperBase
// regular/abstract/final - ��� ������������� ��������.
const std::string AbstractSingleDumperBase::get_abstract_str () const {
	//#UC START# *4666BBA801A5_4571A32201A5*
	return "false";
	//#UC END# *4666BBA801A5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��� �������� ������� ���������� �������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_consumers () const {
	//#UC START# *46663374004E_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46663374004E_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���� ��������� ��������� (����������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_contents () const {
	//#UC START# *4666369E01D4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666369E01D4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ������ ���������,  � ������� ��� ��������� � ������� ���������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_equals_name () const {
	//#UC START# *47A01E5102D1_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *47A01E5102D1_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���� ���������� ��������� (�����) ����������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_all_includes () const {
	//#UC START# *4666371701F4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666371701F4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ������ ����������� �����������
AbstractDumperBase::Selections* AbstractSingleDumperBase::get_applied_gens () const {
	//#UC START# *46678131036B_4571A32201A5*
	return new Selections ();
	//#UC END# *46678131036B_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���� ������������������ ������� �� ��������.
const std::string AbstractSingleDumperBase::get_auto_counter_str () const {
	//#UC START# *4666BCB7033C_4571A32201A5*
	return "";
	//#UC END# *4666BCB7033C_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��� ��������
const std::string AbstractSingleDumperBase::get_class_kind_str () const {
	//#UC START# *465FE63402FD_4571A32201A5*
	return "";
	//#UC END# *465FE63402FD_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ��������� ���������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_contents () const {
	//#UC START# *4666367C01D4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666367C01D4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ���������� �� ��� ������ ������� ���� ��������������
// �����, � ������ "�������" �� ������ ���������. �.�. � ��� �����,
// ������� ���������� ��������� �� �����������
AbstractDumperBase::GenSourceInfoSet* AbstractSingleDumperBase::get_deleted_child_generated_source () const {
	//#UC START# *459D2DD40228_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *459D2DD40228_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ������ ���������, �� ������� ������� ������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_dependences () const {
	//#UC START# *46655D1D03D8_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655D1D03D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ����������� ������� �\��� ��������� (����������� ������ ��������� ������������
// ����������� ������ ����� ������� �������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_derived_impl () const {
	//#UC START# *4666379A0222_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666379A0222_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ������������� ������� �\��� ��������� (������������� ������ ��������� ������������ �����
// ������� �������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_derived_over () const {
	//#UC START# *466637C50399_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466637C50399_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ��������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_diagrams () const {
	//#UC START# *46663777001F_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46663777001F_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��������� ����������� � ��������
const std::string AbstractSingleDumperBase::get_documentation_str () const {
	//#UC START# *4666BA670109_4571A32201A5*
	return "";
	//#UC END# *4666BA670109_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���������, ������� ���������� forward-������������� ��� �������� ��������.
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_forwarded () const {
	//#UC START# *4666357500FA_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666357500FA_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ������� ��������� (�� ������� ����������� �������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_generalizations () const {
	//#UC START# *46655E5B01F4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655E5B01F4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ �������� ������������� �� �������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_generalizator () const {
	//#UC START# *46655DC401C5_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655DC401C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ��������� ���������� ������������ ��� ��������  ��� get-������������ ��� ���������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_get_exceptions () const {
	//#UC START# *466636210271_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466636210271_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� COM GUID
const std::string AbstractSingleDumperBase::get_guid_str () const {
	//#UC START# *4666AA6D02EE_4571A32201A5*
	return "";
	//#UC END# *4666AA6D02EE_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���������� ��������� (�����)
// ���������� ����� ������������ �� ������ ������������ ��������. ���� ������� ��� ��� ���������
// ����� ���������� ���-���� (�����������, ���������, ����� �������� ������� ���� � �.�.) ������
// �������, �� �����, � ������� ���������� ������������ �������, ������� � ������ �����������. ��
// ��������������� ������ ����������� �������� �������� � �������-�������������� (F)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_includes () const {
	//#UC START# *466636DB035B_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466636DB035B_4571A32201A5*
}

// implemented method from AbstractDumperBase
// �������� �� ��������� (��� ��������� � ���������� ��������)
const std::string AbstractSingleDumperBase::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_4571A32201A5*
	return "";
	//#UC END# *4666BA9F03D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ������ ��� ������
const std::string AbstractSingleDumperBase::get_intend_str (short intend_shift) const {
	//#UC START# *4666BAFD038A_4571A32201A5*
	return "";
	//#UC END# *4666BAFD038A_4571A32201A5*
}

// implemented method from AbstractDumperBase
// agr/lnk/ref - ��� ����� ���������, �� ������ � ��������� (Var ��� Box), �� ���������
const std::string AbstractSingleDumperBase::get_link_type_str () const {
	//#UC START# *4666BBD903B9_4571A32201A5*
	return "";
	//#UC END# *4666BBD903B9_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� �����
const std::string AbstractSingleDumperBase::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571A32201A5*
	return "";
	//#UC END# *465EA35D005D_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��������� �� ������ (VCMModule, CORBAInterface::operation, ...)
const AbstractDumperBase::StereotypeID& AbstractSingleDumperBase::get_model_stereotype_str () const {
	//#UC START# *4666AB4D0109_4571A32201A5*
	return AbstractDumperBase::EMPTY_STEREOTYPE_ID;
	//#UC END# *4666AB4D0109_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� GUID ��������
const std::string& AbstractSingleDumperBase::get_model_unique_id_str () const {
	//#UC START# *465E51860213_4571A32201A5*
	return m_model_unique_id;
	//#UC END# *465E51860213_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� native-���� � ��������, ����������� � ����������
const std::string AbstractSingleDumperBase::get_native_path_str () const {
	//#UC START# *4666BD0F01C5_4571A32201A5*
	return "";
	//#UC END# *4666BD0F01C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��� �������� ������� ���������� ��� ����� �������-�������������� ������ (����������) � �����
// ������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_botom_consumers () const {
	//#UC START# *4666333A0261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666333A0261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���� (����������) ������� ��������� (�� ������� ����������� �������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_generalizations () const {
	//#UC START# *46655EC401E4_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655EC401E4_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���� (����������) ����������� ��������� (������� ��������� �������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_realizations () const {
	//#UC START# *46655ED0006D_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655ED0006D_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��� �������� ������� ������������ ��� ����� �������-�������������� ������ (����������) � �����
// ������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nested_top_suppliers () const {
	//#UC START# *466635470186_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635470186_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ������ ����������� ��������/��������� ������� ��� ����������� �������, ������� ��
// ��������� ������ �������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_not_implemented_derived_abstract () const {
	//#UC START# *4B5EE7570302_4571A32201A5*
	return new ADList ();
	//#UC END# *4B5EE7570302_4571A32201A5*
}

// implemented method from AbstractDumperBase
// �� �� ��� � Forwarded �� ��� ���������� ��������� ��������������� ���� � �������������� (�
// ������� ������) ���������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nsf_forwarded () const {
	//#UC START# *466635AB02AF_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635AB02AF_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ���������� ��������� (�����), �� ����������� ��� ������� ��������������� �������� ���
// ����� ������ ������� ���������� (W). ����� ����, � ����� ��������� �� ������� �������� ������, �
// ������ ��������, �� �������� (����������) ������� �������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_nsf_includes () const {
	//#UC START# *466637380203_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466637380203_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ID �������� � ����������
const std::string AbstractSingleDumperBase::get_page_id () const {
	//#UC START# *4639BED10119_4571A32201A5*
	return "";
	//#UC END# *4639BED10119_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ���� ��������, ����������� � ��������� ��������
const std::string AbstractSingleDumperBase::get_page_path () const {
	//#UC START# *4640808A0119_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4640808A0119_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ������������ ���������
// ������ ��������� � ������� �������� ��������� ��������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_parents () const {
	//#UC START# *466636560261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466636560261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ����������� ��������� (������� ��������� �������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_realizations () const {
	//#UC START# *46655E930261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655E930261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ �������� ����������� ������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_realizator () const {
	//#UC START# *46655DAA008C_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655DAA008C_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ �������� ������������� �� ������� (����������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_req_generalizator () const {
	//#UC START# *46655E0C0242_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655E0C0242_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ �������� ����������� ������ (����������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_req_realizator () const {
	//#UC START# *46655DF500AB_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655DF500AB_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��� �������� ������� ���������� ������� (����������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_requrcive_all_consumers () const {
	//#UC START# *466635050213_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635050213_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ���������� ������ ���������, �� ������� ������� ������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_reqursive_dependences () const {
	//#UC START# *46655D480261_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46655D480261_4571A32201A5*
}

// implemented method from AbstractDumperBase
// �������� ������� ����������� ��� ���������
const std::string AbstractSingleDumperBase::get_root_dir (bool direct_get) const {
	//#UC START# *4666BC450203_4571A32201A5*
	return "";
	//#UC END# *4666BC450203_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ���������� � ����� ��������������� �����
AbstractDumperBase::GenSourceInfo* AbstractSingleDumperBase::get_self_generated_source () const {
	//#UC START# *459D2DA9011E_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *459D2DA9011E_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ��������� ������������������ ������� (��� ��������)
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_sequences () const {
	//#UC START# *466635D401C5_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *466635D401C5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ��������� ���������� set-������������ ��� ���������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_set_exceptions () const {
	//#UC START# *4666362C01A5_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *4666362C01A5_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ �������� ������������ ������ � �������� ����� ���������
AbstractDumperBase::ADList* AbstractSingleDumperBase::get_source () const {
	//#UC START# *46663318034B_4571A32201A5*
	ADList* ret = new ADList ();
	return ret;
	//#UC END# *46663318034B_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ��������� ��������
const std::string AbstractSingleDumperBase::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4571A32201A5*
	return "";
	//#UC END# *465FE0B403D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ����
AbstractDumperBase* AbstractSingleDumperBase::get_target () const {
	//#UC START# *466554FF030D_4571A32201A5*
	return NULL;
	//#UC END# *466554FF030D_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ��������� ����� (const, var, ...)
const std::string AbstractSingleDumperBase::get_target_stereotype_str () const {
	//#UC START# *4666BCE003D8_4571A32201A5*
	return "";
	//#UC END# *4666BCE003D8_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� "true", ���� ������� �������������� �������
const std::string AbstractSingleDumperBase::get_type_fixed_size_str () const {
	//#UC START# *4666BB64029F_4571A32201A5*
	return "";
	//#UC END# *4666BB64029F_4571A32201A5*
}

// implemented method from AbstractDumperBase
// �������� ���� ������
const AbstractDumperBase::UserCode AbstractSingleDumperBase::get_user_code (
	const AbstractDumperBase::GenID& gen_id
	, const AbstractDumperBase::UserCodeId& uc_id
) const {
	//#UC START# *4666BEAB0138_4571A32201A5*
	return "";
	//#UC END# *4666BEAB0138_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������� �������� ����������������� �������� �prop_name�
const std::string AbstractSingleDumperBase::get_user_property_str (const std::string& prop_name) const {
	//#UC START# *4666BC09003E_4571A32201A5*
	return "";
	//#UC END# *4666BC09003E_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������ ������������ ��������� ��������.
// ����� ��������� ��������: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
const std::string AbstractSingleDumperBase::get_visability_str () const {
	//#UC START# *4666BAC60177_4571A32201A5*
	return "";
	//#UC END# *4666BAC60177_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ����� �� ������������������� ��������
bool AbstractSingleDumperBase::has_registred_parent () const {
	//#UC START# *466555EA009C_4571A32201A5*
	return false;
	//#UC END# *466555EA009C_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ����� �� ������� ����������� ����� ������
bool AbstractSingleDumperBase::own_output () const {
	//#UC START# *4666BD680128_4571A32201A5*
	return false;
	//#UC END# *4666BD680128_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� ��������
AbstractDumperBase* AbstractSingleDumperBase::parent () const {
	//#UC START# *4665549F0251_4571A32201A5*
	return NULL;
	//#UC END# *4665549F0251_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ������� �� ������ ���������� �� ����� ��������������� ��������� ���������, ���������� true �
// ������ ������.
bool AbstractSingleDumperBase::remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5AE03B9_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45C9F5AE03B9_4571A32201A5*
}

// implemented method from AbstractDumperBase
// ���������� �� ������ ���������� � ��������������� �����, ���������� true � ������ ������.
bool AbstractSingleDumperBase::set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const {
	//#UC START# *45C9F5490109_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45C9F5490109_4571A32201A5*
}

// implemented method from Base::NamedElement
// ���������� ������ ��� ��������
const std::string AbstractSingleDumperBase::get_full_name () const {
	//#UC START# *4AF93E9E0166_4571A32201A5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4AF93E9E0166_4571A32201A5*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

