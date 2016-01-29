////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::MDPFacadeSrv
// Заголовок реализации класса серванта для интерфеса MDPFacade
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"

//#UC START# *462C9FB20331_CUSTOM_INCLUDES*
//#UC END# *462C9FB20331_CUSTOM_INCLUDES*


class MDPFacadeSrv; // self forward Var
typedef ::Core::Var<MDPFacadeSrv> MDPFacadeSrv_var;
typedef ::Core::Var<const MDPFacadeSrv> MDPFacadeSrv_cvar;

class MDPFacadeSrv_factory;

class MDPFacadeSrv:
	virtual public MDPSupport::MDPFacade
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MDPFacadeSrv)
	friend class MDPFacadeSrv_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MDPFacadeSrv ();

	virtual ~MDPFacadeSrv ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_is_login;

	bool m_is_server_exist;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MDPSupport::MDPFacade
	// возвращает false если сервер залочек недоступен
	virtual bool is_server_exist () const;

	// implemented method from MDPSupport::MDPFacade
	// начало сеанса работы с сервером залочек
	virtual bool login ();

	// implemented method from MDPSupport::MDPFacade
	// окончание сеанса работы с сервером залочек
	virtual void logout ();

	// implemented method from MDPSupport::MDPFacade
	// показывает блок диалога со списком  залоченных пакетов
	virtual void show_locked () const;

	// implemented method from MDPSupport::MDPFacade
	// синхронизирует модель (model) на сервере - получает статусы залочек пакетов с сервера
	virtual bool sync (IRoseModelPtr model);

	// implemented method from MDPSupport::MDPFacade
	// "закрывает" модель после синхронизации. Выполняется при закрытии модели.
	virtual bool unsync (IRoseModelPtr model);

//#UC START# *462C9FB20331*
//#UC END# *462C9FB20331*
}; // class MDPFacadeSrv



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
