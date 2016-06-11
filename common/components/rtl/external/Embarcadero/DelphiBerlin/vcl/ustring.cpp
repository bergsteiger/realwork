// -----------------------------------------------------------------------------------
// USTRING.CPP - C++ Encapsuation of Delphi's UnicodeString
//
// $Rev: 86413 $
//
// Copyright(c) 2016 Embarcadero Technologies, Inc. 
//              All rights reserved                      
// -----------------------------------------------------------------------------------
#define __USTRING_INLINE

#include <System.hpp>
#include <System.Internal.StrHlpr.hpp>

#if defined(_Windows)
  #include <windows.hpp>
#endif

#include <System.SyncObjs.hpp>
#include <System.SysUtils.hpp>

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <limits.h>
#include <wchar.h>

#include <ustring.h>
#include <utilcls.h>

#if defined(__ANDROID__)
  #include <WideCharUtils.h>
#endif

#define _STR_CAST(type, arg) const_cast<type>(arg)

namespace System
{

  template <typename CH>
  int WideCharLen(const CH* src)
  {
    int len = 0;
    if (src)
    {
      while (*src++)
        ++len;
    }
    return len;
  }


  static int UTF32ToUTF16(const char32_t* src, WideChar* dst, int len)
  {
    int count = 0;
    while ((len != 0) && *src) {
      char32_t ch = *src++;
      if (ch < 0x0000FFFF) {
        count++;
        if (dst)
          *dst++ = (ch & 0x0000FFFF);
      }
      else if (ch < 0x0010FFFF) {
        count += 2;
        if (dst) {
          ch -= 0x10000;
          *dst++ = (ch >> 10)  | 0xD800;
          *dst++ = (ch & 0x3FF)| 0xDC00;
        }
      } else {
        count++;
        if (dst)
          *dst++ = 0x0000FFFD;
      }
      if (len > 0)
        len--;
    }
    return count;
  }

#if defined(WIDECHAR_IS_CHAR16)
  #if defined(__ANDROID__)
  // NOTE: vswprintf does not work on Android/bionic currently
  //    See https://code.google.com/p/android/issues/detail?id=20567
  //        https://groups.google.com/forum/#!topic/android-ndk/fBqGZDOIn7E
  static int vsnwprintf(UnicodeString& dst, const wchar_t* fmt, va_list paramList)
  {
    UTF8String _fmt8(fmt);
    const char* pFmt = _fmt8.c_str();

    UTF8String _buf;
    int _size = 16;
    _buf.SetLength(_size);
    char *pBuf = static_cast<char*>(const_cast<void*>(_buf.data()));

    int count = vsnprintf(pBuf, _size+1, pFmt, paramList);
    if (!count)
    {
      dst.SetLength(0);
      return 0;
    }
    
    if (count < 0)
      return count;
    
    if (count > _size)
    {
      _size = count;
      _buf.SetLength(_size);
      pBuf = static_cast<char*>(const_cast<void*>(_buf.data()));
      count = vsnprintf(pBuf, _size+1, pFmt, paramList);
    }
    else if (count < _size)
    {
      _buf.SetLength(count);
    }

    if (!count)
    {
      dst.SetLength(0);
    }
    else if (count > 0)
    {
      dst = _buf;
      count = dst.Length();
    }
    return count;
  }
  #else
  static int vsnwprintf(TAPtr<wchar_t>& _buf, const wchar_t* fmt, va_list paramList)
  {
    int _size = 16;
    _buf = new wchar_t[_size];
    int count = vswprintf(&_buf[0], _size, fmt, paramList);
    while (count < 0)
    {
      _size <<= 1;
      _buf = new wchar_t[_size];
      count = vswprintf(&_buf[0], _size, fmt, paramList);
    }
    return count;
  }
  #endif
#endif

  static void dump(const UnicodeString& str, const char* f, int line)
  {
  #ifdef WIDECHAR_IS_WCHAR  // %ls is not valid for char16_t*
    printf("%s:%d -> Data(%p), Str='%ls', len(%d), refcount(%d)\n", f, line, str.data(), str.c_str(), str.Length(), str.RefCount());
  #endif
  }
  #define DUMP(s) dump(s, #s, __LINE__)

  void  __cdecl UnicodeString::ThrowIfOutOfRange(int idx) const
  {
    if (idx < 1 || idx > Length())    // NOTE: UnicodeString is 1-based !!
      throw System::Sysutils::ERangeError(System_Sysconst_SRangeError);
  }

  UnicodeString::UnicodeString(const char* src): Data(0)
  {
#ifdef __ANDROID__
    // The Android startup sequence is such that global C++ objects cannot use
    // Delphi code as the .ctor section is executed before "System.main_app_entry"
    // is invoked, which means that "System.DelphiActivity" is not initialized yet.
    // So, to allow global UnicodeString instances, such as ...
    //
    //  System::String str("I am a global variable");
    //
    //  ... we will go directly to ICU. Ultimately the Delphi Unit Initialization
    // sequence should be updated to tolerate calls from C++ global objects. Or the
    // C++ startup code should initialize Delphi units early enough so that C++
    // global objects can safely access Delphi code.
    //
    InitICU();
    WideBuffer wbuff(src);
    *this = reinterpret_cast<WideChar*>(wbuff.c_str());
#else    
    System::Internal::Strhlpr::UnicodeFromPChar(*this, const_cast<char*>(src));
#endif
  }

  UnicodeString::UnicodeString(const UnicodeString& src)
  {
    // UStrAddRef
    if (this == &src) {
      if (Data && reinterpret_cast<const StrRec*>(Data)[-1].refCnt > 0) {
        System::Syncobjs::TInterlocked::Increment((reinterpret_cast<StrRec*>(Data)[-1].refCnt));
      }
      return;
    }
    Data = 0;
    System::Internal::Strhlpr::UnicodeAssign(*this, const_cast<UnicodeString&>(src));
  }

#if !defined(_DELPHI_NEXTGEN)
  UnicodeString::UnicodeString(const WideString& src): Data(0)
  {
    System::Internal::Strhlpr::UnicodeFromWide(*this, _STR_CAST(WideString&, src));
  }
#endif

  UnicodeString::UnicodeString(const WideChar* src, int len) : Data(0)
  {
    if (len == -1) {
      len = WideCharLen(src);
    }
    if (src && (len > 0))
    {
      SetLength(len);
      memcpy(Data, src, len*sizeof(WideChar));
    }
  }

  UnicodeString::UnicodeString(const WideChar* src) : Data(0)
  {
    if (src && *src)
    {
      int len = WideCharLen(src);
      SetLength(len);
      memcpy(Data, src, len*sizeof(WideChar));
    }
  }

#if defined(WIDECHAR_IS_WCHAR)
  UnicodeString::UnicodeString(const char16_t* src, int numChar16/*= -1*/) : Data(0)
  {
    if (src && (numChar16 != 0))
    {
      int len = (numChar16 == -1) ? WideCharLen(src) : numChar16;
      SetLength(len);
      memcpy(Data, src, len*sizeof(char16_t));
    }
  }
#endif

#if defined(WIDECHAR_IS_CHAR16)
  UnicodeString::UnicodeString(const wchar_t* src, int numWChar /*= -1*/) : Data(0)
  {
    if (src && (numWChar != 0))
    {
      int len = UTF32ToUTF16((const char32_t*)src, 0, numWChar);
      SetLength(len);
      UTF32ToUTF16((const char32_t*)src, Data, numWChar);
    }
  }
#endif

  UnicodeString::UnicodeString(const char32_t* src, int numChar32/*= -1*/) : Data(0)
  {
    if (src && (numChar32 != 0))
    {
      int len = UTF32ToUTF16(src, 0, numChar32);
      SetLength(len);
      UTF32ToUTF16(src, Data, numChar32);
    }
  }

  UnicodeString::UnicodeString(const char* src, int len) : Data(0)
  {
#if !defined(_DELPHI_NEXTGEN)
    AnsiString str(src, len);
    System::Internal::Strhlpr::UnicodeFromAnsi(*this, *PRawByteString(&str));
#else
  #ifdef __ANDROID__
    // See comment in UnicodeString(const char*) about Android and global objects
    //
    InitICU();
    WideBuffer wbuff(src, len);
    *this = UnicodeString(reinterpret_cast<WideChar*>(wbuff.c_str()), wbuff.getLen());
  #else    
    System::Internal::Strhlpr::UnicodeFromAnsi(*this, 0, const_cast<char*>(src), len);
  #endif
#endif
  }

  UnicodeString::UnicodeString(double src) : Data(0)
  {
    *this = System::Sysutils::FloatToStr(src);
  }

  UnicodeString::~UnicodeString()
  {
    System::Internal::Strhlpr::UnicodeFree(*this);
  }

  UnicodeString& UnicodeString::operator=(const UnicodeString& src)
  {
    System::Internal::Strhlpr::UnicodeAssign(*this, const_cast<UnicodeString&>(src));
    return *this;
  }

  UnicodeString& UnicodeString::operator+=(const UnicodeString& src)
  {
    System::Internal::Strhlpr::UnicodeAppend(*this, _STR_CAST(UnicodeString&, src));
    return *this;
  }

  UnicodeString UnicodeString::operator+(const UnicodeString& rhs) const
  {
    UnicodeString tmp(*this);
    System::Internal::Strhlpr::UnicodeAppend(tmp, _STR_CAST(UnicodeString&, rhs));
    return tmp;
  }

  bool UnicodeString::operator==(const UnicodeString& other) const
  {
    return System::Internal::Strhlpr::UnicodeEqual(_STR_CAST(UnicodeString&, *this), _STR_CAST(UnicodeString&, other));
  }

  bool UnicodeString::operator!=(const UnicodeString& other) const
  {
    return !System::Internal::Strhlpr::UnicodeEqual(_STR_CAST(UnicodeString&, *this), _STR_CAST(UnicodeString&, other));
  }

  bool UnicodeString::operator<(const UnicodeString& other) const
  {
    return System::Internal::Strhlpr::UnicodeLess(_STR_CAST(UnicodeString&, *this), _STR_CAST(UnicodeString&, other));
  }

  bool UnicodeString::operator>(const UnicodeString& other) const
  {
    return System::Internal::Strhlpr::UnicodeGreater(_STR_CAST(UnicodeString&, *this), _STR_CAST(UnicodeString&, other));
  }

  bool UnicodeString::operator<=(const UnicodeString& rhs) const
  {
    return !operator>(rhs);
  }

  bool UnicodeString::operator >=(const UnicodeString& rhs) const
  {
    return !operator<(rhs);
  }

  int UnicodeString::Compare(const UnicodeString& rhs) const
  {
    if (rhs.Data == Data) {
      return 0;
    }
    if (!Data || !rhs.Data) {
      return Data ? 1 : -1;
    }
#if defined(_Windows)
    return ::CompareStringW(LOCALE_USER_DEFAULT, 0, Data, Length(),
                            rhs.Data, rhs.Length()) - CSTR_EQUAL;
#else
    return System::Sysutils::AnsiCompareStr(*this, rhs);
#endif
  }

  int UnicodeString::CompareIC(const UnicodeString& rhs) const
  {
    if (rhs.Data == Data) {
      return 0;
    }
    if (!Data || !rhs.Data) {
      return Data ? 1 : -1;
    }
#if defined(_Windows)
    return ::CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE, Data, Length(),
                            rhs.Data, rhs.Length()) - CSTR_EQUAL;
#else
    return System::Sysutils::AnsiCompareText(*this, rhs);
#endif
  }

  UnicodeString UnicodeString::StringOfChar(WideChar ch, int count)
  {
    UnicodeString tmp;
    tmp.SetLength(count);
    WideChar* p = tmp.Data;
    while (count--)
      *p++ = ch;
    return tmp;
  }

#if !defined(_DELPHI_NEXTGEN)
  UnicodeString UnicodeString::LoadStr(int ident)
  {
    return System::Sysutils::LoadStr(ident);
  }

#if defined(_Windows)
  UnicodeString UnicodeString::LoadStr(HINSTANCE hInstance, int ident)
  {
    UnicodeString str;
    str.LoadString(hInstance, ident);
    return str;
  }

  UnicodeString& UnicodeString::LoadString(HINSTANCE hInstance, int id)
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
            SetLength(len);
            wchar_t* p = Data;
            int i = len;
            while (i--)
              *p++ = *resData++;
            if (len > 0)
              Data[len] = 0;
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

  UnicodeString UnicodeString::FmtLoadStr(int ident, const TVarRec* args, int size)
  {
#if defined(_DELPHI_STRING_UNICODE)
    return System::Sysutils::FmtLoadStr(ident, args, size);
#else
    // In ANSI mode the Delphi RTL does not expose this
    // this functionality for UnicodeStrings.
    // Hence, potential data loss!
    return System::Sysutils::FmtLoadStr(ident, args, size);
#endif
  }
#endif

  UnicodeString UnicodeString::Format(const UnicodeString& format, const TVarRec *args, int size)
  {
#if defined(_DELPHI_STRING_UNICODE)
    return System::Sysutils::Format(format, args, size);
#else
    // In ANSI mode the Delphi RTL does not expose this
    // this functionality for UnicodeStrings.
    // We use WideFormat instead
    return System::Sysutils::WideFormat(WideString(format), args, size);
#endif
  }

  UnicodeString UnicodeString::FormatFloat(const UnicodeString& format, const long double& value)
  {
#if defined(_DELPHI_STRING_UNICODE)
    return System::Sysutils::FormatFloat(format, value);
#else
    // In ANSI mode the Delphi RTL does not expose this
    // this functionality for UnicodeStrings.
    return System::Sysutils::FormatFloat(format, value);
#endif
  }


#undef vprintf
#undef printf
#undef sprintf

  int __cdecl UnicodeString::vprintf(const wchar_t* format, va_list paramList)
  {
#if !defined(WIDECHAR_IS_CHAR16)
    int size = vsnwprintf(NULL, 0, format, paramList);
    SetLength(size);
    return size ? vsnwprintf(Data, size + 1, format, paramList) : 0;
#else
  #if defined(__ANDROID__)
     return vsnwprintf(*this, format, paramList);
  #else
    TAPtr<wchar_t> _buf;
    int size = vsnwprintf(_buf, format, paramList);
    if (size >= 0)
    {
      UnicodeString temp(&_buf[0], size);
      temp.swap(*this);
    }
    return size;
  #endif
#endif
  }

  int __cdecl UnicodeString::cat_vprintf(const wchar_t* format, va_list paramList)
  {
#if !defined(WIDECHAR_IS_CHAR16)
    int size = vsnwprintf(NULL, 0, format, paramList);

    if (!size)
      return 0;

    int len = Length();
    SetLength(len + size);
    return vsnwprintf(Data + len, size + 1, format, paramList);
#else
  #if defined(__ANDROID__)
    UnicodeString temp;
    int size = vsnwprintf(temp, format, paramList);
    if (size > 0)
      this->operator+=(temp);
    return size;
  #else
    TAPtr<wchar_t> _buf;

    int size = vsnwprintf(_buf, format, paramList);
    if (size >= 0)
    {
      UnicodeString temp(&_buf[0], size);
      this->operator+=(temp);
    }
    return size;
  #endif
#endif
  }

  int __cdecl UnicodeString::printf(const wchar_t* format, ...)
  {
    int rc;
    va_list paramList;
    va_start(paramList, format);
    rc = vprintf(format, paramList);
    va_end(paramList);
    return rc;
  }

  UnicodeString& __cdecl UnicodeString::sprintf(const wchar_t* format, ...)
  {
    va_list paramList;
    va_start(paramList, format);
    vprintf(format, paramList);
    va_end(paramList);
    return *this;
  }

  int __cdecl UnicodeString::cat_printf(const wchar_t* format, ...)
  {
    int rc;
    va_list paramList;
    va_start(paramList, format);
    rc = cat_vprintf(format, paramList);
    va_end(paramList);
    return rc;
  }

  UnicodeString& __cdecl UnicodeString::cat_sprintf(const wchar_t* format, ...)
  {
    va_list paramList;
    va_start(paramList, format);
    cat_vprintf(format, paramList);
    va_end(paramList);
    return *this;
  }

  UnicodeString UnicodeString::FloatToStrF(long double value, TStringFloatFormat format, int precision, int digits)
  {
    return System::Sysutils::FloatToStrF(value, System::Sysutils::TFloatFormat(format), precision, digits);
  }

  UnicodeString UnicodeString::IntToHex(int value, int digits)
  {
    return System::Sysutils::IntToHex(value, digits);
  }

  UnicodeString UnicodeString::CurrToStr(Currency value)
  {
    return System::Sysutils::CurrToStr(value);
  }

  UnicodeString UnicodeString::CurrToStrF(Currency value, TStringFloatFormat format, int digits)
  {
    return System::Sysutils::CurrToStrF(value, System::Sysutils::TFloatFormat(format), digits);
  }

  UnicodeString& UnicodeString::Unique()
  {
    System::UniqueString(*this);
    return *this;
  }

  UnicodeString& UnicodeString::Insert1(const UnicodeString& source, int index)
  {
    System::Internal::Strhlpr::UnicodeInsert(*this, _STR_CAST(UnicodeString&, source), index);
    return *this;
  }

  UnicodeString& UnicodeString::Insert0(const UnicodeString& source, int index)
  {
    return Insert1(source, index+1);
  }

  UnicodeString& UnicodeString::Delete1(int index, int count)
  {
    System::Internal::Strhlpr::UnicodeDelete(*this, index, count);
    return *this;
  }

  UnicodeString& UnicodeString::Delete0(int index, int count)
  {
    return Delete1(index+1, count);
  }

  UnicodeString& UnicodeString::SetLength(int newLength)
  {
    System::Internal::Strhlpr::UnicodeSetLength(*this, newLength);
    return *this;
  }

  int UnicodeString::Pos1(const UnicodeString& subStr) const
  {
    return System::Internal::Strhlpr::UnicodePos(_STR_CAST(UnicodeString&, *this), _STR_CAST(UnicodeString&, subStr));
  }

  int UnicodeString::Pos0(const UnicodeString& subStr) const
  {
    return Pos1(subStr) - 1;
  }

  UnicodeString UnicodeString::LowerCase() const
  {
    return System::Sysutils::AnsiLowerCase(*this);
  }

  UnicodeString UnicodeString::UpperCase() const
  {
    return System::Sysutils::AnsiUpperCase(*this);
  }

  UnicodeString UnicodeString::Trim() const
  {
    return System::Sysutils::Trim(*this);
  }

  UnicodeString UnicodeString::TrimLeft() const
  {
    return System::Sysutils::TrimLeft(*this);
  }

  UnicodeString UnicodeString::TrimRight() const
  {
    return System::Sysutils::TrimRight(*this);
  }

  UnicodeString UnicodeString::SubString1(int index, int count) const
  {
    // This method is intended to be compatible with Delphi's Copy().
    // Be careful when reordering parameter validation to maintain the
    // semantics!
    const int len = Length();
    if (index > len || count < 1)
      return UnicodeString();
    if (index < 1)
      index = 1;
    int n = len - index + 1;
    if (n > count)
      n = count;
    return UnicodeString(Data + index - 1, n);
  }

  UnicodeString UnicodeString::SubString0(int index, int count) const
  {
    // This method is intended to be compatible with Delphi's Copy().
    // Be careful when reordering parameter validation to maintain the
    // semantics!
    const int len = Length();
    if (index >= len || count < 1)
      return UnicodeString();
    if (index < 0)
      index = 0;
    int n = len - index;
    if (n > count)
      n = count;
    return UnicodeString(Data + index, n);
  }

  int UnicodeString::ToInt() const
  {
    return System::Sysutils::StrToInt(*this);
  }

  int UnicodeString::ToIntDef(int defaultValue) const
  {
    return System::Sysutils::StrToIntDef(*this, defaultValue);
  }

  double UnicodeString::ToDouble() const
  {
    return System::Sysutils::StrToFloat(*this);
  }

  bool UnicodeString::IsDelimiter1(const UnicodeString& delimiters, int index) const
  {
    return System::Sysutils::IsDelimiter(delimiters, *this, index);
  }

  bool UnicodeString::IsDelimiter0(const UnicodeString& delimiters, int index) const
  {
    return IsDelimiter1(delimiters, index+1);
  }

  bool UnicodeString::IsPathDelimiter1(int index) const
  {
    return System::Sysutils::IsPathDelimiter(*this, index);
  }

  bool UnicodeString::IsPathDelimiter0(int index) const
  {
    return IsPathDelimiter1(index+1);
  }

  int UnicodeString::LastDelimiter1(const UnicodeString& delimiters) const
  {
    return System::Sysutils::LastDelimiter(delimiters, *this);
  }

  int UnicodeString::LastDelimiter0(const UnicodeString& delimiters) const
  {
    return LastDelimiter1(delimiters)-1;
  }

  UnicodeString::TStringLeadCharType UnicodeString::ByteType1(int index) const
  {
    return UnicodeString::TStringLeadCharType(Sysutils::ByteType(*this, index));
  }

  UnicodeString::TStringLeadCharType UnicodeString::ByteType0(int index) const
  {
    return ByteType(index+1);
  }

  bool UnicodeString::IsLeadSurrogate1(int index) const
  {
    return ByteType(index) == ctbLeadSurrogate;
  }

  bool UnicodeString::IsLeadSurrogate0(int index) const
  {
    return IsLeadSurrogate1(index+1);
  }

  bool UnicodeString::IsTrailSurrogate1(int index) const
  {
    return ByteType(index) == ctTrailSurrogate;
  }

  bool UnicodeString::IsTrailSurrogate0(int index) const
  {
    return IsTrailSurrogate1(index+1);
  }

  DynamicArray<System::Byte> UnicodeString::BytesOf() const
  {
    return System::Sysutils::BytesOf(*this);
  }

  UnicodeString operator+(const char* lhs, const UnicodeString& rhs)
  {
    UnicodeString tmp(lhs);
    return System::Internal::Strhlpr::UnicodeCat(tmp, _STR_CAST(UnicodeString&, rhs));
  }

  UnicodeString operator+(const wchar_t* lhs, const UnicodeString& rhs)
  {
    UnicodeString tmp(lhs);
    return System::Internal::Strhlpr::UnicodeCat(tmp, _STR_CAST(UnicodeString&, rhs));
  }

  UnicodeString operator+(const char16_t* lhs, const UnicodeString& rhs)
  {
    UnicodeString tmp(lhs);
    return System::Internal::Strhlpr::UnicodeCat(tmp, _STR_CAST(UnicodeString&, rhs));
  }

  UnicodeString operator+(const char32_t* lhs, const UnicodeString& rhs)
  {
    UnicodeString tmp(lhs);
    return System::Internal::Strhlpr::UnicodeCat(tmp, _STR_CAST(UnicodeString&, rhs));
  }

  const WideChar* UnicodeString::FirstChar() const
  {
    return Data;
  }

  const WideChar* UnicodeString::LastChar() const
  {
    return System::Sysutils::AnsiLastChar(*PUnicodeString(this));
  }
  
  WideChar* UnicodeString::FirstChar()
  {
    return Data;
  }

  WideChar* UnicodeString::LastChar()
  {
    return System::Sysutils::AnsiLastChar(*PUnicodeString(this));
  }
  
  UnicodeString& UnicodeString::swap(UnicodeString& other)
  {
    Data = reinterpret_cast<System::WideChar*>(
          System::Syncobjs::TInterlocked::Exchange(reinterpret_cast<void*&>(other.Data),
                                                   reinterpret_cast<void*>(Data)));
    return *this;
  }

} // System Namespace
