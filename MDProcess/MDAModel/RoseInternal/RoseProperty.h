////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseProperty.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseProperty
//
// Свойство
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPROPERTY_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPROPERTY_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace RoseInternal {

// Свойство
class RoseProperty {
	SET_OBJECT_COUNTER (RoseProperty)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseProperty ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_name;

	std::string m_tool_name;

	std::string m_type;

	std::string m_value;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_tool_name () const;

	void set_tool_name (const std::string& tool_name);

	const std::string& get_type () const;

	void set_type (const std::string& type);

	const std::string& get_value () const;

	void set_value (const std::string& value);
}; // class RoseProperty

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPROPERTY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

