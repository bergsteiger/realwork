////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ReturnMessage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ReturnMessage
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ReturnMessage.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const ReturnMessage& item) {
	out_stream << "return" << std::endl;
	out_stream << "\"" << item.get_result () << "\"" << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		out_stream << "{ ";
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		out_stream << " }" << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& ReturnMessage::get_result () const {
	//#UC START# *48AC0356012C_GET_ACCESSOR*
	return m_result;
	//#UC END# *48AC0356012C_GET_ACCESSOR*
}

void ReturnMessage::set_result (const std::string& result) {
	//#UC START# *48AC0356012C_SET_ACCESSOR*
	m_result = result;
	//#UC END# *48AC0356012C_SET_ACCESSOR*
}

const std::string& ReturnMessage::get_guid () const {
	//#UC START# *48AC036B02AD_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AC036B02AD_GET_ACCESSOR*
}

void ReturnMessage::set_guid (const std::string& guid) {
	//#UC START# *48AC036B02AD_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AC036B02AD_SET_ACCESSOR*
}

const PropertyList& ReturnMessage::get_properties () const {
	//#UC START# *48AC03880230_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48AC03880230_GET_ACCESSOR*
}

void ReturnMessage::set_properties (const PropertyList& properties) {
	//#UC START# *48AC03880230_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48AC03880230_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

