////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Operation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Operation
//
// операция класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATION_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATION_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"
#include "MDProcess/MDAFormat/ModelPartDef/OperationArgument.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// операция класса
class Operation {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Operation ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const AbstractionType& get_abstractiveness () const;

	void set_abstractiveness (const AbstractionType& abstractiveness);

	const VisibilityType& get_visibility () const;

	void set_visibility (const VisibilityType& visibility);

	const std::string& get_stereotype () const;

	void set_stereotype (const std::string& stereotype);

	const std::string& get_return_type () const;

	void set_return_type (const std::string& return_type);

	const std::string& get_target_stereotype () const;

	void set_target_stereotype (const std::string& target_stereotype);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const ArgumentList& get_arguments () const;

	void set_arguments (const ArgumentList& arguments);

	const StringList& get_exceptions () const;

	void set_exceptions (const StringList& exceptions);

	const UserPropertyList& get_user_properties () const;

	void set_user_properties (const UserPropertyList& user_properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// тип абстрактности операции
	AbstractionType m_abstractiveness;

	// видимость операции
	VisibilityType m_visibility;

	// стереотип операции, может быть не задан
	std::string m_stereotype;

	// тип возвращаемого результата
	std::string m_return_type;

	// стереотип цели
	std::string m_target_stereotype;

	std::string m_name;

	// параметры операции
	ArgumentList m_arguments;

	// список исключений
	StringList m_exceptions;

	// пользовательские свойства
	UserPropertyList m_user_properties;


}; //class Operation

std::ostream& operator << (std::ostream& out_stream, const Operation& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
