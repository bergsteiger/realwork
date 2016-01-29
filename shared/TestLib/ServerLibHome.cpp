////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestLib/ServerLibHome.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::TestLib
//
// Тестирующая библиотека
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/TestLib/ServerLibHome.h"
#include "shared/TestLib/impl/NewImpl/Auth_i_factory.h"
#include "shared/TestLib/DummyTest.h"

namespace TestLib {

Core::Root::LibHome& ServerLibHomeFactory::get () {
	return ServerLibHomeImpl::Singleton::instance();
}

ServerLibHomeImpl::ServerLibHomeImpl () {
	this->set_requested_status (Core::Root::ES_IDLE);
	this->get_executors ().insert (&DummyTest::get ());
}

void ServerLibHomeImpl::registrate_all_factories () const {
	//#UC START# *45D6DAC9026F_ENVIRONMENTS_CONFIG*
	//#UC END# *45D6DAC9026F_ENVIRONMENTS_CONFIG*

	{
		NewImpl::Auth_i_factory_var fctr = new NewImpl::Auth_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void ServerLibHomeImpl::finalize () {
}
} // namespace TestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
