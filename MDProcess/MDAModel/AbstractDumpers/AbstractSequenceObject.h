////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSequenceObject.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSequenceObject
//
// Псевдо-дампер для доступа к элементам сиквенс-диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSEQUENCEOBJECT_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSEQUENCEOBJECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"

//#UC START# *4571A3770203_CUSTOM_INCLUDES*
//#UC END# *4571A3770203_CUSTOM_INCLUDES*


// Псевдо-дампер для доступа к элементам сиквенс-диаграмм
class AbstractSequenceObject;
typedef Core::Var<AbstractSequenceObject> AbstractSequenceObject_var;
typedef Core::Var<const AbstractSequenceObject> AbstractSequenceObject_cvar;

class AbstractSequenceObject :
	virtual public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (AbstractSequenceObject)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractSequenceObject ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// возвращает имя
	virtual const std::string get_name_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// возвращает класс
	virtual const std::string get_model_class_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает цель
	virtual AbstractDumperBase* get_target () const;

	// overloaded method from AbstractDumperBase
	// возвращает родителя
	virtual AbstractDumperBase* parent () const;


//#UC START# *4571A3770203*
public:
	AbstractSequenceObject();
	bool operator == (const AbstractDumperBase& c) const;

protected:
	AbstractDumperBase* m_class;
	std::string m_name;
//#UC END# *4571A3770203*
}; // class AbstractSequenceObject



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSEQUENCEOBJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

