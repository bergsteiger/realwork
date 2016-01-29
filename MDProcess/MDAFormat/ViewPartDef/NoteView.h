////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/NoteView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::NoteView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_NOTEVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_NOTEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class NoteView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	NoteView ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_number () const;

	void set_number (int number);

	int get_associated_view_number () const;

	void set_associated_view_number (int associated_view_number);

	int get_center_x () const;

	void set_center_x (int center_x);

	int get_center_y () const;

	void set_center_y (int center_y);

	const std::string& get_text () const;

	void set_text (const std::string& text);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_number;

	int m_associated_view_number;

	int m_center_x;

	int m_center_y;

	std::string m_text;


}; //class NoteView

std::ostream& operator << (std::ostream& out_stream, const NoteView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_NOTEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
