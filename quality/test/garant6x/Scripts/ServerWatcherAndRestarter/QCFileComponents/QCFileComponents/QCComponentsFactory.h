// ComponentsFactory.h : Declaration of the CComponentsFactory

#pragma once
#include "resource.h"       // main symbols

#include "QCFileComponents_i.h"


#if defined(_WIN32_WCE) && !defined(_CE_DCOM) && !defined(_CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA)
#error "Single-threaded COM objects are not properly supported on Windows CE platform, such as the Windows Mobile platforms that do not include full DCOM support. Define _CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA to force ATL to support creating single-thread COM object's and allow use of it's single-threaded COM object implementations. The threading model in your rgs file was set to 'Free' as that is the only threading model supported in non DCOM Windows CE platforms."
#endif



// CComponentsFactory

class ATL_NO_VTABLE CQCComponentsFactory :
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CQCComponentsFactory, &CLSID_QCComponentsFactory>,
	public ISupportErrorInfo,
	public IDispatchImpl<IQCComponentsFactory, &IID_IQCComponentsFactory, &LIBID_QCFileComponentsLib, /*wMajor =*/ 1, /*wMinor =*/ 0>
{
public:
	CQCComponentsFactory()
	{
	}

DECLARE_REGISTRY_RESOURCEID(IDR_QCCOMPONENTSFACTORY)

DECLARE_NOT_AGGREGATABLE(CQCComponentsFactory)

BEGIN_COM_MAP(CQCComponentsFactory)
	COM_INTERFACE_ENTRY(IQCComponentsFactory)
	COM_INTERFACE_ENTRY(IDispatch)
	COM_INTERFACE_ENTRY(ISupportErrorInfo)
END_COM_MAP()

// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid);


	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct()
	{
		return S_OK;
	}

	void FinalRelease()
	{
	}

public:

	STDMETHOD(MakeQCTextStream)(BSTR path_to_file, QCIOMode qciomode, VARIANT_BOOL is_create, IQCTextStream** result);
};

OBJECT_ENTRY_AUTO(__uuidof(QCComponentsFactory), CQCComponentsFactory)
