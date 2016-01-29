////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassDiagramContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAMCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAMCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/InheriteView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/RealizeView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AssociationView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/NoteView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagramView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class ClassDiagramContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ClassViewList& get_class_views () const;

	void set_class_views (const ClassViewList& class_views);

	const InheriteViewList& get_inherite_views () const;

	void set_inherite_views (const InheriteViewList& inherite_views);

	const RealizeViewList& get_realize_views () const;

	void set_realize_views (const RealizeViewList& realize_views);

	const AssociationViewList& get_association_views () const;

	void set_association_views (const AssociationViewList& association_views);

	const NoteViewList& get_note_views () const;

	void set_note_views (const NoteViewList& note_views);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const ClassDiagramViewList& get_class_diagram_views () const;

	void set_class_diagram_views (const ClassDiagramViewList& class_diagram_views);

	const SequenceDiagramViewList& get_sequence_diagram_views () const;

	void set_sequence_diagram_views (const SequenceDiagramViewList& sequence_diagram_views);

	const StateDiagramViewList& get_state_diagram_views () const;

	void set_state_diagram_views (const StateDiagramViewList& state_diagram_views);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	ClassViewList m_class_views;

	InheriteViewList m_inherite_views;

	RealizeViewList m_realize_views;

	AssociationViewList m_association_views;

	NoteViewList m_note_views;

	PropertyList m_properties;

	ClassDiagramViewList m_class_diagram_views;

	SequenceDiagramViewList m_sequence_diagram_views;

	StateDiagramViewList m_state_diagram_views;


}; //class ClassDiagramContent

std::ostream& operator << (std::ostream& out_stream, const ClassDiagramContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAMCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
