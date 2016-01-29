////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateAction.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateAction
//
// действие связанное с переходом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEACTION_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEACTION_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// действие связанное с переходом
class StateAction {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const ModelPartDef::ActionType& get_type () const;

	void set_type (const ModelPartDef::ActionType& type);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// имя действия
	std::string m_name;

	// гуид
	std::string m_guid;

	PropertyList m_properties;

	// тип действия
	ModelPartDef::ActionType m_type;


}; //class StateAction

std::ostream& operator << (std::ostream& out_stream, const StateAction& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
