////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseModel/RoseModel.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::RoseModel
//
// Собственные обёртки над розовскими типами. Обёртки нужны, чтобы не складывать алгоритмы в одну
// кучу (сейчас это RoseHelper)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"


// factory interface wrapper for Category
Category* CategoryFactory::make (
	IRoseCategoryPtr cat
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CategoryFactoryManager::Singleton::instance ()->make (cat);
}

// factory interface wrapper for IsVirtual
IsVirtual& IsVirtualFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IsVirtualFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for PropertyHelper
PropertyHelper& PropertyHelperFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PropertyHelperFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for ModelPropertiesHelper
ModelPropertiesHelper& ModelPropertiesHelperFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ModelPropertiesHelperFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for TypeLinkHelper
TypeLinkHelper& TypeLinkHelperFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return TypeLinkHelperFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for OverloadedItem
OverloadedItem* OverloadedItemFactory::make (
	const std::string& uid
	, bool need_collect_child
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return OverloadedItemFactoryManager::Singleton::instance ()->make (uid, need_collect_child);
}

// factory interface wrapper for ImplementedItem
ImplementedItem* ImplementedItemFactory::make (
	const std::string& uid
	, bool need_collect_child
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ImplementedItemFactoryManager::Singleton::instance ()->make (uid, need_collect_child);
}

bool InheritedItemComparator::operator () (InheritedItem_var first_param_, InheritedItem_var second_param_) const {
	//#UC START# *4BF38A6E0355_IMPL*
	return first_param_->get_uid () < second_param_->get_uid ();
	//#UC END# *4BF38A6E0355_IMPL*
}

bool ImplementedItemComparator::operator () (ImplementedItem_var first_param_, ImplementedItem_var second_param_) const {
	//#UC START# *4BF38BF60086_IMPL*
	return first_param_->get_uid () < second_param_->get_uid ();
	//#UC END# *4BF38BF60086_IMPL*
}

bool OverloadedItemComparator::operator () (OverloadedItem_var first_param_, OverloadedItem_var second_param_) const {
	//#UC START# *4BF38C57022C_IMPL*
	return first_param_->get_uid () < second_param_->get_uid ();
	//#UC END# *4BF38C57022C_IMPL*
}

// factory interface wrapper for InheritedItemHelper
InheritedItemHelper& InheritedItemHelperFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return InheritedItemHelperFactoryManager::Singleton::instance ()->get ();
}

// factory interface wrapper for ModelSearcher
ModelSearcher& ModelSearcherFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ModelSearcherFactoryManager::Singleton::instance ()->get ();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

