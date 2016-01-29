////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::MDACmdManager
// ��������� ���������� ������ �������� ��� ��������� CmdManager
//
// �������� MDA-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"

//#UC START# *462D87C6033C_CUSTOM_INCLUDES*
#include "MDProcess/MDAAddinLib/Addin/Addin_i.h"
//#UC END# *462D87C6033C_CUSTOM_INCLUDES*

namespace MDACommands {

class MDACmdManager; // self forward Var
typedef ::Core::Var<MDACmdManager> MDACmdManager_var;
typedef ::Core::Var<const MDACmdManager> MDACmdManager_cvar;

class MDACmdManager_factory;

// �������� MDA-������
class MDACmdManager:
	virtual public Commands::CmdManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MDACmdManager)
	friend class MDACmdManager_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ����� �������� ������ �������� - ��������� ������ ������ ����������, ������� ����� ������� ��
	// ����������� �� ���������� ����������
	// 
	// parent - �������-��������, � ������� ����� ������ ����� �������
	// element_type - {"all", "Class", "Category", "Operation", "Attribute" } - ��� ����������
	// �������� (� ����������� �� ���� ����� ������ ���������������� radio-button � ������� ������
	// ����������)
	static IRoseItemPtr create_new_element (IRoseItemPtr parent, const std::string& element_type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MDACmdManager ();

	virtual ~MDACmdManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������ ��������� ��������� �� ������ ���� need_auto_rep ��������� ����� �� ���������
	// ���������� �������������� ������� ��� ���
	virtual void generate_impl (RoseElementVector& rose_items, bool need_auto_rep);

	// ������� ������ � ������������ ��������� ��������� ������ (���� ��������� ����)? ����������
	// true, ���� ��� ������� ���������, false - ���� ������������ ����� "������"
	virtual bool save_model_if_need () const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Commands::CmdManager
	// ������� �������� ��������, �������� ������ ����������� (������ derived impl; ������ ����������;
	// UP, ������������ � �������)
	virtual void clean_properties (IRoseElementPtr elem);

	// implemented method from Commands::CmdManager
	// �� ��, ��� � clean_properties, �� ����������� ���������� �� ���� ����� ��������
	virtual void clean_properties_recursively (IRoseElementPtr elem);

	// implemented method from Commands::CmdManager
	// ��������� ��������
	virtual void colorize (IRoseDiagramPtr diag);

	// implemented method from Commands::CmdManager
	// ������������ ��� ��������� � cat, � ������ ���������
	virtual void colorize_all_diagrams (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// "��������" ����� � ��������� ���
	// ���������� true � ������ ������, ����� false
	virtual bool control (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� "control" ����������� � cat � ���� ��������� ����������
	virtual bool control_all (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� ����� � ��������� ���, ���� � ���� ���������� �������������
	virtual bool control_to_file (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� ������� item � parent
	// ���������� ����� �������
	virtual IRoseElementPtr copy (IRoseElementPtr item, IRoseElementPtr parent);

	// implemented method from Commands::CmdManager
	// �������� ��������� ���������� �������� (elem)
	// ���� need_auto_rep ��������� ����� �� ��������� ���������� �������������� ������� ��� ���
	virtual void generate (IRoseItemPtr elem, bool need_auto_rep);

	// implemented method from Commands::CmdManager
	// �������� ��������� ���������� �������� (elem)  � ���� ��������� �� ���� ���������
	// ���� need_auto_rep ��������� ����� �� ��������� ���������� �������������� ������� ��� ���
	virtual void generate_with_consumers (IRoseItemPtr elem, bool need_auto_rep);

	// implemented method from Commands::CmdManager
	// �������� "�������" ���������� ������
	virtual void lock (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� ��������� ��� ������ �� ���������� ���������.
	virtual void lock (IRoseCategoryCollectionPtr cats);

	// implemented method from Commands::CmdManager
	// �������� �������� ������ �������� ��� ������
	virtual IRoseAttributePtr new_attribute (IRoseClassPtr parent);

	// implemented method from Commands::CmdManager
	// �������� �������� ������ ����� ��� ����� (parent)
	virtual IRoseAttributePtr new_attribute_key (IRoseRolePtr parent);

	// implemented method from Commands::CmdManager
	// �������� �������� ������ ������, ���������� � parent, ��� parent - ����� ��� �����
	virtual IRoseClassPtr new_class (IRoseItemPtr parent);

	// implemented method from Commands::CmdManager
	// �������� �������� ����� ��������� �������, ��� ��������� ������������ ������ ������������.
	// 
	// \parent - ������� ��� �������� �������� ���������, ����� ���� �������, ���� ������
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent);

	// implemented method from Commands::CmdManager
	// �������� �������� ����� ��������� �������.
	// 
	// \parent - ������� ��� �������� �������� ���������, ����� ���� �������, ���� ������
	// 
	// \name - ��� ���������
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent, const std::string& name);

	// implemented method from Commands::CmdManager
	// �������� �������� ������ ��������, element_type  - ��� �������� ("Class", "Category",
	// "Attribute", "Operation")
	virtual IRoseElementPtr new_element (IRoseItemPtr parent, const std::string& element_type);

	// implemented method from Commands::CmdManager
	// �������� �������� ����� �������� ��� ������
	virtual IRoseOperationPtr new_operation (IRoseClassPtr parent);

	// implemented method from Commands::CmdManager
	// �������� �������� ������ ������
	virtual IRoseCategoryPtr new_package (IRoseCategoryPtr parent);

	// implemented method from Commands::CmdManager
	// �������� ������� ��������, parent - ����� �� ����������� "UseCase"
	virtual IRoseScenarioDiagramPtr new_sequence_diagram (IRoseClassPtr parent);

	// implemented method from Commands::CmdManager
	// ��������� ��������� ��������� � �������� (parent)m � �������� ���������� ���������� ����������
	// ���������. ��� ��������� ������������ ������ ������������ � ����������� �������.
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent);

	// implemented method from Commands::CmdManager
	// ��������� ��������� ��������� � ������ <name> � �������� (parent)m � �������� ����������
	// ���������� ���������� ���������
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent, const std::string& name);

	// implemented method from Commands::CmdManager
	// ������� ������ ������ ������� ��������
	// \is_new - ���� ���������� �������� �� elem �����, ���� ��, �� ���� ������� �����������
	// ���������� �� ���������
	// \need_reload_template - ���� ���������� ����� �� ������������ ������ ����� ������� �������
	virtual RoseHelper::ExecResult properties (IRoseItemPtr elem, bool is_new, bool need_reload_template);

	// implemented method from Commands::CmdManager
	// ����� ���������� � ������ ���� ������� � ������ �������� (new_parent), ��� ������������� �����
	// ������
	// ���������� true � ������ ������
	// 
	// is_new - ���� ������������� � ���, ��� �� � ���������� ����������� ������ ����� ������
	// (�������� ������ ���������� ��������, ��������)
	virtual bool relocate (IRoseElementPtr item, IRoseElementPtr new_parent, bool& is_new);

	// implemented method from Commands::CmdManager
	// ������� ������� �� ������ (��������� ������������� ������������)
	virtual void remove (IRoseElementPtr elem);

	// implemented method from Commands::CmdManager
	// �������� ���������
	virtual void rollback (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� ������ ������ elem
	virtual void search (IRoseItemPtr elem) const;

	// implemented method from Commands::CmdManager
	// ���������� ������ ��� ������, template_path - ���� � ����� �������
	virtual void set_template (IRoseApplicationPtr app, const std::string& template_path) const;

	// implemented method from Commands::CmdManager
	// �������� ������ ������ ���������� �������
	virtual void show_locked () const;

	// implemented method from Commands::CmdManager
	// �������� �������� ������� � ��������� ��� - "����������" ��� � ���� ������ (mdl) ��� cat
	// ��������
	virtual void uncontrol (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� uncontrol ����������� � cat � ���� ��� ��������� ����������
	virtual void uncontrol_all (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// �������� "�������" ���������� ������
	virtual void unlock (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// ��������� ��������� ��� ������ �� ���������� ���������
	virtual void unlock (IRoseCategoryCollectionPtr cats);

	// implemented method from Commands::CmdManager
	// ��������� ������� � � ��� ���������� ��������������� �������� �������� � �
	virtual void view_elem_in_confluence (IRoseItemPtr elem) const;

	// implemented method from Commands::CmdManager
	// �������� ���������� ������
	virtual void view_reports (IRoseItemPtr elem) const;

//#UC START# *462D87C6033C*
	void clear () {
		m_model_explorer = 0;
	}
	typedef ATL::CComPtr<IModelExplorer> IModelExplorerPtr;
	IModelExplorerPtr m_model_explorer;
//#UC END# *462D87C6033C*
}; // class MDACmdManager

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
