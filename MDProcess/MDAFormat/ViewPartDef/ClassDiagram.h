////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ClassDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ClassDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_CLASSDIAGRAM_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_CLASSDIAGRAM_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassView.h"
#include "MDProcess/MDAFormat/ViewPartDef/NoteView.h"
#include "MDProcess/MDAFormat/ViewPartDef/InheritView.h"
#include "MDProcess/MDAFormat/ViewPartDef/AssociationView.h"
#include "MDProcess/MDAFormat/ViewPartDef/RealizeView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDiagramView.h"
#include "MDProcess/MDAFormat/ViewPartDef/SequenceDiagramView.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateDiagramView.h"
#include "MDProcess/MDAFormat/ViewPartDef/PackageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/DependencyView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class ClassDiagram {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	ClassDiagram ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	int get_zoom () const;

	void set_zoom (int zoom);

	const ClassViewList& get_class_views () const;

	void set_class_views (const ClassViewList& class_views);

	const PackageViewList& get_package_views () const;

	void set_package_views (const PackageViewList& package_views);

	const NoteViewList& get_note_views () const;

	void set_note_views (const NoteViewList& note_views);

	const InheritViewList& get_inherit_views () const;

	void set_inherit_views (const InheritViewList& inherit_views);

	const RealizeViewList& get_realize_views () const;

	void set_realize_views (const RealizeViewList& realize_views);

	const AssociationViewList& get_association_views () const;

	void set_association_views (const AssociationViewList& association_views);

	const ClassDiagramViewList& get_class_diags () const;

	void set_class_diags (const ClassDiagramViewList& class_diags);

	const SequenceDiagramViewList& get_sequence_diags () const;

	void set_sequence_diags (const SequenceDiagramViewList& sequence_diags);

	const StateDiagramViewList& get_state_diags () const;

	void set_state_diags (const StateDiagramViewList& state_diags);

	const DependencyViewList& get_dependencies () const;

	void set_dependencies (const DependencyViewList& dependencies);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	int m_zoom;

	ClassViewList m_class_views;

	PackageViewList m_package_views;

	NoteViewList m_note_views;

	InheritViewList m_inherit_views;

	RealizeViewList m_realize_views;

	AssociationViewList m_association_views;

	ClassDiagramViewList m_class_diags;

	SequenceDiagramViewList m_sequence_diags;

	StateDiagramViewList m_state_diags;

	DependencyViewList m_dependencies;


}; //class ClassDiagram

std::ostream& operator << (std::ostream& out_stream, const ClassDiagram& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_CLASSDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
