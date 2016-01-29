////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/AssociationView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::AssociationView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_ASSOCIATIONVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_ASSOCIATIONVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/Point.h"
#include "MDProcess/MDAFormat/ViewPartDef/NameView.h"
#include "MDProcess/MDAFormat/ViewPartDef/StereotypeView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class AssociationView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_number () const;

	void set_number (int number);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	int get_client () const;

	void set_client (int client);

	int get_supplier () const;

	void set_supplier (int supplier);

	const PointList& get_points () const;

	void set_points (const PointList& points);

	const Core::Box<NameView>& name_view () const;

	void name_view (const Core::Box<NameView>& name_view);

	const Core::Box<StereotypeView>& stereotype_view () const;

	void stereotype_view (const Core::Box<StereotypeView>& stereotype_view);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_number;

	// гуид реальной связи, которой соответствует вью
	std::string m_guid;

	int m_client;

	int m_supplier;

	PointList m_points;

	Core::Box<NameView> m_name_view;

	Core::Box<StereotypeView> m_stereotype_view;


}; //class AssociationView

std::ostream& operator << (std::ostream& out_stream, const AssociationView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_ASSOCIATIONVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
