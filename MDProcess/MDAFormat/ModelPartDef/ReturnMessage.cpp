////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/ReturnMessage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::ReturnMessage
//
// Элемент сиквенс-диаграммы, определяет возвращаемое сообщение от одного элемента к другому
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/ReturnMessage.h"


namespace MDAFormat {
namespace ModelPartDef {

std::ostream& operator << (std::ostream& out_stream, const ReturnMessage& item) {
	out_stream << "return" << std::endl;
	out_stream << "\"" << item.get_result () << "\"" << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& ReturnMessage::get_result () const {
	//#UC START# *48ABA6860311_GET_ACCESSOR*
	return m_result;
	//#UC END# *48ABA6860311_GET_ACCESSOR*
}

void ReturnMessage::set_result (const std::string& result) {
	//#UC START# *48ABA6860311_SET_ACCESSOR*
	m_result = result;
	//#UC END# *48ABA6860311_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

