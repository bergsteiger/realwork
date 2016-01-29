////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/RootPackage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::RootPackage
//
// описание рутового элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_ROOTPACKAGE_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_ROOTPACKAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/Namespace.h"
#include "MDProcess/MDAFormat/ViewPartDef/PackageDef.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// описание рутового элемента
class RootPackage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const NamespaceList& get_namespaces () const;

	void set_namespaces (const NamespaceList& namespaces);

	const PackageDef& get_root () const;

	void set_root (const PackageDef& root);

	const std::string& get_file_name () const;

	void set_file_name (const std::string& file_name);
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// список нэймспэйсов
	NamespaceList m_namespaces;

	// собственно рутовый элемент текущего файла
	PackageDef m_root;

	std::string m_file_name; //хранит информацию - из какого файла был прочитан элемент

}; //class RootPackage

std::ostream& operator << (std::ostream& out_stream, const RootPackage& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_ROOTPACKAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
