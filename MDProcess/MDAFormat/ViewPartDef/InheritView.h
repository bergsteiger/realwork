////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/InheritView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::InheritView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_INHERITVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_INHERITVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/Point.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class InheritView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_number () const;

	void set_number (int number);

	int get_client () const;

	void set_client (int client);

	int get_supplier () const;

	void set_supplier (int supplier);

	const PointList& get_points () const;

	void set_points (const PointList& points);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_number;

	int m_client;

	int m_supplier;

	PointList m_points;


}; //class InheritView

std::ostream& operator << (std::ostream& out_stream, const InheritView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_INHERITVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
