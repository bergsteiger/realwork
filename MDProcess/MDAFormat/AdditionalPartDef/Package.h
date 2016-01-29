////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Package.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Package
//
// описание пакета во вспомогательной части
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PACKAGE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PACKAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/PackageContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// описание пакета во вспомогательной части
class Package {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<PackageContent>& content () const;

	void content (const Core::Box<PackageContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// имя пакета
	std::string m_name;

	// гуид
	std::string m_guid;

	Core::Box<PackageContent> m_content;


}; //class Package

std::ostream& operator << (std::ostream& out_stream, const Package& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PACKAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
