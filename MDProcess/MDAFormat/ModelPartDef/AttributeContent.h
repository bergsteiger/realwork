////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/AttributeContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::AttributeContent
//
// вложенные в трибут элементы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTECONTENT_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTECONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// вложенные в трибут элементы
class AttributeContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const AttributeList& get_keys () const;

	void set_keys (const AttributeList& keys);

	const UserPropertyList& get_user_properties () const;

	void set_user_properties (const UserPropertyList& user_properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ключи атрибута
	AttributeList m_keys;

	// пользовательские свойства
	UserPropertyList m_user_properties;


}; //class AttributeContent

std::ostream& operator << (std::ostream& out_stream, const AttributeContent& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_ATTRIBUTECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
