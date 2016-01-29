////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDumper
//
// ������� ������ ��� ���� ��������� ������ ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/Core/data/unsorted_containers.h"
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/Base/Base.h"

//#UC START# *4571D1A5009C_CUSTOM_INCLUDES*
//#UC END# *4571D1A5009C_CUSTOM_INCLUDES*

// forward decls for defined friends
	class RoseOverridenElementDumper;



class RoseOverridenElementDumper;
// ������� ������ ��� ���� ��������� ������ ����
class RoseAbstractDumper;
typedef Core::Var<RoseAbstractDumper> RoseAbstractDumper_var;
typedef Core::Var<const RoseAbstractDumper> RoseAbstractDumper_cvar;

class RoseAbstractDumper :
	public AbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractDumper)
	friend class RoseOverridenElementDumper; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������ ��� ���-������ �������� ��� ��������� ���� � stl-������
	struct IRoseItemWrapper {
		// COM-������
		IRoseItemPtr m_rose_item;

		IRoseItemWrapper (IRoseItemPtr m_rose_item_);
	};

	// ������ ������ ������� ��� ��������������� �����
	class IChoiceDlg {
	// virtual void destructor
	public:
		virtual ~IChoiceDlg () {};

	//////////////////////////////////////////////////////////////////////////////////////////
	// abstarct methods
	public:
		// ��������� ����� ����������� ��������
		virtual const std::string make_choice (const GCL::StrSet& ch_list, const std::string& for_item_name) = 0;

	}; // class IChoiceDlg

	// �����-������� ��������� ���������� Dumper ������ ��� ������ �� ��� ����������
	class DumpersFactory {
	// virtual void destructor
	public:
		virtual ~DumpersFactory () {};

	//////////////////////////////////////////////////////////////////////////////////////////
	// abstarct methods
	public:
		// ��������� ������������ �������� ���������, ���������� true, ���� ��� ������, ����� false
		virtual bool check_stereotype (IRoseElementPtr elem) const = 0;

		// ������� ������ ��� ������� �������
		virtual RoseAbstractDumper* create_by_root (IRoseItemPtr cls) = 0;

		// ������� ������ �� ������ �������� � ���������� �������
		virtual RoseAbstractDumper* create_by_stereotype (const RoseAbstractDumper* parent, IRoseElementPtr cls) = 0;


	//#UC START# *4571E05D02EE*
	//#UC END# *4571E05D02EE*
	}; // class DumpersFactory

	// ������ ��������� ���������
	typedef std::vector < IRoseItemWrapper > IRoseItemPtr_vector;

	// ������ ��������
	typedef std::vector < const RoseAbstractDumper* > RADVector;

	// ���������� ���������
	typedef boost::unordered_set <const RoseAbstractDumper*> UnorderedRADSet;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ������� ������� � ������ �� ��� UID
	static RoseAbstractDumper* find_in_tree (const std::string& uid);

	// ���������� true, ���� ������ ��������� ���������
	static bool is_model_tree_initialized ();

	// ������� ��������� �������-�������, �������� ��� � ���������� (with_owner)
	static RoseAbstractDumper& make_overriden_wrapper (const RoseAbstractDumper* from, const InheritedItem* state, const RoseAbstractDumper* with_owner);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ��������� �������� � ��������� ��������
	virtual void copy_temporary_properties_from (const RoseAbstractDumper* rad);

	// ���������� �������� �������� - ������� ���� �� ��������� ���������, � ����� � ������
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name) const;

	// ���������� �������������� model stereotype
	virtual void reset_model_stereotype ();

	// �������� �������� �� ��������� ���������
	virtual bool set_temporary_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	) const;

	// ����� ����������, ����� ����� ��������, �������������� �� ������� �������� ���������
	virtual void update_cached_attrs () const;

private:
	// ��������� �������, �������� �� � ����������, ����� ������� �������������� ��������, ��� ���
	// ������ ��������, ������� �������������� (��� ���������) ������ ������� ���������� ������ ����
	// ������� (�.� ��� �� �������� �������������)
	void add_wrapper (RoseOverridenElementDumper* wrapper, const RoseAbstractDumper* for_owner);

	// ���������� �������, ��������� � ����������, ���� ������� �� ������� - ���������� 0
	const RoseOverridenElementDumper* get_wrapper (const RoseAbstractDumper* for_owner) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���������� ����� �������� ��� ��� ��������
	unsigned long long m_creation_order;

	// ������������ ��������
	mutable std::string m_documentation;

	IRoseElementPtr m_rose_element;

	// ��������� ��������� �������
	mutable Base::ToolPropertyMap m_temporary_properties;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_documentation () const;

	void set_documentation (const std::string& documentation) const;

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
	// ����� ������ ���������, ���������� �������� � ���� ����� ������.
	// items - ��������� ��������� ��������, ��� ������������ ������������� ����
	// diagram_hash - ��� ���������, ������������� �� ������ ���� view - ��������� �� ��������
	virtual CxMemFile* dump_diagram (AbstractDumperBase::DiagramItemCollection& items, std::string& diagram_hash) const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ����������� �����������
	virtual AbstractDumperBase::Selections* get_applied_gens () const;

	// implemented method from AbstractDumperBase
	// ���� ������������������ ������� �� ��������.
	virtual const std::string get_auto_counter_str () const;

	// implemented method from AbstractDumperBase
	// ������ ����������� ������� �\��� ��������� (����������� ������ ��������� ������������
	// ����������� ������ ����� ������� �������)
	virtual AbstractDumperBase::ADList* get_derived_impl () const;

	// implemented method from AbstractDumperBase
	// ������ ������������� ������� �\��� ��������� (������������� ������ ��������� ������������ �����
	// ������� �������)
	virtual AbstractDumperBase::ADList* get_derived_over () const;

	// implemented method from AbstractDumperBase
	// ��������� ����������� � ��������
	virtual const std::string get_documentation_str () const;

	// implemented method from AbstractDumperBase
	// ���������� COM GUID
	virtual const std::string get_guid_str () const;

	// implemented method from AbstractDumperBase
	// �������� �� ��������� (��� ��������� � ���������� ��������)
	virtual const std::string get_initial_value_str () const;

	// implemented method from AbstractDumperBase
	// ��������� �� ������ (VCMModule, CORBAInterface::operation, ...)
	virtual const AbstractDumperBase::StereotypeID& get_model_stereotype_str () const;

	// implemented method from AbstractDumperBase
	// ���������� GUID ��������
	virtual const std::string& get_model_unique_id_str () const;

	// implemented method from AbstractDumperBase
	// ���������� ���
	virtual const std::string get_name_str () const;

	// implemented method from AbstractDumperBase
	// ���������� native-���� � ��������, ����������� � ����������
	virtual const std::string get_native_path_str () const;

	// implemented method from AbstractDumperBase
	// ���������� ������ ����������� ��������/��������� ������� ��� ����������� �������, ������� ��
	// ��������� ������ �������
	virtual AbstractDumperBase::ADList* get_not_implemented_derived_abstract () const;

	// implemented method from AbstractDumperBase
	// ���������� ID �������� � ����������
	virtual const std::string get_page_id () const;

	// implemented method from AbstractDumperBase
	// ���������� ���� ��������, ����������� � ��������� ��������
	virtual const std::string get_page_path () const;

	// implemented method from AbstractDumperBase
	// �������� ������� ����������� ��� ���������
	virtual const std::string get_root_dir (bool direct_get) const;

	// implemented method from AbstractDumperBase
	// ���������� ���������� � ����� ��������������� �����
	virtual AbstractDumperBase::GenSourceInfo* get_self_generated_source () const;

	// implemented method from AbstractDumperBase
	// ��������� ����� (const, var, ...)
	virtual const std::string get_target_stereotype_str () const;

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
	// ������� �� ������ ���������� �� ����� ��������������� ��������� ���������, ���������� true �
	// ������ ������.
	virtual bool remove_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// implemented method from AbstractDumperBase
	// ���������� �� ������ ���������� � ��������������� �����, ���������� true � ������ ������.
	virtual bool set_self_generated_source (const AbstractDumperBase::GenSourceInfo& src) const;

	// implemented method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();
protected:

	// implemented method from AbstractDumperBase
	// ���������� ���������� �� ��� ������ ������� ���� ��������������
	// �����, � ������ "�������" �� ������ ���������. �.�. � ��� �����,
	// ������� ���������� ��������� �� �����������
	virtual AbstractDumperBase::GenSourceInfoSet* get_deleted_child_generated_source () const;

	// implemented method from Base::NamedElement
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// ������� ������ ��������� ���������
	virtual void clear_var_dumpers (AbstractDumperBase::LocalVarType type) const;

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
	// ���������� ��� ���������������� ���������
	virtual AbstractDumperBase::GenSourceType get_source_type () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��������� ��������
	virtual const std::string get_stereotype_str () const;
protected:

	// overloaded method from AbstractDumper
	// ���������� �������� �������� �� �����
	virtual void delete_from_cache () const;

	// overloaded method from AbstractDumper
	// ����� ���������� �� ������ �������� ����� �������� �����)
	virtual void spell_generation_prepare ();

	// overloaded method from ObjectTreeResolver
	// ������� ��������� �����, ���� -1 - ������ ������� �� �����
	virtual int get_childs_visibility_level () const;


//#UC START# *4571D1A5009C*
public:
	//static methods
	static const RoseAbstractDumper& get_model_tree_root (bool auto_spell = true);
	static void reset_model_tree_root ();
	static void lock_reset ();
	static void unlock_reset ();

private:
	static RoseAbstractDumper* s_model_tree_root;
	static RoseAbstractDumper* s_void_rad;
	static unsigned s_lock_reset;
	static bool s_attempt_reset_while_locked;

public:
	class auto_locker {
	public:
		auto_locker () {
			RoseAbstractDumper::lock_reset();
		}

		~auto_locker () {
			RoseAbstractDumper::unlock_reset();
		}
	};

	typedef std::list<const RoseAbstractDumper*> RADList;
	
	class IMissedGenFileDlg {
	public:
		virtual bool do_remove (const std::string& file_name) = 0;
	};

public:
	static void set_choice_dlg (IChoiceDlg* dlg);
	static void set_missed_gen_file_dlg (IMissedGenFileDlg* dlg);
	static RADList& global_cats();
	static DumpersFactory* dump_factory();	
	static void set_dumper_factory (DumpersFactory* factory);

	static RoseAbstractDumper* find_in_tree (IRoseElementPtr item);	
	static void reset_all ();

private:	
	static IMissedGenFileDlg* s_missed_gen_file_dlg;
	static IChoiceDlg* s_choice_dlg;
	static DumpersFactory* s_dump_factory;
	static RADList s_global_cats;
	static unsigned s_current_elem_order;

public:	
	bool operator == (const AbstractDumperBase& c) const;
	
	//���� �������-����� �� ��� ���������� �������������
	const RoseAbstractDumper* resolve (std::string& type) const;
		
	IRoseElementPtr rose_element () const;

	virtual VisibilityType get_visibility_type () const;
	static void force_applied_gens_to_all (bool set);

	void fill_sequence_data ();
	bool RoseAbstractDumper::is_native (bool& wilth_parent) const;
	
	// ����������� - � ��� ����������� ���������� �������� � ������ parent
	// - ������������ ������� item - ��������� �������, ��������� � ���������
	// ������ st - ��������� �� ������
	RoseAbstractDumper (const RoseAbstractDumper* parent, IRoseElementPtr item, const AbstractDumperBase::StereotypeID& st = AbstractDumperBase::StereotypeID (""));
protected:
	virtual int compare (const ObjectTreeResolver* od) const;
	virtual const ObjectTreeResolver* get_parent_category () const;
	virtual const ObjectTreeResolver* get_nearest_container () const;
	virtual const ObjectTreeResolver* get_parent_container () const;

private:
	typedef std::string SeqId;
	struct MessTreeNode {
		SeqId id;
		IRoseMessagePtr mess;

		MessTreeNode (const SeqId a_id);
		MessTreeNode (const char* a_id);
		MessTreeNode (const SeqId a_id, IRoseMessagePtr a_mess);
		bool operator < (const MessTreeNode& c) const;

		struct Sort: public std::binary_function<const MessTreeNode, const MessTreeNode, bool> {
			bool operator()(const MessTreeNode* const x, const MessTreeNode* const y) const {
				return *x < *y;
			}
		};
	};
	typedef GCL::Tree<MessTreeNode> MessTree;

protected:
	mutable std::string m_model_unique_id;

private:
	//���� ������� ��� ���������, ������ ������� ������� � "����������", �.� ��������, ������� �����������
	//�������� ���� �������
	typedef std::map<const RoseAbstractDumper*, Core::Var<RoseOverridenElementDumper> > WrappersMap;
	WrappersMap m_wrappers;

	AbstractDumperBase::StereotypeID m_model_stereotype;
	
	mutable char m_is_native;
	mutable bool m_native_with_parent;

	unsigned m_elem_order;

	static bool s_force_applied_gens_to_all;

public:

	typedef std::map<const RoseAbstractDumper*, AbstractDumperBase::Selections> SelectionsMap;
	static SelectionsMap s_selections_map;
//#UC END# *4571D1A5009C*
}; // class RoseAbstractDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

