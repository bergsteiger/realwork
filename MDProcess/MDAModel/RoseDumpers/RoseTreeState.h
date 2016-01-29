////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseTreeState
//
// класс инкапсулирет в себе состояние дерева элементов Rose
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETREESTATE_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETREESTATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"


// класс инкапсулирет в себе состояние дерева элементов Rose
class RoseTreeState {
	SET_OBJECT_COUNTER (RoseTreeState)

	// singleton declaration
	typedef ACE_Singleton <RoseTreeState, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RoseTreeState, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static RoseTreeState* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// default ctor
	RoseTreeState ();

	virtual ~RoseTreeState ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвращает флаг измененности
	virtual bool is_changed () const;

	// сброс информации о состоянии
	virtual void reset ();

	// установка флага изменённости
	virtual void set_changed (bool changed);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// флаг определяет, что дерево розы изменилось
	bool m_changed;
}; // class RoseTreeState



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETREESTATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

