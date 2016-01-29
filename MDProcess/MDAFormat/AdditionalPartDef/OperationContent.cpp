////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/OperationContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::OperationContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/OperationContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const OperationContent& item) {
	out_stream << "{" << std::endl;
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.parameters ().empty () == false) {
		ParameterList::const_iterator it = item.get_parameters ().begin ();
		ParameterList::const_iterator it_end = item.get_parameters ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const PropertyList& OperationContent::get_properties () const {
	//#UC START# *48ABF83C011F_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ABF83C011F_GET_ACCESSOR*
}

void OperationContent::set_properties (const PropertyList& properties) {
	//#UC START# *48ABF83C011F_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ABF83C011F_SET_ACCESSOR*
}

const ParameterList& OperationContent::get_parameters () const {
	//#UC START# *48ABF850009D_GET_ACCESSOR*
	return m_parameters;
	//#UC END# *48ABF850009D_GET_ACCESSOR*
}

void OperationContent::set_parameters (const ParameterList& parameters) {
	//#UC START# *48ABF850009D_SET_ACCESSOR*
	m_parameters = parameters;
	//#UC END# *48ABF850009D_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

