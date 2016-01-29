////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RenameRule_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

//#UC START# *45C0CD8803C8_CUSTOM_INCLUDES*
#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C0CD8803C8_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C0CD8803C8*
//#UC END# *45C0CD8803C8*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RenameRule_i::RenameRule_i (XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45BF29580280_45BF29B101E4_45C0CD8803C8_BASE_INIT*
//#UC END# *45BF29580280_45BF29B101E4_45C0CD8803C8_BASE_INIT*
{
	//#UC START# *45BF29580280_45BF29B101E4_45C0CD8803C8_BODY*
	XercesHelpers::XMLStr old_name (rule_node.get_attribute ("oldname"));
	m_old_name = old_name.in ();
	XercesHelpers::XMLStr new_name (rule_node.get_attribute ("newname"));
	m_new_name = new_name.in ();
	//#UC END# *45BF29580280_45BF29B101E4_45C0CD8803C8_BODY*
}

RenameRule_i::~RenameRule_i () {
	//#UC START# *45C0CD8803C8_DESTR_BODY*
	//#UC END# *45C0CD8803C8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Rule
// Применить правило на заданных ини-файлах
void RenameRule_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF29EE03D8_45C0CD8803C8*
	IniConverter::Section* section = old_file->get_cached_section (this->get_section_name ());
	if (!section) {
		return;
	}
	IniConverter::Parameter* old_parameter = section->get_cached_parameter (m_old_name.c_str ());
	if (!old_parameter) {
		return;
	}
	IniConverter::Parameter_var renamed_parameter = IniConverter::ParameterFactory::make (
			m_new_name.c_str ()
			, old_parameter->get_value ().c_str ()
			, old_parameter->get_state ()
			, old_parameter->get_delimiter ()
	);
	section->delete_parameter (m_old_name.c_str ());
	section->add_parameter (renamed_parameter._retn ());
	//#UC END# *45BF29EE03D8_45C0CD8803C8*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

