// QCObjectPlugIn.h : Declaration of the CQCObjectPlugin

#pragma once
#include "QCObjectLib.h"


// CQCObjectPlugin

class ATL_NO_VTABLE CQCObjectPlugIn : 
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CQCObjectPlugIn>,
	public IaqBasePlugin,
	public ItcRuntimeObjectFactory,
	public ItcCodeCompletionProvider
{
	BEGIN_COM_MAP(CQCObjectPlugIn)
		COM_INTERFACE_ENTRY(ItcCodeCompletionProvider)
		COM_INTERFACE_ENTRY(ItcRuntimeObjectFactory)
		COM_INTERFACE_ENTRY(IaqBasePlugin)
	END_COM_MAP()

public:
	static HRESULT CreatePlugin(IaqBasePlugin * * Value);
	static CONST GUID GetPluginKey();

	CQCObjectPlugIn();

	// IaqBasePlugin Methods
	STDMETHOD(Initialize)(IaqBaseManager * Manager);
	STDMETHOD(Update)();
	STDMETHOD(Finalize)();
	STDMETHOD(BaseManagerStateChanged)(AQ_MAINMANAGER_STATE State);

	// IaqKeyItem Methods
	STDMETHOD_(void, GetKey)(GUID * Value);

	// ItcRuntimeObjectFactory Methods
	STDMETHOD_(void, CreateRuntimeObject)(BSTR ObjectName, GUID * ProjectKey, IDispatch * * Value);

	// ItcCodeCompletionProvider Methods
	STDMETHOD_(void, GetName)(BSTR * Value);
	STDMETHOD_(void, GetDescription)(BSTR * Value);
	STDMETHOD_(long, GetBitmapReference)();
	STDMETHOD_(long, GetTypeInformationCount)();
	STDMETHOD_(void, GetTypeInformation)(long Index, LPUNKNOWN * Value);
 
private:
	CComPtr<ItcRuntimeObjectsManager> m_runtime_objects_manager;
	long m_runtime_object_cookie;

	CComPtr<IDispatch> m_idisp_qcobject;
};
