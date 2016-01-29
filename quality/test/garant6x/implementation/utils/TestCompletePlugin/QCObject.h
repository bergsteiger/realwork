// QCObject.h : Declaration of the CQCObject

#pragma once
#include "QCObjectLib.h"

#include "commonForObjects.h"

extern "C" const TCHAR __declspec(selectany) cObjectName[] = _T("QCPlugin");
extern "C" const TCHAR __declspec(selectany) cObjectDescription[] = _T("Набор функций группы качества.");

// CQCObject

class ATL_NO_VTABLE CQCObject :
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CQCObject, &CLSID_QCObject>,
	public IDispatchImpl<IQCObject, &IID_IQCObject, &LIBID_QCObjectLib, /*wMajor =*/ 1, /*wMinor =*/ 0>
{
	BEGIN_COM_MAP(CQCObject)
		COM_INTERFACE_ENTRY(IQCObject)
		COM_INTERFACE_ENTRY(IDispatch)
	END_COM_MAP()

public:
	CQCObject();
	void Initialize();

	// IQCObject Methods	
	STDMETHOD(IsPluginEnabled)(VARIANT* Result);
	
	STDMETHOD(FindElementInArrayByOneDimension)(
		VARIANT* inArray, /*[in]*/
		VARIANT* value,  /*[in]*/
		VARIANT* givenIndexes, /*[in]*/
		VARIANT* result/*[out,retval]*/
	);

	STDMETHOD(SerializeArray)(
		VARIANT* arr, /*[in]*/
		VARIANT* Result/*[out,retval]*/
	);

	STDMETHOD(UnSerializeArray)(
		VARIANT* str, /*[in]*/
		VARIANT* Result/*[out,retval]*/
	);

	STDMETHOD(String2Array)(
		BSTR str, /*[in]*/
		BSTR delimiter,/*[in]*/
		VARIANT* Result /*[out,retval]*/
	);

	STDMETHOD(AddToArray)(
		VARIANT* arr, /*[in, out]*/
		VARIANT* value,/*[in]*/
		VARIANT* Result /*[out,retval]*/
	);

	STDMETHOD(VarArrayRedim)(
		VARIANT* arr, /*[in, out]*/
		VARIANT* highBound/*[in]*/
	);

	STDMETHOD(GetArrayElement)(
		VARIANT* arr, /*[in*/
		VARIANT* index, /*[in]*/
		VARIANT* Result /*[out,retval]*/
	);

	STDMETHOD(PutArrayElement)(
		VARIANT* arr, /*[in*/
		VARIANT* index, /*[in]*/
		VARIANT* value /*[in]*/
	);

	STDMETHOD(GetParam)(
		VARIANT* paramList, /*[in]*/
		BSTR paramName, /*[in]*/
		VARIANT* defaultValue, /*[in]*/
		VARIANT* result /*[out,retval]*/
	);

	STDMETHOD(SetParam)(
		VARIANT* paramList, /*[in,out]*/
		BSTR paramName, /*[in]*/
		VARIANT* value /*[in]*/
	);

	STDMETHOD(GetIPByHostName)(
		VARIANT* hostName, /*[in]*/
		VARIANT* result
	);

	STDMETHOD(Map)(
		VARIANT* mapObject, /*[in, out]*/
		const BSTR whatToDo, /*[in]*/
		VARIANT* key, /*[in]*/
		VARIANT* value, /*[in]*/
		VARIANT* result /*[out, retval]*/
	);



private:
	HRESULT TCError(
		LPCOLESTR errorMsg,
		HRESULT hRes = S_OK
	);

	
	IClassFactoryPtr pIDictFactory;
public:
	STDMETHOD(SaveBMPFile)(BSTR fileName, int hDC, int hBitmap, VARIANT_BOOL* result);
	STDMETHOD(ShellWatchdog)(IQCShellWatchdog** result);
	STDMETHOD(ProcessKiller)(IQCProcessKiller** result);	
	STDMETHOD(GetFileVerInfo)(BSTR fileName, BSTR infoName, BSTR* result);
	};
