////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/ModelStamp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::ModelStamp
//
// штамп модели Розы, посзволяет определять изменялась ли модель с момента посленего построения
// штампа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_MODELSTAMP_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_MODELSTAMP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"


// штамп модели Розы, посзволяет определять изменялась ли модель с момента посленего построения
// штампа
class ModelStamp {
	SET_OBJECT_COUNTER (ModelStamp)

	// singleton declaration
	typedef ACE_Singleton <ModelStamp, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ModelStamp, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ModelStamp* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ModelStamp ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// пересчитывает текщий штамп и сравнивает его с предыдущим, в случае их совпадаения возвращает
	// true, иначе - false
	virtual bool is_stamp_changed ();

private:
	// расчет штампа
	virtual void build_stamp ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// текущий посчитанный штамп
	std::string m_current_stamp;

	// предыдущий штамп
	std::string m_previous_stamp;
}; // class ModelStamp



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_MODELSTAMP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

