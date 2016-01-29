////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Controls/CImageListEx.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Controls::CImageListEx
//
// ����������� ImageList, ��������� ����������� ������ ����������� �� ��������� ������-��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_CONTROLS_CIMAGELISTEX_H__
#define __SHARED_WINGUI_CONTROLS_CIMAGELISTEX_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "afxcmn.h"

namespace WinGUI {

// ����������� ImageList, ��������� ����������� ������ ����������� �� ��������� ������-��������
class CImageListEx :
	virtual public CImageList
{
	SET_OBJECT_COUNTER (CImageListEx)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ����: "���� � ����� � ������������" -> ������ � ImageList'�
	typedef std::map < std::string, unsigned int > ImagePathToIndex;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	CImageListEx ();

public:
	virtual ~CImageListEx ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ����������� � ������.
	// path - ���� � ����� � ������������
	// � ������ ��������� ���������� ���������� ������ ����������� � ������, ����� ��������� -1
	virtual int add (const std::string& path);

	// ��������� � ������ ��������
	// ���������� ������ ������ ����������� �������� � ������
	virtual int add_image (HBITMAP image, int count);

	// ������ Create �� MSDN:
	// cx - ������ ������� �����������
	// cy - ������ ������� �����������
	// flags - �����, �������� ���
	// initial - ������� ����������� ���� ������ �������
	// grow - �� ������� ������ ������ ��� ���������� �����������
	virtual void create (int cx, int cy, unsigned int flags, int initial, int grow);

	// ������� ImageList, ������� ����
	virtual void delete_list ();

	// ���������� ������ �����������, ���������������� ���� (path)
	virtual int get_image_index (const std::string& path);

	// ������� ����������� �� ������
	virtual void remove_images ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������ �� � ������� ����������� � ������
	int m_cx;

	// ������ �� Y ������� ����������� � ������
	int m_cy;

	// ����: "���� � ����� � ������������" -> ������ � ImageList'�
	ImagePathToIndex m_image_path_to_index;
}; // class CImageListEx

} // namespace WinGUI


#endif //__SHARED_WINGUI_CONTROLS_CIMAGELISTEX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

