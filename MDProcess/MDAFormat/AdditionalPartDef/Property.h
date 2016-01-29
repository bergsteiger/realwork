////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Property.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Property
//
// совойство элемента, используется для хранения различных свойств в модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PROPERTY_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PROPERTY_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// совойство элемента, используется для хранения различных свойств в модели
class Property {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Property ();

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
	// имя свойства
	std::string m_name;

	// значение свойства
	std::string m_value;


}; //class Property

std::ostream& operator << (std::ostream& out_stream, const Property& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PROPERTY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
