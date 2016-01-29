////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Message.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Message
//
// Элемент сиквенс диаграммы, определяет сообщение, которым обмениваются два элемент
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_MESSAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_MESSAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/SelfMessage.h"
#include "MDProcess/MDAFormat/ModelPartDef/ReturnMessage.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// Элемент сиквенс диаграммы, определяет сообщение, которым обмениваются два элемент
class Message {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Message ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_class_name () const;

	void set_class_name (const std::string& class_name);

	const std::string& get_object_name () const;

	void set_object_name (const std::string& object_name);

	const std::string& get_operation () const;

	void set_operation (const std::string& operation);

	const SelfMessageList& get_self_messages () const;

	void set_self_messages (const SelfMessageList& self_messages);

	const MessageList& get_messages () const;

	void set_messages (const MessageList& messages);

	const ReturnMessageList& get_return_messages () const;

	void set_return_messages (const ReturnMessageList& return_messages);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// Имя класса на котором вызывается операция
	std::string m_class_name;

	// имя элемента, если нужно
	std::string m_object_name;

	// имя операции с параметрами
	std::string m_operation;

	SelfMessageList m_self_messages;

	MessageList m_messages;

	ReturnMessageList m_return_messages;


}; //class Message

std::ostream& operator << (std::ostream& out_stream, const Message& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_MESSAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
