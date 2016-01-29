////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDependencyDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDependencyDumper
//
// Дампер для розовских связей зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDEPENDENCYDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDEPENDENCYDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"

//#UC START# *4571DFE7035B_CUSTOM_INCLUDES*
//#UC END# *4571DFE7035B_CUSTOM_INCLUDES*


// Дампер для розовских связей зависимости
class RoseAbstractDependencyDumper;
typedef Core::Var<RoseAbstractDependencyDumper> RoseAbstractDependencyDumper_var;
typedef Core::Var<const RoseAbstractDependencyDumper> RoseAbstractDependencyDumper_cvar;

class RoseAbstractDependencyDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseAbstractDependencyDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractDependencyDumper ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from ObjectTreeResolver
	// связывает с элементом всех supplier
	virtual void link_suppliers ();


//#UC START# *4571DFE7035B*
public:
	RoseAbstractDependencyDumper (const RoseAbstractDumper* parent, IRoseItemPtr attr, const AbstractDumperBase::StereotypeID& st);

protected:	
	IRoseClassDependencyPtr dep () const;
	IRoseClassPtr parent_cls () const;
	
//#UC END# *4571DFE7035B*
}; // class RoseAbstractDependencyDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDEPENDENCYDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

