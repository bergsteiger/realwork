////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RuleWithSectionName
//
// сервант для которого есть метод установки имени секции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RuleWithSectionName::~RuleWithSectionName () {
	//#UC START# *45C1DB250167_DESTR_BODY*
	//#UC END# *45C1DB250167_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

const char* RuleWithSectionName::get_section_name () const {
	//#UC START# *45C1DCD9032C*
	return m_section_name.c_str ();
	//#UC END# *45C1DCD9032C*
}

void RuleWithSectionName::set_section_name (const char* name) {
	//#UC START# *45C1DCC20399*
	m_section_name = name;
	//#UC END# *45C1DCC20399*
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

