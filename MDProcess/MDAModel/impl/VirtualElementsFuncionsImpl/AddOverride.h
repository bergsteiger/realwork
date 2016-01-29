////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOverride
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_add_override(<GUID операции>) - добавляет операцию заданную GUID'ом в список
// переопределяемых операции (%O), при этом операция должна принадлежать одному из базовых
// элементов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOVERRIDE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOVERRIDE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.h"

namespace VirtualElementsFuncionsImpl {

class AddOverride; // self forward Var
typedef ::Core::Var<AddOverride> AddOverride_var;
typedef ::Core::Var<const AddOverride> AddOverride_cvar;

class AddOverride_factory;

// %S%f_add_override(<GUID операции>) - добавляет операцию заданную GUID'ом в список
// переопределяемых операции (%O), при этом операция должна принадлежать одному из базовых
// элементов.
class AddOverride:
	virtual public OverrideImplementBase
{
	SET_OBJECT_COUNTER (AddOverride)
	friend class AddOverride_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddOverride ();

	virtual ~AddOverride ();
}; // class AddOverride

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOVERRIDE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
