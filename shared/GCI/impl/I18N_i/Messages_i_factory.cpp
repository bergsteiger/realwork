////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/Messages_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::Messages_i
//
// ���������� ������ � ��������������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/I18N_i/Messages_i_factory.h"
#include "shared/GCI/impl/I18N_i/Messages_i.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

namespace GCI {
namespace I18N_i {

Messages_i_factory::Messages_i_factory () {
}

void Messages_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	I18N::MessagesFactoryManager::register_factory (this, priority);
}

const char* Messages_i_factory::key () const {
	return "Messages_i";
}

// ������� ��� ��������� �������, ������������ ��������� Messages
I18N::Messages* Messages_i_factory::messages () {
	//#UC START# *452CBFC401C5452CCF1602FD_452CC6FF03D8_IMPL*
	Messages_i* messages = new Messages_i ();
	messages->m_default_locale = Environment::get_default_locale ();

	return messages;
	//#UC END# *452CBFC401C5452CCF1602FD_452CC6FF03D8_IMPL*
}

} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

