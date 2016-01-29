////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/Parsers/Parsers.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::Parsers
//
// вспомогательные парсеры сигнатур функций, атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/Parsers/ParsersFactories.h"

namespace Parsers {


ParseError::ParseError (const std::string& info)
	: m_info (info)
//#UC START# *4A3896EF00CD_BASE_INIT*
//#UC END# *4A3896EF00CD_BASE_INIT*
{
	//#UC START# *4A3896EF00CD_BODY*
	//#UC END# *4A3896EF00CD_BODY*
}

ParseError::~ParseError () throw () {
}

const char* ParseError::uid () const /*throw ()*/ {
	return "57E0E30B-D39F-4615-8505-58B380751320";
}

const char* ParseError::what () const throw () {
	//#UC START# *4A3896EF00CD_WHAT_IMPL*
	return m_info.c_str ();
	//#UC END# *4A3896EF00CD_WHAT_IMPL*
}

// factory interface wrapper for AttributeParser
AttributeParser& AttributeParserFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AttributeParserFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for OperationParser
OperationParser& OperationParserFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return OperationParserFactoryManager::Singleton::instance ()->get ();
}

} // namespace Parsers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

