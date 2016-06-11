// -----------------------------------------------------------------------------------
// VCLINIT.CPP - Misc. Support for initializing the C++/Delphi AnsiString
//               RTL initialization, Evaluator support and const in HPP that
//               break PCH support.
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
// -----------------------------------------------------------------------------------
#include <System.hpp>
#include <Sysutils.hpp>
#include <Typinfo.hpp>
#include <System_thunks.h>
#include <StrHlpr.hpp>

extern HINSTANCE _hInstance;
extern char     __isDLL;
extern char     __isGUI;
extern char     __isVCLPackage; // in c0nt.asm

/* Declared in Math.pas/hpp but defined here as declarations in the header was
   blocking creation of precompiled header */
namespace System {
 namespace Math {
  extern const System::Extended NaN = 0.0 / 0.0;
  extern const System::Extended Infinity = 1.0 / 0.0;
  extern const System::Extended NegInfinity = -1.0 / 0.0;
  extern const System::Extended MinComp = -9.223372E+18;
  extern const System::Extended MaxComp = 9.223372E+18;
 }
}

namespace System {
 namespace Dateutils {
  extern const System::Extended OneHour = 4.166667E-02;
  extern const System::Extended OneMinute = 6.944444E-04;
  extern const System::Extended OneSecond = 1.157407E-05;
  extern const System::Extended OneMillisecond = 1.157407E-08;
  extern const System::Extended EpochAsJulianDate = 2.415018E+06;
 }
}

namespace System {
 namespace Types {
  extern const System::Single cPI = 3.141592654;
  extern const System::Single cPIdiv180 = 0.017453292;
  extern const System::Single c180divPI = 57.29577951;
  extern const System::Single c2PI = 6.283185307;
  extern const System::Single cPIdiv2 = 1.570796326;
  extern const System::Single cPIdiv4 = 0.785398163;
  extern const System::Single c3PIdiv4 = 2.35619449;
  extern const System::Single cInv2PI = 1 / 6.283185307;
  extern const System::Single cInv360 = 1 / 360;
  extern const System::Single c180 = 180;
  extern const System::Single c360 = 360;
  extern const System::Single cOneHalf = 0.5;
  extern const System::Extended CurveKappa = 0.5522847498;
  extern const System::Extended CurveKappaInv = 1 - CurveKappa;

  extern const System::Single Epsilon = 1E-40;
  extern const System::Single Epsilon2 = 1E-30;
 }
}

#ifdef _WIN64
  #include <System.Math.hpp>
  namespace System {
    double __fastcall hypotWA(double x, double y) {
      return System::Math::Hypot(x, y);
    }
  }
#endif


namespace System {

#if !defined(_DELPHI_NEXTGEN)
  void __fastcall setUStrData(UnicodeString& dst, const char* src)
  {
    System::Internal::Strhlpr::UnicodeFromUTF8(dst, src);
  }

  void __fastcall setWStrData(WideString& dst, const char* src)
  {
    System::Internal::Strhlpr::WideFromUTF8(dst, src);
  }

  void __fastcall setLStrData(PAnsiString dst, unsigned dstCodePage, const char* src)
  {
    UnicodeString ustr;
    System::Internal::Strhlpr::UnicodeFromUTF8(ustr, src);
    if (dstCodePage == 0xffff)
      dstCodePage = dst->CodePage();
    System::SetAnsiString(dst, reinterpret_cast<WideChar*>(const_cast<void*>(ustr.data())), ustr.Length(), dstCodePage);
  }

  void __fastcall __linkStrModEvalRoutines()
  {
    bool b = false;
    if (b || (!&setUStrData) || (!&setWStrData)|| (!&setLStrData))
    {
      b = !b;
      (void)b;
    }
  }
#endif
}


extern "C"
void __stdcall __InitVCL(void)
{
#if !defined(_DELPHI_NEXTGEN)
  System::__linkStrModEvalRoutines();
#endif
  Sysinit::VclInit(__isDLL, __isVCLPackage, long(_hInstance), __isGUI);
}

extern "C"
void __stdcall __ExitVCL(void)
{
  Sysinit::VclExit();
}
