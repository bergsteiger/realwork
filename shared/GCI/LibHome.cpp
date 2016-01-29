////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::GCI
//
// Garant Common Interfaces - общие интерфейсы повторного использования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/IO_i/Stream_i_factory.h"
#include "shared/GCI/impl/IO_i/String_i_factory.h"
#include "shared/GCI/impl/IO_i/MSDNStreamWrapper_factory.h"
#include "shared/GCI/impl/IO_i/BinaryString_i_factory.h"
#include "shared/GCI/impl/MathImpl/CalculatorImpl_factory.h"
#include "shared/GCI/impl/I18N_i/Messages_i_factory.h"
#include "shared/GCI/impl/I18N_i/WinLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.h"
#include "shared/GCI/impl/UnicodeHelper_i/TatarHelper_factory.h"
#include "shared/GCI/impl/UnicodeHelper_i/EmptyHelper_factory.h"
#include "shared/GCI/impl/MMapWin32/FileForMemImpl_factory.h"
#include "shared/GCI/impl/MMapComImpl/MemoryPoolImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/CPUInfo_factory.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/PhysicalMemoryInfoImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoWin32Impl/ProcessMemoryInfoImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoImpl/CPUInfo_factory.h"
#include "shared/GCI/impl/ResourceInfoImpl/PhysicalMemoryInfoImpl_factory.h"
#include "shared/GCI/impl/ResourceInfoImpl/ProcessMemoryInfoImpl_factory.h"

namespace GCI {

namespace {
	template <typename T>
	bool check_param (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			try {
				boost::lexical_cast<T> (value);
			} catch (boost::bad_lexical_cast&) {
				res = false;
				LOG_E (("Неверное значение параметра %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("Не задан обязательный параметр: %s", key));
		}
		
		return res;
	}
	
	template <>
	bool check_param<std::string> (const char* key, bool is_requared) {
		if (is_requared && !Core::ParamManagerFactory::get ().is_exist (key)) {
			LOG_E(("Не задан обязательный параметр <%s>", key));
			return false;
		}
		return true;
	}
	
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *447878770121_ENVIRONMENTS_CONFIG*
	//#UC END# *447878770121_ENVIRONMENTS_CONFIG*

	{
		IO_i::Stream_i_factory_var fctr = new IO_i::Stream_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IO_i::String_i_factory_var fctr = new IO_i::String_i_factory ();
		fctr->registrate_me(0);
	}
	
	//#UC START# *447878770121_CUSTOM_REGISTRATE_FOR_476263570115_MSDNStreamWrapper*
	//#UC END# *447878770121_CUSTOM_REGISTRATE_FOR_476263570115_MSDNStreamWrapper*
	
	{
		IO_i::BinaryString_i_factory_var fctr = new IO_i::BinaryString_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MathImpl::CalculatorImpl_factory_var fctr = new MathImpl::CalculatorImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		I18N_i::Messages_i_factory_var fctr = new I18N_i::Messages_i_factory ();
		fctr->registrate_me(0);
	}
	
	//#UC START# *447878770121_CUSTOM_REGISTRATE_FOR_48F6F14900DE_WinLocaleOperations*
#if defined (WIN32)
	{
		I18N_i::GarantWinLocaleOperations_factory_var fctr = new I18N_i::GarantWinLocaleOperations_factory ();
		try {	
			fctr->registrate_me(0);
		} catch (Core::Root::DuplicatedFactoryKey&) {}
	}
#endif
	//#UC END# *447878770121_CUSTOM_REGISTRATE_FOR_48F6F14900DE_WinLocaleOperations*
	
	//#UC START# *447878770121_CUSTOM_REGISTRATE_FOR_48F6F18501B0_PosixLocaleOperations*
#if !defined (WIN32)
	{
		I18N_i::PosixLocaleOperations_factory_var fctr = new I18N_i::PosixLocaleOperations_factory ();
		try {	
			fctr->registrate_me(0);
		} catch (Core::Root::DuplicatedFactoryKey&) {}
	}
#endif
	//#UC END# *447878770121_CUSTOM_REGISTRATE_FOR_48F6F18501B0_PosixLocaleOperations*
	
	//#UC START# *447878770121_CUSTOM_REGISTRATE_FOR_48F6F1B102AD_GarantWinLocaleOperations*
	//#UC END# *447878770121_CUSTOM_REGISTRATE_FOR_48F6F1B102AD_GarantWinLocaleOperations*
	
	{
		UnicodeHelper_i::TatarHelper_factory_var fctr = new UnicodeHelper_i::TatarHelper_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UnicodeHelper_i::EmptyHelper_factory_var fctr = new UnicodeHelper_i::EmptyHelper_factory ();
		fctr->registrate_me(0);
	}
	
	#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
	{
		MMapWin32::FileForMemImpl_factory_var fctr = new MMapWin32::FileForMemImpl_factory ();
		fctr->registrate_me(0);
	}
	#endif //WIN32 && _WIN32_WINNT>=0x0500
	
	#if defined(WIN32)
	{
		MMapComImpl::MemoryPoolImpl_factory_var fctr = new MMapComImpl::MemoryPoolImpl_factory ();
		fctr->registrate_me(0);
	}
	#endif //WIN32
	
	#if defined(WIN32)
	{
		ResourceInfoWin32Impl::CPUInfo_factory_var fctr = new ResourceInfoWin32Impl::CPUInfo_factory ();
		fctr->registrate_me(0);
	}
	#endif //WIN32
	
	#if defined(WIN32)
	{
		ResourceInfoWin32Impl::PhysicalMemoryInfoImpl_factory_var fctr = new ResourceInfoWin32Impl::PhysicalMemoryInfoImpl_factory ();
		fctr->registrate_me(0);
	}
	#endif //WIN32
	
	#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0) && defined(WIN32)
	{
		ResourceInfoWin32Impl::ProcessMemoryInfoImpl_factory_var fctr = new ResourceInfoWin32Impl::ProcessMemoryInfoImpl_factory ();
		fctr->registrate_me(0);
	}
	#endif //ACE_HAS_WINNT4!=0 && WIN32
	
	#if !defined(WIN32)
	{
		ResourceInfoImpl::CPUInfo_factory_var fctr = new ResourceInfoImpl::CPUInfo_factory ();
		fctr->registrate_me(0);
	}
	#endif //!WIN32
	
	#if !defined(WIN32)
	{
		ResourceInfoImpl::PhysicalMemoryInfoImpl_factory_var fctr = new ResourceInfoImpl::PhysicalMemoryInfoImpl_factory ();
		fctr->registrate_me(0);
	}
	#endif //!WIN32
	
	#if !defined(WIN32)
	{
		ResourceInfoImpl::ProcessMemoryInfoImpl_factory_var fctr = new ResourceInfoImpl::ProcessMemoryInfoImpl_factory ();
		fctr->registrate_me(0);
	}
	#endif //!WIN32
	
}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-LocalePath: (string)    - определяет используемую локаль\n";


}

bool LibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-LocalePath", false);

	return res;
}
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
