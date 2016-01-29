////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddClass
//
// %S%f_add_class(<GUID нового элемента>,<стереотип>,<имя класса>,<имя переменной>) - создает новый
// элемент - класс с заданным именем и стереотипом, сохраняет его в переменной и добавляет как
// ребенка к текущему элементу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass.h"

namespace VirtualElementsFuncionsImpl {

AddClass_factory::AddClass_factory () {
}

void AddClass_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddClass_factory::key () const {
	return "_add_class";
}

TemplateFunctions::InternalStereotypeFunction* AddClass_factory::make () {
	AddClass_var ret = new AddClass ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

