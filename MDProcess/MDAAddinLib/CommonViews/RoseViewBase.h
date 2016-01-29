////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/CommonViews/RoseViewBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::CommonViews::RoseViewBase
//
// ������� ����� ��� ���� ��������� ����������, ������������ ��������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEVIEWBASE_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEVIEWBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


// ������� ����� ��� ���� ��������� ����������, ������������ ��������� ��������
class RoseViewBase {

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// �������������� ������ ������������ ����
	static const unsigned int PROPERTIES_CMD; // ������� "�������� ��������"
	static const unsigned int LOCK_CMD; // ������� "��������"
	static const unsigned int UNLOCK_CMD; // ������� "���������"
	static const unsigned int BWOSE_CMD; // ������� "�������� �� ���������"

	// ���� - uid->�������. � �������� uid'� ������������ ��� ����'� �������� � ������
	typedef std::map < unsigned long, RoseElementWrapper > UIDtoItemMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseViewBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// ����� ��������������� - ���������� ��� ����������� ����������� �������� ����������
	void fini ();

	// ���������� ��������� ������� �� ��� �����
	virtual IRoseElementPtr get_item_by_guid (size_t guid) const;

	// ���������� ��� �������� �������� �� ��������
	virtual void on_delete_item (size_t guid);

	// ������ ���������� ��� ���������� ������ �������� � ������, ���������� ���������� �������������
	// ��������, ���� ������������� ������ ���� ����������� � ��������� �����������, �������� �
	// ��������� ������ ��� ������.
	virtual size_t on_new_item (IRoseElementPtr elem);

	// ���������� ����������� ���� ��� ����������� ��������
	virtual void show_context_menu (IRoseElementPtr elem, const CPoint& pos, CWnd& wnd);

private:
	// ��������� ���������� ���� ��������
	virtual size_t make_guid (IRoseElementPtr elem) const;

	// ���������� ������ ������������ ����, id - ������������� �������, elem - ������� �� ������� ����
	// ������� ���������� ����
	virtual void on_command (unsigned int id, IRoseElementPtr elem);


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// ����� ������������� - ���������� ��� ����������� ����������� �������� ����������
	virtual void init () = 0;

protected:
	// �������� �������� �� ���
	virtual void delete_item_from_view (size_t guid) = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ������������ � ��������
	UIDtoItemMap m_items;
}; // class RoseViewBase



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEVIEWBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

