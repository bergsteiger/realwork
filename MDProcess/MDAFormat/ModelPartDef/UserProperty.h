////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/UserProperty.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::UserProperty
//
// пользовательское свойство
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_USERPROPERTY_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_USERPROPERTY_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// пользовательское свойство
class UserProperty {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	UserProperty ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_value () const;

	void set_value (const std::string& value);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// имя пользовательского свойства
	std::string m_name;

	// значение пользоствальского свойства
	std::string m_value;


}; //class UserProperty

std::ostream& operator << (std::ostream& out_stream, const UserProperty& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_USERPROPERTY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
