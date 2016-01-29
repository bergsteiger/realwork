////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateDiagramContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateDiagramContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEDIAGRAMCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEDIAGRAMCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/NoteView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class StateDiagramContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const TransitionViewList& get_transition_views () const;

	void set_transition_views (const TransitionViewList& transition_views);

	const StateViewList& get_state_views () const;

	void set_state_views (const StateViewList& state_views);

	const NoteViewList& get_note_views () const;

	void set_note_views (const NoteViewList& note_views);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	TransitionViewList m_transition_views;

	StateViewList m_state_views;

	NoteViewList m_note_views;

	PropertyList m_properties;


}; //class StateDiagramContent

std::ostream& operator << (std::ostream& out_stream, const StateDiagramContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEDIAGRAMCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
