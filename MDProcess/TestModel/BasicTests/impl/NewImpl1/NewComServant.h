////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl1/NewComServant.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ComServant::Class>> TestModel::BasicTests::NewImpl1::NewComServant
// Заголовок реализации класса серванта для интерфеса NewComInterface
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL1_NEWCOMSERVANT_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL1_NEWCOMSERVANT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"	
#include "TestModel/BasicTests/LibHome.h"
//#UC START# *49AEE46A01C7_PRE_CUSTOM_INCLUDES*
//#UC END# *49AEE46A01C7_PRE_CUSTOM_INCLUDES*
#include "TestModel/BasicTests/NewComInterfaces/NewComInterfaces_i.h"

namespace BasicTests {
namespace NewImpl1 {


class ATL_NO_VTABLE NewComServant:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<NewComServant, &CLSID_CoNewComInterface>
	, public ISupportErrorInfo
	, public ATL::IDispatchImpl<NewComInterface, &IID_NewComInterface, &LIBID_NewComInterfacesLib>
{
	SET_OBJECT_COUNTER (NewComServant)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~NewComServant ();
//////////////////////////////////////////////////////////////////////////////////////////
// ComServant declaration
public:
	//#UC START# *49AEE46A01C7REGISTRY_RESOURCEID*
	DECLARE_REGISTRY_RESOURCEID("49AEE46A01C7")
	//#UC END# *49AEE46A01C7REGISTRY_RESOURCEID*
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(NewComServant)
		COM_INTERFACE_ENTRY(NewComInterface)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
	END_COM_MAP()
	
	// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid) {
		return S_FALSE;
	}
}; // class NewComServant

} // namespace NewImpl1
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL1_NEWCOMSERVANT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
