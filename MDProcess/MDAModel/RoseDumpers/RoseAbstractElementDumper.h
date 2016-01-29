////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractElementDumper
//
// Абстракный дампер для всех IRoseItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTELEMENTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTELEMENTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *4571D3040222_CUSTOM_INCLUDES*
//#UC END# *4571D3040222_CUSTOM_INCLUDES*


// Абстракный дампер для всех IRoseItem
class RoseAbstractElementDumper;
typedef Core::Var<RoseAbstractElementDumper> RoseAbstractElementDumper_var;
typedef Core::Var<const RoseAbstractElementDumper> RoseAbstractElementDumper_cvar;

class RoseAbstractElementDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractElementDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractElementDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// алгоритм нахождения типа элемента:
	// 1. Получает из настроек идентификатор связанного элемента - находит этот элемент в дереве
	// 2. Получает из настроек имя связанного типа, сравнивает его переданным именем типа
	// (current_type)
	// 3. Если совпадают - возвращается элемент
	// 4. Если не совпадают - запускается алгоритм поиска типа по имени, информация о полученном
	// элементе сохраняется в модель
	virtual const RoseAbstractDumper* resolve_target_type (std::string& current_type);



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from AbstractDumperBase
	// возвращает true, если элемент можно "дампить"
	virtual bool can_dump () const;

	// overloaded method from ObjectTreeResolver
	// Сортируется ли элементы в порядке создания (в порядке указания на модели) - такие элементы не
	// нужно помещать в граф.
	virtual bool sort_in_model_order () const;


//#UC START# *4571D3040222*
public:
	RoseAbstractElementDumper (const RoseAbstractDumper* parent, IRoseElementPtr cls, const AbstractDumperBase::StereotypeID& = AbstractDumperBase::StereotypeID (""));	
	virtual bool is_it_first (const ObjectTreeResolver* od) const;
//#UC END# *4571D3040222*
}; // class RoseAbstractElementDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTELEMENTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

