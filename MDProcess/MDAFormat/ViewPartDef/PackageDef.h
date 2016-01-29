////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/PackageDef.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::PackageDef
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_PACKAGEDEF_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_PACKAGEDEF_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDef.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class PackageDef {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ClassDiagramList& get_class_diags () const;

	void set_class_diags (const ClassDiagramList& class_diags);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const PackageDefList& get_packages () const;

	void set_packages (const PackageDefList& packages);

	const ClassDefList& get_classes () const;

	void set_classes (const ClassDefList& classes);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	ClassDiagramList m_class_diags;

	std::string m_name;

	PackageDefList m_packages;

	ClassDefList m_classes;


}; //class PackageDef

std::ostream& operator << (std::ostream& out_stream, const PackageDef& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_PACKAGEDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
