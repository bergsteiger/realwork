////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionParamBase.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class TransitionContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const Core::Box<TransitionParamBase>& condition () const;

	void condition (const Core::Box<TransitionParamBase>& condition);

	const Core::Box<TransitionParamBase>& action () const;

	void action (const Core::Box<TransitionParamBase>& action);

	const Core::Box<TransitionParamBase>& guard () const;

	void guard (const Core::Box<TransitionParamBase>& guard);

	const Core::Box<TransitionParamBase>& event () const;

	void event (const Core::Box<TransitionParamBase>& event);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	Core::Box<TransitionParamBase> m_condition;

	Core::Box<TransitionParamBase> m_action;

	Core::Box<TransitionParamBase> m_guard;

	Core::Box<TransitionParamBase> m_event;


}; //class TransitionContent

std::ostream& operator << (std::ostream& out_stream, const TransitionContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
