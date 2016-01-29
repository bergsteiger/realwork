////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddImplement.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddImplement
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_add_implement(<GUID операции>) - добавляет операцию заданную GUID'ом в список реализуемых
// операции (%o), при этом операция должна принадлежать одному из реализуемых элементов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDIMPLEMENT_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDIMPLEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.h"

namespace VirtualElementsFuncionsImpl {

class AddImplement; // self forward Var
typedef ::Core::Var<AddImplement> AddImplement_var;
typedef ::Core::Var<const AddImplement> AddImplement_cvar;

class AddImplement_factory;

// %S%f_add_implement(<GUID операции>) - добавляет операцию заданную GUID'ом в список реализуемых
// операции (%o), при этом операция должна принадлежать одному из реализуемых элементов.
class AddImplement:
	virtual public OverrideImplementBase
{
	SET_OBJECT_COUNTER (AddImplement)
	friend class AddImplement_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddImplement ();

	virtual ~AddImplement ();
}; // class AddImplement

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDIMPLEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
