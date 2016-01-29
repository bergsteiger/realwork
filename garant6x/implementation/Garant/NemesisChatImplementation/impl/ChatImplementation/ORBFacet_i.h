////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ORBFacet_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::ORBFacet_i
//
// реализация ORBFacet для нужд старого GCM
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_ORBFACET_I_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_ORBFACET_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Root/Root.h"

//#UC START# *4A2F5A910254_CUSTOM_INCLUDES*
//#UC END# *4A2F5A910254_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

// реализация ORBFacet для нужд старого GCM
class ORBFacet_i;
typedef Core::Var<ORBFacet_i> ORBFacet_i_var;
typedef Core::Var<const ORBFacet_i> ORBFacet_i_cvar;

class ORBFacet_i :
	virtual public CoreSrv::Root::OrbAcsessor
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ORBFacet_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// создать реализацию фасета
	ORBFacet_i ();

public:
	virtual ~ORBFacet_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CoreSrv::Root::OrbAcsessor
	// Основной ORB
	virtual CORBA::ORB& get_main_orb () const;

	// implemented method from CoreSrv::Root::OrbAcsessor
	// Рутовый объект контекста Name Service-а
	virtual CosNaming::NamingContext& get_ns_root () const;

	// implemented method from CoreSrv::Root::OrbAcsessor
	// Объект текущего контекста PICurrent
	virtual PortableInterceptor::Current& get_pi_current () const;

	// implemented method from CoreSrv::Root::OrbAcsessor
	// Рутовый POA
	virtual PortableServer::POA& get_root_poa () const;

//#UC START# *4A2F5A910254*
//#UC END# *4A2F5A910254*
}; // class ORBFacet_i

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_ORBFACET_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

