////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::MDAFormat
//
// Описание формата хранения модели. Модель храниться в 3-х частях:
// - структурная
// - описательная
// - вспомогательная
// 
// каждая часть описыватеся собственным форматом, все части собираются в один "рутовый файл"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/MDAFormat/LibHome.h"
#include "MDProcess/MDAFormat/Executor.h"

namespace MDAFormat {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&Executor::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *48902AAF011F_ENVIRONMENTS_CONFIG*
	//#UC END# *48902AAF011F_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace MDAFormat

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
