// QCObjectPlugIn.cpp : Implementation of CQCObjectPlugin

#include "stdafx.h"
#include "QCObjectPlugIn.h"
#include "QCObject.h"

// CQCObjectPlugin

CQCObjectPlugIn::CQCObjectPlugIn()
{
}


// IaqBasePlugin Methods

HRESULT STDMETHODCALLTYPE CQCObjectPlugIn::Initialize(IaqBaseManager * Manager)
{
	_ASSERT( Manager != NULL );
	HRESULT hr;
	CComPtr<IaqSubsystemManager> subsystem_manager;

	hr = Manager->get_Managers(IID_ItcRuntimeObjectsManager, &subsystem_manager);
	if (FAILED(hr)) return hr;

	hr = subsystem_manager->QueryInterface(&m_runtime_objects_manager);
	if (FAILED(hr)) return hr;
	subsystem_manager = NULL;


	CComPtr<ItcRuntimeObjectFactory> factory;
	this->QueryInterface(IID_ItcRuntimeObjectFactory, (void**)&factory);
	_ASSERT( factory != NULL );

	GUID key = GUID_NULL;
	m_runtime_object_cookie = m_runtime_objects_manager->RegisterRuntimeObjectFactory(
		CComBSTR(cObjectName),
		VARIANT_FALSE,
		&key,
		factory);

	return S_OK;
}


HRESULT STDMETHODCALLTYPE CQCObjectPlugIn::Update()
{
	return S_OK;
}


HRESULT STDMETHODCALLTYPE CQCObjectPlugIn::Finalize()
{
	m_runtime_objects_manager->RemoveRuntimeObject(m_runtime_object_cookie);

	m_runtime_objects_manager = NULL;

	return S_OK;
}


HRESULT STDMETHODCALLTYPE CQCObjectPlugIn::BaseManagerStateChanged(AQ_MAINMANAGER_STATE /*State*/)
{
	return S_OK;
}


// IaqKeyItem Methods

void STDMETHODCALLTYPE CQCObjectPlugIn::GetKey(GUID * Value)
{
	_ASSERT( Value != NULL );
	*Value = GetPluginKey();
}


CONST GUID CQCObjectPlugIn::GetPluginKey()
{
//	CONST GUID key = // {337AF963-1B72-4efe-B232-ECA15BC0AC5D}
//		{ 0x337af963, 0x1b72, 0x4efe, { 0xb2, 0x32, 0xec, 0xa1, 0x5b, 0xc0, 0xac, 0x5d } };
	
	//{25b6abb4-7fe4-45e5-a7ae-300d999fab42}
	CONST GUID key = 
		{ 0x25b6abb4, 0x7fe4, 0x45e5, { 0xa7, 0xae, 0x30, 0x0d, 0x99, 0x9f, 0xab, 0x42 } };
	return key;
}


HRESULT CQCObjectPlugIn::CreatePlugin(IaqBasePlugin * * Value)
{
	_ASSERT( Value != NULL );

	CComObject<CQCObjectPlugIn>* p;
	HRESULT hr = CComObject<CQCObjectPlugIn>::CreateInstance(&p);
	if (FAILED(hr)) return hr;

	return p->QueryInterface(Value); 
}


// ItcRuntimeObjectFactory Methods

void STDMETHODCALLTYPE CQCObjectPlugIn::CreateRuntimeObject(BSTR ObjectName, GUID * /*ProjectKey*/, IDispatch * * Value)
{
	_ASSERT( Value != NULL );
	if (CComBSTR(ObjectName) == cObjectName)
	{	// наш QCObject - синглтон, мы создаем его только один раз
		if (m_idisp_qcobject == NULL)
		{
			CComObject<CQCObject>* runtime_obj;
			CComObject<CQCObject>::CreateInstance(&runtime_obj);
			runtime_obj->Initialize();
			runtime_obj->QueryInterface(&m_idisp_qcobject);
		}
		
		*Value = m_idisp_qcobject;
		_ASSERT( *Value != NULL );
		(*Value)->AddRef();
	}
	else
	{
		*Value = NULL;
	}
}


// ItcCodeCompletionProvider Methods

void STDMETHODCALLTYPE CQCObjectPlugIn::GetName(BSTR * Value)
{
	_ASSERT( Value != NULL );
	CComBSTR(cObjectName).CopyTo(Value);
}


void STDMETHODCALLTYPE CQCObjectPlugIn::GetDescription(BSTR * Value)
{
	_ASSERT( Value != NULL );
	CComBSTR(cObjectDescription).CopyTo(Value);
}


long STDMETHODCALLTYPE CQCObjectPlugIn::GetBitmapReference()
{
	HBITMAP bitmap = LoadBitmap(hInstance, MAKEINTRESOURCE(IDB_OBJECTBITMAP));
	_ASSERT( bitmap != NULL );
	return (long)bitmap;
}


long STDMETHODCALLTYPE CQCObjectPlugIn::GetTypeInformationCount()
{
	return 1;
}


void STDMETHODCALLTYPE CQCObjectPlugIn::GetTypeInformation(long Index, LPUNKNOWN * Value)
{
	_ASSERT( Index == 0 );
	_ASSERT( Value != NULL );
	if (Index != 0) return;

	CComObject<CQCObject>* tmp_runtime_obj;
	CComObject<CQCObject>::CreateInstance(&tmp_runtime_obj);
	tmp_runtime_obj->Initialize();
	tmp_runtime_obj->QueryInterface(Value);

	CComPtr<ITypeInfo> type_info;
	tmp_runtime_obj->GetTypeInfo(0, 0, &type_info);
	_ASSERT( type_info != NULL );

	type_info->QueryInterface(Value);

	tmp_runtime_obj->Release();
}
