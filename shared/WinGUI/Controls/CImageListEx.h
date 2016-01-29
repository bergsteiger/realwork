////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/WinGUI/Controls/CImageListEx.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Controls::CImageListEx
//
// –асширенный ImageList, позвол€ет формировать список изображений из отдельных файлов-картинок
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_CONTROLS_CIMAGELISTEX_H__
#define __SHARED_WINGUI_CONTROLS_CIMAGELISTEX_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "afxcmn.h"

namespace WinGUI {

// –асширенный ImageList, позвол€ет формировать список изображений из отдельных файлов-картинок
class CImageListEx :
	virtual public CImageList
{
	SET_OBJECT_COUNTER (CImageListEx)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// мапа: "путь к файлу с изображением" -> индекс в ImageList'е
	typedef std::map < std::string, unsigned int > ImagePathToIndex;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	CImageListEx ();

public:
	virtual ~CImageListEx ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ƒобавл€ет изображение в список.
	// path - путь к файлу с изображением
	// в случае успешного добавлени€ возвращает индекс изображени€ в списке, иначе возврщает -1
	virtual int add (const std::string& path);

	// добавл€ет в список картинку
	// возвращает индекс первой добавленной картинки в список
	virtual int add_image (HBITMAP image, int count);

	// аналог Create из MSDN:
	// cx - размер каждого изображени€
	// cy - размер каждого изображени€
	// flags - флаги, задающие тип
	// initial - сколько изображений лист хранит сначала
	// grow - на сколько растет список при добавлении изображени€
	virtual void create (int cx, int cy, unsigned int flags, int initial, int grow);

	// удал€ет ImageList, очищает мапу
	virtual void delete_list ();

	// возвращает индекс изображени€, соответствующего пути (path)
	virtual int get_image_index (const std::string& path);

	// удал€ет изображени€ из списка
	virtual void remove_images ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// размер по ’ каждого изображени€ в списке
	int m_cx;

	// размер по Y каждого изображени€ в списке
	int m_cy;

	// мапа: "путь к файлу с изображением" -> индекс в ImageList'е
	ImagePathToIndex m_image_path_to_index;
}; // class CImageListEx

} // namespace WinGUI


#endif //__SHARED_WINGUI_CONTROLS_CIMAGELISTEX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

