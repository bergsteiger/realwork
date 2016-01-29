////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ReturnMessageView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ReturnMessageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_RETURNMESSAGEVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_RETURNMESSAGEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class ReturnMessageView {
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

	int get_start_y () const;

	void set_start_y (int start_y);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_number;

	std::string m_guid;

	int m_client;

	int m_supplier;

	int m_start_y;


}; //class ReturnMessageView

std::ostream& operator << (std::ostream& out_stream, const ReturnMessageView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_RETURNMESSAGEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
