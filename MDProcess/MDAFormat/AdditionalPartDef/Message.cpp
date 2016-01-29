////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Message.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Message
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Message.h"


namespace MDAFormat {
namespace AdditionalPartDef {

// init ctor
Message::Message () : m_object_name("") {
	//#UC START# *48AC0452025C_DEF_INIT_CTOR*
	//#UC END# *48AC0452025C_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Message& item) {
	out_stream << item.get_class_name () << std::endl;
	if (item.get_object_name () != "") {
		out_stream << "( " << item.get_object_name () << " )" << std::endl;
	}
	out_stream << ":: " << "\"" << item.get_operation () << "\"" << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Message::get_class_name () const {
	//#UC START# *48AC045F0173_GET_ACCESSOR*
	return m_class_name;
	//#UC END# *48AC045F0173_GET_ACCESSOR*
}

void Message::set_class_name (const std::string& class_name) {
	//#UC START# *48AC045F0173_SET_ACCESSOR*
	m_class_name = class_name;
	//#UC END# *48AC045F0173_SET_ACCESSOR*
}

const std::string& Message::get_object_name () const {
	//#UC START# *48AC046F02F3_GET_ACCESSOR*
	return m_object_name;
	//#UC END# *48AC046F02F3_GET_ACCESSOR*
}

void Message::set_object_name (const std::string& object_name) {
	//#UC START# *48AC046F02F3_SET_ACCESSOR*
	m_object_name = object_name;
	//#UC END# *48AC046F02F3_SET_ACCESSOR*
}

const std::string& Message::get_guid () const {
	//#UC START# *48AC048E0066_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AC048E0066_GET_ACCESSOR*
}

void Message::set_guid (const std::string& guid) {
	//#UC START# *48AC048E0066_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AC048E0066_SET_ACCESSOR*
}

const std::string& Message::get_operation () const {
	//#UC START# *48AC05C9028F_GET_ACCESSOR*
	return m_operation;
	//#UC END# *48AC05C9028F_GET_ACCESSOR*
}

void Message::set_operation (const std::string& operation) {
	//#UC START# *48AC05C9028F_SET_ACCESSOR*
	m_operation = operation;
	//#UC END# *48AC05C9028F_SET_ACCESSOR*
}

const Core::Box<MessageContent>& Message::content () const {
	//#UC START# *48AC066F0200_GET_ACCESSOR*
	return m_content;
	//#UC END# *48AC066F0200_GET_ACCESSOR*
}

void Message::content (const Core::Box<MessageContent>& content) {
	//#UC START# *48AC066F0200_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48AC066F0200_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

