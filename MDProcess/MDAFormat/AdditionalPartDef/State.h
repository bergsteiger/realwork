////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/State.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::State
//
// состояние
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// состояние
class State {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<StateContent>& content () const;

	void content (const Core::Box<StateContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	std::string m_guid;

	Core::Box<StateContent> m_content;


}; //class State

std::ostream& operator << (std::ostream& out_stream, const State& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
