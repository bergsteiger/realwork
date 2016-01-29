////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ClassDef.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ClassDef
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_CLASSDEF_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_CLASSDEF_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/SequenceDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class ClassDef {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const ClassDefList& get_classes () const;

	void set_classes (const ClassDefList& classes);

	const ClassDiagramList& get_class_diags () const;

	void set_class_diags (const ClassDiagramList& class_diags);

	const SequenceDiagramList& get_sequence_diags () const;

	void set_sequence_diags (const SequenceDiagramList& sequence_diags);

	const StateDiagramList& get_state_diags () const;

	void set_state_diags (const StateDiagramList& state_diags);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	ClassDefList m_classes;

	ClassDiagramList m_class_diags;

	SequenceDiagramList m_sequence_diags;

	StateDiagramList m_state_diags;


}; //class ClassDef

std::ostream& operator << (std::ostream& out_stream, const ClassDef& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_CLASSDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
