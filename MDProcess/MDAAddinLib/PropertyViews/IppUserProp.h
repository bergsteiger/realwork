////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/PropertyViews/IppUserProp.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppUserProp
//
// �������� ��� ������ � ����-���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPUSERPROP_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPUSERPROP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574175201B5_CUSTOM_INCLUDES*
//#UC END# *4574175201B5_CUSTOM_INCLUDES*


// �������� ��� ������ � ����-���������� ��������
class IppUserProp : public IppBase {
	SET_OBJECT_COUNTER (IppUserProp)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ����� ��� ���������� ������ ��������� ��� ����������� ������� �������
	class GUITreePropertyBuilder {
		SET_OBJECT_COUNTER (GUITreePropertyBuilder)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// �����������
		// prop - ��������� ������ ���������
		explicit GUITreePropertyBuilder (IppUserProp& prop);

	public:
		virtual ~GUITreePropertyBuilder ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// ����� ��� ���������� ������ ��������� �� ������ ����� ������� (root)
		virtual void build (const AbstractDumperBase::PropertyGroupTreeItem* root);

	private:
		// ��������� ������ ��������
		virtual void fill_group (
		WinGUI::COptionTree& option_tree
		, WinGUI::COptionTreeItem*& node
		, const AbstractDumperBase::PropertyGroupTreeItem* group
	);

		// ����� ��������� ������ ���������� ��� ���������� �������
		virtual void fill_properties (const AbstractDumperBase::UserPropertyMap& props, WinGUI::COptionTreeItem& group);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// ��������� ������ ���������
		IppUserProp* m_prop;
	}; // class GUITreePropertyBuilder

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_USER_PROP };

public:
	IppUserProp ();

public:
	virtual ~IppUserProp ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppUserProp)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������ ����-�������
	WinGUI::COptionTree m_properties;

//#UC START# *4574175201B5*	
// Overrides
public:
	virtual bool on_ok(bool& need_colorize);
	
	void add_property (WinGUI::COptionTreeItem* item) {
		m_properties_list.push_back (Property (item));
	}
	WinGUI::COptionTree& get_properties_tree () {
		return m_properties;
	}
protected:
	struct Property {
		WinGUI::COptionTreeItem* item;		
		Property (WinGUI::COptionTreeItem* n) 
			: item (n)
		{
		}
		bool operator == (const Property& eq) {
			return item == eq.item;
		}
		Property& operator = (const Property& eq) {
			item = eq.item;			
			return *this;
		}
	};
	std::vector<Property> m_properties_list;

// Implementation
protected:
	void restore_up (WinGUI::COptionTreeItem* prop_item);
	
	void on_tree_item_changed (NMHDR* pNotifyStruct, LRESULT* plResult);
public:	
	afx_msg LRESULT on_def_prop_btn_clicked (WPARAM wParam, LPARAM lParam);
//#UC END# *4574175201B5*
}; // class IppUserProp



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPUSERPROP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

