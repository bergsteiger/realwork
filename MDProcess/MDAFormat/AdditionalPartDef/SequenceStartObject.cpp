////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SequenceStartObject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SequenceStartObject
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceStartObject.h"


namespace MDAFormat {
namespace AdditionalPartDef {

// init ctor
SequenceStartObject::SequenceStartObject () : m_object_name("") {
	//#UC START# *48AC068D00F7_DEF_INIT_CTOR*
	//#UC END# *48AC068D00F7_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const SequenceStartObject& item) {
	out_stream << "sequence" << std::endl;
	out_stream << item.get_class_name () << std::endl;
	if (item.get_object_name () != "") {
		out_stream << "( " << item.get_object_name () << " )" << std::endl;
	}
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& SequenceStartObject::get_class_name () const {
	//#UC START# *48AC06AE023F_GET_ACCESSOR*
	return m_class_name;
	//#UC END# *48AC06AE023F_GET_ACCESSOR*
}

void SequenceStartObject::set_class_name (const std::string& class_name) {
	//#UC START# *48AC06AE023F_SET_ACCESSOR*
	m_class_name = class_name;
	//#UC END# *48AC06AE023F_SET_ACCESSOR*
}

const std::string& SequenceStartObject::get_object_name () const {
	//#UC START# *48AC06BE0239_GET_ACCESSOR*
	return m_object_name;
	//#UC END# *48AC06BE0239_GET_ACCESSOR*
}

void SequenceStartObject::set_object_name (const std::string& object_name) {
	//#UC START# *48AC06BE0239_SET_ACCESSOR*
	m_object_name = object_name;
	//#UC END# *48AC06BE0239_SET_ACCESSOR*
}

const std::string& SequenceStartObject::get_guid () const {
	//#UC START# *48AC06DE017B_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AC06DE017B_GET_ACCESSOR*
}

void SequenceStartObject::set_guid (const std::string& guid) {
	//#UC START# *48AC06DE017B_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AC06DE017B_SET_ACCESSOR*
}

const Core::Box<MessageContent>& SequenceStartObject::content () const {
	//#UC START# *48AC06F10098_GET_ACCESSOR*
	return m_content;
	//#UC END# *48AC06F10098_GET_ACCESSOR*
}

void SequenceStartObject::content (const Core::Box<MessageContent>& content) {
	//#UC START# *48AC06F10098_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48AC06F10098_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

