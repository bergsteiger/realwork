////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::XMLIniConverterLib::IniConverter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <vector>
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include <fstream>
#include <algorithm>


namespace XMLIniConverterLib {
namespace IniConverter_i {

// таблица параметров из ini файла
typedef std::map < std::string, IniConverter::Parameter_var > ParameterTable;

// таблица секций из ini файла
typedef std::vector < IniConverter::Section_var > SectionTable;

// список правил
typedef std::vector < IniConverter::Rule_cvar > RuleList;

// Таблица переменных
typedef std::map < std::string, std::string > VariableTable;

struct IsSectionName : public std::unary_function<IniConverter::Section_var, bool> {
	bool operator () (const IniConverter::Section_var& param_) const;

	IsSectionName (const char* name_);

private:
	const char* name;
};

} //namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

