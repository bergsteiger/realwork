////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/StateAction.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::StateAction
//
// элемент-действие
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATEACTION_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATEACTION_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// элемент-действие
class StateAction {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ActionType& get_type () const;

	void set_type (const ActionType& type);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// тип действия
	ActionType m_type;

	// имя действия
	std::string m_name;


}; //class StateAction

std::ostream& operator << (std::ostream& out_stream, const StateAction& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_STATEACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
