////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATECONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATECONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Transition.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateAction.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class StateContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const TransitionList& get_transitions () const;

	void set_transitions (const TransitionList& transitions);

	const StateActionList& get_actions () const;

	void set_actions (const StateActionList& actions);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	PropertyList m_properties;

	TransitionList m_transitions;

	StateActionList m_actions;


}; //class StateContent

std::ostream& operator << (std::ostream& out_stream, const StateContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
