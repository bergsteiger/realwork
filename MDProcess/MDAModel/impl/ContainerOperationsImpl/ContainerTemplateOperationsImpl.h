////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::ContainerTemplateOperationsImpl
// Заголовок реализации класса серванта для интерфеса ContainerTemplateOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace ContainerOperationsImpl {

class ContainerTemplateOperationsImpl; // self forward Var
typedef ::Core::Var<ContainerTemplateOperationsImpl> ContainerTemplateOperationsImpl_var;
typedef ::Core::Var<const ContainerTemplateOperationsImpl> ContainerTemplateOperationsImpl_cvar;

class ContainerTemplateOperationsImpl_factory;

class ContainerTemplateOperationsImpl:
	virtual public ContainerOperations::ContainerTemplateOperations
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ContainerTemplateOperationsImpl)
	friend class ContainerTemplateOperationsImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ContainerTemplateOperationsImpl ();

	virtual ~ContainerTemplateOperationsImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// возвращает дампер, по команде в шаблоне, результат функции должен быть положен в Var
	virtual const AbstractDumperBase* get_dumper_by_param (const std::string& param, TemplatePainter* painter) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// добавление элемента в список unresolved_param содержит либо шаблон для получения элемента
	// (например: S%T), либо строка-шаблон в кавычках
	virtual void add (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// возвращает количество вхождений элемента в список, unresolved_param содержит либо шаблон для
	// получения элемента (например: S%T), либо строка-шаблон в кавычках
	virtual const std::string count (
		const TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// возвращает true, если элемент присутствует в списке, иначе false, unresolved_param содержит
	// либо шаблон для получения элемента (например: S%T), либо строка-шаблон в кавычках
	virtual const std::string find (
		const TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void pop_first_to_var (TemplatePainter::ContainerDumper* container, const std::string& var_id) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void pop_last_to_var (TemplatePainter::ContainerDumper* container, const std::string& var_id) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// удаляет элемент из списка, unresolved_param содержит либо шаблон для получения элемента
	// (например: S%T), либо строка-шаблон в кавычках
	virtual void remove (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void sort (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
		, const TemplatePainter::ContainerDumper* key_list
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void unique (
		TemplatePainter::ContainerDumper* container
		, const std::string& command
		, TemplatePainter* painter
	) const;
}; // class ContainerTemplateOperationsImpl

} // namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
