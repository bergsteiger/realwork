////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/RootPackage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::RootPackage
//
// описание рутового пакета
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ROOTPACKAGE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ROOTPACKAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Namespace.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Package.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// описание рутового пакета
class RootPackage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const NamespaceList& get_namespaces () const;

	void set_namespaces (const NamespaceList& namespaces);

	const Package& get_root () const;

	void set_root (const Package& root);

	const std::string& get_file_name () const;

	void set_file_name (const std::string& file_name);
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	NamespaceList m_namespaces;

	// собственно рутовый пакет в текущем файле
	Package m_root;

	std::string m_file_name; //хранит информацию - из какого файла был прочитан элемент

}; //class RootPackage

std::ostream& operator << (std::ostream& out_stream, const RootPackage& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ROOTPACKAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
