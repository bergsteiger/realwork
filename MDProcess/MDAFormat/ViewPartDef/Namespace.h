////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/Namespace.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::Namespace
//
// описание нэймспэйса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_NAMESPACE_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_NAMESPACE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// описание нэймспэйса
class Namespace {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;


}; //class Namespace

std::ostream& operator << (std::ostream& out_stream, const Namespace& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_NAMESPACE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
