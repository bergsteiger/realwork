////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPostUserCodeContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetPostUserCodeContent
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_post_uc_content(gen_id, uc_id,content) - добавляет дополнительный код  после юзерсекции
// заданной uc_id для генератора gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPOSTUSERCODECONTENT_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPOSTUSERCODECONTENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.h"

namespace VirtualElementsFuncionsImpl {

class SetPostUserCodeContent; // self forward Var
typedef ::Core::Var<SetPostUserCodeContent> SetPostUserCodeContent_var;
typedef ::Core::Var<const SetPostUserCodeContent> SetPostUserCodeContent_cvar;

class SetPostUserCodeContent_factory;

// %S%f_set_post_uc_content(gen_id, uc_id,content) - добавляет дополнительный код  после юзерсекции
// заданной uc_id для генератора gen_id
class SetPostUserCodeContent:
	virtual public UCModificationBase
{
	SET_OBJECT_COUNTER (SetPostUserCodeContent)
	friend class SetPostUserCodeContent_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// реализация функции
	static const std::string uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetPostUserCodeContent ();

	virtual ~SetPostUserCodeContent ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UCModificationBase
	// возвращает реализацию конкретной функции
	virtual const UCModificationBase::UCModificationFunctionImpl get_uc_function_impl () const;
}; // class SetPostUserCodeContent

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETPOSTUSERCODECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
