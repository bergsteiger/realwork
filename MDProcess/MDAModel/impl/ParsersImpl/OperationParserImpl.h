////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ParsersImpl/OperationParserImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ParsersImpl::OperationParserImpl
// Заголовок реализации класса серванта для интерфеса OperationParser
//
// реализация парсера сигнатуры функции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_PARSERSIMPL_OPERATIONPARSERIMPL_H__
#define __MDPROCESS_MDAMODEL_PARSERSIMPL_OPERATIONPARSERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"

namespace ParsersImpl {

class OperationParserImpl; // self forward Var
typedef ::Core::Var<OperationParserImpl> OperationParserImpl_var;
typedef ::Core::Var<const OperationParserImpl> OperationParserImpl_cvar;

class OperationParserImpl_factory;

// реализация парсера сигнатуры функции
class OperationParserImpl:
	virtual public Parsers::OperationParser
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (OperationParserImpl)
	friend class OperationParserImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	OperationParserImpl ();

	virtual ~OperationParserImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Parsers::OperationParser
	// возвращает данные операции
	virtual Parsers::OperationData* parse (const std::string& source);
}; // class OperationParserImpl

} // namespace ParsersImpl


#endif //__MDPROCESS_MDAMODEL_PARSERSIMPL_OPERATIONPARSERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
