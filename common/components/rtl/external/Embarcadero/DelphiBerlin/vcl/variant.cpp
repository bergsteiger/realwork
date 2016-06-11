/////////////////////////////////////////////////////////////////////////////
// variant.cpp - support for Delphi variants in C++
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
/////////////////////////////////////////////////////////////////////////////

#include <System.hpp>
#include <System.VarUtils.hpp>
#include <System.Internal.VarHlpr.hpp>
#include <string.h>
#include <limits.h>

#if defined(VARIANT_AUTOMATION_SUPPORT)
  #include <System.SysConst.hpp>
#endif

#if defined(_Windows)
  #include <oaidl.h>
  #if defined(VARIANT_AUTOMATION_SUPPORT)  
    #include <comobj.hpp>
  #endif 
  #include <oleauto.h>
#endif

#include <System.Variants.hpp>
#include <utilcls.h>

#ifndef _ASSERTE
  #include <assert.h>
  #define _ASSERTE(x) assert(x)
#endif

#if !defined(VARIANT_NATIVE_SUPPORT)
  const BOOL VARIANT_FALSE = 0;
  const BOOL VARIANT_TRUE = 65535;
#endif // VARIANT_NATIVE_SUPPORT

// Treat 'long' as either a 32-bit or 64-bit type as appropriate
#if defined(_LP64) 
  #define Variant_varLong varInt64
  #define Variant_varULong varUInt64
  #define Variant_VLong VInt64
  #define Variant_VULong VUInt64
#else
  #define Variant_varLong varInteger
  #define Variant_varULong varLongWord
  #define Variant_VLong VInteger
  #define Variant_VULong VLongWord
#endif

#define VARIANT_AS_TVARDATA(x) x

// InitVariant initializes the variant, and then clears the largest field in
// the union.  This is to ensure that uninitialized data there doesn't get
// interpreted as valid in certain cases, notably, when we cast variant
// objects around before they have been fully instantiated.  In the long
// run, we will do away with the casting and this function can skip
// initializing the union.
static inline void InitVariant(TVarData &vd)
{
  System::Varutils::VariantInit(vd);
  vd.VInt64 = 0;
}

namespace System
{
#if defined(VARIANT_AUTOMATION_SUPPORT)
  Variant __fastcall Variant::CreateObject(const System::String& ProgID)
  {
    return Variant(System::Win::Comobj::CreateOleObject(const_cast<System::String&>(ProgID)));
  }

  Variant __fastcall Variant::GetActiveObject(const System::String& ProgID)
  {
    return Variant(System::Win::Comobj::GetActiveOleObject(const_cast<System::String&>(ProgID)));
  }

  Variant& Variant::NoParam()
  {
    VariantError err;
    #pragma option push -w-8104
    static Variant _noParam(err);
    #pragma option pop
    _ASSERTE(_noParam.VType == VT_ERROR);
    _ASSERTE(V_ERROR(&_noParam) == DISP_E_PARAMNOTFOUND);
    return _noParam;
  }
#endif // VARIANT_AUTOMATION_SUPPORT

  Variant& Variant::Empty()
  {
    #pragma option push -w-8104
    static Variant _empty;
    #pragma option pop
    _ASSERTE(_empty.VType == varEmpty);
    return _empty;
  }

  // Ctr - From Variants
  __fastcall Variant::Variant()
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
  }

  __fastcall Variant::Variant(const Variant& rhs)
  {
    // Handle case where this == &rhs (_VarAddRef)
    // NOTE: This copy *MUST* happen before the VARIANTINIT call
    //       because if the compiler calls with this=&rhs, we'll
    //       be wiping out our source!!
    char copy[sizeof(Variant)];
    memcpy(&copy, &rhs, sizeof(copy));

    InitVariant(VARIANT_AS_TVARDATA(*this));

    // Use Delphi assignment operator
    System::Internal::Varhlpr::VariantCpy(*(reinterpret_cast<Variant*>(&copy)), *this);
  }

  __fastcall Variant::Variant(const TVarData& rhs)
  {
    char copy[sizeof(TVarData)];
    memcpy(&copy, &rhs, sizeof(copy));

    InitVariant(VARIANT_AS_TVARDATA(*this));

    System::Internal::Varhlpr::VariantCpy(*(reinterpret_cast<Variant*>(&copy)), *this);
  }

#if defined(VARIANT_TVARIANT_SUPPORT)
  __fastcall Variant::Variant(const TVariant& rhs)
  {
    ::VariantInit(reinterpret_cast<VARIANTARG*>(this));
    OLECHECK(::VariantCopy(reinterpret_cast<VARIANTARG *>(this), const_cast<TVariant*>(&rhs)));
  }
#endif

  inline void __fastcall Variant::SetType(uint16_t vt, bool init)
  {
    if (init)
      InitVariant(VARIANT_AS_TVARDATA(*this));
    else
      Clear();
    VType = vt;
  }

  inline void __fastcall Variant::SetRefType(uint16_t vt, void *p, bool init)
  {
    SetType(vt|varByRef, init);
    VPointer = p;
  }

  // Ctr - From basic C++ types
  __fastcall Variant::Variant(const bool src)
  {
    SetType(varBoolean, true);
    VBoolean = src ? VARIANT_TRUE : VARIANT_FALSE;
  }

  __fastcall Variant::Variant(const char src)
  {
    SetType(varShortInt, true);
    VShortInt = src;
  }

  __fastcall Variant::Variant(const signed char src)
  {
    SetType(varShortInt, true);
    VShortInt = src;
  }

  __fastcall Variant::Variant(const unsigned char src)
  {
    SetType(varByte, true);
    VByte = src;
  }

  __fastcall Variant::Variant(const short src)
  {
    SetType(varSmallint, true);
    VSmallint = src;
  }

  __fastcall Variant::Variant(const unsigned short src)
  {
    SetType(varWord, true);
    VWord = src;
  }

  __fastcall Variant::Variant(const int src)
  {
    SetType(varInteger, true);
    VInteger = src;
  }

  __fastcall Variant::Variant(const unsigned int src)
  {
    SetType(varLongWord, true);
    VLongWord = src;
  }

  __fastcall Variant::Variant(const long src)
  {
    SetType(Variant_varLong, true);
    Variant_VLong = src;
  }

  __fastcall Variant::Variant(const unsigned long src)
  {
    SetType(Variant_varULong, true);
    Variant_VLong = src;
  }

  __fastcall Variant::Variant(const float src)
  {
    SetType(varSingle, true);
    VSingle = src;
  }

  __fastcall Variant::Variant(const double src)
  {
    SetType(varDouble, true);
    VDouble = src;
  }

  __fastcall Variant::Variant(const long double src)
  {
    SetType(varDouble, true);
    VDouble = src;
  }

  __fastcall Variant::Variant(const __int64 src)
  {
    SetType(varInt64, true);
    VInt64 = src;
  }
  
  __fastcall Variant::Variant(const unsigned __int64 src)
  {
    SetType(varUInt64, true);
    VUInt64 = src;
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  // Ctr - From OLE Structures
  __fastcall Variant::Variant(const VARIANT& src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    OLECHECK(::VariantCopy(reinterpret_cast<VARIANT*>(this), const_cast<VARIANT*>(&src)));
  }

  __fastcall Variant::Variant(const CURRENCY& src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    SET_VTYPE_AND_VAR(CY, src);
  }

  __fastcall Variant::Variant(const DECIMAL& src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    V_DECIMAL(reinterpret_cast<VARIANT*>(this)) = src;
    V_VT(this) = VT_DECIMAL;
  }

  __fastcall Variant::Variant(const SAFEARRAY& src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));

    VARTYPE _vt;
    ::SafeArrayGetVartype(const_cast<SAFEARRAY*>(&src), &_vt);
    VType = VT_ARRAY|_vt;

    V_ARRAY(this) = const_cast<SAFEARRAY*>(&src);
  }

  __fastcall Variant::Variant(SAFEARRAY* src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));

    VARTYPE _vt;
    ::SafeArrayGetVartype(src, &_vt);
    VType = VT_ARRAY|_vt;

    V_ARRAY(this) = src;
  }

  __fastcall Variant::Variant(VARIANT* src)
  {
    ::VariantInit(reinterpret_cast<VARIANTARG*>(this));

    if (src && (src->vt != VT_VARIANT) && (src->vt != (VT_VARIANT|VT_BYREF))) {
      SET_VTYPE_AND_VARREF(VARIANT, src);
    } else {
      //
      OLECHECK(::VariantCopy(reinterpret_cast<VARIANTARG *>(this), src));
    }
  }
#endif // VARIANT_NATIVE_SUPPORT

  // Ctr - From Utility classes
  // NOTE: This is not OLE compatible (i.e. True VARIANT cannot hold on to an
  //       MBCS string. You must ensure that this Variant is not sent to OLE
  //       in an Invoke call for example. The late-bound functions (Exec,
  //       OleProcedure, OleFunction etc.) exposed by the Variant class
  //       ensures that the string is widened. The code generated by importing
  //       TypeLibraries never utilizes AnsiString. So, in general, we should
  //       be safe.
  //
  __fastcall Variant::Variant(const AnsiString& src)
  {
#if !defined(_DELPHI_NEXTGEN) 
    SetType(varString, true);
    VString = 0;
    (AnsiString&)VString = src;
#else 
    // FIXME
#endif
  }

  __fastcall Variant::Variant(const Currency& src)
  {
    SetType(varCurrency, true);
    VCurrency = src;
  }

  __fastcall Variant::Variant(const TDateTime& src)
  {
    SetType(varDate, true);
    VDate = src;
  }

#if defined(VARIANT_ERROR_SUPPORT)
  __fastcall Variant::Variant(const VariantError& src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    SET_VTYPE_AND_VAR(ERROR, src);
  }
#endif

#if !defined(_DELPHI_NEXTGEN)
  __fastcall Variant::Variant(const WideString& src)
  {
    SetType(varOleStr, true);
    (WideString&)VOleStr = src;
  }
#endif  

  __fastcall Variant::Variant(const UnicodeString& src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    System::Internal::Varhlpr::VariantFromUnicodeString(*this, src);
  }


  // Ctr - Asciiz Pointer
  // We currently treat 'const char*' as a string.
  // However, it could also be viewed as a character by reference!!!!
  __fastcall Variant::Variant(const char* src)
  {
#if !defined(_DELPHI_NEXTGEN) 
    SetType(varString, true);
    (AnsiString&)VString = src;
#else 
    SetType(varUString, true);
    (UnicodeString&)VString = src;
#endif
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  __fastcall Variant::Variant(wchar_t* src, bool makeCopy)
  {
    SetType(varOleStr, true);
#if !defined(_DELPHI_NEXTGEN) 
    bstrVal = makeCopy ? WideString::Copy(src) : src;
#else 
    // FIXME
#endif
  }
#endif  

  __fastcall Variant::Variant(IDispatch* src)
  {
    SetType(varDispatch, true);
    if (src)
      src->AddRef();
    VDispatch = src;
  }

  __fastcall Variant::Variant(IUnknown* src)
  {
    SetType(varUnknown, true);
    if (src)
      src->AddRef();
    VUnknown = src;
  }


  __fastcall Variant::Variant(signed char* src)
  {
    SetRefType(varShortInt, src, true);
  }

  __fastcall Variant::Variant(unsigned char* src)
  {
    SetRefType(varByte, src, true);
  }

  __fastcall Variant::Variant(short* src)
  {
    SetRefType(varSmallint, src, true);
  }

  __fastcall Variant::Variant(unsigned short* src)
  {
    SetRefType(varWord, src, true);
  }

  __fastcall Variant::Variant(int* src)
  {
    SetRefType(varInteger, src, true);
  }

  __fastcall Variant::Variant(unsigned int* src)
  {
    SetRefType(varLongWord, src, true);
  }

  __fastcall Variant::Variant(long* src)
  {
    SetRefType(Variant_varLong, src, true);
  }

  __fastcall Variant::Variant(unsigned long* src)
  {
    SetRefType(Variant_varULong, src, true);
  }

  __fastcall Variant::Variant(float* src)
  {
    SetRefType(varSingle, src, true);
  }

  __fastcall Variant::Variant(double* src)
  {
    SetRefType(varDouble, src, true);
  }

  __fastcall Variant::Variant(__int64* src)
  {
    SetRefType(varInt64, src, true);
  }

  __fastcall Variant::Variant(unsigned __int64* src)
  {
    SetRefType(varUInt64, src, true);
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  __fastcall Variant::Variant(CURRENCY* src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    SET_VTYPE_AND_VARREF(CY, src);
  }

  __fastcall Variant::Variant(DECIMAL* src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    V_DECIMALREF(reinterpret_cast<VARIANT*>(this)) = src;
    V_VT(this) = VT_DECIMAL|VT_BYREF; 
  }

  __fastcall Variant::Variant(SAFEARRAY** src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));

    VARTYPE _vt;
    ::SafeArrayGetVartype(*src, &_vt);
    VType = VT_ARRAY|VT_BYREF|_vt;
    V_ARRAYREF(this) = src;
    SET_VTYPE_AND_VARREF(ARRAY, src);
  }
#endif // VARIANT_NATIVE_SUPPORT

#if defined(WIDECHAR_IS_WCHAR)
  __fastcall Variant::Variant(wchar_t** src)        // VT_BSTR|VT_BYREF
  {
    SetRefType(varOleStr, src, true);
  }
#endif

  // Ctr - Ref Utility classes
  __fastcall Variant::Variant(Currency* src)
  {
    SetRefType(varCurrency, src, true);
  }

  __fastcall Variant::Variant(TDateTime* src)
  {
    SetRefType(varDate, src, true);
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  __fastcall Variant::Variant(Variant* src)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    SET_VTYPE_AND_VARREF(VARIANT, reinterpret_cast<VARIANTARG*>(src));
  }
#endif

  // Ctr - Arrays
  // Construct a Variant array of type varType
  //
  // For example: Variant ArrayVar(OPENARRAY(int, (0, 0)), varVariant);
  //              Varaint ArrayVar(OpenArray<int>(0, 0)), OpenArrayCount<int>(0, 0).GetHigh(), varVariant);
  __fastcall Variant::Variant(const int* bounds, const int boundsSize, Word varType)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    *this = Variants::VarArrayCreate(bounds, boundsSize, varType);
  }

  // Construct a one dimensional Variant array of type varVariant
  // and fill with values
  __fastcall Variant::Variant(const Variant* values, const int valuesSize)
  {
    InitVariant(VARIANT_AS_TVARDATA(*this));
    *this = Variants::VarArrayOf(values, valuesSize);
  }

  __fastcall Variant::Variant(const System::DelphiInterface<IDispatch>& src)
  {
    SetType(varDispatch, true);
    if (src)
      src->AddRef();
    VDispatch = src;
  }

  // Dtr
  __fastcall Variant::~Variant()
  {
    Clear();
  }

  // Typical nothrow swap operation (for easier use of copy & swap)
  void __fastcall Variant::swap(Variant& rhs)
  {
    char temp[sizeof(Variant)];
    memcpy(temp, this, sizeof(Variant));
    memcpy(this, &rhs, sizeof(Variant));
    memcpy(&rhs, temp, sizeof(Variant));
  }

  // Assignments
  //
  Variant& __fastcall Variant::operator =(const Variant& rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(const bool rhs)
  {
    SetType(varBoolean, false);
    VBoolean = rhs ? VARIANT_TRUE : VARIANT_FALSE;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const char rhs)
  {
    SetType(varShortInt, false);
    VShortInt = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const signed char rhs)
  {
    SetType(varShortInt, false);
    VShortInt = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const unsigned char rhs)
  {
    SetType(varByte, false);
    VByte = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const short rhs)
  {
    SetType(varSmallint, false);
    VSmallint = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const unsigned short rhs)
  {
    SetType(varWord, false);
    VWord = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const int rhs)
  {
    SetType(varInteger, false);
    VInteger = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const unsigned int rhs)
  {
    SetType(varLongWord, false);
    VLongWord = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const long rhs)
  {
    SetType(Variant_varLong, false);
    Variant_VLong = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const unsigned long rhs)
  {
    SetType(Variant_varULong, false);
    Variant_VLong = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const float rhs)
  {
    SetType(varSingle, false);
    VSingle = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const double rhs)
  {
    SetType(varDouble, false);
    VDouble = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const __int64 rhs)
  {
    SetType(varInt64, false);
    VInt64 = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const unsigned __int64 rhs)
  {
    SetType(varUInt64, false);
    VUInt64 = rhs;
    return *this;
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  Variant& __fastcall Variant::operator =(const CURRENCY& rhs)
  {
    Clear();
    SET_VTYPE_AND_VAR(CY, rhs);
    return *this;
  }

  Variant& __fastcall Variant::operator =(const DECIMAL& rhs)
  {
    Clear();
    V_DECIMAL(reinterpret_cast<VARIANT*>(this)) = rhs;
    V_VT(this) = VT_DECIMAL;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const SAFEARRAY& rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(SAFEARRAY* rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(const VARIANT& rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(VARIANT *rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }
#endif // VARIANT_NATIVE_SUPPORT

#if defined(VARIANT_TVARIANT_SUPPORT)
  Variant& __fastcall Variant::operator =(const TVariant& rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(TVariant *rhs)
  {
    return this->operator=(static_cast<VARIANT*>(rhs));
  }

#endif

#if defined(WIDECHAR_IS_WCHAR)
  Variant& __fastcall Variant::Assign(wchar_t* rhs, bool makeCopy)
  {
#if !defined(_DELPHI_NEXTGEN)
    SetType(varOleStr, false);
    VOleStr = makeCopy ? WideString::Copy(rhs) : rhs;
#else 
    // FIXME
#endif
    return *this;
  }
#endif

  Variant& __fastcall Variant::operator =(IUnknown* rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(IDispatch* rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(const AnsiString& rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(const Currency& rhs)
  {
    SetType(varCurrency, false);
    VCurrency = rhs;
    return *this;
  }

  Variant& __fastcall Variant::operator =(const TDateTime& rhs)
  {
    SetType(varDate, false);
    VDate = rhs;
    return *this;
  }

#if defined(VARIANT_ERROR_SUPPORT)
  Variant& __fastcall Variant::operator =(const VariantError& rhs)
  {
    Clear();
    SET_VTYPE_AND_VAR(ERROR, rhs);
    return *this;
  }
#endif

#if !defined(_DELPHI_NEXTGEN)
  Variant& __fastcall Variant::operator =(const WideString& rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }
#endif  

  Variant& __fastcall Variant::operator =(const UnicodeString& src)
  {
    System::Internal::Varhlpr::VariantFromUnicodeString(*this, src);
    return *this;
  }

  Variant& __fastcall Variant::operator =(const System::DelphiInterface<IDispatch>& rhs)
  {
    // NOTE: Relies on fact that operat T*() of DelphiInterface does not AddRef!!
    return this->operator=((IDispatch*)(rhs));
  }


  Variant& __fastcall Variant::operator =(const char* rhs)            // Treated as pointer Asciiz string
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(signed char* src)
  {
    SetRefType(varShortInt, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(unsigned char* src)
  {
    SetRefType(varByte, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(short* src)
  {
    SetRefType(varSmallint, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(unsigned short* src)
  {
    SetRefType(varWord, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(int* src)
  {
    SetRefType(varInteger, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(unsigned int* src)
  {
    SetRefType(varLongWord, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(long* src)
  {
    SetRefType(Variant_varLong, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(unsigned long* src)
  {
    SetRefType(Variant_varULong, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(float* src)
  {
    SetRefType(varSingle, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(double* src)
  {
    SetRefType(varDouble, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(__int64* src)
  {
    SetRefType(varInt64, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(unsigned __int64* src)
  {
    SetRefType(varUInt64, src, false);
    return *this;
  }

#ifdef VARIANT_NATIVE_SUPPORT
  Variant& __fastcall Variant::operator =(CURRENCY* src)
  {
    Clear();
    SET_VTYPE_AND_VARREF(CY, src);
    return *this;
  }

  Variant& __fastcall Variant::operator =(DECIMAL* rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }

  Variant& __fastcall Variant::operator =(SAFEARRAY** rhs)
  {
    Variant newVal(rhs);
    swap(newVal);
    return *this;
  }
#endif

#if defined(WIDECHAR_IS_WCHAR)
  Variant& __fastcall Variant::operator =(WideChar** src)
  {
    SetRefType(varOleStr, src, false);
    return *this;
  }
#endif

  Variant& __fastcall Variant::operator =(IUnknown** src)
  {
    SetRefType(varUnknown, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(IDispatch** src)
  {
    SetRefType(varDispatch, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(IInterface** src)
  {
    SetRefType(varUnknown, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(Currency* src)
  {
    SetRefType(varCurrency, src, false);
    return *this;
  }

  Variant& __fastcall Variant::operator =(TDateTime* src)
  {
    SetRefType(varDate, src, false);
    return *this;
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  Variant& __fastcall Variant::operator =(Variant* src)
  {
    Clear();
    SET_VTYPE_AND_VARREF(VARIANT, reinterpret_cast<VARIANTARG*>(src));
    return *this;
  }
#endif


  Variant& __fastcall Variant::operator +=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantAdd(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator -=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantSub(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator *=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantMul(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator /=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantDiv(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator %=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantMod(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator &=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantAnd(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator |=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantOr(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator ^=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantXor(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator <<=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantShl(src, *this);
    return *this;
  }

  Variant& __fastcall Variant::operator >>=(const Variant& src)
  {
    System::Internal::Varhlpr::VariantShr(src, *this);
    return *this;
  }

  bool __fastcall Variant::operator ==(const Variant& src) const
  {
    return Variants::VarCompareValue(*this, src) == Variants::vrEqual;
  }

  bool __fastcall Variant::operator !=(const Variant& src) const
  {
    return Variants::VarCompareValue(*this, src) != Variants::vrEqual;
  }

  bool __fastcall Variant::operator <(const Variant& rhs) const
  {
    // Handle some stuff on C++ side (BCB-40469, BCB-13561)
    //
    if (VType == rhs.VType)
    {
      switch (VType)
      {
        case varShortInt:   return VShortInt < rhs.VShortInt;
        case varByte:       return VByte     < rhs.VByte;
        case varSmallint:   return VSmallint < rhs.VSmallint;
        case varWord:       return VWord     < rhs.VWord;
        case varInteger:    return VInteger  < rhs.VInteger;
        case varLongWord:   return VLongWord < rhs.VLongWord;
        case varInt64:      return VInt64    < rhs.VInt64;
        case varUInt64:     return VUInt64   < rhs.VUInt64;
        case varSingle:     return VSingle   < rhs.VSingle;
        case varDouble:     return VDouble   < rhs.VDouble;
        default:            break;
      }
    }

    return Variants::VarCompareValue(*this, rhs) == Variants::vrLessThan;
  }

  bool __fastcall Variant::operator >(const Variant& rhs) const
  {
    // Handle some stuff on C++ side (BCB-40469, BCB-13561)
    //
    if (VType == rhs.VType)
    {
      switch (VType)
      {
        case varShortInt:   return VShortInt > rhs.VShortInt;
        case varByte:       return VByte     > rhs.VByte;
        case varSmallint:   return VSmallint > rhs.VSmallint;
        case varWord:       return VWord     > rhs.VWord;
        case varInteger:    return VInteger  > rhs.VInteger;
        case varLongWord:   return VLongWord > rhs.VLongWord;
        case varInt64:      return VInt64    > rhs.VInt64;
        case varUInt64:     return VUInt64   > rhs.VUInt64;
        case varSingle:     return VSingle   > rhs.VSingle;
        case varDouble:     return VDouble   > rhs.VDouble;
        default:            break;
      }
    }

    return Variants::VarCompareValue(*this, rhs) == Variants::vrGreaterThan;
  }


  bool __fastcall Variant::operator <=(const Variant& rhs) const
  {
    return !operator >(rhs);
  }

  bool __fastcall Variant::operator >=(const Variant& rhs) const
  {
    return !operator <(rhs);
  }

// For cases where the two variants are of the same type, we can
// implement some operations on the C++ side
#define VAR_SIMPLE_OP( op ) \
    if (VType == rhs.VType) \
    {                       \
      switch (VType)        \
      {                     \
        case varShortInt:   return VShortInt op rhs.VShortInt; \
        case varByte:       return VByte     op rhs.VByte;     \
        case varSmallint:   return VSmallint op rhs.VSmallint; \
        case varWord:       return VWord     op rhs.VWord;     \
        case varInteger:    return VInteger  op rhs.VInteger;  \
        case varLongWord:   return VLongWord op rhs.VLongWord; \
        case varInt64:      return VInt64    op rhs.VInt64;    \
        case varUInt64:     return VUInt64   op rhs.VUInt64;   \
        default:            break;                             \
      }                                                        \
    }

  Variant __fastcall Variant::operator +(const Variant& rhs) const
  {
    return System::Internal::Varhlpr::VariantAdd2(*this, rhs);
  }

  Variant __fastcall Variant::operator -(const Variant& rhs) const
  {
    VAR_SIMPLE_OP( - );
    return System::Internal::Varhlpr::VariantSub2(*this, rhs);
  }

  Variant __fastcall Variant::operator *(const Variant& rhs) const
  {
    return System::Internal::Varhlpr::VariantMul2(*this, rhs);
  }

  Variant __fastcall Variant::operator /(const Variant& rhs) const
  {
    VAR_SIMPLE_OP( / );
    return System::Internal::Varhlpr::VariantDiv2(*this, rhs);
  }

  Variant __fastcall Variant::operator %(const Variant& rhs) const
  {
    VAR_SIMPLE_OP( % );
    return System::Internal::Varhlpr::VariantMod2(*this, rhs);
  }

  Variant __fastcall Variant::operator &(const Variant& rhs) const
  {
    VAR_SIMPLE_OP( & );
    return System::Internal::Varhlpr::VariantAnd2(*this, rhs);
  }

  Variant __fastcall Variant::operator |(const Variant& rhs) const
  {
    return System::Internal::Varhlpr::VariantOr2(*this, rhs);
  }

  Variant __fastcall Variant::operator ^(const Variant& rhs) const
  {
    return System::Internal::Varhlpr::VariantXor2(*this, rhs);
  }

  Variant __fastcall Variant::operator <<(const Variant& rhs) const
  {
    VAR_SIMPLE_OP( << );
    return System::Internal::Varhlpr::VariantShl2(*this, rhs);
  }

  Variant __fastcall Variant::operator >>(const Variant& rhs) const
  {
    VAR_SIMPLE_OP( >> );
    return System::Internal::Varhlpr::VariantShr2(*this, rhs);
  }

  Variant __fastcall Variant::operator -() const
  {
    return System::Internal::Varhlpr::VariantNeg(*this);
  }

  Variant __fastcall Variant::operator !() const
  {
    return System::Internal::Varhlpr::VariantNot(*this);
  }

  // Conversion operators

  __fastcall Variant::operator bool() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varBoolean);
    return tmp.VBoolean != VARIANT_FALSE;
  }

  __fastcall Variant::operator char() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varShortInt);
    return tmp.VShortInt;
  }

  __fastcall Variant::operator signed char() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varShortInt);
    return tmp.VShortInt;
  }

  __fastcall Variant::operator unsigned char() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varByte);
    return tmp.VByte;
  }

  __fastcall Variant::operator short() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varSmallint);
    return tmp.VSmallint;
  }

  __fastcall Variant::operator unsigned short() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varWord);
    return tmp.VWord;
  }

  __fastcall Variant::operator int() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varInteger);
    return tmp.VInteger;
  }

  __fastcall Variant::operator unsigned int() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varLongWord);
    return tmp.VLongWord;
  }

  __fastcall Variant::operator long() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, Variant_varLong);
    return tmp.Variant_VLong;
  }

  __fastcall Variant::operator unsigned long() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, Variant_varULong);
    return tmp.Variant_VLong;
  }

  __fastcall Variant::operator float() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varSingle);
    return tmp.VSingle;
  }

  __fastcall Variant::operator double() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varDouble);
    return tmp.VDouble;
  }

#if !defined(_DELPHI_NEXTGEN)
  __fastcall Variant::operator AnsiString() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varString);
    return AnsiString((AnsiString&)(tmp.VString));
  }
#endif

  __fastcall Variant::operator __int64() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varInt64);
    return tmp.VInt64;
  }
  
  __fastcall Variant::operator unsigned __int64() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varUInt64);
    return tmp.VUInt64;
  }
  
  __fastcall Variant::operator Currency() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varCurrency);
    return tmp.VCurrency;
  }

  __fastcall Variant::operator TDateTime() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varDate);
    return tmp.VDate;
  }

#if !defined(_DELPHI_NEXTGEN)
  __fastcall Variant::operator WideString() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varOleStr);
    return tmp.VOleStr;
  }
#endif

  __fastcall Variant::operator UnicodeString() const
  {
    UnicodeString str;
    System::Internal::Varhlpr::VariantToUnicodeString(*this, str);
    return str;
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  __fastcall Variant::operator CURRENCY() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, VT_CY);
    return V_CY(&tmp);
  }

  __fastcall Variant::operator DECIMAL() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, VT_DECIMAL);
    return V_DECIMAL(reinterpret_cast<VARIANT*>(&tmp));
  }

  __fastcall Variant::operator VARIANT()
  {
    VARIANT tmp;
    ::VariantInit(&tmp);

#if !defined(_DELPHI_NEXTGEN)
    // Handle case where 'Variant' contains non-COM-standard strings
    //
    if (Type() == varString)
    {
      AnsiString astr = *this;
      WideString wstr(astr);
      V_BSTR(&tmp) = wstr.Detach();
      tmp.vt = VT_BSTR;
    }
    else if (Type() == varUString)
    {
      UnicodeString ustr = *this;
      WideString wstr(ustr);
      V_BSTR(&tmp) = wstr.Detach();
      tmp.vt = VT_BSTR;
    }
    else
#endif    
      OLECHECK(::VariantCopy(&tmp, reinterpret_cast<VARIANTARG*>(this)));

    return tmp;
  }
#endif // VARIANT_NATIVE_SUPPORT
#ifdef VARIANT_TVARIANT_SUPPORT

  __fastcall Variant::operator TVariant()
  {
    return TVariant(*(reinterpret_cast<VARIANT*>(this)));
  }
#endif

#if defined(WIDECHAR_IS_WCHAR)
  __fastcall Variant::operator wchar_t*() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varOleStr);
#if defined(WIDESTRING_IS_BSTR)
    return WideString::Copy(tmp.bstrVal);
#else
    return tmp.VOleStr;
#endif
  }
#endif

  __fastcall Variant::operator IDispatch*()
  {
    return VariantIntfExtract<Variant>::GetIDispatch(*this);
  }

  __fastcall Variant::operator IUnknown*()
  {
    return VariantIntfExtract<Variant>::GetIUnknown(*this);
  }

  __fastcall Variant::operator IInterface*()
  {
    IUnknown* retval = VariantIntfExtract<Variant>::GetIUnknown(*this);
    return reinterpret_cast<IInterface*>(retval);
  }

  // By ref conversion operators

  void __fastcall Variant::CastError(uint16_t vt)
  {
    Variants::VarCastError(VType, vt);
  }

  __fastcall Variant::operator signed char*()
  {
    signed char *rc = static_cast<signed char *>(VPointer);
    if (VType != (varShortInt|varByRef))
    {
      if (VType == varShortInt)
        rc = &VShortInt;
      else
        CastError(varShortInt|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator unsigned char*()
  {
    unsigned char *rc = static_cast<unsigned char *>(VPointer);
    if (VType != (varByte|varByRef))
    {
      if (VType == varByte)
        rc = &VByte;
      else
        CastError(varByte|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator short*()
  {
    short *rc = static_cast<short *>(VPointer);
    if (VType != (varSmallint|varByRef))
    {
      if (VType == varSmallint)
        rc = &VSmallint;
      else
        CastError(varSmallint|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator unsigned short*()
  {
    unsigned short *rc = static_cast<unsigned short *>(VPointer);
    if (VType != (varWord|varByRef))
    {
      if (VType == varWord)
        rc = &VWord;
      else
        CastError(varWord|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator int*()
  {
    int *rc = static_cast<int *>(VPointer);
    if (VType != (varInteger|varByRef))
    {
      if (VType == varInteger)
        rc = &VInteger;
      else
        CastError(varInteger|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator unsigned int*()
  {
    unsigned int *rc = static_cast<unsigned int *>(VPointer);
#if !defined(_PLAT_IOS64) // FIXME-_PLAT_IOS64
    if (VType != (varLongWord|varByRef))
    {
      if (VType == varLongWord)
        rc = &VLongWord;
      else
        CastError(varLongWord|varByRef);
    }
#endif    
    return rc;
  }

  __fastcall Variant::operator long*()
  {
    long *rc = static_cast<long *>(VPointer);
    if (VType != (Variant_varLong|varByRef))
    {
      if (VType == Variant_varLong)
        rc = reinterpret_cast<long*>(&Variant_VLong);
      else
        CastError(Variant_varLong|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator unsigned long*()
  {
    unsigned long *rc = static_cast<unsigned long *>(VPointer);
    if (VType != (Variant_varULong|varByRef))
    {
      if (VType == Variant_varULong)
        rc = reinterpret_cast<unsigned long*>(&Variant_VULong);
      else
        CastError(Variant_varULong|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator float*()
  {
    float *rc = static_cast<float *>(VPointer);
    if (VType != (varSingle|varByRef))
    {
      if (VType == varSingle)
        rc = &VSingle;
      else
        CastError(varSingle|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator double*()
  {
    double *rc = static_cast<double *>(VPointer);
    if (VType != (varDouble|varByRef))
    {
      if (VType == varDouble)
        rc = &VDouble;
      else
        CastError(varDouble|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator __int64*()
  {
    __int64 *rc = static_cast<__int64 *>(VPointer);
    if (VType != (varInt64|varByRef))
    {
      if (VType == varInt64)
        rc = &VInt64;
      else
        CastError(varInt64|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator unsigned __int64*()
  {
    unsigned __int64 *rc = static_cast<unsigned __int64 *>(VPointer);
    if (VType != (varUInt64|varByRef))
    {
      if (VType == varUInt64)
        rc = &VUInt64;
      else
        CastError(varUInt64|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator Currency*()
  {
    Currency *rc = static_cast<Currency *>(VPointer);
    if (VType != (varCurrency|varByRef))
    {
      if (VType == varCurrency)
        rc = static_cast<Currency*>(&VCurrency);
      else
        CastError(varCurrency|varByRef);
    }
    return rc;
  }

  __fastcall Variant::operator TDateTime*()
  {
    TDateTime *rc = static_cast<TDateTime *>(VPointer);
    if (VType != (varDate|varByRef))
    {
      if (VType == varDate)
        rc = static_cast<TDateTime*>(&VDate);
      else
        CastError(varDate|varByRef);
    }
    return rc;
  }

#if defined(WIDECHAR_IS_WCHAR)
  __fastcall Variant::operator wchar_t**()
  {
    WideChar** rc = static_cast<wchar_t **>(VPointer);
    if (VType != (varOleStr|varByRef))
    {
      if (VType == varOleStr)
        rc = &VOleStr;
      else
        CastError(varOleStr|varByRef);
    }
    return rc;
  }
#endif

#if defined(VARIANT_AUTOMATION_SUPPORT)
  __fastcall Variant::operator VARIANT*()
  {
    if (vt == (VT_VARIANT|VT_BYREF)) {
      return V_VARIANTREF(this);
    }

    return reinterpret_cast<VARIANT*>(GetBaseVariant());
  }

  __fastcall Variant::operator LPSAFEARRAY()
  {
    if (V_ISARRAY(this)) {
      return V_ARRAY(this);
    }
    CastError(VT_ARRAY);
    return 0;
  }
#endif  // VARIANT_AUTOMATION_SUPPORT

#if defined(VARIANT_TVARIANT_SUPPORT)
  __fastcall Variant::operator TVariant*()
  {
    return reinterpret_cast<TVariant*>((VARIANT*)(*this));
  }
#endif

  void __fastcall Variant::SetError(const HResult err)
  {
    SetType(varError, false);
    VError = err;
  }

  HResult __fastcall Variant::GetError() const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varError);
    return tmp.VError;
  }

#if defined(VARIANT_NATIVE_SUPPORT)
  // Returns pointer to base Variant type when Variant holds other Variant
  //
  Variant* __fastcall Variant::GetBaseVariant()
  {
    Variant *pVar = this;

    // NOTE: Technically there could only be one level of indirection for VT_VARIANT
    //       Additionally, VT_VARIANT should always be used in combination with VT_BYREF
    //       However, it does not hurt to catch multiple indirection or check a simple
    //       VT_VARIANT VARTYPE. Never know what's being packed and sent down out there
    //
    while (((pVar->VType == VT_VARIANT) || (pVar->VType == (VT_VARIANT|VT_BYREF))) && (V_VARIANTREF(pVar)))
      pVar = reinterpret_cast<Variant*>(V_VARIANTREF(pVar));
    return pVar;
  }
#endif

  Variant& __fastcall Variant::ChangeType(int varType)
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varType);
    return *this = tmp;
  }

  Variant __fastcall Variant::AsType(int varType) const
  {
    Variant tmp;
    System::Internal::Varhlpr::VariantCast(*this, tmp, varType);
    return tmp;
  }

  Variant __fastcall Variant::Sanitized() const
  {
#if defined(VARIANT_NATIVE_SUPPORT)
    Variant tmp;
 #if !defined(_DELPHI_NEXTGEN)
    // varString & varUString won't work with COM
    if (vt == varString)
    {
      AnsiString astr = *this;
      WideString wstr(astr);
      tmp = wstr;
    }
    else if (vt == varUString)
    {
      UnicodeString ustr = *this;
      WideString wstr(ustr);
      tmp = wstr;
    }
    else
 #endif
    {
      tmp = *this;
    }
    return tmp;
#else
    return *this;
#endif
  }

  void __fastcall Variant::Clear()
  {
    System::Internal::Varhlpr::VariantClear(*this);
  }

  int __fastcall Variant::Type() const
  {
    return Variants::VarType(*this);
  }

  bool __fastcall Variant::IsNull() const
  {
    return Variants::VarIsNull(*this);
  }

  bool __fastcall Variant::IsEmpty() const
  {
    return Variants::VarIsEmpty(*this);
  }

  bool __fastcall Variant::IsArray() const
  {
    return Variants::VarIsArray(*this);
  }

  int __fastcall Variant::ArrayDimCount() const
  {
    return Variants::VarArrayDimCount(*this);
  }

  int __fastcall Variant::ArrayLowBound(const int dim) const
  {
    return Variants::VarArrayLowBound(*this, dim);
  }

  int __fastcall Variant::ArrayHighBound(const int dim) const
  {
    return Variants::VarArrayHighBound(*this, dim);
  }

  void __fastcall Variant::ArrayRedim(int highBound)
  {
    System::Internal::Varhlpr::VariantArrayRedim(*this, highBound);
  }

  Pointer __fastcall Variant::ArrayLock()
  {
    return Variants::VarArrayLock(*this);
  }

  void    __fastcall Variant::ArrayUnlock()
  {
    Variants::VarArrayUnlock(*this);
  }

  Variant& __fastcall Variant::operator [](const int idx)
  {
    // Only use this function for arrays of type Variant!
    //
    if (!IsArray() || idx < ArrayLowBound() || idx > ArrayHighBound())
      throw Variants::EVariantBadIndexError(System_Sysconst_SVarArrayBounds);

    Variant* array((Variant*)ArrayLock());
    Variant* v(array + idx);
    ArrayUnlock();
    return *v;
  }

  Variant __fastcall Variant::GetElement(const int i1) const
  {
    return System::Internal::Varhlpr::VariantGetElement(*this, i1);
  }

  Variant __fastcall Variant::GetElement(const int i1, const int i2) const
  {
    return System::Internal::Varhlpr::VariantGetElement(*this, i1, i2);
  }

  Variant __fastcall Variant::GetElement(const int i1, const int i2, const int i3) const
  {
    return System::Internal::Varhlpr::VariantGetElement(*this, i1, i2, i3);
  }

  Variant __fastcall Variant::GetElement(const int i1, const int i2, const int i3, const int i4) const
  {
    return System::Internal::Varhlpr::VariantGetElement(*this, i1, i2, i3, i4);
  }

  Variant __fastcall Variant::GetElement(const int i1, const int i2, const int i3, const int i4, const int i5) const
  {
    return System::Internal::Varhlpr::VariantGetElement(*this, i1, i2, i3, i4, i5);
  }

  void __fastcall Variant::PutElement(const Variant& data, const int i1)
  {
    return System::Internal::Varhlpr::VariantPutElement(*this, data, i1);
  }

  void __fastcall Variant::PutElement(const Variant& data, const int i1, const int i2)
  {
    return System::Internal::Varhlpr::VariantPutElement(*this, data, i1, i2);
  }

  void __fastcall Variant::PutElement(const Variant& data, const int i1, const int i2, const int i3)
  {
    return System::Internal::Varhlpr::VariantPutElement(*this, data, i1, i2, i3);
  }

  void __fastcall Variant::PutElement(const Variant& data, const int i1, const int i2, const int i3, const int i4)
  {
    return System::Internal::Varhlpr::VariantPutElement(*this, data, i1, i2, i3, i4);
  }

  void __fastcall Variant::PutElement(const Variant& data, const int i1, const int i2, const int i3, const int i4, const int i5)
  {
    return System::Internal::Varhlpr::VariantPutElement(*this, data, i1, i2, i3, i4, i5);
  }

#if defined(VARIANT_AUTOMATION_SUPPORT)
  #if !defined(__clang__)
  Variant __fastcall Variant::Exec(AutoCmd& cmd, Integer) const
  {
    //Result
    Variant tmp;
    Variant* ptmp = 0;

    if (cmd.RequestResult())
      ptmp = &tmp;

    //construct a call descriptor
    TCallDesc callDesc;
    TCallDesc* pcallDesc = &callDesc;

    // set calltype, argcount, named arg count
    callDesc.CallType      = cmd.GetCallType();
    callDesc.ArgCount      = cmd.GetArgCount();
    callDesc.NamedArgCount = cmd.GetNamedArgCount();

    // fill in arg types for named args
    for (Byte i = 0; i < callDesc.NamedArgCount; i++)
    {
      int argType = cmd.GetNamedArgType(i);
      if (argType == varString)
        callDesc.ArgTypes[i] = varStrArg;
      else if (argType == (varString | varByRef))
        callDesc.ArgTypes[i] = varStrArg + 128;
      else
      {
        callDesc.ArgTypes[i] = (Byte)(argType & varTypeMask);
        callDesc.ArgTypes[i] += (Byte)((argType & varByRef) ? 128 : 0);
      }
    }

    // fill in arg types for un-named args
    for (Byte i = callDesc.NamedArgCount; i < callDesc.ArgCount; i++)
    {
      int argType = cmd.GetArgType((Byte)(i-callDesc.NamedArgCount));
      if (argType == varString)
        callDesc.ArgTypes[i] = varStrArg;
      else if (argType == (varString | varByRef))
        callDesc.ArgTypes[i] = varStrArg + 128;
      else
      {
        callDesc.ArgTypes[i] = (Byte)(argType & varTypeMask);
        callDesc.ArgTypes[i] += (Byte)((argType & varByRef) ? 128 : 0);
      }
    }

    // get ptr that points after all argtypes
    char* p = (char*) &callDesc.ArgTypes[callDesc.ArgCount];

    // fill in the name of the cmd
    p = stpcpy(p, (char*)cmd.GetName().c_str());

    // fill in names of named args
    for (Byte i = 0; i < callDesc.NamedArgCount; i++)
      p = stpcpy(p+1, (char*)cmd.GetNamedParmName(i).c_str());

    // fill an array of values/addresses of named args (makes asm easier)
    void* namedParms[MaxDispArgs*2];
    void* namedParmsPtr = &namedParms;
    Byte namedCursor = 0;
    for (Byte i = 0; i < callDesc.NamedArgCount; i++)
    {
      Variant* v = &cmd.GetNamedParm(i);
      int argType= cmd.GetNamedArgType(i) & varTypeMask;
      bool byRef = cmd.GetNamedArgType(i) & varByRef;
      if (!byRef)
      {
        switch (argType)
        {
        case varDouble:
        case varDate:
        case varCurrency:
          namedParms[namedCursor++] = reinterpret_cast<void*>(v->VInteger);  // other half
          namedParms[namedCursor++] = reinterpret_cast<void*>(*((&v->VInteger) + 1));     //half
          break;
        case varSingle:
        case varDispatch:
        case varInteger:
        case varBoolean:
        case varOleStr:
        case varUnknown:
          namedParms[namedCursor++] = reinterpret_cast<void*>(v->VInteger);  // pick 1 (union)
          break;
        case varSmallint:
          namedParms[namedCursor++] = reinterpret_cast<void*>((int)v->VSmallint);
          break;
        case varByte:
          namedParms[namedCursor++] = reinterpret_cast<void*>((int)v->VByte);
          break;
        case varVariant:
          namedParms[namedCursor++] = v;
          break;
        }
      }
      else // byRef
      {
          namedParms[namedCursor++] = v->VPointer;
      }
    }
    // fill an array of values/addresses of un-named args (makes asm easier)
    void* parms[MaxDispArgs*2];
    void* parmsPtr = &parms;
    Byte cursor = 0;
    for (Byte i = 0; i < callDesc.ArgCount - callDesc.NamedArgCount; i++)
    {
      Variant* v = &cmd.GetParm(i);
      int argType= cmd.GetArgType(i) & varTypeMask;
      bool byRef = cmd.GetArgType(i) & varByRef;
      if (!byRef)
      {
        switch  (argType)
        {
        case varDouble:
        case varDate:
        case varCurrency:
          parms[cursor++] = reinterpret_cast<void*>(v->VInteger);  // other half
          parms[cursor++] = reinterpret_cast<void*>(*((&v->VInteger) + 1)); //half
          break;
        case varSingle:
        case varDispatch:
        case varInteger:
        case varBoolean:
        case varOleStr:
        case varUnknown:
          parms[cursor++] = reinterpret_cast<void*>(v->VInteger);  // pick 1 (union)
          break;
        case varSmallint:
          parms[cursor++] = reinterpret_cast<void*>((int)v->VSmallint);
          break;
        case varByte:
          parms[cursor++] = reinterpret_cast<void*>((int)v->VByte);
          break;
        case varVariant:
          parms[cursor++] = v;
          break;
        }
      }
      else // byRef
      {
          parms[cursor++] = v->VPointer;
      }
    }

    _EDX  = 0x0;                          // xor  edx, edx
    _DL   = cursor;                       // mov  dl, cursor
    _EDX -= 1;                            // dec  edx
    _EDX <<= 2;                           // shl  edx, 2
    _EAX  = (unsigned long)parmsPtr;      // mov  eax, parmsPtr
    _EDX += _EAX;                         // add  edx, eax
    _CL   = cursor;                       // mov  cl, cursor

    while (--_CL > 0)                     // dec  cl - while (ecx > 0)
    {
      _EAX = *((unsigned long*)_EDX);     // mov  eax, [edx]
      __emit__(0x50);                     // push eax
      _EDX -= 4;                          // sub  edx, 4
    }

    _EDX  = 0x0;                          // xor  edx, edx
    _DL   = namedCursor;                  // mov  dl, namedCursor
    _EDX -= 1;                            // dec  edx
    _EDX <<= 2;                           // shl  edx, 2
    _EAX  = (unsigned long)namedParmsPtr; // mov  eax, namedParmsPtr
    _EDX += _EAX;                         // add  edx, eax
    _CL   = namedCursor;                  // mov  cl, namedCursor

    while (--_CL > 0)                     // dec  cl - while (ecx > 0)
    {
      _EAX = *((unsigned long*)_EDX);     // mov  eax, [edx]
      __emit__(0x50);                     // push eax
      _EDX -= 4;                          // sub  edx, 4
    }

#if 0 || defined(USE_VCLHLPR_PAS)
    (*System::Internal::Varhlpr::TVarDispProc(Variants::VarDispProc))(ptmp, *this, pcallDesc);
#else
    typedef void __cdecl (*TVarDispProc)(System::PVariant Result,
                                         const Variant &Instance,
                                         System::PCallDesc CallDesc,
                                         void* Params);
    (*TVarDispProc(Variants::VarDispProc))(ptmp, *this, pcallDesc, parms);
#endif

    // NOTE: C++ Compiler cleans up 12 bytes for above 3 parameters.
    //       We only need to clean the extra parameters we pushed

    _ECX  = 0;                            // xor  ecx, ecx
    _CL   = cursor;                       // mov  cl, cursor
    _CL  += namedCursor;                  // add  cl, namedcursor
    _ECX *= 4;                            // shl  ecx, 2
    _ESP += _ECX;                         // add  esp, ecx


/* Original assembly code that required TASM
    asm
    {
      extrn   @System@@DispInvoke$qv:near
      xor     edx, edx
      mov     dl, cursor
      dec     edx
      imul    edx, 4
      add     edx, parmsPtr
      mov     cl, cursor
      @@0:
      dec     cl
      test    cl,  cl
      jl      @@1
      mov     eax, [edx]
      push    eax
      sub     edx, 4
      jmp     @@0

      @@1:
      xor     edx, edx
      mov     dl, namedCursor
      dec     edx
      imul    edx, 4
      add     edx, namedParmsPtr
      mov     cl, namedCursor
      @@2:
      dec     cl
      test    cl,  cl
      jl      @@3
      mov     eax, [edx]
      push    eax
      sub     edx, 4
      jmp     @@2
      @@3:

      push    pcallDesc
      push    this
      push    ptmp

      call    @System@@DispInvoke$qv

      xor     ecx, ecx
      mov     cl, cursor
      add     cl, namedCursor
      imul    ecx, 4
      add     ecx, 12
      add     esp, ecx
    }
*/

    // if no result is returned, return a true
    if (!cmd.RequestResult())
      tmp = true;

    return tmp;
  }
  #endif // !__clang__

  void Variant::OleProcedure(const String& name, TAutoArgsBase* args)
  {
    // Bind to IDispatch in this Variant
    //
    TAutoDriver<IDispatch> disp;
    disp.Bind(AsRef<IDispatch>(), false/*operator IDispatch*() returns AddRef Interface */);

    // Look up the dispid of the name passed
    //
    DISPID id;
    System::Win::Comobj::OleCheck(disp.GetIDsOfNames(WideString(name).data(), id));

    // Do Invoke
    //
    HRESULT status;
    if (args)
      status = disp.OleProcedure(id, *args);
    else
      status = disp.OleProcedure(id);

    if (status != S_OK)
      System::Win::Comobj::DispatchInvokeError(status, disp.get_excepinfo());
  }

  Variant Variant::OleFunction(const String& name, TAutoArgsBase* args)
  {
    // Bind to IDispatch in this Variant
    //
    TAutoDriver<IDispatch> disp;
    disp.Bind(AsRef<IDispatch>(), false/*operator IDispatch*() returns AddRef Interface */);

    // Look up the dispid of the name passed
    //
    DISPID id;
    System::Win::Comobj::OleCheck(disp.GetIDsOfNames(WideString(name).data(), id));

    // OleFunctions need args array since it returns value
    //
    TAutoArgs<0> _a;
    if (!args)
      args = &_a;

    // Do Invoke
    //
    HRESULT status = disp.OleFunction (id, *args);
    if (status != S_OK)
      System::Win::Comobj::DispatchInvokeError(status, disp.get_excepinfo());
    return Variant(args->GetRetVariant());
  }

  Variant Variant::OlePropertyGet(const String& name, TAutoArgsBase* args)
  {
    // Bind to IDispatch in this Variant
    //
    TAutoDriver<IDispatch> disp;
    disp.Bind(AsRef<IDispatch>(), false/*operator IDispatch*() returns AddRef Interface */);

    // Look up the dispid of the name passed
    //
    DISPID id;
    System::Win::Comobj::OleCheck(disp.GetIDsOfNames(WideString(name).data(), id));

    // OlePropertyGets need args array since it returns value
    //
    TAutoArgs<0> _a;
    if (!args)
      args = &_a;

    // Do Invoke
    //
    HRESULT status = disp.OlePropertyGet (id, *args);
    if (status != S_OK)
      System::Win::Comobj::DispatchInvokeError(status, disp.get_excepinfo());
    return Variant(args->GetRetVariant());
  }

  void Variant::OlePropertySet(const String& name, TAutoArgsBase& args)
  {

    // Bind to IDispatch in this Variant
    //
    TAutoDriver<IDispatch> disp;
    disp.Bind(AsRef<IDispatch>(), false/*operator IDispatch*() returns AddRef Interface */);

    // Look up the dispid of the name passed
    //
    DISPID id;
    System::Win::Comobj::OleCheck(disp.GetIDsOfNames(WideString(name).data(), id));

    // Do Invoke
    //
    HRESULT status = disp.OlePropertyPut (id, args);
    if (status != S_OK)
      System::Win::Comobj::DispatchInvokeError(status, disp.get_excepinfo());
  }


  // AutoCmd
  //
  AutoCmd::AutoCmd(const String& name): Name(name)
  {}

  AutoCmd::AutoCmd(const AutoCmd& src): Name(src.Name),
                                         Parms(src.Parms),
                                         ParmTypes(src.ParmTypes),
                                         NamedParms(src.NamedParms),
                                         NamedParmTypes(src.NamedParmTypes),
                                         NamedParmNames(src.NamedParmNames)
  {}

  AutoCmd::~AutoCmd()
  {}

  AutoCmd& AutoCmd::SetName(const String& name)
  {
    Name = name;
    return *this;
  }

  AutoCmd& AutoCmd::Clear()
  {
    ClearName();
    ClearArgs();
    return *this;
  }

  AutoCmd& AutoCmd::ClearName()
  {
    SetName("");
    return *this;
  }

  AutoCmd& AutoCmd::ClearArgs()
  {
    Parms.Clear();
    ParmTypes.Clear();

    NamedParms.Clear();
    NamedParmTypes.Clear();
    NamedParmNames.Clear();

    return *this;
  }

  int AutoCmd::GetArgType(const Byte idx) const
  {
    if (ParmTypes.IsEmpty() || ParmTypes.ArrayHighBound() < idx)
      throw Variants::EVariantBadIndexError(System_Sysconst_SVarArrayBounds);
    return ParmTypes.GetElement(idx);
  }

  int AutoCmd::GetNamedArgType(const Byte idx) const
  {
    if (NamedParmTypes.IsEmpty() || NamedParmTypes.ArrayHighBound() < idx)
      throw Variants::EVariantBadIndexError(System_Sysconst_SVarArrayBounds);
    return NamedParmTypes.GetElement(idx);
  }

  Byte AutoCmd::GetArgCount() const
  {
    int count = GetNamedArgCount();
    if (!Parms.IsEmpty())
      count += Parms.ArrayHighBound() + 1;
    return (Byte) count;
  }

  Byte AutoCmd::GetNamedArgCount() const
  {
    int count = 0;
    if (!NamedParms.IsEmpty())
      count += NamedParms.ArrayHighBound() + 1;
    return (Byte)count;
  }

  Variant& AutoCmd::GetParm(const Byte idx)
  {
    if (Parms.IsEmpty() || Parms.ArrayHighBound() < idx)
      throw Variants::EVariantBadIndexError(System_Sysconst_SVarArrayBounds);
    return Parms[idx];
  }

  Variant& AutoCmd::GetNamedParm(const Byte idx)
  {
    if (NamedParms.IsEmpty() || NamedParms.ArrayHighBound() < idx)
      throw Variants::EVariantBadIndexError(System_Sysconst_SVarArrayBounds);
    return NamedParms[idx];
  }

  AnsiString AutoCmd::GetNamedParmName(const Byte idx) const
  {
    if (NamedParms.IsEmpty() || NamedParms.ArrayHighBound() < idx)
      throw Variants::EVariantBadIndexError(System_Sysconst_SVarArrayBounds);
    return NamedParmNames.GetElement(idx);
  }

  void AutoCmd::AddElement()
  {
    if (Parms.IsEmpty())
    {
      Parms = Variant(OPENARRAY(int, (0, 0)), varVariant);
      _ASSERTE(Parms.VType == (VT_ARRAY|VT_VARIANT));
      ParmTypes = Variant(OPENARRAY(int, (0, 0)), varInteger);
      _ASSERTE(ParmTypes.VType == (VT_ARRAY|VT_I4));
    }
    else
    {
      Parms.ArrayRedim(Parms.ArrayHighBound()+1);
      ParmTypes.ArrayRedim(ParmTypes.ArrayHighBound()+1);
    }
  }

  AutoCmd& AutoCmd::operator <<(const Variant& v)
  {
    AddElement();

    // Handle case where Variant contains a non-Automation compatible AnsiString
    Variant tmp(v);
    if ((tmp.VType == varString) || (tmp.VType == varUString))
      tmp.ChangeType(varOleStr);
    Parms.PutElement(tmp, Parms.ArrayHighBound());
    ParmTypes.PutElement(tmp.Type(), ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const short arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varSmallint, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const int arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varInteger, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const float arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varSingle, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const double arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varDouble, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const Currency arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varCurrency, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const TDateTime arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varDate, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const bool arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varBoolean, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const WordBool arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varBoolean, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const Byte arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varByte, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(const AnsiString& arg)
  {
    AddElement();
    // NOTE: AnsiString is converted to BSTR
    Parms.PutElement(WideString(arg).Detach(), Parms.ArrayHighBound());
    ParmTypes.PutElement(varOleStr, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(IDispatch* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varDispatch, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(wchar_t* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varOleStr, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(IUnknown* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varUnknown, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(Variant* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varVariant | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(short* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varSmallint | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(int* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varInteger | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(float* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varSingle | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(double* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varDouble | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(Currency* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varCurrency | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(TDateTime* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varDate | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(WordBool* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varBoolean | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(Byte* arg)
  {
    AddElement();
    Parms.PutElement(arg, Parms.ArrayHighBound());
    ParmTypes.PutElement(varByte | varByRef, ParmTypes.ArrayHighBound());
    return *this;
  }

  AutoCmd& AutoCmd::operator <<(AnsiString* arg)
  {
    // Automation Server does not support the non-OLE MBCS string type.
    // Hence, we turn the string into a plain string
    return this->operator << (*arg);
  }

  AutoCmd& AutoCmd::operator <<(const NamedParm& np)
  {
    if (NamedParms.IsEmpty())
    {
      NamedParms     = Variant(OPENARRAY(int, (0, 0)), varVariant);
      NamedParmTypes = Variant(OPENARRAY(int, (0, 0)), varInteger);
      NamedParmNames = Variant(OPENARRAY(int, (0, 0)), varVariant);
    }
    else
    {
      NamedParms.ArrayRedim(NamedParms.ArrayHighBound()+1);
      NamedParmTypes.ArrayRedim(NamedParmTypes.ArrayHighBound()+1);
      NamedParmNames.ArrayRedim(NamedParmNames.ArrayHighBound()+1);
    }

    NamedParmNames.PutElement(np.GetParmName(), NamedParmNames.ArrayHighBound());
    NamedParmTypes.PutElement(np.GetType(), NamedParmTypes.ArrayHighBound());
    NamedParms.PutElement(np.GetParm(), NamedParms.ArrayHighBound());

    return *this;
  }
#endif // VARIANT_AUTOMATION_SUPPORT

} // namespace System


namespace System
{

// extern PACKAGE void __fastcall VariantClear(System::Variant &V);
// extern PACKAGE void __fastcall VariantCast(const System::Variant &src, System::Variant &dst, int vt);
// extern PACKAGE void __fastcall VariantArrayRedim(System::Variant &V, int High);

  void __fastcall VarClear(Variant& v)
  {
    System::Internal::Varhlpr::VariantClear(v);
  }

  void __fastcall VarCast(Variant &dest, const Variant& source, int type)
  {
    System::Internal::Varhlpr::VariantCast(source, dest, type);
  }

  void __fastcall VarArrayRedim(Variant& a, int high)
  {
    System::Internal::Varhlpr::VariantArrayRedim(a, high);
  }

} // namespace System

