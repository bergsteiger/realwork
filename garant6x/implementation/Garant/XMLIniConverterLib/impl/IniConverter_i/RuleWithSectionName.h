////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RuleWithSectionName
//
// сервант для которого есть метод установки имени секции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RULEWITHSECTIONNAME_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RULEWITHSECTIONNAME_H__

#include "shared/Core/sys/std_inc.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

// сервант для которого есть метод установки имени секции
class RuleWithSectionName {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RuleWithSectionName ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void set_section_name (const char* name);

protected:
	virtual const char* get_section_name () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_section_name;
}; // class RuleWithSectionName

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RULEWITHSECTIONNAME_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

