////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::Searcher2Impl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/LibHome.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl.h"
// by <<uses>> dependencies
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Searcher2Impl::Searcher2Impl ()
//#UC START# *541AB3640200_541AB3ED00FA_541AB80F024A_BASE_INIT*
//#UC END# *541AB3640200_541AB3ED00FA_541AB80F024A_BASE_INIT*
{
	//#UC START# *541AB3640200_541AB3ED00FA_541AB80F024A_BODY*
	//#UC END# *541AB3640200_541AB3ED00FA_541AB80F024A_BODY*
}

Searcher2Impl::~Searcher2Impl () {
	//#UC START# *541AB80F024A_DESTR_BODY*
	//#UC END# *541AB80F024A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Gardocs::Searcher2
Gardocs::GardocList* Searcher2Impl::get_notop_created_since (
	const GCI::IO::DateTimeBox& date
	, long count
	, const char* partnerId
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *541AB396009A_541AB80F024A*
	Core::Aptr<Gardocs::GardocList> ret = new Gardocs::GardocList();
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::Searcher2> action;

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->get_notop_created_since (
			DataConverter::total_second_since_1st_jan_1970 (date)
			, count
			, partnerId
		);

		for (CORBA::ULong i = 0; i < response->length(); i++) {
			ret->push_back (DataConverter::make_adapter_gardoc (response->operator[](i)));
		}
		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret.forget();
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *541AB396009A_541AB80F024A*
}

// implemented method from Gardocs::Searcher2
Gardocs::GardocList* Searcher2Impl::get_top_created_since (
	const GCI::IO::DateTimeBox& date
	, long count
	, const char* partnerId
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *541AB38E025D_541AB80F024A*
	Core::Aptr<Gardocs::GardocList> ret = new Gardocs::GardocList();
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::Searcher2> action;

		ArchiGate::DocCardRemote::GardocList_var response = action.impl->get_top_created_since (
			DataConverter::total_second_since_1st_jan_1970 (date)
			, count
			, partnerId
		);

		for (CORBA::ULong i = 0; i < response->length(); i++) {
			ret->push_back (DataConverter::make_adapter_gardoc (response->operator[](i)));
		}
		LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
		return ret.forget();
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *541AB38E025D_541AB80F024A*
}
} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

