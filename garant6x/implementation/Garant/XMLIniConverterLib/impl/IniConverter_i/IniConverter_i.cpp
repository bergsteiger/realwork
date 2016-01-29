////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::XMLIniConverterLib::IniConverter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"


namespace XMLIniConverterLib {
namespace IniConverter_i {

bool IsSectionName::operator () (const IniConverter::Section_var& param_) const {
	//#UC START# *45C311EF030D_IMPL*
	return param_->get_name () == name;
	//#UC END# *45C311EF030D_IMPL*
}


IsSectionName::IsSectionName (const char* name_) : name(name_) {
	//#UC START# *45C311EF030D_INIT_CTOR*
	//#UC END# *45C311EF030D_INIT_CTOR*
}


} //namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

