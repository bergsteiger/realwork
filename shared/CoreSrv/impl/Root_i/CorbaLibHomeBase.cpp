////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/CorbaLibHomeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaLibHomeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeBase.h"

namespace CoreSrv {
namespace Root_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CorbaLibHomeBase::CorbaLibHomeBase ()
//#UC START# *461E2FA500B9_BASE_INIT*
//#UC END# *461E2FA500B9_BASE_INIT*
{
	//#UC START# *461E2FA500B9_BODY*
	//#UC END# *461E2FA500B9_BODY*
}

CorbaLibHomeBase::~CorbaLibHomeBase () {
	//#UC START# *457EA57001A1_DESTR_BODY*
	//#UC END# *457EA57001A1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Root::CorbaLibHome
// доступ к объектам инфраструктуры ORB-а
const Root::OrbAcsessor& CorbaLibHomeBase::get_orb_facet () const {
	//#UC START# *4933DA4C00D1_457EA57001A1_GET*
	if (m_orb_facet.ptr()) {
		return *m_orb_facet;
	} else {
		throw Core::Root::CachedAttrUninitialized ("CorbaLibHomeBase::orb_facet");
	}
	//#UC END# *4933DA4C00D1_457EA57001A1_GET*
}

Root::OrbAcsessor& CorbaLibHomeBase::get_orb_facet () {
	return const_cast<Root::OrbAcsessor&>(((const CorbaLibHomeBase*)this)->get_orb_facet ());
}

// implemented method from Root::CorbaLibHome
// Объект инициализации ORB-а (для регистрации интерцепторов)
PortableInterceptor::ORBInitializer* CorbaLibHomeBase::get_orb_initializer () const {
	//#UC START# *45E705BD01C5_457EA57001A1_GET*
	return 0;
	//#UC END# *45E705BD01C5_457EA57001A1_GET*
}

// implemented method from CorbaLibHomeLocal
// доступ к объектам инфраструктуры ORB-а
void CorbaLibHomeBase::set_orb_facet (Root::OrbAcsessor* orb_facet) {
	//#UC START# *4933DA99002F_457EA57001A1_SET*
	m_orb_facet = Root::OrbAcsessor::_duplicate(orb_facet);
	m_home_poa = 0;
	//#UC END# *4933DA99002F_457EA57001A1_SET*
}

// implemented method from CorbaLibHomeLocal
// в этом кал-бек методе дожны быть зарегистрированны в NS все каналы событий, определяемых
// библиотекой
void CorbaLibHomeBase::publish_all_event_channel () {
	//#UC START# *492FF2DA02AF_457EA57001A1*
	//#UC END# *492FF2DA02AF_457EA57001A1*
}

// implemented method from CorbaLibHomeLocal
// в этом кал-бек методе дожны быть заоегистрированны в NS все импортируемые серверные фабрики
void CorbaLibHomeBase::publish_all_servers_factories () const {
	//#UC START# *492FF2E102E3_457EA57001A1*
	//#UC END# *492FF2E102E3_457EA57001A1*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Core::Root_i::LibHomeLocal
// вызывается фреймворком для освобождения всех ресурсов билиотеки и выполнения де-
// инициализационных действий, перед удалением билиотеки
void CorbaLibHomeBase::finalize () {
	//#UC START# *492FEBE902F5_457EA57001A1*
	if (m_home_poa.ptr()) {
		m_home_poa->destroy(true, true);
		m_home_poa = 0;
	}
	//#UC END# *492FEBE902F5_457EA57001A1*
}

} // namespace Root_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

