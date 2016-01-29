////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/ListOperationBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::BaseFunctionImpl::ListOperationBase
//
// базовый класс для работы с переменными - типа список
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_LISTOPERATIONBASE_H__
#define __MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_LISTOPERATIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace BaseFunctionImpl {

// базовый класс для работы с переменными - типа список
class ListOperationBase {
	SET_OBJECT_COUNTER (ListOperationBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ListOperationBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// возвращает контэйнер (БЕЗ УВЕЛИЧЕНИЯ СЧЕТЧИКА ССЫЛОК) по его идентификатору, если ранее
	// контэйнер не был создан - создает его
	virtual TemplatePainter::ContainerDumper* get_container (const std::string& id) const;

	// возвращает контэйнер с заданным id (если такого контэйнера нет - возвращает 0)
	virtual TemplatePainter::ContainerDumper* get_container_if_exists (const std::string& id) const;

}; // class ListOperationBase

} // namespace BaseFunctionImpl


#endif //__MDPROCESS_MDAMODEL_BASEFUNCTIONIMPL_LISTOPERATIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

