////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseDumpers::RoseHelper
//
// ��������������� ������� � �������� ��� ������ � ����������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEHELPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/WinGUI/Controls/CImageListEx.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

//#UC START# *4571F040008C_USER_INCLUDES*
#include <functional>
#include <map>
#include <set>
#include <afxcmn.h>
#include "boost/function.hpp"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
//#UC END# *4571F040008C_USER_INCLUDES*

namespace RoseHelper {

// �������� ��� �� ����� ���� ������������� � �������� ����������
class BadName : public ::Core::Exception {
public:
	BadName (const std::string& name);

	virtual ~BadName () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ���������� ���
	std::string m_name;
};

// ���� "���� � ��� ��������" �� ��� "����"
typedef std::map < std::string, std::string > RoseItemMap;

// ������ ����� ������
typedef GCL::StrSet Selections;

// ��������� ������ ������� �������������� �������
enum ExecResult {
	ER_EDIT_OK // �������������� ���������
	, ER_CANCEL // �������������� �������� ��� �� ������� � ����������
	, ER_DELETE // � ���������� �������������� �������� ������
};

// ���� ��������, ������������ ��� ������ � �����
static const char* CLASS_DIAG_LINK_PROPERTY = "ClassUID"; // �������� �������� � ������� �������� ��������� ������� ����������� �������
static const char* SCEN_DIAG_LINK_PROPERTY = "UseCase"; // �������� �������� � ������� �������� ������� - ���������  ����������� usecase'��
static const char* DIAG_CHANGE_FLAG_PROPERTY = "IsChanged"; // �������� �������� ������������� ����������� ���������

// ���� ��������
static const char* view_prefix = "\x95\x20"; // ������� ����������� ����� ������ �������� �� ���������, ���� � ���� ���� ��������������� ��������
static const char* view_postfix = "\0"; // ������� ����������� ����� ������ �������� �� ���������, ���� � ���� ���� ��������������� ��������

// ��������� ���������� ���������� ����� � ������� ������� ��������
void check_name (IRoseItemPtr item, const std::string& pure_name) /*throw (BadName)*/;

// ����� ����������� ��������� �������� �� ��������� � ������������
// � ������������ ������� (x, y)
void position_in_diagram (IRoseDiagramPtr diag, IRoseItemPtr item, long x, long y);

// ����� ����������� ��������� ��� �������� �� ��������� � ������������
// � ������������ ������� (x, y)
void position_in_diagram (IRoseDiagramPtr diag, IRoseItemViewPtr view, long x, long y);

// ����� ���������� �������� �� ���� h_wnd ����� ���������
bool is_diagram_window (HWND h_wnd, IRoseDiagramPtr diag);

// ���������� ������� ��������� �� �������� �����������
IRoseElementPtr get_element (IRoseDiagramPtr diag, long x, long y);

// �������� ����� �� ��������� ������ � ���������� ���������
bool point_to_diagram (POINT& point, IRoseDiagramPtr diag);

// ���������� ��������� ������� ������ ������� ����� ���� ������� �� ��������
IRoseControllableUnitPtr get_nearest_controllable_unit (IRoseElementPtr elem);

// ���������� ��������� �����
IRoseCategoryPtr get_nearest_category (IRoseElementPtr elem);

// ���������� true ���� ���������� ������� ����� �������������
bool can_modify_elem (IRoseElementPtr elem);

// ����� ������� ���������� ���
const std::string create_unic_name (IRoseItemPtr context, const char* prefix);

// ���������� ��������� ��������, ��������������� ������ � ������� (template_str)
const std::string extract_stereotype (const std::string& template_str);

// ��������� ��� �� ������������ � �� ������������� � �������� ���������
void check_class_name (IRoseClassPtr cls, const char* name_buf, bool& bad);

// ���������� ����, ��������������� "�����" ������� ����������
IRoseRolePtr get_role (IRoseAssociationPtr assoc);

// ����� ���������� � ������ ���� item � ������ �������� (new_parent)
// is_new - ���� ������������� � ���, ��� �� � ���������� ����������� ������ ����� ������ (��������
// ������ ���������� ��������, ��������)
// 
// ���������� true, � ������ ���� ����������� ���� ��������, ����� false
bool relocate (IRoseElementPtr elem, IRoseElementPtr new_parent, bool& is_new);

// ���������� ImageList, �������� �����������, �������������� ��������� ������.
// 
// ������� ������������ ��������� �� ����!
WinGUI::CImageListEx* get_rose_image_list ();

// ���������� ������ ����������� � ImageList'�, ���������������� �������� (elem), ���� ������
// ����������� ��� - ���������� -1
int get_image_index (IRoseElementPtr elem);

// ���������� ����� �� ����� ������ � ��������� ���
bool can_control (IRoseCategoryPtr cat);

// ������� ���������� ������ �� ����������� �������� �������� ��������
// � ��������� ��� ����� � �������� ����������
const std::string clean_wrong_sympbols (const char* str);

// ���������� ��� ���� ���� ����� ��� ������ � ��������� ���, � ��������� ������ ���������� ���
// �����
const std::string extract_cat_name (IRoseCategoryPtr cat);

// ��������� ���� �� �������� ������� ���� ����� ������� ���.
const std::string create_dir_path (IRoseCategoryPtr cat);

// ���������� ������������� ���� ���������
HWND get_diag_window (IRoseDiagramPtr diag);

// ����� ������������ ������� (elem) �� ��������� (diag)
// 
// ����� ��������:
// 1. ���� ������� ��������: ����� ���, ��� �����, ��� ��������� ��� ��������, ����� ������� ����
// 2. ���� ������ �� ����� �����: ���� ����� � ������ �� ������� forieghn color, ������� ����� (���
// ���������� ��� ����� �����), ��� ���������, ��� ��������
// 3. �����, ������������ �� �������: ���� ����, ���� �����, ��������� ��������, ��������� ���������
// 4. �����, ���� ������� �� �� ����� �����, �� ������� ���� �� �������� �������� �������� ��
// ���������, ���� ���� �� ������� �� � "����".
// ���� ������� �������� �����, �� �� ��, ������������ � ��������� ��������, ���� ������� ��� -
// �������. ���� ������ ����, � ������ �� ����� - �������.
void colorize (IRoseDiagramPtr diag, IRoseElementPtr elem);

// ���������� ��������� �������� �������, ��������� � ������� (item), ���� � item �� �������� ��
// ���� ��������� ��������� ������
// 
// ����� ��������� ��������� �������������� � �����, � ������� ��������� item
IRoseClassDiagramCollectionPtr get_class_diagrams (IRoseClassPtr item);

// ���������� ���� � �����
const std::string get_template_file ();

// �������� ������� ���� ������� �� �������� ������� ���������� ���� � �����.
// 
// \one_trye - ���� ���������� ������ �� ������ ���� ������� ������� ����
const std::string open_template_file (bool one_try);

// ��������� �� ����� �������� ��� ������ ��� �� ���������.
// ������������ ��� ��������� �� ��������� �������� � ���������������� UP
const std::string create_label_name (const std::string& item_name);

// ��������� �� ������ ��� ��� ��������
const std::string extract_name_from_label (const std::string& label);

// ���������� ������ ���� �������� (��������� �������, �������-���������, ��������� ���������)
// ��������
IRoseDiagramCollectionPtr get_diagrams (IRoseElementPtr elem);

// ����� ���������� true, ���� ������� ��� ���� �� ���� �� ��� ��������� �������� Main - ���������,
// ����� ���������� false
bool is_main_with_parents (IRoseElementPtr elem);

// �������� �� ������� ������������. ���������� true, ���� ��� �������� ��� ���� �� ��� ������ ���
// �������� ��������� ������� ��������������, ����� - false
bool is_incomplete (IRoseElementPtr elem);

// ���������� �������������, ��������������� view ��������
void get_rect (IRoseItemViewPtr view, CRect& rect);

// ���������� ��������� ��� ��������������� �������� (item) �� ��������� (diag)
IRoseItemViewCollectionPtr get_views (IRoseItemPtr item, IRoseDiagramPtr diag);

// ���������� ��������� ����������� (Class, Operation, Attribute � �.�), ������� ���������
// ��������� ������ �������� (elem).
GCL::StrSet* get_enabled_stereotypes (IRoseElementPtr elem);

// ���������� ������ ���� ����������� (�������������, �����������)  �� ������� ������� (����������)
IRoseClassCollectionPtr get_all_derived (IRoseClassPtr cls);

// ���������� �������� � �������, � ����������� �� ��������� ������� ����������� ������� �
// ����������� �������, � ������ ������������� ������� ������� ����������, ��� �������� ������
// �������� ���������� true.
// user_friendly_name - ��� \������������� ��������, ��� ����������� ������������ � �������, ���� �
// ����
bool write_property_with_lock (
		IRoseElementPtr elem
		, const std::string& prop_id
		, const std::string& prop_value
		, GenSupport::LockStrategy lock_strategy
		, bool is_write_necessary
		, const std::string& user_friendly_name
	) /*throw (
		Base::FatalError
	)*/;

// ����� ��������� ���������� � ���������� ���������� (���������� � ��������� ��������) � ���
// ��������
void move_generated_source_to_parent (IRoseElementPtr elem, IRoseElementPtr parent);

// ���������� �������� � �������, � ����������� �� ��������� ������� ����������� ������� �
// ����������� �������, � ������ ������������� ������� ������� ����������, ��� �������� ������
// �������� ���������� true.
// user_friendly_name - ��� \������������� ��������, ��� ����������� ������������ � �������, ���� �
// ����
bool write_property_with_lock (
		IRoseElementPtr elem
		, const std::string& tool_name
		, const std::string& prop_id
		, const std::string& prop_value
		, GenSupport::LockStrategy lock_strategy
		, bool is_write_necessary
		, const std::string& user_friendly_name
	);

// ���������� ������ ���� ����� ��������
RoseElementSet* get_all_childs (IRoseElementPtr elem);

// ���������� ������ ���������������� ����� ��������
RoseElementSet* get_childs (IRoseElementPtr elem);

// �� ���� ��������� �������� ��� ������ ���-������, ������ ��� ������ � �������� ������ ����������
// � � ������ ���������� �� ��������.
const std::string create_full_name (IRoseCategoryPtr cat);

// ��������� ������������� ��� ������� ������������� ���������� ��� ���������� ������ override ���
// implement ��������.
const std::string make_restore_overriden_or_impl_callback_uid (IRoseElementPtr elem, const std::string& prop_name);

//#UC START# *4571F040008C_USER_DEFINITION*
#define PROP_ROOTDIR			   OLESTR("RootDir")
#define PROP_ATTR_SET_RAISES	   OLESTR("SetRaises")
#define PROP_ATTR_GET_RAISES	   OLESTR("GetRaises")
#define PROP_TEMPLATE_FILE         OLESTR("TempliteFile")
#define PROP_AUTO_COUNTER          OLESTR("AutoCounter")
#define PROP_IS_NATIVE             OLESTR("IsNative")
#define PROP_DERIVED_IMPLEMENT	   OLESTR("DerivedImplement")
#define PROP_DERIVED_OVERLOAD	   OLESTR("DerivedOverload")
#define PROP_IMPLEMENT_SELECT_TYPE  OLESTR("ImplementSelectType")
#define PROP_OVERLOAD_SELECT_TYPE  OLESTR("OverloadSelectType")
#define PROP_TARGET_STEREOTYPE     OLESTR("TargetStereotype")
#define PROP_APPLGEN			   OLESTR("ApplyedGens")
#define PROP_INCOMPLETE	           OLESTR("Incomplete")
#define PROP_OS_GUID			   "OS_GUID"

#define SET_COLOR(TARGET,SOURCE)      \
	if (TARGET->Red != SOURCE[0]) {   \
		TARGET->Red = SOURCE[0];      \
	}                                 \
	if (TARGET->Green != SOURCE[1]) { \
		TARGET->Green = SOURCE[1];    \
	}                                 \
	if (TARGET->Blue != SOURCE[2]) {  \
		TARGET->Blue = SOURCE[2];     \
	}

#define SET_COLOR_RGB(TARGET,R,G,B)      \
	if (TARGET->Red != R) {   \
		TARGET->Red = R;      \
	}                                 \
	if (TARGET->Green != G) { \
		TARGET->Green = G;    \
	}                                 \
	if (TARGET->Blue != B) {  \
		TARGET->Blue = B;     \
	}


//////////////////////////////Propery work methods:////////////////////////////////////////////////////////
const std::string get_visibility_type(IRoseElementPtr item);
const std::string get_visibility_type(const RoseAbstractDumper* item);

void set_visibility_type (IRoseElementPtr item, const std::string& vt);
void set_visibility_type (const RoseAbstractDumper* item, const std::string& vt, bool persist = false);

bool is_it_abstract (IRoseElementPtr item);
bool is_it_abstract (const RoseAbstractDumper* item);

bool is_it_optional (IRoseElementPtr item);
bool is_it_optional (const RoseAbstractDumper* item);

bool is_it_implementable (IRoseElementPtr item);
bool is_it_implementable (const RoseAbstractDumper* item);

bool has_it_derived_impl (IRoseElementPtr item);

std::string get_target_stereotype(IRoseElementPtr item);
std::string get_target_stereotype(const RoseAbstractDumper* item);

bool set_target_stereotype (IRoseElementPtr item, const std::string& st);
bool set_target_stereotype (const RoseAbstractDumper* item, const std::string& st, bool persist = false);

void set_default_abstraction_type(IRoseElementPtr item);

void set_abstraction_type (IRoseElementPtr item, AbstractDumperBase::AbstractionType type);

const std::string get_abstraction_type_str (IRoseElementPtr item);
const std::string get_abstraction_type_str (const RoseAbstractDumper* item);

AbstractDumperBase::AbstractionType get_abstraction_type (IRoseElementPtr item);

const std::string get_link_type (IRoseElementPtr item);

bool set_link_type (IRoseElementPtr item, const std::string& lt);

bool get_is_native(IRoseElementPtr item);

bool get_is_native_with_parent(IRoseElementPtr item, bool& with_parent);

bool get_is_native_with_parent(IRoseElementPtr item);

bool set_is_native(IRoseElementPtr item, bool value);

void set_parameterized(IRoseItemPtr item, bool value);


//////////////////////////////////////////////////////////////////////////////////////////////////////////

IRoseApplicationPtr rose_app ();

void set_rose_app (IRoseApplicationPtr app);

void clear_incremented_counters ();

bool has_content (IRoseItemPtr item);

int get_image_id (const AbstractDumperBase* adb);

IRoseItemCollectionPtr get_clients (const IRoseElementPtr& elem);
IRoseItemCollectionPtr get_clients (const IRoseClassPtr& cls);
IRoseItemCollectionPtr get_clients (const IRoseCategoryPtr& cat);

void delete_item (IRoseItemPtr new_item);

bool delete_item_with_lock (IRoseItemPtr new_item);

void browse_item (IRoseItemPtr new_item);

bool show_item (IRoseElementPtr item);

void reset_template ();

bool load_template ();

void reset_gen_stereotype (IRoseElementPtr item);
AbstractDumperBase::StereotypeID create_gen_stereotype (IRoseElementPtr item);

IRoseCategoryPtr get_parent_category (IRoseElementPtr item);

IRoseItemPtr get_nearest_container (IRoseElementPtr item);

IRoseDiagramPtr get_self_diagram (IRoseElementPtr item);

//���������� ������ ��������, �� ������� ������������ �������
IRoseDiagramCollectionPtr get_all_diagrams (IRoseElementPtr item);

RoseItemMap find_all_visible_item (IRoseElementPtr from, const GCL::StrSet& stereotypes);

RoseItemMap find_all_visible_ex (IRoseElementPtr from, const GCL::StrSet& stereotypes);

std::string get_full_name (IRoseElementPtr item);

AbstractDumperBase::StereotypeID get_gen_stereotype (IRoseElementPtr item);

std::string get_template_file(IRoseElementPtr item, bool& by_parent);

std::string get_root_dir(IRoseElementPtr item);

std::string get_implement_select_type (const IRoseElementPtr elem);
const std::string get_implement_select_type (const RoseAbstractDumper* elem);

const std::string make_template_file (const std::string& file_name);


void set_template_file(IRoseElementPtr item, const std::string& value);

void set_root_dir(IRoseElementPtr item, const std::string& value);

bool override_property (IRoseElementPtr item, _bstr_t tool_name, _bstr_t prop_name, _bstr_t value);

bool force_override_property (IRoseElementPtr item, _bstr_t tool_name, _bstr_t prop_name, _bstr_t value);

GCL::StrVector get_available_target_stereotypes (IRoseElementPtr item);	

std::string get_auto_counter(IRoseElementPtr item);

//���������� ����� �������� �������� (���� ������� �����, �� ��������� ����� ��������, ��������� ��� � ���������)
unsigned long long get_creation_timestamp(IRoseElementPtr item);

//���������� ������ ����������� ��� ���������������� �� ������, ���������� � ����������
void get_derived_methods_from_prop (IRoseElementPtr item, _bstr_t& prop_name, GCL::StrSet& methods);
void get_derived_methods_from_prop (const RoseAbstractDumper* item, _bstr_t& prop_name, RoseAbstractDumper::UnorderedRADSet& methods);

RoseItemMap find_all_derived_abstract (IRoseElementPtr from);

void find_all_derived_abstract (IRoseElementPtr from, GCL::StrSet& res);
void get_self_abstract (const RoseAbstractDumper* self, RoseAbstractDumper::UnorderedRADSet& res);

void find_all_derived_abstract (const RoseAbstractDumper* from, RoseAbstractDumper::UnorderedRADSet& res);
void find_all_derived_abstract (const RoseAbstractDumper* from, RoseAbstractDumper::UnorderedRADSet& res);

void get_implemented_methods (const RoseAbstractDumper* elem, RoseAbstractDumper::UnorderedRADSet& res);

RoseItemMap find_all_derived_impl (IRoseElementPtr from);

void find_all_derived_impl (IRoseElementPtr from, GCL::StrSet& res);

void find_all_derived_impl (const RoseAbstractDumper* from, RoseAbstractDumper::UnorderedRADSet& res);

IRoseElementPtr get_context(IRoseElementPtr item);

std::string get_overwriten_prop (IRoseElementPtr item);

void colorize(const IRoseDiagramPtr& d);

void colorize_all ();

void fill_node (Selections& selections, CTreeCtrl& tree, HTREEITEM ht_node, RoseAbstractDumper::GenTreeItem* gt_node);

typedef std::vector<HTREEITEM> TreeItems;

void collect_all_checked (const CTreeCtrl& tree, TreeItems& items, TreeItems& leaf_items, HTREEITEM current = NULL, bool parent_checked = false);

bool is_it_available_by_type (IRoseItemPtr item, IRoseItemPtr item_context, const AbstractDumperBase::StereotypeID& st_tp);

bool is_it_available_by_constr (IRoseItemPtr item, IRoseItemPtr item_context, const AbstractDumperBase::StereotypeID& st_tp);

bool is_it_main_model_element(IRoseElementPtr item);

void set_new_main_model_element(IRoseItemPtr item);

IRoseItemPtr get_main_model_element();

//���������, ��� ��� ��������� �� ��������� ����� �,
//��� ��� �����-�������
bool is_attribute_role (IRoseRolePtr role);
typedef std::set<const AbstractDumperBase::Templates::value_type*> TemplatesSet;

TemplatesSet get_available_parent_by_constr (
	const AbstractDumperBase::Templates::key_type& key_child
	, const AbstractDumperBase::Templates::value_type& child
);

//��� ���������� ������ ������� available_parent_by_constr
typedef std::map<const AbstractDumperBase::Templates::key_type, TemplatesSet>  AvailableParentByConstrMap;
AvailableParentByConstrMap& get_available_parent_by_constr_map ();

bool check_model_for_changes ();

// ��������� ��������� ��������
GCL::StrSet& get_changed_diags ();

struct ParentSelectFilter {
	ParentSelectFilter (IRoseElementPtr item): m_item (item) {
	}
	
	bool is_meet (const AbstractDumperBase::GenTreeItem* node) const {
		IRoseElementPtr context = RoseHelper::get_context (m_item);

		while (context) {
			std::string merged_sels = context->GetPropertyValue(TOOL_NAME, PROP_APPLGEN);

			context = RoseHelper::get_context (context);

			RoseHelper::Selections selections = GCL::split_string_by_sub_string_uniq (merged_sels.data(), "|");

			if (selections.size()) {
				bool good = false;

				Core::Var<const AbstractDumperBase::GenTreeItem> parent = AbstractDumperBase::GenTreeItem::_duplicate(node);

				if (this->check_parent_down (parent.in(), selections)) {
					good = true;
				} else {
					while (!parent.is_nil()) {
						if (selections.find (parent->name()) != selections.end()) {
							good = true;
							break;
						}

						parent = dynamic_cast<const AbstractDumperBase::GenTreeItem*>(parent->parent());
					}
				}

				if (!good) {
					return false;
				}
			}
		}

		return true;
	}

	void each_func (const GCL::StaticNode* item, RoseHelper::Selections& all_child_gens) const {
		all_child_gens.insert(dynamic_cast<const AbstractDumperBase::GenTreeItem*>(item)->name());
	}

	bool check_parent_down (const AbstractDumperBase::GenTreeItem* root_gen, const RoseHelper::Selections& selections) const {
		RoseHelper::Selections all_child_gens;
		root_gen->for_each (*this, all_child_gens);
		
		if (std::find_first_of(all_child_gens.begin(), all_child_gens.end(), selections.begin(), selections.end()) != all_child_gens.end()) {
			return true;
		} else {
			return false;
		}
	}

	IRoseElementPtr m_item;
};

void move_generated_source (IRoseElementPtr elem, IRoseElementPtr parent);

#define FORCE_MODEL_EDIT(OBJ,WHAT) \
	bool fme_macro_is_need_unlock = false; \
	IRoseControllableUnitPtr fme_macro_cat = RoseHelper::get_nearest_controllable_unit (OBJ); \
	if (0 != fme_macro_cat && false == fme_macro_cat->IsModifiable ()) { \
		fme_macro_is_need_unlock = true; \
	} \
	if (fme_macro_is_need_unlock) { \
		fme_macro_cat->Modifiable (true); \
	} \
	try { \
		WHAT; \
	} catch (...) { \
	} \
	if (fme_macro_is_need_unlock) { \
		fme_macro_cat->Save (); \
		fme_macro_cat->Modifiable (false); \
	}

template <class Type, class ValueType>
void write_type (Type obj, ValueType value) {
	obj->Type = value;
}


template <class Type, class ValueType>
void write_init_value (Type obj, ValueType value) {
	obj->InitValue = value;
}

template <class Type, class ValueType>
void write_return_type (Type obj, ValueType value) {
	obj->ReturnType = value;
}

//override for IRoseParametrPtr
void write_type (IRoseParameterPtr obj, const char* value);

void write_init_value (IRoseParameterPtr obj, const char* value);

void do_on_lock_fail (const std::string& mess);

template <class Type, class ValueType = const char*>
struct DoActionWithLock  {
	typedef void (*ACTION_PROC) (Type, ValueType);
	void operator () (						  
		Type obj
		, ValueType value
		, ACTION_PROC action_func
		, GenSupport::LockStrategy lock_strategy
		, bool is_write_necessary
	) /*throw (Base::FatalError)*/ {
		this->operator () (
			obj
			, value
			, boost::function<void (Type, ValueType)> (action_func)
			, lock_strategy
			, is_write_necessary
		);
	}
	void operator () (						  
		Type obj
		, ValueType value
		, boost::function<void (Type, ValueType)> action_func
		, GenSupport::LockStrategy lock_strategy
		, bool is_write_necessary
	) /*throw (Base::FatalError)*/ {
		class local {
		public:
			static void do_lock (
				boost::function<void (Type, ValueType)> action_func
				, Type obj
				, ValueType value
				, bool is_write_necessary
			) {
				MDPSupport::CatLockerFacade_var clf = MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)obj);
				if (clf->try_change ()) {
					action_func (obj, value);
					clf->do_change ();
				} else {
					std::string mess ("��������� �������� �������� �������� ��� ��������: ");
					mess += get_full_name (obj);
					
					if (is_write_necessary) {
						do_on_lock_fail (std::string (mess));
					} else {
						GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
					}
				}
			}

			static void do_no_lock (
				boost::function<void (Type, ValueType)> action_func
				, Type obj
				, ValueType value
				, bool is_write_necessary
			) {
				if (false == can_modify_elem (obj)) {
					std::string mess ("��������� �������� �������� �������� ��� ��������: ");
					mess += get_full_name (obj);
					
					if (is_write_necessary) {						
						do_on_lock_fail (std::string (mess));
					} else {
						GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
					}

				} else {
					action_func (obj, value);
				}
			}
		};
		if (false == can_modify_elem (obj)) {
			switch (lock_strategy) {
				case GenSupport::LS_NO_LOCK: {
					local::do_no_lock (action_func, obj, value, is_write_necessary);
					break;
				}
				case GenSupport::LS_ASK: {
					std::string mess ("��� ������ �������� �������� ���������� ��������� �������:\r\n");
					mess += get_full_name (obj);
					
					int answer = ::AfxMessageBox (mess.c_str (), MB_ICONQUESTION | MB_YESNOCANCEL);
					switch (answer) {
						case IDOK:
							local::do_lock (action_func, obj, value, is_write_necessary);
							break;
						case IDNO:
							local::do_no_lock (action_func, obj, value, is_write_necessary);
							break;
						case IDCANCEL:
							GenSupport::EnvironmentFactory::get ().set_cancel_generation (true);
							throw Base::FatalError ("��������� ���� �������� �������������");
							break;
					}
					break;
				}
				
				 case GenSupport::LS_LOCK_ALL: {
					local::do_lock (action_func, obj, value, is_write_necessary);
					break;
				}

			}
		} else {
			//������� ��� �������� ��� ���������������
			action_func (obj, value);
		}
	}
};

//���� ��� �������� -> ������ ��������
typedef std::map<std::string, GCL::StrSet> GeneratedSourceSetMap;

//���� ��� �������� -> ��������
typedef std::map<std::string, std::string> GeneratedSourcePropertiesMap;

//����� ��� ���������� ���������� � ����������� ���������� �����
void update_nested_generated_source (
	IRoseElementPtr parent
	, const GeneratedSourcePropertiesMap& nested_generated_sources
);

//����� ��� ���������� ���������� � ����������� ���������� ����� �������� ��������� ������ ������
//� ������������ �� ����������
void update_nested_generated_source_with_lock (
	IRoseElementPtr parent
	, const GeneratedSourcePropertiesMap& nested_generated_sources
);

//�������� ������ �������, ������� ����� �������� � parent
void get_updated_nested_generated_source (
	IRoseElementPtr parent
	, const GeneratedSourceSetMap& files_properties
	, const GeneratedSourceSetMap& pages_properties
	, GeneratedSourcePropertiesMap& nested_generated_sources
);

//��������� ������ ���� �������, ����������� SELF GENERATED � NESTED GENERATED
//�.� ���� �������� - ���������� � �������� ��������, �� ��� �������������� � �������� ��� �������� - ������
//���������� ���������� �����
void collect_generated_source_for_parent (
	const std::string& elem_guid
	, const std::string& prop_name
	, const std::string& prop_value
	, GeneratedSourceSetMap& files_properties
	, GeneratedSourceSetMap& pages_properties
);

//���������� true, ���� prop_name - ��� ��� ����-������
bool is_user_code_property (const std::string& prop_name);
//#UC END# *4571F040008C_USER_DEFINITION*

} // namespace RoseHelper


#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
