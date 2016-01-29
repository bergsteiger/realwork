////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::RootPackage
//
// рутовый пакет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_ROOTPACKAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_ROOTPACKAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Namespace.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include "MDProcess/MDAFormat/ModelPartDef/Package.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// рутовый пакет
class RootPackage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const NamespaceList& get_namepsaces () const;

	void set_namepsaces (const NamespaceList& namepsaces);

	const Package& get_root () const;

	void set_root (const Package& root);

	const std::string& get_file_name () const;

	void set_file_name (const std::string& file_name);
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// список нэймспейсов
	NamespaceList m_namepsaces;

	// рутовый пакет
	Package m_root;

	std::string m_file_name; //хранит информацию - из какого файла был прочитан элемент

}; //class RootPackage

std::ostream& operator << (std::ostream& out_stream, const RootPackage& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_ROOTPACKAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
