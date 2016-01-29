////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ParameterContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ParameterContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PARAMETERCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PARAMETERCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class ParameterContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	PropertyList m_properties;


}; //class ParameterContent

std::ostream& operator << (std::ostream& out_stream, const ParameterContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PARAMETERCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
