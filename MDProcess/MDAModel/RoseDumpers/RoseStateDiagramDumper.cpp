////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateDiagramDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateDiagramDumper
//
// дампер диграмммы состояний
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseStateDiagramDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *465E5060038A_CUSTOM_INCLUDES*
//#UC END# *465E5060038A_CUSTOM_INCLUDES*


//#UC START# *465E5060038A*
//#UC END# *465E5060038A*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// init ctor
RoseStateDiagramDumper::RoseStateDiagramDumper (const RoseAbstractDumper* parent, IRoseStateDiagramPtr diag)
//#UC START# *465E647B0213_BASE_INIT*
: RoseDiagramDumper (diag)
//#UC END# *465E647B0213_BASE_INIT*
{
	//#UC START# *465E647B0213_BODY*	
	//#UC END# *465E647B0213_BODY*
}

RoseStateDiagramDumper::~RoseStateDiagramDumper () {
	//#UC START# *465E5060038A_DESTR_BODY*
	//#UC END# *465E5060038A_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает класс
const std::string RoseStateDiagramDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_465E5060038A*
	return "StateDiagram";
	//#UC END# *465EA35D005D_465E5060038A*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

