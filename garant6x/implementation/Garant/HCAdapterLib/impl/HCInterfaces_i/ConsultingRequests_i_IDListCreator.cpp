////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i_IDListCreator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingRequests_i::IDListCreator
//
// общий код для вычитывания id-шников из потока
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i.h"

//#UC START# *47B156000062_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMElement.hpp"
#include "xercesc/dom/DOMNode.hpp"
#include "xercesc/dom/DOMNodeList.hpp"

#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"
#include "shared/XercesHelpers/wrappers/XMLStrUnicode.h"
//#UC END# *47B156000062_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {
class ConsultingRequests_i;
//#UC START# *47B156000062*
//#UC END# *47B156000062*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

const char* ConsultingRequests_i::IDListCreator::BadXML::uid () const /*throw ()*/ {
	return "BB8277B5-CB0E-404F-9A12-F7FB8BD08EAC";
}

const char* ConsultingRequests_i::IDListCreator::BadXML::what () const throw () {
	//#UC START# *47B157E1025D_WHAT_IMPL*
	return "BadXML (не смогли вычитать xml)";
	//#UC END# *47B157E1025D_WHAT_IMPL*
}




const char* ConsultingRequests_i::IDListCreator::EmptyXML::uid () const /*throw ()*/ {
	return "0D63B0DE-8A9A-4A8C-A577-79EED714D6FA";
}

const char* ConsultingRequests_i::IDListCreator::EmptyXML::what () const throw () {
	//#UC START# *47B15AA30116_WHAT_IMPL*
	return "EmptyXML (в xml нет идентификаторов консультаций)";
	//#UC END# *47B15AA30116_WHAT_IMPL*
}



//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingRequests_i::IDListCreator::IDListCreator (GCI::IO::Stream* data)
//#UC START# *47B1565B01B9_BASE_INIT*
//#UC END# *47B1565B01B9_BASE_INIT*
{
	//#UC START# *47B1565B01B9_BODY*
	size_t data_size = data->seek (0, 2);
	if (!data_size) {
		LOG_E (("%s: empty stream", GDS_CURRENT_FUNCTION));
		throw BadXML ();
	}
	data->seek (0, 0);
	Core::Aptr<char, Core::ArrayDeleteDestructor<char> >  buffer (new char [data_size]);
	size_t len = data->read (buffer.ptr (), data_size);
	if (!len) {
		LOG_E (("%s: can't read data from stream", GDS_CURRENT_FUNCTION));
		throw BadXML ();
	}
	GDS_ASSERT (len == data_size);
	if (len != data_size) {
		LOG_W (("%s: stream size (%d) not equal to readed data size (%d)", GDS_CURRENT_FUNCTION, data_size, len));
	}

	// строим xml
	HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());	
	try {
		XERCES_CPP_NAMESPACE::DOMDocument* doc = m_manager.get_doc (buffer.ptr (), len);
		m_root = doc->getDocumentElement ();
	} catch (...) {
		LOG_E (("%s: can't create DOM tree from stream", GDS_CURRENT_FUNCTION));
		throw BadXML ();
	}
	//#UC END# *47B1565B01B9_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вычитать из xml флаг операции
bool ConsultingRequests_i::IDListCreator::get_force_flag () {
	//#UC START# *47B156B501F1*
	XercesHelpers::DOMNodeEx root_tag (m_root);
	XercesHelpers::XMLStr force_attr (root_tag.get_attribute ("force"));
	if (force_attr.in () && !ACE_OS::strncmp ("yes", force_attr.in (), sizeof ("yes"))) {
		return true;
	}

	return false;
	//#UC END# *47B156B501F1*
}

// получить списки идентификаторов консультаций
void ConsultingRequests_i::IDListCreator::get_unique_id_lists (
	GblConsultingDef::UniqueConsultationIDList& id70
) /*throw (
	EmptyXML
)*/ {
	//#UC START# *47B1578403D1*
	XercesHelpers::XMLStrUnicode query_string ("query");
	XERCES_CPP_NAMESPACE::DOMNodeList* query_list = m_root->getElementsByTagName (query_string.data ());
	size_t list_size = query_list->getLength ();
	if (!list_size) {
		LOG_W (("%s: empty query list", GDS_CURRENT_FUNCTION));
		throw EmptyXML ();
	}

	id70.length (list_size);
	size_t id_list70_size = 0;
	for (size_t i = 0; i < list_size; ++i) {
		XercesHelpers::DOMNodeEx query_tag (query_list->item (i));
		XercesHelpers::XMLStr id_attr (query_tag.get_attribute ("id"));
		id70[id_list70_size++] = CORBA::string_dup (id_attr.in ());
	}
	id70.length (id_list70_size);
	//#UC END# *47B1578403D1*
}

} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

