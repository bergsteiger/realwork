////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionParamBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionParamBase
//
// базовое описание формата параметров перехода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONPARAMBASE_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONPARAMBASE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// базовое описание формата параметров перехода
class TransitionParamBase {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	std::string m_guid;


}; //class TransitionParamBase

std::ostream& operator << (std::ostream& out_stream, const TransitionParamBase& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONPARAMBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
