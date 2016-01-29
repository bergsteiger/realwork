////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::GardocGetterImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/LibHome.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl.h"
// by <<uses>> dependencies
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GardocGetterImpl::GardocGetterImpl ()
//#UC START# *54999FFF02C9_5499A00F031A_5499A0B701E7_BASE_INIT*
//#UC END# *54999FFF02C9_5499A00F031A_5499A0B701E7_BASE_INIT*
{
	//#UC START# *54999FFF02C9_5499A00F031A_5499A0B701E7_BODY*
	//#UC END# *54999FFF02C9_5499A00F031A_5499A0B701E7_BODY*
}

GardocGetterImpl::~GardocGetterImpl () {
	//#UC START# *5499A0B701E7_DESTR_BODY*
	//#UC END# *5499A0B701E7_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Gardocs::GardocGetter
Gardocs::GardocList* GardocGetterImpl::gardocs_by_confluenceid_list (
	const Gardocs::LongList& confluenceidList
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *5499A01C011F_5499A0B701E7*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::GardocGetter> action;

		::ArchiGate::DocCardRemote::LongList corbaList (confluenceidList.size());
		for (unsigned int i = 0; i < confluenceidList.size(); i++) {
			corbaList[i] = confluenceidList[i];
		}

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->gardocs_by_confluenceid_list (corbaList);
		Gardocs::GardocList* ret = DataConverter::make_adapter_gardoc_list (response);

		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret;
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *5499A01C011F_5499A0B701E7*
}

// implemented method from Gardocs::GardocGetter
Gardocs::GardocList* GardocGetterImpl::gardocs_by_topic_list (
	const Gardocs::LongList& topicList
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *5499A01B0069_5499A0B701E7*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::GardocGetter> action;

		::ArchiGate::DocCardRemote::LongList corbaList (topicList.size());
		for (unsigned int i = 0; i < topicList.size(); i++) {
			corbaList[i] = topicList[i];
		}

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->gardocs_by_topic_list (corbaList);
		Gardocs::GardocList* ret = DataConverter::make_adapter_gardoc_list (response);

		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret;
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *5499A01B0069_5499A0B701E7*
}
} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

