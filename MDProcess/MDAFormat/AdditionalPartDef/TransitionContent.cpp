////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const TransitionContent& item) {
	out_stream << "{" << std::endl;
	if (item.get_condition ().is_nil () == false) {
		out_stream << "condition " << *item.get_condition () << " ;" << std::endl;
	}
	if (item.get_action ().is_nil () == false) {
		out_stream << "action " << *item.get_action () << " ;" << std::endl;
	}
	if (item.get_guard ().is_nil () == false) {
		out_stream << "guard " << *item.get_guard () << " ;" << std::endl;
	}
	if (item.get_event ().is_nil () == false) {
		out_stream << "event " << *item.get_event () << " ;" << std::endl;
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const Core::Box<TransitionParamBase>& TransitionContent::condition () const {
	//#UC START# *48ACE91B01C9_GET_ACCESSOR*
	return m_condition;
	//#UC END# *48ACE91B01C9_GET_ACCESSOR*
}

void TransitionContent::condition (const Core::Box<TransitionParamBase>& condition) {
	//#UC START# *48ACE91B01C9_SET_ACCESSOR*
	m_condition = condition;
	//#UC END# *48ACE91B01C9_SET_ACCESSOR*
}

const Core::Box<TransitionParamBase>& TransitionContent::action () const {
	//#UC START# *48ACE9340199_GET_ACCESSOR*
	return m_action;
	//#UC END# *48ACE9340199_GET_ACCESSOR*
}

void TransitionContent::action (const Core::Box<TransitionParamBase>& action) {
	//#UC START# *48ACE9340199_SET_ACCESSOR*
	m_action = action;
	//#UC END# *48ACE9340199_SET_ACCESSOR*
}

const Core::Box<TransitionParamBase>& TransitionContent::guard () const {
	//#UC START# *48ACE94A0091_GET_ACCESSOR*
	return m_guard;
	//#UC END# *48ACE94A0091_GET_ACCESSOR*
}

void TransitionContent::guard (const Core::Box<TransitionParamBase>& guard) {
	//#UC START# *48ACE94A0091_SET_ACCESSOR*
	m_guard = guard;
	//#UC END# *48ACE94A0091_SET_ACCESSOR*
}

const Core::Box<TransitionParamBase>& TransitionContent::event () const {
	//#UC START# *48ACE94A0358_GET_ACCESSOR*
	return m_event;
	//#UC END# *48ACE94A0358_GET_ACCESSOR*
}

void TransitionContent::event (const Core::Box<TransitionParamBase>& event) {
	//#UC START# *48ACE94A0358_SET_ACCESSOR*
	m_event = event;
	//#UC END# *48ACE94A0358_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

