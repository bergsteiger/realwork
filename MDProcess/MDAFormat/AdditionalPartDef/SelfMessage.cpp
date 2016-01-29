////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SelfMessage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SelfMessage
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SelfMessage.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const SelfMessage& item) {
	out_stream << "this" << std::endl;
	out_stream << ":: " << "\"" << item.get_operation () << "\"" << std::endl;
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
const std::string& SelfMessage::get_operation () const {
	//#UC START# *48AC03E500FC_GET_ACCESSOR*
	return m_operation;
	//#UC END# *48AC03E500FC_GET_ACCESSOR*
}

void SelfMessage::set_operation (const std::string& operation) {
	//#UC START# *48AC03E500FC_SET_ACCESSOR*
	m_operation = operation;
	//#UC END# *48AC03E500FC_SET_ACCESSOR*
}

const std::string& SelfMessage::get_guid () const {
	//#UC START# *48AC03F70317_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AC03F70317_GET_ACCESSOR*
}

void SelfMessage::set_guid (const std::string& guid) {
	//#UC START# *48AC03F70317_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AC03F70317_SET_ACCESSOR*
}

const PropertyList& SelfMessage::get_properties () const {
	//#UC START# *48AC04040048_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48AC04040048_GET_ACCESSOR*
}

void SelfMessage::set_properties (const PropertyList& properties) {
	//#UC START# *48AC04040048_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48AC04040048_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

