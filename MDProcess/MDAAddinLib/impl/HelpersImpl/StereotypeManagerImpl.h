////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::StereotypeManagerImpl
// Заголовок реализации класса серванта для интерфеса StereotypeManager
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"

namespace HelpersImpl {

class StereotypeManagerImpl; // self forward Var
typedef ::Core::Var<StereotypeManagerImpl> StereotypeManagerImpl_var;
typedef ::Core::Var<const StereotypeManagerImpl> StereotypeManagerImpl_cvar;

class StereotypeManagerImpl_factory;

// реализация
class StereotypeManagerImpl:
	virtual public Helpers::StereotypeManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StereotypeManagerImpl)
	friend class StereotypeManagerImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StereotypeManagerImpl ();

	virtual ~StereotypeManagerImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Helpers::StereotypeManager
	// Формирует список стереотипов элементов, разрешённых создавать в заданном элементе.
	// Результирующий список отсортирован по частоте использования стереотипов внутри пакета!
	virtual Helpers::StereotypeList* make_allowable_stereotypes (IRoseElementPtr elem, IRoseElementPtr context) const;

	// implemented method from Helpers::StereotypeManager
	// формирует мапу частоты использования стереотипов внутри заданного элемента
	virtual Helpers::StereotypeUseMap* make_use_map (IRoseElementPtr elem) const;
}; // class StereotypeManagerImpl

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_STEREOTYPEMANAGERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
