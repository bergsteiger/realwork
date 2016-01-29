////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Transition.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Transition
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITION_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITION_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class Transition {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_target_state_name () const;

	void set_target_state_name (const std::string& target_state_name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<TransitionContent>& content () const;

	void content (const Core::Box<TransitionContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_target_state_name;

	std::string m_guid;

	Core::Box<TransitionContent> m_content;


}; //class Transition

std::ostream& operator << (std::ostream& out_stream, const Transition& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
