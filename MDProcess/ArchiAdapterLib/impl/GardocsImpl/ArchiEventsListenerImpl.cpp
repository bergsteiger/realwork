////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::ArchiEventsListenerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/LibHome.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/ArchiEventsListenerImpl.h"
// by <<uses>> dependencies
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ArchiEventsListenerImpl::ArchiEventsListenerImpl ()
//#UC START# *4E8F2E020146_4E8F4243005A_4E8F4EC0036E_BASE_INIT*
//#UC END# *4E8F2E020146_4E8F4243005A_4E8F4EC0036E_BASE_INIT*
{
	//#UC START# *4E8F2E020146_4E8F4243005A_4E8F4EC0036E_BODY*
	//#UC END# *4E8F2E020146_4E8F4243005A_4E8F4EC0036E_BODY*
}

ArchiEventsListenerImpl::~ArchiEventsListenerImpl () {
	//#UC START# *4E8F4EC0036E_DESTR_BODY*
	//#UC END# *4E8F4EC0036E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Gardocs::ArchiEventsListener
// проинформировать К о наступлении события
void ArchiEventsListenerImpl::on_event (
	const Gardocs::ArchiEvent& event
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *4E8F2EDD0294_4E8F4EC0036E*
	try {
		InvocationAspect<ArchiGate::DocCardRemote::ArchiEventsListener> action;
		ArchiGate::DocCardRemote::ArchiEvent out;
		out.type = event.type.in()->get_data();
		out.doc = DataConverter::make_remote_gardoc (event.doc);

		action.impl->on_event (out);
	} catch (...) {
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *4E8F2EDD0294_4E8F4EC0036E*
}
} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

