////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Message.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Message
//
// Элемент сиквенс диаграммы, определяет сообщение, которым обмениваются два элемент
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Message.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Message::Message () : m_object_name("") {
	//#UC START# *48ABA699023C_DEF_INIT_CTOR*
	//#UC END# *48ABA699023C_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Message& item) {
	out_stream << item.get_class_name () << std::endl;
	if (item.get_object_name () != "") {
		out_stream << "( " << item.get_object_name () << " )" << std::endl;
	}
	out_stream << ":: " << "\"" << item.get_operation () << "\"" << " {" << std::endl;
	if (item.self_messages ().empty () == false) {
		SelfMessageList::const_iterator it = item.get_self_messages ().begin ();
		SelfMessageList::const_iterator it_end = item.get_self_messages ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.messages ().empty () == false) {
		MessageList::const_iterator it = item.get_messages ().begin ();
		MessageList::const_iterator it_end = item.get_messages ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.return_messages ().empty () == false) {
		ReturnMessageList::const_iterator it = item.get_return_messages ().begin ();
		ReturnMessageList::const_iterator it_end = item.get_return_messages ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "} ;" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Message::get_class_name () const {
	//#UC START# *48ABA6D1034E_GET_ACCESSOR*
	return m_class_name;
	//#UC END# *48ABA6D1034E_GET_ACCESSOR*
}

void Message::set_class_name (const std::string& class_name) {
	//#UC START# *48ABA6D1034E_SET_ACCESSOR*
	m_class_name = class_name;
	//#UC END# *48ABA6D1034E_SET_ACCESSOR*
}

const std::string& Message::get_object_name () const {
	//#UC START# *48ABA6E30108_GET_ACCESSOR*
	return m_object_name;
	//#UC END# *48ABA6E30108_GET_ACCESSOR*
}

void Message::set_object_name (const std::string& object_name) {
	//#UC START# *48ABA6E30108_SET_ACCESSOR*
	m_object_name = object_name;
	//#UC END# *48ABA6E30108_SET_ACCESSOR*
}

const std::string& Message::get_operation () const {
	//#UC START# *48ABA70B01E8_GET_ACCESSOR*
	return m_operation;
	//#UC END# *48ABA70B01E8_GET_ACCESSOR*
}

void Message::set_operation (const std::string& operation) {
	//#UC START# *48ABA70B01E8_SET_ACCESSOR*
	m_operation = operation;
	//#UC END# *48ABA70B01E8_SET_ACCESSOR*
}

const SelfMessageList& Message::get_self_messages () const {
	//#UC START# *48ABA77800FC_GET_ACCESSOR*
	return m_self_messages;
	//#UC END# *48ABA77800FC_GET_ACCESSOR*
}

void Message::set_self_messages (const SelfMessageList& self_messages) {
	//#UC START# *48ABA77800FC_SET_ACCESSOR*
	m_self_messages = self_messages;
	//#UC END# *48ABA77800FC_SET_ACCESSOR*
}

const MessageList& Message::get_messages () const {
	//#UC START# *48ABA78800B0_GET_ACCESSOR*
	return m_messages;
	//#UC END# *48ABA78800B0_GET_ACCESSOR*
}

void Message::set_messages (const MessageList& messages) {
	//#UC START# *48ABA78800B0_SET_ACCESSOR*
	m_messages = messages;
	//#UC END# *48ABA78800B0_SET_ACCESSOR*
}

const ReturnMessageList& Message::get_return_messages () const {
	//#UC START# *48ABA7A90265_GET_ACCESSOR*
	return m_return_messages;
	//#UC END# *48ABA7A90265_GET_ACCESSOR*
}

void Message::set_return_messages (const ReturnMessageList& return_messages) {
	//#UC START# *48ABA7A90265_SET_ACCESSOR*
	m_return_messages = return_messages;
	//#UC END# *48ABA7A90265_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

