////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/PackageView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::PackageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_PACKAGEVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_PACKAGEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class PackageView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_number () const;

	void set_number (int number);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	int get_center_x () const;

	void set_center_x (int center_x);

	int get_center_y () const;

	void set_center_y (int center_y);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_number;

	// гуид реального пакета, которому соответствует вью
	std::string m_guid;

	int m_center_x;

	int m_center_y;


}; //class PackageView

std::ostream& operator << (std::ostream& out_stream, const PackageView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_PACKAGEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
