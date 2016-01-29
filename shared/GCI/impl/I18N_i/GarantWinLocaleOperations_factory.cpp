////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
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
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

namespace GCI {
namespace I18N_i {

GarantWinLocaleOperations_factory::GarantWinLocaleOperations_factory () {
}

void GarantWinLocaleOperations_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	I18N::LocaleOperationsFactoryManager::register_factory (this, priority);
}

const char* GarantWinLocaleOperations_factory::key () const {
	return "GarantWinLocaleOperations";
}

I18N::LocaleOperations* GarantWinLocaleOperations_factory::make () {
	GarantWinLocaleOperations_var ret = new GarantWinLocaleOperations ();
	return ret._retn ();
}

} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

