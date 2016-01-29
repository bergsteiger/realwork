////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractClassDumper
//
// Дампер для Розовских классов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCLASSDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCLASSDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *4571DD3D03D8_CUSTOM_INCLUDES*
//#UC END# *4571DD3D03D8_CUSTOM_INCLUDES*


// Дампер для Розовских классов
class RoseAbstractClassDumper;
typedef Core::Var<RoseAbstractClassDumper> RoseAbstractClassDumper_var;
typedef Core::Var<const RoseAbstractClassDumper> RoseAbstractClassDumper_cvar;

class RoseAbstractClassDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractClassDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractClassDumper ();


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

	// overloaded method from ObjectTreeResolver
	// связывает с элементом всех supplier
	virtual void link_suppliers ();


//#UC START# *4571DD3D03D8*
public:		
	RoseAbstractClassDumper (const RoseAbstractDumper* parent, IRoseClassPtr cls );	
	IRoseClassPtr cls() const;

protected:
	virtual bool check_protected_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const;
	virtual bool check_private_visibility_access (const ObjectTreeResolver* sup, const std::string& link_stereotype) const;
//#UC END# *4571DD3D03D8*
}; // class RoseAbstractClassDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCLASSDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

