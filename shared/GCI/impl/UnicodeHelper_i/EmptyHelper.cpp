////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/EmptyHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::EmptyHelper
//
// Заглушка, не выполняющая дополнительных преобразований
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/UnicodeHelper_i/EmptyHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EmptyHelper::EmptyHelper ()
//#UC START# *4869FDE10378_486A077002FA_486A0709027E_BASE_INIT*
//#UC END# *4869FDE10378_486A077002FA_486A0709027E_BASE_INIT*
{
	//#UC START# *4869FDE10378_486A077002FA_486A0709027E_BODY*
	//#UC END# *4869FDE10378_486A077002FA_486A0709027E_BODY*
}

EmptyHelper::~EmptyHelper () {
	//#UC START# *486A0709027E_DESTR_BODY*
	//#UC END# *486A0709027E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UnicodeHelper::ConverterHelper
// дополнительные (специфический для локали) преобразования
void EmptyHelper::add_specific (wchar_t* buffer) const {
	//#UC START# *4869FE9D0252_486A0709027E*
	//#UC END# *4869FE9D0252_486A0709027E*
}

// implemented method from UnicodeHelper::ConverterHelper
// удаляет из Unicode-строки дополнителное, специфическое для локали преобразование
const std::wstring EmptyHelper::remove_specific (const std::wstring& in) const {
	//#UC START# *486A03D2026B_486A0709027E*
	return in;
	//#UC END# *486A03D2026B_486A0709027E*
}
} // namespace UnicodeHelper_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

