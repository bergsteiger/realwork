////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/SequenceStartObject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::SequenceStartObject
//
// Описание начального элемента сиквенс диаграммы, на сиквенс-диаграммме может быть только один
// такой элемент
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/SequenceStartObject.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
SequenceStartObject::SequenceStartObject () : m_object_name("") {
	//#UC START# *48ABA7BE023F_DEF_INIT_CTOR*
	//#UC END# *48ABA7BE023F_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const SequenceStartObject& item) {
	out_stream << item.get_class_name () << std::endl;
	if (item.get_object_name () != "") {
		out_stream << "( " << item.get_object_name () << " )" << std::endl;
	}
	out_stream << "{" << std::endl;
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
const std::string& SequenceStartObject::get_class_name () const {
	//#UC START# *48ABA7E102A1_GET_ACCESSOR*
	return m_class_name;
	//#UC END# *48ABA7E102A1_GET_ACCESSOR*
}

void SequenceStartObject::set_class_name (const std::string& class_name) {
	//#UC START# *48ABA7E102A1_SET_ACCESSOR*
	m_class_name = class_name;
	//#UC END# *48ABA7E102A1_SET_ACCESSOR*
}

const std::string& SequenceStartObject::get_object_name () const {
	//#UC START# *48ABA7FF0211_GET_ACCESSOR*
	return m_object_name;
	//#UC END# *48ABA7FF0211_GET_ACCESSOR*
}

void SequenceStartObject::set_object_name (const std::string& object_name) {
	//#UC START# *48ABA7FF0211_SET_ACCESSOR*
	m_object_name = object_name;
	//#UC END# *48ABA7FF0211_SET_ACCESSOR*
}

const SelfMessageList& SequenceStartObject::get_self_messages () const {
	//#UC START# *48ABA83702AA_GET_ACCESSOR*
	return m_self_messages;
	//#UC END# *48ABA83702AA_GET_ACCESSOR*
}

void SequenceStartObject::set_self_messages (const SelfMessageList& self_messages) {
	//#UC START# *48ABA83702AA_SET_ACCESSOR*
	m_self_messages = self_messages;
	//#UC END# *48ABA83702AA_SET_ACCESSOR*
}

const MessageList& SequenceStartObject::get_messages () const {
	//#UC START# *48ABA83C030C_GET_ACCESSOR*
	return m_messages;
	//#UC END# *48ABA83C030C_GET_ACCESSOR*
}

void SequenceStartObject::set_messages (const MessageList& messages) {
	//#UC START# *48ABA83C030C_SET_ACCESSOR*
	m_messages = messages;
	//#UC END# *48ABA83C030C_SET_ACCESSOR*
}

const ReturnMessageList& SequenceStartObject::get_return_messages () const {
	//#UC START# *48ABA842002D_GET_ACCESSOR*
	return m_return_messages;
	//#UC END# *48ABA842002D_GET_ACCESSOR*
}

void SequenceStartObject::set_return_messages (const ReturnMessageList& return_messages) {
	//#UC START# *48ABA842002D_SET_ACCESSOR*
	m_return_messages = return_messages;
	//#UC END# *48ABA842002D_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

