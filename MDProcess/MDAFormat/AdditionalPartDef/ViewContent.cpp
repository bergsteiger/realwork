////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ViewContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ViewContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const ViewContent& item) {
	out_stream << item.get_number () << std::endl;
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

	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
unsigned int ViewContent::get_number () const {
	//#UC START# *48ABFD3602B7_GET_ACCESSOR*
	return m_number;
	//#UC END# *48ABFD3602B7_GET_ACCESSOR*
}

void ViewContent::set_number (unsigned int number) {
	//#UC START# *48ABFD3602B7_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48ABFD3602B7_SET_ACCESSOR*
}

const std::string& ViewContent::get_guid () const {
	//#UC START# *48ABFD3F018B_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABFD3F018B_GET_ACCESSOR*
}

void ViewContent::set_guid (const std::string& guid) {
	//#UC START# *48ABFD3F018B_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABFD3F018B_SET_ACCESSOR*
}

const PropertyList& ViewContent::get_properties () const {
	//#UC START# *48ABFD450309_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ABFD450309_GET_ACCESSOR*
}

void ViewContent::set_properties (const PropertyList& properties) {
	//#UC START# *48ABFD450309_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ABFD450309_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

