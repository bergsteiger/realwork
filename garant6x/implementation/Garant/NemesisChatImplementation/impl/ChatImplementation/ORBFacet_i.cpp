////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ORBFacet_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::ORBFacet_i
//
// реализация ORBFacet для нужд старого GCM
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ORBFacet_i.h"

//#UC START# *4A2F5A910254_CUSTOM_INCLUDES*
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Core/Common/GCMManager_i.h"
//#UC END# *4A2F5A910254_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

//#UC START# *4A2F5A910254*
//#UC END# *4A2F5A910254*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создать реализацию фасета
ORBFacet_i::ORBFacet_i ()
//#UC START# *4A2F6A7101EA_BASE_INIT*
//#UC END# *4A2F6A7101EA_BASE_INIT*
{
	//#UC START# *4A2F6A7101EA_BODY*
	//#UC END# *4A2F6A7101EA_BODY*
}

ORBFacet_i::~ORBFacet_i () {
	//#UC START# *4A2F5A910254_DESTR_BODY*
	//#UC END# *4A2F5A910254_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CoreSrv::Root::OrbAcsessor
// Основной ORB
CORBA::ORB& ORBFacet_i::get_main_orb () const {
	//#UC START# *458115C00148_4A2F5A910254_GET*
	return *GCM::get_cached_orb ();
	//#UC END# *458115C00148_4A2F5A910254_GET*
}

// implemented method from CoreSrv::Root::OrbAcsessor
// Рутовый объект контекста Name Service-а
CosNaming::NamingContext& ORBFacet_i::get_ns_root () const {
	//#UC START# *458115CB0399_4A2F5A910254_GET*
	return *GCM::Root::cached_name_service ();
	//#UC END# *458115CB0399_4A2F5A910254_GET*
}

// implemented method from CoreSrv::Root::OrbAcsessor
// Объект текущего контекста PICurrent
PortableInterceptor::Current& ORBFacet_i::get_pi_current () const {
	//#UC START# *45E54A7602DE_4A2F5A910254_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45E54A7602DE_4A2F5A910254_GET*
}

// implemented method from CoreSrv::Root::OrbAcsessor
// Рутовый POA
PortableServer::POA& ORBFacet_i::get_root_poa () const {
	//#UC START# *458115F00271_4A2F5A910254_GET*
	return *GCM::get_cached_root_poa ();
	//#UC END# *458115F00271_4A2F5A910254_GET*
}
} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

