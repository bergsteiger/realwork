////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/SequenceDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::SequenceDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_SEQUENCEDIAGRAM_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_SEQUENCEDIAGRAM_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/NoteView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ObjectView.h"
#include "MDProcess/MDAFormat/ViewPartDef/MessageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/SelfMessageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ReturnMessageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class SequenceDiagram {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	SequenceDiagram ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	int get_zoom () const;

	void set_zoom (int zoom);

	const ObjectViewList& get_object_views () const;

	void set_object_views (const ObjectViewList& object_views);

	const MessageViewList& get_message_views () const;

	void set_message_views (const MessageViewList& message_views);

	const SelfMessageViewList& get_self_message_views () const;

	void set_self_message_views (const SelfMessageViewList& self_message_views);

	const ReturnMessageViewList& get_return_message_views () const;

	void set_return_message_views (const ReturnMessageViewList& return_message_views);

	const NoteViewList& get_note_views () const;

	void set_note_views (const NoteViewList& note_views);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	int m_zoom;

	ObjectViewList m_object_views;

	MessageViewList m_message_views;

	SelfMessageViewList m_self_message_views;

	ReturnMessageViewList m_return_message_views;

	NoteViewList m_note_views;


}; //class SequenceDiagram

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagram& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_SEQUENCEDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
