////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/ProxyConsumer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::ProxyConsumer
//
// Дополнительный получатель сообщений, имеющий связь с основным получателем. Решает следующее
// проблемы:
// 1. потому-что внутри фаер эвент основной получатель может быть уничтожен (типа: поймали
// сообщение - убей себя, такое бывает при апдейте)
// 2.  если объект стал дестроится из другого потока, то ТАО переходит в такое хитрое состояние -
// запрещение апколлов. А так как до конца умереть он не может, т.к. мешает захваченый здесь
// m_mutex, то состояние сохраняется и любой удаленный вызов внутри этого фаер эвент приводит к
// зависанию.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/ProxyConsumer.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"
// by <<uses>> dependencies
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"
// by <<friend>> dependencies
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"

namespace GSI {
namespace NotifyService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор, в котором сразу связываемся с основным получателем
ProxyConsumer::ProxyConsumer (Consumer_i* consumer)
//#UC START# *44F2D36603B9_BASE_INIT*
: m_real_consumer (consumer)
//#UC END# *44F2D36603B9_BASE_INIT*
{
	//#UC START# *44F2D36603B9_BODY*
	//#UC END# *44F2D36603B9_BODY*
}

ProxyConsumer::~ProxyConsumer () {
	//#UC START# *44A11A37004E_DESTR_BODY*
	if (0 != m_real_consumer) {
		GDS_ASSERT_MSG (false, ("NotifyService::ProxyConsumer::~ProxyConsumer: consumer not call stop_listen, try to continue"));
		this->stop_listen ();
	}
	//#UC END# *44A11A37004E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// зовется корбовским листенером для обработки пришедшего сообщения
void ProxyConsumer::push_event (const CORBA::Any& event) {
	//#UC START# *44F2C316024A*
	GUARD (m_mutex);
	if (m_real_consumer) {
		Core::Var<Consumer_i> to_avoid_consumer_destruction_while_fire_event (Core::IObject::_duplicate (m_real_consumer)); 

		//ses: зачем это нужно здесь
		// 1. потому-что внутри этого фаер эвент this может быть уничтожен (типа: поймали сообщение - убей себя, такое бывает при апдейте)
		// 2. если объект стал дестроится из другого потока, то ТАО переходит в такое хитрое состояние - запрещение апколлов.
		// А так как до конца умереть он не может, т.к. мешает захваченый здесь m_mutex, то состояние сохраняется
		// и любой удаленный вызов внутри этого фаер эвент приводит к зависанию
		// больше пока ничего не вспомнил.

		try {
			m_real_consumer->fire_event (event);
		} catch (...) {
			GDS_ASSERT ((false, "Error in fire_event"));
		}
	}
	//#UC END# *44F2C316024A*
}

// прикращаем принимать сообщения из корбовского листенера
void ProxyConsumer::stop_listen () {
	//#UC START# *44F2C3300315*
	{
		GUARD (m_mutex);
		m_real_consumer = 0;
	}
	ManagerLocalFactory::make ().unregister (this);
	//#UC END# *44F2C3300315*
}

} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

