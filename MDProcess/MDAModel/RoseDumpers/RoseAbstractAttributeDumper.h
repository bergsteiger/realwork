////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractAttributeDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractAttributeDumper
//
// Дампер для розовских атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTATTRIBUTEDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTATTRIBUTEDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseInitialValue.h"

//#UC START# *4571DF1E00CB_CUSTOM_INCLUDES*
//#UC END# *4571DF1E00CB_CUSTOM_INCLUDES*


// Дампер для розовских атрибутов
class RoseAbstractAttributeDumper;
typedef Core::Var<RoseAbstractAttributeDumper> RoseAbstractAttributeDumper_var;
typedef Core::Var<const RoseAbstractAttributeDumper> RoseAbstractAttributeDumper_cvar;

class RoseAbstractAttributeDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseAbstractAttributeDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractAttributeDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// значение по-умолчанию
	RoseInitialValue_var m_init_value;

	// тип связи на элементе
	mutable std::string m_link_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_link_type () const;

	void set_link_type (const std::string& link_type) const;

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
	// возвращает дампер для вывода значения по-умолчанию
	virtual AbstractDumperBase* get_initial_value () const;

	// overloaded method from AbstractDumperBase
	// значение по умолчанию (для атрибутов и аргументов операции)
	virtual const std::string get_initial_value_str () const;

	// overloaded method from AbstractDumperBase
	// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
	virtual const std::string get_link_type_str () const;

	// overloaded method from AbstractDumperBase
	// возвращает стереотип элемента
	virtual const std::string get_stereotype_str () const;

	// overloaded method from ObjectTreeResolver
	// связывает с элементом всех supplier
	virtual void link_suppliers ();

	// overloaded method from RoseAbstractDumper
	// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
	virtual void update_cached_attrs () const;


//#UC START# *4571DF1E00CB*
public:
	RoseAbstractAttributeDumper (const RoseAbstractDumper* parent, IRoseItemPtr attr, const AbstractDumperBase::StereotypeID& st );

protected:
	bool m_is_rl_attr;
	
	IRoseAttributePtr attr () const;
	IRoseRolePtr rl_attr () const;
	IRoseClassPtr parent_cls () const;
//#UC END# *4571DF1E00CB*
}; // class RoseAbstractAttributeDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTATTRIBUTEDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

