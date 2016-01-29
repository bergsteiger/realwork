////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::SplashScreen_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

//#UC START# *45EE7F5603BF_CUSTOM_INCLUDES*
#include "garantServer/src/Business/GblLogging/Client/CPUInfo.h"
//#UC END# *45EE7F5603BF_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45EE7F5603BF*
//#UC END# *45EE7F5603BF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SplashScreen_i::SplashScreen_i (bool is_start, short x, short y, bool flash_available)
//#UC START# *45ED939E0218_45EE72F301B5_45EE7F5603BF_BASE_INIT*
//#UC END# *45ED939E0218_45EE72F301B5_45EE7F5603BF_BASE_INIT*
{
	//#UC START# *45ED939E0218_45EE72F301B5_45EE7F5603BF_BODY*
	GblPilotDef::ScreenResolution resolution;
	resolution.m_height = y;
	resolution.m_width = x;

	try {
		GblPilot::SplashImage_var pilot_splash_image (
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_login_info ()
		);
		const size_t min_cpu_speed = 1000;
		bool flash_available_and_cpu_is_cool = flash_available & (CPUInfo ().get_speed () >= min_cpu_speed);

		m_splash_image_info = pilot_splash_image->get_image (is_start, resolution, flash_available_and_cpu_is_cool);
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (...) {
		GDS_ASSERT (false);
		throw CanNotFindData ();
	}
	//#UC END# *45ED939E0218_45EE72F301B5_45EE7F5603BF_BODY*
}

SplashScreen_i::~SplashScreen_i () {
	//#UC START# *45EE7F5603BF_DESTR_BODY*
	//#UC END# *45EE7F5603BF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from SplashScreen
const GCI::IO::String* SplashScreen_i::get_owner () const {
	//#UC START# *45ED94BD03BC_45EE7F5603BF_GET*
	return GCI::IO::StringFactory::make (m_splash_image_info->m_company.in ());
	//#UC END# *45ED94BD03BC_45EE7F5603BF_GET*
}

// implemented method from SplashScreen
const GCI::IO::String* SplashScreen_i::get_owner_caption () const {
	//#UC START# *45ED94A6015B_45EE7F5603BF_GET*
	return GCI::IO::StringFactory::make (m_splash_image_info->m_title.in ());
	//#UC END# *45ED94A6015B_45EE7F5603BF_GET*
}

// implemented method from SplashScreen
short SplashScreen_i::get_show_time () const {
	//#UC START# *45ED94710052_45EE7F5603BF_GET*
	return m_splash_image_info->m_time;
	//#UC END# *45ED94710052_45EE7F5603BF_GET*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ExternalObject
// Указатель на буфер с данными.
const void* SplashScreen_i::get_data_pointer () const {
	//#UC START# *45ED932A0047_45EE7F5603BF_GET*
	return m_splash_image_info->m_blob.m_data.get_buffer ();
	//#UC END# *45ED932A0047_45EE7F5603BF_GET*
}

void* SplashScreen_i::get_data_pointer () {
	return const_cast<void*>(((const SplashScreen_i*)this)->get_data_pointer ());
}

// overloaded method from ExternalObject
// Общий размер возвращаемых данных.
unsigned long SplashScreen_i::get_data_size () const {
	//#UC START# *45ED932A0046_45EE7F5603BF_GET*
	return m_splash_image_info->m_blob.m_data.length ();
	//#UC END# *45ED932A0046_45EE7F5603BF_GET*
}

// overloaded method from ExternalObject
ExternalObjectType SplashScreen_i::get_data_type () const {
	//#UC START# *45ED93C9017C_45EE7F5603BF_GET*
	return EOT_PIC;
	//#UC END# *45ED93C9017C_45EE7F5603BF_GET*
}

// overloaded method from ExternalObject
// Имя внешнего объекта.
const GCI::IO::String* SplashScreen_i::get_name () const {
	//#UC START# *45ED932A0048_45EE7F5603BF_GET*
	return GCI::IO::StringFactory::make ("");
	//#UC END# *45ED932A0048_45EE7F5603BF_GET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

