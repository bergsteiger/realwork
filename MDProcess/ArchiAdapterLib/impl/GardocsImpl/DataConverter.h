////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::DataConverter
//
// DataConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_DATACONVERTER_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_DATACONVERTER_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4E9319DF02E4_CUSTOM_INCLUDES*
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"

/*struct InvocationAspect {
	ArchiGate::DocCardRemote::Searcher_var impl;
	InvocationAspect () {
		CoreSrv::SessionFactory::get().login ("architester", "6v2K3024");
		impl = ArchiGate::DocCardRemote::SearcherFactory::make();
	}
	~InvocationAspect () {
		impl->release();
		CoreSrv::SessionFactory::get().logout ();
	}
};*/
namespace Core {	
template <>
struct TypeTraits <ArchiGate::DocCardRemote::Searcher> {
	typedef ArchiGate::DocCardRemote::SearcherFactory Factory;
};

template <>
struct TypeTraits <ArchiGate::DocCardRemote::Searcher2> {
	typedef ArchiGate::DocCardRemote::Searcher2Factory Factory;
};

template <>
struct TypeTraits <ArchiGate::DocCardRemote::ArchiEventsListener> {
	typedef ArchiGate::DocCardRemote::ArchiEventsListenerFactory Factory;
};

template <>
struct TypeTraits <ArchiGate::DocCardRemote::Utils> {
	typedef ArchiGate::DocCardRemote::UtilsFactory Factory;
};

template <>
struct TypeTraits <ArchiGate::DocCardRemote::GardocGetter> {
	typedef ArchiGate::DocCardRemote::GardocGetterFactory Factory;
};
}

template<typename T>
struct InvocationAspect {
	TAO_Objref_Var_T<T> impl;

	InvocationAspect () {
		//CoreSrv::SessionFactory::get().login ("architester", "6v2K3024");

		CoreSrv::SessionFactory::get().login (
			Core::ParamManagerFactory::get ().get_string ("-login")
			, Core::ParamManagerFactory::get ().get_string ("-password")
			);

		impl = Core::TypeTraits<T>::Factory::make();
	}
	~InvocationAspect () {
		impl->release();
		CoreSrv::SessionFactory::get().logout ();
	}
};

//#UC END# *4E9319DF02E4_CUSTOM_INCLUDES*

namespace ArchiAdapterLib {
namespace GardocsImpl {

// DataConvertor
class DataConverter {
	SET_OBJECT_COUNTER (DataConverter)

//#UC START# *4E9319DF02E4*
public:
	static ArchiGate::DocCardRemote::Gardoc make_remote_gardoc (const Gardocs::Gardoc& gardoc_remote);
	static Gardocs::Gardoc make_adapter_gardoc (const ArchiGate::DocCardRemote::Gardoc& gardoc_remote);
	static long long total_second_since_1st_jan_1970 (const GCI::IO::DateTimeBox& date);
	static GCI::IO::DateTimeBox from_total_second_since_1st_jan_1970 (long long total_second);
	static Gardocs::GardocList* make_adapter_gardoc_list (const ArchiGate::DocCardRemote::GardocList* gardoc_list_remote);
//#UC END# *4E9319DF02E4*
}; // class DataConverter

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_DATACONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

