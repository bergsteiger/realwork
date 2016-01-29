////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::CommonUtils::XML_i::XMLReader_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/CommonUtils/LibHome.h"
#include "garant6x/implementation/Garant/CommonUtils/impl/XML_i/XMLReader_i.h"

//#UC START# *443136380271_CUSTOM_INCLUDES*
#include <cstring>

#include <vector>
#include <iterator>
#include <algorithm>

#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garantServer/src/Business/GblConsultingClient/Server/XMLReader.h"
//#UC END# *443136380271_CUSTOM_INCLUDES*

namespace CommonUtils {
namespace XML_i {

//#UC START# *443136380271*
//#UC END# *443136380271*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

XMLReader_i::XMLReader_i ()
//#UC START# *442D453501E4_443CDC2F037A_443136380271_BASE_INIT*
//#UC END# *442D453501E4_443CDC2F037A_443136380271_BASE_INIT*
{
	//#UC START# *442D453501E4_443CDC2F037A_443136380271_BODY*
	//#UC END# *442D453501E4_443CDC2F037A_443136380271_BODY*
}

XMLReader_i::~XMLReader_i () {
	//#UC START# *443136380271_DESTR_BODY*
	//#UC END# *443136380271_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from XML::XMLReader
// чтение xml с данными о консультации
GblConsultingDef::ConsultationData* XMLReader_i::read_result (
	GCI::IO::Stream* result
) const /*throw (
	XML::BadXMLFormat
)*/ {
	//#UC START# *4430E42C03A9_443136380271*
	const size_t block_size = 512;
	static char buffer[block_size];
	std::vector<char> xml_data;
	size_t len; // Number of received bytes
	for (bool eof = result->eof (); !eof; eof = result->eof ()) {
		len = result->read (buffer, block_size);
		if (len) {
			std::copy (buffer, &(buffer[len]), std::back_inserter (xml_data));
		}
	}
	if (xml_data.size () == 0) {
		LOG_E (("XMLReader_i::read_result: zero length of xml stream"));
		throw XML::BadXMLFormat ();
	}

	try {
		return GblConsultingClientServer::XMLReader::read_result (xml_data);
	} catch (.../*GblConsultingDef::InvalidXML&*/) {
		throw XML::BadXMLFormat ();
	}
	//#UC END# *4430E42C03A9_443136380271*
}
} // namespace XML_i
} // namespace CommonUtils

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

