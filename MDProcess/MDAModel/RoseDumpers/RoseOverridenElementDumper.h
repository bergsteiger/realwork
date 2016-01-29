////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseOverridenElementDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseOverridenElementDumper
//
// ������ ��� ����������������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEOVERRIDENELEMENTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEOVERRIDENELEMENTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"


// ������ ��� ����������������� ��������
class RoseOverridenElementDumper;
typedef Core::Var<RoseOverridenElementDumper> RoseOverridenElementDumper_var;
typedef Core::Var<const RoseOverridenElementDumper> RoseOverridenElementDumper_cvar;

class RoseOverridenElementDumper :
	virtual public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseOverridenElementDumper)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���� ��������
	static const std::string OWNER_VAR_ID; // ������������� ����������, ������������ ��������� ����������������� �������� (�������� - �������, ������� ��������� ��������������/��������� ���� �������)

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ������� ������� �� ������ ��������� ������� ������������ ��������� ����������������� ��������
	RoseOverridenElementDumper (
		const RoseAbstractDumper* from
		, const InheritedItem* state
		, const RoseAbstractDumper* owner
	);

public:
	virtual ~RoseOverridenElementDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void update (const RoseAbstractDumper* from, const InheritedItem* state);

private:
	virtual RoseAbstractDumper* get_wrapped_object ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������, ��� ������� �������
	RoseAbstractDumper* m_wrapped_object;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	virtual const RoseAbstractDumper* get_wrapped_object () const;

	virtual void set_wrapped_object (RoseAbstractDumper* wrapped_object);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumper
	// ���������� true, ���� ������������� ���������� ��������� ��������� ��������, ����� false
	virtual bool check_stereotype_use () const;

	// overloaded method from AbstractDumper
	// �������� ���������, �� ������� ����
	virtual void dump_start () const;

	// overloaded method from AbstractDumper
	// ��������� ��� ������ ������� �� ������� ����������� ����
	virtual void prepare_output_cache () const;

	// overloaded method from AbstractDumperBase
	// ��������� ���� ������
	virtual void add_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
		, const AbstractDumperBase::UserCode& uc
	) const;

	// overloaded method from AbstractDumperBase
	// ��������������� ��� ���
	virtual bool am_i_registred () const;

	// overloaded method from AbstractDumperBase
	// ������� ������ ��������� ���������
	virtual void clear_var_dumpers (AbstractDumperBase::LocalVarType type) const;

	// overloaded method from AbstractDumperBase
	// ����� ������ ���������, ���������� �������� � ���� ����� ������.
	// items - ��������� ��������� ��������, ��� ������������ ������������� ����
	// diagram_hash - ��� ���������, ������������� �� ������ ���� view - ��������� �� ��������
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// overloaded method from AbstractDumperBase
	// ���������� ����� �������� (��������������� ���� ��� ��� ���������� ������ ��������� � ��������
	// � ������)
	virtual unsigned long long elem_creation_order () const;

	// overloaded method from AbstractDumperBase
	// ���������� ����� �������� (��������������� ��� ���������� ������ ���������)
	virtual unsigned int elem_order () const;

	// overloaded method from AbstractDumperBase
	// regular/abstract/final - ��� ������������� ��������.
	virtual const std::string get_abstract_str () const;

	// overloaded method from AbstractDumperBase
	// ��� �������� ������� ���������� �������
	virtual AbstractDumperBase::ADList* get_all_consumers () const;

	// overloaded method from AbstractDumperBase
	// ������ ���� ��������� ��������� (����������)
	virtual AbstractDumperBase::ADList* get_all_contents () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ���������,  � ������� ��� ��������� � ������� ���������
	virtual AbstractDumperBase::ADList* get_all_equals_name () const;

	// overloaded method from AbstractDumperBase
	// ������ ���� ���������� ��������� (�����) ����������
	virtual AbstractDumperBase::ADList* get_all_includes () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ����������� �����������
	virtual AbstractDumperBase::Selections* get_applied_gens () const;

	// overloaded method from AbstractDumperBase
	// ���� ������������������ ������� �� ��������.
	virtual const std::string get_auto_counter_str () const;

	// overloaded method from AbstractDumperBase
	// ��� ��������
	virtual const std::string get_class_kind_str () const;

	// overloaded method from AbstractDumperBase
	// ������ ��������� ���������
	virtual AbstractDumperBase::ADList* get_contents () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ���������, �� ������� ������� ������
	virtual AbstractDumperBase::ADList* get_dependences () const;

	// overloaded method from AbstractDumperBase
	// ������ ����������� ������� �\��� ��������� (����������� ������ ��������� ������������
	// ����������� ������ ����� ������� �������)
	virtual AbstractDumperBase::ADList* get_derived_impl () const;

	// overloaded method from AbstractDumperBase
	// ������ ������������� ������� �\��� ��������� (������������� ������ ��������� ������������ �����
	// ������� �������)
	virtual AbstractDumperBase::ADList* get_derived_over () const;

	// overloaded method from AbstractDumperBase
	// ������ ��������
	virtual AbstractDumperBase::ADList* get_diagrams () const;

	// overloaded method from AbstractDumperBase
	// ��������� ����������� � ��������
	virtual const std::string get_documentation_str () const;

	// overloaded method from AbstractDumperBase
	// ������ ���������, ������� ���������� forward-������������� ��� �������� ��������.
	virtual AbstractDumperBase::ADList* get_forwarded () const;

	// overloaded method from AbstractDumperBase
	// ������ ������� ��������� (�� ������� ����������� �������)
	virtual AbstractDumperBase::ADList* get_generalizations () const;

	// overloaded method from AbstractDumperBase
	// ������ �������� ������������� �� �������
	virtual AbstractDumperBase::ADList* get_generalizator () const;

	// overloaded method from AbstractDumperBase
	// ������ ��������� ���������� ������������ ��� ��������  ��� get-������������ ��� ���������
	virtual AbstractDumperBase::ADList* get_get_exceptions () const;

	// overloaded method from AbstractDumperBase
	// ���������� COM GUID
	virtual const std::string get_guid_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��� ����� � ������������, ���������� � ���������
	virtual const std::string get_image_file () const;

	// overloaded method from AbstractDumperBase
	// ������ ���������� ��������� (�����)
	// ���������� ����� ������������ �� ������ ������������ ��������. ���� ������� ��� ��� ���������
	// ����� ���������� ���-���� (�����������, ���������, ����� �������� ������� ���� � �.�.) ������
	// �������, �� �����, � ������� ���������� ������������ �������, ������� � ������ �����������. ��
	// ��������������� ������ ����������� �������� �������� � �������-�������������� (F)
	virtual AbstractDumperBase::ADList* get_includes () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ��� ������ �������� ��-���������
	virtual AbstractDumperBase* get_initial_value () const;

	// overloaded method from AbstractDumperBase
	// �������� �� ��������� (��� ��������� � ���������� ��������)
	virtual const std::string get_initial_value_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ��� ������
	virtual const std::string get_intend_str (short intend_shift) const;

	// overloaded method from AbstractDumperBase
	// ���������� ����, ������� ������������ ��� �������� ������������� ���� ���������
	virtual const std::string get_link_guid () const;

	// overloaded method from AbstractDumperBase
	// agr/lnk/ref - ��� ����� ���������, �� ������ � ��������� (Var ��� Box), �� ���������
	virtual const std::string get_link_type_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���� �������
	virtual AbstractDumperBase* get_main_element () const;

	// overloaded method from AbstractDumperBase
	// ��������� �� ������ (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� GUID ��������
	virtual const std::string& get_model_unique_id_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���
	virtual const std::string get_name_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� native-���� � ��������, ����������� � ����������
	virtual const std::string get_native_path_str () const;

	// overloaded method from AbstractDumperBase
	// ��� �������� ������� ���������� ��� ����� �������-�������������� ������ (����������) � �����
	// ������
	virtual AbstractDumperBase::ADList* get_nested_botom_consumers () const;

	// overloaded method from AbstractDumperBase
	// ������ ���� (����������) ������� ��������� (�� ������� ����������� �������)
	virtual AbstractDumperBase::ADList* get_nested_generalizations () const;

	// overloaded method from AbstractDumperBase
	// ������ ���� (����������) ����������� ��������� (������� ��������� �������)
	virtual AbstractDumperBase::ADList* get_nested_realizations () const;

	// overloaded method from AbstractDumperBase
	// ��� �������� ������� ������������ ��� ����� �������-�������������� ������ (����������) � �����
	// ������
	virtual AbstractDumperBase::ADList* get_nested_top_suppliers () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ����������� ��������/��������� ������� ��� ����������� �������, ������� ��
	// ��������� ������ �������
	virtual AbstractDumperBase::ADList* get_not_implemented_derived_abstract () const;

	// overloaded method from AbstractDumperBase
	// �� �� ��� � Forwarded �� ��� ���������� ��������� ��������������� ���� � �������������� (�
	// ������� ������) ���������
	virtual AbstractDumperBase::ADList* get_nsf_forwarded () const;

	// overloaded method from AbstractDumperBase
	// ������ ���������� ��������� (�����), �� ����������� ��� ������� ��������������� �������� ���
	// ����� ������ ������� ���������� (W). ����� ����, � ����� ��������� �� ������� �������� ������,
	// � ������ ��������, �� �������� (����������) ������� �������
	virtual AbstractDumperBase::ADList* get_nsf_includes () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���������, � ������� ������ ��������� ����
	virtual GCL::code_t get_output_coding () const;

	// overloaded method from AbstractDumperBase
	// ���������� ID �������� � ����������
	virtual const std::string get_page_id () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���� ��������, ����������� � ��������� ��������
	virtual const std::string get_page_path () const;

	// overloaded method from AbstractDumperBase
	// ������ ������������ ���������
	// ������ ��������� � ������� �������� ��������� ��������
	virtual AbstractDumperBase::ADList* get_parents () const;

	// overloaded method from AbstractDumperBase
	// ������ ����������� ��������� (������� ��������� �������)
	virtual AbstractDumperBase::ADList* get_realizations () const;

	// overloaded method from AbstractDumperBase
	// ������ �������� ����������� ������
	virtual AbstractDumperBase::ADList* get_realizator () const;

	// overloaded method from AbstractDumperBase
	// ������ �������� ������������� �� ������� (����������)
	virtual AbstractDumperBase::ADList* get_req_generalizator () const;

	// overloaded method from AbstractDumperBase
	// ������ �������� ����������� ������ (����������)
	virtual AbstractDumperBase::ADList* get_req_realizator () const;

	// overloaded method from AbstractDumperBase
	// ��� �������� ������� ���������� ������� (����������)
	virtual AbstractDumperBase::ADList* get_requrcive_all_consumers () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���������� ������ ���������, �� ������� ������� ������
	virtual AbstractDumperBase::ADList* get_reqursive_dependences () const;

	// overloaded method from AbstractDumperBase
	// �������� ������� ����������� ��� ���������
	virtual const std::string get_root_dir (bool direct_get) const;

	// overloaded method from AbstractDumperBase
	// ���������� ���������� � ����� ��������������� �����
	virtual AbstractDumperBase::GenSourceInfo* get_self_generated_source () const;

	// overloaded method from AbstractDumperBase
	// ������ ��������� ������������������ ������� (��� ��������)
	virtual AbstractDumperBase::ADList* get_sequences () const;

	// overloaded method from AbstractDumperBase
	// ������ ��������� ���������� set-������������ ��� ���������
	virtual AbstractDumperBase::ADList* get_set_exceptions () const;

	// overloaded method from AbstractDumperBase
	// ������ �������� ������������ ������ � �������� ����� ���������
	virtual AbstractDumperBase::ADList* get_source () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��� ���������������� ���������
	virtual AbstractDumperBase::GenSourceType get_source_type () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��������� ��������
	virtual const std::string get_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ����
	virtual AbstractDumperBase* get_target () const;

	// overloaded method from AbstractDumperBase
	// ��������� ����� (const, var, ...)
	virtual const std::string get_target_stereotype_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� "true", ���� ������� �������������� �������
	virtual const std::string get_type_fixed_size_str () const;

	// overloaded method from AbstractDumperBase
	// �������� ���� ������
	virtual const AbstractDumperBase::UserCode get_user_code (
		const AbstractDumperBase::GenID& gen_id
		, const AbstractDumperBase::UserCodeId& uc_id
	) const;

	// overloaded method from AbstractDumperBase
	// ������� �������� ����������������� �������� �prop_name�
	virtual const std::string get_user_property_str (const std::string& prop_name) const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ �� id-�����, ��������� � ���������
	virtual const AbstractDumperBase* get_var_dumper (const std::string& var_id) const;

	// overloaded method from AbstractDumperBase
	// ������ ������������ ��������� ��������.
	// ����� ��������� ��������: PublicAccess, PrivateAccess, ProtectedAccess, ImplementationAccess)
	virtual const std::string get_visability_str () const;

	// overloaded method from AbstractDumperBase
	// ����� �� ������������������� ��������
	virtual bool has_registred_parent () const;

	// overloaded method from AbstractDumperBase
	// ���������� true, ���� ������� ��� ������ (������������ �� ����������� ����, ��� ��������� ����
	// ��������)
	virtual bool is_changed () const;

	// overloaded method from AbstractDumperBase
	// ���������� true, ���� �������� ��� �������� ����� ���� Home - ���������, ����� - false
	virtual bool is_home () const;

	// overloaded method from AbstractDumperBase
	// ���������� ����� �� ������� ����������� ����� ������
	virtual bool own_output () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��������
	virtual AbstractDumperBase* parent () const;

	// overloaded method from AbstractDumperBase
	// ������� �� ������ ���������� �� ����� ��������������� ��������� ���������, ���������� true �
	// ������ ������.
	virtual bool remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// overloaded method from AbstractDumperBase
	// ���������� ���������� �� �����������
	virtual void reset_changed () const;

	// overloaded method from AbstractDumperBase
	// �������� ������� ���������� ����������� �����
	virtual void run_post_command () const;

	// overloaded method from AbstractDumperBase
	// ���������� �� ������ ���������� � ��������������� �����, ���������� true � ������ ������.
	virtual bool set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// overloaded method from AbstractDumperBase
	// ������������� ������ �� id-�����, ��������� � ���������
	virtual void set_var_dumper (const std::string& var_id, const AbstractDumperBase* dumper) const;

	// overloaded method from AbstractDumperBase
	// ����������� ������ � �������
	virtual void write_template_error_log (const char* log) const;

	// overloaded method from AbstractDumperBase
	// ����������� ��������������
	virtual void write_template_warning_log (const char* log) const;

	// overloaded method from AbstractLogger
	// ����� ��� ����������� ������
	virtual void write_error_log (const std::string& mess, bool fatal) const;

	// overloaded method from AbstractLogger
	// ����������� �������������� ���������
	virtual void write_info_log (const std::string& mess) const;

	// overloaded method from AbstractLogger
	// ����������� ��������������
	virtual void write_warning_log (const std::string& mess) const;

	// overloaded method from ObjectTreeResolver
	// ���������� ������ ��������� �� ������� ������� ������, ������ ��� ����������
	virtual void collect_suppliers_by_type (
		ObjectTreeResolver::SupplierType type
		, ObjectTreeResolver::OTRVector& collection
	) const;

	// overloaded method from ObjectTreeResolver
	// ���������� ��������� ������ ��������� �� ������� ������� ������, ������ ��� ����������
	virtual void collect_suppliers_by_type_recursive (
		ObjectTreeResolver::SupplierType type
		, ObjectTreeResolver::OTRVector& collection
	) const;

	// overloaded method from ObjectTreeResolver
	// ������������ ��������� ������
	virtual int compare (const ObjectTreeResolver* od) const;

	// overloaded method from ObjectTreeResolver
	// ���������� true, ���� ������� ����� �� ������ ����� ������, �������� ����� � ���������� ������
	virtual bool is_global_visible () const;

	// overloaded method from ObjectTreeResolver
	// �������� �� obj supplier'�� � �������� �����������
	virtual bool is_supplier_with_stereotype (const ObjectTreeResolver* obj, const std::string& stereotype) const;

	// overloaded method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();

	// overloaded method from ObjectTreeResolver
	// ��������� ����� ��������� ���� � ��������� ����������
	virtual void remove_supplier (
		const ObjectTreeResolver* supplier
		, ObjectTreeResolver::SupplierType type
		, const std::string& stereotype
	);

	// overloaded method from ObjectTreeResolver
	// �������� ����������� ������ ����� ���������� ��������� source � target
	virtual void set_dependencies (
		const ObjectTreeResolver* target
		, const ObjectTreeResolver::AddDependencyFunctor& add_dep
	) const;

	// overloaded method from RoseAbstractDumper
	// �������� ��������� �������� � ��������� ��������
	virtual void copy_temporary_properties_from (const RoseAbstractDumper* rad);

	// overloaded method from RoseAbstractDumper
	// ���������� �������� �������� - ������� ���� �� ��������� ���������, � ����� � ������
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name) const;

	// overloaded method from RoseAbstractDumper
	// ���������� �������������� model stereotype
	virtual void reset_model_stereotype ();

	// overloaded method from RoseAbstractDumper
	// �������� �������� �� ��������� ���������
	virtual bool set_temporary_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	) const;

	// overloaded method from RoseAbstractDumper
	// ����� ����������, ����� ����� ��������, �������������� �� ������� �������� ���������
	virtual void update_cached_attrs () const;
protected:

	// overloaded method from AbstractDumper
	// ���������� �������� �������� �� �����
	virtual void delete_from_cache () const;

	// overloaded method from AbstractDumper
	// ����� ���������� �� ������ �������� ����� �������� �����)
	virtual void spell_generation_prepare ();

	// overloaded method from AbstractDumperBase
	// �������� ������� ��� ����������� dump'�
	virtual void add_dumper_for_delay_dump (const AbstractDumperBase* adb) const;

	// overloaded method from AbstractDumperBase
	// ���������� true, ���� ������� ����� "�������"
	virtual bool can_dump () const;

	// overloaded method from AbstractDumperBase
	// ���������� ���������� �� ��� ������ ������� ���� ��������������
	// �����, � ������ "�������" �� ������ ���������. �.�. � ��� �����,
	// ������� ���������� ��������� �� �����������
	virtual AbstractDumperBase::GenSourceInfoSet* get_deleted_child_generated_source () const;

	// overloaded method from AbstractDumperBase
	// ���������� ������ ������� (�����) ��������������� ����������
	virtual GCL::StrSet* get_labels () const;

	// overloaded method from Base::NamedElement
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const;

	// overloaded method from ObjectTreeResolver
	// ������� ��������� �����, ���� -1 - ������ ������� �� �����
	virtual int get_childs_visibility_level () const;

	// overloaded method from ObjectTreeResolver
	// ���������� ��� ������� ����������
	virtual long get_fwd_weight () const;

	// overloaded method from ObjectTreeResolver
	// ���������� true, ���� ������� ������ ������� �������������
	virtual bool is_forbiden_forward_dcl () const;

	// overloaded method from ObjectTreeResolver
	// ����������� �� �������� � ������� �������� (� ������� �������� �� ������) - ����� �������� ��
	// ����� �������� � ����.
	virtual bool sort_in_model_order () const;
private:

	// overloaded method from AbstractDumper
	// ��������� �������� ����� � "��������" �������� ���� �� ������� ������� (�.� � ����� ������
	// ����� ��������� �����)
	virtual void close_output (std::ofstream& file) const;

	// overloaded method from AbstractDumper
	// ����-��������� ���������������� �����:
	// �������� ������ �������� ������ (���� ��� ����������) �� ���, ��� �������� � �������
	// ����������. file_path - ���� � �����, � ������� ����� �������� ���������, ����� ��������� ����
	// � ������ ���������
	virtual void file_post_process (const std::string& file_path) const;

	// overloaded method from ObjectTreeResolver
	// C������� ��������� ������������ - ���� � ������ ���������� ����� ��������, �� ���������, ����
	// ������� - ������� �������� �������� �� ���� � ��� ����� �������� �������� �������, �.� ��� ���-
	// �� ����� ���� ��������� ����� � ��� �������
	virtual bool is_global_locally () const;

}; // class RoseOverridenElementDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEOVERRIDENELEMENTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

