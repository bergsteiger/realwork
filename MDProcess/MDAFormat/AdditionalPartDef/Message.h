////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Message.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Message
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_MESSAGE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_MESSAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/MessageContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
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

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const std::string& get_operation () const;

	void set_operation (const std::string& operation);

	const Core::Box<MessageContent>& content () const;

	void content (const Core::Box<MessageContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_class_name;

	std::string m_object_name;

	std::string m_guid;

	std::string m_operation;

	Core::Box<MessageContent> m_content;


}; //class Message

std::ostream& operator << (std::ostream& out_stream, const Message& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_MESSAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
