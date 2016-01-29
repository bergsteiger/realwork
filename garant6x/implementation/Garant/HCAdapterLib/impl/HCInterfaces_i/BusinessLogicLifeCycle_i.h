////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::BusinessLogicLifeCycle_i
// Заголовок реализации класса серванта для интерфеса BusinessLogicLifeCycle
//
// реализация соответствующего интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_BUSINESSLOGICLIFECYCLE_I_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_BUSINESSLOGICLIFECYCLE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingC.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"

//#UC START# *47861A7102CF_CUSTOM_INCLUDES*
namespace Adapters {
	class IXercesAdapter;
}
//#UC END# *47861A7102CF_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

class BusinessLogicLifeCycle_i; // self forward Var
typedef ::Core::Var<BusinessLogicLifeCycle_i> BusinessLogicLifeCycle_i_var;
typedef ::Core::Var<const BusinessLogicLifeCycle_i> BusinessLogicLifeCycle_i_cvar;

class BusinessLogicLifeCycle_i_factory;

// реализация соответствующего интерфейса
class BusinessLogicLifeCycle_i:
	virtual public HCInterfaces::BusinessLogicLifeCycle
	, virtual public ::Core::RefCountObjectBase
	, virtual public GCM::GCMSimpleServer
{
	SET_OBJECT_COUNTER (BusinessLogicLifeCycle_i)
	friend class BusinessLogicLifeCycle_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <BusinessLogicLifeCycle_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BusinessLogicLifeCycle_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BusinessLogicLifeCycle_i ();

	virtual ~BusinessLogicLifeCycle_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblConsulting::ConsultationManager70_var m_consultation_manager70;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from HCInterfaces::BusinessLogicLifeCycle
	// получить интерфейс к СК  версии 7
	virtual GblConsulting::ConsultationManager70& get_consultation_manager70 () const;

	// implemented method from HCInterfaces::BusinessLogicLifeCycle
	// метод должен быть вызван первым после загрузки dll библиотеки
	virtual void start ();

	// implemented method from HCInterfaces::BusinessLogicLifeCycle
	// метод должен быть вызван перед завершением работы библиотеки
	virtual void stop ();

//#UC START# *47861A7102CF*
public:
	virtual void execute () throw (CORBA::SystemException);
//#UC END# *47861A7102CF*
}; // class BusinessLogicLifeCycle_i

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_BUSINESSLOGICLIFECYCLE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
