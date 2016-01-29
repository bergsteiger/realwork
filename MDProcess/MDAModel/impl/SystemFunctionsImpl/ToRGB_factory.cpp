////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToRGB
//
// реализация встроенной функции генератора _to_rgb
// _to_rgb(«число», «разделитель») - преобразует цвет заданный числом в формат RGB, возвращает
// строчку, «разделитель» - разделитель используемый для отделения цветов (по умолчанию
// используется ","), Например:
// %f_to_rgb(100) - вернёт 100,0,0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB.h"

namespace SystemFunctionsImpl {

ToRGB_factory::ToRGB_factory () {
}

void ToRGB_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToRGB_factory::key () const {
	return "_to_rgb";
}

TemplateFunctions::InternalFunction* ToRGB_factory::make () {
	ToRGB_var ret = new ToRGB ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

