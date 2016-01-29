////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/TypeConverterException.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::data::TypeConverterException
// Файл реализации утилитного набора TypeConverterException
//
// Набор Исключений специфических для рабоы с TypeConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/data/TypeConverterException.h"

namespace Core {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation


const char* ElementNotFound::uid () const /*throw ()*/ {
	return "96C9233F-032E-4E37-8BAB-D8067A8084FD";
}

const char* ElementNotFound::what () const throw () {
	//#UC START# *45B4A52B002E_WHAT_IMPL*
	return "ElementNotFound (Данный ключ не найден)";
	//#UC END# *45B4A52B002E_WHAT_IMPL*
}



} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

