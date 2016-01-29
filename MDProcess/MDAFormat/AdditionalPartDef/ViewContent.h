////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ViewContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_VIEWCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_VIEWCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class ViewContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	unsigned int get_number () const;

	void set_number (unsigned int number);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	unsigned int m_number;

	std::string m_guid;

	PropertyList m_properties;


}; //class ViewContent

std::ostream& operator << (std::ostream& out_stream, const ViewContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_VIEWCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
