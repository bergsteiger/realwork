////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSequenceDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSequenceDumper
//
// Псевдо Дампер для доступа к сиквенс-диаграммам
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSequenceDumper.h"

//#UC START# *4571A360030D_CUSTOM_INCLUDES*
//#UC END# *4571A360030D_CUSTOM_INCLUDES*


//#UC START# *4571A360030D*
AbstractSequenceDumper::AbstractSequenceDumper () {
	m_reciver = NULL;
	m_sender = NULL;
	m_operation = NULL;
}

bool AbstractSequenceDumper::operator == (const AbstractDumperBase& c) const {
	return get_name_str() == c.get_name_str() 
		&& *get_target() == *c.get_target();
}
//#UC END# *4571A360030D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractSequenceDumper::~AbstractSequenceDumper () {
	//#UC START# *4571A360030D_DESTR_BODY*
	//#UC END# *4571A360030D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает имя
const std::string AbstractSequenceDumper::get_name_str () const {
	//#UC START# *466554D9006D_4571A360030D*
	return m_message;
	//#UC END# *466554D9006D_4571A360030D*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает класс
const std::string AbstractSequenceDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571A360030D*
	return "Message";
	//#UC END# *465EA35D005D_4571A360030D*
}

// overloaded method from AbstractDumperBase
// возвращает цель
AbstractDumperBase* AbstractSequenceDumper::get_target () const {
	//#UC START# *466554FF030D_4571A360030D*
	return m_reciver;
	//#UC END# *466554FF030D_4571A360030D*
}

// overloaded method from AbstractDumperBase
// возвращает родителя
AbstractDumperBase* AbstractSequenceDumper::parent () const {
	//#UC START# *4665549F0251_4571A360030D*
	return m_operation;
	//#UC END# *4665549F0251_4571A360030D*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

