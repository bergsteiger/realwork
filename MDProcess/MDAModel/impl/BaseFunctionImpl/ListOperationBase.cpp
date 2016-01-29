////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::BaseFunctionImpl::ListOperationBase
//
// базовый класс для работы с переменными - типа список
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.h"

namespace BaseFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListOperationBase::~ListOperationBase () {
	//#UC START# *4B581BCD0399_DESTR_BODY*
	//#UC END# *4B581BCD0399_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает контэйнер (БЕЗ УВЕЛИЧЕНИЯ СЧЕТЧИКА ССЫЛОК) по его идентификатору, если ранее
// контэйнер не был создан - создает его
TemplatePainter::ContainerDumper* ListOperationBase::get_container (const std::string& id) const {
	//#UC START# *4B581C00003B*
	const AbstractDumperBase* var = TemplatePainter::get_var_dumper (id);
	TemplatePainter::ContainerDumper* container = dynamic_cast<TemplatePainter::ContainerDumper*> (
		const_cast<AbstractDumperBase*> (var)
	);

	if (!container) {
		TemplatePainter::ContainerDumper_var newContainer = new TemplatePainter::ContainerDumper (id);
		container = newContainer.ptr ();

		TemplatePainter::set_var_dumper (id, container); //увеличиваем счетчик ссылок на container
	}

	return container;
	//#UC END# *4B581C00003B*
}

// возвращает контэйнер с заданным id (если такого контэйнера нет - возвращает 0)
TemplatePainter::ContainerDumper* ListOperationBase::get_container_if_exists (const std::string& id) const {
	//#UC START# *4B59A5C0021A*
	const AbstractDumperBase* var = TemplatePainter::get_var_dumper (id);
	TemplatePainter::ContainerDumper* container = dynamic_cast<TemplatePainter::ContainerDumper*> (
		const_cast<AbstractDumperBase*> (var)
	);

	return container;
	//#UC END# *4B59A5C0021A*
}

} // namespace BaseFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

