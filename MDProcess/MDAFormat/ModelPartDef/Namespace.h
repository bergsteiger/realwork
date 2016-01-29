////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Namespace.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Namespace
//
// описание пространства имён пакета
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_NAMESPACE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_NAMESPACE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// описание пространства имён пакета
class Namespace {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// собственно имя нэймспейса
	std::string m_name;


}; //class Namespace

std::ostream& operator << (std::ostream& out_stream, const Namespace& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_NAMESPACE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
