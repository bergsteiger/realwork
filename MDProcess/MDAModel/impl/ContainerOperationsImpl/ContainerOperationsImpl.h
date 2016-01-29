////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::ContainerOperationsImpl
//
// пакет операций для работы со списками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

//forward decl
class AbstractDumperBase;
class TemplatePainter;

namespace ContainerOperationsImpl {

// функтор сравнивающий два элемента дерева генерации по результату применения к этим элементам
// команды шаблона, для сравнения используется оператор "меньше".
struct LessByTemplateCommand : public std::binary_function<AbstractDumperBase, AbstractDumperBase, bool> {
	bool operator () (const AbstractDumperBase* first_param_, const AbstractDumperBase* second_param_) const;

	LessByTemplateCommand (const std::string& command_, const TemplatePainter* painter_);

private:
	// комманда шаблона
	std::string command;
	// родительский объект для выполнения шаблона
	const TemplatePainter* painter;
};

// функтор сравнивающий два элемента дерева генерации по результату применения к этим элементам
// команды шаблона, для сравнения используется оператор "меньше".
struct EqualByTemplateCommand : public std::binary_function<AbstractDumperBase, AbstractDumperBase, bool> {
	bool operator () (const AbstractDumperBase* first_param_, const AbstractDumperBase* second_param_) const;

	EqualByTemplateCommand (const std::string& command_, const TemplatePainter* painter_);

private:
	std::string command;
	// родительский объект для выполнения шаблона
	const TemplatePainter* painter;
};

} //namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

