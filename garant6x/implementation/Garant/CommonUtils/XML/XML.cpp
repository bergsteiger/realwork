////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/CommonUtils/XML/XML.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::CommonUtils::XML
//
// ��������� ��� ������ XML �� ������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XML.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XMLFactories.h"

namespace CommonUtils {
namespace XML {


const char* BadXMLFormat::uid () const /*throw ()*/ {
	return "4D709E6C-C465-4167-9AA0-1BEC4989CE32";
}

const char* BadXMLFormat::what () const throw () {
	//#UC START# *443CFC3703B9_WHAT_IMPL*
	return "BadXMLFormat (���������� ������������, ���� �� ������ ��������� xml)";
	//#UC END# *443CFC3703B9_WHAT_IMPL*
}

// factory interface wrapper for XMLReader
XMLReader* XMLReaderFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return XMLReaderFactoryManager::Singleton::instance ()->make ();
}

} // namespace XML
} // namespace CommonUtils

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

