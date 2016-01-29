////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateDiagramDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateDiagramDumper
//
// дампер диграмммы состояний
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDIAGRAMDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDIAGRAMDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"

//#UC START# *465E5060038A_CUSTOM_INCLUDES*
//#UC END# *465E5060038A_CUSTOM_INCLUDES*


// дампер диграмммы состояний
class RoseStateDiagramDumper;
typedef Core::Var<RoseStateDiagramDumper> RoseStateDiagramDumper_var;
typedef Core::Var<const RoseStateDiagramDumper> RoseStateDiagramDumper_cvar;

class RoseStateDiagramDumper :
	public RoseDiagramDumper
{
	SET_OBJECT_COUNTER (RoseStateDiagramDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// init ctor
	RoseStateDiagramDumper (const RoseAbstractDumper* parent, IRoseStateDiagramPtr diag);

public:
	virtual ~RoseStateDiagramDumper ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;


//#UC START# *465E5060038A*
//#UC END# *465E5060038A*
}; // class RoseStateDiagramDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDIAGRAMDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

