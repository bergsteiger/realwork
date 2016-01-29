////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerFacadeImpl
// Заголовок реализации класса серванта для интерфеса CatLockerFacade
//
// реализация интерфейса обертки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"


class CatLockerFacadeImpl; // self forward Var
typedef ::Core::Var<CatLockerFacadeImpl> CatLockerFacadeImpl_var;
typedef ::Core::Var<const CatLockerFacadeImpl> CatLockerFacadeImpl_cvar;

class CatLockerFacadeImpl_factory;

// реализация интерфейса обертки
class CatLockerFacadeImpl:
	virtual public MDPSupport::CatLockerFacade
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CatLockerFacadeImpl)
	friend class CatLockerFacadeImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CatLockerFacadeImpl (IRoseCategoryPtr cat);

	CatLockerFacadeImpl (IRoseElementPtr elem);

	virtual ~CatLockerFacadeImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseCategoryPtr m_cat;

	bool m_is_change_mode;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MDPSupport::CatLockerFacade
	// возвращает true если кат можно менять
	virtual bool can_change () const;

	// implemented method from MDPSupport::CatLockerFacade
	// возвращает true, если кат можно отлочить
	virtual bool can_commit () const;

	// implemented method from MDPSupport::CatLockerFacade
	// возвращает true, если кат можно залочить
	virtual bool can_lock () const;

	// implemented method from MDPSupport::CatLockerFacade
	// возвращает true, если изменения в кат можно удачно откатить
	virtual bool can_rollback () const;

	// implemented method from MDPSupport::CatLockerFacade
	// модфикация окончена удачно, принять изменения. Если модификация была не удачной,  то в
	// деструкторе CatLockerFacade изменения будут откатаны.
	virtual void do_change ();

	// implemented method from MDPSupport::CatLockerFacade
	// начать модификацию элемента
	virtual bool try_change ();
}; // class CatLockerFacadeImpl



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
