// QCObject.cpp : Implementation of DLL Exports.

#include "stdafx.h"
#include "resource.h"
#include "aqExtensionRegistrator.h"
#include "QCObjectPlugIn.h"

class CQCObjectPluginModule : public CAtlDllModuleT< CQCObjectPluginModule >
{
public :
	DECLARE_LIBID(LIBID_QCObjectLib)
};

CQCObjectPluginModule _AtlModule;
HINSTANCE hInstance;

// DLL Entry Point
extern "C" BOOL WINAPI DllMain(HINSTANCE hInstance, DWORD dwReason, LPVOID lpReserved)
{
	::hInstance = hInstance;
	return _AtlModule.DllMain(dwReason, lpReserved); 
}


EXTERN_C HRESULT STDAPICALLTYPE GetPluginRegistrator(IaqExtensionRegistrator** lpRetVal)
{
	CComObject<CaqExtensionRegistrator>* p;
	HRESULT hr = CComObject<CaqExtensionRegistrator>::CreateInstance(&p);
	if (FAILED(hr)) return hr;

	//CONST GUID key = { 0xA97B0A16, 0x6296, 0x43B4, { 0xBB, 0xE0, 0x59, 0x9C, 0x09, 0x4E, 0x3B, 0xB6 } };
	CONST GUID key =   { 0x46dd5e75, 0x1184, 0x4e3c, { 0xb6, 0xee, 0x9a, 0x4b, 0x0e, 0xda, 0xe5, 0x50} };
	p->SetDescription(key, _T("QualityControl Plug-in Registrator"), _T("MSU NPP Garant-Service. QualityControl Group."));

	AQ_PLUGIN_VERSION version = { 6, 0 };
	p->AddPlugin( CQCObjectPlugIn::CreatePlugin,
	              CQCObjectPlugIn::GetPluginKey(),
	              _T("QC Plug-In"),
	              _T("Set of functions."),
	              version);

	return p->QueryInterface(lpRetVal);
}
