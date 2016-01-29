////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/SelfMessage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::SelfMessage
//
// Элемент сиквенс-диаграммы, определяет сообщение, вызываемое объектом на самом себе.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/SelfMessage.h"


namespace MDAFormat {
namespace ModelPartDef {

std::ostream& operator << (std::ostream& out_stream, const SelfMessage& item) {
	out_stream << "this" << std::endl;
	out_stream << ":: " << "\"" << item.get_operation () << "\"" << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& SelfMessage::get_operation () const {
	//#UC START# *48ABA61E0366_GET_ACCESSOR*
	return m_operation;
	//#UC END# *48ABA61E0366_GET_ACCESSOR*
}

void SelfMessage::set_operation (const std::string& operation) {
	//#UC START# *48ABA61E0366_SET_ACCESSOR*
	m_operation = operation;
	//#UC END# *48ABA61E0366_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

