////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddCategory
//
// %S%f_add_category(«UID»,«стереотип»,«имя»,«переменная») - добавляет папку к текущему элементу и
// записывает её в переменную. Пример использования:
// {code}
// %S%f_add_category(_UID_SUFFIX,Test,Unit,CAT)  - создается папка со стереотипом Unit, именем Test
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory.h"

namespace VirtualElementsFuncionsImpl {

AddCategory_factory::AddCategory_factory () {
}

void AddCategory_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddCategory_factory::key () const {
	return "_add_category";
}

TemplateFunctions::InternalStereotypeFunction* AddCategory_factory::make () {
	AddCategory_var ret = new AddCategory ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

