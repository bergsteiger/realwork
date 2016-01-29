////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseSequenceDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseSequenceDumper
//
// Дампер Розовских сиквенс-диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESEQUENCEDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESEQUENCEDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSequenceDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *4571D2DD0196_CUSTOM_INCLUDES*
//#UC END# *4571D2DD0196_CUSTOM_INCLUDES*


// Дампер Розовских сиквенс-диаграмм
class RoseSequenceDumper;
typedef Core::Var<RoseSequenceDumper> RoseSequenceDumper_var;
typedef Core::Var<const RoseSequenceDumper> RoseSequenceDumper_cvar;

class RoseSequenceDumper :
	virtual public AbstractSequenceDumper
{
	SET_OBJECT_COUNTER (RoseSequenceDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// создает дампер на основе соответствующего КОМ-объекта
	explicit RoseSequenceDumper (IRoseMessagePtr mess);

public:
	virtual ~RoseSequenceDumper ();


//#UC START# *4571D2DD0196*
//#UC END# *4571D2DD0196*
}; // class RoseSequenceDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESEQUENCEDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

