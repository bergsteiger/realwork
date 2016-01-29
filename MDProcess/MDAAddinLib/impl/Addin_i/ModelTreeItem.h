////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/ModelTreeItem.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::ModelTreeItem
//
// ������ � ������� ��� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MODELTREEITEM_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MODELTREEITEM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *45C704E301A5_CUSTOM_INCLUDES*
//#UC END# *45C704E301A5_CUSTOM_INCLUDES*


// ������ � ������� ��� �������� ������
class ModelTreeItem;
typedef Core::Var<ModelTreeItem> ModelTreeItem_var;
typedef Core::Var<const ModelTreeItem> ModelTreeItem_cvar;

class ModelTreeItem :
	virtual public GCL::StaticNode
{
	SET_OBJECT_COUNTER (ModelTreeItem)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ������� ����������� ��������
	static ModelTreeItem* make_copy (const ModelTreeItem* source);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit ModelTreeItem (IRoseElementPtr elem);

public:
	virtual ~ModelTreeItem ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� true ���� ������� ����� ���� ��������� � parent, ����� - false
	virtual bool can_move_to (const ModelTreeItem* parent) const;

	// ������������� ���� ������
	virtual void init (IRoseElementPtr elem);

	// return true if element moved successfully, other - false
	virtual bool move_to (ModelTreeItem* parent);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���������� ������� ������
	IRoseElementPtr m_item;

	// ������ ��� �������� ����������� �� ���������� �� ����� �������� � ��� ����������
	std::string m_item_name;

	// ��������� ��������
	std::string m_item_stereotype;

	// uid �������� �� ������
	std::string m_item_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseElementPtr get_item () const;

	void set_item (IRoseElementPtr item);

	const std::string& get_item_name () const;

	void set_item_name (const std::string& item_name);

	const std::string& get_item_stereotype () const;

	void set_item_stereotype (const std::string& item_stereotype);

	const std::string& get_item_uid () const;

	void set_item_uid (const std::string& item_uid);

//#UC START# *45C704E301A5*
//#UC END# *45C704E301A5*
}; // class ModelTreeItem



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MODELTREEITEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

