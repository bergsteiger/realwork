////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/StereotypeView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::StereotypeView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_STEREOTYPEVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_STEREOTYPEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class StereotypeView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_center_x () const;

	void set_center_x (int center_x);

	int get_center_y () const;

	void set_center_y (int center_y);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_center_x;

	int m_center_y;


}; //class StereotypeView

std::ostream& operator << (std::ostream& out_stream, const StereotypeView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_STEREOTYPEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
