////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/MessageContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::MessageContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/MessageContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Message.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const MessageContent& item) {
	out_stream << "{" << std::endl;
	if (item.self_messages ().empty () == false) {
		SelfMessageList::const_iterator it = item.get_self_messages ().begin ();
		SelfMessageList::const_iterator it_end = item.get_self_messages ().end ();
		
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
	if (item.messages ().empty () == false) {
		MessageList::const_iterator it = item.get_messages ().begin ();
		MessageList::const_iterator it_end = item.get_messages ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const SelfMessageList& MessageContent::get_self_messages () const {
	//#UC START# *48AC063A03D3_GET_ACCESSOR*
	return m_self_messages;
	//#UC END# *48AC063A03D3_GET_ACCESSOR*
}

void MessageContent::set_self_messages (const SelfMessageList& self_messages) {
	//#UC START# *48AC063A03D3_SET_ACCESSOR*
	m_self_messages = self_messages;
	//#UC END# *48AC063A03D3_SET_ACCESSOR*
}

const ReturnMessageList& MessageContent::get_return_messages () const {
	//#UC START# *48AC06470170_GET_ACCESSOR*
	return m_return_messages;
	//#UC END# *48AC06470170_GET_ACCESSOR*
}

void MessageContent::set_return_messages (const ReturnMessageList& return_messages) {
	//#UC START# *48AC06470170_SET_ACCESSOR*
	m_return_messages = return_messages;
	//#UC END# *48AC06470170_SET_ACCESSOR*
}

const MessageList& MessageContent::get_messages () const {
	//#UC START# *48AC065F01DA_GET_ACCESSOR*
	return m_messages;
	//#UC END# *48AC065F01DA_GET_ACCESSOR*
}

void MessageContent::set_messages (const MessageList& messages) {
	//#UC START# *48AC065F01DA_SET_ACCESSOR*
	m_messages = messages;
	//#UC END# *48AC065F01DA_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

