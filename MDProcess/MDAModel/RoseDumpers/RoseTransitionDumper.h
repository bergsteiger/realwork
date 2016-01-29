////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseTransitionDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseTransitionDumper
//
// дампер переходов между состояниями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETRANSITIONDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETRANSITIONDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *465E55840157_CUSTOM_INCLUDES*
//#UC END# *465E55840157_CUSTOM_INCLUDES*


// дампер переходов между состояниями
class RoseTransitionDumper;
typedef Core::Var<RoseTransitionDumper> RoseTransitionDumper_var;
typedef Core::Var<const RoseTransitionDumper> RoseTransitionDumper_cvar;

class RoseTransitionDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseTransitionDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// init cotr
	RoseTransitionDumper (const RoseAbstractDumper* parent, IRoseTransitionPtr item);

public:
	virtual ~RoseTransitionDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвращает объект - переход
	virtual IRoseTransitionPtr transition () const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// значение по умолчанию (для атрибутов и аргументов операции)
	virtual const std::string get_initial_value_str () const;

	// overloaded method from ObjectTreeResolver
	// связывает с элементом всех supplier
	virtual void link_suppliers ();


//#UC START# *465E55840157*	
//#UC END# *465E55840157*
}; // class RoseTransitionDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETRANSITIONDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

