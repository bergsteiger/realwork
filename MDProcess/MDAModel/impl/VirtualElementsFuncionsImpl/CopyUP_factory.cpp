////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyUP
//
// %S%f_copy_up(<УИД или имя элемента>) - копирует значения UP из элемента-источника в элемент-
// цель, при этом в элементе-цели новых свойств не создается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP.h"

namespace VirtualElementsFuncionsImpl {

CopyUP_factory::CopyUP_factory () {
}

void CopyUP_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string CopyUP_factory::key () const {
	return "_copy_up";
}

TemplateFunctions::InternalStereotypeFunction* CopyUP_factory::make () {
	CopyUP_var ret = new CopyUP ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

