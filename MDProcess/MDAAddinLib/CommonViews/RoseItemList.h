////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> MDProcess::MDAAddinLib::CommonViews::RoseItemList
//
// ��� - ������ ��� ����������� ��������� ����. ��������� ���������� �������� � ���� ������ �
// ��������, ������ ��� ������ ����������� �����. ������ �������� 3 �������: ��� ��������,
// ���������, ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEITEMLIST_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEITEMLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "afxcmn.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseViewBase.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *47E79D7E0362_CUSTOM_INCLUDES*
//#UC END# *47E79D7E0362_CUSTOM_INCLUDES*


// ��� - ������ ��� ����������� ��������� ����. ��������� ���������� �������� � ���� ������ �
// ��������, ������ ��� ������ ����������� �����. ������ �������� 3 �������: ��� ��������,
// ���������, ������������
class RoseItemList : public CListCtrl, public RoseViewBase {
	SET_OBJECT_COUNTER (RoseItemList)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ����������� ����������
	enum SortDirection {
		ST_ASCENDING // �� �����������
		, ST_DESCENDING // �� ��������
	};

	// ��������� ���������� ����������
	struct SortParam {
		// ��������� �� ������, ������� ����� �����������
		CListCtrl* list;
		// ��������� �������, �� �������� ���� �������� ����������
		int primary_column_id;
		// ��������� �������, �� �������� ����� ������� ����������
		int secondary_column_id;
		// ����������� ����������
		SortDirection direction;
		SortParam ()
			: list(0)
			, primary_column_id(-1)
			, secondary_column_id(-1)
			, direction(ST_ASCENDING)
		{
			//#UC START# *47E8A70D03D6_DEF_INIT_CTOR*
			//#UC END# *47E8A70D03D6_DEF_INIT_CTOR**cpp*
		}
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	RoseItemList ();

public:
	virtual ~RoseItemList ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(RoseItemList)

public:
	// �������� ������� � ������. info - ������ ��������� � ��������� ���������� �� ��������.
	virtual void add_item (IRoseElementPtr elem, const GCL::StrVector& info);

	// ������� ������� �� ������
	virtual void delete_item (int index);

	// ���������� ��������� �������, � �������� ������ ������� ������ ��� ������� index
	virtual IRoseElementPtr get_item (int index) const;

	// �������������� ������
	virtual void sort (SortParam& sort_param);

private:
	// callback, ���������� ����������� MFC ��� ����������� �������� - ����� ��� ������� ����
	// ���������.
	virtual void OnDestroy ();

	// ���������� ������� ������ �� ����������� (� ����������� ������)
	virtual IRoseElementPtr get_item_by_coord (POINT point) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ����������� ����������
	SortDirection m_current_direction;

	// ������ ������ ��� ��������
	Core::Box<CImageList> m_image_list;

	// ���� ������������ ��������� �� �������������� ������
	bool m_is_sorting_permited;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	bool get_is_sorting_permited () const;

	void set_is_sorting_permited (bool is_sorting_permited);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from RoseViewBase
	// ����� ������������� - ���������� ��� ����������� ����������� �������� ����������
	virtual void init ();
protected:

	// implemented method from RoseViewBase
	// �������� �������� �� ���
	virtual void delete_item_from_view (size_t guid);

//#UC START# *47E79D7E0362*
protected:
	void OnLvnItemActivateResult(NMHDR *pNMHDR, LRESULT *pResult);
	void on_list_header_click (NMHDR* pNMHDR, LRESULT* pResult);

	void OnContextMenu (CWnd* pWnd, CPoint pos);
//#UC END# *47E79D7E0362*
}; // class RoseItemList



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEITEMLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

