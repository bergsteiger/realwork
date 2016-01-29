////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/StateDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::StateDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_STATEDIAGRAM_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_STATEDIAGRAM_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/NoteView.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateView.h"
#include "MDProcess/MDAFormat/ViewPartDef/TransitionView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class StateDiagram {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	StateDiagram ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const StateViewList& get_state_views () const;

	void set_state_views (const StateViewList& state_views);

	const TransitionViewList& get_transition_views () const;

	void set_transition_views (const TransitionViewList& transition_views);

	const NoteViewList& get_note_views () const;

	void set_note_views (const NoteViewList& note_views);

	int get_zoom () const;

	void set_zoom (int zoom);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	StateViewList m_state_views;

	TransitionViewList m_transition_views;

	NoteViewList m_note_views;

	int m_zoom;


}; //class StateDiagram

std::ostream& operator << (std::ostream& out_stream, const StateDiagram& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_STATEDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
