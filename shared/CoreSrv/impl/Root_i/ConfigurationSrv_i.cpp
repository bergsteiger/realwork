////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/Root_i/ConfigurationSrv_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::ConfigurationSrv_i
//
// ��������� ������� (���� ���������� ��������� ����������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/impl/Root_i/ConfigurationSrv_i.h"
// by <<uses>> dependencies
#include "shared/CoreSrv/Root/ServerSettings.h"

namespace CoreSrv {
namespace Root_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConfigurationSrv_i::ConfigurationSrv_i ()
//#UC START# *458EBECE021C_458EBEEB0122_45FF9ECE032C_BASE_INIT*
//#UC END# *458EBECE021C_458EBEEB0122_45FF9ECE032C_BASE_INIT*
{
	//#UC START# *458EBECE021C_458EBEEB0122_45FF9ECE032C_BODY*
	this->info().use_corba = true;
	this->info().server_side = true;
	try {
		this->info().server_side = Root::ServerSettings::get_orb_init_ref ().empty ();
	} catch (Core::ParameterIsMissing&) {
	}
	//#UC END# *458EBECE021C_458EBEEB0122_45FF9ECE032C_BODY*
}

ConfigurationSrv_i::~ConfigurationSrv_i () {
	//#UC START# *45FF9ECE032C_DESTR_BODY*
	//#UC END# *45FF9ECE032C_DESTR_BODY*
}


} // namespace Root_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

