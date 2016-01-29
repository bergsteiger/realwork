////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDefaultUC
// Заголовок реализации класса серванта для интерфеса 
//
// %f_set_default_uc(<генератор>,<Идентификатор юзер-секции>,<код юзер-секции>) - заменяет код юзер-
// секции, который генерится шаблоном при первой генерации (или при выставленной галке "rewrite
// user code")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDEFAULTUC_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDEFAULTUC_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.h"

namespace VirtualElementsFuncionsImpl {

class SetDefaultUC; // self forward Var
typedef ::Core::Var<SetDefaultUC> SetDefaultUC_var;
typedef ::Core::Var<const SetDefaultUC> SetDefaultUC_cvar;

class SetDefaultUC_factory;

// %f_set_default_uc(<генератор>,<Идентификатор юзер-секции>,<код юзер-секции>) - заменяет код юзер-
// секции, который генерится шаблоном при первой генерации (или при выставленной галке "rewrite
// user code")
class SetDefaultUC:
	virtual public UCModificationBase
{
	SET_OBJECT_COUNTER (SetDefaultUC)
	friend class SetDefaultUC_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	static const std::string uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetDefaultUC ();

	virtual ~SetDefaultUC ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UCModificationBase
	// возвращает реализацию конкретной функции
	virtual const UCModificationBase::UCModificationFunctionImpl get_uc_function_impl () const;
}; // class SetDefaultUC

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDEFAULTUC_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
