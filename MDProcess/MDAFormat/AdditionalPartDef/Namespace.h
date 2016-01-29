////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Namespace.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Namespace
//
// описание нэймспейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_NAMESPACE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_NAMESPACE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// описание нэймспейса
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
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_NAMESPACE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
