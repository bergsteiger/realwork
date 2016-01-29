////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/CommonViews/CTooltipListCtrl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> MDProcess::MDAAddinLib::CommonViews::CTooltipListCtrl
//
// �������-������ � ���������� ����������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_CTOOLTIPLISTCTRL_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_CTOOLTIPLISTCTRL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include <map>
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45F982BB0128_CUSTOM_INCLUDES*
#include "afxcmn.h"
//#UC END# *45F982BB0128_CUSTOM_INCLUDES*


// �������-������ � ���������� ����������� ���������
class CTooltipListCtrl : public CListCtrl {
	SET_OBJECT_COUNTER (CTooltipListCtrl)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���� "������� �������" -> �����-���������
	typedef std::map < unsigned long, std::string > ItemToTextMap;

	// ��������� ���������� ���������
	typedef std::set < int > SelectedItems;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	CTooltipListCtrl ();

public:
	virtual ~CTooltipListCtrl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(CTooltipListCtrl)

public:
	// ��������� ������� � ������� = text � ������
	virtual void add_item (const std::string& text);

	// �������� ��� �������� � ������
	virtual void delete_all_items ();

	// ������� ������� �� ������, row - ������� �������� � ������
	virtual void delete_item (unsigned long row);

	// ���������� �����-���������, ��������� � ���������
	virtual const std::string get_item_tip (unsigned long row) const;

	// ���������� ������� ���������� ��������
	virtual int get_selected_item () const;

	// ���������� ��������� �������� ���������� ���������
	virtual SelectedItems* get_selected_items () const;

	// ���������� ��������� � ������ �������� � ������ �����
	virtual void move_selected_items (CTooltipListCtrl& dest);

	// ������������� �����-���������, ��������� � ���������
	virtual unsigned long set_item_tip (unsigned long row, const std::string& text);

	// ������������� ����, ��� ������ �������������
	// (���� �� ��������)
	virtual void set_multicolumn (bool is_multi);

	// ������������� ������������ ������ ���� ����������� ���������
	virtual void set_tooltip_max_width (unsigned long width);

private:
	// ���������� ������ �������, ��� ���� ����� ���������� ���� ���������� �������������� ��������
	// ��� ���
	virtual void calculate_column_width (bool after_add);

	// ���������� ����� �������� � ������ ��� ������� ��������� ������ ����
	virtual int get_item_on_cursor () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_is_multicolumn;

	ItemToTextMap m_item_to_tip;

	unsigned long m_tool_tip_max_width;

//#UC START# *45F982BB0128*	
// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTooltipListCtrl)
	protected:	
	virtual void PreSubclassWindow();
	//}}AFX_VIRTUAL
	virtual int OnToolHitTest( CPoint point, TOOLINFO* pTI ) const;

	BOOL OnToolTipText( UINT id, NMHDR * pNMHDR, LRESULT * pResult );

	// Generated message map functions
protected:
	//{{AFX_MSG(CTooltipListCtrl)
	afx_msg void OnGetdispinfo(NMHDR* pNMHDR, LRESULT* pResult);
	//}}AFX_MSG
//#UC END# *45F982BB0128*
}; // class CTooltipListCtrl



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_CTOOLTIPLISTCTRL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

