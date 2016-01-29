////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
// Заголовок реализации класса серванта для интерфеса 
//
// 1. %S%f_add_operation(<GUID нового элемента>,<стереотип>, <имя операции>,<тип результата>,<имя
// переменной>) - создает новый элемент - операцию с заданным именем и стереотипом, сохраняет его в
// переменной и добавляет как ребенка к текущему элементу, тип операции задается либо ГУИДОМ
// существующего элемента, либо просто именем типа - в этом случае в дереве будет искаться элемент
// с таким именем.
// 2. %S%f_add_operation(<GUID нового элемента>, <стереотип>,<имя опреации с парметрами и
// результатом>,<имя переменной>) - создает новый элемент - операцию имя операции тип результата, а
// также параметры задаются вторым параметром, в формате: <имя операции> (<спецификатор параметра>
// <имя параметра> : <тип параметра (GUID или строка) = <значение по умолчанию (GUID или
// строка)>>):<GUID или имя возвращемого параметра>
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddOperation; // self forward Var
typedef ::Core::Var<AddOperation> AddOperation_var;
typedef ::Core::Var<const AddOperation> AddOperation_cvar;

class AddOperation_factory;

// 1. %S%f_add_operation(<GUID нового элемента>,<стереотип>, <имя операции>,<тип результата>,<имя
// переменной>) - создает новый элемент - операцию с заданным именем и стереотипом, сохраняет его в
// переменной и добавляет как ребенка к текущему элементу, тип операции задается либо ГУИДОМ
// существующего элемента, либо просто именем типа - в этом случае в дереве будет искаться элемент
// с таким именем.
// 2. %S%f_add_operation(<GUID нового элемента>, <стереотип>,<имя опреации с парметрами и
// результатом>,<имя переменной>) - создает новый элемент - операцию имя операции тип результата, а
// также параметры задаются вторым параметром, в формате: <имя операции> (<спецификатор параметра>
// <имя параметра> : <тип параметра (GUID или строка) = <значение по умолчанию (GUID или
// строка)>>):<GUID или имя возвращемого параметра>
class AddOperation:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddOperation)
	friend class AddOperation_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddOperation ();

	virtual ~AddOperation ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// создает новый элемент - операцию с заданным именем и стереотипом, сохраняет его в переменной и
	// добавляет как ребенка к текущему элементу, тип операции задается либо ГУИДОМ существующего
	// элемента, либо просто именем типа - в этом случае в дереве будет искаться элемент с таким
	// именем.
	virtual const std::string create_operation (
		const RoseAbstractDumper* parent
		, const std::string& guid_suffix
		, const std::string& name
		, const std::string& stereotype
		, const std::string& result
		, const std::string& var_id
		, TemplatePainter* painter
	) const;

	// создает новый элемент - операцию имя операции тип результата, а также параметры задаются вторым
	// параметром, в формате: <имя операции> (<спецификатор параметра> <имя параметра> : <тип
	// параметра (GUID или строка) = <значение по умолчанию (GUID или строка)>>):<GUID или имя
	// возвращемого параметра>
	virtual const std::string create_operation (
		const RoseAbstractDumper* parent
		, const std::string& guid_suffix
		, const std::string& signature
		, const std::string& stereotype
		, const std::string& var_id
		, TemplatePainter* painter
	) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddOperation

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
