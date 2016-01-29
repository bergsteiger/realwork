////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSingleDumperBase
//
// ������� ����� ��� "������" �������� - ��� ������� ����������� ������� ������, � �� ���������� ��.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSINGLEDUMPERBASE_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSINGLEDUMPERBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

//#UC START# *4571A32201A5_CUSTOM_INCLUDES*
//#UC END# *4571A32201A5_CUSTOM_INCLUDES*


// ������� ����� ��� "������" �������� - ��� ������� ����������� ������� ������, � �� ���������� ��.
class AbstractSingleDumperBase;
typedef Core::Var<AbstractSingleDumperBase> AbstractSingleDumperBase_var;
typedef Core::Var<const AbstractSingleDumperBase> AbstractSingleDumperBase_cvar;

class AbstractSingleDumperBase :
	virtual public AbstractDumperBase
{
	SET_OBJECT_COUNTER (AbstractSingleDumperBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractSingleDumperBase ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ��������� ���� ������
	virtual void add_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
		, const AbstractDumperBase::UserCode& uc
	) const;

	// implemented method from AbstractDumperBase
	// ��������������� ��� ���
	virtual bool am_i_registred () const;

	// implemented method from AbstractDumperBase
	// ����� ������ ���������, ���������� �������� � ���� ����� ������.
	// items - ��������� ��������� ��������, ��� ������������ ������������� ����
	// diagram_hash - ��� ���������, ������������� �� ������ ���� view - ��������� �� ��������
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// implemented method from AbstractDumperBase
	// regular/abstract/final - ��� ������������� ��������.
	virtual const std::string get_abstract_str () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ���������� �������
	virtual AbstractDumperBase::ADList* get_all_consumers () const;

	// implemented method from AbstractDumperBase
	// ������ ���� ��������� ��������� (����������)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ���������,  � ������� ��� ��������� � ������� ���������
	virtual AbstractDumperBase::ADList* get_all_equals_name () const;

	// implemented method from AbstractDumperBase
	// ������ ���� ���������� ��������� (�����) ����������
	virtual AbstractDumperBase::ADList* get_all_includes () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ����������� �����������
	virtual AbstractDumperBase::Selections* get_applied_gens () const;

	// implemented method from AbstractDumperBase
	// ���� ������������������ ������� �� ��������.
	virtual const std::string get_auto_counter_str () const;

	// implemented method from AbstractDumperBase
	// ��� ��������
	virtual const std::string get_class_kind_str () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ���������
	virtual AbstractDumperBase::ADList* get_contents () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ���������, �� ������� ������� ������
	virtual AbstractDumperBase::ADList* get_dependences () const;

	// implemented method from AbstractDumperBase
	// ������ ����������� ������� �\��� ��������� (����������� ������ ��������� ������������
	// ����������� ������ ����� ������� �������)
	virtual AbstractDumperBase::ADList* get_derived_impl () const;

	// implemented method from AbstractDumperBase
	// ������ ������������� ������� �\��� ��������� (������������� ������ ��������� ������������ �����
	// ������� �������)
	virtual AbstractDumperBase::ADList* get_derived_over () const;

	// implemented method from AbstractDumperBase
	// ������ ��������
	virtual AbstractDumperBase::ADList* get_diagrams () const;

	// implemented method from AbstractDumperBase
	// ��������� ����������� � ��������
	virtual const std::string get_documentation_str () const;

	// implemented method from AbstractDumperBase
	// ������ ���������, ������� ���������� forward-������������� ��� �������� ��������.
	virtual AbstractDumperBase::ADList* get_forwarded () const;

	// implemented method from AbstractDumperBase
	// ������ ������� ��������� (�� ������� ����������� �������)
	virtual AbstractDumperBase::ADList* get_generalizations () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ������������� �� �������
	virtual AbstractDumperBase::ADList* get_generalizator () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ���������� ������������ ��� ��������  ��� get-������������ ��� ���������
	virtual AbstractDumperBase::ADList* get_get_exceptions () const;

	// implemented method from AbstractDumperBase
	// ���������� COM GUID
	virtual const std::string get_guid_str () const;

	// implemented method from AbstractDumperBase
	// ������ ���������� ��������� (�����)
	// ���������� ����� ������������ �� ������ ������������ ��������. ���� ������� ��� ��� ���������
	// ����� ���������� ���-���� (�����������, ���������, ����� �������� ������� ���� � �.�.) ������
	// �������, �� �����, � ������� ���������� ������������ �������, ������� � ������ �����������. ��
	// ��������������� ������ ����������� �������� �������� � �������-�������������� (F)
	virtual AbstractDumperBase::ADList* get_includes () const;

	// implemented method from AbstractDumperBase
	// �������� �� ��������� (��� ��������� � ���������� ��������)
	virtual const std::string get_initial_value_str () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ��� ������
	virtual const std::string get_intend_str (short intend_shift) const;

	// implemented method from AbstractDumperBase
	// agr/lnk/ref - ��� ����� ���������, �� ������ � ��������� (Var ��� Box), �� ���������
	virtual const std::string get_link_type_str () const;

	// implemented method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;

	// implemented method from AbstractDumperBase
	// ��������� �� ������ (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// ���������� GUID ��������
	virtual const std::string& get_model_unique_id_str () const;

	// implemented method from AbstractDumperBase
	// ���������� native-���� � ��������, ����������� � ����������
	virtual const std::string get_native_path_str () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ���������� ��� ����� �������-�������������� ������ (����������) � �����
	// ������
	virtual AbstractDumperBase::ADList* get_nested_botom_consumers () const;

	// implemented method from AbstractDumperBase
	// ������ ���� (����������) ������� ��������� (�� ������� ����������� �������)
	virtual AbstractDumperBase::ADList* get_nested_generalizations () const;

	// implemented method from AbstractDumperBase
	// ������ ���� (����������) ����������� ��������� (������� ��������� �������)
	virtual AbstractDumperBase::ADList* get_nested_realizations () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ������������ ��� ����� �������-�������������� ������ (����������) � �����
	// ������
	virtual AbstractDumperBase::ADList* get_nested_top_suppliers () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ����������� ��������/��������� ������� ��� ����������� �������, ������� ��
	// ��������� ������ �������
	virtual AbstractDumperBase::ADList* get_not_implemented_derived_abstract () const;

	// implemented method from AbstractDumperBase
	// �� �� ��� � Forwarded �� ��� ���������� ��������� ��������������� ���� � �������������� (�
	// ������� ������) ���������
	virtual AbstractDumperBase::ADList* get_nsf_forwarded () const;

	// implemented method from AbstractDumperBase
	// ������ ���������� ��������� (�����), �� ����������� ��� ������� ��������������� �������� ���
	// ����� ������ ������� ���������� (W). ����� ����, � ����� ��������� �� ������� �������� ������,
	// � ������ ��������, �� �������� (����������) ������� �������
	virtual AbstractDumperBase::ADList* get_nsf_includes () const;

	// implemented method from AbstractDumperBase
	// ���������� ID �������� � ����������
	virtual const std::string get_page_id () const;

	// implemented method from AbstractDumperBase
	// ���������� ���� ��������, ����������� � ��������� ��������
	virtual const std::string get_page_path () const;

	// implemented method from AbstractDumperBase
	// ������ ������������ ���������
	// ������ ��������� � ������� �������� ��������� ��������
	virtual AbstractDumperBase::ADList* get_parents () const;

	// implemented method from AbstractDumperBase
	// ������ ����������� ��������� (������� ��������� �������)
	virtual AbstractDumperBase::ADList* get_realizations () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ����������� ������
	virtual AbstractDumperBase::ADList* get_realizator () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ������������� �� ������� (����������)
	virtual AbstractDumperBase::ADList* get_req_generalizator () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ����������� ������ (����������)
	virtual AbstractDumperBase::ADList* get_req_realizator () const;

	// implemented method from AbstractDumperBase
	// ��� �������� ������� ���������� ������� (����������)
	virtual AbstractDumperBase::ADList* get_requrcive_all_consumers () const;

	// implemented method from AbstractDumperBase
	// ���������� ���������� ������ ���������, �� ������� ������� ������
	virtual AbstractDumperBase::ADList* get_reqursive_dependences () const;

	// implemented method from AbstractDumperBase
	// �������� ������� ����������� ��� ���������
	virtual const std::string get_root_dir (bool direct_get) const;

	// implemented method from AbstractDumperBase
	// ���������� ���������� � ����� ��������������� �����
	virtual AbstractDumperBase::GenSourceInfo* get_self_generated_source () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ������������������ ������� (��� ��������)
	virtual AbstractDumperBase::ADList* get_sequences () const;

	// implemented method from AbstractDumperBase
	// ������ ��������� ���������� set-������������ ��� ���������
	virtual AbstractDumperBase::ADList* get_set_exceptions () const;

	// implemented method from AbstractDumperBase
	// ������ �������� ������������ ������ � �������� ����� ���������
	virtual AbstractDumperBase::ADList* get_source () const;

	// implemented method from AbstractDumperBase
	// ���������� ��������� ��������
	virtual const std::string get_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// ���������� ����
	virtual AbstractDumperBase* get_target () const;

	// implemented method from AbstractDumperBase
	// ��������� ����� (const, var, ...)
	virtual const std::string get_target_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// ���������� "true", ���� ������� �������������� �������
	virtual const std::string get_type_fixed_size_str () const;

	// implemented method from AbstractDumperBase
	// �������� ���� ������
	virtual const AbstractDumperBase::UserCode get_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
	) const;

	// implemented method from AbstractDumperBase
	// ������� �������� ����������������� �������� �prop_name�
	virtual const std::string get_user_property_str (const std::string& prop_name) const;

	// implemented method from AbstractDumperBase
	// ������ ������������ ��������� ��������.
	// ����� ��������� ��������: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
	virtual const std::string get_visability_str () const;

	// implemented method from AbstractDumperBase
	// ����� �� ������������������� ��������
	virtual bool has_registred_parent () const;

	// implemented method from AbstractDumperBase
	// ���������� ����� �� ������� ����������� ����� ������
	virtual bool own_output () const;

	// implemented method from AbstractDumperBase
	// ���������� ��������
	virtual AbstractDumperBase* parent () const;

	// implemented method from AbstractDumperBase
	// ������� �� ������ ���������� �� ����� ��������������� ��������� ���������, ���������� true �
	// ������ ������.
	virtual bool remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// implemented method from AbstractDumperBase
	// ���������� �� ������ ���������� � ��������������� �����, ���������� true � ������ ������.
	virtual bool set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;
protected:

	// implemented method from AbstractDumperBase
	// ���������� ���������� �� ��� ������ ������� ���� ��������������
	// �����, � ������ "�������" �� ������ ���������. �.�. � ��� �����,
	// ������� ���������� ��������� �� �����������
	virtual AbstractDumperBase::GenSourceInfoSet* get_deleted_child_generated_source () const;

	// implemented method from Base::NamedElement
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const;

//#UC START# *4571A32201A5*
protected:	
	virtual ADList* get_scopes(const AbstractDumperBase* main_scope) const;	
	virtual std::ostream* get_output () const;

protected:
	mutable std::string m_model_unique_id;
//#UC END# *4571A32201A5*
}; // class AbstractSingleDumperBase



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSINGLEDUMPERBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

