////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Attribute.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Attribute
//
// описание атрибута
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ATTRIBUTE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ATTRIBUTE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AttributeContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// описание атрибута
class Attribute {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<AttributeContent>& content () const;

	void content (const Core::Box<AttributeContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// имя атрибута
	std::string m_name;

	std::string m_guid;

	Core::Box<AttributeContent> m_content;


}; //class Attribute

std::ostream& operator << (std::ostream& out_stream, const Attribute& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ATTRIBUTE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
