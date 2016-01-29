////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/State.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::State
//
// элемент-состояние
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/StateAction.h"
#include "MDProcess/MDAFormat/ModelPartDef/Transition.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// элемент-состояние
class State {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	State ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const StateType& get_type () const;

	void set_type (const StateType& type);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const StateActionList& get_actions () const;

	void set_actions (const StateActionList& actions);

	const TransitionList& get_transitions () const;

	void set_transitions (const TransitionList& transitions);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// тип состояния
	StateType m_type;

	// имя состояния
	std::string m_name;

	// список действий
	StateActionList m_actions;

	// список переходов
	TransitionList m_transitions;


}; //class State

std::ostream& operator << (std::ostream& out_stream, const State& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_STATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
