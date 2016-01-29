////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_TemplateContext.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::TemplateContext
//
// контекст генерации шаблона - задаёт текущее "место" генерации (функция, генератор,
// трансформатор...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// блок констант для контекста
const long AbstractDumperBase::TemplateContext::INIT_STACK_SIZE = 32; // начальный размер стэка

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор, по умолчанию резервируем INIT_STACK_SIZE элементов для стэка
AbstractDumperBase::TemplateContext::TemplateContext ()
//#UC START# *46F21E3603B9_BASE_INIT*
//#UC END# *46F21E3603B9_BASE_INIT*
{
	//#UC START# *46F21E3603B9_BODY*
	m_stack.reserve (INIT_STACK_SIZE);
	//#UC END# *46F21E3603B9_BODY*
}

AbstractDumperBase::TemplateContext::~TemplateContext () {
	//#UC START# *46F219CE0203_DESTR_BODY*
	//#UC END# *46F219CE0203_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// очистка стэка
void AbstractDumperBase::TemplateContext::clear () {
	//#UC START# *46F21D84030D*
	m_stack.clear ();
	//#UC END# *46F21D84030D*
}

// пустой ли стэк
bool AbstractDumperBase::TemplateContext::empty () const {
	//#UC START# *46F21EC8031C*
	return m_stack.empty ();
	//#UC END# *46F21EC8031C*
}

// удаляет элемент вершины стэка
void AbstractDumperBase::TemplateContext::pop () {
	//#UC START# *46F22196008C*
	if (m_stack.empty () == false) {
		m_stack.pop_back ();
	}
	//#UC END# *46F22196008C*
}

// помещение данных на вершину стэка
void AbstractDumperBase::TemplateContext::push (const ContextData& data) {
	//#UC START# *46F21DF4003E*
	GDS_ASSERT(!data.function_id/*.get ()*/.empty () || !data.transformator_id/*.get ()*/.empty ());
	m_stack.push_back (data);
	//#UC END# *46F21DF4003E*
}

// переписываем верхушку стэка
void AbstractDumperBase::TemplateContext::rewrite_top (
	const StereotypeID& st
	, const FunctionID& fn
	, const TransformatorID& tr
) {
	//#UC START# *46F2258B002E*
	AbstractDumperBase::ContextData& data = const_cast<AbstractDumperBase::ContextData&> (top ());
	data.stereotype_id = st;
	data.function_id = fn;
	data.transformator_id = tr;
	//#UC END# *46F2258B002E*
}

// возвращает данные на вершине стэка
const AbstractDumperBase::ContextData& AbstractDumperBase::TemplateContext::top () const {
	//#UC START# *46F21D9D0242*
	GDS_ASSERT_MSG(!m_stack.empty (), ("TemplateContext stack must not be empty!"));
	
	return m_stack.back ();
	//#UC END# *46F21D9D0242*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

