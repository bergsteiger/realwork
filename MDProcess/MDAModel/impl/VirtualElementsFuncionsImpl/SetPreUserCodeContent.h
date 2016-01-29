////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetPreUserCodeContent
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_pre_uc_content(gen_id, uc_id,content) - добавляет дополнительный код перед юзерсекцией
// заданной uc_id для генератора gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPREUSERCODECONTENT_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPREUSERCODECONTENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.h"

namespace VirtualElementsFuncionsImpl {

class SetPreUserCodeContent; // self forward Var
typedef ::Core::Var<SetPreUserCodeContent> SetPreUserCodeContent_var;
typedef ::Core::Var<const SetPreUserCodeContent> SetPreUserCodeContent_cvar;

class SetPreUserCodeContent_factory;

// %S%f_set_pre_uc_content(gen_id, uc_id,content) - добавляет дополнительный код перед юзерсекцией
// заданной uc_id для генератора gen_id
class SetPreUserCodeContent:
	virtual public UCModificationBase
{
	SET_OBJECT_COUNTER (SetPreUserCodeContent)
	friend class SetPreUserCodeContent_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// реализация функции
	static const std::string uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetPreUserCodeContent ();

	virtual ~SetPreUserCodeContent ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UCModificationBase
	// возвращает реализацию конкретной функции
	virtual const UCModificationBase::UCModificationFunctionImpl get_uc_function_impl () const;
}; // class SetPreUserCodeContent

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPREUSERCODECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
