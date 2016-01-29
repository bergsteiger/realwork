////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractActionDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractActionDumper
//
// дампер розовских Action
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTACTIONDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTACTIONDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *465FB9A903D8_CUSTOM_INCLUDES*
//#UC END# *465FB9A903D8_CUSTOM_INCLUDES*


// дампер розовских Action
class RoseAbstractActionDumper;
typedef Core::Var<RoseAbstractActionDumper> RoseAbstractActionDumper_var;
typedef Core::Var<const RoseAbstractActionDumper> RoseAbstractActionDumper_cvar;

class RoseAbstractActionDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseAbstractActionDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// init ctor
	RoseAbstractActionDumper (
		const RoseAbstractDumper* parent
		, IRoseActionPtr action
		, const AbstractDumperBase::StereotypeID& st
	);

public:
	virtual ~RoseAbstractActionDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// тип экшена ("do", "exit","entry", "trigger", "send", "")
	std::string m_action_type;

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
	// вид элемента
	virtual const std::string get_class_kind_str () const;


//#UC START# *465FB9A903D8*
//#UC END# *465FB9A903D8*
}; // class RoseAbstractActionDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTACTIONDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

