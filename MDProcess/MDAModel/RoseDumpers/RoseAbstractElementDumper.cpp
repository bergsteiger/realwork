////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractElementDumper
//
// Абстракный дампер для всех IRoseItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571D3040222_CUSTOM_INCLUDES*
//#UC END# *4571D3040222_CUSTOM_INCLUDES*


//#UC START# *4571D3040222*
RoseAbstractElementDumper::RoseAbstractElementDumper (const RoseAbstractDumper* parent, IRoseElementPtr cls, const AbstractDumperBase::StereotypeID& st) 
	: RoseAbstractDumper (parent, cls, st) 
{
}

bool RoseAbstractElementDumper::is_it_first (const ObjectTreeResolver* od) const {
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*>(od);
	if (!rad) {
		return false;
	}
	return (this->elem_order() > rad->elem_order());
}
//#UC END# *4571D3040222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractElementDumper::~RoseAbstractElementDumper () {
	//#UC START# *4571D3040222_DESTR_BODY*
	//#UC END# *4571D3040222_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// алгоритм нахождения типа элемента:
// 1. Получает из настроек идентификатор связанного элемента - находит этот элемент в дереве
// 2. Получает из настроек имя связанного типа, сравнивает его переданным именем типа (current_type)
// 3. Если совпадают - возвращается элемент
// 4. Если не совпадают - запускается алгоритм поиска типа по имени, информация о полученном
// элементе сохраняется в модель
const RoseAbstractDumper* RoseAbstractElementDumper::resolve_target_type (std::string& current_type) {
	//#UC START# *4ABC406501AA*
	IRoseElementPtr elem = this->rose_element ();
	std::string resolved_guid = TypeLinkHelperFactory::get ().get_linked (elem);
	
	if (!resolved_guid.empty ()) {
		const RoseAbstractDumper* resolved_type = RoseAbstractDumper::find_in_tree (resolved_guid);
		if (resolved_type) {		
			std::string resolved_type_full_name = (static_cast<const Base::NamedElement*> (resolved_type))->get_full_name ();

			//проверяем, что полное имя элемента НЕ заканчивается на current_type
			//то нужно обновить его
			if (!GCL::end_with (resolved_type_full_name.c_str (), current_type.c_str ())) {			
				current_type = resolved_type->get_name_str ();
			}

			return resolved_type;
		}
	}

	const RoseAbstractDumper* resolved_type = this->resolve (current_type);
	return resolved_type;
	//#UC END# *4ABC406501AA*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает true, если элемент можно "дампить"
bool RoseAbstractElementDumper::can_dump () const {
	//#UC START# *4AB372760177_4571D3040222*
	return this->accepted_generator();
	//#UC END# *4AB372760177_4571D3040222*
}

// overloaded method from ObjectTreeResolver
// Сортируется ли элементы в порядке создания (в порядке указания на модели) - такие элементы не
// нужно помещать в граф.
bool RoseAbstractElementDumper::sort_in_model_order () const {
	//#UC START# *4AB0CD170066_4571D3040222*
	return true;
	//#UC END# *4AB0CD170066_4571D3040222*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

