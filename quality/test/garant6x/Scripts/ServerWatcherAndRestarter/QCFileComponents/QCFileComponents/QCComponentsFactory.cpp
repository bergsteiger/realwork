// ComponentsFactory.cpp : Implementation of CComponentsFactory

#include "stdafx.h"
#include "QCComponentsFactory.h"

#include "QCTextStream.h"


// CComponentsFactory

STDMETHODIMP CQCComponentsFactory::InterfaceSupportsErrorInfo(REFIID riid)
{
	static const IID* arr[] = 
	{
		&IID_IQCComponentsFactory
	};

	for (int i=0; i < sizeof(arr) / sizeof(arr[0]); i++)
	{
		if (InlineIsEqualGUID(*arr[i],riid))
			return S_OK;
	}
	return S_FALSE;
}

STDMETHODIMP CQCComponentsFactory::MakeQCTextStream(BSTR path_to_file, QCIOMode qciomode, VARIANT_BOOL is_create, IQCTextStream** result)
{
	CComObject<CQCTextStream>* p;
	HRESULT hr = CComObject<CQCTextStream>::CreateInstance(&p);
	if (FAILED(hr)) return hr;
	//
	IOMode iomode;
	switch (qciomode)
	{
		case QCForReading :
			iomode = ForReading;
			break;
		case QCForWriting :
			iomode = ForWriting;
			break;
		case QCForAppending :
			iomode = ForAppending;
			break;
	}
	//
	hr = p->Initialize(path_to_file, iomode, is_create);
	if (FAILED(hr))
	{	
		// не удалось инициализировать, узнаем почему
		IErrorInfo* p_ei;
		HRESULT eihr = p->QueryInterface(&p_ei);
		if (FAILED(eihr)) {
			return Error("Не удалось инициализировать QCTextStream и узнать почему!");
		}
		BSTR err_desc;
		p_ei->GetDescription(&err_desc);
		p_ei->Release();
		//
		return Error(err_desc, IID_IQCTextStream, hr);
	} else {
		return p->QueryInterface(result);
	}

	
	return S_OK;
}
