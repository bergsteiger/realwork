////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/MessageContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::MessageContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_MESSAGECONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_MESSAGECONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ReturnMessage.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SelfMessage.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class MessageContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const SelfMessageList& get_self_messages () const;

	void set_self_messages (const SelfMessageList& self_messages);

	const ReturnMessageList& get_return_messages () const;

	void set_return_messages (const ReturnMessageList& return_messages);

	const MessageList& get_messages () const;

	void set_messages (const MessageList& messages);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	SelfMessageList m_self_messages;

	ReturnMessageList m_return_messages;

	MessageList m_messages;


}; //class MessageContent

std::ostream& operator << (std::ostream& out_stream, const MessageContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_MESSAGECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
