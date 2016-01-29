////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/Commands/Commands.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Commands
//
// ���������� ��� ��������� MDA-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMANDS_H__
#define __MDPROCESS_MDAADDINLIB_COMMANDS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

namespace Commands {

class CmdManager;
typedef ::Core::Var<CmdManager> CmdManager_var;
typedef ::Core::Var<const CmdManager> CmdManager_cvar;
// ��������� - �������� ������
class CmdManager
	: virtual public ::Core::IObject
{
public:
	// ��������� ��������
	virtual void colorize (IRoseDiagramPtr diag) = 0;

	// ������������ ��� ��������� � cat, � ������ ���������
	virtual void colorize_all_diagrams (IRoseCategoryPtr cat) = 0;

	// "��������" ����� � ��������� ���
	// ���������� true � ������ ������, ����� false
	virtual bool control (IRoseCategoryPtr cat) = 0;

	// �������� "control" ����������� � cat � ���� ��������� ����������
	virtual bool control_all (IRoseCategoryPtr cat) = 0;

	// �������� ����� � ��������� ���, ���� � ���� ���������� �������������
	virtual bool control_to_file (IRoseCategoryPtr cat) = 0;

	// �������� ������� item � parent
	// ���������� ����� �������
	virtual IRoseElementPtr copy (IRoseElementPtr item, IRoseElementPtr parent) = 0;

	// �������� ��������� ���������� �������� (elem)
	// ���� need_auto_rep ��������� ����� �� ��������� ���������� �������������� ������� ��� ���
	virtual void generate (IRoseItemPtr elem, bool need_auto_rep) = 0;

	// �������� ��������� ���������� �������� (elem)  � ���� ��������� �� ���� ���������
	// ���� need_auto_rep ��������� ����� �� ��������� ���������� �������������� ������� ��� ���
	virtual void generate_with_consumers (IRoseItemPtr elem, bool need_auto_rep) = 0;

	// �������� "�������" ���������� ������
	virtual void lock (IRoseCategoryPtr cat) = 0;

	// �������� �������� ������ �������� ��� ������
	virtual IRoseAttributePtr new_attribute (IRoseClassPtr parent) = 0;

	// �������� �������� ������ ����� ��� ����� (parent)
	virtual IRoseAttributePtr new_attribute_key (IRoseRolePtr parent) = 0;

	// �������� �������� ������ ������, ���������� � parent, ��� parent - ����� ��� �����
	virtual IRoseClassPtr new_class (IRoseItemPtr parent) = 0;

	// �������� �������� ����� ��������� �������, ��� ��������� ������������ ������ ������������.
	// 
	// \parent - ������� ��� �������� �������� ���������, ����� ���� �������, ���� ������
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent) = 0;

	// �������� �������� ����� ��������� �������.
	// 
	// \parent - ������� ��� �������� �������� ���������, ����� ���� �������, ���� ������
	// 
	// \name - ��� ���������
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent, const std::string& name) = 0;

	// �������� �������� ������ ��������, element_type  - ��� �������� ("Class", "Category",
	// "Attribute", "Operation")
	virtual IRoseElementPtr new_element (IRoseItemPtr parent, const std::string& element_type) = 0;

	// �������� �������� ����� �������� ��� ������
	virtual IRoseOperationPtr new_operation (IRoseClassPtr parent) = 0;

	// �������� �������� ������ ������
	virtual IRoseCategoryPtr new_package (IRoseCategoryPtr parent) = 0;

	// �������� ������� ��������, parent - ����� �� ����������� "UseCase"
	virtual IRoseScenarioDiagramPtr new_sequence_diagram (IRoseClassPtr parent) = 0;

	// ��������� ��������� ��������� � �������� (parent)m � �������� ���������� ���������� ����������
	// ���������. ��� ��������� ������������ ������ ������������ � ����������� �������.
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent) = 0;

	// ��������� ��������� ��������� � ������ <name> � �������� (parent)m � �������� ����������
	// ���������� ���������� ���������
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent, const std::string& name) = 0;

	// ������� ������ ������ ������� ��������
	// \is_new - ���� ���������� �������� �� elem �����, ���� ��, �� ���� ������� �����������
	// ���������� �� ���������
	// \need_reload_template - ���� ���������� ����� �� ������������ ������ ����� ������� �������
	virtual RoseHelper::ExecResult properties (IRoseItemPtr elem, bool is_new, bool need_reload_template) = 0;

	// ����� ���������� � ������ ���� ������� � ������ �������� (new_parent), ��� ������������� �����
	// ������
	// ���������� true � ������ ������
	// 
	// is_new - ���� ������������� � ���, ��� �� � ���������� ����������� ������ ����� ������
	// (�������� ������ ���������� ��������, ��������)
	virtual bool relocate (IRoseElementPtr item, IRoseElementPtr new_parent, bool& is_new) = 0;

	// �������� ���������
	virtual void rollback (IRoseCategoryPtr cat) = 0;

	// �������� �������� ������� � ��������� ��� - "����������" ��� � ���� ������ (mdl) ��� cat
	// ��������
	virtual void uncontrol (IRoseCategoryPtr cat) = 0;

	// �������� uncontrol ����������� � cat � ���� ��� ��������� ����������
	virtual void uncontrol_all (IRoseCategoryPtr cat) = 0;

	// �������� "�������" ���������� ������
	virtual void unlock (IRoseCategoryPtr cat) = 0;

	// �������� ������ ������ elem
	virtual void search (IRoseItemPtr elem) const = 0;

	// �������� ������ ������ ���������� �������
	virtual void show_locked () const = 0;

	// ��������� ������� � � ��� ���������� ��������������� �������� �������� � �
	virtual void view_elem_in_confluence (IRoseItemPtr elem) const = 0;

	// �������� ���������� ������
	virtual void view_reports (IRoseItemPtr elem) const = 0;

	// ���������� ������ ��� ������, template_path - ���� � ����� �������
	virtual void set_template (IRoseApplicationPtr app, const std::string& template_path) const = 0;

	// ������� ������� �� ������ (��������� ������������� ������������)
	virtual void remove (IRoseElementPtr elem) = 0;

	// �������� ��������� ��� ������ �� ���������� ���������.
	virtual void lock (IRoseCategoryCollectionPtr cats) = 0;

	// ��������� ��������� ��� ������ �� ���������� ���������
	virtual void unlock (IRoseCategoryCollectionPtr cats) = 0;

	// ������� �������� ��������, �������� ������ ����������� (������ derived impl; ������ ����������;
	// UP, ������������ � �������)
	virtual void clean_properties (IRoseElementPtr elem) = 0;

	// �� ��, ��� � clean_properties, �� ����������� ���������� �� ���� ����� ��������
	virtual void clean_properties_recursively (IRoseElementPtr elem) = 0;
};

/// factory interface for CmdManager
class CmdManagerFactory {
public:
	// �������� �������� ������
	static CmdManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DblClickAction;
typedef ::Core::Var<DblClickAction> DblClickAction_var;
typedef ::Core::Var<const DblClickAction> DblClickAction_cvar;
// ������� �� ����-����
class DblClickAction
	: virtual public ::Core::IObject
{
public:
	// ��������� ��������
	virtual void action (IRoseElementPtr elem) = 0;
};

/// factory interface for DblClickAction
class DblClickActionFactory {
public:
	// �������, ������ ��������� ����������
	static DblClickAction* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Commands

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Commands::CmdManager> {
	typedef Commands::CmdManagerFactory Factory;
};
template <>
struct TypeTraits <Commands::DblClickAction> {
	typedef Commands::DblClickActionFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAADDINLIB_COMMANDS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
