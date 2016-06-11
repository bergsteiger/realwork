// -----------------------------------------------------------------------------------
// DSTRING.CPP - Support for Delphi AnsiString in C++
//            (AnsiString and template<sz> SmallString)
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
// -----------------------------------------------------------------------------------

#define __DSTRING_INLINE

#include <System.hpp>
#include <System.Internal.StrHlpr.hpp>

#if defined(_Windows)
  #include <windows.hpp>
#endif

#if !defined(_DELPHI_NEXTGEN)
 #include <AnsiStrings.hpp>
#endif

#include <System.SyncObjs.hpp>
#include <System.SysUtils.hpp>

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <limits.h>

#include <dstring.h>

#pragma hdrstop

#ifdef near
#undef near
#endif

#define _STR_CAST(type, arg) const_cast<type>(arg)

#if defined(_WIN32) && !defined(_WIN64) && defined(__clang__)
 #define _CLANG_WIN32
#endif

#include <System_thunks.h>

namespace System
{

  template <typename CH>
  int _CharLen(const CH* src)
  {
    int len = 0;
    if (src)
    {
      while (*src++)
        ++len;
    }
    return len;
  }

  void  __cdecl AnsiStringBase::ThrowIfOutOfRange(int idx) const
  {
    if (idx < 1 || idx > Length())    // NOTE: AnsiString is 1-based !!
      throw Sysutils::ERangeError(System_Sysconst_SRangeError);
  }

#if defined(__clang__ ) && !defined(_CLANG_WIN32)
  void _LStrFromPChar(System::AnsiStringT<(unsigned short)0>&, char*, unsigned short);
  void _LStrAsg(System::AnsiStringT<(unsigned short)0>&, System::AnsiStringT<(unsigned short)0>);
 #if !defined(_DELPHI_NEXTGEN)
  void _LStrFromWStr(System::AnsiStringT<(unsigned short)0>&, System::WideString, unsigned short);
 #endif
  void _LStrFromUStr(System::AnsiStringT<(unsigned short)0>&, System::UnicodeString, unsigned short);
  void _LStrFromPWCharLen(System::AnsiStringT<(unsigned short)0>&, System::WideChar*, int, unsigned short);
  void _LStrFromWChar(System::AnsiStringT<(unsigned short)0>&, System::WideChar, unsigned short);
  void _LStrCat(System::AnsiStringT<(unsigned short)0>&, System::AnsiStringT<(unsigned short)0>);
  void _LStrCat3(System::AnsiStringT<(unsigned short)0>&, System::AnsiStringT<(unsigned short)0>, System::AnsiStringT<(unsigned short)0>);
  int  _LStrCmp(System::AnsiStringT<(unsigned short)0>, System::AnsiStringT<(unsigned short)0>);
  void _LStrInsert(System::AnsiStringT<(unsigned short)0>, System::AnsiStringT<(unsigned short)0>&, int);
  void _LStrDelete(System::AnsiStringT<(unsigned short)0>&, int, int);
  void _LStrSetLength(System::AnsiStringT<(unsigned short)0>&, int, unsigned short);
  void _LStrClr(void*);
#endif

  AnsiStringBase::AnsiStringBase(const char* src, int codePage) : Data(0)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrFromPChar(*PAnsiString(this), const_cast<char*>(src), codePage != 0xffff ? codePage : 0);
#else
    typedef void (__fastcall *LStrFromPChar_Proc)(const AnsiStringBase&, const char*, unsigned short);
    (reinterpret_cast<LStrFromPChar_Proc>(_System__LStrFromPChar))(*this, src, codePage != 0xffff ? codePage : 0);
#endif
  }

  AnsiStringBase::AnsiStringBase(const AnsiStringBase& src)
  {
    // Handle case of LStrAddRef first
    if (this == &src) {
      if (Data && reinterpret_cast<const StrRec*>(Data)[-1].refCnt > 0) {
        System::Syncobjs::TInterlocked::Increment((reinterpret_cast<StrRec*>(Data)[-1].refCnt));
      }
      return;
    }
#if defined(__clang__) && !defined(_CLANG_WIN32)
    Data = 0;
    _LStrAsg(*PAnsiString(this), *PAnsiString(&src));
#else
    Data = 0;
    typedef void (__fastcall *LStrAsg_Proc)(AnsiStringBase*, char*);
    (reinterpret_cast<LStrAsg_Proc>(_System__LStrAsg))(this, src.Data);
#endif
  }

#if !defined(_DELPHI_NEXTGEN)
  AnsiStringBase::AnsiStringBase(const WideString &src, int codePage) : Data(0)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrFromWStr(*PAnsiString(this), src, codePage != 0xffff ? codePage : 0);
#else
    typedef void (__fastcall *LStrFromWStr_Proc)(AnsiStringBase*, System::WideChar*, unsigned short);
    (reinterpret_cast<LStrFromWStr_Proc>(_System__LStrFromWStr))(this, src.c_bstr(), codePage != 0xffff ? codePage : 0);
#endif
  }
#endif

  AnsiStringBase::AnsiStringBase(const UnicodeString& src, int codePage) : Data(0)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrFromUStr(*PAnsiString(this), src, codePage != 0xffff ? codePage : 0);
#else
    typedef void (__fastcall *LStrFromUStr_Proc)(AnsiStringBase*, const void*/*System::WideChar*/, unsigned short);
    (reinterpret_cast<LStrFromUStr_Proc>(_System__LStrFromUStr))(this, src.data(), codePage != 0xffff ? codePage : 0);
#endif
  }

  AnsiStringBase::AnsiStringBase(const char* src, int byteLen, int codePage) : Data(0)
  {
    if (src) {
      if (byteLen < 0) {
        byteLen = strlen(src);
      }
      SetLength(byteLen, codePage);
      memcpy(Data, src, byteLen);
    }
  }

  void AnsiStringBase::_AnsiFromPWChar(AnsiStringBase& dst, const System::WideChar* src, int len, int codePage)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrFromPWCharLen(*PAnsiString(&dst), const_cast<System::WideChar*>(src), len, codePage != 0xffff ? codePage : 0);
#else
    typedef void (__fastcall *LStrFromPWCharLen_Proc)(AnsiStringBase*, const System::WideChar*, int, unsigned short);
    (reinterpret_cast<LStrFromPWCharLen_Proc>(_System__LStrFromPWCharLen))(&dst, src, len, codePage != 0xffff ? codePage : 0);
#endif
  }

  AnsiStringBase::AnsiStringBase(const wchar_t* src, int numwchar, int codePage): Data(0)
  {
    if (numwchar < 0)
      numwchar = _CharLen(src);
#if defined(_Windows)
    _AnsiFromPWChar(*this, src, numwchar, codePage);
#elif defined(__APPLE__) || defined(__arm__)
    UnicodeString ustr((const char32_t*)(src), numwchar);
    *this = AnsiStringBase(ustr, codePage);
#else
  #error "Unsupported platform"
#endif
  }

  AnsiStringBase::AnsiStringBase(const char16_t* src, int numwchar, int codePage): Data(0)
  {
    if (numwchar < 0)
      numwchar = _CharLen(src);
#if defined(_Windows)
    _AnsiFromPWChar(*this, reinterpret_cast<const wchar_t*>(src), numwchar, codePage);
#elif defined(__APPLE__) || defined(__arm__)
    _AnsiFromPWChar(*this, src, numwchar, codePage);
#else
  #error "Unsupported platform"
#endif
  }

  AnsiStringBase::AnsiStringBase(const char32_t* src, int numChar32, int codePage) : Data(0)
  {
    if (src && (numChar32 != 0))
    {
      UnicodeString ustr(src, numChar32);
      *this = AnsiStringBase(ustr, codePage);
    }
  }

  AnsiStringBase::AnsiStringBase(System::WideChar src, int codePage) : Data(0)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrFromWChar(*PAnsiString(this), src, codePage != 0xffff ? codePage : 0);
#else
    typedef void (__fastcall *LStrFromWChar_Proc)(AnsiStringBase*, System::WideChar, unsigned short);
    (reinterpret_cast<LStrFromWChar_Proc>(_System__LStrFromWChar))(this, src, codePage != 0xffff ? codePage : 0);
#endif
  }

  AnsiStringBase::AnsiStringBase(double src, int codePage) : Data(0)
  {
#if !defined(_DELPHI_STRING_UNICODE)
    *this = Sysutils::FloatToStr(src);
#else
    *this = AnsiStringBase(Sysutils::FloatToStr(src), codePage);
#endif
  }

  AnsiStringBase::~AnsiStringBase()
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrClr(this);
#else
    typedef void (__fastcall *LStrClr_Proc)(AnsiStringBase *);
    (reinterpret_cast<LStrClr_Proc>(_System__LStrClr))(this);
#endif
  }

  AnsiStringBase& AnsiStringBase::operator=(const AnsiStringBase& src)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrAsg(*PAnsiString(this), *PAnsiString(&src));
#else
    typedef void (__fastcall *LStrAsg_Proc)(AnsiStringBase*, char*);
    (reinterpret_cast<LStrAsg_Proc>(_System__LStrAsg))(this, src.Data);
#endif
    return *this;
  }

  void AnsiStringBase::_AnsiCat(AnsiStringBase& dst, const AnsiStringBase& src)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrCat(*PAnsiString(&dst), *PAnsiString(&src));
#else
    typedef void (__fastcall *LStrCat_Proc)(AnsiStringBase*, char*);
    (reinterpret_cast<LStrCat_Proc>(_System__LStrCat))(&dst, src.Data);
#endif
  }

  void AnsiStringBase::_AnsiCat(AnsiStringBase& dst, const AnsiStringBase& src1, const AnsiStringBase& src2)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrCat3(*PAnsiString(&dst), *PAnsiString(&src1), *PAnsiString(&src2));
#else
    typedef void (__fastcall* LStrCat3_Proc)(AnsiStringBase*, char*, char*);
    (reinterpret_cast<LStrCat3_Proc>(_System__LStrCat3))(&dst, src1.Data, src2.Data);
#endif
  }

  bool AnsiStringBase::operator==(const AnsiStringBase& rhs) const
  {
    return AnsiCompare(rhs) == 0;
  }

  bool AnsiStringBase::operator!=(const AnsiStringBase& rhs) const
  {
    return AnsiCompare(rhs) != 0;
  }

  bool AnsiStringBase::operator<(const AnsiStringBase& rhs) const
  {
    return AnsiCompare(rhs) < 0;
  }

  bool AnsiStringBase::operator>(const AnsiStringBase& rhs) const
  {
    return AnsiCompare(rhs) > 0;
  }

  int AnsiStringBase::AnsiCompare(const AnsiStringBase& rhs) const
  {
#if !defined(_DELPHI_NEXTGEN)
    if (System::Internal::Strhlpr::AnsiGreater(
                   *reinterpret_cast<PRawByteString>(const_cast<AnsiStringBase*>(this)),
                   *reinterpret_cast<PRawByteString>(const_cast<AnsiStringBase*>(&rhs))))
      return 1;
    else if (System::Internal::Strhlpr::AnsiLess(
                   *reinterpret_cast<PRawByteString>(const_cast<AnsiStringBase*>(this)),
                   *reinterpret_cast<PRawByteString>(const_cast<AnsiStringBase*>(&rhs))))
      return -1;
    else
      return 0;
#else
   // FIXME
    // This assumes the two AnsiStrings are of the same codepage??
    int lsz = Length();
    int rsz = rhs.Length();
    int minsz = (lsz <= rsz) ? lsz : rsz;
    for (int i=0; i < minsz; i++) {
       if (Data[i] < rhs.Data[i])
         return -1;
       else if (Data[i] > rhs.Data[i])
         return 1;
    }
    if (lsz < rsz)
      return -1;
    if (lsz > rsz)
        return 1;
    return 0;
#endif
  }

  int AnsiStringBase::AnsiCompareIC(const AnsiStringBase& rhs) const
  {
#if !defined(_DELPHI_NEXTGEN)
    return Ansistrings::AnsiCompareText(*PAnsiString(this),
                                        *PAnsiString(&rhs));
#else
    return Sysutils::AnsiCompareText(UnicodeString(*PAnsiString(this)),
                                     UnicodeString(*PAnsiString(&rhs)));
#endif
  }

  // Return AnsiString of count chars of value ch
  AnsiStringBase AnsiStringBase::StringOfChar(char ch, int count)
  {
    return System::StringOfChar(ch, count);
  }

#if !defined(_DELPHI_NEXTGEN)
  AnsiStringBase AnsiStringBase::LoadStr(int ident, int codePage)
  {
    return AnsiStringBase(Sysutils::LoadStr(ident), codePage);
  }

 #if defined(_Windows)
  AnsiStringBase AnsiStringBase::LoadStr(HINSTANCE hInstance, int ident, int codePage)
  {
    AnsiStringBase str;
    str.LoadString(hInstance, ident, codePage);
    return str;
  }

  AnsiStringBase& AnsiStringBase::LoadString(HINSTANCE hInstance, int id, int codePage)
  {
    HRSRC resHdl = ::FindResource(hInstance, MAKEINTRESOURCE(id/16+1), RT_STRING);
    if (resHdl)
    {
      HGLOBAL gblHdl = ::LoadResource(hInstance, resHdl);
      if (gblHdl)
      {
        WCHAR* resData = (WCHAR*)::LockResource(gblHdl);
        if (resData)
        {
          unsigned int len;
          for (int cnt = id % 16; len = *resData++, cnt--; resData += len)
            ;
          if (len != 0)
          {
            if (len > 0) {
              *this = AnsiStringBase(resData, len, codePage);
            } else {
              SetLength(len, codePage);
            }
          }
          /* Unnecessary in Win32
          ::UnlockResource(gblHdl);
          */
        }
        ::FreeResource(resHdl);
      }
    }

    return *this;
  }
 #endif

  AnsiStringBase AnsiStringBase::FmtLoadStr(int ident,
                                               const TVarRec* args,
                                               int size,
                                               int codePage)
  {
    return AnsiStringBase(Sysutils::FmtLoadStr(ident, args, size), codePage);
  }

  AnsiStringBase AnsiStringBase::Format(const AnsiStringBase& format,
                                        const TVarRec *args,
                                        int size,
                                        int /*codePage*/)
  {
    return Ansistrings::Format(*PAnsiString(&format), args, size);
  }

  AnsiStringBase AnsiStringBase::FormatFloat(const AnsiStringBase& format,
                                             const long double& value,
                                             int codePage)
  {
    return AnsiStringBase(Sysutils::FormatFloat(*PAnsiString(&format), value), codePage);
  }
#endif

#undef vprintf
#undef printf
#undef sprintf

  int __cdecl AnsiStringBase::vprintf(int codePage, const char* format, va_list paramList)
  {
    int size = vsnprintf(NULL, 0, format, paramList);
    SetLength(size, codePage);
    return size ? vsnprintf(Data, size + 1, format, paramList) : 0;
  }

  int __cdecl AnsiStringBase::cat_vprintf(int codePage, const char* format, va_list paramList)
  {
    int size = vsnprintf(NULL, 0, format, paramList);

    if (!size)
      return 0;

    int len = Length();
    SetLength(len + size, codePage);
    return vsnprintf(Data + len, size + 1, format, paramList);
  }

  AnsiStringBase AnsiStringBase::FloatToStrF(long double value,
                                             TStringFloatFormat format,
                                             int precision,
                                             int digits,
                                             int codePage)
  {
    return AnsiStringBase(Sysutils::FloatToStrF(value,
                                                Sysutils::TFloatFormat(format),
                                                precision,
                                                digits), codePage);
  }

  AnsiStringBase AnsiStringBase::IntToHex(int value, int digits, int codePage)
  {
    return AnsiStringBase(Sysutils::IntToHex(value, digits), codePage);
  }

  AnsiStringBase AnsiStringBase::CurrToStr(const Currency& value, int codePage)
  {
    return AnsiStringBase(Sysutils::CurrToStr(value), codePage);
  }

  AnsiStringBase AnsiStringBase::CurrToStrF(const Currency& value,
                                            TStringFloatFormat format,
                                            int digits,
                                            int codePage)
  {
    return AnsiStringBase(Sysutils::CurrToStrF(value, Sysutils::TFloatFormat(format), digits), codePage);
  }

#if defined(_Windows)
  int AnsiStringBase::WideCharBufSize(int codePage) const
  {
    return ::MultiByteToWideChar(codePage, 0, (Data) ? Data: (const PAnsiChar)"", -1, 0, 0);
  }

  wchar_t* AnsiStringBase::WideChar(wchar_t* dest, int destSize, int codePage) const
  {
    ::MultiByteToWideChar(codePage, 0,(Data) ? Data: (const PAnsiChar)"", -1, dest, destSize);
    return dest;
  }
#endif

  AnsiStringBase& AnsiStringBase::Insert1(const AnsiStringBase& source, int index)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrInsert(*PAnsiString(&source), *PAnsiString(this), index);
#else
    typedef void (__fastcall *LStrInsert_Proc)(char*, AnsiStringBase*, int);
    (reinterpret_cast<LStrInsert_Proc>(_System__LStrInsert))(source.Data, this, index);
#endif
    return *this;
  }

  AnsiStringBase& AnsiStringBase::Insert0(const AnsiStringBase& source, int index)
  {
    if (index >= Length())
      return *this;
    if (index < 0)
      index = 0;
    AnsiStringBase temp;
    temp.SetLength(Length()+source.Length(), CodePage());
    if (index > 0)
      memmove(temp.Data, Data, index*sizeof(Data[0]));
    memmove(temp.Data+index, source.Data, source.Length()*sizeof(source.Data[0]));
    memmove(temp.Data+index+source.Length(), Data+index, (Length()-index)*sizeof(Data[0]));
    swap(temp);
    return *this;
  }

  AnsiStringBase& AnsiStringBase::Delete1(int index, int count)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrDelete(*PAnsiString(this), index, count);
#else
    typedef void (__fastcall *LStrDelete_Proc)(AnsiStringBase*, int, int);
    (reinterpret_cast<LStrDelete_Proc>(_System__LStrDelete))(this, index, count);
#endif
    return *this;
  }

  AnsiStringBase& AnsiStringBase::Delete0(int index, int count)
  {
    if (index >= Length())
      return *this;
    int delta = (index+count <= Length()) ? count: Length()-index;
    AnsiStringBase temp;
    temp.SetLength(Length()-delta, CodePage());
    if (index > 0)
      memmove(temp.Data, Data, index*sizeof(Data[0]));
    memmove(temp.Data+index, Data+index+delta, (Length()-index-delta)*sizeof(Data[0]));
    swap(temp);
    return *this;
  }

  AnsiStringBase& AnsiStringBase::SetLength(int newLength, int codePage)
  {
#if defined(__clang__) && !defined(_CLANG_WIN32)
    _LStrSetLength(*PAnsiString(this), newLength, codePage != 0xffff ? codePage : 0);
#else
    typedef void (__fastcall *LStrSetLength_Proc)(AnsiStringBase*, int, unsigned short);
    (reinterpret_cast<LStrSetLength_Proc>(_System__LStrSetLength))(this, newLength, codePage != 0xffff ? codePage : 0);
#endif
    return *this;
  }

#if !defined(_DELPHI_NEXTGEN) || defined(__clang__)
  int AnsiStringBase::Pos1(const AnsiStringBase& subStr) const
  {
    return System::Pos(*reinterpret_cast<PRawByteString>(const_cast<AnsiStringBase*>(&subStr)),
                       *PRawByteString(this));
  }
#endif

  int AnsiStringBase::Pos0(const AnsiStringBase& subStr) const
  {
    return Pos1(subStr)-1;
  }

  AnsiStringBase AnsiStringBase::LowerCase(int codePage) const
  {
#if !defined(_DELPHI_NEXTGEN)
    (void)codePage;
    return Ansistrings::AnsiLowerCase(*PAnsiString(this));
#else
    return AnsiStringBase(Sysutils::AnsiLowerCase(UnicodeString(*PAnsiString(this))), codePage);
#endif
  }

  AnsiStringBase AnsiStringBase::UpperCase(int codePage) const
  {
#if !defined(_DELPHI_NEXTGEN)
    (void)codePage;
    return Ansistrings::AnsiUpperCase(*PAnsiString(this));
#else
    return AnsiStringBase(Sysutils::AnsiUpperCase(UnicodeString(*PAnsiString(this))), codePage);
#endif
  }

  AnsiStringBase AnsiStringBase::Trim(int codePage) const
  {
#if !defined(_DELPHI_NEXTGEN)
    (void)codePage;
    return Ansistrings::Trim(*PAnsiString(this));
#else
    return AnsiStringBase(Sysutils::Trim(UnicodeString(*PAnsiString(this))), codePage);
#endif
  }

  AnsiStringBase AnsiStringBase::TrimLeft(int codePage) const
  {
#if !defined(_DELPHI_NEXTGEN)
    (void)codePage;
    return Ansistrings::TrimLeft(*PAnsiString(this));
#else
    return AnsiStringBase(Sysutils::TrimLeft(UnicodeString(*PAnsiString(this))), codePage);
#endif
  }

  AnsiStringBase AnsiStringBase::TrimRight(int codePage) const
  {
#if !defined(_DELPHI_NEXTGEN)
    (void)codePage;
    return Ansistrings::TrimRight(*PAnsiString(this));
#else
    return AnsiStringBase(Sysutils::TrimRight(UnicodeString(*PAnsiString(this))), codePage);
#endif
  }

  AnsiStringBase AnsiStringBase::SubString1(int index, int count) const
  {
    // This method is intended to be compatible with Delphi's Copy().
    // Be careful when reordering parameter validation to maintain the
    // semantics!
    const int len = Length();
    if (index > len || count < 1)
      return AnsiStringBase();
    if (index < 1)
      index = 1;
    int n = len - index + 1;
    if (n > count)
      n = count;
    return AnsiStringBase(Data + index - 1, n, CodePage());
  }

  AnsiStringBase AnsiStringBase::SubString0(int index, int count) const
  {
    return SubString1(index+1, count);
  }

  int AnsiStringBase::ToInt() const
  {
    return Sysutils::StrToInt(*PAnsiString(this));
  }

  int AnsiStringBase::ToIntDef(int defaultValue) const
  {
    return Sysutils::StrToIntDef(*PAnsiString(this), defaultValue);
  }

  double AnsiStringBase::ToDouble() const
  {
    #pragma option push -w-8071
    return Sysutils::StrToFloat(*PAnsiString(this));
    #pragma option pop
  }

  bool AnsiStringBase::IsDelimiter1(const AnsiStringBase& delimiters, int index) const
  {
#if !defined(_DELPHI_NEXTGEN)
    return Ansistrings::IsDelimiter(*PAnsiString(&delimiters),
                                    *PAnsiString(this), index);
#else
    // FIXME
    return IsDelimiter0(delimiters, index-1);
#endif
  }

  bool AnsiStringBase::IsDelimiter0(const AnsiStringBase& delimiters, int index) const
  {
    if (index < 0 || index >= Length())
      return false;
    int dlmLen = delimiters.Length();
    for (int i=0; i<dlmLen; i++) {
      if (delimiters[i] == Data[index])
        return true;
    }
    return false;
  }

  int AnsiStringBase::AnsiPos1(const AnsiStringBase& subStr) const
  {
#if !defined(_DELPHI_NEXTGEN)
    return Ansistrings::AnsiPos(*PAnsiString(&subStr), *PAnsiString(this));
#else
    // FIXME
    return AnsiPos0(subStr) + 1;
#endif
  }

  int AnsiStringBase::AnsiPos0(const AnsiStringBase& subStr) const
  {
    // FIXME this seems suspicious. i.e. AnsiPos0 calling Pos1 with no adjustment
    return Pos1(subStr);
  }

#if !defined(_DELPHI_NEXTGEN)
  bool AnsiStringBase::IsPathDelimiter1(int index) const
  {
    return Ansistrings::IsPathDelimiter(*PAnsiString(this), index);
  }

  bool AnsiStringBase::IsPathDelimiter0(int index) const
  {
    return IsPathDelimiter1(index+1);
  }

  int AnsiStringBase::LastDelimiter1(const AnsiStringBase& delimiters) const
  {
    return Ansistrings::LastDelimiter(*PAnsiString(&delimiters),
                                      *PAnsiString(this));
  }

  int AnsiStringBase::LastDelimiter0(const AnsiStringBase& delimiters) const
  {
    int dlmLen = delimiters.Length();
    if (dlmLen <=0)
      return -1;
    for (int j=Length(); j>=0; --j) {
      for (int i=0; i<dlmLen;i++) {
        if (delimiters[i] == Data[j])
          return j;
      }
    }
    return -1;
  }

  AnsiStringBase::TStringMbcsByteType AnsiStringBase::ByteType1(int index) const
  {
    //NOTE: This code requires TStringMbcsByteType and TMbcsByteType to be identical
    return TStringMbcsByteType(System::Ansistrings::ByteType(*PAnsiString(this), index));
  }

  AnsiStringBase::TStringMbcsByteType AnsiStringBase::ByteType0(int index) const
  {
    return ByteType1(index+1);
  }

  bool AnsiStringBase::IsLeadByte1(int index) const
  {
    return ByteType(index) == mbLeadByte;
  }

  bool AnsiStringBase::IsLeadByte0(int index) const
  {
    return IsLeadByte1(index+1);
  }

  bool AnsiStringBase::IsTrailByte1(int index) const
  {
    return ByteType(index) == mbTrailByte;
  }

  bool AnsiStringBase::IsTrailByte0(int index) const
  {
    return IsTrailByte1(index+1);
  }

  DynamicArray<System::Byte> AnsiStringBase::BytesOf() const
  {
    return Sysutils::BytesOf(*PRawByteString(this));
  }

  char* AnsiStringBase::AnsiLastChar() const
  {
    return Ansistrings::AnsiLastChar(*PAnsiString(this));
  }
#endif

  AnsiStringBase& AnsiStringBase::swap(AnsiStringBase& other)
  {
    Data = reinterpret_cast<char*>(
          System::Syncobjs::TInterlocked::Exchange(reinterpret_cast<void*&>(other.Data),
                                                   reinterpret_cast<void*>(Data)));
    return *this;
  }
} // System Namespace
