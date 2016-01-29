////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SequenceDiagramContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SEQUENCEDIAGRAMCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SEQUENCEDIAGRAMCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ObjectView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/MessageView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SelfMessageView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ReturnMessageView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class SequenceDiagramContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ObjectViewList& get_object_views () const;

	void set_object_views (const ObjectViewList& object_views);

	const MessageViewList& get_message_views () const;

	void set_message_views (const MessageViewList& message_views);

	const SelfMessageViewList& get_self_message_views () const;

	void set_self_message_views (const SelfMessageViewList& self_message_views);

	const ReturnMessageViewList& get_return_message_views () const;

	void set_return_message_views (const ReturnMessageViewList& return_message_views);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	ObjectViewList m_object_views;

	MessageViewList m_message_views;

	SelfMessageViewList m_self_message_views;

	ReturnMessageViewList m_return_message_views;

	PropertyList m_properties;


}; //class SequenceDiagramContent

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagramContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SEQUENCEDIAGRAMCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
