////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/AttributeContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::AttributeContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ATTRIBUTECONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ATTRIBUTECONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class AttributeContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const AttributeList& get_attributes () const;

	void set_attributes (const AttributeList& attributes);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	AttributeList m_attributes;

	PropertyList m_properties;


}; //class AttributeContent

std::ostream& operator << (std::ostream& out_stream, const AttributeContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ATTRIBUTECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
