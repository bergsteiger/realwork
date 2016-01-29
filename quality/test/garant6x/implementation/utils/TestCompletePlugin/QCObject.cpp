// IQCObject.cpp : Implementation of CQCObject

#include "stdafx.h"
#include "QCObject.h"

// это все мои инклюды
#include "QCShellWatchdog.h"
#include "QCProcessKiller.h"
#include <memory>
#include <sstream>
#include <strstream>
#include <string>

#include <Winsock2.h>
#include <windows.h>

#include "scrshot.h"

// CQCObject

HRESULT CQCObject::TCError(LPCOLESTR errorMsg, HRESULT hRes)
{
	CComVariant str(errorMsg);

	TestCompleteLog(_T("Error"), errorMsg/*&str*/, true);
	
	return Error( errorMsg, IID_IQCObject, hRes );
}


CQCObject::CQCObject()
{
	if ( FAILED( CoGetClassObject(Scripting::CLSID_Dictionary, CLSCTX_INPROC_SERVER, NULL, IID_IClassFactory, reinterpret_cast<void**>(&pIDictFactory) ) ) )
		::MessageBoxA( NULL, "Не удалось инициализировать фабрику Dictionary", "Ошибка", MB_ICONEXCLAMATION);
}

void CQCObject::Initialize() 
{
	InitTypeInfo(IID_IQCObject);
}

static const LCID CONST_LCID = GetUserDefaultLCID();
// IQCObject Methods

STDMETHODIMP CQCObject::IsPluginEnabled(
    VARIANT* Result/*[out,retval]*/
)
{
	Result->vt = VT_BOOL;
	Result->boolVal = true;
	return S_OK;
}

STDMETHODIMP CQCObject::FindElementInArrayByOneDimension(
	VARIANT* inArray, /*[in]*/
	VARIANT* value,  /*[in]*/
	VARIANT* givenIndexes, /*[in]*/
	VARIANT* result/*[out,retval]*/
) 
{	
	// очищаем ответ, empty - означает, что ничего не было найдено
	VariantInit( result );
	
	// проверяем, что заданы индексы для всех размерностей исходного массива
	if( ( (givenIndexes->vt & VT_ARRAY) != VT_ARRAY ) || // если индексы не массив
		( (inArray->vt & VT_ARRAY) != VT_ARRAY ) || // ИЛИ если задан не массив
		( inArray->parray->cDims != givenIndexes->parray->rgsabound[0].cElements ) // или количество индексов не равно размерности заданного массива
		) 
		return S_FALSE;
	// парсим массив данных индексов
	long lowBound, highBound;
	SafeArrayGetLBound(givenIndexes->parray, 1, &lowBound);
	SafeArrayGetUBound(givenIndexes->parray, 1, &highBound);

	std::auto_ptr<long> aptr_indexes ( new long[highBound - lowBound + 1] );
	long *const indexes ( aptr_indexes.get() );
	
	int tmp(0);
	bool isVarIndexFounded(false);
	for (long i = lowBound ; i <= highBound ; i++)
	{	
		VARIANT valFromArr;
		if ( SafeArrayGetElement(givenIndexes->parray, &i, &valFromArr) == S_OK)
			if ( valFromArr.vt == VT_BSTR  )
			{
				tmp = i - lowBound;
				isVarIndexFounded = true;
			}
			else if (valFromArr.vt == VT_I4)
				indexes[i - lowBound] = valFromArr.intVal;
	}
	if (!isVarIndexFounded) return S_FALSE;
	const int varIndexNum(tmp);
	// теперь в indexes занесены заданные значения индексов, а в varIndexNum занесен номер индекса, который будем менять
	
	// Выполняем поиск в массиве
	
	SafeArrayGetLBound(inArray->parray, varIndexNum+1, &lowBound);
	SafeArrayGetUBound(inArray->parray, varIndexNum+1, &highBound);
	
	VARIANT valFromArr;
	
	for (indexes[varIndexNum] = lowBound; indexes[varIndexNum] <= highBound; indexes[varIndexNum]++)
	{
		if ( SafeArrayGetElement(inArray->parray, indexes, &valFromArr) == S_OK )
			if (VarCmp(&valFromArr, value, CONST_LCID, 0) == VARCMP_EQ) 
			{
				result->vt = VT_I4;
				result->intVal = indexes[varIndexNum];
				return S_OK;
			}
	}

	return S_OK;
}

static const OLECHAR *ARRAY_SIGNATURE = OLESTR("Serialized array. By TestComplete.");
static const OLECHAR *MAP_SIGNATURE = OLESTR("Serialized map. By TestComplete.");
static const OLECHAR *END_OF_LINE = OLESTR("\r\n");

// класс для итерации по массиву
class Indexes
{
protected:
	long cDims, maxDim;
	long *indexes;
	long *hBounds;
	long *lBounds;
	bool isEnd;
public:
	
	Indexes(const SAFEARRAY *parray) :
	  isEnd(false)
	{
		cDims = parray->cDims;
		maxDim = cDims - 1;

		indexes = new long[cDims];
		lBounds = new long[cDims];
		hBounds = new long[cDims];

		for (int i = 0; i < cDims; i++)
		{
			lBounds[i] = parray->rgsabound[maxDim-i].lLbound;
			hBounds[i] = parray->rgsabound[maxDim-i].lLbound + parray->rgsabound[maxDim-i].cElements - 1;
			indexes[i] = lBounds[i];
		}
	};

	~Indexes()
	{
		delete[] indexes;
		delete[] lBounds;
		delete[] hBounds; 
	};

	bool Next(void)
	{
		if ( isEnd ) 
			return false;

		for (int i = 0; i < cDims; i++)
			if (indexes[i] < hBounds[i])
			{
				indexes[i]++;
				return true;
			}
			else
			{
				isEnd = (i == maxDim); // признак окончания - когда последний по порядку индекс, при последовательном увеличении, примет максимальное значение
				indexes[i] = lBounds[i];
			}
		return !isEnd;
	}

	long* GetIndexes(void) const
	{
		return indexes;
	}
};

STDMETHODIMP CQCObject::SerializeArray(
	VARIANT* arr, /*[in]*/
	VARIANT* Result/*[out,retval]*/
)
{
	if ( (arr->vt & VT_ARRAY) != VT_ARRAY ) return S_FALSE;
	VariantClear(Result);
	//
	SAFEARRAY *parray = arr->parray;
	
	std::wstringstream buf;
	buf.clear();
	
	Indexes mIndexes(parray);

	const int cDims = parray->cDims;
	
	buf << ARRAY_SIGNATURE << /*END_OF_LINE*/ std::endl << cDims << std::endl; //END_OF_LINE;
	
	for (int i = 0; i < cDims; i++)
	{
		long lowBound, highBound;
		SafeArrayGetLBound(parray, i+1, &lowBound);
		SafeArrayGetUBound(parray, i+1, &highBound);
		buf << lowBound << /*END_OF_LINE*/std::endl << highBound << std::endl; //END_OF_LINE;
	}

	do
	{
		CComVariant valFromArr;
		CComVariant varStr;
		if ( SafeArrayGetElement(parray, mIndexes.GetIndexes(), &valFromArr) == S_OK )
		{ 
			VariantChangeType(&varStr, &valFromArr, VARIANT_ALPHABOOL | VARIANT_NOUSEROVERRIDE, VT_BSTR);
			buf << valFromArr.vt << /*END_OF_LINE*/std::endl << varStr.bstrVal << std::endl; //END_OF_LINE;
		}	

	} while (mIndexes.Next());
	
	Result->vt = VT_BSTR;
	SysReAllocString( &Result->bstrVal, buf.str().c_str() );

	return S_OK;
}

STDMETHODIMP CQCObject::UnSerializeArray(
	VARIANT* str, /*[in]*/
	VARIANT* Result/*[out,retval]*/
)
{
	if (str->vt != VT_BSTR ) return S_FALSE;
	VariantClear(Result);
	
	std::wstringstream srcBuf(str->bstrVal);
	std::wstringstream tempStream;
	std::wstring wStr;

	// проверяем сигнатуру файла 
	std::getline(srcBuf, wStr);
	if ( wStr.find(ARRAY_SIGNATURE) == -1 ) return S_FALSE;

	// считываем размерность массива
	long cDims(-1);
	srcBuf >> cDims;
	if (cDims == -1) return S_FALSE;

	// считываем границы массива
	SAFEARRAYBOUND* bounds = new SAFEARRAYBOUND[cDims];
	for (int i = 0; i < cDims ; i++)
	{
		srcBuf >> bounds[i].lLbound;
		srcBuf >> bounds[i].cElements;
		bounds[i].cElements -= bounds[i].lLbound - 1;
	}

	// создаем массив
	SAFEARRAY* parray = SafeArrayCreate(VT_VARIANT, cDims, bounds);
	if (parray != NULL)
	{ // массив создался
		Indexes mIndexes(parray);

		CComVariant varStr, value;
		varStr.vt = VT_BSTR;
		varStr.bstrVal = SysAllocString(L"");

		do
		{ // прочитываем строки и преобразуем их в элементы массива
			VARTYPE vtType(8);

			srcBuf >> vtType;

			std::getline(srcBuf, wStr); // пропускаем перевод строки

			std::getline(srcBuf, wStr);

			SysReAllocString( &varStr.bstrVal, wStr.c_str() );
			switch ( vtType )
			{
				case VT_EMPTY :
					VariantClear(&value);
					break;
				case VT_I4 :
				case VT_BOOL :
				case VT_R8 :
					VariantChangeType(&value, &varStr, VARIANT_ALPHABOOL | VARIANT_NOUSEROVERRIDE, vtType);
					break;
				case VT_BSTR:
					value = varStr;
					break;				
				default:
					value = varStr;
			}
							
			SafeArrayPutElement(parray, mIndexes.GetIndexes(), &value);

		} while (mIndexes.Next());
	}
	
	Result->vt = VT_ARRAY | VT_VARIANT;
	//SafeArrayCopy(parray, &Result->parray);
	Result->parray = parray;

	return S_OK;
}

STDMETHODIMP CQCObject::String2Array(
	BSTR str, /*[in]*/
	BSTR delimiter,/*[in]*/
	VARIANT* Result /*[out,retval]*/
)
{
	VariantClear(Result);

	std::wstring wsStr(str);
	const std::wstring wsDelimiter(delimiter);
	const size_t delimLength = wsDelimiter.length();
	
	SAFEARRAYBOUND bounds;
	bounds.lLbound = 1;
	bounds.cElements = 1;
	

	SAFEARRAY* parray = SafeArrayCreate(VT_VARIANT, 1, &bounds);
	if (parray != NULL)
	{ // массив создался

		CComVariant varStr;		

		size_t currPos; 
		size_t prevPos(0);
		
		while ( (currPos = wsStr.find(wsDelimiter, prevPos )) != wsStr.npos )
		{
			varStr = wsStr.substr(prevPos, currPos-prevPos).c_str();
			
			SafeArrayPutElement(parray, reinterpret_cast<long*>(&bounds.cElements), &varStr);
			bounds.cElements++;
			SafeArrayRedim(parray, &bounds);
			
			prevPos = currPos + delimLength;
		}
		
		varStr = wsStr.substr(prevPos, wsStr.length()-prevPos+1).c_str();
		SafeArrayPutElement(parray, reinterpret_cast<long*>(&bounds.cElements), &varStr);
	}

	Result->vt = VT_ARRAY | VT_VARIANT;
	Result->parray = parray;

	return S_OK;
}

STDMETHODIMP CQCObject::AddToArray(
	VARIANT* arr, /*[in, out]*/
	VARIANT* value,/*[in]*/
	VARIANT* Result /*[out,retval]*/
)
{
	VariantClear(Result);

	if ( (arr->vt & VT_ARRAY) != VT_ARRAY ) 
	{
		SAFEARRAYBOUND bound;
		bound.cElements = 1;
		bound.lLbound = 0;
		arr->parray = SafeArrayCreate(VT_VARIANT, 1, &bound);
		arr->vt = VT_ARRAY | VT_VARIANT;
	}

	if ( arr->parray != NULL)
	{
		long highBound;
		long lowBound;
		SafeArrayGetUBound(arr->parray, 1, &highBound);
		SafeArrayGetLBound(arr->parray, 1, &lowBound);
		
		CComVariant valFromArr;
		SafeArrayGetElement(arr->parray, &highBound, &valFromArr);
		if (valFromArr.vt != VT_EMPTY)
		{
			highBound++;
			SAFEARRAYBOUND bound = arr->parray->rgsabound[0];
			bound.cElements++;
			SafeArrayRedim(arr->parray, &bound);
		}
		SafeArrayPutElement(arr->parray, &highBound, value);

		Result->vt = VT_I4;
		Result->intVal = highBound - lowBound + 1;
	}
	return S_OK;
}


STDMETHODIMP CQCObject::VarArrayRedim(
		VARIANT* arr, /*[in, out]*/
		VARIANT* highBound/*[in]*/
)
{
	if ( (arr->vt & VT_ARRAY) != VT_ARRAY ) return S_FALSE;
	
	const USHORT cDims = arr->parray->cDims;
	SAFEARRAYBOUND *bounds = new SAFEARRAYBOUND[cDims];
	for ( int i=0; i < cDims ; i++)
		bounds[i] = arr->parray->rgsabound[i];

	bounds[0].cElements = highBound->intVal - bounds[cDims-1].lLbound+1;

	HRESULT res = SafeArrayRedim(arr->parray, bounds);
	delete[] bounds;
	return res;
}

STDMETHODIMP CQCObject::GetArrayElement(
		VARIANT* arr, /*[in*/
		VARIANT* index, /*[in]*/
		VARIANT* Result /*[out,retval]*/
)
{
	VariantClear(Result);
	if ( ((arr->vt & VT_ARRAY) != VT_ARRAY) || ((index->vt & VT_ARRAY) != VT_ARRAY) ) return S_FALSE;
	
	long* indexes = new long[ index->parray->rgsabound->cElements];
	
	Indexes mIndexes(index->parray);
	int i = 0;
	do
	{
		VARIANT valFromArr;
		if ( SafeArrayGetElement(index->parray, mIndexes.GetIndexes(), &valFromArr) == S_OK )
		{
			indexes[i++] = valFromArr.intVal;	
		}	
	} while (mIndexes.Next());

	HRESULT res = SafeArrayGetElement(arr->parray, indexes, Result);
	delete[] indexes;
	return res;
}

STDMETHODIMP CQCObject::PutArrayElement(
		VARIANT* arr, /*[in*/
		VARIANT* index, /*[in]*/
		VARIANT* value /*[in]*/
)
{
	if ( ((arr->vt & VT_ARRAY) != VT_ARRAY) || ((index->vt & VT_ARRAY) != VT_ARRAY) ) return S_FALSE;
	
	long* indexes = new long[ index->parray->rgsabound->cElements];
	
	Indexes mIndexes(index->parray);
	int i = 0;
	do
	{
		VARIANT valFromArr;
		if ( SafeArrayGetElement(index->parray, mIndexes.GetIndexes(), &valFromArr) == S_OK )
		{
			indexes[i++] = valFromArr.intVal;	
		}	
	} while (mIndexes.Next());

	HRESULT res = SafeArrayPutElement(arr->parray, indexes, value);
	delete[] indexes;
	return res;
}

STDMETHODIMP CQCObject::GetParam(
		VARIANT* paramList, /*[in]*/
		BSTR paramName, /*[in]*/
		VARIANT* defaultValue, /*[in]*/
		VARIANT* result /*[out,retval]*/
)
{	
	VariantClear(result);
	
	CComBSTR bsParamName(paramName);
	bsParamName.ToUpper();
	CComVariant varParamName(bsParamName);
	
	Map(paramList, OLESTR("get"), &varParamName, NULL, result);
	//VariantCopy( result, &res );
	
	if ( result->vt == VT_EMPTY )
		VariantCopy(result, defaultValue);

	return S_OK;
}

STDMETHODIMP CQCObject::SetParam(
		VARIANT* paramList, /*[in,out]*/
		BSTR paramName, /*[in]*/
		VARIANT* value /*[in]*/
)
{
	CComVariant res;

	CComBSTR bsParamName(paramName);
	bsParamName.ToUpper();
	CComVariant varParamName(bsParamName);

	return Map(paramList, OLESTR("put"), &varParamName, value, &res);
}

STDMETHODIMP CQCObject::GetIPByHostName(
		VARIANT* hostName, /*[in]*/
		VARIANT* result
)
{
	result->vt = VT_BSTR;
	result->bstrVal = SysAllocString(L"");

	if (hostName->vt != VT_BSTR ) return E_INVALIDARG;
	
	WORD wVersionRequested;
	WSADATA wsaData;
	int err;
	 
	wVersionRequested = MAKEWORD( 1, 1 );
	 
	err = WSAStartup( wVersionRequested, &wsaData );
	if ( err == 0 ) 
	{
		char charBuf[256]; // должно хватить на адрес машины
		wcstombs_s<_countof(charBuf)>(NULL, charBuf, hostName->bstrVal, _TRUNCATE);
		hostent* pHostEnt = gethostbyname(charBuf);
		if ( pHostEnt != NULL )
		{
			wchar_t buf[16];
			swprintf_s<_countof(buf)>(buf, L"%d.%d.%d.%d", (unsigned char)(pHostEnt->h_addr_list[0][0]), (unsigned char)(pHostEnt->h_addr_list[0][1]), (unsigned char)(pHostEnt->h_addr_list[0][2]), (unsigned char)(pHostEnt->h_addr_list[0][3]));
			SysReAllocString(&result->bstrVal, buf);
		} 
		WSACleanup();
	}
	return S_OK;	
}

STDMETHODIMP CQCObject::Map(
		VARIANT* mapObject, /*[in, out]*/
		const BSTR whatToDo, /*[in]*/
		VARIANT* key, /*[in]*/
		VARIANT* value, /*[in]*/
		VARIANT* result /*[out, retval]*/
)
{	
	//
	VariantClear( result );

	Scripting::IDictionaryPtr spDict;
	
	if (( mapObject->vt != VT_DISPATCH ) ||
		((mapObject->vt == VT_DISPATCH ) && ((spDict = mapObject->pdispVal) == NULL)  ) )
	{
		VariantClear(mapObject);

		if ( FAILED( pIDictFactory->CreateInstance(NULL, IID_IDispatch, reinterpret_cast<void**>(&mapObject->pdispVal) ) ) )
		{	
			VariantClear(mapObject);
			return TCError( OLESTR("Не удалось создать экземпляр Scripting.Dictionary!"), E_FAIL ); 
		}

		mapObject->vt = VT_DISPATCH;
	}

	spDict = mapObject->pdispVal;
	if ( spDict == NULL )
		return TCError( OLESTR("Не удалось получить интерфейс IDictionary!"), E_INVALIDARG );

	CComBSTR bsWhatToDo(whatToDo);
	if ( bsWhatToDo == OLESTR("put") ) 
	{ // обрабатываем операцию put
		
		if ( ( value->vt == VT_DISPATCH ) || ( value->vt == VT_UNKNOWN ) )
			return spDict->putref_Item(key, value);
		else
			return spDict->put_Item(key, value);		
	}
	else if ( bsWhatToDo == OLESTR("get") ) 
	{ // обрабатываем операцию get
		VARIANT_BOOL isKeyExists;		
		spDict->Exists(key, &isKeyExists);

		if ( isKeyExists == VARIANT_TRUE )
			return spDict->get_Item(key, result);
		
	}
	else if ( bsWhatToDo == OLESTR("serialize") ) 
	{ // обрабатываем операцию serialize

		std::wostringstream buf;
		buf.clear();
		
		long elemCount;
		spDict->get_Count(&elemCount);

		buf << MAP_SIGNATURE << std::endl << elemCount << std::endl; //END_OF_LINE;
		
		// получаем массив значений
		CComVariant arrItems;		
		spDict->Items(&arrItems);
		// получаем массив ключей
		CComVariant arrKeys;
		spDict->Keys(&arrKeys);
		
		CComVariant varStrKey, varStrItem, varKey, varItem;;
		
		for (long i = 0; i < elemCount ; ++i)
		{
			if (
				SUCCEEDED( SafeArrayGetElement(arrItems.parray, &i, &varItem) ) 
				&& SUCCEEDED( SafeArrayGetElement(arrKeys.parray, &i, &varKey) ) 
			)
			{ 
				if ( 
					FAILED( VariantChangeType(&varStrKey, &varKey, VARIANT_ALPHABOOL | VARIANT_NOUSEROVERRIDE, VT_BSTR) )
					|| FAILED ( VariantChangeType(&varStrItem, &varItem,  VARIANT_ALPHABOOL | VARIANT_NOUSEROVERRIDE, VT_BSTR) ) 
				)
					return TCError(OLESTR("При сериализации не удалось сконвертировать какое-либо значение ключа или данных в строковый тип!"), E_FAIL);
				buf << varKey.vt << std::endl << varStrKey.bstrVal << std::endl << varItem.vt << std::endl << varStrItem.bstrVal << std::endl;
			}
		}
		
		result->vt = VT_BSTR;
		result->bstrVal = ::SysAllocString( buf.str().c_str() );
	}
	else if ( bsWhatToDo == OLESTR("unserialize") )
	{ // обрабатываем операцию unserialize
		if ( key->vt != VT_BSTR)
			return TCError(OLESTR("Параметр key должен быть строкой!"), E_INVALIDARG);

		spDict->RemoveAll();
				
		std::wistringstream srcBuf(key->bstrVal);
		std::wstring wStr;

		// проверяем сигнатуру файла
		std::getline(srcBuf, wStr);
		if ( wStr.find(MAP_SIGNATURE) == -1 ) 
			return TCError(OLESTR("В строке не найдена сигнатура!"), E_INVALIDARG);

		// считываем размерность массива
		long elemCount(-1);
		srcBuf >> elemCount;
		if (elemCount == -1) 
			return TCError(OLESTR("Размер мапы неверен!"), E_INVALIDARG);
		
		CComVariant varStrKey, varStrItem;
		CComVariant varKey, varItem;

		VARTYPE keyType, itemType;
		for (long i = 0; i < elemCount; ++i )
		{ // прочитываем строки
			if (srcBuf.eof()) 
				return TCError(OLESTR("Unserialize. Входной буфер закончился, а из него хотим читать!"), E_INVALIDARG);
			// считываем тип ключа			
			srcBuf >> keyType;
			std::getline(srcBuf, wStr); // пропускаем перевод строки			
			// считываем значение ключа
			std::getline(srcBuf, wStr);
			// конвертируем в Variant
			varStrKey = wStr.c_str();
				
			
			// считываем тип данных
			srcBuf >> itemType;
			std::getline(srcBuf, wStr); // пропускаем перевод строки			
			// считываем значение данных
			std::getline(srcBuf, wStr);
			// конвертируем в Variant
			varStrItem = wStr.c_str();
			
			if ( 
				FAILED(VariantChangeType(&varKey, &varStrKey, VARIANT_ALPHABOOL | VARIANT_NOUSEROVERRIDE, keyType)) 
				|| FAILED( VariantChangeType(&varItem, &varStrItem, VARIANT_ALPHABOOL | VARIANT_NOUSEROVERRIDE, itemType)) 
			)
				return TCError(OLESTR("При десериализации не удалось сконвертировать какое-либо значение ключа или данных в нужный тип!"), E_FAIL);

			spDict->Add(&varKey, &varItem);
		}
	}
	else 
		return TCError(OLESTR("Параметр whatToDo не распознан! Map из плагина поддерживает не все операции!"), E_INVALIDARG);

	return S_OK;
}


STDMETHODIMP CQCObject::SaveBMPFile(BSTR fileName, int hDC, int hBitmap, VARIANT_BOOL* result)
{
	PBITMAPINFO pBmpInfo = CreateBitmapInfoStruct((HBITMAP)hBitmap);
	if ( CreateBMPFile(fileName, pBmpInfo, (HBITMAP)hBitmap, (HDC)hDC) )
		*result = VARIANT_TRUE;
	else
		*result = VARIANT_FALSE;
		
	return S_OK;
}

STDMETHODIMP CQCObject::ShellWatchdog(IQCShellWatchdog** result)
{
	CComObject<CQCShellWatchdog>* pWatchDog;
	HRESULT hr = CComObject<CQCShellWatchdog>::CreateInstance(&pWatchDog);
	if (FAILED(hr)) return hr;
	return pWatchDog->QueryInterface(result);
}

STDMETHODIMP CQCObject::ProcessKiller(IQCProcessKiller** result)
{
	CComObject<CQCProcessKiller>* pProcKiller;
	HRESULT hr = CComObject<CQCProcessKiller>::CreateInstance(&pProcKiller);
	if (FAILED(hr)) return hr;
	return pProcKiller->QueryInterface(result);
}

STDMETHODIMP CQCObject::GetFileVerInfo(BSTR fileName, BSTR infoName, BSTR* result)
{	
	if (_taccess_s(fileName, 0) != 0)
		return TCError(_T("File not found"), E_FAIL);

	const DWORD dwFVISize = GetFileVersionInfoSize(fileName, NULL);
	if (dwFVISize == 0) 
		return TCError(_T("GetFileVersionInfoSize return 0 (may be file not exists or can not be read)"), E_FAIL);
	
	std::auto_ptr<char> buf( new char[dwFVISize] );
	
	if (!GetFileVersionInfo(fileName, NULL, dwFVISize, buf.get()) )
		return TCError(_T("GetFileVersionInfo return false"), E_FAIL);

	TCHAR *pOutBuf;
	UINT uiOutBufSize;

	VerQueryValue(buf.get(), _T("\\VarFileInfo\\Translation"), (LPVOID*)&pOutBuf, &uiOutBufSize);
	if (uiOutBufSize < 4)
		return TCError(_T("VerQueryValue does not return code-page value"), E_FAIL);

	const DWORD dwLangCP = 
		( (*(DWORD*)pOutBuf >> 16) & 0x0000FFFF ) | //code-page
		( (*(DWORD*)pOutBuf << 16) & 0xFFFF0000); //lang info

	TCHAR szLangCP[9];
	_stprintf_s(&szLangCP[0], 9, _T("%.8X"), dwLangCP);

	std::wstring sSubBlock = _T("\\StringFileInfo\\");
	sSubBlock = sSubBlock + szLangCP + _T("\\") + infoName;
	
	if ( !VerQueryValue(buf.get(), sSubBlock.c_str(), (LPVOID*)&pOutBuf, &uiOutBufSize) )
		return TCError(_T("Specified infoName does not exists"), E_FAIL);
	else if (uiOutBufSize > 0)
		::SysReAllocStringLen(result, pOutBuf, uiOutBufSize);

	return S_OK;
}
