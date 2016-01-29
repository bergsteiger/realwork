////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/Parsers/Parsers.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Parsers
//
// вспомогательные парсеры сигнатур функций, атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERS_H__
#define __MDPROCESS_MDAMODEL_PARSERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>

namespace Parsers {

#pragma pack (push, 1)

// структура описывающая свойства параметра или атрибута
struct AttributeData {
	// возвращает имя атрибута
	std::string name;
	// тип атрибута
	std::string type;
	// знчение по-умолчанию
	std::string init_value;
};

#pragma pack (pop)

// писок атрибутов или параметров
typedef std::vector < AttributeData > AttributeDataVector;

// parsing error
class ParseError : public ::Core::Exception {
public:
	ParseError (const std::string& info);

	virtual ~ParseError () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// дполнительная информация об ошибке
	std::string m_info;
};

#pragma pack (push, 1)

// данные для операции
struct OperationData {
	// имя функции
	std::string name;
	// тип возвращаемого параметра фукнции
	std::string return_type;
	// параметры операции
	AttributeDataVector parameters;
};

#pragma pack (pop)

class AttributeParser;
typedef ::Core::Var<AttributeParser> AttributeParser_var;
typedef ::Core::Var<const AttributeParser> AttributeParser_cvar;
// парсер для "вычлеленения" параметров атрибута из строки. формат:
// <имя>: <тип> = <значение по-умолчанию>
class AttributeParser
	: virtual public ::Core::IObject
{
public:
	// парсит строку, в случае успеха возвращает true
	virtual AttributeData* parse (const std::string& source) /*throw (ParseError)*/ = 0;
};

/// factory interface for AttributeParser
class AttributeParserFactory {
public:
	// создает экземпляр парсера
	static AttributeParser& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class OperationParser;
typedef ::Core::Var<OperationParser> OperationParser_var;
typedef ::Core::Var<const OperationParser> OperationParser_cvar;
// парсит сигнатуру функции
class OperationParser
	: virtual public ::Core::IObject
{
public:
	// возвращает данные операции
	virtual OperationData* parse (const std::string& source) = 0;
};

/// factory interface for OperationParser
class OperationParserFactory {
public:
	// создает экземпляр парсера
	static OperationParser& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Parsers

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Parsers::AttributeParser> {
	typedef Parsers::AttributeParserFactory Factory;
};
template <>
struct TypeTraits <Parsers::OperationParser> {
	typedef Parsers::OperationParserFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_PARSERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
