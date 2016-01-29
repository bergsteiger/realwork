////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::ContainerOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONS_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"

namespace ContainerOperations {

class ContainerTemplateOperations;
typedef ::Core::Var<ContainerTemplateOperations> ContainerTemplateOperations_var;
typedef ::Core::Var<const ContainerTemplateOperations> ContainerTemplateOperations_cvar;
// интерфейс операций над элементом типа "список"
class ContainerTemplateOperations
	: virtual public ::Core::IObject
{
public:
	// добавление элемента в список unresolved_param содержит либо шаблон для получения элемента
	// (например: S%T), либо строка-шаблон в кавычках
	virtual void add (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const = 0;

	// удаляет элемент из списка, unresolved_param содержит либо шаблон для получения элемента
	// (например: S%T), либо строка-шаблон в кавычках
	virtual void remove (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const = 0;

	// возвращает количество вхождений элемента в список, unresolved_param содержит либо шаблон для
	// получения элемента (например: S%T), либо строка-шаблон в кавычках
	virtual const std::string count (
		const TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const = 0;

	// возвращает true, если элемент присутствует в списке, иначе false, unresolved_param содержит
	// либо шаблон для получения элемента (например: S%T), либо строка-шаблон в кавычках
	virtual const std::string find (
		const TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const = 0;

	virtual void pop_first_to_var (TemplatePainter::ContainerDumper* container, const std::string& var_id) const = 0;

	virtual void pop_last_to_var (TemplatePainter::ContainerDumper* container, const std::string& var_id) const = 0;

	virtual void sort (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
		, const TemplatePainter::ContainerDumper* key_list
	) const = 0;

	virtual void unique (
		TemplatePainter::ContainerDumper* container
		, const std::string& command
		, TemplatePainter* painter
	) const = 0;
};

/// factory interface for ContainerTemplateOperations
class ContainerTemplateOperationsFactory {
public:
	static ContainerTemplateOperations& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace ContainerOperations

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ContainerOperations::ContainerTemplateOperations> {
	typedef ContainerOperations::ContainerTemplateOperationsFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
