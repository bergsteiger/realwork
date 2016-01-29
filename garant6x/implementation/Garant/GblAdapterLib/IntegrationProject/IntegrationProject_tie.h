////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"

namespace GblAdapterLib {

class IIntegration_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_integration_complect_id_463F4FA3006D (
		GCI::IO::IString_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;

	virtual IntegrationType __stdcall get_object_by_xml_463F4FF5032C (
		const char* xml
		, Core::IIObject_tie*& result
	) const /*throw (CanNotFindData_tie, InvalidXMLType_tie, CantCreateObject_tie)*/ = 0;


	virtual const bool __stdcall get_integration_enabled () const = 0;
};

class __declspec (dllexport) Integration_tie: public IIntegration_tie {
	SET_OBJECT_COUNTER (Integration_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Integration_tie ();

	typedef ::Core::PoolObjectManager<Integration_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Integration_tie> Pool;
	friend class ::Core::PoolObjectManager<Integration_tie>;
	typedef ::Core::IidMapRegistrator<Integration_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IIntegration_tie* obj, Integration*& ret_, bool interface_addref = false);

	static void make_tie (const Integration* obj, IIntegration_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Integration& obj, IIntegration_tie*& ret_, const Core::TIEBase* owner);

	Integration* m_impl;

protected:
	virtual void __stdcall get_integration_complect_id_463F4FA3006D (
		GCI::IO::IString_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;

	virtual IntegrationType __stdcall get_object_by_xml_463F4FF5032C (
		const char* xml
		, Core::IIObject_tie*& result
	) const /*throw (CanNotFindData_tie, InvalidXMLType_tie, CantCreateObject_tie)*/;


	virtual const bool __stdcall get_integration_enabled () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

