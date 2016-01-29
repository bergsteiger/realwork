////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSequenceDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSequenceDumper
//
// Псевдо Дампер для доступа к сиквенс-диаграммам
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSEQUENCEDUMPER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSEQUENCEDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"

//#UC START# *4571A360030D_CUSTOM_INCLUDES*
//#UC END# *4571A360030D_CUSTOM_INCLUDES*


// Псевдо Дампер для доступа к сиквенс-диаграммам
class AbstractSequenceDumper;
typedef Core::Var<AbstractSequenceDumper> AbstractSequenceDumper_var;
typedef Core::Var<const AbstractSequenceDumper> AbstractSequenceDumper_cvar;

class AbstractSequenceDumper :
	virtual public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (AbstractSequenceDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~AbstractSequenceDumper ();


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


//#UC START# *4571A360030D*
public:
	AbstractSequenceDumper ();
	bool operator == (const AbstractDumperBase& c) const;

protected:
	AbstractDumperBase* m_reciver;
	AbstractDumperBase* m_sender;
	AbstractDumperBase* m_operation;
	std::string m_message;
//#UC END# *4571A360030D*
}; // class AbstractSequenceDumper



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTSEQUENCEDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

