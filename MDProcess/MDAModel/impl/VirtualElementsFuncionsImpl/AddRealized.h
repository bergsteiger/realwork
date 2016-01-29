////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddRealized
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_add_realized(<ГУИД реального элемента или просто имя>, <прозрачность - true | false>) -
// добавляет в список реализуемых элементов элемент, соответствующий гуиду, если задан не ГУИД, а
// просто имя класса - находит в дереве элемент с таким именем и добавляет его, если установлена
// прозрачность связи, то для нее не будут выполняться проверки доступности и видимость, а также,
// такая связь не будет учитываться в графе зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDREALIZED_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDREALIZED_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddRealized; // self forward Var
typedef ::Core::Var<AddRealized> AddRealized_var;
typedef ::Core::Var<const AddRealized> AddRealized_cvar;

class AddRealized_factory;

// %S%f_add_realized(<ГУИД реального элемента или просто имя>, <прозрачность - true | false>) -
// добавляет в список реализуемых элементов элемент, соответствующий гуиду, если задан не ГУИД, а
// просто имя класса - находит в дереве элемент с таким именем и добавляет его, если установлена
// прозрачность связи, то для нее не будут выполняться проверки доступности и видимость, а также,
// такая связь не будет учитываться в графе зависимости
class AddRealized:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddRealized)
	friend class AddRealized_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddRealized ();

	virtual ~AddRealized ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddRealized

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDREALIZED_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
