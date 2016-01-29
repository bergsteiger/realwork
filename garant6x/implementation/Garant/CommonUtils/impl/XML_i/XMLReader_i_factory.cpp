////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::CommonUtils::XML_i::XMLReader_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i_factory.h"
#include "garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i.h"

namespace CommonUtils {
namespace XML_i {

XMLReader_i_factory::XMLReader_i_factory () {
}

void XMLReader_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	XML::XMLReaderFactoryManager::register_factory (this, priority);
}

const char* XMLReader_i_factory::key () const {
	return "XMLReader_i";
}

XML::XMLReader* XMLReader_i_factory::make () {
	return Core::IObject::_duplicate (XMLReader_i::Singleton::instance());
}

} // namespace XML_i
} // namespace CommonUtils

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

