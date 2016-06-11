// -----------------------------------------------------------------------------------
// currency.cpp - Supports Delphi Currency type
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
// -----------------------------------------------------------------------------------
#include  <System.hpp>
#include  <System.SysUtils.hpp>

#if defined(_WIN32)
 #include <windows.h>
 #include <oleauto.h>
#endif


// - http://msdn.microsoft.com/en-us/library/ms221223.aspx
// A currency number stored as an 8-byte, two's complement integer, scaled by 10,000
// to give a fixed-point number with 15 digits to the left of the decimal point and 4
// digits to the right. This representation provides a range of 922337203685477.5807
// to -922337203685477.5808. The CURRENCY data type is useful for calculations
// involving money, or for any fixed-point calculation where accuracy is particularly
// important.

namespace System
{
  __fastcall Currency::Currency(double val)
  {
#if defined(_USE_WINAPI)
    HRESULT hres = ::VarCyFromR8(val, reinterpret_cast<CURRENCY*>(this));
#else
    *this = System::Sysutils::FloatToCurr(val);
#endif
  }

  Currency& __fastcall Currency::operator =(double rhs)
  {
#if defined(_USE_WINAPI)
    HRESULT hres = ::VarCyFromR8(rhs, reinterpret_cast<CURRENCY*>(this));
#else
    *this = System::Sysutils::FloatToCurr(rhs);
#endif
    return *this;
  }

  __fastcall Currency::Currency(const System::String& src)
  {
    *this = System::Sysutils::StrToCurr(src);
  }

  __fastcall Currency::operator System::String() const
  {
    return System::Sysutils::CurrToStr(*this);
  }


#ifdef _WIN64

  static_assert((sizeof(System::Currency) == sizeof(CY)), "Size of 'System::Currency' and 'CY' must match");

  extern "C" void __fastcall __currMul(const System::Currency c1, System::Currency &c2)
  {
    /*
      HRESULT VarCyMul(_In_   CY cyLeft, _In_   CY cyRight, _Out_  LPCY pcyResult);
    */
    HRESULT hr = ::VarCyMul(*reinterpret_cast<CY*>(const_cast<System::Currency*>(&c1)),
                            *reinterpret_cast<CY*>(const_cast<System::Currency*>(&c2)),
                            reinterpret_cast<CY*>(&c2));
    if (hr != S_OK)
    {
    }
  }
#endif
}
