////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Attribute.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Attribute
//
// атрибут
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/AttributeContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// атрибут
class Attribute {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Attribute ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const VisibilityType& get_visibility () const;

	void set_visibility (const VisibilityType& visibility);

	const AbstractionType& get_abstractiveness () const;

	void set_abstractiveness (const AbstractionType& abstractiveness);

	const LinkType& get_link_type () const;

	void set_link_type (const LinkType& link_type);

	const std::string& get_stereotype () const;

	void set_stereotype (const std::string& stereotype);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_target_type () const;

	void set_target_type (const std::string& target_type);

	const std::string& get_init_value () const;

	void set_init_value (const std::string& init_value);

	const std::string& get_target_stereotype () const;

	void set_target_stereotype (const std::string& target_stereotype);

	const StringList& get_set_exceptions () const;

	void set_set_exceptions (const StringList& set_exceptions);

	const StringList& get_get_excpetions () const;

	void set_get_excpetions (const StringList& get_excpetions);

	const Core::Box<AttributeContent>& content () const;

	void content (const Core::Box<AttributeContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// видимость
	VisibilityType m_visibility;

	AbstractionType m_abstractiveness;

	// тип связи
	LinkType m_link_type;

	// стереотип атрибута, по-умолчанию - не задан
	std::string m_stereotype;

	// имя атрибута (в некоторых случаях может может быть не задано)
	std::string m_name;

	// тип атрибута
	std::string m_target_type;

	// значение по-умолчанию
	std::string m_init_value;

	std::string m_target_stereotype;

	// список set-исключений
	StringList m_set_exceptions;

	// список get-исключений
	StringList m_get_excpetions;

	Core::Box<AttributeContent> m_content;


}; //class Attribute

std::ostream& operator << (std::ostream& out_stream, const Attribute& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
