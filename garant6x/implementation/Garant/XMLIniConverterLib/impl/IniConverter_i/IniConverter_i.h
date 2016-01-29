////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::XMLIniConverterLib::IniConverter_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ������� ���������� �� ini �����
typedef std::map < std::string, IniConverter::Parameter_var > ParameterTable;

// ������� ������ �� ini �����
typedef std::vector < IniConverter::Section_var > SectionTable;

// ������ ������
typedef std::vector < IniConverter::Rule_cvar > RuleList;

// ������� ����������
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

