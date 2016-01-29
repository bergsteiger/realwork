////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/TypeConverterException.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::data::TypeConverterException
//
// Набор Исключений специфических для рабоы с TypeConvertor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_TYPECONVERTEREXCEPTION_H__
#define __SHARED_CORE_DATA_TYPECONVERTEREXCEPTION_H__

#include "ace/ACE.h"
#include "shared/Core/sys/Exception.h"

namespace Core {

// Данный ключ не найден
class ElementNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};


} // namespace Core


#endif //__SHARED_CORE_DATA_TYPECONVERTEREXCEPTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
