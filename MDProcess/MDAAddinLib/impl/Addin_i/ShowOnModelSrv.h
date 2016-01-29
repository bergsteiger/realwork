////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/ShowOnModelSrv.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::ShowOnModelSrv
//
// реализация фасета ShowOnModel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_SHOWONMODELSRV_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_SHOWONMODELSRV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinks.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksS.h"


// реализация фасета ShowOnModel
class ShowOnModelSrv;
typedef Core::Var<ShowOnModelSrv> ShowOnModelSrv_var;
typedef Core::Var<const ShowOnModelSrv> ShowOnModelSrv_cvar;

class ShowOnModelSrv :
	virtual public POA_LinkSupport::ConfModelLinks::ShowOnModel
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (ShowOnModelSrv)

	// singleton declaration
	typedef ACE_Singleton <ShowOnModelSrv, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ShowOnModelSrv, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ShowOnModelSrv* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ShowOnModelSrv ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from LinkSupport::ConfModelLinks::ShowOnModel
	// показать элемент в розе, возвращает 0 - если удалось, 1 - если открыта не та модель
	virtual CORBA::Long show (const char* project_name, const char* elem_guid) throw (CORBA::SystemException);
}; // class ShowOnModelSrv



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_SHOWONMODELSRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

