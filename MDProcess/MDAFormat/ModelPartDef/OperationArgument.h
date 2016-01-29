////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/OperationArgument.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::OperationArgument
//
// параметр операции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATIONARGUMENT_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATIONARGUMENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// параметр операции
class OperationArgument {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	OperationArgument ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ArgumentQualifier& get_qualifier () const;

	void set_qualifier (const ArgumentQualifier& qualifier);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_target_full_name () const;

	void set_target_full_name (const std::string& target_full_name);

	const std::string& get_init_value () const;

	void set_init_value (const std::string& init_value);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// спецификатор параметра операции
	ArgumentQualifier m_qualifier;

	// имя параметра
	std::string m_name;

	// полное имя типа параметра
	std::string m_target_full_name;

	// зачение по умолчанию для параметра
	std::string m_init_value;


}; //class OperationArgument

std::ostream& operator << (std::ostream& out_stream, const OperationArgument& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATIONARGUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
