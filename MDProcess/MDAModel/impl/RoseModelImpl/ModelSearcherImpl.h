////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelSearcherImpl
// Заголовок реализации класса серванта для интерфеса ModelSearcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELSEARCHERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELSEARCHERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class ModelSearcherImpl; // self forward Var
typedef ::Core::Var<ModelSearcherImpl> ModelSearcherImpl_var;
typedef ::Core::Var<const ModelSearcherImpl> ModelSearcherImpl_cvar;

class ModelSearcherImpl_factory;

class ModelSearcherImpl:
	virtual public ModelSearcher
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ModelSearcherImpl)
	friend class ModelSearcherImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// мапа строка-строка
	typedef std::map < std::string, std::string > Str2StrMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ModelSearcherImpl ();

	virtual ~ModelSearcherImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// мапа старый гуид (оригинальный, который получил элемент при первом созданий) - новый гуид,
	// который элемент получает при перетаскивании
	mutable Str2StrMap m_old_uid_to_new_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ModelSearcher
	// обработка удаления элемента с модели
	virtual void on_delete_element (IRoseElementPtr elem) const;

	// implemented method from ModelSearcher
	// обработка создания нового элемента (или загрузка из модели старого)
	virtual void on_new_element (IRoseElementPtr element) const;

	// implemented method from ModelSearcher
	// ищет элемент модели по идентификатору, если не находит - возвращает 0
	virtual IRoseElementPtr search (const std::string& uid) const;
}; // class ModelSearcherImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELSEARCHERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
