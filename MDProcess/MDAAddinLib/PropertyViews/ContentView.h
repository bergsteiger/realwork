////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/PropertyViews/ContentView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::ContentView
//
// ������ ��� ����������� ����� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_CONTENTVIEW_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_CONTENTVIEW_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *47E884C00139_CUSTOM_INCLUDES*
//#UC END# *47E884C00139_CUSTOM_INCLUDES*


// ������ ��� ����������� ����� ��������
class ContentView : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (ContentView)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_CONTENT_VIEW };

public:
	// �����������
	explicit ContentView (IRoseElementPtr self);

public:
	virtual ~ContentView ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ContentView)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
private:
	// ��������� ������ �����
	virtual void fill_childs_list ();

	// ���������� ������ �� ������ "Browse" - ���������� ��������� � ������ ������� �� ���������
	void on_browse ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������-������ �����
	RoseItemList m_childs_list;

	// ������� ��� �������� ����� �������� ������ �����
	IRoseElementPtr m_self;

//#UC START# *47E884C00139*
//#UC END# *47E884C00139*
}; // class ContentView



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_CONTENTVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

