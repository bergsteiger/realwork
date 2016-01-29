////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/GarantWinLocaleOperations.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::GarantWinLocaleOperations
//
// � ��������� ����������� setlocale �������� �� ������ ��� ��������� �������� ������, ������� ����
// WinLocaleOperations ��� ������ �� GarantWinLocaleOperations. ��. [$111739591].
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

namespace GCI {
namespace I18N_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GarantWinLocaleOperations::GarantWinLocaleOperations ()
//#UC START# *452F6A8F0148_48F6F9050118_48F6F1B102AD_BASE_INIT*
: m_win_locale (I18N::SL_RU_CP1251)
//#UC END# *452F6A8F0148_48F6F9050118_48F6F1B102AD_BASE_INIT*
{
	//#UC START# *452F6A8F0148_48F6F9050118_48F6F1B102AD_BODY*
	//#UC END# *452F6A8F0148_48F6F9050118_48F6F1B102AD_BODY*
}

GarantWinLocaleOperations::~GarantWinLocaleOperations () {
	//#UC START# *48F6F1B102AD_DESTR_BODY*
	//#UC END# *48F6F1B102AD_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from I18N::LocaleOperations
// ���������� ������� ������
I18N::SupportedLocales GarantWinLocaleOperations::get_locale () const {
	//#UC START# *452F720B00CB_48F6F1B102AD*
	return m_win_locale;
	//#UC END# *452F720B00CB_48F6F1B102AD*
}

// implemented method from I18N::LocaleOperations
// ������������� ������� ������.
void GarantWinLocaleOperations::set_locale (I18N::SupportedLocales locale) {
	//#UC START# *452F71DA0203_48F6F1B102AD*
	m_win_locale = locale;
	//#UC END# *452F71DA0203_48F6F1B102AD*
}
} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

