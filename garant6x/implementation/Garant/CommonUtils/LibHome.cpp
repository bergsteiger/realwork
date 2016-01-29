////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::CommonUtils
//
// общий код
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/CommonUtils/LibHome.h"
#include "garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i_factory.h"

namespace CommonUtils {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *447878CD0121_ENVIRONMENTS_CONFIG*
	//#UC END# *447878CD0121_ENVIRONMENTS_CONFIG*

	{
		XML_i::XMLReader_i_factory_var fctr = new XML_i::XMLReader_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace CommonUtils

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
