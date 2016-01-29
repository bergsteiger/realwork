/*******************************************************************/
/*                                                                 */
/*       AutomatedQA Corp.                                         */
/*       Late binding support                                      */
/*       Target compiler(s): Visual C++ 6, .NET, 2005;             */
/*                           C++Builder 3, 4, 5, 6                 */
/*                                                                 */
/*       Copyright (c) AutomatedQA Corp.                           */
/*       ALL RIGHTS RESERVED                                       */
/*                                                                 */
/*******************************************************************/

#if !defined(SCRIPT_H__5061756C_536F_6C6F_646B_792054756C61__INCLUDED_)
#define SCRIPT_H__5061756C_536F_6C6F_646B_792054756C61__INCLUDED_

#if defined(_MSC_VER) && (_MSC_VER > 1000)
#pragma once
#include <crtdbg.h>
#endif // _MSC_VER > 1000

#include <objbase.h>
#include <limits.h>
#include <tchar.h>
#include <memory>

#ifdef _MFC_VER

#include <afx.h>

#endif //_MFC_VER

#ifdef __BORLANDC__

#include <system.hpp>
#include "utilcls.h"
#include <dstring.h>

#if __BORLANDC__  > 0x530   // BCB version > 3

#pragma warn -8008
#pragma warn -8066

#else

#include <oleauto.h>

#pragma warn -ccc
#pragma warn -rch

#endif // __BORLANDC__  > 0x530

#endif //__BORLANDC__

namespace script
{
///////////////////////////////////////////////////////////////////////

typedef enum tagTPriorityMessage
{
    pmLowest    = 100,
    pmLower     = 200,
    pmNormal    = 300,
    pmHigher    = 400,
    pmHighest   = 400
} TPriorityMessage;

typedef enum tagTFontMessage
{
    fmBold     = 1,
    fmItalic   = 2,
    fmUnderline = 4,
    fmStrikeOut = 8
} TFontMessage;

typedef enum tagTShiftKey
{
    skNoShift = 0x0000,
    skShift = 0x2000,
    skAlt = 0x8000,
    skCtrl = 0x4000
} TShiftKey;

#if !defined(__BORLANDC__) || !defined(StdCtrlsHPP)
const
  int cbUnchecked = 0,
	cbChecked = 1,
	cbGrayed = 2;
#endif


///////////////////////////////////////////////////////////////////////

class COleInit
{
    COINIT m_initKind;
    HRESULT m_hRes;
public:

#if (_WIN32_WINNT >= 0x0400 ) || defined(_WIN32_DCOM) // DCOM
  COleInit(COINIT kind = COINIT_APARTMENTTHREADED)
  {
        m_initKind = kind;
        m_hRes = CoInitializeEx(NULL, kind);

#if defined(_MSC_VER)
   _ASSERTE(SUCCEEDED(m_hRes));
#endif
  }
#else
  COleInit()
  {
        m_initKind = COINIT_APARTMENTTHREADED;
        m_hRes = CoInitialize(NULL);

#if defined(_MSC_VER)
   _ASSERTE(SUCCEEDED(m_hRes));
#endif
  }
#endif // DCOM


  ~COleInit()
  {
    if( m_hRes == S_OK || m_hRes == S_FALSE)
        CoUninitialize();
  }
};



///////////////////////////////////////////////////////////////////////////////////////////
// CInvokeException
///////////////////////////////////////////////////////////////////////////////////////////

#define ERRBUFSIZE 255

class CInvokeException
{  
public:
    HRESULT errCode;

  TCHAR errBuffer[ERRBUFSIZE];

	CInvokeException(){errCode=S_OK;}

#ifdef _UNICODE


    CInvokeException* WriteError(LPOLESTR prefx1,LPOLESTR prefx2,LPOLESTR prefx3, HRESULT error)
    {
      errCode = error;
      int shift=0;
      int size=0;
      
      if (prefx1!=NULL && shift+1<ERRBUFSIZE)
      {
          size = wcslen(prefx1);
          if(size+1<ERRBUFSIZE) { wcscpy(errBuffer,prefx1); shift+=size;}
      }
      
      if (prefx2!=NULL && shift+1<ERRBUFSIZE)
      {
          size =wcslen(prefx2);
          if(shift+size+1<ERRBUFSIZE) {wcscpy(errBuffer+shift,prefx2); shift+=size;}
      }
      
      if(prefx3!=NULL && shift+1<ERRBUFSIZE)
      {
          size =wcslen(prefx3);
          if(shift+size+1<ERRBUFSIZE) {wcscpy(errBuffer+shift,prefx3); shift+=size;}
      }
      
      if (error!=0 && shift+1<ERRBUFSIZE)
          FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM|FORMAT_MESSAGE_ARGUMENT_ARRAY,NULL, 
                      error, 0, errBuffer+shift,ERRBUFSIZE-shift, NULL);
      
      return this;
    }

    CInvokeException* WriteError(LPOLESTR prefx1,const char* prefx2,LPOLESTR prefx3, HRESULT error)
    {
      errCode = error;
      int shift=0;
      int size=0;
      
      if (prefx1!=NULL && shift+1<ERRBUFSIZE)
      {
          size = wcslen(prefx1);
          if(size+1<ERRBUFSIZE) { wcscpy(errBuffer,prefx1); shift+=size;}
      }
      
      if (prefx2!=NULL && shift+1<ERRBUFSIZE)
      {
          size =strlen(prefx2);
      shift += MultiByteToWideChar(CP_ACP, 0, prefx2, size,errBuffer+shift,ERRBUFSIZE-shift);
      errBuffer[shift] = 0;
      }
      
      if(prefx3!=NULL && shift+1<ERRBUFSIZE)
      {
          size =wcslen(prefx3);
          if(shift+size+1<ERRBUFSIZE) {wcscpy(errBuffer+shift,prefx3); shift+=size;}
      }
      
      if (error!=0 && shift+1<ERRBUFSIZE)
          FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM|FORMAT_MESSAGE_ARGUMENT_ARRAY,NULL, 
                      error, 0, errBuffer+shift,ERRBUFSIZE-shift, NULL);
      
      return this;
    }


#else

    CInvokeException* WriteError(const char* prefx1,LPOLESTR prefx2,const char* prefx3, HRESULT error)
    {
        errCode = error;
        int shift=0;
        int size=0;

        if (prefx1!=NULL && shift+1<ERRBUFSIZE)
        {
            size = (int)strlen(prefx1);
            if (size+1<ERRBUFSIZE) { strcpy(errBuffer,prefx1); shift+=size;}
        }
      
      if (prefx2!=NULL && shift+1<ERRBUFSIZE)
      {
          size = (int)wcslen(prefx2);
          shift+=WideCharToMultiByte(CP_ACP,0,prefx2,size,errBuffer+shift,ERRBUFSIZE-shift,NULL,NULL);
      }
      
      if (prefx3!=NULL && shift+1<ERRBUFSIZE)
      {
          size = (int)strlen(prefx3);
          if (shift+size+1<ERRBUFSIZE) {strcpy(errBuffer+shift,prefx3); shift+=size;}
      }
      
      if (error!=0 && shift+1<ERRBUFSIZE)
          FormatMessageA(FORMAT_MESSAGE_FROM_SYSTEM|FORMAT_MESSAGE_ARGUMENT_ARRAY,NULL, 
                      error, 0, errBuffer+shift,ERRBUFSIZE-shift, NULL);
      return this;
    }

    CInvokeException* WriteError(const char* prefx1,LPOLESTR prefx2,LPOLESTR prefx3, HRESULT error)
    {
        errCode = error;
        int shift=0;
        int size=0;
        
        if (prefx1!=NULL && shift+1<ERRBUFSIZE)
        {
            size = (int)strlen(prefx1);
            if (size+1<ERRBUFSIZE) { strcpy(errBuffer,prefx1); shift+=size;}
        }
        
        if (prefx2!=NULL && shift+1<ERRBUFSIZE)
        {
            size = (int)wcslen(prefx2);
            shift+=WideCharToMultiByte(CP_ACP,0,prefx2,size,errBuffer+shift,ERRBUFSIZE-shift,NULL,NULL);
        }

        if (prefx3!=NULL && shift+1<ERRBUFSIZE)
        {
            size = (int)wcslen(prefx3);
            shift+=WideCharToMultiByte(CP_ACP,0,prefx3,size,errBuffer+shift,ERRBUFSIZE-shift,NULL,NULL);
        }

        if (error!=0 && shift+1<ERRBUFSIZE)
              FormatMessageA(FORMAT_MESSAGE_FROM_SYSTEM|FORMAT_MESSAGE_ARGUMENT_ARRAY,NULL, 
                          error, 0, errBuffer+shift,ERRBUFSIZE-shift, NULL);
        return this;
    }


  CInvokeException* WriteError(const char* prefx1,const char* prefx2,const char* prefx3, HRESULT error)
  {
      errCode = error;
      int shift=0;
      int size=0;
      
      if (prefx1!=NULL && shift+1<ERRBUFSIZE)
      {
          size = (int)strlen(prefx1);
          if(size+1<ERRBUFSIZE) { strcpy(errBuffer,prefx1); shift+=size;}
      }
      
      if (prefx2!=NULL && shift+1<ERRBUFSIZE)
      {
          size = (int)strlen(prefx2);
          if(shift+size+1<ERRBUFSIZE) {strcpy(errBuffer+shift,prefx2); shift+=size;}
      }
      
      if(prefx3!=NULL && shift+1<ERRBUFSIZE)
      {
          size = (int)strlen(prefx3);
          if(shift+size+1<ERRBUFSIZE) {strcpy(errBuffer+shift,prefx3); shift+=size;}
      }
      
      if (error!=0 && shift+1<ERRBUFSIZE)
          FormatMessageA(FORMAT_MESSAGE_FROM_SYSTEM|FORMAT_MESSAGE_ARGUMENT_ARRAY,NULL, 
                      error, 0, errBuffer+shift,ERRBUFSIZE-shift, NULL);
      
      return this;
  }

#endif

};

////////////////////////////////////////////////////////////////////////////////////////

inline HRESULT Ansi2Unicode(LPCSTR pszA, LPOLESTR* ppszW)
{
    DWORD dwError;
    static CInvokeException Exception;
 
    if(NULL == pszA){*ppszW = NULL; return NOERROR;}
    
    ULONG cCharacters =  (ULONG)strlen(pszA)+1;

    *ppszW = new wchar_t[cCharacters];    
    if (NULL == *ppszW) 
        throw Exception.WriteError(NULL,(LPOLESTR)NULL,(LPOLESTR)NULL,E_OUTOFMEMORY);


    int resSize = MultiByteToWideChar(CP_ACP, 0, pszA, cCharacters-1,*ppszW, cCharacters);
    (*ppszW)[resSize] = 0;

    if (0 == resSize && cCharacters != 1)    
    {
        dwError = GetLastError();
        delete [](*ppszW);
        *ppszW = NULL;
        throw Exception.WriteError(NULL,(LPOLESTR)NULL,(LPOLESTR)NULL,HRESULT_FROM_WIN32(dwError));
   }   

   return NOERROR;
}


inline HRESULT Unicode2Ansi(LPCOLESTR pszW, LPSTR* ppszA)
{
    static CInvokeException Exception;
    ULONG cCharacters = 0;    
    DWORD dwError = 0;

    if(pszW == NULL) { *ppszA = NULL; return NOERROR;}

    cCharacters = (int)wcslen(pszW)+1;
  
    *ppszA = new char[cCharacters];
    if(NULL == *ppszA) 
        throw Exception.WriteError(NULL,(LPOLESTR)NULL,(LPOLESTR)NULL,E_OUTOFMEMORY);

    int resSize = WideCharToMultiByte(CP_ACP,0,pszW,cCharacters-1,*ppszA,cCharacters,NULL,NULL);
    (*ppszA)[resSize]=0;
    
    if (0 == resSize && cCharacters != 1) 
    {
        dwError = GetLastError(); 
        delete [] (*ppszA);        
        *ppszA = NULL;
        throw Exception.WriteError(NULL,(LPOLESTR)NULL,(LPOLESTR)NULL,HRESULT_FROM_WIN32(dwError));
    }    

  return NOERROR;
}


///////////////////////////////////////////////////////////////////////////////////////////
// CVariantWrap
///////////////////////////////////////////////////////////////////////////////////////////

class CVariantWrap  : public VARIANT
{

public:


    //Conversion from...
    CVariantWrap(BYTE byteVal);                         //...BYTE
    CVariantWrap(short shortVal);                       //...short
    CVariantWrap(const bool bVal);                      //...bool ("const" to avoid conversions to bool)
    CVariantWrap(int intVal,VARTYPE vtArg = VT_EMPTY);  //...int
    CVariantWrap(long longVal,VARTYPE vtArg = VT_I4);   //...long
    CVariantWrap(unsigned long longVal);                //...unsigned long

    CVariantWrap(float fltVal);                         //...float
    CVariantWrap(double dblVal,VARTYPE vtArg = VT_R8);  //...double
    CVariantWrap(const CY cyVal);                       //...const CY&
    CVariantWrap(const DECIMAL dVal);                   //...const DECIMAL&
    CVariantWrap(const char* charStr);                  //...const char*
    CVariantWrap(LPCOLESTR str);                        //...LPCOLESTR
    CVariantWrap(BSTR charStr,BOOL isAttachOnly);       //...BSTR
    CVariantWrap(IUnknown* pUnk,BOOL isAddRef=TRUE);    //...IUnknown*
    CVariantWrap(IDispatch* pDisp,BOOL isAddRef=TRUE);  //...IDispatch*
    CVariantWrap(VARIANT var,BOOL isAttachOnly);        //...VARIANT&
#ifdef _MFC_VER
    CVariantWrap(CString str);                          //...CString&
#endif
#ifdef __BORLANDC__
    CVariantWrap(AnsiString str);                       //...AnsiString&
#endif

    //Assignment operators
    CVariantWrap& operator=(BYTE bVal);                 //...BYTE
    CVariantWrap& operator=(short shortVal);            //...short
    CVariantWrap& operator=(bool bVal);                 //...bool
    CVariantWrap& operator=(int intVal);                //...int
    CVariantWrap& operator=(long longVal);              //...long
    CVariantWrap& operator=(float fltVal);              //...float
    CVariantWrap& operator=(double dblVal);             //...double
    CVariantWrap& operator=(const CY cyVal);            //...const CY&
    CVariantWrap& operator=(const DECIMAL decVal);      //...const DECIMAL&
    CVariantWrap& operator=(const char* pVal);          //...const char*
    CVariantWrap& operator=(LPCOLESTR pVal);            //...LPCOLESTR
    CVariantWrap& operator=(const BSTR rVal);           //...const BSTR
    CVariantWrap& operator=(const IUnknown* pVal);      //...IUnknown*
    CVariantWrap& operator=(const IDispatch* pVal);     //...IDispatch*
    CVariantWrap& operator=(const VARIANT varVal);      //...const VARIANT&
#ifdef _MFC_VER
    CVariantWrap& operator=(const CString str);         //...CString&
#endif
#ifdef __BORLANDC__
    CVariantWrap& operator=(const AnsiString str);      //...AnsiString&
#endif

	// arithmetic operators
	CVariantWrap& operator++(); 
	CVariantWrap operator++(int);
	CVariantWrap& operator--(); 
	CVariantWrap operator--(int);


#if defined(_MFC_VER) && (__BORLANDC__  > 0x530)
	// logic operators
    template <class T> bool operator<(T var);
    template <class T> bool operator>(T var);
    template <class T> bool operator==(T var);
    template <class T> bool operator<=(T var);
    template <class T> bool operator>=(T var);
#endif

	// Conversion to...
    operator BYTE();                                    // ...BYTE
    operator short();                                   // ...short
    operator bool();                                    // ...bool
    operator int();                                     // ...int
    operator long();                                    // ...long
    operator float();                                   // ...float
    operator double();                                  // ...double
    operator CY();                                      // ...CY
    operator DECIMAL();                                 // ...DECIMAL
    char* CreateAnsi();                                 // ...char*
    LPOLESTR CreateUnicode();                           // ...LPOLESTR
    BSTR CreateBSTR();                                  // ...BSTR
    operator IDispatch*();                              // ...IDispatch*
    operator IUnknown*();                               // ...IUnknown*
#ifdef _MFC_VER
    operator CString();                                 //...CString
#endif
#ifdef __BORLANDC__
    operator AnsiString();                              //...AnsiString
#endif

  /////////// BYREF ////////////

    //Construct VT_BYREF on ...
    CVariantWrap(BYTE* pByte);                          //...BYTE*
    CVariantWrap(short* pShort, VARTYPE vtArg = VT_I2); //...short*
    CVariantWrap(int* pInt);                            //...int*
    CVariantWrap(long* pLong , VARTYPE vtArg = VT_I4);  //...long*
    CVariantWrap(float* pFlt);                          //...float*
    CVariantWrap(double* pDbl,VARTYPE vtArg = VT_R8);   //...double*
    CVariantWrap(CY* pCY);                              //...const CY*
    CVariantWrap(DECIMAL* pDEC);                        //...const DECIMAL*
    CVariantWrap(BSTR* pBSTR);                          //...BSTR*
    CVariantWrap(IUnknown** ppUnk);                     //...IUnknown**
    CVariantWrap(IDispatch** ppDisp);                   //...IDispatch**
    CVariantWrap(VARIANT* pVar);                        //...VARIANT*

    CVariantWrap(CVariantWrap* const other ,VARTYPE refType = VT_EMPTY);

    CVariantWrap(const CVariantWrap& other);
#if __BORLANDC__  < 0x570
    CVariantWrap& operator=(CVariantWrap other);
#else
	CVariantWrap& operator=(CVariantWrap& other);
#endif

    CVariantWrap();
    ~CVariantWrap();

protected:

#ifdef _UNICODE

    CInvokeException* writeError(LPOLESTR prefx1,LPOLESTR prefx2,LPOLESTR prefx3, HRESULT error);
#else

    CInvokeException* writeError(const char* prefx1,LPOLESTR prefx2,const char* prefx3, HRESULT error);
    CInvokeException* writeError(const char* prefx1,const char* prefx2,const char* prefx3, HRESULT error);
#endif
};

///////////////////////////////////////////////////////////////////////////////////
// Conversions from ...

//...BYTE
inline CVariantWrap::CVariantWrap(BYTE byteVal)
{
    V_VT(this) = VT_UI1;
    V_UI1(this) = byteVal;
}

//...short
inline CVariantWrap::CVariantWrap(short shortVal)
{
    V_VT(this) = VT_I2;
    V_I2(this) = shortVal;
}

//...bool
inline CVariantWrap::CVariantWrap(bool bVal)
{
    V_VT(this) = VT_BOOL;
    V_BOOL(this) = bVal ? VARIANT_TRUE : VARIANT_FALSE;
}

// ... int
inline CVariantWrap::CVariantWrap(int integer,VARTYPE vtArg)
{
   if ((vtArg != VT_I2) && (vtArg != VT_I4) && (vtArg != VT_BOOL) && (vtArg != VT_EMPTY))
       throw  writeError(_T("\"CVariantWrap(int)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_INVALIDARG);

    switch(vtArg)
    {
    case VT_EMPTY:
        {
            if(sizeof(int)==sizeof(long))
            {
                V_VT(this) = VT_I4; V_I4(this) = integer;
            }
            else
            {
                V_VT(this) = VT_I2; V_I2(this) = (short)integer;
            }
            break;
        }
    case VT_I2:
        {   if(integer>SHRT_MAX || integer<SHRT_MIN)
                throw  writeError(_T("\"CVariantWrap(int)\" error : "),
                                            (LPOLESTR)NULL,NULL,E_INVALIDARG);
            V_VT(this) = VT_I2;  V_I2(this) = (short)integer; break;
        }
    case VT_BOOL:
        {
            V_VT(this) = VT_BOOL;
            V_BOOL(this) = (integer ? VARIANT_TRUE : VARIANT_FALSE);
            break;
        }
    case VT_I4:
        {
            V_VT(this) = VT_I4;  V_I4(this) = integer; break;
        }
    }
}

//...long
inline CVariantWrap::CVariantWrap(long longVal, VARTYPE vtArg)
{
   if ((vtArg != VT_I4) && (vtArg != VT_ERROR) && (vtArg != VT_BOOL))
       throw  writeError(_T("\"CVariantWrap(long)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_INVALIDARG);

    switch(vtArg)
    {
    case VT_BOOL:
        {
            V_VT(this) = VT_BOOL;
            V_BOOL(this) = (longVal ? VARIANT_TRUE : VARIANT_FALSE);
            break;
        }
    case VT_I4:
        {
            V_VT(this) = VT_I4;
            V_I4(this) = longVal; break;
        }
    case VT_ERROR:
        {
            V_VT(this) = VT_ERROR;
            V_ERROR(this) = longVal; break;
        }
    }
}

//...unsigned long
inline CVariantWrap::CVariantWrap(unsigned long longVal)
{

   V_VT(this) = VT_UI4;
   V_UI4(this) = longVal;
}


//...float
inline CVariantWrap::CVariantWrap(float floatVal)
{
    V_VT(this) = VT_R4;
    V_R4(this) = floatVal;
}

//...double
inline CVariantWrap::CVariantWrap(double dblVal, VARTYPE vtArg)
{
   if ((vtArg != VT_R8) && (vtArg != VT_DATE))
       throw  writeError(_T("\"CVariantWrap(double)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_INVALIDARG);
    switch(vtArg)
    {
    case VT_R8:
        {
            V_VT(this) = VT_R8;
            V_R8(this) = dblVal; break;
        }
    case VT_DATE:
        {
            V_VT(this) = VT_DATE;
            V_DATE(this) = dblVal;
        }
    }
}

//...CY
inline CVariantWrap::CVariantWrap(const CY cyVal)
{
  V_VT(this) = VT_CY;
  V_CY(this) = cyVal;
}

//...DECIMAL
inline CVariantWrap::CVariantWrap(const DECIMAL dVal)
{
  V_DECIMAL(this) = dVal;
  V_VT(this) = VT_DECIMAL;
}

// ... char*
inline CVariantWrap::CVariantWrap(const char* charStr)
{
    LPOLESTR wStr;
    V_VT(this) = VT_BSTR;

    Ansi2Unicode(charStr,&wStr);
    V_BSTR(this) = SysAllocString(wStr);

    delete [] wStr;

    if(V_BSTR(this)==NULL && charStr != NULL)
        throw  writeError(_T("\"CVariantWrap(const char*)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
}

// ... LPCOLESTR
inline CVariantWrap::CVariantWrap(LPCOLESTR str)
{
    V_VT(this) = VT_BSTR;
    V_BSTR(this) = SysAllocString(str);

    if(V_BSTR(this)==NULL)
    throw  writeError(_T("\"CVariantWrap(LPOLESTR)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
}

// ...BSTR
inline CVariantWrap::CVariantWrap(BSTR bstr,BOOL isAttachOnly) 
{
    V_VT(this) = VT_BSTR;

    if(isAttachOnly)
    {V_BSTR(this) = bstr;
    }
    else
    {
        V_BSTR(this)= SysAllocString(bstr);
        if(NULL == V_BSTR(this)) 
            throw writeError(_T("\"CVariantWrap(const BSTR bstrStr)\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
    }

}


//...IUnknown*
inline CVariantWrap::CVariantWrap(IUnknown* pUnk,BOOL isAddRef)
{
     V_VT(this) = VT_UNKNOWN;
  V_UNKNOWN(this) = pUnk;

  if (isAddRef && V_UNKNOWN(this) ) 
    V_UNKNOWN(this)->AddRef();

}

//...IDispatch*
inline CVariantWrap::CVariantWrap(IDispatch* pDisp,BOOL isAddRef)
{
     V_VT(this) = VT_DISPATCH;
  V_DISPATCH(this) = pDisp;

  if (isAddRef && V_DISPATCH(this)) 
    V_DISPATCH(this)->AddRef();
}

// ... VARIANT
inline CVariantWrap::CVariantWrap(VARIANT var,BOOL isAttachOnly)
{
    if(isAttachOnly)
    {
        memcpy((void*)this,(void*)&(var),sizeof(var));
        V_VT(&var) = VT_EMPTY;
    }
    else
    {
        VariantInit(this);
        HRESULT hres = VariantCopy(this, &var);
        if(FAILED(hres))
            throw writeError(_T("\"CVariantWrap(VARIANT& var,BOOL isAttachOnly)\" error : "),
                                        (LPOLESTR)NULL,NULL,hres);
    }
}


#ifdef _MFC_VER

//...CString

inline CVariantWrap::CVariantWrap(CString str)
{
    V_VT(this) = VT_BSTR;

    V_BSTR(this) = str.AllocSysString();

    if(V_BSTR(this)==NULL && str.IsEmpty() != NULL) 
        throw  writeError(_T("\"CVariantWrap(const char*)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
}

#endif 

#ifdef __BORLANDC__

//...AnsiString
 
inline CVariantWrap::CVariantWrap(AnsiString str)
{
    LPOLESTR wStr;
    V_VT(this) = VT_BSTR;

    Ansi2Unicode(str.c_str(),&wStr);
    V_BSTR(this) = SysAllocString(wStr);

    delete [] wStr;        

    if(V_BSTR(this)==NULL && str.c_str() != NULL)
        throw  writeError(_T("\"CVariantWrap(const char*)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
}

#endif 



//////////////////////////////////////////////////////////////////////////////////////////
// Assignment operators

// BYTE
inline CVariantWrap& CVariantWrap::operator=(BYTE byteVal)
{
  if (V_VT(this) != VT_UI1) 
    {
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(BYTE)\" error : "),(LPOLESTR)NULL,NULL,hres);

    V_VT(this) = VT_UI1;
  }

  V_UI1(this) = byteVal;

  return *this;
}

// short  
inline CVariantWrap& CVariantWrap::operator=(short shortVal)  
{
    switch(V_VT(this))        
    {
    case VT_I2:    
        V_I2(this) = shortVal; break;
    case VT_BOOL:   
        V_BOOL(this) = (shortVal ? VARIANT_TRUE : VARIANT_FALSE); break;
    default:
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(short)\" error : "),(LPOLESTR)NULL,NULL,hres);
        V_VT(this) = VT_I2;
        V_I2(this) = shortVal;
        break;
  }

    return *this;
}

// bool   
inline CVariantWrap& CVariantWrap::operator=(bool boolVal)
{
  if (V_VT(this) != VT_BOOL) 
    {
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(bool )\" error : "),(LPOLESTR)NULL,NULL,hres);

    V_VT(this) = VT_BOOL;
  }

  V_BOOL(this) = (boolVal ? VARIANT_TRUE : VARIANT_FALSE);

  return *this;
}

// int
inline CVariantWrap& CVariantWrap::operator=(int intVal)  
{
    if((V_VT(this)!=VT_I2) && (V_VT(this)!=VT_BOOL) && (V_VT(this)!=VT_I4))
    {
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(int)\" error : "),(LPOLESTR)NULL,NULL,hres);

        if(sizeof(int)==2)
        {
            V_VT(this) = VT_I2;
            V_I2(this) = (short)intVal;
        }
        else
        {
            V_VT(this) = VT_I4;
            V_I4(this) = intVal;

        }
    }
    else
    {
        switch(V_VT(this))
        {
        case VT_I2:
            if(intVal>SHRT_MAX || intVal<SHRT_MIN)
                throw  writeError(_T("\"operator = (int)\" error : "),
                                            (LPOLESTR)NULL,NULL,E_INVALIDARG);
            V_VT(this) = VT_I2;  V_I2(this) = (short)intVal; break;
        case VT_BOOL:   
            V_BOOL(this) = (intVal ? VARIANT_TRUE : VARIANT_FALSE);
            break;
        case VT_I4: 
            V_VT(this) = VT_I4;  V_I4(this) = intVal; break;
        }

    }
    return *this;
}

// long   
inline CVariantWrap& CVariantWrap::operator=(long longVal)  
{
    switch(V_VT(this))
    {
    case VT_I4:    
        V_I4(this) = longVal; break;
    case VT_ERROR:
    V_ERROR(this) = longVal; break;
    case VT_BOOL:
    V_BOOL(this) = (longVal ? VARIANT_TRUE : VARIANT_FALSE);
    default:
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(long)\" error : "),(LPOLESTR)NULL,NULL,hres);
    V_VT(this) = VT_I4;
    V_I4(this) = longVal;
        break;
  }
  return *this;
}

// float   
inline CVariantWrap& CVariantWrap::operator=(float fltVal)  
{
  if (V_VT(this) != VT_R4) 
    {
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(float)\" error : "),(LPOLESTR)NULL,NULL,hres);

    V_VT(this) = VT_R4;
  }

  V_R4(this) = fltVal;

  return *this;
}

// double   
inline CVariantWrap& CVariantWrap::operator=(double dblVal)  
{
    switch(V_VT(this))
    {
    case VT_R8:   V_R8(this) = dblVal; break;
    case VT_DATE:  V_DATE(this) = dblVal; break;
    default:    
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(double)\" error : "),(LPOLESTR)NULL,NULL,hres);

    V_VT(this) = VT_R8;
    V_R8(this) = dblVal;
        break;
  }

  return *this;
}

// CY
inline CVariantWrap& CVariantWrap::operator=(const CY cyVal)  
{
  if (V_VT(this) != VT_CY) 
    {
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(CY&)\" error : "),(LPOLESTR)NULL,NULL,hres);

    V_VT(this) = VT_CY;
  }

  V_CY(this) = cyVal;

  return *this;
}

// DECIMAL
inline CVariantWrap& CVariantWrap::operator=(const DECIMAL decVal)
{
  if (V_VT(this) != VT_DECIMAL) 
    {
        HRESULT hres = VariantClear(this);
        if(FAILED(hres))
            throw writeError(_T("\"operator=(DECIMAL&)\" error : "),(LPOLESTR)NULL,NULL,hres);
  }

  V_DECIMAL(this) = decVal;
  V_VT(this) = VT_DECIMAL;
  return *this;
}

// char*   
inline CVariantWrap& CVariantWrap::operator=(const char* pVal)  
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(char*)\" error : "),(LPOLESTR)NULL,NULL,hres);

    LPOLESTR wStr;
    V_VT(this) = VT_BSTR;

    Ansi2Unicode(pVal,&wStr);
    V_BSTR(this) = SysAllocString(wStr);

    delete [] wStr;        

  if (V_BSTR(this) == NULL && pVal != NULL) 
        throw writeError(_T("\"operator=(char*)\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);

  return *this;
}

// LPCOLESTR   
inline CVariantWrap& CVariantWrap::operator=(LPCOLESTR pVal)  
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(LPCOLESTR)\" error : "),(LPOLESTR)NULL,NULL,hres);

  V_VT(this) = VT_BSTR;

  if (pVal == NULL) 
        V_BSTR(this) = NULL;
  else
    {
    V_BSTR(this) = SysAllocString(pVal);

    if (V_BSTR(this) == NULL) {
            throw writeError(_T("\"operator=(LPCOLESTR)\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);

        }
  }

  return *this;
}

// BSTR   
inline CVariantWrap& CVariantWrap::operator=(const BSTR bstrVal)  
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(BSTR)\" error : "),(LPOLESTR)NULL,NULL,hres);

  V_VT(this) = VT_BSTR;

  if (!bstrVal)     
        V_BSTR(this) = NULL;
  else 
    {
    V_BSTR(this) = SysAllocString((LPOLESTR)bstrVal);

    if (V_BSTR(this) == NULL) 
            throw writeError(_T("\"operator=(BSTR)\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
  }

  return *this;
}

// IUnknown*
inline CVariantWrap& CVariantWrap::operator=(const IUnknown* pUnk)
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(IUnknown*)\" error : "),(LPOLESTR)NULL,NULL,hres);

  V_VT(this) = VT_UNKNOWN;
  V_UNKNOWN(this) = const_cast<IUnknown*>(pUnk);

  if( V_UNKNOWN(this) )
    V_UNKNOWN(this)->AddRef();

  return *this;
}

// IDispatch*   
inline CVariantWrap& CVariantWrap::operator=(const IDispatch* pDisp)
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(IDispatch*)\" error : "),(LPOLESTR)NULL,NULL,hres);

  V_VT(this) = VT_DISPATCH;
  V_DISPATCH(this) = const_cast<IDispatch*>(pDisp);
  if(  V_DISPATCH(this) )
    V_DISPATCH(this)->AddRef();
  return *this;
}

// VARIANT
inline CVariantWrap& CVariantWrap::operator=(const VARIANT varVal)
{
  HRESULT hres = VariantCopy(this, const_cast<VARIANT*>(static_cast<const VARIANT*>(&varVal)));
    if(FAILED(hres))
        throw writeError(_T("\"CVariantWrap(CVariantWrap&)\" error : "),(LPOLESTR)NULL,NULL,hres);

    return *this;
}

#ifdef _MFC_VER
//...CString
inline CVariantWrap& CVariantWrap::operator=(const CString str)    
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(char*)\" error : "),(LPOLESTR)NULL,NULL,hres);

    V_VT(this) = VT_BSTR; 

    V_BSTR(this) = str.AllocSysString();

  if (V_BSTR(this) == NULL && str.IsEmpty() != NULL) 
        throw writeError(_T("\"operator=(char*)\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);

  return *this;
}
#endif 

#ifdef __BORLANDC__
//...AnsiString
inline CVariantWrap& CVariantWrap::operator=(const AnsiString str)
{
    HRESULT hres = VariantClear(this);
    if(FAILED(hres))
        throw writeError(_T("\"operator=(char*)\" error : "),(LPOLESTR)NULL,NULL,hres);

    LPOLESTR wStr;
    V_VT(this) = VT_BSTR;

    Ansi2Unicode(str.c_str(),&wStr);
    V_BSTR(this) = SysAllocString(wStr);

    delete [] wStr;

  if (V_BSTR(this) == NULL && str.c_str() != NULL)
        throw writeError(_T("\"operator=(char*)\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);

  return *this;

}
#endif 


// arithmetic operators
inline CVariantWrap& CVariantWrap::operator++()
{
    switch(V_VT(this))
    {
        case VT_I2:
			V_I2(this) = V_I2(this) + 1;
			break;
        case VT_I4: 
			V_I4(this) = V_I4(this) + 1;
			break;
		default: 
			throw  writeError(_T("\"operator++()\" error : "), (LPOLESTR) NULL, NULL, E_INVALIDARG);
	}
	return *this;
}

inline CVariantWrap CVariantWrap::operator++(int)
{
	if ( (V_VT(this) == VT_I2) || (V_VT(this) == VT_I4) )
	{
		CVariantWrap temp(this);
		this->operator++();
		return temp;
	}
	else
		throw  writeError(_T("\"operator++(int)\" error : "), (LPOLESTR)NULL, NULL, E_INVALIDARG);
}

inline CVariantWrap& CVariantWrap::operator--()
{
	switch(V_VT(this))
	{
		case VT_I2:
			V_I2(this) = V_I2(this) -1;
			break;
		case VT_I4:
			V_I4(this) = V_I4(this) -1;
			break;
		default:
			throw  writeError(_T("\"operator--()\" error : "), (LPOLESTR)NULL, NULL, E_INVALIDARG);
	}
	return *this;
}

inline CVariantWrap CVariantWrap::operator--(int)
{
	if ( (V_VT(this) == VT_I2) || (V_VT(this) == VT_I4) )
	{
		CVariantWrap temp(this);
		this->operator--();
		return temp;
	}
	else
		throw  writeError(_T("\"operator++(int)\" error : "), (LPOLESTR)NULL, NULL, E_INVALIDARG);
}

#if defined(_MFC_VER) && (__BORLANDC__  > 0x530)
template <class T> inline bool CVariantWrap::operator<(T var)
{
	CVariantWrap tmpVariant(var);
	HRESULT hr = ::VarCmp(this, (VARIANT *)&tmpVariant, LOCALE_USER_DEFAULT , NORM_IGNORECASE);
	return hr == VARCMP_LT;
}

template <class T> inline bool CVariantWrap::operator>(T var)
{
	CVariantWrap tmpVariant(var);
	HRESULT hr = ::VarCmp(this, (VARIANT *)&tmpVariant, LOCALE_USER_DEFAULT , NORM_IGNORECASE);
	return  hr == VARCMP_GT;
}

template <class T> inline bool CVariantWrap::operator==(T var)
{
	CVariantWrap tmpVariant(var);
	HRESULT hr = ::VarCmp(this, (VARIANT *)&tmpVariant, LOCALE_USER_DEFAULT , NORM_IGNORECASE);
	return hr == VARCMP_EQ;
}

template <class T> inline bool CVariantWrap::operator<=(T var)
{
	CVariantWrap tmpVariant(var);
	HRESULT hr = ::VarCmp(this, (VARIANT *)&tmpVariant, LOCALE_USER_DEFAULT , NORM_IGNORECASE);
	return (hr == VARCMP_LT) || (hr == VARCMP_EQ);
}

template <class T> inline bool CVariantWrap::operator>=(T var)
{
	CVariantWrap tmpVariant(var);
	HRESULT hr = ::VarCmp(this, (VARIANT *)&tmpVariant, LOCALE_USER_DEFAULT , NORM_IGNORECASE);
	return (hr == VARCMP_GT) || (hr == VARCMP_EQ);
}
#endif

//////////////////////////////////////////////////////////////////////////////////////////
// Conversions to ...

//...BYTE  
inline CVariantWrap::operator BYTE()
{
    CVariantWrap result;

    if (VT_UI1 == V_VT(this)) return V_UI1(this); 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_UI1);
    if(FAILED(hres))
        throw writeError(_T("\"operator BYTE()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_UI1(&result);

}

//...short
inline CVariantWrap::operator short()
{
    CVariantWrap result;

    if (VT_I2 == V_VT(this)) return V_I2(this);

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_I2);
    if(FAILED(hres))
        throw writeError(_T("\"operator int()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_I2(&result);
}

//...bool  
inline CVariantWrap::operator bool()
{
    CVariantWrap result;

    if (VT_BOOL == V_VT(this)) return V_BOOL(this)!=FALSE; 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_BOOL);
    if(FAILED(hres))
        throw writeError(_T("\"operator bool()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_BOOL(&result)!=FALSE;

}

//...int  
inline CVariantWrap::operator int()
{
#if defined(__BORLANDC__) 
#if (sizeof(int)==sizeof(long))
     return (int)(operator long());
#endif
#if (sizeof(int)==sizeof(short))
     return (int)(operator short());
#endif
#endif

#if defined(_MSC_VER)
 if(sizeof(int)==sizeof(long))
     return (int)(operator long());
 if(sizeof(int)==sizeof(short))
     return (int)(operator short());
#endif
}

//...long  
inline CVariantWrap::operator long()
{
    CVariantWrap result;

    if (VT_I4 == V_VT(this)) return V_I4(this); 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_I4);
    if(FAILED(hres))
        throw writeError(_T("\"operator long()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_I4(&result);

}

//...float  
inline CVariantWrap::operator float()
{
    CVariantWrap result;

    if (VT_R4 == V_VT(this)) return V_R4(this); 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_R4);
    if(FAILED(hres))
        throw writeError(_T("\"operator float()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_R4(&result);

}

//...double  
inline CVariantWrap::operator double()
{
    CVariantWrap result;

    if (VT_R8 == V_VT(this)) return V_R8(this); 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_R8);
    if(FAILED(hres))
        throw writeError(_T("\"operator double()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_R8(&result);

}

//...CY  
inline CVariantWrap::operator CY()
{
    CVariantWrap result;

    if (VT_CY == V_VT(this)) return V_CY(this); 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_CY);
    if(FAILED(hres))
        throw writeError(_T("\"operator CY()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_CY(&result);

}

//...DECIMAL  
inline CVariantWrap::operator DECIMAL()
{
    CVariantWrap result;

    if (VT_DECIMAL == V_VT(this)) return V_DECIMAL(this); 

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_DECIMAL);
    if(FAILED(hres))
        throw writeError(_T("\"operator DECIMAL()\" error : "),(LPOLESTR)NULL,NULL,hres);

  return V_DECIMAL(&result);

}

//...char*  
inline char* CVariantWrap::CreateAnsi()
{
    char * res;

    CVariantWrap result;

    if (VT_BSTR == V_VT(this)) 
    {
        Unicode2Ansi((LPOLESTR)V_BSTR(this),&res); 
        return res;
    }

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_BSTR);
    if(FAILED(hres))
        throw writeError(_T("\"operator char*()\" error : "),(LPOLESTR)NULL,NULL,hres);

    Unicode2Ansi((LPOLESTR)V_BSTR(&result),&res); 
  return res;
}

//...LPOLESTR  
inline LPOLESTR CVariantWrap::CreateUnicode()
{  
    int size; 
    LPOLESTR res; 

    CVariantWrap result;

    if (VT_BSTR == V_VT(this)) 
    {
        size = (int)wcslen((LPOLESTR)V_BSTR(this))+1;
        res = new wchar_t[size];
        if(NULL == res) 
            throw writeError(_T("\"CreateUnicode\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
        memcpy(res,(LPOLESTR)V_BSTR(this),size*2);
        return res; 
    }

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_BSTR);
    if(FAILED(hres))
        throw writeError(_T("\"operator LPOLESTR()\" error : "),(LPOLESTR)NULL,NULL,hres);

    size = (int)wcslen((LPOLESTR)(result.bstrVal))+1;
    res = new wchar_t[size];
    if(NULL == res) 
        throw writeError(_T("\"CreateUnicode\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
    memcpy(res,(LPOLESTR)(result.bstrVal),size*2);
    return res; 
}


//...BSTR  
inline BSTR CVariantWrap::CreateBSTR()
{  
    BSTR res;

    CVariantWrap result;

    if (VT_BSTR == V_VT(this))
    {
        res= SysAllocString((LPOLESTR)V_BSTR(this));
        if(NULL == res) 
            throw writeError(_T("\"CreateBSTR\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
        return res;
    }

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_BSTR);
    if(FAILED(hres))
        throw writeError(_T("\"operator LPOLESTR()\" error : "),(LPOLESTR)NULL,NULL,hres);

    res= SysAllocString(result.bstrVal);
    if(NULL == res)
        throw writeError(_T("\"CreateBSTR\" error : "),(LPOLESTR)NULL,NULL,E_OUTOFMEMORY);
    return res;
}

//...IUnknown*  
inline CVariantWrap::operator IUnknown*()
{
    CVariantWrap result;

    if (VT_UNKNOWN == V_VT(this))  
    {
    if( V_UNKNOWN(this) )
      V_UNKNOWN(this)->AddRef();
        return V_UNKNOWN(this); 
    }

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_UNKNOWN);
    if(FAILED(hres))
        throw writeError(_T("\"operator IUnknown*()\" error : "),(LPOLESTR)NULL,NULL,hres);

  if(V_UNKNOWN(&result))
    V_UNKNOWN(&result)->AddRef();
    return V_UNKNOWN(&result);

}

//...IDispatch*
inline CVariantWrap::operator IDispatch*()
{
    CVariantWrap result;

    if (VT_DISPATCH == V_VT(this)) 
    {
    if( V_DISPATCH(this))
      V_DISPATCH(this)->AddRef();
        return V_DISPATCH(this); 
    }

    HRESULT hres = VariantChangeType(static_cast<VARIANT*>(&result),static_cast<VARIANT*>(this),0, VT_DISPATCH);
    if(FAILED(hres))
        throw writeError(_T("\"operator IDispatch*()\" error : "),(LPOLESTR)NULL,NULL,hres);

  if(V_DISPATCH(&result))
    V_DISPATCH(&result)->AddRef();
    return V_DISPATCH(&result);

}


#ifdef _MFC_VER

//...CString

inline CVariantWrap::operator CString()
{
    return CString((LPCWSTR)V_BSTR(this));
}

#endif 
#ifdef __BORLANDC__

//...AnsiString

inline CVariantWrap::operator AnsiString()
{
    return AnsiString(V_BSTR(this));
}
#endif 

///////////////////////////////////////////////////////////////////////////////////
//Construct VT_BYREF on ...

//...BYTE*
inline CVariantWrap::CVariantWrap(BYTE* pByte)
{
    V_VT(this) = VT_UI1|VT_BYREF;
    V_UI1REF(this) = pByte;
}

//...short*
inline CVariantWrap::CVariantWrap(short* pShort ,VARTYPE vtArg )
{
   if ((vtArg != VT_I2) && (vtArg != VT_BOOL)) 
       throw  writeError(_T("\"CVariantWrap(short*)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_INVALIDARG);
    switch(vtArg)
    {
    case VT_I2:
        {
        V_VT(this) = VT_I2 | VT_BYREF;
      break;
        }
    case VT_BOOL: 
        {
            V_VT(this) = VT_BOOL | VT_BYREF;
      break;
        }
    }
  
  V_I2REF(this) = pShort;

}

// ... int*
inline CVariantWrap::CVariantWrap(int* pInteger)
{
   if(sizeof(int)==sizeof(long))
   {
     V_VT(this) = VT_I4 | VT_BYREF; V_I4REF(this) = reinterpret_cast<long*>(pInteger);
   }
   else
   {
     V_VT(this) = VT_I2 | VT_BYREF; V_I2REF(this) = reinterpret_cast<short*>(pInteger);
   }
}

//...long*
inline CVariantWrap::CVariantWrap(long* pLong , VARTYPE vtArg )
{
   if ((vtArg != VT_I4) && (vtArg != VT_ERROR)) 
       throw  writeError(_T("\"CVariantWrap(long*)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_INVALIDARG);
    switch(vtArg)
    {
    case VT_I4:
        {
        V_VT(this) = VT_I4 | VT_BYREF;
      break;
        }
    case VT_ERROR: 
        {
            V_VT(this) = VT_ERROR | VT_BYREF;
      break;
        }
    }

    V_I4REF(this) = pLong;
}

//...float*
inline CVariantWrap::CVariantWrap(float* pFloat)
{
    V_VT(this) = VT_R4 | VT_BYREF;
    V_R4REF(this) = pFloat;
}

//...double*
inline CVariantWrap::CVariantWrap(double* pDbl ,VARTYPE vtArg )
{
   if ((vtArg != VT_R8) && (vtArg != VT_DATE)) 
       throw  writeError(_T("\"CVariantWrap(double*)\" error : "),
                                    (LPOLESTR)NULL,NULL,E_INVALIDARG);
    switch(vtArg)
    {
    case VT_R8:
        {
      V_VT(this) = VT_R8 | VT_BYREF;
      break;
        }
    case VT_DATE: 
        {
      V_VT(this) = VT_DATE | VT_BYREF;
      break;
        }
    }
  
    V_R8REF(this) = pDbl; 
}

//...CY*
inline CVariantWrap::CVariantWrap(CY* pCY)
{
  V_VT(this) = VT_CY | VT_BYREF;
  V_CYREF(this) = pCY;
}



//...DECIMAL*
inline CVariantWrap::CVariantWrap(DECIMAL* pDEC)
{
  V_VT(this) = VT_DECIMAL | VT_BYREF;
  V_DECIMALREF(this) = pDEC;
}

  
// ...BSTR*
inline CVariantWrap::CVariantWrap(BSTR* pBstr) 
{
    V_VT(this) = VT_BSTR | VT_BYREF;
    V_BSTRREF(this) = pBstr;
}


//...IUnknown**
inline CVariantWrap::CVariantWrap(IUnknown** ppUnk)
{
     V_VT(this) = VT_UNKNOWN | VT_BYREF;
  V_UNKNOWNREF(this) = ppUnk;

}

//...IDispatch**
inline CVariantWrap::CVariantWrap(IDispatch** ppDisp)
{
     V_VT(this) = VT_DISPATCH | VT_BYREF;
  V_DISPATCHREF(this) = ppDisp;

}

// ... VARIANT*
inline CVariantWrap::CVariantWrap(VARIANT* pVar)
{
  if(V_VT(pVar) & VT_BYREF && V_VT(pVar) & VT_VARIANT)
      throw writeError(_T("\"CVariantWrap(VARIANT*)\" error : "),(LPOLESTR)NULL,NULL,E_INVALIDARG);
  
  V_VT(this) =  VT_BYREF | VT_VARIANT;
  V_VARIANTREF(this) = pVar;
}




////////////////////////////////////////////////////////////////////////////////////////////


#define CASE(type,member) case type : {V_VT(this) |= type; member##REF(this) = &(member(pOther));  return;}

inline CVariantWrap::CVariantWrap(CVariantWrap* const pOther , VARTYPE refType) 
{
  VariantInit(this);

  if(refType == (VT_BYREF|VT_VARIANT))
  {  
    if(V_VT(pOther) & VT_BYREF && V_VT(pOther) & VT_VARIANT)
        throw writeError(_T("\"CVariantWrap(CVariantWrap*)\" error : "),(LPOLESTR)NULL,NULL,E_INVALIDARG);
    
    V_VT(this) =  refType;
    V_VARIANTREF(this) = pOther;
    return;
  }          

  if(V_VT(pOther) & VT_BYREF )
    throw writeError(_T("\"CVariantWrap(CVariantWrap*)\" error : "),(LPOLESTR)NULL,NULL,E_INVALIDARG);

  V_VT(this) = VT_BYREF;

  switch(V_VT(pOther))
  {
  CASE(VT_UI1,V_UI1)
  CASE(VT_I2,V_I2)
  CASE(VT_I4,V_I4)
  CASE(VT_R4,V_R4)
  CASE(VT_R8,V_R8)
  CASE(VT_I1,V_I1)
  CASE(VT_UI2,V_UI2)
  CASE(VT_UI4,V_UI4)
  CASE(VT_INT,V_INT)
  CASE(VT_UINT,V_UINT)
  CASE(VT_CY,V_CY)
  CASE(VT_DATE,V_DATE)
  CASE(VT_BSTR,V_BSTR)
  CASE(VT_DISPATCH,V_DISPATCH)
  CASE(VT_ERROR,V_ERROR)
  CASE(VT_BOOL,V_BOOL)
  CASE(VT_UNKNOWN,V_UNKNOWN)
  CASE(VT_ARRAY,V_ARRAY)
  CASE(VT_DECIMAL,V_DECIMAL)
  default :  throw writeError(_T("\"CVariantWrap(CVariantWrap*)\" error : "),(LPOLESTR)NULL,NULL,E_INVALIDARG);
  }

}
  
inline CVariantWrap::CVariantWrap(const CVariantWrap& other) 
{
  VariantInit(this);
  HRESULT hres = VariantCopy(this, const_cast<VARIANT*>(static_cast<const VARIANT*>(&other)));
    if(FAILED(hres))
        throw writeError(_T("\"CVariantWrap(CVariantWrap&)\" error : "),(LPOLESTR)NULL,NULL,hres);


}

#if __BORLANDC__  < 0x570
inline CVariantWrap& CVariantWrap::operator=(CVariantWrap other) 
#else
inline CVariantWrap& CVariantWrap::operator=(CVariantWrap& other)
#endif
{
  HRESULT hres = VariantCopy(this, const_cast<VARIANT*>(static_cast<const VARIANT*>(&other)));
    if(FAILED(hres))
        throw writeError(_T("\"CVariantWrap(CVariantWrap&)\" error : "),(LPOLESTR)NULL,NULL,hres);

    return *this;
}


   
inline CVariantWrap::CVariantWrap()
{
  VariantInit(this);
};

  
inline CVariantWrap::~CVariantWrap()
{
#if __BORLANDC__  > 0x530   // BCB version > 3
 HRESULT hres = VariantClear(this);
 if(FAILED(hres))
    throw writeError(_T("\"~CVariantWrap()\" error : "),(LPOLESTR)NULL,NULL,hres);
#else
 VariantClear(this);
#endif
}

#ifdef _UNICODE

inline CInvokeException* CVariantWrap::writeError(LPOLESTR prefx1,LPOLESTR prefx2,LPOLESTR prefx3, HRESULT error)
{
    static CInvokeException Exception;
    return Exception.WriteError(prefx1,prefx2,prefx3,error);
}

#else

inline CInvokeException* CVariantWrap::writeError(const char* prefx1,LPOLESTR prefx2,const char* prefx3, HRESULT error)
{
    static CInvokeException Exception;
    return Exception.WriteError(prefx1,prefx2,prefx3,error);

}

inline CInvokeException* CVariantWrap::writeError(const char* prefx1,const char* prefx2,const char* prefx3, HRESULT error)
{
    static CInvokeException Exception;
    return Exception.WriteError(prefx1,prefx2,prefx3,error);
}

#endif





template< class variant> class CMethod;
template< class variant> class CScriptObject;
template< class func , class variant> class CLazyRef;


inline HRESULT Ansi2UnicodeStatic(LPCSTR pszA, LPOLESTR pszW , ULONG cCharacters)
{
    DWORD dwError;
    static CInvokeException Exception;
 
    if(NULL == pszA){ pszW[0] = 0; return NOERROR;}

  if(strlen(pszA)+1 > cCharacters)
    return S_FALSE;
  else cCharacters =  (int)strlen(pszA)+1;

    int resSize = MultiByteToWideChar(CP_ACP, 0, pszA, cCharacters-1, pszW, cCharacters);
    pszW[resSize] = 0;

    if (0 == resSize && cCharacters != 1)    
    {
        dwError = GetLastError();
        throw Exception.WriteError(NULL,(LPOLESTR)NULL,(LPOLESTR)NULL,HRESULT_FROM_WIN32(dwError));
   }   

   return NOERROR;
}

template<int size>
class CMethodNameBase
{
public:

  static OLECHAR m_Name[size + 1];
    static CInvokeException Exception;

  CMethodNameBase()
  {}

  inline CMethodNameBase& operator =(const char* methodName)
  {
      if (!methodName)
        throw Exception.WriteError(_T("operator["),methodName,_T("] : empty method or property name "),E_INVALIDARG);

    if( Ansi2UnicodeStatic(methodName, m_Name , MaxNameLength ) != S_OK )
        throw Exception.WriteError(_T(""),_T(""),_T(" method or property name too long . Please increase MaxNameLen constant"),E_INVALIDARG);

    return *this;
  }

  inline CMethodNameBase& operator =(LPOLESTR methodName)
  {
      if (!methodName)
        throw Exception.WriteError(_T("operator["),methodName,_T("] : empty method or property name "),E_INVALIDARG);

    if( wcslen(methodName) > MaxNameLength )
        throw Exception.WriteError(_T(""),_T(""),_T(" method or property name too long . Please increase MaxNameLen constant"),E_INVALIDARG);
    else  wcscpy(m_Name , methodName);

    return *this;
  }
};

template< int size>
OLECHAR CMethodNameBase<size>::m_Name[size + 1];

template< int size>
CInvokeException CMethodNameBase<size>::Exception;

enum { MaxNameLength = 255 };

class CMethodName : public CMethodNameBase<MaxNameLength>
{
public :
  CMethodName(){}

  inline CMethodName& operator =(const char* methodName)
  { return (CMethodName&)CMethodNameBase<MaxNameLength>::operator =(methodName); }

  inline CMethodName& operator =(LPOLESTR methodName)
  { return (CMethodName&)CMethodNameBase<MaxNameLength>::operator =(methodName); }
};

class Put : public CMethodNameBase<MaxNameLength>
{
public :
  Put(){}

  inline Put(const char* methodName)
  { CMethodNameBase<MaxNameLength>::operator =(methodName); }

  inline Put(LPOLESTR methodName)
  { CMethodNameBase<MaxNameLength>::operator =(methodName); }

  inline Put& operator =(const char* methodName)
  { return (Put&)CMethodNameBase<MaxNameLength>::operator =(methodName); }

  inline Put& operator =(LPOLESTR methodName)
  { return (Put&)CMethodNameBase<MaxNameLength>::operator =(methodName); }
};


////////////////////////////////////////////////////////////////////////////////////////
//CPutMethod
////////////////////////////////////////////////////////////////////////////////////////


template<class variant>
class CPutMethod
{
public :
  typedef CScriptObject<variant> ScriptType;
  friend ScriptType;
  friend CMethod<variant>;

    ~CPutMethod()
  {
    if(!m_bNoRelease)
      ((IDispatch*)m_pDisp)->Release();
  };

  enum { MaxIndexNum = 10};

protected :

    static EXCEPINFO ExcepInfo;
    static unsigned int WrongArgNumber;
    static CInvokeException Exception;

  variant& m_host;
  const IDispatch* m_pDisp;
  const BOOL m_bNoRelease;

  const DISPID m_propID;

  int  m_indicesNum;
  VARIANT m_arguments[MaxIndexNum + 1];

  CPutMethod(ScriptType& host , IDispatch* pDisp, LPOLESTR name , BOOL isNoRelease)
    : m_host(host) , m_pDisp(pDisp) , m_bNoRelease(isNoRelease) ,m_propID(0)
  {
    m_indicesNum = 0;

    if (!m_pDisp)
      throw Exception.WriteError(_T("CPutMethod"),name,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    HRESULT hRes = ((IDispatch*)m_pDisp)->GetIDsOfNames(IID_NULL,&name, 1,LOCALE_SYSTEM_DEFAULT, (long*)(&m_propID) );
    if (FAILED(hRes))
      throw Exception.WriteError(_T("CPutMethod"),name,_T("] - GetIDsOfNames calling error : "),hRes);
  }

    CPutMethod& keepIndices(int argNum,variant *array);
    void invoke();

public :

  // assign to property
    ScriptType& operator=(ScriptType other)
  {
      if (!m_pDisp)
        throw Exception.WriteError(_T("operator="), _T("") ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);
    m_arguments[m_indicesNum] = *((VARIANT*)&other);
    invoke();
    return (ScriptType&)m_host;
  }

public :

  // operators for ease calling IDispatch::Invoke

    CPutMethod& __cdecl operator()();
    CPutMethod& __cdecl operator()(variant v1);
    CPutMethod& __cdecl operator()(variant v1,variant v2);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7,variant v8);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7,variant v8,
                                                 variant v9);
    CPutMethod& __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7,variant v8,
                                                 variant v9,variant v10);
};

////////////////////////////////////////////////////////////////////////////////////////////

template<class variant>
EXCEPINFO  CPutMethod<variant>::ExcepInfo;

template<class variant>
unsigned int CPutMethod<variant>::WrongArgNumber=0;

template<class variant>
CInvokeException CPutMethod<variant>::Exception;


////////////////////////////////////////////////////////////////////////////////////////////

template<class variant>
CPutMethod<variant>& CPutMethod<variant>::keepIndices(int argNum,variant *argArray)
{
  m_indicesNum = argNum;
    for(int i = 0; i<argNum; i++ )
        memcpy(m_arguments + i, argArray+(m_indicesNum - i),sizeof(VARIANT));
  return *this;
}


template<class variant>
void CPutMethod<variant>::invoke()
{
    DISPID dispPut=DISPID_PROPERTYPUT;

    DISPPARAMS varArgs;
    varArgs.rgvarg = m_arguments;
    varArgs.cArgs  = m_indicesNum + 1;
    varArgs.cNamedArgs = 1;
    varArgs.rgdispidNamedArgs = &dispPut;

    if (!m_pDisp)
        throw Exception.WriteError(_T("operator("),_T(""),_T(") : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    HRESULT hRes = ((IDispatch*)m_pDisp)->Invoke( m_propID,IID_NULL,LOCALE_SYSTEM_DEFAULT, INVOKE_PROPERTYPUT ,&varArgs, NULL ,(EXCEPINFO FAR*)&ExcepInfo, &WrongArgNumber);
    if(FAILED(hRes))
    {
        if(hRes ==DISP_E_EXCEPTION)
            throw Exception.WriteError(_T("Exception in : "),ExcepInfo.bstrSource,ExcepInfo.bstrDescription,0);

        throw Exception.WriteError(_T("operator="),_T(""),_T(") - Invoke calling error : "),hRes);
    }
}

//////////////////////////////////////////////////////////////////////////////////////////

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()()
  {  return keepIndices(0,NULL); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1)
  {  return keepIndices(1,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2)
  {  return keepIndices(2,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3)
  {  return keepIndices(3,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4)
  {  return keepIndices(4,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5)
  {  return keepIndices(5,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6)
  {  return keepIndices(6,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7)
  {  return keepIndices(7,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7,variant v8)
  {  return keepIndices(8,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7,variant v8,
                                                             variant v9)
  {  return keepIndices(9,&v1); }

template<class variant>
CPutMethod<variant>& __cdecl CPutMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7,variant v8,
                                                             variant v9,variant v10)
  {  return keepIndices(10,&v1); }


////////////////////////////////////////////////////////////////////////////////////////
//CMethod
////////////////////////////////////////////////////////////////////////////////////////


template<class variant>
class CMethod
{
protected :
  VARIANT m_var;
public :

  typedef CScriptObject<variant> ScriptType;
  friend ScriptType;

  enum  {  ANYMETHOD = 0xff , ANYFLAG = 0xff00 , NORELEASE = 0x8000 };

    ~CMethod()
  {
	if( m_var.wReserved1 & ANYMETHOD )
    {
      VARIANT res;
      invoke(0,NULL,(ScriptType&)res);
	  CMethod<variant>(res , TRUE , 0 , NULL , FALSE);
    }

    if( m_var.wReserved1 & NORELEASE )
	  m_var.vt = VT_EMPTY;
  };


#if __BORLANDC__  < 0x580   // BCB version < 8
	CMethod(CMethod& other)
  {
		  // "CMethod(CMethod& other) must not be called!!!!"
		  assert(0);
		  ShowMessage("CMethod(CMethod& other) must not be called!!!!");
  }
#endif


  operator BYTE()     // ...BYTE
  {  ScriptType res;  invoke(0,NULL,res);
	return res.operator BYTE();
  }

    operator short()     // ...short
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator short();
  }

  operator bool()     // ...bool
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator bool();
  }

    operator int()          // ...int
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator int();
  }

  operator long()      // ...long
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator long();
  }

  operator float()     // ...float
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator float();
  }

  operator double()     // ...double
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator double();
  }

  operator CY()       // ...CY
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator CY();
  }

  operator DECIMAL()     // ...DECIMAL
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator DECIMAL();
  }

    char* CreateAnsi()      // ...char*
  {  ScriptType res;  invoke(0,NULL,res);
    return res.CreateAnsi();
  }

    LPOLESTR CreateUnicode()// ...LPOLESTR
  {  ScriptType res;  invoke(0,NULL,res);
    return res.CreateUnicode();
  }

    BSTR CreateBSTR()       // ...BSTR
  {  ScriptType res;  invoke(0,NULL,res);
    return res.CreateBSTR();
  }

  operator IDispatch*()   // ...IDispatch*
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator IDispatch*();
  }

  operator IUnknown*()   // ...IUnknown*
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator IUnknown*();
  }

#ifdef _MFC_VER
  operator CString()      //...CString
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator CString();
  }
#endif

#ifdef __BORLANDC__
  operator AnsiString()   //...AnsiString
  {  ScriptType res;  invoke(0,NULL,res);
    return res.operator AnsiString();
  }

/*
  operator AnsiString&()   //...AnsiString&
  {       static AnsiString resStr;
                ScriptType res;  invoke(0,NULL,res);
    restStr =  res.operator AnsiString();
                return resStr;
  }
*/

#endif

  operator VARIANT()   // ...VARIANT
  {  VARIANT res;
    invoke(0,NULL,(ScriptType&)res);
    return res;
  }

  operator variant()   // ...variant
  {  VARIANT res;
    invoke(0,NULL,(ScriptType&)res);
    return variant(res,TRUE);
  }


  operator ScriptType()   // ...ScriptType
  {  VARIANT res;
    invoke(0,NULL,(ScriptType&)res);
    return ScriptType(res,TRUE);
  }

protected :

    static EXCEPINFO ExcepInfo;
    static unsigned int WrongArgNumber;
    static CInvokeException Exception;

    CMethod(VARIANT& var, BOOL isAttachOnly ,WORD kind , LPOLESTR method , BOOL isNoRelease)
  {
    if(isAttachOnly)
      memmove((void*)this , (const void*)&var , sizeof(VARIANT));
    else
    {
      HRESULT hres = VariantCopy(&this->m_var, const_cast<VARIANT*>(static_cast<const VARIANT*>(&var)));
      if(FAILED(hres))
      throw Exception.WriteError(_T("\"CMethod(VARIANT& var)\" error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);
    }

    m_var.wReserved1 = 0;
    if(isNoRelease) m_var.wReserved1 |= NORELEASE;
    if(kind) m_var.wReserved1 = (m_var.wReserved1 & (WORD)ANYFLAG) | ( kind & (WORD)ANYMETHOD );
    if(method) GetIDofName( method );
  }

    void GetIDofName(LPOLESTR name);
    void invoke(int argNum,variant *array, ScriptType& result );

public :

  // collection of methods and properties indexed by const char* or LPOLESTR
    CMethod operator[](const char* name )
  {
    CMethodName wName;
    wName = name;
    return operator[](wName.m_Name);
  }

  CMethod operator[](LPCOLESTR name )
  {
      if (m_var.vt!=VT_DISPATCH)
        throw Exception.WriteError(_T("operator["), (LPOLESTR)name ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    if( m_var.wReserved1 & ANYMETHOD )
    {
      VARIANT res;
      invoke(0,NULL,(ScriptType&)res);
      return CMethod<variant>(res , TRUE , (WORD)(INVOKE_FUNC|INVOKE_PROPERTYGET) , (LPOLESTR)name , FALSE);
    }
    else
          throw Exception.WriteError(_T("\"CMethod::operator[]\" error : there is no method or property name "),(LPOLESTR)NULL,(LPOLESTR)NULL,0);
  }

  // Special for assign to indexed property
  CPutMethod<variant> operator[](Put name )
  {
      if (m_var.vt!=VT_DISPATCH)
        throw Exception.WriteError(_T("operator["), name.m_Name ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    if( m_var.wReserved1 & ANYMETHOD )
    {
      VARIANT res;
      invoke(0,NULL,(ScriptType&)res);

      if( res.vt != VT_DISPATCH)
          throw Exception.WriteError(_T("operator["), name.m_Name ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

      return CPutMethod<variant>(*((ScriptType*)&m_var), res.pdispVal , name.m_Name , FALSE);
    }
    else
          throw Exception.WriteError(_T("\"CMethod::operator[]\" error : there is no method or property name "),(LPOLESTR)NULL,(LPOLESTR)NULL,0);
  }

  // assign to property
    ScriptType& operator=(ScriptType other)
  {
      if (m_var.vt!=VT_DISPATCH)
        throw Exception.WriteError(_T("operator="), _T("") ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    if( m_var.wReserved1 & ANYMETHOD )
    {
      VARIANT varnt;
      m_var.wReserved1 = (unsigned short)((m_var.wReserved1 & ANYFLAG) | INVOKE_PROPERTYPUT);
      invoke(1,&other,(ScriptType&)varnt);
      return (ScriptType&)*((ScriptType*)this);
    }
    else
          throw Exception.WriteError(_T("\"CMethod::operator=\" error : there is no method or property name "),(LPOLESTR)NULL,(LPOLESTR)NULL,0);
  }

protected :
    ScriptType GetSriptObject()
    {
       if (m_var.vt!=VT_DISPATCH)
             throw Exception.WriteError(_T("operator="), _T("") ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

         if( m_var.wReserved1 & ANYMETHOD )
         {
          VARIANT varnt;
    invoke(0,NULL,(ScriptType&)varnt);
    return ScriptType(varnt , TRUE);
  }
  else
           throw Exception.WriteError(_T("\"CMethod::operator=\" error : there is no method or property name "),(LPOLESTR)NULL,(LPOLESTR)NULL,0);

    }

public :

  // operators for ease calling IDispatch::Invoke

    ScriptType __cdecl operator()();
    ScriptType __cdecl operator()(variant v1);
    ScriptType __cdecl operator()(variant v1,variant v2);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7,variant v8);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7,variant v8,
                                                 variant v9);
    ScriptType __cdecl operator()(variant v1,variant v2,
                                                 variant v3,variant v4,
                                                 variant v5,variant v6,
                                                 variant v7,variant v8,
                                                 variant v9,variant v10);
};

////////////////////////////////////////////////////////////////////////////////////////////

template<class variant>
EXCEPINFO  CMethod<variant>::ExcepInfo;

template<class variant>
unsigned int CMethod<variant>::WrongArgNumber=0;

template<class variant>
CInvokeException CMethod<variant>::Exception;


////////////////////////////////////////////////////////////////////////////////////////////


template<class variant>
void CMethod<variant>::GetIDofName(LPOLESTR name)
{
    DISPID methodId;

    if (m_var.vt!=VT_DISPATCH)
        throw Exception.WriteError(_T("operator["),name,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    if (sizeof(variant) < sizeof(VARIANT))
    throw Exception.WriteError(_T("operator["),name,_T("] - size of CMethod base class less then size of VARIANT! : "),E_INVALIDARG);

    HRESULT hRes = m_var.pdispVal->GetIDsOfNames(IID_NULL,&name, 1,LOCALE_SYSTEM_DEFAULT, &methodId);
    if (FAILED(hRes))
        throw Exception.WriteError(_T("operator["),name,_T("] - GetIDsOfNames calling error : "),hRes);

  *((DISPID*)& m_var.wReserved2) = methodId;
}


template<class variant>
void CMethod<variant>::invoke(int argNum, variant *argArray, ScriptType& varResult)
{
    DISPID dispPut=DISPID_PROPERTYPUT;

    DISPPARAMS varArgs;
    varArgs.rgvarg = argArray;
    varArgs.cArgs  = argNum;
    varArgs.cNamedArgs = (m_var.wReserved1&ANYMETHOD)==INVOKE_PROPERTYPUT?1:0;
    varArgs.rgdispidNamedArgs = (m_var.wReserved1&ANYMETHOD)==INVOKE_PROPERTYPUT?&dispPut:NULL;

    if (m_var.vt!=VT_DISPATCH)
  {
    m_var.wReserved1 &= ANYFLAG;
    *((DISPID*)&m_var.wReserved2 ) = 0;

        throw Exception.WriteError(_T("operator("),_T(""),_T(") : object doesn't contain IDispatch pointer "),E_INVALIDARG);
  }

    for(int l=0,r=argNum-1;l<argNum/2;l++,r--)
    {
        memcpy(&varResult      ,varArgs.rgvarg+r,sizeof(VARIANT));
        memcpy(varArgs.rgvarg+r,varArgs.rgvarg+l,sizeof(VARIANT));
        memcpy(varArgs.rgvarg+l,&varResult      ,sizeof(VARIANT));
    }

    if (sizeof(variant) > sizeof(VARIANT))
        for(int i=0;i<argNum;i++)
            memmove(varArgs.rgvarg+i,((VARIANT*)(argArray+i)),sizeof(VARIANT));

    if (sizeof(variant) < sizeof(VARIANT))
  {
    m_var.wReserved1 &= ANYFLAG;
    *((DISPID*)&m_var.wReserved2 ) = 0;

    throw Exception.WriteError(_T("operator("),_T(""),_T(") - size of CMethod base class less then size of VARIANT! : "),E_INVALIDARG);
  }

    varResult.vt = VT_EMPTY;

    HRESULT hRes = (m_var.pdispVal)->Invoke(*((DISPID*)&(m_var.wReserved2) ),IID_NULL,LOCALE_SYSTEM_DEFAULT, m_var.wReserved1&(WORD)ANYMETHOD ,&varArgs,(VARIANT*)&varResult,(EXCEPINFO FAR*)&ExcepInfo, &WrongArgNumber);

    if(FAILED(hRes))
    {
    m_var.wReserved1 &= ANYFLAG;
    *((DISPID*)&m_var.wReserved2 ) = 0;

        if(hRes ==DISP_E_EXCEPTION)
            throw Exception.WriteError(_T("Exception in : "),ExcepInfo.bstrSource,ExcepInfo.bstrDescription,0);

        throw Exception.WriteError(_T("operator("),_T(""),_T(") - Invoke calling error : "),hRes);
    }

  m_var.wReserved1 &= ANYFLAG;
  *((DISPID*)&m_var.wReserved2 ) = 0;
}


//////////////////////////////////////////////////////////////////////////////////////////

template<class variant> void* PrepareParams(int number, ...)
{
	va_list param_pt;
	va_start(param_pt,number);

	VARIANT* argsArray = new VARIANT[number];
	variant* arg;
	VARIANT* dest;

	for (int index = 0 ; index < number ; index++)
	{
		arg = &(va_arg(param_pt, variant));
		dest = argsArray+index;
		memcpy(dest, arg, sizeof(VARIANT));
	}
	va_end(param_pt);

	return argsArray;
}


template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()()
{
  VARIANT result;
  invoke(0,NULL,(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1)
{
  VARIANT result;
  invoke(1,&v1,(CScriptObject<variant>&)result); 
  return CScriptObject<variant>(result,TRUE);
}  

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(2, v1, v2));
  
  invoke(2, (variant*) params.get(),(CScriptObject<variant>&)result); 
  return CScriptObject<variant>(result,TRUE);
}

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(3, v1, v2, v3));
  
  invoke(3, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}  

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(4, v1, v2, v3, v4));
  
  invoke(4, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}  

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2, 
                                                             variant v3,variant v4,
                                                             variant v5)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(5, v1, v2, v3, v4, v5));

  invoke(5, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(6, v1, v2, v3, v4, v5, v6));

  invoke(6, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2, 
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(7, v1, v2, v3, v4, v5, v6, v7));

  invoke(7, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2, 
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7,variant v8)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(8, v1, v2, v3, v4, v5, v6, v7, v8));

  invoke(8, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2, 
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7,variant v8,
                                                             variant v9)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(9, v1, v2, v3, v4, v5, v6, v7, v8, v9));

  invoke(9, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}  

template<class variant>
CScriptObject<variant> __cdecl CMethod<variant>::operator()(variant v1,variant v2,
                                                             variant v3,variant v4,
                                                             variant v5,variant v6,
                                                             variant v7,variant v8,
                                                             variant v9,variant v10)
{
  VARIANT result;
  std::auto_ptr<int> params((int *) PrepareParams<variant>(10, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10));

  invoke(10, (variant*) params.get(),(CScriptObject<variant>&)result);
  return CScriptObject<variant>(result,TRUE);
}



////////////////////////////////////////////////////////////////////////////////////////
//CScriptObject
////////////////////////////////////////////////////////////////////////////////////////

template<class variant>
class CScriptObject  : public variant
{
protected :

    static CInvokeException Exception;

public:

  typedef variant BaseType;

    CScriptObject(const CScriptObject& other);
#if __BORLANDC__  < 0x570
    CScriptObject& operator=(const CScriptObject other);
#else
	CScriptObject& operator=(const CScriptObject& other);
#endif


#ifdef __BORLANDC__
    CScriptObject operator=(CMethod<variant> Val);
#endif

#ifdef _MSC_VER
    CScriptObject& operator=(const CMethod<variant>& Val);
#endif


    //Conversion from...
    CScriptObject(BYTE byteVal) : variant(byteVal){};                                   //...BYTE
    CScriptObject(short shortVal) : variant(shortVal){};                                //...short
    CScriptObject(const bool bVal) : variant(bVal){};                                   //...bool ("const" to avoid conversions to bool)
    CScriptObject(int intVal,VARTYPE vtArg = VT_EMPTY) : variant(intVal,vtArg){};       //...int
    CScriptObject(long longVal,VARTYPE vtArg = VT_I4) : variant(longVal,vtArg){};       //...long
    CScriptObject(float fltVal) : variant(fltVal){};                                    //...float
    CScriptObject(double dblVal,VARTYPE vtArg = VT_R8) : variant(dblVal,vtArg){};       //...double
    CScriptObject(const CY cyVal) : variant(cyVal){};                                   //...const CY&
    CScriptObject(const DECIMAL dVal) : variant(dVal){};                                //...const DECIMAL&
    CScriptObject(const char* charStr) : variant(charStr){};                            //...const char*
    CScriptObject(LPCOLESTR str) : variant(str){};                                      //...LPCOLESTR
    CScriptObject(BSTR charStr,BOOL isAttachOnly) : variant(charStr,isAttachOnly){};    //...BSTR
    CScriptObject(IUnknown* pUnk,BOOL isAddRef=TRUE) : variant(pUnk,isAddRef){};        //...IUnknown*
    CScriptObject(IDispatch* pDisp,BOOL isAddRef=TRUE) : variant(pDisp,isAddRef){};     //...IDispatch*
    CScriptObject(VARIANT var,BOOL isAttachOnly) : variant(var,isAttachOnly){};         //...VARIANT&
#ifdef _MFC_VER
    CScriptObject(CString str) : variant(str){};                                        //...CString&
#endif
#ifdef __BORLANDC__
    CScriptObject(AnsiString str) : variant(str){};                                     //...AnsiString&
#endif

    //Assignment operators
    CScriptObject& operator=(BYTE bVal)                                                 //...BYTE
    { return (CScriptObject&) variant::operator=(bVal); }
    CScriptObject& operator=(short shortVal)                                            //...short
    { return (CScriptObject&) variant::operator=(shortVal); }
    CScriptObject& operator=(bool bVal)                                                 //...bool
    { return (CScriptObject&) variant::operator=(bVal); }
    CScriptObject& operator=(int intVal)                                                //...int
    { return (CScriptObject&) variant::operator=(intVal); }
    CScriptObject& operator=(long longVal)                                              //...long
    { return (CScriptObject&) variant::operator=(longVal); }
    CScriptObject& operator=(float fltVal)                                              //...float
    { return (CScriptObject&) variant::operator=(fltVal); }
    CScriptObject& operator=(double dblVal)                                             //...double
    { return (CScriptObject&) variant::operator=(dblVal); }
    CScriptObject& operator=(const CY cyVal)                                            //...const CY&
    { return (CScriptObject&) variant::operator=(cyVal); }
    CScriptObject& operator=(const DECIMAL decVal)                                      //...const DECIMAL&
    { return (CScriptObject&) variant::operator=(decVal); }
    CScriptObject& operator=(const char* pVal)                                          //...const char*
    { return (CScriptObject&) variant::operator=(pVal); }
    CScriptObject& operator=(LPCOLESTR pVal)                                            //...LPCOLESTR
    { return (CScriptObject&) variant::operator=(pVal); }
    CScriptObject& operator=(const BSTR rVal)                                           //...const BSTR
    { return (CScriptObject&) variant::operator=(rVal); }
    CScriptObject& operator=(const IUnknown* pVal)                                      //...IUnknown*
    { return (CScriptObject&) variant::operator=(pVal); }
    CScriptObject& operator=(const IDispatch* pVal)                                     //...IDispatch*
    { return (CScriptObject&) variant::operator=(pVal); }
    CScriptObject& operator=(const VARIANT Val)                                         //...const VARIANT&
    { return (CScriptObject&) variant::operator=(Val); }


#ifdef _MFC_VER
    CScriptObject& operator=(const CString str)                                         //...CString&
    { return (CScriptObject&) variant::operator=(str); }
#endif
#ifdef __BORLANDC__
    CScriptObject& operator=(const AnsiString str)                                      //...AnsiString&
    { return (CScriptObject&) variant::operator=(str); }
#endif

  /////////// BYREF ////////////

    //Construct VT_BYREF on ...
    CScriptObject(BYTE* pByte) : variant(pByte){};                                      //...BYTE*
    CScriptObject(short* pShort, VARTYPE vtArg = VT_I2) : variant(pShort, vtArg){};     //...short*
    CScriptObject(int* pInt) : variant(pInt){};                                         //...int*
    CScriptObject(long* pLong , VARTYPE vtArg = VT_I4) : variant(pLong , vtArg){};      //...long*
    CScriptObject(float* pFlt) : variant(pFlt){};                                       //...float*
    CScriptObject(double* pDbl,VARTYPE vtArg = VT_R8) : variant(pDbl,vtArg){};          //...double*
    CScriptObject(CY* pCY) : variant(pCY){};                                            //...const CY*
    CScriptObject(DECIMAL* pDEC) : variant(pDEC){};                                     //...const DECIMAL*
    CScriptObject(BSTR* pBSTR) : variant(pBSTR){};                                      //...BSTR*
    CScriptObject(IUnknown** ppUnk) : variant(ppUnk){};                                 //...IUnknown**
    CScriptObject(IDispatch** ppDisp) : variant(ppDisp){};                              //...IDispatch**
    CScriptObject(VARIANT* pVar) : variant(pVar){};                                     //...VARIANT*


  // collection of methods and properties indexed by const char* or LPOLESTR

    CMethod<variant> operator[](const char* name ) 
  {
    CMethodName wName;
    wName = name;
    return operator[](wName.m_Name);
  }

    CMethod<variant> operator[](LPCOLESTR name ) 
  {
      if (vt!=VT_DISPATCH)
        throw Exception.WriteError(_T("operator["), (LPOLESTR)name ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    return   CMethod<variant>(*this, TRUE , (WORD)(INVOKE_FUNC|INVOKE_PROPERTYGET) ,
            (LPOLESTR)name , TRUE);
  }
	

  // Special for assign to indexed property
    CPutMethod<variant> operator[](Put name ) 
  {
      if (vt!=VT_DISPATCH)
        throw Exception.WriteError(_T("operator["), name.m_Name ,_T("] : object doesn't contain IDispatch pointer "),E_INVALIDARG);

    return  CPutMethod<variant>( *this , pdispVal , name.m_Name , TRUE);

  }

#ifdef _MSC_VER
  CScriptObject(const CMethod<variant>& other)
  {
    VARIANT* pOther = (VARIANT*)(void*)(&other);
      if (pOther->vt!=VT_DISPATCH)
          throw Exception.WriteError(_T("CScriptObject() error : argument is not a object"),(LPOLESTR)NULL,(LPOLESTR)NULL,0);

	if( pOther->wReserved1 & CMethod<variant>::ANYMETHOD )
    {
      ((CMethod<variant>&)other).invoke(0,NULL,(CScriptObject&)(*this));
    }
    else
          throw Exception.WriteError(_T("CScriptObject() error : attempt to convert method to object "),(LPOLESTR)NULL,(LPOLESTR)NULL,0);
  }
#endif // _MSC_VER


#if __BORLANDC__  >= 0x580   // BCB version >= 8
  CScriptObject(CMethod<variant> other)
  {
	VARIANT* pOther = (VARIANT*)(void*)(&other);
	  if (pOther->vt!=VT_DISPATCH)
		  throw Exception.WriteError(_T("CScriptObject() error : argument is not a object"),(LPOLESTR)NULL,(LPOLESTR)NULL,0);

	if( pOther->wReserved1 & CMethod<variant>::ANYMETHOD )
	{
      other.invoke(0,NULL,(CScriptObject&)(*this));
    }
    else
          throw Exception.WriteError(_T("CScriptObject() error : attempt to convert method to object "),(LPOLESTR)NULL,(LPOLESTR)NULL,0);
  }
#endif // __BORLANDC__


    CScriptObject(){};
    ~CScriptObject(){};

    // functions gets active objects IDispatch by given CLSID

    CScriptObject& GetActiveObject(const CLSID&);
    CScriptObject& GetActiveObject(LPCOLESTR progID);

    // functions gets active object or creates instance

    CScriptObject& GetObject(const CLSID&);
    CScriptObject& GetObjectAlternative(const CLSID& ClsId, const CLSID& AltClsId);

    CScriptObject& GetObject(LPCOLESTR progID);
	CScriptObject& GetObjectAlternative(LPCOLESTR progID, LPCOLESTR alt_progID);


  void Clear()
  {
    VariantClear(this);
  }

  BOOL IsEmpty()
  {
    return vt == VT_EMPTY;
  }

  BOOL IsConnected()
  {
    return (vt == VT_DISPATCH) && (pdispVal!= NULL);
  }


};

////////////////////////////////////////////////////////////////////////////////////////////


template<class variant>
CInvokeException CScriptObject<variant>::Exception;


////////////////////////////////////////////////////////////////////////////////////////////
template<class variant>
CScriptObject<variant>::CScriptObject(const CScriptObject<variant>& other) 
{
  // VariantInit(this); Ancestor must do it
  HRESULT hres = VariantCopy(this, const_cast<VARIANT*>(static_cast<const VARIANT*>(&other)));
    if(FAILED(hres))
        throw Exception.WriteError(_T("\"CScriptObject(CScriptObject&)\" error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);
}

#if __BORLANDC__  < 0x570
template<class variant>
CScriptObject<variant>& CScriptObject<variant>::operator=(const CScriptObject<variant> other)
#else
template<class variant>
CScriptObject<variant>& CScriptObject<variant>::operator=(const CScriptObject<variant>& other)
#endif
{
  HRESULT hres = VariantCopy(this, const_cast<VARIANT*>(static_cast<const VARIANT*>(&other)));
    if(FAILED(hres))
        throw Exception.WriteError(_T("\"CScriptObject(CScriptObject)\" error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);

    return *this;
}


#ifdef __BORLANDC__
template<class variant>
CScriptObject<variant> CScriptObject<variant>::operator=(CMethod<variant> other)
{
  var res = var(other);
  return operator=(res);
}
#endif

#ifdef _MSC_VER
template<class variant>
CScriptObject<variant>& CScriptObject<variant>::operator=(const CMethod<variant>& other)
{
  var res = var(other);
  return operator=( res );
}
#endif


//////////////////////////////////////////////////////////////////////////////////////////////
//

template<class variant>
CScriptObject<variant>& CScriptObject<variant>::GetActiveObject(const CLSID& ClsId)
{
    IUnknown* pUnk;
    IDispatch* pDisp;

    HRESULT hres = ::GetActiveObject(ClsId, NULL, &pUnk);
    if (FAILED(hres))
        throw Exception.WriteError(_T("\"GetActiveObject\" ::GetActiveObject calling error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);

    hres = pUnk->QueryInterface(IID_IDispatch,(void**)&pDisp);

    pUnk->Release();

    if(FAILED(hres))
        throw Exception.WriteError(_T("\"GetActiveObject\" QueryInterface calling error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);

    VariantClear(this);
    vt= VT_DISPATCH;
    pdispVal = pDisp;

    return (CScriptObject<variant>&) *this;
}

template<class variant>
CScriptObject<variant>& CScriptObject<variant>::GetActiveObject(LPCOLESTR progID)
{
    CLSID clsid;
    HRESULT hRes = CLSIDFromProgID(progID,&clsid);

    if (FAILED(hRes))
        throw Exception.WriteError(_T("\"GetActiveObject\" CLSIDFromProgID calling error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hRes);

    return this->GetActiveObject(clsid);
}

template<class variant>
CScriptObject<variant>& CScriptObject<variant>::GetObject(const CLSID& ClsId)
{
    IUnknown* pntr = NULL;

    HRESULT hres = ::GetActiveObject(ClsId, NULL, &pntr);
    if (FAILED(hres))
          hres = CoCreateInstance(ClsId ,NULL,CLSCTX_LOCAL_SERVER ,
                               IID_IUnknown , (void**) &pntr  );
    if(FAILED(hres))
       throw Exception.WriteError(_T("Can not create the server instance : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);

    IDispatch* dptr = NULL;
    hres = pntr->QueryInterface(IID_IDispatch, (void**) &dptr);
    if(FAILED(hres))
    {
        pntr->Release();
        throw Exception.WriteError(_T("Can not create the server instance : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);
    }
    pntr->Release();

    VariantClear(this);
    vt= VT_DISPATCH;
    pdispVal = dptr;

    return (CScriptObject<variant>&) *this;
}

template<class variant>
CScriptObject<variant>& CScriptObject<variant>::GetObjectAlternative(const CLSID& ClsId, const CLSID& AltClsId)
{
    IUnknown* pntr = NULL;

    HRESULT hres = ::GetActiveObject(ClsId, NULL, &pntr);
    if (FAILED(hres))
	{
		hres = ::GetActiveObject(AltClsId, NULL, &pntr);
		if (FAILED(hres))
		{
			hres = CoCreateInstance(ClsId ,NULL,CLSCTX_LOCAL_SERVER,
							   IID_IUnknown , (void**) &pntr  );
			if (FAILED(hres))
				hres = CoCreateInstance(AltClsId ,NULL,CLSCTX_LOCAL_SERVER,
								   IID_IUnknown , (void**) &pntr  );
		}
	}

    if(FAILED(hres))
       throw Exception.WriteError(_T("Can not create the server instance : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);

    IDispatch* dptr = NULL;
    hres = pntr->QueryInterface(IID_IDispatch, (void**) &dptr);
    if(FAILED(hres))
    {
        pntr->Release();
        throw Exception.WriteError(_T("Can not create the server instance : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hres);
    }
    pntr->Release();

    VariantClear(this);
    vt= VT_DISPATCH;
    pdispVal = dptr;

    return (CScriptObject<variant>&) *this;
}


template<class variant>
CScriptObject<variant>& CScriptObject<variant>::GetObject(LPCOLESTR progID)
{
    CLSID clsid;
    HRESULT hRes = CLSIDFromProgID(progID,&clsid);

    if (FAILED(hRes))
        throw Exception.WriteError(_T("\"GetObject\" CLSIDFromProgID calling error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hRes);

    return this->GetObject(clsid);
}

template<class variant>
CScriptObject<variant>& CScriptObject<variant>::GetObjectAlternative(LPCOLESTR progID, LPCOLESTR alt_progID)
{
    CLSID clsid;
    HRESULT hRes = CLSIDFromProgID(progID, &clsid);

	CLSID alt_clsid;
    HRESULT hResAlt = CLSIDFromProgID(alt_progID, &alt_clsid);

    if (SUCCEEDED(hRes))
		if(SUCCEEDED(hResAlt))
			return this->GetObjectAlternative(clsid, alt_clsid);
		else
		    return this->GetObject(clsid);
	else
		if(SUCCEEDED(hResAlt))
		    return this->GetObject(alt_clsid);
		else
			throw Exception.WriteError(_T("\"GetObject\" CLSIDFromProgID calling error : "),(LPOLESTR)NULL,(LPOLESTR)NULL,hRes);
}

// !!! Change this type def to change base variant wrapper :

typedef CVariantWrap BaseVariantWrapper;

typedef  CScriptObject<BaseVariantWrapper> var;
typedef  void function;
typedef  bool Boolean;



///////////////////////////////////////////////////////////////////////////////////////////
// Arithmetic
///////////////////////////////////////////////////////////////////////////////////////////

#ifdef _MFC_VER

inline void ShowMessage(CString str){ AfxMessageBox(str);};

#endif //_MFC_VER


typedef  CMethod< BaseVariantWrapper > method;

#ifdef _MFC_VER
//  operator+
inline var operator+( var& left , var& right)
{
  var res;
  ::VarAdd(  &var(left), &var(right), &res);
  return res;
}
inline var operator+( var& left , method& right)
{
  var res;
  ::VarAdd(  &var(left), &var(right), &res);
  return res;
}

inline var operator+( method& left , var& right)
{
  var res;
  ::VarAdd(  &var(left), &right, &res);
  return res;
}
inline var operator+( method& left , method& right)
{
  var res;
  ::VarAdd(  &var(left), &var(right), &res);
  return res;
}
#endif _MFC_VER


#ifdef __BORLANDC__

#if __BORLANDC__  == 0x530   // BCB 3
inline void _VarAdd(VARIANT* pLeft , VARIANT* pRight , VARIANT* res)
{
	Variant *pL = (Variant*)pLeft , *pR = (Variant*)pRight;
	*res = (VARIANT)(*pL + *pR);
};
#elif  __BORLANDC__ >= 0x0580  // BDS
inline void _VarAdd(VARIANT* pLeft , VARIANT* pRight , VARIANT* res)
{
	::VarAdd(pLeft, pRight, res);
};
#else
inline void _VarAdd(VARIANT* pLeft , VARIANT* pRight , VARIANT* res)
{
	VarAdd(pLeft, pRight, res);
};
#endif


inline var operator+( var left , var right)
{
  var res;
  _VarAdd(  &var(left), &var(right), &res);
  return res;
}
inline var operator+( var left , method right)
{
  var res;
  _VarAdd(  &var(left), &var(right), &res);
  return res;
}

inline var operator+( method left , var right)
{
  var res;
  _VarAdd(  &var(left), &var(right), &res);
  return res;
}
inline var operator+( method left , method right)
{
  var res;
  _VarAdd(  &var(left), &var(right), &res);
  return res;
}
#endif // __BORLAND__

// operator ==

#ifdef _MSC_VER

// fix for VS before SP4
#if _MSC_VER <= 1200
 STDAPI VarCmp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LCID lcid, ULONG dwFlags);
#endif

inline bool operator==(const var& left ,const method& right)
{
	return VarCmp(  (var*)&left, (var*)&var((method&)right), LOCALE_USER_DEFAULT, 0 ) == VARCMP_EQ;
}

inline bool operator==(const method& left ,const var& right)
{
	return VarCmp(  (var*)&var((method&)left), (var*)&right, LOCALE_USER_DEFAULT , 0 ) == VARCMP_EQ;
}
inline bool operator==(const method& left ,const method& right)
{
	return VarCmp(  (var*)&var((method&)left), (var*)&var((method&)right), LOCALE_USER_DEFAULT , 0) == VARCMP_EQ;
}
#endif _MSC_VER


#ifdef __BORLANDC__

#if __BORLANDC__  == 0x530   // BCB 3
#define VARCMP_LT   0
#define VARCMP_EQ   1
#define VARCMP_GT   2
#define VARCMP_NULL 3

inline _VarCmp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LCID lcid, ULONG dwFlags)
{
	Variant *pLeft = (Variant*)pvarLeft , *pRight = (Variant*)pvarRight;
	if( !pLeft || !pRight ) return VARCMP_NULL;
	if( *pLeft < *pRight) return VARCMP_LT;
	if( *pLeft > *pRight) return VARCMP_GT;
	return  VARCMP_EQ;
};

#elif __BORLANDC__  == 0x580   // BDS
inline _VarCmp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LCID lcid, ULONG dwFlags)
{
  return ::VarCmp(pvarLeft, pvarRight, dwFlags);
}

#else
  #if __BORLANDC__  == 0x540   // BCB version 4
  // fix for BCB before 5
  STDAPI VarCmp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LCID lcid, ULONG dwFlags);
  #endif

  inline _VarCmp(LPVARIANT pvarLeft, LPVARIANT pvarRight, LCID lcid, ULONG dwFlags)
  {
	return VarCmp(pvarLeft, pvarRight, lcid, dwFlags);
  }
#endif //



inline bool operator==( var left , method right)
{
	return _VarCmp(  (LPVARIANT) &left, (LPVARIANT) &var(right), LOCALE_USER_DEFAULT , 0 ) == VARCMP_EQ;
}

inline bool operator==( method left , var right)
{
	return _VarCmp(  (LPVARIANT) &var(left), (LPVARIANT) &right, LOCALE_USER_DEFAULT , 0 ) == VARCMP_EQ;
}
inline bool operator==( method left , method right)
{
	return _VarCmp(  (LPVARIANT) &var(left), (LPVARIANT) &var(right), LOCALE_USER_DEFAULT , 0 ) == VARCMP_EQ;
}
#endif //__BORLANDC__



template<class T, class variant>
class CLazyRef
{
private :
  var m_ref;
public :

  CLazyRef()
  {
  }

  bool IsVaidReference(const var& Ref)
  {
    if(Ref.vt != VT_DISPATCH )
      return false;

    unsigned int tiCount;

    return S_OK == Ref.pdispVal->GetTypeInfoCount(&tiCount);
  }

  inline var& GetRef()
  {
    T caller;

    m_ref = caller();
    return m_ref;
  };

  operator var()
  {
    return GetRef();
  }

  // collection of methods and properties indexed by const char* or LPOLESTR
  CMethod<variant> operator[](const char* name )
  {
    return GetRef().operator[](name);
  }

  CMethod<variant> operator[](LPCOLESTR name )
  {
    return GetRef().operator[](name);
  }

  CMethod<variant> operator[](CVariantWrap& name)
  {
	  BSTR pBSTR = name.CreateBSTR();
	  return operator[](pBSTR);
  }

  // Special for assign to indexed property
  CPutMethod<variant> operator[](Put name )
  {
    return  Ref().operator[](name);
  }



};


} // script namespace

#define TCApplication L"TestComplete.TestCompleteApplication.6" 
#define TEApplication L"TestExecute.TestExecuteApplication.6" 

#define IntegrationPropName L"Integration"
#define ObjectByNamePropName L"GetObjectByName" 

///////////////////////////////////////////////////////////////////////////////////////////
// TestCompletes global objects
///////////////////////////////////////////////////////////////////////////////////////////


namespace TestComplete
{
  using namespace script;

class GetTCBase
{
protected :
  inline var GetTCObject(void)
  { return (var)TestComplete::var().GetObjectAlternative(TCApplication, TEApplication); }

};

class GetTC : public GetTCBase
{
public :
  var operator()(void)
  { return GetTCObject(); }
};

class GetManager : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()["Manager"]["ManagersByString"]("{6FD84F86-DA2B-4902-BD72-1E0A9A85146D}"); }
};

class GetADO : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("ADO"); }
};

class GetBDE : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("BDE"); }
};

class GetBuiltIn : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("BuiltIn"); }
};

class GetDB : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("DB"); }
};

class GetDbgServices : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("DbgServices"); }
};

class GetDll : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Dll"); }
};

class GetdotNET : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("dotNET"); }
};

class GetFiles : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Files"); }
};

class GetIndicator : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Indicator"); }
};

class GetLoadTesting : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("LoadTesting"); }
};

class GetLog : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Log"); }
};

class GetNetworkSuite : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("NetworkSuite"); }
};

class GetObjects : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Objects"); }
};

class GetOCR : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("OCR"); }
};

class GetODT : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("ODT"); }
};

class GetOptions : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Options"); }
};

class GetProject : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Project"); }
};

class GetProjectSuite : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("ProjectSuite"); }
};

class GetRegions : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Regions"); }
};

class GetRunner : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Runner"); }
};

class GetSys : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Sys"); }
};

class GetStorages : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Storages"); }
};


class GetTestedApps : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("TestedApps"); }
};

class GetTestSuites : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("TestSuites"); }
};


class GetUtilities : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Utilities"); }
};

class GetUtils : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Utils"); }
};

class GetWin32API : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Win32API"); }
};

class GetNameMapping : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("NameMapping"); }
};

class GetAliases : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Aliases"); }
};


class GetConsts : public GetTCBase
{
public :
  var operator()(void)
  { return (var)GetTCObject()[IntegrationPropName][ObjectByNamePropName]("Consts"); }
};

  extern CLazyRef<GetTC, BaseVariantWrapper>					TC;\
  extern CLazyRef<GetADO, BaseVariantWrapper>					ADO;\
  extern CLazyRef<GetManager, BaseVariantWrapper>				Manager;\
  extern CLazyRef<GetBDE, BaseVariantWrapper>					BDE;\
  extern CLazyRef<GetBuiltIn, BaseVariantWrapper>				BuiltIn;\
  extern CLazyRef<GetDB, BaseVariantWrapper>					DB;\
  extern CLazyRef<GetDbgServices, BaseVariantWrapper>			DbgServices;\
  extern CLazyRef<GetDll, BaseVariantWrapper>					Dll;\
  extern CLazyRef<GetdotNET, BaseVariantWrapper>				dotNET;\
  extern CLazyRef<GetFiles, BaseVariantWrapper>					Files;\
  extern CLazyRef<GetIndicator, BaseVariantWrapper>				Indicator;\
  extern CLazyRef<GetLoadTesting, BaseVariantWrapper>			LoadTesting;\
  extern CLazyRef<GetLog, BaseVariantWrapper>					Log;\
  extern CLazyRef<GetNetworkSuite, BaseVariantWrapper>			NetworkSuite;\
  extern CLazyRef<GetObjects, BaseVariantWrapper>				Objects;\
  extern CLazyRef<GetOCR, BaseVariantWrapper>					OCR;\
  extern CLazyRef<GetODT, BaseVariantWrapper>					ODT;\
  extern CLazyRef<GetOptions, BaseVariantWrapper>				Options;\
  extern CLazyRef<GetProject, BaseVariantWrapper>               Project;\
  extern CLazyRef<GetProjectSuite, BaseVariantWrapper>          ProjectSuite;\
  extern CLazyRef<GetRegions, BaseVariantWrapper>               Regions;\
  extern CLazyRef<GetRunner, BaseVariantWrapper>                Runner;\
  extern CLazyRef<GetSys, BaseVariantWrapper>                   Sys;\
  extern CLazyRef<GetStorages, BaseVariantWrapper>              Storages;\
  extern CLazyRef<GetTestedApps, BaseVariantWrapper>            TestedApps;\
  extern CLazyRef<GetTestSuites, BaseVariantWrapper>            TestSuites;\
  extern CLazyRef<GetUtilities, BaseVariantWrapper>             Utilities;\
  extern CLazyRef<GetUtils, BaseVariantWrapper>					Utils;\
  extern CLazyRef<GetWin32API, BaseVariantWrapper>				Win32API;\
  extern CLazyRef<GetNameMapping, BaseVariantWrapper>			NameMapping;\
  extern CLazyRef<GetAliases, BaseVariantWrapper>				Aliases;\
  extern CLazyRef<GetConsts, BaseVariantWrapper>				Consts;

  inline void StopTest(void)
  {
    Runner["Stop"];
  }

  inline var GetObjectByName(const BSTR ObjName)
  {
	  return TC[IntegrationPropName][ObjectByNamePropName](ObjName);
  }

  inline void RunTest(const BSTR LogName, const BSTR ProjectName, const BSTR SuiteName)
  {

	  TC[IntegrationPropName]["OpenProjectSuite"](SuiteName);

	  var TestEngine = TC["Manager"]["ManagersByString"]("{555A3A53-8D35-4F93-9570-00662CF627C6}"); 
	  TestEngine["RunConnected"](LogName, ProjectName);
  }


#define IMPLEMENT_TESTCOMPLETE_GLOBAL_OBJECTS   COleInit g_InitOle;\
  CLazyRef<GetTC, BaseVariantWrapper>                     TestComplete::TC;\
  CLazyRef<GetADO, BaseVariantWrapper>                    TestComplete::ADO;\
  CLazyRef<GetManager, BaseVariantWrapper>				  TestComplete::Manager;\
  CLazyRef<GetBDE, BaseVariantWrapper>                    TestComplete::BDE;\
  CLazyRef<GetBuiltIn, BaseVariantWrapper>                TestComplete::BuiltIn;\
  CLazyRef<GetDB, BaseVariantWrapper>            TestComplete::DB;\
  CLazyRef<GetDbgServices, BaseVariantWrapper>            TestComplete::DbgServices;\
  CLazyRef<GetDll, BaseVariantWrapper>          TestComplete::Dll;\
  CLazyRef<GetdotNET, BaseVariantWrapper>                 TestComplete::dotNET;\
  CLazyRef<GetFiles, BaseVariantWrapper>                  TestComplete::Files;\
  CLazyRef<GetIndicator, BaseVariantWrapper>              TestComplete::Indicator;\
  CLazyRef<GetLoadTesting, BaseVariantWrapper>            TestComplete::LoadTesting;\
  CLazyRef<GetLog, BaseVariantWrapper>                    TestComplete::Log;\
  CLazyRef<GetNetworkSuite, BaseVariantWrapper>           TestComplete::NetworkSuite;\
  CLazyRef<GetObjects, BaseVariantWrapper>                TestComplete::Objects;\
  CLazyRef<GetOCR, BaseVariantWrapper>          TestComplete::OCR;\
  CLazyRef<GetODT, BaseVariantWrapper>          TestComplete::ODT;\
  CLazyRef<GetOptions, BaseVariantWrapper>				TestComplete::Options;\
  CLazyRef<GetProject, BaseVariantWrapper>                TestComplete::Project;\
  CLazyRef<GetProjectSuite, BaseVariantWrapper>           TestComplete::ProjectSuite;\
  CLazyRef<GetRegions, BaseVariantWrapper>                TestComplete::Regions;\
  CLazyRef<GetRunner, BaseVariantWrapper>                 TestComplete::Runner;\
  CLazyRef<GetSys, BaseVariantWrapper>                    TestComplete::Sys;\
  CLazyRef<GetStorages, BaseVariantWrapper>               TestComplete::Storages;\
  CLazyRef<GetTestedApps, BaseVariantWrapper>             TestComplete::TestedApps;\
  CLazyRef<GetTestSuites, BaseVariantWrapper>			TestComplete::TestSuites;\
  CLazyRef<GetUtilities, BaseVariantWrapper>              TestComplete::Utilities;\
  CLazyRef<GetUtils, BaseVariantWrapper>          TestComplete::Utils;\
  CLazyRef<GetWin32API, BaseVariantWrapper>               TestComplete::Win32API;\
  CLazyRef<GetNameMapping, BaseVariantWrapper>			TestComplete::NameMapping;\
  CLazyRef<GetAliases, BaseVariantWrapper>			TestComplete::Aliases;\
  CLazyRef<GetConsts, BaseVariantWrapper>				TestComplete::Consts;

//#if !( (_WIN32_WINNT >= 0x0400 ) || defined(_WIN32_DCOM) )
//#error "_WIN32_WINNT must be >= 0x0400 or _WIN32_DCOM must be defined to init MTA , see your defines"
//#endif

#define IMPLEMENT_TESTCOMPLETE_GLOBAL_OBJECTS_MTA\
  COleInit g_InitOle(COINIT_MULTITHREADED);\
  CLazyRef<GetTC, BaseVariantWrapper>                     TestComplete::TC;\
  CLazyRef<GetADO, BaseVariantWrapper>                    TestComplete::ADO;\
  CLazyRef<GetManager, BaseVariantWrapper>				  TestComplete::Manager;\
  CLazyRef<GetBDE, BaseVariantWrapper>                    TestComplete::BDE;\
  CLazyRef<GetBuiltIn, BaseVariantWrapper>                TestComplete::BuiltIn;\
  CLazyRef<GetDB, BaseVariantWrapper>            TestComplete::DB;\
  CLazyRef<GetDbgServices, BaseVariantWrapper>            TestComplete::DbgServices;\
  CLazyRef<GetDll, BaseVariantWrapper>          TestComplete::Dll;\
  CLazyRef<GetdotNET, BaseVariantWrapper>                 TestComplete::dotNET;\
  CLazyRef<GetFiles, BaseVariantWrapper>                  TestComplete::Files;\
  CLazyRef<GetIndicator, BaseVariantWrapper>              TestComplete::Indicator;\
  CLazyRef<GetLoadTesting, BaseVariantWrapper>            TestComplete::LoadTesting;\
  CLazyRef<GetLog, BaseVariantWrapper>                    TestComplete::Log;\
  CLazyRef<GetNetworkSuite, BaseVariantWrapper>           TestComplete::NetworkSuite;\
  CLazyRef<GetObjects, BaseVariantWrapper>                TestComplete::Objects;\
  CLazyRef<GetOCR, BaseVariantWrapper>          TestComplete::OCR;\
  CLazyRef<GetODT, BaseVariantWrapper>          TestComplete::ODT;\
  CLazyRef<GetOptions, BaseVariantWrapper>				TestComplete::Options;\
  CLazyRef<GetProject, BaseVariantWrapper>                TestComplete::Project;\
  CLazyRef<GetProjectSuite, BaseVariantWrapper>           TestComplete::ProjectSuite;\
  CLazyRef<GetRegions, BaseVariantWrapper>                TestComplete::Regions;\
  CLazyRef<GetRunner, BaseVariantWrapper>                 TestComplete::Runner;\
  CLazyRef<GetSys, BaseVariantWrapper>                    TestComplete::Sys;\
  CLazyRef<GetStorages, BaseVariantWrapper>               TestComplete::Storages;\
  CLazyRef<GetTestedApps, BaseVariantWrapper>             TestComplete::TestedApps;\
  CLazyRef<GetTestSuites, BaseVariantWrapper>           TestComplete::TestSuites;\
  CLazyRef<GetUtilities, BaseVariantWrapper>              TestComplete::Utilities;\
  CLazyRef<GetUtils, BaseVariantWrapper>          TestComplete::Utils;\
  CLazyRef<GetWin32API, BaseVariantWrapper>               TestComplete::Win32API;\
  CLazyRef<GetNameMapping, BaseVariantWrapper>			TestComplete::NameMapping;\
  CLazyRef<GetAliases, BaseVariantWrapper>			TestComplete::Aliases;\
  CLazyRef<GetConsts, BaseVariantWrapper>				TestComplete::Consts;

#define IMPLEMENT_TESTCOMPLETE_GLOBAL_OBJECTS_ONLY\
  CLazyRef<GetTC, BaseVariantWrapper>                     TestComplete::TC;\
  CLazyRef<GetADO, BaseVariantWrapper>                    TestComplete::ADO;\
  CLazyRef<GetManager, BaseVariantWrapper>				  TestComplete::Manager;\
  CLazyRef<GetBDE, BaseVariantWrapper>                    TestComplete::BDE;\
  CLazyRef<GetBuiltIn, BaseVariantWrapper>                TestComplete::BuiltIn;\
  CLazyRef<GetDB, BaseVariantWrapper>            TestComplete::DB;\
  CLazyRef<GetDbgServices, BaseVariantWrapper>            TestComplete::DbgServices;\
  CLazyRef<GetDll, BaseVariantWrapper>          TestComplete::Dll;\
  CLazyRef<GetdotNET, BaseVariantWrapper>                 TestComplete::dotNET;\
  CLazyRef<GetFiles, BaseVariantWrapper>                  TestComplete::Files;\
  CLazyRef<GetIndicator, BaseVariantWrapper>              TestComplete::Indicator;\
  CLazyRef<GetLoadTesting, BaseVariantWrapper>            TestComplete::LoadTesting;\
  CLazyRef<GetLog, BaseVariantWrapper>                    TestComplete::Log;\
  CLazyRef<GetNetworkSuite, BaseVariantWrapper>           TestComplete::NetworkSuite;\
  CLazyRef<GetObjects, BaseVariantWrapper>                TestComplete::Objects;\
  CLazyRef<GetOCR, BaseVariantWrapper>          TestComplete::OCR;\
  CLazyRef<GetODT, BaseVariantWrapper>          TestComplete::ODT;\
  CLazyRef<GetOptions, BaseVariantWrapper>				TestComplete::Options;\
  CLazyRef<GetProject, BaseVariantWrapper>                TestComplete::Project;\
  CLazyRef<GetProjectSuite, BaseVariantWrapper>           TestComplete::ProjectSuite;\
  CLazyRef<GetRegions, BaseVariantWrapper>                TestComplete::Regions;\
  CLazyRef<GetRunner, BaseVariantWrapper>                 TestComplete::Runner;\
  CLazyRef<GetSys, BaseVariantWrapper>                    TestComplete::Sys;\
  CLazyRef<GetStorages, BaseVariantWrapper>               TestComplete::Storages;\
  CLazyRef<GetTestedApps, BaseVariantWrapper>             TestComplete::TestedApps;\
  CLazyRef<GetTestSuites, BaseVariantWrapper>           TestComplete::TestSuites;\
  CLazyRef<GetUtilities, BaseVariantWrapper>              TestComplete::Utilities;\
  CLazyRef<GetUtils, BaseVariantWrapper>          TestComplete::Utils;\
  CLazyRef<GetWin32API, BaseVariantWrapper>               TestComplete::Win32API;\
  CLazyRef<GetNameMapping, BaseVariantWrapper>			TestComplete::NameMapping;\
  CLazyRef<GetAliases, BaseVariantWrapper>			TestComplete::Aliases;\
  CLazyRef<GetConsts, BaseVariantWrapper>				TestComplete::Consts;

} //namespace TestComplete



#endif // !defined(SCRIPT_H__5061756C_536F_6C6F_646B_792054756C61__INCLUDED_)


