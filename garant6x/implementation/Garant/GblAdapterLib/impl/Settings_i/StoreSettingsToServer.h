////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/StoreSettingsToServer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Settings_i::StoreSettingsToServer
//
// ����� ������������ ������������ ��������� ��������� �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_STORESETTINGSTOSERVER_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_STORESETTINGSTOSERVER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/Common/TimerHelper.h"

namespace GblAdapterLib {

// ����� ������������ ������������ ��������� ��������� �� ������
class StoreSettingsToServer :
	virtual public GCL::TimerHelper
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~StoreSettingsToServer ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from GCL::TimerHelper
	virtual int handler (const void* data);
}; // class StoreSettingsToServer

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_STORESETTINGSTOSERVER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

