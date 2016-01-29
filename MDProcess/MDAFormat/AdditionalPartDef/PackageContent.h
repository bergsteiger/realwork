////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/PackageContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::PackageContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PACKAGECONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PACKAGECONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Dependency.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Class.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class PackageContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const DependencyList& get_dependecies () const;

	void set_dependecies (const DependencyList& dependecies);

	const SequenceDiagramList& get_sequence_diags () const;

	void set_sequence_diags (const SequenceDiagramList& sequence_diags);

	const StateDiagramList& get_state_diags () const;

	void set_state_diags (const StateDiagramList& state_diags);

	const ClassDiagramList& get_class_diags () const;

	void set_class_diags (const ClassDiagramList& class_diags);

	const ClassList& get_classes () const;

	void set_classes (const ClassList& classes);

	const PackageList& get_packages () const;

	void set_packages (const PackageList& packages);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	PropertyList m_properties;

	DependencyList m_dependecies;

	SequenceDiagramList m_sequence_diags;

	StateDiagramList m_state_diags;

	ClassDiagramList m_class_diags;

	ClassList m_classes;

	PackageList m_packages;


}; //class PackageContent

std::ostream& operator << (std::ostream& out_stream, const PackageContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PACKAGECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
