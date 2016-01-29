////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractCategoryDumper
//
// Дампер для Розовских папок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCATEGORYDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCATEGORYDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *4571DD1A009C_CUSTOM_INCLUDES*
//#UC END# *4571DD1A009C_CUSTOM_INCLUDES*


// Дампер для Розовских папок
class RoseAbstractCategoryDumper;
typedef Core::Var<RoseAbstractCategoryDumper> RoseAbstractCategoryDumper_var;
typedef Core::Var<const RoseAbstractCategoryDumper> RoseAbstractCategoryDumper_cvar;

class RoseAbstractCategoryDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractCategoryDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractCategoryDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// флаг "локальной" глобальности
	mutable bool m_is_global_locally;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	bool get_is_global_locally () const;

	void set_is_global_locally (bool is_global_locally) const;

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

	// overloaded method from RoseAbstractDumper
	// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
	virtual void update_cached_attrs () const;
private:

	// overloaded method from ObjectTreeResolver
	// Cвойство локальной глобальности - если у пакета выставлено такое свойство, то считается, всем
	// пакетам - соседям доступны элементы из него и его детям доступны элементы соседей, т.е как буд-
	// то между ними протянута связь в обе стороны
	virtual bool is_global_locally () const;


//#UC START# *4571DD1A009C*
public:	
	RoseAbstractCategoryDumper (const RoseAbstractDumper* parent, IRoseCategoryPtr cat);	
	IRoseCategoryPtr cat() const;
	virtual bool is_global() const;

protected:
	// рекурсивная сборка всех include путей у вложенных папок генерируемых в текущий IDL-файл
	//virtual void collect_include (GCL::StrSet& col);
	bool data;
	
//#UC END# *4571DD1A009C*
}; // class RoseAbstractCategoryDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCATEGORYDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

