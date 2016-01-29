////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseInitialValue.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseInitialValue
//
// дампер значечений начальных значений (используетс€ дл€ вывода начальных значений атрибутов и
// параметров операций)
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEINITIALVALUE_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEINITIALVALUE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *473D50220261_CUSTOM_INCLUDES*
//#UC END# *473D50220261_CUSTOM_INCLUDES*


// дампер значечений начальных значений (используетс€ дл€ вывода начальных значений атрибутов и
// параметров операций)
class RoseInitialValue;
typedef Core::Var<RoseInitialValue> RoseInitialValue_var;
typedef Core::Var<const RoseInitialValue> RoseInitialValue_cvar;

class RoseInitialValue :
	virtual public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (RoseInitialValue)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// parent - родитель элемента-значени€ по-умолчанию
	explicit RoseInitialValue (RoseAbstractDumper* parent);

public:
	virtual ~RoseInitialValue ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ¬ыполн€етс€ св€зывание значени€ по-умолчанию с конкретным типом. “ип определ€етс€ по следующему
	// алгоритму: если строка, соответствующа€ значению по-умолчанию записана в формате: [VALUE], то
	// на модели ищетс€ элемент с именем VALUE, и с ним св€зываетс€ родитель элемента - значение по
	// умолчанию (дл€ правильной сортировки по зависимости), тип значени€-по-умолчанию устанавливаетс€
	// равным типу элемента VALUE, в качестве значени€ по-умолчанию устанавливаетс€ строка: VALUE.
	// ≈сли же формат строки иной, то тип значени€-поумолчанию устанавливаетс€ равным типу
	// родительского элемента.
	// в параметр value - записываетс€ строка значение по умолчанию.
	virtual void link (std::string& value);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// значение по-умолчанию
	std::string m_init_value;

	// –одитель значени€ по-умолчанию, может быть либо атрибут, либо параметр-операции
	RoseAbstractDumper* m_parent;

	// тип значени€ по умолчанию, может быть пустым
	AbstractDumperBase* m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// возвращает им€
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


//#UC START# *473D50220261*
	bool operator == (const AbstractDumperBase& c) const;
//#UC END# *473D50220261*
}; // class RoseInitialValue



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEINITIALVALUE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

