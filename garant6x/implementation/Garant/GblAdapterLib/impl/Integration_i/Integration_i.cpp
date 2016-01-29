////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Integration_i::Integration_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"

namespace GblAdapterLib {
namespace Integration_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Integration_i::Integration_i ()
//#UC START# *463F4EAD0000_463F5060029F_463F52E6003E_BASE_INIT*
: m_is_integration_enabled (boost::indeterminate)
//#UC END# *463F4EAD0000_463F5060029F_463F52E6003E_BASE_INIT*
{
	//#UC START# *463F4EAD0000_463F5060029F_463F52E6003E_BODY*
	//#UC END# *463F4EAD0000_463F5060029F_463F52E6003E_BODY*
}

Integration_i::~Integration_i () {
	//#UC START# *463F52E6003E_DESTR_BODY*
	//#UC END# *463F52E6003E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

boost::tribool Integration_i::get_is_integration_enabled () const {
	//#UC START# *4AB9D0BA0344_GET_ACCESSOR*
	return m_is_integration_enabled;
	//#UC END# *4AB9D0BA0344_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Integration
// возвращает идентификатор комлекта.
GCI::IO::String* Integration_i::get_integration_complect_id () const /*throw (CanNotFindData)*/ {
	//#UC START# *463F4FA3006D_463F52E6003E*
	try {
		CORBA::String_var complect_id = ApplicationHelper::instance ()->get_cached_integration ()->get_integration_complect_id ();
		return GCI::IO::StringFactory::make (complect_id.in ());
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *463F4FA3006D_463F52E6003E*
}

// implemented method from Integration
// метод возвращает объект по поданному xml-у
IntegrationType Integration_i::get_object_by_xml (
	const char* xml
	, Core::IObject*& result
) const /*throw (
	CanNotFindData
	, InvalidXMLType
	, CantCreateObject
)*/ {
	//#UC START# *463F4FF5032C_463F52E6003E*
	if (!xml) {
		LOG_E (("%s: xml text not found", GDS_CURRENT_FUNCTION));
		throw InvalidXMLType ();
	}
	size_t xml_size = std::strlen (xml);
	if (!xml_size) {
		LOG_E (("%s: empty xml text", GDS_CURRENT_FUNCTION));
		throw InvalidXMLType ();
	}

	GblIntegration::ObjectFromXML_var server_object;
	try {
		server_object = ApplicationHelper::instance ()->get_cached_integration ()->create_object_by_xml (xml, xml_size + 1);
	}  catch (GblIntegration::CantParseXML&) {
		throw InvalidXMLType ();
	}  catch (GblIntegration::ExecutionError&) {
		throw CanNotFindData ();
	}  catch (GblIntegration::CantCreateObject&) {
		throw CantCreateObject ();
	} catch (CORBA::Exception&) {
		throw CanNotFindData ();
	}

	switch (server_object->_d ()) {
		case GblIntegration::IT_BOOKMARK:
			result = ListEntryInfoFactory::make (server_object->bookmark ());
			return GblAdapterLib::IT_LISTENTRYINFO;
		case GblIntegration::IT_LIST:
			{
			GblDocList::DocListTree_var list = server_object->list ();
			result = DynListFactory::make (list._retn ());
			return GblAdapterLib::IT_LIST;
			}
		case GblIntegration::IT_QUERY:
			{
			QueryCreator_var creator (QueryCreatorFactory::make ());
			result = creator->make_query (server_object->query ());
			return GblAdapterLib::IT_QUERY;
			}
		default:
			LOG_E (("%s: unknown server object type", GDS_CURRENT_FUNCTION));
			throw CanNotFindData ();
	}
	//#UC END# *463F4FF5032C_463F52E6003E*
}

// implemented method from Integration
// доступны ли в версии возможности для внешних интеграторов
const bool Integration_i::get_integration_enabled () const {
	//#UC START# *4AB9D0030054_463F52E6003E_GET*
	if (boost::indeterminate (m_is_integration_enabled)) {
		m_is_integration_enabled = ApplicationHelper::instance ()->get_cached_integration ()->integration_enabled ();
	}

	return m_is_integration_enabled;
	//#UC END# *4AB9D0030054_463F52E6003E_GET*
}
} // namespace Integration_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

