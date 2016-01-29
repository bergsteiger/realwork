////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/ReturnMessage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::ReturnMessage
//
// Элемент сиквенс-диаграммы, определяет возвращаемое сообщение от одного элемента к другому
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_RETURNMESSAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_RETURNMESSAGE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// Элемент сиквенс-диаграммы, определяет возвращаемое сообщение от одного элемента к другому
class ReturnMessage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_result () const;

	void set_result (const std::string& result);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// возвращаемый результат
	std::string m_result;


}; //class ReturnMessage

std::ostream& operator << (std::ostream& out_stream, const ReturnMessage& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_RETURNMESSAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
