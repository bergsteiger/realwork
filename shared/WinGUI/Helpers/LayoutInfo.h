////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/LayoutInfo.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::LayoutInfo
//
// ����� ��� �������� ���������� � ����� � ��������. ��������� ���������� ����� ����� �����������,
// � ����� ���.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_LAYOUTINFO_H__
#define __SHARED_WINGUI_HELPERS_LAYOUTINFO_H__

#include "shared/Core/sys/std_inc.h"
#include <map>

//#UC START# *4652AEFF0128_CUSTOM_INCLUDES*
//#UC END# *4652AEFF0128_CUSTOM_INCLUDES*

namespace WinGUI {

// ����� ��� �������� ���������� � ����� � ��������. ��������� ���������� ����� ����� �����������,
// � ����� ���.
class LayoutInfo {
	SET_OBJECT_COUNTER (LayoutInfo)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���� �����
	enum OptionTypes {
		OT_MIN_WIDTH // ����������� ������
		, OT_MAX_WIDTH // ������������ ������
		, OT_MIN_HEIGHT // ����������� ������
		, OT_MAX_HEIGHT // ������������ ������
		, OT_ASPECT_RATIO // ����������� ������
		, OT_MIN_LEFT // ����������� �������� ���������� LEFT
		, OT_MAX_LEFT // ������������ �������� ���������� LEFT
		, OT_MIN_TOP // ����������� �������� ���������� TOP
		, OT_MAX_TOP // ������������ �������� ���������� TOP
		, OT_LEFT_OFFSET // �������� ���������� LEFT
		, OT_TOP_OFFSET // �������� ���������� TOP
		, OT_RIGHT_OFFSET // �������� ���������� RIGHT
		, OT_BOTTOM_OFFSET // �������� ���������� BOTTOM
		, OT_LEFT_ANCHOR // �������� �����
		, OT_TOP_ANCHOR // �������� ������
		, OT_RIGHT_ANCHOR // �������� ������
		, OT_BOTTOM_ANCHOR // �������� �����
		, OT_CENTER_XPOS // X ���������� ������
		, OT_CENTER_YPOS // Y ���������� ������
	};

	// �����
	typedef std::map < OptionTypes, int > Options;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// default �����������
	LayoutInfo ();

public:
	virtual ~LayoutInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ��������
	virtual bool add_option (OptionTypes opt, int value);

	// ���������� ������� ������������� �����
	virtual bool get_option (OptionTypes opt, int& value) const;

	// true, ���� ����� opt  �����������, ����� false
	virtual bool has_option (OptionTypes opt) const;

	// ?????
	const CRect& reference_rect () const;

	// ?????
	CRect& reference_rect ();

	// ������� ���������� � ������������
	virtual void reset ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������� �����
	Options m_options;

	// �������� ������������ ��� ������������� �������� ����� ��� ����� � ��������� �������.
	// �������� �������� ����� 1333 � ��������� 3 ����� ����������������� ��� ����� 1.333
	unsigned int m_precision;

	CRect m_reference_rect;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	unsigned int get_precision () const;

	void set_precision (unsigned int precision);

//#UC START# *4652AEFF0128*
//#UC END# *4652AEFF0128*
}; // class LayoutInfo

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_LAYOUTINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

