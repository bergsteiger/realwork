////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractSequenceObject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractSequenceObject
//
// Псевдо-дампер для доступа к элементам сиквенс-диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSequenceObject.h"

//#UC START# *4571A3770203_CUSTOM_INCLUDES*
//#UC END# *4571A3770203_CUSTOM_INCLUDES*


//#UC START# *4571A3770203*
AbstractSequenceObject::AbstractSequenceObject() {
	AbstractDumperBase* m_class = NULL;
}

bool AbstractSequenceObject::operator == (const AbstractDumperBase& c) const {
	return get_name_str() == c.get_name_str() 
		&& get_target() == c.get_target();
}
//#UC END# *4571A3770203*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractSequenceObject::~AbstractSequenceObject () {
	//#UC START# *4571A3770203_DESTR_BODY*
	//#UC END# *4571A3770203_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает имя
const std::string AbstractSequenceObject::get_name_str () const {
	//#UC START# *466554D9006D_4571A3770203*
	return m_name;
	//#UC END# *466554D9006D_4571A3770203*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает класс
const std::string AbstractSequenceObject::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571A3770203*
	return "ClassInstance";
	//#UC END# *465EA35D005D_4571A3770203*
}

// overloaded method from AbstractDumperBase
// возвращает цель
AbstractDumperBase* AbstractSequenceObject::get_target () const {
	//#UC START# *466554FF030D_4571A3770203*
	return m_class;
	//#UC END# *466554FF030D_4571A3770203*
}

// overloaded method from AbstractDumperBase
// возвращает родителя
AbstractDumperBase* AbstractSequenceObject::parent () const {
	//#UC START# *4665549F0251_4571A3770203*
	return m_class;
	//#UC END# *4665549F0251_4571A3770203*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

