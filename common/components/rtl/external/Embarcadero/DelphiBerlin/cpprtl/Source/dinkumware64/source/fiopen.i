#line 1 "fiopen.cpp"
#line 1 "fiopen.cpp"
#line 1 "<built-in>"
#line 1 "<built-in>"
#line 159 "<built-in>"
#line 1 "<command line>"
#line 1 "<built-in>"
#line 1 "fiopen.cpp"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\istream"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\ostream"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\ios"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"



#line 1 "C:\\src\\winrtl\\include\\climits"
#line 10 "C:\\src\\winrtl\\include\\climits"
#line 1 "C:\\src\\winrtl\\include\\_lim.h"
#line 13 "C:\\src\\winrtl\\include\\_lim.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\_stddef.h"
#line 1 "C:\\src\\winrtl\\include\\_defs.h"
#line 14 "C:\\src\\winrtl\\include\\_stddef.h"




#line 1 "C:\\src\\winrtl\\include\\_null.h"
#line 18 "C:\\src\\winrtl\\include\\_stddef.h"
#line 38 "C:\\src\\winrtl\\include\\_stddef.h"
typedef int ssize_t;




namespace std {
#line 63 "C:\\src\\winrtl\\include\\_stddef.h"
   typedef unsigned int size_t;
#line 78 "C:\\src\\winrtl\\include\\_stddef.h"
typedef size_t rsize_t;




typedef int errno_t;
#line 99 "C:\\src\\winrtl\\include\\_stddef.h"
typedef int ptrdiff_t;
#line 123 "C:\\src\\winrtl\\include\\_stddef.h"
typedef wchar_t wint_t;
#line 132 "C:\\src\\winrtl\\include\\_stddef.h"
typedef wchar_t wctype_t;




typedef double max_align_t;




typedef decltype(nullptr) nullptr_t;



extern "C" {

extern unsigned long __cdecl __declspec(dllexport) __threadid(void);



}
#line 164 "C:\\src\\winrtl\\include\\_stddef.h"
}
#line 13 "C:\\src\\winrtl\\include\\_lim.h"
#line 10 "C:\\src\\winrtl\\include\\climits"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"

#line 1 "C:\\src\\winrtl\\include\\cmath"
#line 10 "C:\\src\\winrtl\\include\\cmath"
#line 1 "C:\\src\\winrtl\\include\\math.h"
#line 15 "C:\\src\\winrtl\\include\\math.h"
#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xtgmath.h"





#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xtr1common"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 79 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xkeycheck.h"
#line 79 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 285 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#pragma warn -inl
#line 501 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
typedef long _Int32t;
typedef unsigned long _Uint32t;






typedef int _Ptrdifft;






typedef unsigned int _Sizet;
#line 982 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
namespace std {}
#line 1137 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
namespace std {
typedef bool _Bool;
}
#line 1168 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 1 "C:\\src\\winrtl\\include\\stdarg.h"
#line 19 "C:\\src\\winrtl\\include\\stdarg.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 19 "C:\\src\\winrtl\\include\\stdarg.h"



namespace std {





typedef __builtin_va_list va_list;
#line 57 "C:\\src\\winrtl\\include\\stdarg.h"
}






     using std::va_list;
#line 1168 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 1298 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
typedef long long _Longlong;
typedef unsigned long long _ULonglong;
#line 1311 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
namespace std {
namespace tr1 {
using ::_Longlong;
using ::_ULonglong;
}
}
#line 1334 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
typedef wchar_t _Wchart;
typedef wchar_t _Wintt;
#line 1396 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
typedef va_list _Va_list;
#line 1413 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
namespace std {



extern "C" {
__declspec(dllexport) void _Atexit(void ( *)(void));
}
#line 1431 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
typedef char _Sysch_t;
#line 1445 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
}
#line 1500 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
namespace std {
enum _Uninitialized
 {
 _Noinit
 };

extern "C++" {

class __declspec(dllexport) _Lockit
 {
public:

 _Lockit()
  {
  }

 explicit _Lockit(int)
  {
  }

 ~_Lockit()
  {
  }
#line 1547 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
 _Lockit(const _Lockit&);
 _Lockit& operator=(const _Lockit&);

private:
 int _Locktype;
 };


class _Mutex
 {
public:
 _Mutex(_Uninitialized)
     {
     }

 _Mutex()
     {
     }

 void _Lock()
  {
  }

 void _Unlock()
  {
  }
 };
#line 1594 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
}
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xtr1common"


namespace std {

template<class _T1,
 class _Ret>
 struct unary_function;


template<class _T1,
 class _T2,
 class _Ret>
 struct binary_function;


struct _Nil
 {
 };
static _Nil _Nil_obj;


template<class _Ty,
 _Ty _Val>
 struct integral_constant
 {
 static const _Ty value = _Val;

 typedef _Ty value_type;
 typedef integral_constant<_Ty, _Val> type;

            operator value_type() const
  {
  return (value);
  }
 };

typedef integral_constant<bool, true> true_type;
typedef integral_constant<bool, false> false_type;


template<bool>
 struct _Cat_base
  : false_type
 {
 };

template<>
 struct _Cat_base<true>
  : true_type
 {
 };


template<bool _Test,
 class _Ty = void>
 struct enable_if
 {
 };

template<class _Ty>
 struct enable_if<true, _Ty>
 {
 typedef _Ty type;
 };


template<bool _Test,
 class _Ty1,
 class _Ty2>
 struct conditional
 {
 typedef _Ty2 type;
 };

template<class _Ty1,
 class _Ty2>
 struct conditional<true, _Ty1, _Ty2>
 {
 typedef _Ty1 type;
 };


template<class _Ty1, class _Ty2>
 struct is_same
  : false_type
 {
 };

template<class _Ty1>
 struct is_same<_Ty1, _Ty1>
  : true_type
 {
 };


template<class _Ty>
 struct remove_const
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct remove_const<const _Ty>
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct remove_const<const _Ty[]>
 {
 typedef _Ty type[];
 };

template<class _Ty, unsigned int _Nx>
 struct remove_const<const _Ty[_Nx]>
 {
 typedef _Ty type[_Nx];
 };


template<class _Ty>
 struct remove_volatile
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct remove_volatile<volatile _Ty>
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct remove_volatile<volatile _Ty[]>
 {
 typedef _Ty type[];
 };

template<class _Ty, unsigned int _Nx>
 struct remove_volatile<volatile _Ty[_Nx]>
 {
 typedef _Ty type[_Nx];
 };


template<class _Ty>
 struct remove_cv
 {
 typedef typename remove_const<typename remove_volatile<_Ty>::type>::type
  type;
 };


template<class _Ty>
 struct _Is_integral
  : false_type
 {
 };

template<>
 struct _Is_integral<bool>
  : true_type
 {
 };

template<>
 struct _Is_integral<char>
  : true_type
 {
 };

template<>
 struct _Is_integral<unsigned char>
  : true_type
 {
 };

template<>
 struct _Is_integral<signed char>
  : true_type
 {
 };

template<>
 struct _Is_integral<wchar_t>
  : true_type
 {
 };

template<>
 struct _Is_integral<unsigned short>
  : true_type
 {
 };

template<>
 struct _Is_integral<signed short>
  : true_type
 {
 };

template<>
 struct _Is_integral<unsigned int>
  : true_type
 {
 };

template<>
 struct _Is_integral<signed int>
  : true_type
 {
 };

template<>
 struct _Is_integral<unsigned long>
  : true_type
 {
 };

template<>
 struct _Is_integral<signed long>
  : true_type
 {
 };


template<>
 struct _Is_integral<char16_t>
  : true_type
 {
 };

template<>
 struct _Is_integral<char32_t>
  : true_type
 {
 };



template<>
 struct _Is_integral<long long>
  : true_type
 {
 };

template<>
 struct _Is_integral<unsigned long long>
  : true_type
 {
 };



template<class _Ty>
 struct is_integral
  : _Is_integral<typename remove_cv<_Ty>::type>
 {
 };


template<class _Ty>
 struct _Is_floating_point
  : false_type
 {
 };

template<>
 struct _Is_floating_point<float>
  : true_type
 {
 };

template<>
 struct _Is_floating_point<double>
  : true_type
 {
 };

template<>
 struct _Is_floating_point<long double>
  : true_type
 {
 };


template<class _Ty>
 struct is_floating_point
  : _Is_floating_point<typename remove_cv<_Ty>::type>
 {
 };

template<class _Ty>
 struct _Is_numeric
  : _Cat_base<is_integral<_Ty>::value
   || is_floating_point<_Ty>::value>
 {
 };


template<class _Ty>
 struct remove_reference
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct remove_reference<_Ty&>
 {
 typedef _Ty type;
 };


template<class _Ty>
 struct remove_reference<_Ty&&>
 {
 typedef _Ty type;
 };



template<class _Tgt,
 class _Src>
 struct _Copy_cv
 {
 typedef typename remove_reference<_Tgt>::type _Tgtx;
 typedef _Tgtx& type;
 };

template<class _Tgt,
 class _Src>
 struct _Copy_cv<_Tgt, const _Src>
 {
 typedef typename remove_reference<_Tgt>::type _Tgtx;
 typedef const _Tgtx& type;
 };

template<class _Tgt,
 class _Src>
 struct _Copy_cv<_Tgt, volatile _Src>
 {
 typedef typename remove_reference<_Tgt>::type _Tgtx;
 typedef volatile _Tgtx& type;
 };

template<class _Tgt,
 class _Src>
 struct _Copy_cv<_Tgt, const volatile _Src>
 {
 typedef typename remove_reference<_Tgt>::type _Tgtx;
 typedef const volatile _Tgtx& type;
 };

template<class _Tgt,
 class _Src>
 struct _Copy_cv<_Tgt, _Src&>
 {
 typedef typename _Copy_cv<_Tgt, _Src>::type type;
 };


struct _Wrap_int
 {
 _Wrap_int(int)
  {
  }
 };

template<class _Ty>
 struct _Identity
 {
 typedef _Ty type;
 };
#line 458 "C:\\src\\winrtl\\include\\dinkumware64\\xtr1common"
template<class _Ty>
 struct _Has_result_type
  { template<class _Uty> static auto _Fn(int, _Identity<typename _Uty::result_type> * = 0, _Identity<typename _Uty::result_type> * = 0, _Identity<typename _Uty::result_type> * = 0) -> true_type; template<class _Uty> static auto _Fn(_Wrap_int) -> false_type; typedef decltype(_Fn<_Ty>(0)) type; };
}
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\xtgmath.h"


namespace std {
template<class _Ty>
 struct _Promote_to_float
 {
 typedef typename conditional<is_integral<_Ty>::value,
  double, _Ty>::type type;
 };

template<class _Ty1,
 class _Ty2>
 struct _Common_float_type
 {
 typedef typename _Promote_to_float<_Ty1>::type _Ty1f;
 typedef typename _Promote_to_float<_Ty2>::type _Ty2f;
 typedef typename conditional<is_same<_Ty1f, long double>::value
  || is_same<_Ty2f, long double>::value, long double,
  typename conditional<is_same<_Ty1f, double>::value
   || is_same<_Ty2f, double>::value, double,
   float>::type>::type type;
 };
}
#line 64 "C:\\src\\winrtl\\include\\dinkumware64\\xtgmath.h"
namespace std {
extern "C" __declspec(dllexport) double pow(double, double);
float pow(float, float);
long double pow(long double, long double);

template<class _Ty1,
 class _Ty2> inline
 typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value
  && ::std:: _Is_numeric<_Ty2>::value,
  typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type
 pow(const _Ty1 _Left, const _Ty2 _Right)
 {
 typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type;
 return (::std:: pow(type(_Left), type(_Right)));
 }


extern "C" double acos(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type acos(_Ty _Left) { return (::std:: acos((double)_Left)); }
extern "C" double asin(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type asin(_Ty _Left) { return (::std:: asin((double)_Left)); }
extern "C" double atan(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type atan(_Ty _Left) { return (::std:: atan((double)_Left)); }
extern "C" double atan2(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type atan2(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: atan2((type)_Left, (type)_Right)); }
extern "C" double ceil(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type ceil(_Ty _Left) { return (::std:: ceil((double)_Left)); }
extern "C" double cos(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type cos(_Ty _Left) { return (::std:: cos((double)_Left)); }
extern "C" double cosh(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type cosh(_Ty _Left) { return (::std:: cosh((double)_Left)); }
extern "C" double exp(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type exp(_Ty _Left) { return (::std:: exp((double)_Left)); }

extern "C" double floor(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type floor(_Ty _Left) { return (::std:: floor((double)_Left)); }
extern "C" double fmod(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type fmod(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: fmod((type)_Left, (type)_Right)); }
extern "C" double frexp(double, int *); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type frexp(_Ty _Left, int * _Arg2) { return (::std:: frexp((double)_Left, _Arg2)); }
extern "C" double ldexp(double, int); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type ldexp(_Ty _Left, int _Arg2) { return (::std:: ldexp((double)_Left, _Arg2)); }
extern "C" double log(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type log(_Ty _Left) { return (::std:: log((double)_Left)); }
extern "C" double log10(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type log10(_Ty _Left) { return (::std:: log10((double)_Left)); }


extern "C" double sin(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type sin(_Ty _Left) { return (::std:: sin((double)_Left)); }
extern "C" double sinh(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type sinh(_Ty _Left) { return (::std:: sinh((double)_Left)); }
extern "C" double sqrt(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type sqrt(_Ty _Left) { return (::std:: sqrt((double)_Left)); }
extern "C" double tan(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type tan(_Ty _Left) { return (::std:: tan((double)_Left)); }
extern "C" double tanh(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type tanh(_Ty _Left) { return (::std:: tanh((double)_Left)); }
#line 115 "C:\\src\\winrtl\\include\\dinkumware64\\xtgmath.h"
template<class _Ty1,
 class _Ty2,
 class _Ty3> inline
 typename ::std:: _Common_float_type<_Ty1,
  typename ::std:: _Common_float_type<_Ty2, _Ty3>::type>::type
 fma(_Ty1 _Left, _Ty2 _Middle, _Ty3 _Right)
 {
 typedef typename ::std:: _Common_float_type<_Ty1,
  typename ::std:: _Common_float_type<_Ty2, _Ty3>::type>::type type;
 return (::std:: fma((type)_Left, (type)_Right));
 }


template<class _Ty1,
 class _Ty2> inline
 typename ::std:: _Common_float_type<_Ty1, _Ty2>::type
 remquo(_Ty1 _Left, _Ty2 _Right, int *_Pquo)
 {
 typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type;
 return (::std:: remquo((type)_Left, (type)_Right, _Pquo));
 }

extern "C" double acosh(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type acosh(_Ty _Left) { return (::std:: acosh((double)_Left)); }
extern "C" double asinh(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type asinh(_Ty _Left) { return (::std:: asinh((double)_Left)); }
extern "C" double atanh(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type atanh(_Ty _Left) { return (::std:: atanh((double)_Left)); }
extern "C" double cbrt(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type cbrt(_Ty _Left) { return (::std:: cbrt((double)_Left)); }
extern "C" double copysign(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type copysign(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: copysign((type)_Left, (type)_Right)); }
extern "C" double erf(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type erf(_Ty _Left) { return (::std:: erf((double)_Left)); }
extern "C" double erfc(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type erfc(_Ty _Left) { return (::std:: erfc((double)_Left)); }
extern "C" double expm1(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type expm1(_Ty _Left) { return (::std:: expm1((double)_Left)); }
extern "C" double exp2(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type exp2(_Ty _Left) { return (::std:: exp2((double)_Left)); }
extern "C" double fabs(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type fabs(_Ty _Left) { return (::std:: fabs((double)_Left)); }
extern "C" double fdim(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type fdim(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: fdim((type)_Left, (type)_Right)); }

extern "C" double fmax(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type fmax(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: fmax((type)_Left, (type)_Right)); }
extern "C" double fmin(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type fmin(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: fmin((type)_Left, (type)_Right)); }
extern "C" double hypot(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type hypot(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: hypot((type)_Left, (type)_Right)); }
extern "C" int ilogb(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, int>::type ilogb(_Ty _Left) { return (::std:: ilogb((double)_Left)); }
extern "C" double lgamma(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type lgamma(_Ty _Left) { return (::std:: lgamma((double)_Left)); }
extern "C" long long llrint(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, long long>::type llrint(_Ty _Left) { return (::std:: llrint((double)_Left)); }
extern "C" long long llround(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, long long>::type llround(_Ty _Left) { return (::std:: llround((double)_Left)); }
extern "C" double log1p(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type log1p(_Ty _Left) { return (::std:: log1p((double)_Left)); }
extern "C" double log2(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type log2(_Ty _Left) { return (::std:: log2((double)_Left)); }
extern "C" double logb(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type logb(_Ty _Left) { return (::std:: logb((double)_Left)); }
extern "C" long lrint(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, long>::type lrint(_Ty _Left) { return (::std:: lrint((double)_Left)); }
extern "C" long lround(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, long>::type lround(_Ty _Left) { return (::std:: lround((double)_Left)); }
extern "C" double nearbyint(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type nearbyint(_Ty _Left) { return (::std:: nearbyint((double)_Left)); }
extern "C" double nextafter(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type nextafter(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: nextafter((type)_Left, (type)_Right)); }
extern "C" double nexttoward(double, long double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type nexttoward(_Ty _Left, long double _Arg2) { return (::std:: nexttoward((double)_Left, _Arg2)); }
extern "C" double remainder(double, double); template<class _Ty1, class _Ty2> inline typename ::std:: enable_if< ::std:: _Is_numeric<_Ty1>::value && ::std:: _Is_numeric<_Ty2>::value, typename ::std:: _Common_float_type<_Ty1, _Ty2>::type>::type remainder(_Ty1 _Left, _Ty2 _Right) { typedef typename ::std:: _Common_float_type<_Ty1, _Ty2>::type type; return (::std:: remainder((type)_Left, (type)_Right)); }

extern "C" double rint(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type rint(_Ty _Left) { return (::std:: rint((double)_Left)); }
extern "C" double round(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type round(_Ty _Left) { return (::std:: round((double)_Left)); }
extern "C" double scalbln(double, long); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type scalbln(_Ty _Left, long _Arg2) { return (::std:: scalbln((double)_Left, _Arg2)); }
extern "C" double scalbn(double, int); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type scalbn(_Ty _Left, int _Arg2) { return (::std:: scalbn((double)_Left, _Arg2)); }
extern "C" double tgamma(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type tgamma(_Ty _Left) { return (::std:: tgamma((double)_Left)); }
extern "C" double trunc(double); template<class _Ty> inline typename ::std:: enable_if< ::std:: is_integral<_Ty>::value, double>::type trunc(_Ty _Left) { return (::std:: trunc((double)_Left)); }
}
#line 15 "C:\\src\\winrtl\\include\\math.h"




#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 19 "C:\\src\\winrtl\\include\\math.h"








#pragma pack(push, 1)







  extern "C" {
#line 64 "C:\\src\\winrtl\\include\\math.h"
struct _exception
{
    int type;
    char *name;
    double arg1, arg2, retval;
};

struct _exceptionl
{
    int type;
    char *name;
    long double arg1, arg2, retval;
};

typedef enum
{
    DOMAIN = 1,
    SING,
    OVERFLOW,
    UNDERFLOW,
    TLOSS,
    PLOSS,
    STACKFAULT
} _mexcep;

int _matherr(struct _exception *__e);
int _matherrl(struct _exceptionl *__e);


}
#line 115 "C:\\src\\winrtl\\include\\math.h"
  namespace std {
#line 140 "C:\\src\\winrtl\\include\\math.h"
extern "C" {


extern double __declspec(dllexport) _huge_dble;
extern long double __declspec(dllexport) _huge_ldble;
#line 154 "C:\\src\\winrtl\\include\\math.h"
float __declspec(dllexport) atan2f(float, float);
float __declspec(dllexport) ceilf(float);
float __declspec(dllexport) cosf(float);
float __declspec(dllexport) expf(float);
float __declspec(dllexport) floorf(float);
float __declspec(dllexport) ldexpf(float, int);
float __declspec(dllexport) logf(float);
float __declspec(dllexport) powf(float, float);
float __declspec(dllexport) sinf(float);
float __declspec(dllexport) sqrtf(float);
float __declspec(dllexport) tanf(float);


float __declspec(dllexport) acosf(float);
float __declspec(dllexport) asinf(float);
float __declspec(dllexport) atanf(float);
float __declspec(dllexport) coshf(float);
float __declspec(dllexport) fabsf(float);
float __declspec(dllexport) fmodf(float, float);
float __declspec(dllexport) frexpf(float, int *);
float __declspec(dllexport) hypotf(float, float);
float __declspec(dllexport) log10f(float);
float __declspec(dllexport) modff(float, float *);
float __declspec(dllexport) sinhf(float);
float __declspec(dllexport) tanhf(float);

float __declspec(dllexport) nanf(const char*);
double __declspec(dllexport) nan(const char*);
long double __declspec(dllexport) nanl(const char*);

float __declspec(dllexport) roundf(float);
double __declspec(dllexport) round(double);
long double __declspec(dllexport) roundl(long double);

float __declspec(dllexport) acoshf(float);
float __declspec(dllexport) asinhf(float);
float __declspec(dllexport) atanhf(float);
double __declspec(dllexport) acosh(double);
double __declspec(dllexport) asinh(double);
double __declspec(dllexport) atanh(double);
long double __declspec(dllexport) acoshl(long double);
long double __declspec(dllexport) asinhl(long double);
long double __declspec(dllexport) atanhl(long double);

float __declspec(dllexport) expm1f (float __x);
double __declspec(dllexport) expm1 (double __x);
long double __declspec(dllexport) expm1l (long double __x);

float __declspec(dllexport) log2f(float);
double __declspec(dllexport) log2(double);
long double __declspec(dllexport) log2l(long double);

float __declspec(dllexport) log1pf(float);
double __declspec(dllexport) log1p(double);
long double __declspec(dllexport) log1pl(long double);

float __declspec(dllexport) copysignf(float, float);
double __declspec(dllexport) copysign(double, double);
long double __declspec(dllexport) copysignl(long double, long double);




double __declspec(dllexport) acos (double __x);
double __declspec(dllexport) asin (double __x);
double __declspec(dllexport) atan (double __x);
double __declspec(dllexport) atan2 (double __y, double __x);
double __declspec(dllexport) ceil (double __x);
double __declspec(dllexport) cos (double __x);
double __declspec(dllexport) cosh (double __x);
double __declspec(dllexport) exp (double __x);
double __declspec(dllexport) fabs (double __x);
double __declspec(dllexport) floor (double __x);
double __declspec(dllexport) fmod (double __x, double __y);
double __declspec(dllexport) frexp (double __x, int * __exponent);
double __declspec(dllexport) hypot (double __x, double __y);
double __declspec(dllexport) ldexp (double __x, int __exponent);
double __declspec(dllexport) log (double __x);
double __declspec(dllexport) log10 (double __x);
double __declspec(dllexport) modf (double __x, double * __ipart);
double __declspec(dllexport) pow (double __x, double __y);
double __declspec(dllexport) sin (double __x);
double __declspec(dllexport) sinh (double __x);
double __declspec(dllexport) sqrt (double __x);
double __declspec(dllexport) tan (double __x);
double __declspec(dllexport) tanh (double __x);

long double __declspec(dllexport) acosl (long double __x);
long double __declspec(dllexport) asinl (long double __x);
long double __declspec(dllexport) atan2l (long double __x, long double __y);
long double __declspec(dllexport) atanl (long double __x);
long double __declspec(dllexport) ceill (long double __x);
long double __declspec(dllexport) coshl (long double __x);
long double __declspec(dllexport) cosl (long double __x);
long double __declspec(dllexport) expl (long double __x);
long double __declspec(dllexport) fabsl (long double __x);
long double __declspec(dllexport) floorl (long double __x);
long double __declspec(dllexport) fmodl (long double __x, long double __y);
long double __declspec(dllexport) frexpl (long double __x, int * __exponent);
long double __declspec(dllexport) hypotl (long double __x, long double __y);
long double __declspec(dllexport) ldexpl (long double __x, int __exponent);
long double __declspec(dllexport) log10l (long double __x);
long double __declspec(dllexport) logl (long double __x);
long double __declspec(dllexport) modfl (long double __x, long double * __ipart);
long double __declspec(dllexport) powl (long double __x, long double __y);
long double __declspec(dllexport) sinhl (long double __x);
long double __declspec(dllexport) sinl (long double __x);
long double __declspec(dllexport) sqrtl (long double __x);
long double __declspec(dllexport) tanhl (long double __x);
long double __declspec(dllexport) tanl (long double __x);

double __declspec(dllexport) atof (const char * __s);
#line 280 "C:\\src\\winrtl\\include\\math.h"
int __declspec(dllexport) abs(int __x);


long __declspec(dllexport) labs (long __x);
double __declspec(dllexport) pow10 (int __p);

long double __declspec(dllexport) _atold (const char * __s);


double __declspec(dllexport) poly (double __x, int __degree, double __coeffs []);
long double __declspec(dllexport) polyl (long double __x, int __degree, long double __coeffs []);
long double __declspec(dllexport) pow10l (int __p);


__int64 __declspec(dllexport) _atoi64(const char * __s);
char * __declspec(dllexport) _i64toa(__int64 __value, char *__strP, int __radix);
char * __declspec(dllexport) _ui64toa(unsigned __int64 __value, char *__strP, int __radix);
__int64 __declspec(dllexport) _wtoi64(const wchar_t * __s);
wchar_t * __declspec(dllexport) _i64tow(__int64 __value, wchar_t *__strP, int __radix);
wchar_t * __declspec(dllexport) _ui64tow(unsigned __int64 __value, wchar_t *__strP, int __radix);

double __declspec(dllexport) _wtof(const wchar_t * __s);
int __declspec(dllexport) _wtoi(const wchar_t * __s);
long __declspec(dllexport) _wtol(const wchar_t * __s);
long double __declspec(dllexport) _wtold(const wchar_t * __s);






extern "C++" {
#line 372 "C:\\src\\winrtl\\include\\math.h"
inline float abs (float __x) { return (float)fabs((double)__x); }
inline float acos (float __x) { return (float)acos((double)__x); }
inline float asin (float __x) { return (float)asin((double)__x); }
inline float atan (float __x) { return (float)atan((double)__x); }
inline float atan2(float __x, float __y) { return (float)atan2((double)__x,(double)__y); }
inline float ceil (float __x) { return (float)ceil((double)__x); }
inline float cos (float __x) { return (float)cos((double)__x); }
inline float cosh (float __x) { return (float)cosh((double)__x); }
inline float exp (float __x) { return (float)exp((double)__x); }
inline float fabs (float __x) { return (float)fabs((double)__x); }
inline float floor(float __x) { return (float)floor((double)__x); }
inline float fmod (float __x, float __y) { return (float)fmod((double) __x,(double) __y); }
inline float frexp(float __x, int *__y) { return (float)frexp((double)__x,__y); }
inline float hypot(float __x, float __y) { return (float)hypot((double) __x,(double) __y); }
inline float ldexp(float __x, int __y) { return (float)ldexp((double)__x,__y); }
inline float log (float __x) { return (float)log((double)__x); }
inline float log10(float __x) { return (float)log10((double)__x); }
inline float pow (float __x, float __y) { return (float)pow((double)__x,(double)__y); }
inline float pow (float __x, int __y) { return (float)pow((double)__x,(double)__y); }
inline float sin (float __x) { return (float)sin((double)__x); }
inline float sinh (float __x) { return (float)sinh((double)__x); }
inline float sqrt (float __x) { return (float)sqrt((double)__x); }
inline float tan (float __x) { return (float)tan((double)__x); }
inline float tanh (float __x) { return (float)tanh((double)__x); }

inline float modf (float __x, float *__y)
{
  double __d;
  float __f = (float)modf((double)__x, &__d);
  *__y = (float) __d;
  return __f;
}

inline double abs(double __x) { return fabs(__x); }
inline double pow(double __x, int __y) { return pow(__x,(double)__y); }

inline long double abs (long double __x) { return fabsl(__x); }
inline long double acos (long double __x) { return acosl(__x); }
inline long double asin (long double __x) { return asinl(__x); }
inline long double atan (long double __x) { return atanl(__x); }
inline long double atan2(long double __x, long double __y) { return atan2l(__x,__y); }
inline long double ceil (long double __x) { return ceill(__x); }
inline long double cos (long double __x) { return cosl(__x); }
inline long double cosh (long double __x) { return coshl(__x); }
inline long double exp (long double __x) { return expl(__x); }
inline long double fabs (long double __x) { return fabsl(__x); }
inline long double floor(long double __x) { return floorl(__x); }
inline long double fmod (long double __x, long double __y) { return fmodl(__x,__y); }
inline long double hypot(long double __x, long double __y) { return hypotl(__x,__y); }
inline long double frexp(long double __x, int *__y) { return frexpl(__x,__y); }
inline long double ldexp(long double __x, int __y) { return ldexpl(__x,__y); }
inline long double log (long double __x) { return logl(__x); }
inline long double log10(long double __x) { return log10l(__x); }
inline long double modf (long double __x, long double *__y) { return modfl(__x,__y); }
inline long double pow (long double __x, long double __y) { return powl(__x,__y); }
inline long double pow (long double __x, int __y) { return powl(__x,(double)__y); }
inline long double sin (long double __x) { return sinl(__x); }
inline long double sinh (long double __x) { return sinhl(__x); }
inline long double sqrt (long double __x) { return sqrtl(__x); }
inline long double tan (long double __x) { return tanl(__x); }
inline long double tanh (long double __x) { return tanhl(__x); }


}




}
}





#pragma pack(pop)
#line 10 "C:\\src\\winrtl\\include\\cmath"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 13 "C:\\src\\winrtl\\include\\cmath"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"

#line 1 "C:\\src\\winrtl\\include\\cstdio"
#line 21 "C:\\src\\winrtl\\include\\cstdio"
#line 1 "C:\\src\\winrtl\\include\\stdio.h"
#line 14 "C:\\src\\winrtl\\include\\stdio.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\stdio.h"



#line 1 "C:\\src\\winrtl\\include\\_nfile.h"
#line 17 "C:\\src\\winrtl\\include\\stdio.h"





#line 1 "C:\\src\\winrtl\\include\\stdarg.h"
#line 22 "C:\\src\\winrtl\\include\\stdio.h"








namespace std {
#line 40 "C:\\src\\winrtl\\include\\stdio.h"
#pragma pack(push, 1)





typedef long fpos_t;


 typedef long off_t;





extern int _floatconvert;
#line 108 "C:\\src\\winrtl\\include\\stdio.h"
typedef struct
{
        unsigned char *curp;
        unsigned char *buffer;
        int level;
        int bsize;
        unsigned short istemp;
        unsigned short flags;
        wchar_t hold;
        char fd;
        unsigned char token;
} FILE;
#line 134 "C:\\src\\winrtl\\include\\stdio.h"
extern "C" {




extern FILE __declspec(dllexport) _streams[];
extern unsigned __declspec(dllexport) _nfile;
#line 155 "C:\\src\\winrtl\\include\\stdio.h"
FILE * __declspec(dllexport) __getStream( int );

}




extern "C" {







errno_t __declspec(dllexport) tmpfile_s(FILE * * streamptr);
errno_t __declspec(dllexport) tmpnam_s(char *__s, rsize_t __maxsize);
errno_t __declspec(dllexport) _wtmpnam_s(wchar_t *__s, rsize_t __maxsize);
errno_t __declspec(dllexport) fopen_s(FILE * * streamptr,
         const char *filename, const char *type);
errno_t __declspec(dllexport) _wfopen_s(FILE * * streamptr,
           const wchar_t *filename, const wchar_t *type);
errno_t __declspec(dllexport) freopen_s(FILE * * newstreamptr,
           const char * filename,
           const char * type,
           FILE * fp);
errno_t __declspec(dllexport) _wfreopen_s(FILE * * newstreamptr,
      const wchar_t * filename,
      const wchar_t * type,
      FILE * fp);
int __declspec(dllexport) fprintf_s(FILE * F, const char * fmt, ...);
int __declspec(dllexport) fwprintf_s(FILE * F, const wchar_t * fmt, ...);
int __declspec(dllexport) printf_s(const char * __format, ...);
int __declspec(dllexport) wprintf_s(const wchar_t * __format, ...);

int __declspec(dllexport) sprintf_s(char * __buffer, rsize_t __n,
           const char * __format, ...);
int __declspec(dllexport) swprintf_s(wchar_t * __buffer, rsize_t __n,
     const wchar_t * __format, ...);

int __declspec(dllexport) vsprintf_s(char * __buffer, rsize_t __n,
     const char * __format,
     va_list);
int __declspec(dllexport) vswprintf_s(wchar_t * __buffer, rsize_t __n,
      const wchar_t * __format,
      va_list);
int __declspec(dllexport) vprintf_s(const char * __format, va_list);
int __declspec(dllexport) vwprintf_s(const wchar_t * __format, va_list);
int __declspec(dllexport) snprintf_s(char * __buffer, rsize_t __nsize,
     const char * __format, ...);
int __declspec(dllexport) snwprintf_s(wchar_t * __buffer, rsize_t __nsize,
      const wchar_t * __format, ...);
int __declspec(dllexport) vfprintf_s(FILE * __stream, const char * __format,
     va_list);
int __declspec(dllexport) vfwprintf_s(FILE * __stream, const wchar_t * __format,
      va_list);
int __declspec(dllexport) vsnprintf_s(char * __buffer, rsize_t __nsize,
      const char * __format, va_list);
int __declspec(dllexport) vsnwprintf_s(wchar_t * __buffer, rsize_t __nsize,
       const wchar_t * __format, va_list);
char * __declspec(dllexport) gets_s(char * __s, rsize_t __n);
wchar_t* __declspec(dllexport) _getws_s(wchar_t * __s, rsize_t __n);
int __declspec(dllexport) sscanf_s(const char * __buffer,
          const char * __format, ...);
int __declspec(dllexport) swscanf_s(const wchar_t * __buffer,
           const wchar_t * __format, ...);
int __declspec(dllexport) fscanf_s(FILE * __stream, const char * __format, ...);
int __declspec(dllexport) fwscanf_s(FILE * __stream, const wchar_t * __format, ...);
int __declspec(dllexport) scanf_s(const char * __format, ...);
int __declspec(dllexport) wscanf_s(const wchar_t * __format, ...);
int __declspec(dllexport) vsscanf_s(const char * __buffer, const char * __format,
           va_list);
int __declspec(dllexport) vswscanf_s(const wchar_t * __buffer, const wchar_t * __format,
     va_list);
int __declspec(dllexport) vfscanf_s(FILE * __stream, const char * __format,
           va_list);
int __declspec(dllexport) vfwscanf_s(FILE * __stream, const wchar_t * __format,
     va_list);
int __declspec(dllexport) vscanf_s(const char * __format, va_list);
int __declspec(dllexport) vwscanf_s(const wchar_t * __format, va_list);
#line 243 "C:\\src\\winrtl\\include\\stdio.h"
void __declspec(dllexport) clearerr(FILE * __stream);
int __declspec(dllexport) fclose(FILE * __stream);
int __declspec(dllexport) fflush(FILE * __stream);
int __declspec(dllexport) fgetc(FILE * __stream);
std::wint_t __declspec(dllexport) fgetwc(FILE * __stream);
int __declspec(dllexport) fgetpos(FILE * __stream, fpos_t*__pos);
char * __declspec(dllexport) fgets(char * __s, int __n, FILE * __stream);
wchar_t* __declspec(dllexport) fgetws(wchar_t * __s, int __n, FILE * __stream);
FILE * __declspec(dllexport) fopen(const char * __path, const char * __mode);
FILE * __declspec(dllexport) _wfopen(const wchar_t * __path,
                                 const wchar_t * __mode);
int __declspec(dllexport) fprintf(FILE * __stream, const char * __format, ...);
int __declspec(dllexport) fwprintf(FILE * __stream, const wchar_t *__format, ...);
int __declspec(dllexport) fputc(int __c, FILE * __stream);
std::wint_t __declspec(dllexport) fputwc(std::wint_t __c, FILE * __stream);
int __declspec(dllexport) fputs(const char * __s, FILE * __stream);
int __declspec(dllexport) fputws(const wchar_t * __s, FILE * __stream);
std::size_t __declspec(dllexport) fread(void * __ptr, std::size_t __size, std::size_t __n,
                                 FILE * __stream);
FILE * __declspec(dllexport) freopen(const char * __path, const char * __mode,
                                 FILE * __stream);
FILE * __declspec(dllexport) _wfreopen(const wchar_t * __path, const wchar_t * __mode,
                                 FILE * __stream);
int __declspec(dllexport) fscanf(FILE * __stream, const char * __format, ...);
int __declspec(dllexport) fwscanf(FILE *__stream, const wchar_t *__format, ...);
int __declspec(dllexport) fseek(FILE * __stream, long __offset, int __whence);
int __declspec(dllexport) _fseeki64(FILE * __stream, __int64 __offset, int __whence);
int __declspec(dllexport) fsetpos(FILE * __stream, const fpos_t*__pos);
long __declspec(dllexport) ftell(FILE * __stream);
__int64 __declspec(dllexport) _ftelli64(FILE * __stream);
std::size_t __declspec(dllexport) fwrite(const void * __ptr, std::size_t __size, std::size_t __n,
                                 FILE * __stream);
char * __declspec(dllexport) gets(char * __s);
wchar_t* __declspec(dllexport) _getws(wchar_t * __s);
int __declspec(dllexport) _pclose(FILE *__stream);
void __declspec(dllexport) perror(const char * __s);
void __declspec(dllexport) _wperror(const wchar_t * __s);
FILE * __declspec(dllexport) _popen(const char * __command, const char * __mode);
FILE * __declspec(dllexport) _wpopen(const wchar_t * __command,
                                 const wchar_t * __mode);

int __declspec(dllexport) printf(const char * __format, ...) __attribute__((format (printf, 1, 2)));
int __declspec(dllexport) wprintf(const wchar_t * __format, ...);
int __declspec(dllexport) puts(const char * __s);
int __declspec(dllexport) _putws(const wchar_t * __s);

int __declspec(dllexport) remove(const char * __path);
int __declspec(dllexport) _wremove(const wchar_t * __path);
int __declspec(dllexport) rename(const char * __oldname,const char * __newname);
int __declspec(dllexport) _wrename(const wchar_t * __oldname,const wchar_t * __newname);
void __declspec(dllexport) rewind(FILE * __stream);
int __declspec(dllexport) scanf(const char * __format, ...);
int __declspec(dllexport) wscanf(const wchar_t * __format, ...);
void __declspec(dllexport) setbuf(FILE * __stream, char * __buf);
int __declspec(dllexport) setvbuf(FILE * __stream, char * __buf,
                                 int __type, std::size_t __size);
int __declspec(dllexport) sprintf(char * __buffer, const char * __format, ...) __attribute__((format (printf, 2, 3)));
int __declspec(dllexport) swprintf(wchar_t * __buffer, const wchar_t * __format, ...);


}
extern "C++" {
int __declspec(dllexport) swprintf(wchar_t * s, std::size_t __nsize, const wchar_t * format, ...);
}
extern "C" {


int __declspec(dllexport) snprintf(char * __buffer, std::size_t __nsize,
                                 const char * __format, ...) __attribute__((format (printf, 3, 4)));
int __declspec(dllexport) snwprintf(wchar_t * __buffer, std::size_t __nsize,
                                 const wchar_t * __format, ...);

int __declspec(dllexport) _snprintf(char * __buffer, std::size_t __nsize,
                                 const char * __format, ...) __attribute__((format (printf, 3, 4)));
int __declspec(dllexport) _snwprintf(wchar_t * __buffer, std::size_t __nsize,
                                 const wchar_t * __format, ...);

int __declspec(dllexport) sscanf(const char * __buffer,
                                 const char * __format, ...);
int __declspec(dllexport) swscanf(const wchar_t * __buffer,
                                 const wchar_t * __format, ...);
char * __declspec(dllexport) strerror(int __errnum);
FILE * __declspec(dllexport) tmpfile(void);
char * __declspec(dllexport) tmpnam(char * __s);
wchar_t * __declspec(dllexport) _wtmpnam(wchar_t * __s);
int __declspec(dllexport) ungetc(int __c, FILE * __stream);
std::wint_t __declspec(dllexport) ungetwc(std::wint_t __c, FILE * __stream);
int __declspec(dllexport) vfprintf(FILE * __stream, const char * __format,
                                 va_list) __attribute__((format (printf, 2, 0)));
int __declspec(dllexport) vfscanf(FILE * __stream, const char * __format,
                                 va_list);
int __declspec(dllexport) vprintf(const char * __format, va_list) __attribute__((format (printf, 1, 0)));
int __declspec(dllexport) vscanf(const char * __format, va_list);
int __declspec(dllexport) vsprintf(char * __buffer, const char * __format,
          va_list) __attribute__((format (printf, 2, 0)));
int __declspec(dllexport) vsnprintf(char * __buffer, std::size_t __nsize, const char * __format,
           va_list) __attribute__((format (printf, 3, 0)));
int __declspec(dllexport) vsscanf(const char * __buffer, const char * __format,
                                 va_list);
int __declspec(dllexport) vfwprintf(FILE * __stream, const wchar_t * __format,
                                 va_list);
int __declspec(dllexport) vfwscanf(FILE * __stream, const wchar_t * __format,
                                 va_list);
int __declspec(dllexport) vwprintf(const wchar_t * __format, va_list);
int __declspec(dllexport) vwscanf(const wchar_t * __format, va_list);
int __declspec(dllexport) vswprintf(wchar_t * __buffer, const wchar_t * __format,
                                 va_list);
int __declspec(dllexport) vsnwprintf(wchar_t * __buffer, std::size_t __nsize, const wchar_t * __format,
                                 va_list);
int __declspec(dllexport) vswscanf(const wchar_t * __buffer, const wchar_t * __format,
                                 va_list);
int __declspec(dllexport) _unlink(const char * __path);
int __declspec(dllexport) _wunlink(const wchar_t * __path);

int __declspec(dllexport) _vsnprintf(char * __buffer, std::size_t __nsize, const char * __format,
     va_list) __attribute__((format (printf, 3, 0)));
int __declspec(dllexport) _vsnwprintf(wchar_t * __buffer, std::size_t __nsize, const wchar_t * __format,
                                 va_list);


int __declspec(dllexport) getc(FILE * __fp);
std::wint_t __declspec(dllexport) getwc(FILE * __fp);
int __declspec(dllexport) getchar(void);
std::wint_t __declspec(dllexport) getwchar(void);
int __declspec(dllexport) putchar(const int __c);
std::wint_t __declspec(dllexport) putwchar(const std::wint_t __c);
int __declspec(dllexport) putc(const int __c, FILE * __fp);
std::wint_t __declspec(dllexport) putwc(const std::wint_t __c, FILE * __fp);
int __declspec(dllexport) feof(FILE * __fp);
int __declspec(dllexport) ferror(FILE * __fp);
int __declspec(dllexport) _fileno(FILE *__fp);
int __declspec(dllexport) _flushall(void);
int __declspec(dllexport) _fcloseall(void);
FILE * __declspec(dllexport) _fdopen(int __handle, const char * __type);
FILE * __declspec(dllexport) _wfdopen(int __handle, const wchar_t * __type);
int __declspec(dllexport) _fgetchar(void);
std::wint_t __declspec(dllexport) _fgetwchar(void);
int __declspec(dllexport) _fputchar(int __c);
std::wint_t __declspec(dllexport) _fputwchar(std::wint_t __c);
FILE * __declspec(dllexport) _fsopen (const char * __path, const char * __mode, int __shflag);
FILE * __declspec(dllexport) _wfsopen (const wchar_t * __path,
                                 const wchar_t * __mode, int __shflag);



int __declspec(dllexport) _sopen (const char *__path, int __access, int __shflag,
                                 ... );

int __declspec(dllexport) _wsopen (const wchar_t *__path, int __access, int __shflag,
                                 ... );
int __declspec(dllexport) _getw(FILE * __stream);
int __declspec(dllexport) _putw(int __w, FILE * __stream);
int __declspec(dllexport) _rmtmp(void);
char * __declspec(dllexport) _strerror(const char * __s);
char * __declspec(dllexport) _tempnam(const char * __dir, const char * __pfx);
wchar_t * __declspec(dllexport) _wtempnam(const wchar_t * __dir, const wchar_t * __pfx);
int __declspec(dllexport) _fgetc(FILE * __stream);
std::wint_t __declspec(dllexport) _fgetwc(FILE * __stream);
int __declspec(dllexport) _fputc(char __c, FILE * __stream);
std::wint_t __declspec(dllexport) _fputwc(wchar_t __c, FILE * __stream);

int __declspec(dllexport) flushall(void);
FILE * __declspec(dllexport) fdopen(int __handle, const char * __type);
int __declspec(dllexport) fputchar(int __c);
int __declspec(dllexport) fgetchar(void);
int __declspec(dllexport) fileno(FILE * __fp);
int __declspec(dllexport) fcloseall(void);
int __declspec(dllexport) fseeko(FILE * __stream, off_t __offset, int __whence);
off_t __declspec(dllexport) ftello(FILE * __stream);
char * __declspec(dllexport) tempnam(const char * __dir, const char * __pfx);
int __declspec(dllexport) rmtmp(void);
int __declspec(dllexport) unlink(const char * __path);
int __declspec(dllexport) getw(FILE * __stream);
int __declspec(dllexport) putw(int __w, FILE * __stream);
int __declspec(dllexport) sopen (const char *__path, int __access, int __shflag,
                                 ... );


}
#line 464 "C:\\src\\winrtl\\include\\stdio.h"
#pragma pack(pop)








}
#line 21 "C:\\src\\winrtl\\include\\cstdio"
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"

#line 1 "C:\\src\\winrtl\\include\\cstdlib"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 1 "C:\\src\\winrtl\\include\\stdlib.h"
#line 14 "C:\\src\\winrtl\\include\\stdlib.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\stdlib.h"
#line 23 "C:\\src\\winrtl\\include\\stdlib.h"
extern "C"{
#line 40 "C:\\src\\winrtl\\include\\stdlib.h"
}



namespace std {




#pragma pack(push, 1)





typedef struct {
        int quot;
        int rem;
} div_t;




typedef struct {
        long quot;
        long rem;
} ldiv_t;




typedef struct {
        long long quot;
        long long rem;
} lldiv_t;
#line 98 "C:\\src\\winrtl\\include\\stdlib.h"
typedef void ( * atexit_t)(void);
#line 109 "C:\\src\\winrtl\\include\\stdlib.h"
extern "C" {



typedef void ( *constraint_handler_t)(const char * __msg,
            void * __ptr,
            errno_t __error);

constraint_handler_t __declspec(dllexport) set_constraint_handler_s(constraint_handler_t __handler);
void __declspec(dllexport) abort_handler_s(const char * __msg,
     void * __ptr,
     errno_t __error);
void __declspec(dllexport) ignore_handler_s(const char * __msg,
      void * __ptr,
      errno_t __error);

errno_t __declspec(dllexport) getenv_s(size_t * len, char * value,
        rsize_t maxsize, const char * name);
errno_t __declspec(dllexport) wgetenv_s(size_t * len, wchar_t * value,
         rsize_t maxsize, const wchar_t * name);



void __declspec(dllexport) __declspec(noreturn) abort(void);
#line 148 "C:\\src\\winrtl\\include\\stdlib.h"
int __declspec(dllexport) abs(int __x);


int __declspec(dllexport) atexit(void ( * __func)(void));
double __declspec(dllexport) atof(const char * __s);
int __declspec(dllexport) atoi(const char * __s);
long __declspec(dllexport) atol(const char * __s);
void * __declspec(dllexport) calloc(std::size_t __nitems, std::size_t __size);
div_t __declspec(dllexport) div(int __numer, int __denom);
void __declspec(dllexport) __declspec(noreturn) exit(int __status);
void __declspec(dllexport) free(void * __block);
char * __declspec(dllexport) getenv(const char * __name);
long __declspec(dllexport) labs(long __x);
long long __declspec(dllexport) llabs(long long __x);
ldiv_t __declspec(dllexport) ldiv(long __numer, long __denom);
lldiv_t __declspec(dllexport) lldiv(long long __numer, long long __denom);
void * __declspec(dllexport) malloc(std::size_t __size);
int __declspec(dllexport) mblen(const char * __s, std::size_t __n);
std::size_t __declspec(dllexport) mbstowcs(wchar_t *__pwcs, const char * __s,
                                     std::size_t __n);
std::size_t __declspec(dllexport) _mbstrlen(const char *__s);
int __declspec(dllexport) mbtowc(wchar_t *__pwc, const char * __s, std::size_t __n);
int __declspec(dllexport) mbtowc_cp(wchar_t *__pwc, const char * __s, std::size_t __n, const unsigned _codepage);
int __declspec(dllexport) rand(void);



void * __declspec(dllexport) realloc(void * __block, std::size_t __size);
void __declspec(dllexport) srand(unsigned __seed);

float __declspec(dllexport) strtof(const char * __s, char * *__endptr);

double __declspec(dllexport) strtod(const char * __s, char * *__endptr);
long __declspec(dllexport) strtol(const char * __s, char * *__endptr, int __radix);
long long __declspec(dllexport) strtoll(const char * __s, char * *__endptr, int __radix);

long double _strtold(const char * __s, char * *__endptr);

long double __declspec(dllexport) strtold(const char * __s, char * *__endptr);
unsigned long __declspec(dllexport) strtoul(const char * __s, char * *__endptr, int __radix);
unsigned long long __declspec(dllexport) strtoull(const char * __s, char * *__endptr, int __radix);
int __declspec(dllexport) system(const char * __command);

std::size_t __declspec(dllexport) wcstombs(char * __s, const wchar_t *__pwcs,std::size_t __n);
int __declspec(dllexport) wctomb(char * __s, wchar_t __wc);
int __declspec(dllexport) wctomb_cp(char * __s, wchar_t __wc, const unsigned _codepage);
double __declspec(dllexport) _wtof(const wchar_t * __s);
int __declspec(dllexport) _wtoi(const wchar_t * __s);
long __declspec(dllexport) _wtol(const wchar_t * __s);
long double __declspec(dllexport) _wtold(const wchar_t * __s);

float __declspec(dllexport) wcstof(const wchar_t * __s, wchar_t * *__endptr);

double __declspec(dllexport) wcstod(const wchar_t * __s, wchar_t * *__endptr);
long double __declspec(dllexport) wcstold(const wchar_t * __s, wchar_t * *__endptr);
long __declspec(dllexport) wcstol(const wchar_t * __s, wchar_t * *__endptr, int __radix);
long long __declspec(dllexport) wcstoll(const wchar_t * __s, wchar_t * *__endptr, int __radix);

long double _wcstold(const wchar_t * __s, wchar_t * *__endptr);

unsigned long __declspec(dllexport) wcstoul(const wchar_t * __s, wchar_t * *__endptr, int __radix);
unsigned long long __declspec(dllexport) wcstoull(const wchar_t * __s, wchar_t * *__endptr, int __radix);
int __declspec(dllexport) _wsystem(const wchar_t * __command);
wchar_t * __declspec(dllexport) _itow(int __value, wchar_t *__string, int __radix);
wchar_t * __declspec(dllexport) _ltow(long __value, wchar_t *__string, int __radix);
wchar_t * __declspec(dllexport) _ultow(unsigned long __value, wchar_t *__string, int __radix);



__int64 __declspec(dllexport) _atoi64(const char * __s);
char * __declspec(dllexport) _i64toa(__int64 __value, char *__strP, int __radix);
char * __declspec(dllexport) _ui64toa(unsigned __int64 __value, char *__strP, int __radix);
__int64 __declspec(dllexport) _wtoi64(const wchar_t * __s);
wchar_t * __declspec(dllexport) _i64tow(__int64 __value, wchar_t *__strP, int __radix);
wchar_t * __declspec(dllexport) _ui64tow(unsigned __int64 __value, wchar_t *__strP, int __radix);

char * __declspec(dllexport) ltoa(long __value, char * __string, int __radix);
char * __declspec(dllexport) ecvt(double __value, int __ndig, int * __dec, int * __sign);
char * __declspec(dllexport) fcvt(double __value, int __ndig, int * __dec, int * __sign);
char * __declspec(dllexport) gcvt(double __value, int __ndec, char * __buf);




extern int __declspec(dllexport) __mb_cur_max;
#line 246 "C:\\src\\winrtl\\include\\stdlib.h"
void __declspec(dllexport) _seterrormode(int __mode);



extern char ** __declspec(dllexport) _environ;
extern wchar_t ** __declspec(dllexport) _wenviron;
extern int __declspec(dllexport) _fileinfo;
extern int _fmode;
extern unsigned char __declspec(dllexport) _osmajor;
extern unsigned char __declspec(dllexport) _osminor;
extern unsigned char __declspec(dllexport) _osmode;
extern unsigned int __declspec(dllexport) _osversion;
extern int __declspec(dllexport) _cmdline_escapes;

extern char * __declspec(dllexport) _sys_errlist[];
extern int __declspec(dllexport) _sys_nerr;







}
#line 294 "C:\\src\\winrtl\\include\\stdlib.h"
extern "C" {


long double __declspec(dllexport) _atold(const char * __s);

unsigned char __declspec(dllexport) _crotl(unsigned char __value, int __count);
unsigned char __declspec(dllexport) _crotr(unsigned char __value, int __count);

char * __declspec(dllexport) _ecvt(double __value, int __ndig, int * __dec,
                                     int * __sign);
void __declspec(dllexport) __declspec(noreturn) _exit(int __status);
char * __declspec(dllexport) _fcvt(double __value, int __ndig, int * __dec,
                                     int * __sign);
char * __declspec(dllexport) _fullpath(char * __buf, const char * __path,
                                     std::size_t __maxlen);
char * __declspec(dllexport) _gcvt(double __value, int __ndec,
                                     char * __buf);
char * __declspec(dllexport) itoa(int __value, char * __string,
                                     int __radix);
long __declspec(dllexport) _lrand(void);
unsigned long __declspec(dllexport) _lrotl(unsigned long __val, int __count);
unsigned long __declspec(dllexport) _lrotr(unsigned long __val, int __count);

char * __declspec(dllexport) _ltoa(long __value, char * __string,
                                     int __radix);
void __declspec(dllexport) _makepath(char * __path,
                                     const char * __drive,
                                     const char * __dir,
                                     const char * __name,
                                     const char * __ext );
int __declspec(dllexport) putenv(const char * __name);

unsigned short __declspec(dllexport) _rotl(unsigned short __value, int __count);
unsigned short __declspec(dllexport) _rotr(unsigned short __value, int __count);

void __declspec(dllexport) _searchenv(const char * __file,
                                     const char * __varname,
                                     char *__pathname);
void __declspec(dllexport) _searchstr(const char * __file,
                                     const char * __ipath,
                                     char *__pathname);
void __declspec(dllexport) _splitpath(const char * __path,
                                     char * __drive,
                                     char * __dir,
                                     char * __name,
                                     char * __ext );


void __declspec(dllexport) swab(const char * __from, char * __to, ssize_t __nbytes);


char * __declspec(dllexport) ultoa(unsigned long __value, char * __string,
                                     int __radix);
void __declspec(dllexport) perror(const char * __s);

void __declspec(dllexport) _wperror(const wchar_t * __s);
wchar_t * __declspec(dllexport) _wfullpath(wchar_t * __buf,const wchar_t * __path,
                                     std::size_t __maxlen);
void __declspec(dllexport) _wmakepath(wchar_t * __path,
                                     const wchar_t * __drive,
                                     const wchar_t * __dir,
                                     const wchar_t * __name,
                                     const wchar_t * __ext );
void __declspec(dllexport) _wsplitpath(const wchar_t * __path,
                                     wchar_t * __drive,
                                     wchar_t * __dir,
                                     wchar_t * __name,
                                     wchar_t * __ext );

void __declspec(dllexport) _wsearchenv(const wchar_t * __file,
                                     const wchar_t * __varname,
                                     wchar_t *__pathname);
void __declspec(dllexport) _wsearchstr(const wchar_t * __file,
                                     const wchar_t * __ipath,
                                     wchar_t *__pathname);
wchar_t * __declspec(dllexport) _wgetenv(const wchar_t * __name);
int __declspec(dllexport) _wputenv(const wchar_t * __name);


}





inline int random(int __num) { return __num ? (int)(_lrand()%(__num)) : 0; }
#line 388 "C:\\src\\winrtl\\include\\stdlib.h"
extern "C" {

long __declspec(dllexport) time(long *);

}
#line 402 "C:\\src\\winrtl\\include\\stdlib.h"
inline void randomize(void)
{
    srand((unsigned) time(0));
}
#line 489 "C:\\src\\winrtl\\include\\stdlib.h"
extern "C"{



    extern int __declspec(dllexport) _argc;
    extern char ** __declspec(dllexport) _argv;



    extern wchar_t ** __declspec(dllexport) _wargv;

}






#pragma pack(pop)








}





#line 1 "C:\\src\\winrtl\\include\\search.h"
#line 13 "C:\\src\\winrtl\\include\\search.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 13 "C:\\src\\winrtl\\include\\search.h"
#line 24 "C:\\src\\winrtl\\include\\search.h"
namespace std {
extern "C" {

void * __declspec(dllexport) bsearch(const void * __key, const void * __base,
       std::size_t __nelem, std::size_t __width,
       int ( *fcmp)(const void *, const void *));

void * __declspec(dllexport) lfind(const void * __key, const void * __base,
    std::size_t *__num, std::size_t __width,
                                int ( *fcmp)(const void *, const void *));

void * __declspec(dllexport) lsearch(const void * __key, void * __base,
      std::size_t *__num, std::size_t __width,
      int ( *fcmp)(const void *, const void *));

void __declspec(dllexport) qsort(void * __base, std::size_t __nelem, std::size_t __width,
     int ( *__fcmp)(const void *, const void *));


void * __declspec(dllexport) bsearch_s(const void * __key, const void * __base,
         rsize_t __nelem, rsize_t __width,
         int ( *__fcmp)(const void *, const void *, void *),
         void *__context);

errno_t __declspec(dllexport) qsort_s(void * __base, rsize_t __nelem, rsize_t __width,
        int ( *__fcmp)(const void *, const void *, void *),
        void *__context);



}
}
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"

#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 15 "C:\\src\\winrtl\\include\\errno.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 15 "C:\\src\\winrtl\\include\\errno.h"



namespace std {
extern "C" {
#line 434 "C:\\src\\winrtl\\include\\errno.h"
extern int __declspec(dllexport) _doserrno;


extern "C" {

extern int * __declspec(dllexport) __errno(void);

}
#line 451 "C:\\src\\winrtl\\include\\errno.h"
extern int __declspec(dllexport) _sys_nerr;
extern char * __declspec(dllexport) _sys_errlist[];
#line 464 "C:\\src\\winrtl\\include\\errno.h"
}
}
#line 522 "C:\\src\\winrtl\\include\\stdlib.h"






namespace std {
inline long abs(long __x) { return labs(__x); }
inline long long abs(long long __x) { return llabs(__x); }
inline ldiv_t div(long __x, long __y) { return ldiv(__x,__y); }
inline lldiv_t div(long long __x, long long __y) { return lldiv(__x,__y); }
}
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\streambuf"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xiosbase"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"



#line 1 "C:\\src\\winrtl\\include\\climits"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"

#line 1 "C:\\src\\winrtl\\include\\cstring"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 1 "C:\\src\\winrtl\\include\\_str.h"
#line 14 "C:\\src\\winrtl\\include\\_str.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\_str.h"





#line 1 "C:\\src\\winrtl\\include\\locale.h"





#line 1 "C:\\src\\winrtl\\include\\_loc.h"
#line 12 "C:\\src\\winrtl\\include\\_loc.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 12 "C:\\src\\winrtl\\include\\_loc.h"
#line 23 "C:\\src\\winrtl\\include\\_loc.h"
namespace std {
#line 47 "C:\\src\\winrtl\\include\\_loc.h"
struct lconv {

   char *decimal_point;
   char *thousands_sep;
   char *grouping;
   char *int_curr_symbol;
   char *currency_symbol;
   char *mon_decimal_point;
   char *mon_thousands_sep;
   char *mon_grouping;
   char *positive_sign;
   char *negative_sign;
   char int_frac_digits;
   char frac_digits;
   char p_cs_precedes;
   char p_sep_by_space;
   char n_cs_precedes;
   char n_sep_by_space;
   char p_sign_posn;
   char n_sign_posn;
};


#pragma pack(push, 1)


extern "C" {


char * setlocale( int __category, const char *__locale );
wchar_t * _wsetlocale( int __category, const wchar_t *__locale );




char * __declspec(dllexport) _lsetlocale( int __category, const char *__locale );
struct lconv * __declspec(dllexport) localeconv( void );
struct lconv * __declspec(dllexport) _llocaleconv( void );
wchar_t * __declspec(dllexport) _lwsetlocale( int __category, const wchar_t *__locale );

}


#pragma pack(pop)
#line 116 "C:\\src\\winrtl\\include\\_loc.h"
}
#line 6 "C:\\src\\winrtl\\include\\locale.h"
#line 19 "C:\\src\\winrtl\\include\\_str.h"
#line 33 "C:\\src\\winrtl\\include\\_str.h"
extern "C" {



namespace std {
#line 46 "C:\\src\\winrtl\\include\\_str.h"
std::size_t __declspec(dllexport) strnlen_s(const char *__s, std::size_t __maxlen);
std::size_t __declspec(dllexport) wcsnlen_s(const wchar_t *__s, std::size_t __maxlen);
errno_t __declspec(dllexport) strerror_s(char *__s, rsize_t __maxsize, errno_t __errnum);
errno_t __declspec(dllexport) _wcserror_s(wchar_t *__s, rsize_t __maxsize, errno_t __errnum);
size_t __declspec(dllexport) strerrorlen_s(errno_t errnum);
errno_t __declspec(dllexport) strncpy_s(char * dest, rsize_t destmax,
        const char * src, rsize_t n);
errno_t __declspec(dllexport) wcsncpy_s(wchar_t * dest, rsize_t destmax,
        const wchar_t * src, rsize_t n);
errno_t __declspec(dllexport) strcpy_s(char * dest, rsize_t destmax,
       const char * src);
errno_t __declspec(dllexport) wcscpy_s(wchar_t * dest, rsize_t destmax,
       const wchar_t * src);
errno_t __declspec(dllexport) strncat_s(char * dest, rsize_t destmax,
        const char * src, rsize_t n);
errno_t __declspec(dllexport) wcsncat_s(wchar_t * dest, rsize_t destmax,
        const wchar_t * src, rsize_t n);
errno_t __declspec(dllexport) strcat_s(char * dest, rsize_t destmax,
       const char * src);
errno_t __declspec(dllexport) wcscat_s(wchar_t * dest, rsize_t destmax,
       const wchar_t * src);
char * __declspec(dllexport) strtok_s(char * __s1, rsize_t * __s1max,
       const char * __s2, char ** __ptr);
wchar_t * __declspec(dllexport) wcstok_s(wchar_t * __s1, rsize_t * __s1max,
       const wchar_t * __s2, wchar_t ** __ptr);


std::size_t __declspec(dllexport) wcslen(const wchar_t *__s);
wchar_t * __declspec(dllexport) wcscpy(wchar_t *__dst, const wchar_t *__src);
wchar_t * __declspec(dllexport) wcscat(wchar_t *__dest, const wchar_t *__src);
int __declspec(dllexport) wcscmp(const wchar_t *__s1, const wchar_t *__s2);
int __declspec(dllexport) wcscoll(const wchar_t * __s1, const wchar_t * __s2);
std::size_t __declspec(dllexport) wcscspn(const wchar_t *__s1, const wchar_t *__s2);
wchar_t * __declspec(dllexport) _wcsdup(const wchar_t *__s);
int __declspec(dllexport) wcsncmp(const wchar_t *__s1, const wchar_t *__s2, std::size_t __maxlen);
wchar_t * __declspec(dllexport) wcsncpy(wchar_t *__dest, const wchar_t *__src, std::size_t __maxlen);
wchar_t * __declspec(dllexport) _wcsnset(wchar_t *__s, wchar_t __ch, std::size_t __n);
wchar_t * __declspec(dllexport) wcspbrk(const wchar_t *__s1, const wchar_t *__s2);
wchar_t * __declspec(dllexport) wcsrchr(const wchar_t *__s, wchar_t __c);
wchar_t * __declspec(dllexport) _wcsrev(wchar_t *__s);
wchar_t * __declspec(dllexport) _wcsset(wchar_t*__s, wchar_t __ch);
std::size_t __declspec(dllexport) wcsspn(const wchar_t *__s1, const wchar_t *__s2);
wchar_t * __declspec(dllexport) wcsstr(const wchar_t *__s1, const wchar_t *__s2);
wchar_t * __declspec(dllexport) wcstok(wchar_t *__s1, const wchar_t *__s2);
wchar_t * __declspec(dllexport) wcsncat(wchar_t *__dest, const wchar_t *__src, std::size_t __maxlen);
wchar_t * __declspec(dllexport) wcspcpy(wchar_t *__dest, const wchar_t *__src);
wchar_t * __declspec(dllexport) _wcspcpy(wchar_t *__dest, const wchar_t *__src);
int __declspec(dllexport) _wcsicmp(const wchar_t *__s1, const wchar_t *__s2);
int __declspec(dllexport) _wcsnicmp(const wchar_t *__s1, const wchar_t *__s2, std::size_t __maxlen);
wchar_t * __declspec(dllexport) _wcslwr(wchar_t *__s);
wchar_t * __declspec(dllexport) _wcsupr(wchar_t *__s);
wchar_t * __declspec(dllexport) _lwcslwr(wchar_t *__s);
wchar_t * __declspec(dllexport) _lwcsupr(wchar_t *__s);
wchar_t * __declspec(dllexport) __wcserror(const wchar_t *__s);
wchar_t * __declspec(dllexport) _wcserror(int __errnum);


wchar_t * __declspec(dllexport) wcschr(const wchar_t *__s, wchar_t __c);







char * strcat(char *__dest, const char *__src);
int strcmp(const char *__s1, const char *__s2);
char * strcpy(char *__dest, const char *__src);
std::size_t strlen(const char *__s);
char * strncat(char *__dest, const char *__src,
                                        std::size_t __maxlen);
int strncmp(const char *__s1, const char *__s2,
                                        std::size_t __maxlen);
char * strncpy(char *__dest, const char *__src,
                                        std::size_t __maxlen);
std::size_t strcspn(const char *__s1, const char *__s2);
char * strerror(int __errnum);
std::size_t strspn(const char *__s1, const char *__s2);
char * strtok(char *__s1, const char *__s2);
char * _strerror(const char *__s);






char * _lstrlwr(char *__s);
char * _lstrupr(char *__s);
char * stpcpy(char *__dest, const char *__src);
char * _stpcpy(char *__dest, const char *__src);
char * strdup(const char *__s);
int stricmp(const char *__s1, const char *__s2);
char * strlwr(char *__s);
int strnicmp(const char *__s1, const char *__s2,
                                           std::size_t __maxlen);
char * strnset(char *__s, int __ch, std::size_t __n);
char * strrev(char *__s);
char * strset(char *__s, int __ch);
char * strupr(char *__s);



extern "C++"
{
          char * strchr(char * __s, int __c);
    const char * strchr(const char * __s, int __c);
          char * strrchr(char *__s, int __c);
    const char * strrchr(const char *__s, int __c);
          char * strpbrk(char *__s1, const char *__s2);
    const char * strpbrk(const char *__s1, const char *__s2);
          char * strstr(char *__s1, const char *__s2);
    const char * strstr(const char *__s1, const char *__s2);




}
#line 343 "C:\\src\\winrtl\\include\\_str.h"
int __export _lstrcoll(const char * __s1, const char * __s2);
int __export _lstricoll(const char * __s1, const char * __s2);
int __export _lstrncoll(const char * __s1, const char * __s2, const int __len);
int __export _lstrnicoll(const char * __s1, const char * __s2, int __len);
std::size_t __export _lstrxfrm(char * __s1, const char * __s2,std::size_t __n );
int __export _stricoll(const char * __s1, const char * __s2);
int __export _strncoll(const char * __s1, const char * __s2, std::size_t __n);
int __export _strnicoll(const char * __s1, const char * __s2, int __len);





int strcoll(const char * __s1, const char * __s2);
std::size_t strxfrm(char * __s1, const char * __s2,std::size_t __n );





int __export _lwcscoll(const wchar_t * __s1, const wchar_t * __s2);
int __export _lwcsicoll(const wchar_t * __s1, const wchar_t * __s2);
int __export _lwcsncoll(const wchar_t * __s1, const wchar_t * __s2, const int __len);
int __export _lwcsnicoll(const wchar_t * __s1, const wchar_t * __s2, int __len);
std::size_t __export _lwcsxfrm(wchar_t * __s1, const wchar_t * __s2,std::size_t __n );
int __export wcscoll(const wchar_t * __s1, const wchar_t * __s2);
int __export _wcsicoll(const wchar_t * __s1, const wchar_t * __s2);
int __export _wcsncoll(const wchar_t * __s1, const wchar_t * __s2, std::size_t __n);
int __export _wcsnicoll(const wchar_t * __s1, const wchar_t * __s2, int __len);
std::size_t __export wcsxfrm(wchar_t * __s1, const wchar_t * __s2, std::size_t __n );
#line 403 "C:\\src\\winrtl\\include\\_str.h"
inline char * strupr(char *__s)
    { return _lstrupr(__s); }
inline char * strlwr(char *__s)
    { return _lstrlwr(__s); }
inline int stricoll(const char * __s1, const char * __s2)
    { return _lstricoll(__s1, __s2); }
inline int strncoll(const char * __s1, const char * __s2, const int __len)
    { return _lstrncoll( __s1, __s2, __len); }
inline int strnicoll(const char * __s1, const char * __s2, int __len)
    { return _lstrnicoll(__s1, __s2, __len); }

inline int strcoll(const char * __s1, const char * __s2)
    { return _lstrcoll(__s1, __s2); }
inline std::size_t strxfrm(char * __s1, const char * __s2, std::size_t __n )
    { return _lstrxfrm(__s1, __s2, __n); }
#line 438 "C:\\src\\winrtl\\include\\_str.h"
}



}





#line 1 "C:\\src\\winrtl\\include\\mem.h"
#line 13 "C:\\src\\winrtl\\include\\mem.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 13 "C:\\src\\winrtl\\include\\mem.h"
#line 25 "C:\\src\\winrtl\\include\\mem.h"
extern "C" {



namespace std {



errno_t __export memcpy_s(void * __dest, rsize_t __destmax,
         const void * __src, rsize_t __n);
errno_t __export memmove_s(void * __dest, rsize_t __destmax,
          const void * __src, rsize_t __n);
errno_t __export wmemcpy_s(wchar_t * __dest, rsize_t __destmax,
          const wchar_t * __src, rsize_t __n);
errno_t __export wmemmove_s(wchar_t * __dest, rsize_t __destmax,
           const wchar_t * __src, rsize_t __n);


void * __export memccpy(void *__dest, const void *__src,
                                        int __c, std::size_t __n);
int __export memcmp(const void *__s1, const void *__s2,
                                       std::size_t __n);
void * __export memcpy(void *__dest, const void *__src,
                                       std::size_t __n);
int __export memicmp(const void *__s1, const void *__s2,
                                        std::size_t __n);
void * __export memmove(void *__dest, const void *__src,
                                        std::size_t __n);
void * __export memset(void *__s, int __c, std::size_t __n);

wchar_t * __export wmemset(wchar_t *__s, int __c, std::size_t __n);
wchar_t * __export wmemcpy(wchar_t *__dest, const wchar_t *__src, std::size_t __n);
wchar_t * __export wmemmove(wchar_t *__dest, const wchar_t *__src, std::size_t __n);
wchar_t * __export wmemchr(const wchar_t *__s, int __c, std::size_t __n);
int __export wmemcmp(const wchar_t *__s1, const wchar_t *__s2, std::size_t __n);


wchar_t * __export _wmemset(wchar_t *__s, int __c, std::size_t __n);
wchar_t * __export _wmemcpy(wchar_t *__dest, const wchar_t *__src, std::size_t __n);


extern "C++"
{
          void * __export memchr(void *__s, int __c, std::size_t __n);
    const void * __export memchr(const void *__s, int __c, std::size_t __n);
          wchar_t * __export _wmemchr(wchar_t *__s, int __c, std::size_t __n);
    const wchar_t * __export _wmemchr(const wchar_t *__s, int __c, std::size_t __n);
}
#line 94 "C:\\src\\winrtl\\include\\mem.h"
}
}
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\stdexcept"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\exception"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"



#line 1 "C:\\src\\winrtl\\include\\cstddef"
#line 10 "C:\\src\\winrtl\\include\\cstddef"
#line 1 "C:\\src\\winrtl\\include\\stddef.h"
#line 17 "C:\\src\\winrtl\\include\\stddef.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 17 "C:\\src\\winrtl\\include\\stddef.h"
#line 10 "C:\\src\\winrtl\\include\\cstddef"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"

#line 1 "C:\\src\\winrtl\\include\\cstdlib"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 1 "C:\\src\\winrtl\\include\\stdlib.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"
#line 1 "C:\\src\\winrtl\\include\\search.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"

#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 522 "C:\\src\\winrtl\\include\\stdlib.h"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\initializer_list"



#line 1 "C:\\src\\winrtl\\include\\cstddef"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\initializer_list"


namespace std {

template<class _Elem>
 class initializer_list
 {
public:
 typedef _Elem value_type;
 typedef const _Elem& reference;
 typedef const _Elem& const_reference;
 typedef size_t size_type;

 typedef const _Elem* iterator;
 typedef const _Elem* const_iterator;

 initializer_list()
  : _First(0), _Last(0)
  {
  }

 initializer_list(const _Elem *_First_arg,
  const _Elem *_Last_arg)
  : _First(_First_arg), _Last(_Last_arg)
  {
  }

 initializer_list(const _Elem *_First_arg, size_t _Count)
  : _First(_First_arg), _Last(_First_arg + _Count)
  {
  }

 const _Elem *begin() const
  {
  return (_First);
  }

 const _Elem *end() const
  {
  return (_Last);
  }

 size_t size() const
  {
  return ((size_t)(_Last - _First));
  }

private:
 const _Elem *_First;
 const _Elem *_Last;
 };
}
namespace std {

template<class _Elem> inline
 const _Elem *begin(::std:: initializer_list<_Elem> _Ilist)
 {
 return (_Ilist.begin());
 }


template<class _Elem> inline
 const _Elem *end(::std:: initializer_list<_Elem> _Ilist)
 {
 return (_Ilist.end());
 }
}
#line 8 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"
#line 26 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"
namespace std {
#line 125 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"
template<class _Ty> inline
 _Ty *addressof(_Ty& _Val)
 {
 return (reinterpret_cast<_Ty *>(
  (&const_cast<char&>(
  reinterpret_cast<const volatile char&>(_Val)))));
 }


template<bool,
 class _Ty1,
 class _Ty2>
 struct _If
 {
 typedef _Ty2 type;
 };

template<class _Ty1,
 class _Ty2>
 struct _If<true, _Ty1, _Ty2>
 {
 typedef _Ty1 type;
 };

template<class _Ty>
 struct _Always_false
 {
 static const bool value = false;
 };
#line 173 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"
template<class _Arg,
 class _Result>
 struct unary_function
 {
 typedef _Arg argument_type;
 typedef _Result result_type;
 };


template<class _Arg1,
 class _Arg2,
 class _Result>
 struct binary_function
 {
 typedef _Arg1 first_argument_type;
 typedef _Arg2 second_argument_type;
 typedef _Result result_type;
 };


template<class _Ty = void>
 struct plus
  : public binary_function<_Ty, _Ty, _Ty>
 {
 _Ty operator()(const _Ty& _Left, const _Ty& _Right) const
  {
  return (_Left + _Right);
  }
 };


template<class _Ty = void>
 struct minus
  : public binary_function<_Ty, _Ty, _Ty>
 {
 _Ty operator()(const _Ty& _Left, const _Ty& _Right) const
  {
  return (_Left - _Right);
  }
 };


template<class _Ty = void>
 struct multiplies
  : public binary_function<_Ty, _Ty, _Ty>
 {
 _Ty operator()(const _Ty& _Left, const _Ty& _Right) const
  {
  return (_Left * _Right);
  }
 };


template<class _Ty = void>
 struct equal_to
  : public binary_function<_Ty, _Ty, bool>
 {
 bool operator()(const _Ty& _Left, const _Ty& _Right) const
  {
  return (_Left == _Right);
  }
 };


template<class _Ty = void>
 struct less
  : public binary_function<_Ty, _Ty, bool>
 {
 bool operator()(const _Ty& _Left, const _Ty& _Right) const
  {
  return (_Left < _Right);
  }
 };



template<>
 struct plus<void>
 {
 template<class _Ty1,
  class _Ty2>
  auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
  -> decltype(static_cast<_Ty1 &&>(_Left)
   + static_cast<_Ty2 &&>(_Right))
  {
  return (static_cast<_Ty1 &&>(_Left)
   + static_cast<_Ty2 &&>(_Right));
  }
 };


template<>
 struct minus<void>
 {
 template<class _Ty1,
  class _Ty2>
  auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
  -> decltype(static_cast<_Ty1 &&>(_Left)
   - static_cast<_Ty2 &&>(_Right))
  {
  return (static_cast<_Ty1 &&>(_Left)
   - static_cast<_Ty2 &&>(_Right));
  }
 };


template<>
 struct multiplies<void>
 {
 template<class _Ty1,
  class _Ty2>
  auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
  -> decltype(static_cast<_Ty1 &&>(_Left)
   * static_cast<_Ty2 &&>(_Right))
  {
  return (static_cast<_Ty1 &&>(_Left)
   * static_cast<_Ty2 &&>(_Right));
  }
 };


template<>
 struct equal_to<void>
 {
 template<class _Ty1,
  class _Ty2>
  auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
  -> decltype(static_cast<_Ty1 &&>(_Left)
   == static_cast<_Ty2 &&>(_Right))
  {
  return (static_cast<_Ty1 &&>(_Left)
   == static_cast<_Ty2 &&>(_Right));
  }
 };


template<>
 struct less<void>
 {
 template<class _Ty1,
  class _Ty2>
  auto operator()(_Ty1&& _Left, _Ty2&& _Right) const
  -> decltype(static_cast<_Ty1 &&>(_Left)
   < static_cast<_Ty2 &&>(_Right))
  {
  return (static_cast<_Ty1 &&>(_Left)
   < static_cast<_Ty2 &&>(_Right));
  }
 };
#line 337 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"
}



namespace std {

inline size_t _Hash_seq(const unsigned char *_First, size_t _Count)
 {






 static_assert(sizeof(size_t) == 4, "This code is for 32-bit size_t.");
 const size_t _FNV_offset_basis = 2166136261U;
 const size_t _FNV_prime = 16777619U;


 size_t _Val = _FNV_offset_basis;
 for (size_t _Next = 0; _Next < _Count; ++_Next)
  {
  _Val ^= (size_t)_First[_Next];
  _Val *= _FNV_prime;
  }






 static_assert(sizeof(size_t) == 4, "This code is for 32-bit size_t.");


 return (_Val);
 }


template<class _Kty>
 struct _Bitwise_hash
  : public unary_function<_Kty, size_t>
 {
 size_t operator()(const _Kty& _Keyval) const
  {
  return (_Hash_seq((const unsigned char *)&_Keyval, sizeof (_Kty)));
  }
 };


template<class _Kty>
 struct hash
  : public _Bitwise_hash<_Kty>
 {
 };
template<>
 struct hash<bool>
  : public _Bitwise_hash<bool>
 {
 };

template<>
 struct hash<char>
  : public _Bitwise_hash<char>
 {
 };

template<>
 struct hash<signed char>
  : public _Bitwise_hash<signed char>
 {
 };

template<>
 struct hash<unsigned char>
  : public _Bitwise_hash<unsigned char>
 {
 };


template<>
 struct hash<char16_t>
  : public _Bitwise_hash<char16_t>
 {
 };

template<>
 struct hash<char32_t>
  : public _Bitwise_hash<char32_t>
 {
 };


template<>
 struct hash<wchar_t>
  : public _Bitwise_hash<wchar_t>
 {
 };

template<>
 struct hash<short>
  : public _Bitwise_hash<short>
 {
 };

template<>
 struct hash<unsigned short>
  : public _Bitwise_hash<unsigned short>
 {
 };

template<>
 struct hash<int>
  : public _Bitwise_hash<int>
 {
 };

template<>
 struct hash<unsigned int>
  : public _Bitwise_hash<unsigned int>
 {
 };

template<>
 struct hash<long>
  : public _Bitwise_hash<long>
 {
 };

template<>
 struct hash<unsigned long>
  : public _Bitwise_hash<unsigned long>
 {
 };

template<>
 struct hash<long long>
  : public _Bitwise_hash<long long>
 {
 };

template<>
 struct hash<unsigned long long>
  : public _Bitwise_hash<unsigned long long>
 {
 };

template<>
 struct hash<float>
  : public _Bitwise_hash<float>
 {
 typedef float _Kty;
 typedef _Bitwise_hash<_Kty> _Mybase;

 size_t operator()(const _Kty& _Keyval) const
  {
  return (_Mybase::operator()(
   _Keyval == 0 ? 0 : _Keyval));
  }
 };

template<>
 struct hash<double>
  : public _Bitwise_hash<double>
 {
 typedef double _Kty;
 typedef _Bitwise_hash<_Kty> _Mybase;

 size_t operator()(const _Kty& _Keyval) const
  {
  return (_Mybase::operator()(
   _Keyval == 0 ? 0 : _Keyval));
  }
 };

template<>
 struct hash<long double>
  : public _Bitwise_hash<long double>
 {
 typedef long double _Kty;
 typedef _Bitwise_hash<_Kty> _Mybase;

 size_t operator()(const _Kty& _Keyval) const
  {
  return (_Mybase::operator()(
   _Keyval == 0 ? 0 : _Keyval));
  }
 };

template<class _Ty>
 struct hash<_Ty *>
  : public _Bitwise_hash<_Ty *>
 {
 };
}
#line 542 "C:\\src\\winrtl\\include\\dinkumware64\\xstddef"
namespace std {
namespace tr1 {
using ::std:: hash;
}
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\exception"


namespace std {

class exception;
typedef void (*_Prhand)(const exception&);
extern __declspec(dllexport) _Prhand _Raise_handler;
__declspec(dllexport) void _Throw(const exception&);
#line 105 "C:\\src\\winrtl\\include\\dinkumware64\\exception"
class __declspec(dllexport) exception
 {
public:
 static _Prhand _Set_raise_handler(_Prhand _Pnew);

 exception()
  {
  }

 explicit exception(const char *)
  {
  }

 virtual ~exception() ;


 virtual const char *what() const;
#line 131 "C:\\src\\winrtl\\include\\dinkumware64\\exception"
 void _Raise() const;

protected:
 virtual void _Doraise() const;

 };


class __declspec(dllexport) bad_exception
 : public exception
 {
public:
 bad_exception()
  {
  }





 virtual ~bad_exception()
  {
  }





protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };



typedef void (*terminate_handler)();
typedef void (*unexpected_handler)();


__declspec(dllexport) terminate_handler get_terminate() ;
__declspec(dllexport) terminate_handler set_terminate(terminate_handler) ;
__declspec(dllexport) unexpected_handler get_unexpected() ;
__declspec(dllexport) unexpected_handler set_unexpected(unexpected_handler) ;
__declspec(dllexport) bool uncaught_exception() ;
__declspec(dllexport) void terminate() ;
__declspec(dllexport) void unexpected();

inline unexpected_handler get_unexpected()
 {
 unexpected_handler _Hand = set_unexpected(0);
 set_unexpected(_Hand);
 return (_Hand);
 }

inline terminate_handler get_terminate()
 {
 terminate_handler _Hand = set_terminate(0);
 set_terminate(_Hand);
 return (_Hand);
 }
}



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xxexception"




namespace std {
typedef void *exception_ptr;


inline exception_ptr current_exception()
 {
 return (exception_ptr());
 }

inline void rethrow_exception(exception_ptr)
 {
 int _Zero = 0;
 if (_Zero)
          ;
 }
}

namespace std {

template<class _Excep> inline
 exception_ptr make_exception_ptr(_Excep _Ex)
 {
 {{
 ::std:: _Throw(_Ex);
 } if (0) {
 int _Zero = 0;
 if (_Zero == 0)
  return (current_exception());
 }}
 return (exception_ptr());
 }


class nested_exception
 {
public:
 nested_exception()
  : _Myptr(current_exception())
  {
  }
#line 58 "C:\\src\\winrtl\\include\\dinkumware64\\xxexception"
 nested_exception(const nested_exception& _Right)
  : _Myptr(_Right._Myptr)
  {
  }

 nested_exception& operator=(
  const nested_exception& _Right)
  {
  _Myptr = _Right._Myptr;
  return (*this);
  }

 virtual ~nested_exception()
  {
  }


 exception_ptr nested_ptr() const
  {
  return (_Myptr);
  }

 void rethrow_nested() const
  {
  rethrow_exception(_Myptr);
  }

private:
 exception_ptr _Myptr;
 };


template<class _Ty>
 struct _Wrapped_with_nested
  : _Ty, nested_exception
 {
 _Wrapped_with_nested(const _Ty && _Val)
  : _Ty((_Ty &&)(_Val))
  {
  }
 };

template<class _Ty> inline
 void _Throw_with_nested0(_Ty && _Val, ...)
 {
                             ;
 }

template<class _Ty> inline
 void _Throw_with_nested0(_Ty && _Val,
  const _Wrapped_with_nested<_Ty>*)
 {
                                                        ;
 }

template<class _Ty> inline
 void _Throw_with_nested(_Ty && _Val,
  const volatile void *)
 {
 _Throw_with_nested0(_Val, 0);
 }

template<class _Ty> inline
 void _Throw_with_nested(_Ty && _Val,
  const volatile nested_exception *)
 {
                             ;
 }

template<class _Ty> inline
 void throw_with_nested(_Ty && _Val)
 {
 _Throw_with_nested(_Val, &_Val);
 }


inline void _Rethrow_if_nested(const nested_exception *_Val)
 {
 _Val->rethrow_nested();
 }

inline void _Rethrow_if_nested(const void *)
 {
 }

template<class _Ex> inline
 void rethrow_if_nested(const _Ex& _Val)
 {
 _Rethrow_if_nested(&_Val);
 }
}
#line 197 "C:\\src\\winrtl\\include\\dinkumware64\\exception"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\stdexcept"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"



#line 1 "C:\\src\\winrtl\\include\\cstdlib"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 1 "C:\\src\\winrtl\\include\\stdlib.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"
#line 1 "C:\\src\\winrtl\\include\\search.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"

#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 522 "C:\\src\\winrtl\\include\\stdlib.h"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\limits"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\ymath.h"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\ymath.h"

namespace std {
 extern "C" {
#line 126 "C:\\src\\winrtl\\include\\dinkumware64\\ymath.h"
void _Feraise(int);

typedef union
 {
 unsigned short _Word[8];
 float _Float;
 double _Double;
 long double _Long_double;
 } _Dconst;


__declspec(dllexport) double _Cosh(double, double);
__declspec(dllexport) double _Divide(double, double);
__declspec(dllexport) short _Dtest(double *);
__declspec(dllexport) double _Log(double, int);
__declspec(dllexport) double _Recip(double);
__declspec(dllexport) double _Sin(double, unsigned int);
__declspec(dllexport) double _Sinx(double, unsigned int, int);
__declspec(dllexport) double _Sinh(double, double);
__declspec(dllexport) short _Exp(double *, double, long);
__declspec(dllexport) extern const _Dconst _Denorm, _Hugeval, _Inf,
 _Nan, _Snan;


__declspec(dllexport) float _FCosh(float, float);
__declspec(dllexport) float _FDivide(float, float);
__declspec(dllexport) short _FDtest(float *);
__declspec(dllexport) float _FLog(float, int);
__declspec(dllexport) float _FRecip(float);
__declspec(dllexport) float _FSin(float, unsigned int);
__declspec(dllexport) float _FSinx(float, unsigned int, int);
__declspec(dllexport) float _FSinh(float, float);
__declspec(dllexport) short _FExp(float *, float, long);
__declspec(dllexport) extern const _Dconst _FDenorm, _FInf, _FNan, _FSnan;


__declspec(dllexport) long double _LCosh(long double, long double);
__declspec(dllexport) long double _LDivide(long double, long double);
__declspec(dllexport) short _LDtest(long double *);
__declspec(dllexport) long double _LLog(long double, int);
__declspec(dllexport) long double _LRecip(long double);
__declspec(dllexport) long double _LSin(long double, unsigned int);
__declspec(dllexport) long double _LSinx(long double, unsigned int, int);
__declspec(dllexport) long double _LSinh(long double, long double);

__declspec(dllexport) short _LExp(long double *, long double, long);
__declspec(dllexport) extern const _Dconst _LDenorm, _LInf, _LNan, _LSnan;







float fmodf(float, float);
float logf(float);


}
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\limits"

#line 1 "C:\\src\\winrtl\\include\\cfloat"
#line 10 "C:\\src\\winrtl\\include\\cfloat"
#line 1 "C:\\src\\winrtl\\include\\float.h"
#line 14 "C:\\src\\winrtl\\include\\float.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\float.h"



namespace std {
#line 128 "C:\\src\\winrtl\\include\\float.h"
extern "C" {


extern float __declspec(dllexport) _max_flt;
extern double __declspec(dllexport) _max_dble;

extern long double __declspec(dllexport) _max_ldble;
extern long double __declspec(dllexport) _tiny_ldble;


unsigned int _clear87(void);
unsigned int _control87(unsigned int __newcw, unsigned int __mask);
void _fpreset(void);
unsigned int _status87(void);



double __export _chgsign(double __d);
double __export _copysign(double __da, double __db);
int __export _finite(double __d);
int __export _fpclass(double __d);
int __export _isinf(double __d);
int __export _isnan(double __d);
double __export _logb(double __d);
double __export _scalb(double __d, long __exp);
double __export _nextafter(double __da, double __db);

long double __export _chgsignl(long double __ld);
long double __export _copysignl(long double __lda, long double __ldb);
int __export _finitel(long double __ld);
int __export _fpclassl(long double __ld);
int __export _isnanl(long double __ld);
long double __export _logbl(long double __ld);
long double __export _scalbl(long double __ld, long __exp);
long double __export _nextafterl(long double __lda, long double __ldb);
#line 186 "C:\\src\\winrtl\\include\\float.h"
}
#line 227 "C:\\src\\winrtl\\include\\float.h"
}






extern unsigned int __declspec(dllexport) _default87;


namespace std {
#line 283 "C:\\src\\winrtl\\include\\float.h"
}
#line 10 "C:\\src\\winrtl\\include\\cfloat"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\limits"

#line 1 "C:\\src\\winrtl\\include\\climits"
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\limits"

#line 1 "C:\\src\\winrtl\\include\\cmath"
#line 10 "C:\\src\\winrtl\\include\\cmath"
#line 1 "C:\\src\\winrtl\\include\\math.h"
#line 10 "C:\\src\\winrtl\\include\\cmath"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 13 "C:\\src\\winrtl\\include\\cmath"
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\limits"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\cwchar"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\cwchar"




#line 1 "C:\\src\\winrtl\\include\\wchar.h"
#line 11 "C:\\src\\winrtl\\include\\wchar.h"
#line 1 "C:\\src\\winrtl\\include\\tchar.h"







#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 171 "C:\\src\\winrtl\\include\\_stddef.h"
     using std::ptrdiff_t;
     using std::__threadid;
     using std::size_t;
     using std::wint_t;
     using std::wctype_t;


     using std::errno_t;
     using std::rsize_t;
#line 8 "C:\\src\\winrtl\\include\\tchar.h"
#line 30 "C:\\src\\winrtl\\include\\tchar.h"
#line 1 "C:\\src\\winrtl\\include\\_str.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 1 "C:\\src\\winrtl\\include\\mem.h"
#line 182 "C:\\src\\winrtl\\include\\mem.h"
    using std::_wmemchr;
    using std::_wmemcpy;
    using std::_wmemset;
    using std::wmemmove;
    using std::wmemchr;
    using std::wmemcmp;
    using std::wmemcpy;
    using std::wmemset;
    using std::memccpy;
    using std::memicmp;
    using std::memmove;
    using std::memchr;
    using std::memcmp;
    using std::memcpy;
    using std::memset;


    using std::memcpy_s;
    using std::memmove_s;
    using std::wmemcpy_s;
    using std::wmemmove_s;
#line 447 "C:\\src\\winrtl\\include\\_str.h"





    using std::_lstrlwr;
    using std::_lstrupr;
    using std::_stpcpy;
    using std::strdup;
    using std::stricmp;
    using std::strlwr;
    using std::strnicmp;
    using std::strrev;
    using std::strupr;
#line 475 "C:\\src\\winrtl\\include\\_str.h"
    using std::_lstrcoll;
    using std::_lstricoll;
    using std::_lstrncoll;
    using std::_lstrnicoll;
    using std::_lstrxfrm;
    using std::_lwcscoll;
    using std::_lwcsicoll;
    using std::_lwcslwr;
    using std::_lwcsncoll;
    using std::_lwcsnicoll;
    using std::_lwcsupr;
    using std::_lwcsxfrm;
    using std::_stricoll;
    using std::_strncoll;
    using std::_strnicoll;
    using std::_wcsdup;
    using std::_wcsicmp;
    using std::_wcsicoll;
    using std::_wcslwr;
    using std::_wcsncoll;
    using std::_wcsnicmp;
    using std::_wcsnicoll;
    using std::_wcsnset;
    using std::_wcspcpy;
    using std::_wcsrev;
    using std::_wcsset;
    using std::_wcsupr;


    using std::strnset;
    using std::stpcpy;
    using std::strset;
    using std::_strerror;
    using std::_wcserror;
    using std::__wcserror;


    using std::strcat;
    using std::strchr;
    using std::strcmp;
    using std::strcpy;
    using std::strlen;
    using std::strncat;
    using std::strncmp;
    using std::strncpy;
    using std::strrchr;

    using std::strcspn;
    using std::strerror;
    using std::strpbrk;
    using std::strspn;
    using std::strstr;
    using std::strtok;
    using std::strxfrm;
    using std::strcoll;

    using std::wcscat;
    using std::wcschr;
    using std::wcscmp;
    using std::wcscoll;
    using std::wcscpy;
    using std::wcscspn;
    using std::wcslen;
    using std::wcsncat;
    using std::wcsncmp;
    using std::wcsncpy;
    using std::wcspbrk;
    using std::wcspcpy;
    using std::wcsrchr;
    using std::wcsspn;
    using std::wcsstr;
    using std::wcstok;
    using std::wcsxfrm;


    using std::_wcserror_s;
    using std::strcat_s;
    using std::strcpy_s;
    using std::strerror_s;
    using std::strerrorlen_s;
    using std::strncat_s;
    using std::strncpy_s;
    using std::strnlen_s;
    using std::strtok_s;
    using std::wcscat_s;
    using std::wcscpy_s;
    using std::wcsncat_s;
    using std::wcsncpy_s;
    using std::wcsnlen_s;
    using std::wcstok_s;
#line 30 "C:\\src\\winrtl\\include\\tchar.h"







extern "C" {





namespace std {







typedef char _TCHAR;
typedef signed char _TSCHAR;
typedef unsigned char _TUCHAR;
typedef char _TXCHAR;
typedef int _TINT;





}
#line 624 "C:\\src\\winrtl\\include\\tchar.h"
inline std::size_t _tclen(const char *__s ){return (1); }
inline void _tccpy(char *__s1, const char *__s2) {*(__s1) = *(__s2); }
inline int _tccmp(const char *__s1, const char *__s2){ return (int) ( ((unsigned char*)__s1)-((unsigned char*)__s2)); }
#line 667 "C:\\src\\winrtl\\include\\tchar.h"
inline char * strinc(const char * __s) { return (char *)(__s+1); }
inline char * strdec(const char * __s1, const char * __s2) { return (char *)((__s1 >= __s2) ? 0 : (__s2-1)); }

inline char * _strinc(const char * __s) { return (char *)(__s+1); }
inline char * _strdec(const char * __s1, const char * __s2) { return (char *)((__s1 >= __s2) ? 0 : (__s2-1)); }
inline unsigned int _strnextc(const char *__s) { return (unsigned int) (__s ? __s[0] : 0); }
inline char * _strninc(const char * __s, std::size_t __n) { return (char *)(__s+__n); }
inline std::size_t _strncnt( const char * __s, std::size_t __n) { std::size_t __len; __len = std::strlen(__s); return (__len>__n) ? __n : __len; }
inline char * _strspnp( const char * __s1, const char * __s2) { return (*(__s1 += std::strspn(__s1,__s2))!='\0') ? (char*)__s1 : 0; }
#line 1036 "C:\\src\\winrtl\\include\\tchar.h"
}
    using std::_TCHAR;
    using std::_TSCHAR;
    using std::_TUCHAR;
    using std::_TXCHAR;
    using std::_TINT;
#line 11 "C:\\src\\winrtl\\include\\wchar.h"
#line 26 "C:\\src\\winrtl\\include\\wchar.h"
typedef int mbstate_t;


namespace std {
#line 51 "C:\\src\\winrtl\\include\\wchar.h"
extern "C" {



#pragma argsused
__inline int fwide(FILE *__fp, int __mode) { return __mode; }


}
}





    using std::fwide;
#line 8 "C:\\src\\winrtl\\include\\dinkumware64\\cwchar"
#line 28 "C:\\src\\winrtl\\include\\dinkumware64\\cwchar"
namespace std {
struct tm;
}

namespace std {
extern "C" {
using ::std:: tm;

typedef int _Mbstatet;
typedef int mbstate_t;



int wmemcmp(const wchar_t *, const wchar_t *, size_t);

wchar_t *wmemmove(wchar_t *, const wchar_t *, size_t);


wint_t btowc(int);
size_t mbrtowc(wchar_t *, const char *, size_t, mbstate_t *);
size_t mbrtowc_cp(wchar_t *, const char *, size_t, mbstate_t *, const unsigned int);
int wctob(wint_t);
size_t wcrtomb(char *, wchar_t, mbstate_t *);
size_t wcrtomb_cp(char *, wchar_t, mbstate_t *, const unsigned int);
}
}
#line 8 "C:\\src\\winrtl\\include\\dinkumware64\\limits"



namespace std {
#line 23 "C:\\src\\winrtl\\include\\dinkumware64\\limits"
typedef enum
 {
 denorm_indeterminate = -1,
 denorm_absent = 0,
 denorm_present = 1}
  float_denorm_style;


typedef enum
 {
 round_indeterminate = -1,
 round_toward_zero = 0,
 round_to_nearest = 1,
 round_toward_infinity = 2,
 round_toward_neg_infinity = 3}
  float_round_style;


struct _Num_base
 {
 static const float_denorm_style has_denorm = (float_denorm_style)(denorm_absent);
 static const bool has_denorm_loss = (bool)(false);
 static const bool has_infinity = (bool)(false);
 static const bool has_quiet_NaN = (bool)(false);
 static const bool has_signaling_NaN = (bool)(false);
 static const bool is_bounded = (bool)(false);
 static const bool is_exact = (bool)(false);
 static const bool is_iec559 = (bool)(false);
 static const bool is_integer = (bool)(false);
 static const bool is_modulo = (bool)(false);
 static const bool is_signed = (bool)(false);
 static const bool is_specialized = (bool)(false);
 static const bool tinyness_before = (bool)(false);
 static const bool traps = (bool)(false);
 static const float_round_style round_style = (float_round_style)(round_toward_zero);
 static const int digits = (int)(0);
 static const int digits10 = (int)(0);


 static const int max_digits10 = (int)(0);


 static const int max_exponent = (int)(0);
 static const int max_exponent10 = (int)(0);
 static const int min_exponent = (int)(0);
 static const int min_exponent10 = (int)(0);
 static const int radix = (int)(0);
 };


template<class _Ty>
 class numeric_limits
  : public _Num_base
 {
public:
 static _Ty (min)()
  {
  return (_Ty(0));
  }

 static _Ty (max)()
  {
  return (_Ty(0));
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (_Ty(0));
  }

 static _Ty round_error()
  {
  return (_Ty(0));
  }

 static _Ty denorm_min()
  {
  return (_Ty(0));
  }

 static _Ty infinity()
  {
  return (_Ty(0));
  }

 static _Ty quiet_NaN()
  {
  return (_Ty(0));
  }

 static _Ty signaling_NaN()
  {
  return (_Ty(0));
  }
 };

template<class _Ty>
 class numeric_limits<const _Ty>
  : public numeric_limits<_Ty>
 {
 };

template<class _Ty>
 class numeric_limits<volatile _Ty>
  : public numeric_limits<_Ty>
 {
 };

template<class _Ty>
 class numeric_limits<const volatile _Ty>
  : public numeric_limits<_Ty>
 {
 };


struct _Num_int_base
 : public _Num_base
 {
 static const bool is_bounded = (bool)(true);
 static const bool is_exact = (bool)(true);
 static const bool is_integer = (bool)(true);
 static const bool is_modulo = (bool)(true);
 static const bool is_specialized = (bool)(true);
 static const int radix = (int)(2);
 };


struct _Num_float_base
 : public _Num_base
 {
 static const float_denorm_style has_denorm = (float_denorm_style)(denorm_present);
 static const bool has_denorm_loss = (bool)(true);
 static const bool has_infinity = (bool)(true);
 static const bool has_quiet_NaN = (bool)(true);
 static const bool has_signaling_NaN = (bool)(true);
 static const bool is_bounded = (bool)(true);
 static const bool is_exact = (bool)(false);
 static const bool is_iec559 = (bool)(true);
 static const bool is_integer = (bool)(false);
 static const bool is_modulo = (bool)(false);
 static const bool is_signed = (bool)(true);
 static const bool is_specialized = (bool)(true);
 static const bool tinyness_before = (bool)(true);
 static const bool traps = (bool)(false);
 static const float_round_style round_style = (float_round_style)(round_to_nearest);
 static const int radix = (int)(2);
 };


template<> class numeric_limits<char>
 : public _Num_int_base
 {
public:
 typedef char _Ty;

 static _Ty (min)()
  {
  return ((-128));
  }

 static _Ty (max)()
  {
  return (127);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)((-128) != 0);
 static const int digits = (int)(8 - ((-128) != 0 ? 1 : 0));
 static const int digits10 = (int)((8 - ((-128) != 0 ? 1 : 0)) * 301L / 1000);

 };


template<> class numeric_limits<wchar_t>
 : public _Num_int_base
 {
public:
 typedef wchar_t _Ty;

 static _Ty (min)()
  {
  return ((_Ty)0);
  }

 static _Ty (max)()
  {
  return ((_Ty)0xffff);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(0 != 0);
 static const int digits = (int)(8 * sizeof (wchar_t) - (0 != 0 ? 1 : 0));

 static const int digits10 = (int)((8 * sizeof (wchar_t) - (0 != 0 ? 1 : 0)) * 301L / 1000);

 };


template<> class numeric_limits<_Bool>
 : public _Num_int_base
 {
public:
 typedef bool _Ty;

 static _Ty (min)()
  {
  return (false);
  }

 static _Ty (max)()
  {
  return (true);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_modulo = (bool)(false);
 static const bool is_signed = (bool)(false);
 static const int digits = (int)(1);
 static const int digits10 = (int)(0);
 };


template<> class numeric_limits<signed char>
 : public _Num_int_base
 {
public:
 typedef signed char _Ty;

 static _Ty (min)()
  {
  return ((-128));
  }

 static _Ty (max)()
  {
  return (127);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(true);
 static const int digits = (int)(8 - 1);
 static const int digits10 = (int)((8 - 1) * 301L / 1000);
 };


template<> class numeric_limits<unsigned char>
 : public _Num_int_base
 {
public:
 typedef unsigned char _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (255);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8);
 static const int digits10 = (int)(8 * 301L / 1000);
 };


template<> class numeric_limits<short>
 : public _Num_int_base
 {
public:
 typedef short _Ty;

 static _Ty (min)()
  {
  return ((-32767 -1));
  }

 static _Ty (max)()
  {
  return (32767);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(true);
 static const int digits = (int)(8 * sizeof (short) - 1);
 static const int digits10 = (int)((8 * sizeof (short) - 1) * 301L / 1000);

 };


template<> class numeric_limits<unsigned short>
 : public _Num_int_base
 {
public:
 typedef unsigned short _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (65535U);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8 * sizeof (unsigned short));
 static const int digits10 = (int)(8 * sizeof (unsigned short) * 301L / 1000);

 };



template<> class numeric_limits<char16_t>
 : public _Num_int_base
 {
public:
 typedef char16_t _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (65535U);
  }

 static _Ty lowest()
  {
  return ((min)());
  }

 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8 * sizeof (char16_t));
 static const int digits10 = (int)(8 * sizeof (char16_t) * 301L / 1000);

 };



template<> class numeric_limits<int>
 : public _Num_int_base
 {
public:
 typedef int _Ty;

 static _Ty (min)()
  {
  return ((-2147483647L -1));
  }

 static _Ty (max)()
  {
  return (2147483647L);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(true);
 static const int digits = (int)(8 * sizeof (int) - 1);
 static const int digits10 = (int)((8 * sizeof (int) - 1) * 301L / 1000);

 };


template<> class numeric_limits<unsigned int>
 : public _Num_int_base
 {
public:
 typedef unsigned int _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (4294967295UL);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8 * sizeof (unsigned int));
 static const int digits10 = (int)(8 * sizeof (unsigned int) * 301L / 1000);

 };


template<> class numeric_limits<long>
 : public _Num_int_base
 {
public:
 typedef long _Ty;

 static _Ty (min)()
  {
  return ((-2147483647L -1));
  }

 static _Ty (max)()
  {
  return (2147483647L);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(true);
 static const int digits = (int)(8 * sizeof (long) - 1);
 static const int digits10 = (int)((8 * sizeof (long) - 1) * 301L / 1000);

 };


template<> class numeric_limits<unsigned long>
 : public _Num_int_base
 {
public:
 typedef unsigned long _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (4294967295UL);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8 * sizeof (unsigned long));
 static const int digits10 = (int)(8 * sizeof (unsigned long) * 301L / 1000);

 };



template<> class numeric_limits<char32_t>
 : public _Num_int_base
 {
public:
 typedef char32_t _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (4294967295UL);
  }

 static _Ty lowest()
  {
  return ((min)());
  }

 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8 * sizeof (char32_t));
 static const int digits10 = (int)(8 * sizeof (char32_t) * 301L / 1000);

 };




template<> class numeric_limits<long long>
 : public _Num_int_base
 {
public:
 typedef long long _Ty;

 static _Ty (min)()
  {
  return (-0x7fffffffffffffffLL - 1);
  }

 static _Ty (max)()
  {
  return (0x7fffffffffffffffLL);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(true);
 static const int digits = (int)(8 * sizeof (long long) - 1);
 static const int digits10 = (int)((8 * sizeof (long long) - 1) * 301L / 1000);

 };


template<> class numeric_limits<unsigned long long>
 : public _Num_int_base
 {
public:
 typedef unsigned long long _Ty;

 static _Ty (min)()
  {
  return (0);
  }

 static _Ty (max)()
  {
  return (0xffffffffffffffffULL);
  }


 static _Ty lowest()
  {
  return ((min)());
  }


 static _Ty epsilon()
  {
  return (0);
  }

 static _Ty round_error()
  {
  return (0);
  }

 static _Ty denorm_min()
  {
  return (0);
  }

 static _Ty infinity()
  {
  return (0);
  }

 static _Ty quiet_NaN()
  {
  return (0);
  }

 static _Ty signaling_NaN()
  {
  return (0);
  }

 static const bool is_signed = (bool)(false);
 static const int digits = (int)(8 * sizeof (unsigned long long));
 static const int digits10 = (int)(8 * sizeof (unsigned long long) * 301L / 1000);

 };



template<> class numeric_limits<float>
 : public _Num_float_base
 {
public:
 typedef float _Ty;

 static _Ty (min)()
  {
  return (1.17549435e-38F);
  }

 static _Ty (max)()
  {
  return (3.40282347e+38F);
  }


 static _Ty lowest()
  {
  return (-(max)());
  }


 static _Ty epsilon()
  {
  return (1.19209290E-07F);
  }

 static _Ty round_error()
  {
  return (0.5);
  }

 static _Ty denorm_min()
  {
  return (::std:: _FDenorm._Float);
  }

 static _Ty infinity()
  {
  return (::std:: _FInf._Float);
  }

 static _Ty quiet_NaN()
  {
  return (::std:: _FNan._Float);
  }

 static _Ty signaling_NaN()
  {
  return (::std:: _FSnan._Float);
  }

 static const int digits = (int)(24);
 static const int digits10 = (int)(6);


 static const int max_digits10 = (int)(2 + 24 * 301L / 1000);


 static const int max_exponent = (int)((int)+128);
 static const int max_exponent10 = (int)((int)+38);
 static const int min_exponent = (int)((int)-125);
 static const int min_exponent10 = (int)((int)-37);
 };


template<> class numeric_limits<double>
 : public _Num_float_base
 {
public:
 typedef double _Ty;

 static _Ty (min)()
  {
  return (2.2250738585072014e-308);
  }

 static _Ty (max)()
  {
  return (1.7976931348623157e+308);
  }


 static _Ty lowest()
  {
  return (-(max)());
  }


 static _Ty epsilon()
  {
  return (2.2204460492503131E-16);
  }

 static _Ty round_error()
  {
  return (0.5);
  }

 static _Ty denorm_min()
  {
  return (::std:: _Denorm._Double);
  }

 static _Ty infinity()
  {
  return (::std:: _Inf._Double);
  }

 static _Ty quiet_NaN()
  {
  return (::std:: _Nan._Double);
  }

 static _Ty signaling_NaN()
  {
  return (::std:: _Snan._Double);
  }

 static const int digits = (int)(53);
 static const int digits10 = (int)(15);


 static const int max_digits10 = (int)(2 + 53 * 301L / 1000);


 static const int max_exponent = (int)((int)+1024);
 static const int max_exponent10 = (int)((int)+308);
 static const int min_exponent = (int)((int)-1021);
 static const int min_exponent10 = (int)((int)-307);
 };


template<> class numeric_limits<long double>
 : public _Num_float_base
 {
public:
 typedef long double _Ty;

 static _Ty (min)()
  {
  return (2.2250738585072014e-308);
  }

 static _Ty (max)()
  {
  return (1.7976931348623157e+308);
  }


 static _Ty lowest()
  {
  return (-(max)());
  }


 static _Ty epsilon()
  {
  return (1.084202172485504434e-019L);
  }

 static _Ty round_error()
  {
  return (0.5);
  }

 static _Ty denorm_min()
  {
  return (::std:: _LDenorm._Long_double);
  }

 static _Ty infinity()
  {
  return (::std:: _LInf._Long_double);
  }

 static _Ty quiet_NaN()
  {
  return (::std:: _LNan._Long_double);
  }

 static _Ty signaling_NaN()
  {
  return (::std:: _LSnan._Long_double);
  }

 static const int digits = (int)(64);
 static const int digits10 = (int)(18);


 static const int max_digits10 = (int)(2 + 64 * 301L / 1000);


 static const int max_exponent = (int)((int)+16384);
 static const int max_exponent10 = (int)((int)+4932);
 static const int min_exponent = (int)((int)-16381);
 static const int min_exponent10 = (int)((int)-4931);
 };
}
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\new"






namespace std {





class bad_alloc
 : public ::std:: exception
 {
public:







 bad_alloc()
  {
  }

 bad_alloc(const char *_Message)
  {
  }

 virtual const char *what() const
  {
  return ("bad allocation");
  }
#line 45 "C:\\src\\winrtl\\include\\dinkumware64\\new"
protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };



class bad_array_new_length
 : public bad_alloc
 {
public:
 bad_array_new_length()
  : bad_alloc("bad array new length")
  {
  }
 };



}
#line 80 "C:\\src\\winrtl\\include\\dinkumware64\\new"
namespace std {

typedef void ( *new_handler)();

struct nothrow_t
 {
 };

extern __declspec(dllexport) const nothrow_t nothrow;


__declspec(dllexport) new_handler get_new_handler()
          ;
__declspec(dllexport) new_handler set_new_handler(new_handler)
          ;
}
#line 106 "C:\\src\\winrtl\\include\\dinkumware64\\new"
void operator delete(void *) ;






void * operator new(::std:: size_t);




void * operator new(::std:: size_t, const ::std:: nothrow_t&)
          ;

inline void * operator new(::std:: size_t, void *_Where)
 {
 return (_Where);
 }
#line 133 "C:\\src\\winrtl\\include\\dinkumware64\\new"
void operator delete[](void *) ;






void * operator new[](::std:: size_t);




void * operator new[](::std:: size_t, const ::std:: nothrow_t&)
          ;

inline void * operator new[](::std:: size_t, void *_Where)
 {
 return (_Where);
 }

void operator delete(void *, const ::std:: nothrow_t&)
          ;

void operator delete[](void *, const ::std:: nothrow_t&)
          ;

void operator delete(void *, void *) ;



void operator delete[](void *, void *) ;
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"



#line 1 "C:\\src\\winrtl\\include\\climits"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"

#line 1 "C:\\src\\winrtl\\include\\cstdlib"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 1 "C:\\src\\winrtl\\include\\stdlib.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"
#line 1 "C:\\src\\winrtl\\include\\search.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"

#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 522 "C:\\src\\winrtl\\include\\stdlib.h"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\utility"




#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\iosfwd"



#line 1 "C:\\src\\winrtl\\include\\cstdio"
#line 21 "C:\\src\\winrtl\\include\\cstdio"
#line 1 "C:\\src\\winrtl\\include\\stdio.h"
#line 21 "C:\\src\\winrtl\\include\\cstdio"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\iosfwd"

#line 1 "C:\\src\\winrtl\\include\\cstring"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 1 "C:\\src\\winrtl\\include\\_str.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 1 "C:\\src\\winrtl\\include\\mem.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\iosfwd"




namespace std {
#line 19 "C:\\src\\winrtl\\include\\dinkumware64\\iosfwd"
typedef _Longlong streamoff;
typedef _Longlong streamsize;






extern __declspec(dllexport) fpos_t _Fpz;
extern __declspec(dllexport) const streamoff _BADOFF;


template<class _Statetype>
 class fpos
 {
 typedef fpos<_Statetype> _Myt;

public:
        fpos(streamoff _Off = 0)
  : _Myoff(_Off), _Fpos(_Fpz), _Mystate()
  {
  }

        fpos(_Statetype _State, fpos_t _Fileposition)
  : _Myoff(0), _Fpos(_Fileposition), _Mystate(_State)
  {
  }

 _Statetype state() const
  {
  return (_Mystate);
  }

 void state(_Statetype _State)
  {
  _Mystate = _State;
  }

 fpos_t seekpos() const
  {
  return (_Fpos);
  }

        operator streamoff() const
  {
  return ((streamoff)(_Myoff + ((long)(_Fpos))));
  }

 streamoff operator-(const _Myt& _Right) const
  {
  return ((streamoff)*this - (streamoff)_Right);
  }

 _Myt& operator+=(streamoff _Off)
  {
  _Myoff += _Off;
  return (*this);
  }

 _Myt& operator-=(streamoff _Off)
  {
  _Myoff -= _Off;
  return (*this);
  }

 _Myt operator+(streamoff _Off) const
  {
  _Myt _Tmp = *this;
  return (_Tmp += _Off);
  }

 _Myt operator-(streamoff _Off) const
  {
  _Myt _Tmp = *this;
  return (_Tmp -= _Off);
  }

 bool operator==(const _Myt& _Right) const
  {
  return ((streamoff)*this == (streamoff)_Right);
  }

 bool operator==(streamoff _Right) const
  {
  return ((streamoff)*this == _Right);
  }

 bool operator!=(const _Myt& _Right) const
  {
  return (!(*this == _Right));
  }

private:
 streamoff _Myoff;
 fpos_t _Fpos;
 _Statetype _Mystate;
 };
#line 133 "C:\\src\\winrtl\\include\\dinkumware64\\iosfwd"
typedef fpos<_Mbstatet> streampos;


typedef streampos wstreampos;


template<class _Elem,
 class _Int_type>
 struct _Char_traits
 {
 typedef _Elem char_type;
 typedef _Int_type int_type;
 typedef streampos pos_type;
 typedef streamoff off_type;
 typedef _Mbstatet state_type;

 static int compare(
  const _Elem *_First1,
  const _Elem *_First2, size_t _Count)
  {
  for (; 0 < _Count; --_Count, ++_First1, ++_First2)
   if (!eq(*_First1, *_First2))
    return (lt(*_First1, *_First2) ? -1 : +1);
  return (0);
  }

 static size_t length(const _Elem *_First)
  {
  size_t _Count;
  for (_Count = 0; !eq(*_First, _Elem()); ++_First)
   ++_Count;
  return (_Count);
  }

 static _Elem * copy(
  _Elem *_First1,
  const _Elem *_First2, size_t _Count)
  {
  _Elem *_Next = _First1;
  for (; 0 < _Count; --_Count, ++_Next, ++_First2)
   assign(*_Next, *_First2);
  return (_First1);
  }

 static const _Elem * find(
  const _Elem *_First,
  size_t _Count, const _Elem& _Ch)
  {
  for (; 0 < _Count; --_Count, ++_First)
   if (eq(*_First, _Ch))
    return (_First);
  return (0);
  }

 static _Elem * move(
  _Elem *_First1,
  const _Elem *_First2, size_t _Count)
  {
  _Elem *_Next = _First1;
  if (_First2 < _Next && _Next < _First2 + _Count)
   for (_Next += _Count, _First2 += _Count; 0 < _Count; --_Count)
    assign(*--_Next, *--_First2);
  else
   for (; 0 < _Count; --_Count, ++_Next, ++_First2)
    assign(*_Next, *_First2);
  return (_First1);
  }

 static _Elem * assign(
  _Elem *_First,
  size_t _Count, _Elem _Ch)
  {
  _Elem *_Next = _First;
  for (; 0 < _Count; --_Count, ++_Next)
   assign(*_Next, _Ch);
  return (_First);
  }

 static void assign(_Elem& _Left, const _Elem& _Right)
  {
  _Left = _Right;
  }

 static bool eq(const _Elem& _Left,
  const _Elem& _Right)
  {
  return (_Left == _Right);
  }

 static bool lt(const _Elem& _Left,
  const _Elem& _Right)
  {
  return (_Left < _Right);
  }

 static _Elem to_char_type(
  const int_type& _Meta)
  {
  return ((_Elem)_Meta);
  }

 static int_type to_int_type(
  const _Elem& _Ch)
  {
  return ((int_type)_Ch);
  }

 static bool eq_int_type(const int_type& _Left,
  const int_type& _Right)
  {
  return (_Left == _Right);
  }

 static int_type not_eof(
  const int_type& _Meta)
  {
  return (_Meta != eof() ? (int_type)_Meta : (int_type)!eof());
  }

 static int_type eof()
  {
  return ((int_type)(-1));
  }
 };


template<class _Elem>
 struct char_traits
  : public _Char_traits<_Elem, long>
 {
 };



template<>
 struct char_traits<char16_t>
 : public _Char_traits<char16_t, unsigned short>
 {
 };

typedef streampos u16streampos;


template<>
 struct char_traits<char32_t>
 : public _Char_traits<char32_t, unsigned>
 {
 };

typedef streampos u32streampos;



template<>
 struct char_traits<wchar_t>
 {
 typedef wchar_t _Elem;
 typedef _Elem char_type;
 typedef wint_t int_type;
 typedef streampos pos_type;
 typedef streamoff off_type;
 typedef _Mbstatet state_type;

 static int compare(const _Elem *_First1, const _Elem *_First2,
  size_t _Count)
  {
  return (_Count == 0 ? 0
   : ::std:: wmemcmp(_First1, _First2, _Count));
  }

 static size_t length(const _Elem *_First)
  {
  return (*_First == 0 ? 0
   : ::std:: wcslen(_First));
  }

 static _Elem * copy(_Elem *_First1, const _Elem *_First2,
  size_t _Count)
  {
  return (_Count == 0 ? _First1
   : (_Elem *)::std:: wmemcpy(_First1, _First2, _Count));
  }

 static const _Elem * find(const _Elem *_First, size_t _Count,
  const _Elem& _Ch)
  {
  return (_Count == 0 ? (const _Elem *)0
   : (const _Elem *)::std:: wmemchr(_First, _Ch, _Count));
  }

 static _Elem * move(_Elem *_First1, const _Elem *_First2,
  size_t _Count)
  {
  return (_Count == 0 ? _First1
   : (_Elem *)::std:: wmemmove(_First1, _First2, _Count));
  }

 static _Elem * assign(_Elem *_First, size_t _Count,
  _Elem _Ch)
  {
  return ((_Elem *)::std:: wmemset(_First, _Ch, _Count));
  }

 static void assign(_Elem& _Left, const _Elem& _Right)
  {
  _Left = _Right;
  }

 static bool eq(const _Elem& _Left,
  const _Elem& _Right)
  {
  return (_Left == _Right);
  }

 static bool lt(const _Elem& _Left,
  const _Elem& _Right)
  {
  return (_Left < _Right);
  }

 static _Elem to_char_type(
  const int_type& _Meta)
  {
  return (_Meta);
  }

 static int_type to_int_type(
  const _Elem& _Ch)
  {
  return (_Ch);
  }

 static bool eq_int_type(const int_type& _Left,
  const int_type& _Right)
  {
  return (_Left == _Right);
  }

 static int_type not_eof(
  const int_type& _Meta)
  {
  return (_Meta != eof() ? _Meta : !eof());
  }

 static int_type eof()
  {
  return ((std::wint_t)(0xFFFF));
  }
 };


template<> struct char_traits<char>
 {
 typedef char _Elem;
 typedef _Elem char_type;
 typedef int int_type;
 typedef streampos pos_type;
 typedef streamoff off_type;
 typedef _Mbstatet state_type;

 static int compare(const _Elem *_First1, const _Elem *_First2,
  size_t _Count)
  {
  return (_Count == 0 ? 0
   : ::std:: memcmp(_First1, _First2, _Count));
  }

 static size_t length(const _Elem *_First)
  {
  return (*_First == 0 ? 0
   : ::std:: strlen(_First));
  }

 static _Elem * copy(_Elem *_First1, const _Elem *_First2,
  size_t _Count)
  {
  return (_Count == 0 ? _First1
   : (_Elem *)::std:: memcpy(_First1, _First2, _Count));
  }

 static const _Elem * find(const _Elem *_First, size_t _Count,
  const _Elem& _Ch)
  {
  return (_Count == 0 ? (const _Elem *)0
   : (const _Elem *)::std:: memchr(_First, _Ch, _Count));
  }

 static _Elem * move(_Elem *_First1, const _Elem *_First2,
  size_t _Count)
  {
  return (_Count == 0 ? _First1
   : (_Elem *)::std:: memmove(_First1, _First2, _Count));
  }

 static _Elem * assign(_Elem *_First, size_t _Count,
  _Elem _Ch)
  {
  return ((_Elem *)::std:: memset(_First, _Ch, _Count));
  }

 static void assign(_Elem& _Left, const _Elem& _Right)
  {
  _Left = _Right;
  }

 static bool eq(const _Elem& _Left,
  const _Elem& _Right)
  {
  return (_Left == _Right);
  }

 static bool lt(const _Elem& _Left,
  const _Elem& _Right)
  {
  return ((unsigned char)_Left < (unsigned char)_Right);
  }

 static _Elem to_char_type(
  const int_type& _Meta)
  {
  return ((_Elem)_Meta);
  }

 static int_type to_int_type(
  const _Elem& _Ch)
  {
  return ((unsigned char)_Ch);
  }

 static bool eq_int_type(const int_type& _Left,
  const int_type& _Right)
  {
  return (_Left == _Right);
  }

 static int_type not_eof(
  const int_type& _Meta)
  {
  return (_Meta != eof() ? _Meta : !eof());
  }

 static int_type eof()
  {
  return ((-1));
  }
 };


template<class _Ty>
 class allocator;
class ios_base;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_ios;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class istreambuf_iterator;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class ostreambuf_iterator;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_streambuf;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_istream;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_ostream;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_iostream;
template<class _Elem,
 class _Traits = char_traits<_Elem>,
 class _Alloc = allocator<_Elem> >
 class basic_stringbuf;
template<class _Elem,
 class _Traits = char_traits<_Elem>,
 class _Alloc = allocator<_Elem> >
 class basic_istringstream;
template<class _Elem,
 class _Traits = char_traits<_Elem>,
 class _Alloc = allocator<_Elem> >
 class basic_ostringstream;
template<class _Elem,
 class _Traits = char_traits<_Elem>,
 class _Alloc = allocator<_Elem> >
 class basic_stringstream;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_filebuf;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_ifstream;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_ofstream;
template<class _Elem,
 class _Traits = char_traits<_Elem> >
 class basic_fstream;


typedef basic_ios<char, char_traits<char> > ios;
typedef basic_streambuf<char, char_traits<char> > streambuf;
typedef basic_istream<char, char_traits<char> > istream;
typedef basic_ostream<char, char_traits<char> > ostream;
typedef basic_iostream<char, char_traits<char> > iostream;
typedef basic_stringbuf<char, char_traits<char>,
 allocator<char> > stringbuf;
typedef basic_istringstream<char, char_traits<char>,
 allocator<char> > istringstream;
typedef basic_ostringstream<char, char_traits<char>,
 allocator<char> > ostringstream;
typedef basic_stringstream<char, char_traits<char>,
 allocator<char> > stringstream;
typedef basic_filebuf<char, char_traits<char> > filebuf;
typedef basic_ifstream<char, char_traits<char> > ifstream;
typedef basic_ofstream<char, char_traits<char> > ofstream;
typedef basic_fstream<char, char_traits<char> > fstream;


typedef basic_filebuf<char, char_traits<char> > stdiobuf;
typedef basic_fstream<char, char_traits<char> > stdiostream;



typedef basic_ios<wchar_t, char_traits<wchar_t> > wios;
typedef basic_streambuf<wchar_t, char_traits<wchar_t> >
 wstreambuf;
typedef basic_istream<wchar_t, char_traits<wchar_t> > wistream;
typedef basic_ostream<wchar_t, char_traits<wchar_t> > wostream;
typedef basic_iostream<wchar_t, char_traits<wchar_t> > wiostream;
typedef basic_stringbuf<wchar_t, char_traits<wchar_t>,
 allocator<wchar_t> > wstringbuf;
typedef basic_istringstream<wchar_t, char_traits<wchar_t>,
 allocator<wchar_t> > wistringstream;
typedef basic_ostringstream<wchar_t, char_traits<wchar_t>,
 allocator<wchar_t> > wostringstream;
typedef basic_stringstream<wchar_t, char_traits<wchar_t>,
 allocator<wchar_t> > wstringstream;
typedef basic_filebuf<wchar_t, char_traits<wchar_t> > wfilebuf;
typedef basic_ifstream<wchar_t, char_traits<wchar_t> > wifstream;
typedef basic_ofstream<wchar_t, char_traits<wchar_t> > wofstream;
typedef basic_fstream<wchar_t, char_traits<wchar_t> > wfstream;
}




using ::std:: ios;
using ::std:: streambuf;
using ::std:: istream;
using ::std:: ostream;
using ::std:: iostream;

using ::std:: filebuf;
using ::std:: ifstream;
using ::std:: ofstream;
using ::std:: fstream;

using ::std:: stdiobuf;
using ::std:: stdiostream;
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\utility"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
#line 260 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
namespace std {

template<class _Ty>
 struct _Ptr_traits
 {
 };

template<class _Ty>
 struct _Ptr_traits<_Ty *>
 {
 static const bool _Is_const = false;
 static const bool _Is_volatile = false;
 };

template<class _Ty>
 struct _Ptr_traits<const _Ty *>
 {
 static const bool _Is_const = true;
 static const bool _Is_volatile = false;
 };

template<class _Ty>
 struct _Ptr_traits<volatile _Ty *>
 {
 static const bool _Is_const = false;
 static const bool _Is_volatile = true;
 };

template<class _Ty>
 struct _Ptr_traits<const volatile _Ty *>
 {
 static const bool _Is_const = true;
 static const bool _Is_volatile = true;
 };

template<class _Ty>
 struct _Is_funptr
  : false_type
 {
 };

template<class _Ty>
 struct _Is_memfunptr
  : false_type
 {
 };
#line 316 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ret, class... _Types> struct _Is_funptr<_Ret ( *)(_Types...)> : true_type { };
#line 328 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret ( _Arg0::*)(_Types...) > : true_type { }; template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret ( _Arg0::*)(_Types...) const> : true_type { }; template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret ( _Arg0::*)(_Types...) volatile> : true_type { }; template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret ( _Arg0::*)(_Types...) const volatile> : true_type { };


template<class _Ret,
 class... _Types>
 struct _Is_funptr<_Ret (*)(_Types..., ...)>
  : true_type
 {
 };
#line 347 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) > : true_type { }; template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const> : true_type { }; template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) volatile> : true_type { }; template<class _Ret, class _Arg0, class... _Types> struct _Is_memfunptr<_Ret (_Arg0::*)(_Types..., ...) const volatile> : true_type { };
#line 418 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct add_const
 {
 typedef const _Ty type;
 };


template<class _Ty>
 struct add_volatile
 {
 typedef volatile _Ty type;
 };


template<class _Ty>
 struct add_cv
 {
 typedef const volatile _Ty type;
 };


template<class _Ty>
 struct add_reference
 {
 typedef typename remove_reference<_Ty>::type& type;
 };
#line 452 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<> struct add_reference< void> { typedef void type; }; template<> struct add_reference<const void> { typedef const void type; }; template<> struct add_reference<volatile void> { typedef volatile void type; }; template<> struct add_reference<const volatile void> { typedef const volatile void type; };



template<class _Ty>
 struct add_lvalue_reference
 {
 typedef typename add_reference<_Ty>::type type;
 };


template<class _Ty>
 struct add_rvalue_reference
 {
 typedef typename remove_reference<_Ty>::type && type;
 };

template<class _Ty>
 struct add_rvalue_reference<_Ty&>
 {
 typedef _Ty& type;
 };
#line 482 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<> struct add_rvalue_reference< void> { typedef void type; }; template<> struct add_rvalue_reference<const void> { typedef const void type; }; template<> struct add_rvalue_reference<volatile void> { typedef volatile void type; }; template<> struct add_rvalue_reference<const volatile void> { typedef const volatile void type; };



template<class _Ty>
 typename add_rvalue_reference<_Ty>::type
  declval() ;


template<class _Ty>
 struct remove_extent
 {
 typedef _Ty type;
 };

template<class _Ty, unsigned int _Ix>
 struct remove_extent<_Ty[_Ix]>
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct remove_extent<_Ty[]>
 {
 typedef _Ty type;
 };


template<class _Ty>
 struct remove_all_extents
 {
 typedef _Ty type;
 };

template<class _Ty, unsigned int _Ix>
 struct remove_all_extents<_Ty[_Ix]>
 {
 typedef typename remove_all_extents<_Ty>::type type;
 };

template<class _Ty>
 struct remove_all_extents<_Ty[]>
 {
 typedef typename remove_all_extents<_Ty>::type type;
 };


template<class _Ty>
 struct remove_pointer
 {
 typedef _Ty type;
 };
#line 542 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty> struct remove_pointer<_Ty *> { typedef _Ty type; }; template<class _Ty> struct remove_pointer<_Ty *const> { typedef _Ty type; }; template<class _Ty> struct remove_pointer<_Ty *volatile> { typedef _Ty type; }; template<class _Ty> struct remove_pointer<_Ty *const volatile> { typedef _Ty type; };



template<class _Ty>
 struct add_pointer
 {
 typedef typename remove_reference<_Ty>::type *type;
 };



template<class _Ty>
 struct _Is_void
  : false_type
 {
 };

template<>
 struct _Is_void<void>
  : true_type
 {
 };

template<class _Ty>
 struct is_void
  : _Is_void<typename remove_cv<_Ty>::type>
 {
 };


template<class _Ty>
 struct is_array
  : false_type
 {
 };

template<class _Ty, size_t _Nx>
 struct is_array<_Ty[_Nx]>
  : true_type
 {
 };

template<class _Ty>
 struct is_array<_Ty[]>
  : true_type
 {
 };



template<class _Ty>
 struct is_lvalue_reference
  : false_type
 {
 };

template<class _Ty>
 struct is_lvalue_reference<_Ty&>
  : true_type
 {
 };


template<class _Ty>
 struct is_rvalue_reference
  : false_type
 {
 };


template<class _Ty>
 struct is_rvalue_reference<_Ty&&>
  : true_type
 {
 };



template<class _Ty>
 struct is_reference
  : _Cat_base<is_lvalue_reference<_Ty>::value
  || is_rvalue_reference<_Ty>::value>
 {
 };
#line 644 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct _Is_member_object_pointer
  : false_type
 {
 };

template<class _Ty1, class _Ty2>
 struct _Is_member_object_pointer<_Ty1 _Ty2::*>
  : _Cat_base<!_Is_memfunptr<_Ty1 _Ty2::*>::value>
 {
 };

template<class _Ty>
 struct is_member_object_pointer
  : _Is_member_object_pointer<typename remove_cv<_Ty>::type>
 {
 };


template<class _Ty>
 struct is_member_function_pointer
  : _Cat_base<_Is_memfunptr<typename remove_cv<_Ty>::type>::value>
 {
 };


template<class _Ty>
 struct _Is_pointer
  : false_type
 {
 };

template<class _Ty>
 struct _Is_pointer<_Ty *>
  : _Cat_base<!is_member_object_pointer<_Ty *>::value
  && !is_member_function_pointer<_Ty *>::value>
 {
 };

template<class _Ty>
 struct is_pointer
  : _Is_pointer<typename remove_cv<_Ty>::type>
 {
 };




template<class _Ty>
 struct _Is_nullptr_t
  : _Cat_base<is_same<typename remove_cv<_Ty>::type, nullptr_t>::value>
 {
 };
#line 707 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct is_union : _Cat_base<__is_union(_Ty)>
 {
 };


template<class _Ty>
 struct is_class : _Cat_base<__is_class(_Ty)>
 {
 };


template<class _Ty>
 struct is_function
  : _Cat_base<_Is_funptr<typename remove_cv<_Ty>::type *>::value>
 {
 };

template<class _Ty>
 struct is_function<_Ty&>
  : false_type
 {
 };


template<class _Ty>
 struct is_function<_Ty&&>
  : false_type
 {
 };



template<class _Ty>
 struct is_arithmetic
  : _Cat_base<is_integral<_Ty>::value
  || is_floating_point<_Ty>::value>
 {
 };


template<class _Ty>
 struct is_fundamental
  : _Cat_base<is_arithmetic<_Ty>::value
  || is_void<_Ty>::value
  || _Is_nullptr_t<_Ty>::value>
 {
 };


template<class _Ty>
 struct is_object
  : _Cat_base<!is_function<_Ty>::value
  && !is_reference<_Ty>::value
  && !is_void<_Ty>::value>
 {
 };
#line 775 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct decay;

template<bool,
 class _From,
 class _To>
 struct _Is_convertible
  : false_type
 {
 };

template<class _From,
 class _To>
 struct _Is_convertible<true, _From, _To>
 {
 template<class _Ufrom>
  static typename add_rvalue_reference<_Ufrom>::type _Create();


 template<class _Uto>
  static auto _Fn(int, _Uto)
   -> true_type;
 template<class _Uto>
  static auto _Fn(_Wrap_int, ...)
   -> false_type;

 typedef decltype(_Fn<_To>(0, _Create<_From>())) type;
#line 816 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
 };


template<class _From, class _To>
 struct is_convertible


  : _Cat_base<is_void<typename remove_volatile<_From>::type>::value && is_void<typename remove_volatile<_To>::type>::value || _Is_convertible< !is_void<typename remove_volatile<_From>::type>::value && !is_function<typename remove_volatile<_From>::type>::value && !is_void<typename remove_volatile<_To>::type>::value && !is_function<typename remove_volatile<_To>::type>::value, typename remove_volatile<_From>::type, typename remove_volatile<_To>::type>::type::value>






 {
 };
#line 885 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct is_enum
  : _Cat_base<__is_enum(_Ty)>
 {
 };


template<class _Ty>
 struct is_compound
  : _Cat_base<!is_fundamental<_Ty>::value>
 {
 };


template<class _Ty>
 struct is_member_pointer
  : _Cat_base<is_member_object_pointer<_Ty>::value
  || is_member_function_pointer<_Ty>::value>
 {
 };


template<class _Ty>
 struct is_scalar
  : _Cat_base<is_arithmetic<_Ty>::value
  || is_enum<_Ty>::value
  || is_pointer<_Ty>::value
  || is_member_pointer<_Ty>::value
  || _Is_nullptr_t<_Ty>::value>
 {
 };


template<class _Ty>
 struct is_const
  : _Cat_base<_Ptr_traits<_Ty *>::_Is_const
  && !is_function<_Ty>::value>
 {
 };

template<class _Ty, unsigned int _Nx>
 struct is_const<_Ty[_Nx]>
  : false_type
 {
 };

template<class _Ty, unsigned int _Nx>
 struct is_const<const _Ty[_Nx]>
  : true_type
 {
 };

template<class _Ty>
 struct is_const<_Ty&>
  : false_type
 {
 };


template<class _Ty>
 struct is_const<_Ty&&>
  : false_type
 {
 };



template<class _Ty>
 struct is_volatile
  : _Cat_base<_Ptr_traits<_Ty *>::_Is_volatile
  && !is_function<_Ty>::value>
 {
 };

template<class _Ty>
 struct is_volatile<_Ty&>
  : false_type
 {
 };


template<class _Ty>
 struct is_volatile<_Ty&&>
  : false_type
 {
 };



template<class _Ty>
 struct _Is_pod : _Cat_base<is_scalar<_Ty>::value || __is_pod(_Ty)>
 {
 };

template<class _Ty>
 struct is_pod
  : _Is_pod<typename remove_all_extents<_Ty>::type>
 {
 };


template<class _Ty>
 struct is_empty : _Cat_base<__is_empty(_Ty)>
 {
 };


template<class _Ty>
 struct is_polymorphic : _Cat_base<__is_polymorphic(_Ty)>
 {
 };


template<class _Ty>
 struct is_abstract : _Cat_base<__is_abstract(_Ty)>
 {
 };


template<class _Ty>
 struct is_standard_layout : is_pod<_Ty>
 {
 };


template<class _Ty>
 struct is_literal_type : _Cat_base<is_scalar<_Ty>::value>
 {
 };


template<class _Ty>
 struct is_trivial : is_pod<_Ty>
 {
 };


template<class _Ty>
 struct has_virtual_destructor
  : _Cat_base<__has_virtual_destructor(_Ty)>
 {
 };
#line 1042 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<bool,
 class _Ty,
 class... _Args>
 struct _Is_constructible
  : false_type
 {
 };

template<class _Ty,
 class... _Args>
 struct _Is_constructible<true, _Ty, _Args...>
 {

 template<class _Uty>
  static auto _Fn(int)
   -> decltype(_Uty(::std:: declval<_Args>()...), true_type());
 template<class _Uty>
  static auto _Fn(_Wrap_int)
   -> false_type;

 typedef decltype(_Fn<_Ty>(0)) type;




 };

template<class _Ty,
 class... _Args>
 struct is_constructible
  : _Is_constructible<is_object<_Ty>::value
    && (!is_scalar<_Ty>::value || sizeof...(_Args) <= 1),
   typename remove_all_extents<_Ty>::type,
   _Args...>::type
 {
 };
#line 1150 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct is_copy_constructible
  : _Cat_base<!is_array<_Ty>::value
   && is_constructible<
    typename remove_volatile<
     typename remove_reference<_Ty>::type>::type,
    typename add_lvalue_reference<
    typename add_const<
    typename remove_volatile<_Ty>::type>::type>::type>::value>
 {
 };


template<class _Ty>
 struct has_copy_constructor
  : is_copy_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct is_default_constructible
  : is_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct has_default_constructor
  : is_default_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct is_move_constructible
  : is_constructible<
   typename remove_reference<_Ty>::type,
   typename add_rvalue_reference<_Ty>::type
  >::type
 {
 };


template<class _Ty>
 struct has_move_constructor
  : is_move_constructible<_Ty>::type
 {
 };


template<bool,
 class _To,
 class _From>
 struct _Is_assignable
  : false_type
 {
 };

template<class _To,
 class _From>
 struct _Is_assignable<true, _To, _From>
 {

 template<class _Uty>
  static auto _Fn(int)
   -> decltype((::std:: declval<_Uty>() = ::std:: declval<_From>()),
    true_type());

 template<class _Uty>
  static auto _Fn(_Wrap_int)
   -> false_type;

 typedef decltype(_Fn<_To>(0)) type;
#line 1233 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
 };

template<class _To,
 class _From>
 struct is_assignable
  : _Is_assignable<
   is_object<typename remove_reference<_To>::type>::value
   && !is_array<typename remove_reference<_To>::type>::value
   && is_object<typename remove_reference<_From>::type>::value
   && !is_array<typename remove_reference<_From>::type>::value,
   _To, _From>::type

 {
 };


template<class _Ty>
 struct is_copy_assignable
  : is_assignable<typename add_lvalue_reference<
    typename remove_volatile<_Ty>::type>::type,
   typename add_lvalue_reference<
    typename add_const<
     typename remove_volatile<_Ty>::type>::type>::type>::type
 {
 };


template<class _Ty>
 struct has_copy_assign
  : is_copy_assignable<_Ty>::type
 {
 };


template<class _Ty>
 struct is_move_assignable
  : is_assignable<typename add_lvalue_reference<
    typename remove_volatile<_Ty>::type>::type,
   typename add_rvalue_reference<
    typename remove_volatile<_Ty>::type>::type>::type
 {
 };

template<class _Ty>
 struct has_move_assign
  : is_move_assignable<_Ty>::type
 {
 };


template<class _Ty>
 struct _Is_destructible
  : true_type
 {
 };

template<>
 struct _Is_destructible<void>
  : false_type
 {
 };

template<class _Ty>
 struct is_destructible
  : _Is_destructible<typename remove_cv<_Ty>::type>
 {
 };
#line 1315 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty,
 class... _Args>
 struct is_trivially_constructible
  : is_constructible<_Ty, _Args...>

 {
 };

template<class _Ty>
 struct is_trivially_constructible<_Ty, _Ty>
  : _Cat_base<!is_array<_Ty>::value && __has_trivial_copy(_Ty)>

 {
 };

template<class _Ty>
 struct is_trivially_constructible<_Ty>
  : _Cat_base<is_pod<_Ty>::value || !is_array<_Ty>::value && __has_trivial_constructor(_Ty)>

 {
 };
#line 1393 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct is_trivially_copy_constructible
  : _Cat_base<!is_array<_Ty>::value && __has_trivial_copy(_Ty)>
 {
 };


template<class _Ty>
 struct is_trivially_copyable
  : is_trivially_copy_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct has_trivial_copy_constructor
  : is_trivially_copy_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct is_trivially_default_constructible
  : is_trivially_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct has_trivial_default_constructor
  : is_trivially_default_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct is_trivially_move_constructible
  : _Cat_base<!is_array<_Ty>::value && is_trivially_constructible< typename remove_volatile<_Ty>::type, typename add_rvalue_reference< typename remove_volatile<_Ty>::type>::type>::value>
 {
 };


template<class _Ty>
 struct has_trivial_move_constructor
  : is_trivially_move_constructible<_Ty>::type
 {
 };


template<class _To,
 class _From>
 struct is_trivially_assignable
  : is_assignable<_To, _From>::type
 {
 };


template<class _Ty>
 struct is_trivially_copy_assignable
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_trivial_assign(typename remove_reference<_Ty>::type))>
 {
 };


template<class _Ty>
 struct has_trivial_copy_assign
  : is_trivially_copy_assignable<_Ty>::type
 {
 };


template<class _Ty>
 struct is_trivially_move_assignable
  : is_trivially_assignable<typename add_lvalue_reference< typename remove_volatile<_Ty>::type>::type, typename add_rvalue_reference< typename remove_volatile<_Ty>::type>::type>::type
 {
 };


template<class _Ty>
 struct has_trivial_move_assign
  : is_trivially_move_assignable<_Ty>::type
 {
 };


template<class _Ty>
 struct is_trivially_destructible
  : _Cat_base<is_pod<_Ty>::value || __has_trivial_destructor(_Ty)>
 {
 };
#line 1498 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty,
 class... _Args>
 struct is_nothrow_constructible
  : is_constructible<_Ty, _Args...>

 {
 };

template<class _Ty>
 struct is_nothrow_constructible<_Ty, _Ty>
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_nothrow_copy(typename remove_reference<_Ty>::type))>

 {
 };

template<class _Ty>
 struct is_nothrow_constructible<_Ty>
  : _Cat_base<__has_nothrow_constructor(_Ty)>

 {
 };
#line 1575 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct is_nothrow_copy_constructible
  : _Cat_base<!is_array<_Ty>::value
   && is_nothrow_constructible<
    typename remove_volatile<_Ty>::type,
    typename add_lvalue_reference<
    typename add_const<
     typename remove_volatile<_Ty>::type>::type>::type>::value>
 {
 };


template<class _Ty>
 struct has_nothrow_copy_constructor
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_nothrow_copy(typename remove_reference<_Ty>::type))>
 {
 };


template<class _Ty>
 struct is_nothrow_default_constructible
  : is_nothrow_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct has_nothrow_default_constructor
  : is_nothrow_default_constructible<_Ty>::type
 {
 };


template<class _Ty>
 struct is_nothrow_move_constructible
  : _Cat_base<!is_array<_Ty>::value
   && is_nothrow_constructible<
    typename remove_volatile<_Ty>::type,
    typename add_rvalue_reference<
    typename remove_volatile<_Ty>::type>::type>::value>
 {
 };


template<class _Ty>
 struct has_nothrow_move_constructor
  : is_nothrow_move_constructible<_Ty>::type
 {
 };


template<class _To,
 class _From>
 struct is_nothrow_assignable
  : _Cat_base<!is_array<_To>::value && (is_pod<typename remove_reference<_To>::type>::value || __has_nothrow_assign(typename remove_reference<_To>::type))>
 {
 };


template<class _Ty>
 struct is_nothrow_copy_assignable
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_nothrow_assign(typename remove_reference<_Ty>::type))>
 {
 };


template<class _Ty>
 struct has_nothrow_copy_assign
  : is_nothrow_copy_assignable<_Ty>::type
 {
 };


template<class _Ty>
 struct is_nothrow_move_assignable
  : is_nothrow_assignable<typename add_lvalue_reference< typename remove_volatile<_Ty>::type>::type, typename add_rvalue_reference< typename remove_volatile<_Ty>::type>::type>::type
 {
 };


template<class _Ty>
 struct has_nothrow_move_assign
  : is_nothrow_move_assignable<_Ty>::type
 {
 };


template<class _Ty>
 struct _Is_nothrow_destructible
  : true_type
 {
 };

template<>
 struct _Is_nothrow_destructible<void>
  : false_type
 {
 };

template<class _Ty>
 struct is_nothrow_destructible
  : _Is_nothrow_destructible<typename remove_cv<_Ty>::type>
 {
 };


template<class _Ty>
 struct has_trivial_constructor
  : _Cat_base<is_pod<_Ty>::value || !is_array<_Ty>::value && __has_trivial_constructor(_Ty)>
 {
 };


template<class _Ty>
 struct has_trivial_copy
  : _Cat_base<!is_array<_Ty>::value && __has_trivial_copy(_Ty)>
 {
 };


template<class _Ty>
 struct has_trivial_assign
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_trivial_assign(typename remove_reference<_Ty>::type))>
 {
 };


template<class _Ty>
 struct has_trivial_destructor
  : _Cat_base<is_pod<_Ty>::value || __has_trivial_destructor(_Ty)>
 {
 };


template<class _Ty>
 struct has_nothrow_constructor
  : _Cat_base<__has_nothrow_constructor(_Ty)>
 {
 };


template<class _Ty>
 struct has_nothrow_copy
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_nothrow_copy(typename remove_reference<_Ty>::type))>
 {
 };


template<class _Ty>
 struct has_nothrow_assign
  : _Cat_base<!is_array<_Ty>::value && (is_pod<typename remove_reference<_Ty>::type>::value || __has_nothrow_assign(typename remove_reference<_Ty>::type))>
 {
 };


template<class _Ty>
 struct _Has_signed_vals
  : _Cat_base<(typename remove_cv<_Ty>::type)(-1)
  < (typename remove_cv<_Ty>::type)(0)>
 {
 };

template<class _Ty>
 struct is_signed
  : _Cat_base<is_floating_point<_Ty>::value || (is_integral<_Ty>::value
  && _Has_signed_vals<
   typename _If<is_integral<_Ty>::value, _Ty, int>::type>::value)>
 {
 };


template<class _Ty>
 struct is_unsigned
  : _Cat_base<is_integral<_Ty>::value
  && !_Has_signed_vals<
   typename _If<is_integral<_Ty>::value, _Ty, int>::type>::value>
 {
 };


template<class _Ty>
 struct _Change_sign
 {
 _Change_sign()
  {
 static_assert(((is_integral<_Ty>::value || is_enum<_Ty>::value) && !is_same<_Ty, bool>::value), "make_signed<T>/make_unsigned<T> require that T shall be a (possibly " "cv-qualified) integral type or enumeration but not a bool type.");




  }

 typedef
  typename _If<is_same<_Ty, signed char>::value
   || is_same<_Ty, unsigned char >::value, signed char,
  typename _If<is_same<_Ty, short >::value
   || is_same<_Ty, unsigned short >::value, short,
  typename _If<is_same<_Ty, int >::value
   || is_same<_Ty, unsigned int >::value, int,
  typename _If<is_same<_Ty, long >::value
   || is_same<_Ty, unsigned long >::value, long,
  typename _If<is_same<_Ty, long long >::value
   || is_same<_Ty, unsigned long long>::value, long long,
  typename _If<sizeof (_Ty) == sizeof (signed char), signed char,
  typename _If<sizeof (_Ty) == sizeof (short ), short,
  typename _If<sizeof (_Ty) == sizeof (int ), int,
  typename _If<sizeof (_Ty) == sizeof (long ), long,
   long long
  >::type>::type>::type>::type>::type>::type>::type>::type>::type
   _Signed;

 typedef
  typename _If<is_same<_Signed, signed char>::value, unsigned char,
  typename _If<is_same<_Signed, short >::value, unsigned short,
  typename _If<is_same<_Signed, int >::value, unsigned int,
  typename _If<is_same<_Signed, long >::value, unsigned long,
   unsigned long long
  >::type>::type>::type>::type
   _Unsigned;
 };

template<class _Ty>
 struct _Change_sign<const _Ty>
 {
 typedef const typename _Change_sign<_Ty>::_Signed _Signed;
 typedef const typename _Change_sign<_Ty>::_Unsigned _Unsigned;
 };

template<class _Ty>
 struct _Change_sign<volatile _Ty>
 {
 typedef volatile typename _Change_sign<_Ty>::_Signed _Signed;
 typedef volatile typename _Change_sign<_Ty>::_Unsigned _Unsigned;
 };

template<class _Ty>
 struct _Change_sign<const volatile _Ty>
 {
 typedef const volatile typename _Change_sign<_Ty>::_Signed _Signed;
 typedef const volatile typename _Change_sign<_Ty>::_Unsigned _Unsigned;
 };


template<class _Ty>
 struct make_signed
 {
 typedef typename _Change_sign<_Ty>::_Signed type;
 };


template<class _Ty>
 struct make_unsigned
 {
 typedef typename _Change_sign<_Ty>::_Unsigned type;
 };
#line 1846 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct alignment_of
  : integral_constant<size_t,
   __alignof__(typename remove_reference<_Ty>::type)>
 {
 };






template<class _Ty,
 size_t _Len>
 union _Align_type
 {
 _Ty _Val;
 char _Pad[_Len];
 };

template<size_t _Len,
 size_t _Align,
 class _Ty,
 bool _Ok>
 struct _Aligned;

template<size_t _Len,
 size_t _Align,
 class _Ty>
 struct _Aligned<_Len, _Align, _Ty, true>
 {
 typedef _Align_type<_Ty, _Len> type;
 };

template<size_t _Len,
 size_t _Align>
 struct _Aligned<_Len, _Align, double, false>
 {
 typedef _Align_type<max_align_t, _Len> type;
 };

template<size_t _Len,
 size_t _Align>
 struct _Aligned<_Len, _Align, int, false>
 {
 typedef typename _Aligned<_Len, _Align, double, _Align <= alignment_of<double>::value>::type type;
 };

template<size_t _Len,
 size_t _Align>
 struct _Aligned<_Len, _Align, short, false>
 {
 typedef typename _Aligned<_Len, _Align, int, _Align <= alignment_of<int>::value>::type type;
 };

template<size_t _Len,
 size_t _Align>
 struct _Aligned<_Len, _Align, char, false>
 {
 typedef typename _Aligned<_Len, _Align, short, _Align <= alignment_of<short>::value>::type type;
 };

template<size_t _Len,
 size_t _Align = alignment_of<max_align_t>::value>
 struct aligned_storage
 {
 typedef typename _Aligned<_Len, _Align, char, _Align <= alignment_of<char>::value>::type type;
 };
#line 1922 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<size_t... _Vals>
 struct _Maximum;

template<>
 struct _Maximum<>
 {
 static const size_t value = 0;
 };

template<size_t _Val>
 struct _Maximum<_Val>
 {
 static const size_t value = _Val;
 };

template<size_t _First,
 size_t _Second,
 size_t... _Rest>
 struct _Maximum<_First, _Second, _Rest...>
  : _Maximum<(_First < _Second ? _Second : _First), _Rest...>
 {
 };

template<size_t _Len,
 class... _Types>
 struct aligned_union
 {
 static const size_t _Max_len = _Maximum<
  _Len, sizeof(_Types)...>::value;
 static const size_t alignment_value = _Maximum<
  alignment_of<_Types>::value...>::value;
 typedef typename aligned_storage<_Max_len, alignment_value>::type type;
 };
#line 1985 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty>
 struct underlying_type
 {
 typedef int type;
 };



template<class _Ty>
 struct rank
  : integral_constant<size_t, 0>
 {
 };

template<class _Ty, unsigned int _Ix>
 struct rank<_Ty[_Ix]>
  : integral_constant<size_t, rank<_Ty>::value + 1>
 {
 };

template<class _Ty>
 struct rank<_Ty[]>
  : integral_constant<size_t, rank<_Ty>::value + 1>
 {
 };


template<class _Ty, unsigned int _Nx>
 struct _Extent
  : integral_constant<size_t, 0>
 {
 };

template<class _Ty, unsigned int _Ix>
 struct _Extent<_Ty[_Ix], 0>
  : integral_constant<size_t, _Ix>
 {
 };

template<class _Ty, unsigned int _Nx, unsigned int _Ix>
 struct _Extent<_Ty[_Ix], _Nx>
  : _Extent<_Ty, _Nx - 1>
 {
 };

template<class _Ty, unsigned int _Nx>
 struct _Extent<_Ty[], _Nx>
  : _Extent<_Ty, _Nx - 1>
 {
 };

template<class _Ty, unsigned int _Nx = 0>
 struct extent
  : _Extent<_Ty, _Nx>
 {
 };


template<class _Base, class _Der>
 struct is_base_of : _Cat_base<__is_base_of(_Base, _Der)>
 {
 };


template<class _Ty>
 struct decay
 {
 typedef typename remove_reference<_Ty>::type _Ty1;

 typedef typename _If<is_array<_Ty1>::value,
  typename remove_extent<_Ty1>::type *,
  typename _If<is_function<_Ty1>::value,
   typename add_pointer<_Ty1>::type,
   typename remove_cv<_Ty1>::type>::type>::type type;
 };


namespace tr1 {
using ::std:: add_const;
using ::std:: add_cv;
using ::std:: add_pointer;
using ::std:: add_reference;
using ::std:: add_volatile;
using ::std:: aligned_storage;
using ::std:: alignment_of;
using ::std:: conditional;
using ::std:: decay;
using ::std:: enable_if;
using ::std:: extent;
using ::std:: false_type;
using ::std:: has_nothrow_assign;
using ::std:: has_nothrow_constructor;
using ::std:: has_nothrow_copy;
using ::std:: has_trivial_assign;
using ::std:: has_trivial_constructor;
using ::std:: has_trivial_copy;
using ::std:: has_trivial_destructor;
using ::std:: has_virtual_destructor;
using ::std:: integral_constant;
using ::std:: is_abstract;
using ::std:: is_arithmetic;
using ::std:: is_array;
using ::std:: is_base_of;
using ::std:: is_class;
using ::std:: is_compound;
using ::std:: is_const;
using ::std:: is_convertible;
using ::std:: is_empty;
using ::std:: is_enum;
using ::std:: is_floating_point;
using ::std:: is_function;
using ::std:: is_fundamental;
using ::std:: is_integral;
using ::std:: is_member_function_pointer;
using ::std:: is_member_object_pointer;
using ::std:: is_member_pointer;
using ::std:: is_object;
using ::std:: is_pod;
using ::std:: is_pointer;
using ::std:: is_polymorphic;
using ::std:: is_reference;
using ::std:: is_same;
using ::std:: is_scalar;
using ::std:: is_signed;
using ::std:: is_union;
using ::std:: is_unsigned;
using ::std:: is_void;
using ::std:: is_volatile;
using ::std:: make_signed;
using ::std:: make_unsigned;
using ::std:: rank;
using ::std:: remove_all_extents;
using ::std:: remove_const;
using ::std:: remove_cv;
using ::std:: remove_extent;
using ::std:: remove_pointer;
using ::std:: remove_reference;
using ::std:: remove_volatile;
using ::std:: true_type;
 }






template<class... _Ty>
 struct common_type;

template<class _Ty>
 struct common_type<_Ty>
 {
 typedef typename decay<_Ty>::type type;
 };

template<class _Ty0,
 class _Ty1>
 struct common_type<_Ty0, _Ty1>
 {
 typedef typename decay<
  decltype(_Always_false<_Ty0>::value
   ? ::std:: declval<_Ty0>()
   : ::std:: declval<_Ty1>())
 >::type type;
 };

template<class _Ty0,
 class _Ty1,
 class... _Ty>
 struct common_type<_Ty0, _Ty1, _Ty...>
 {
 typedef typename common_type<
  typename common_type<_Ty0, _Ty1>::type, _Ty...
 >::type type;
 };
#line 2209 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<size_t... _Indexes>
 struct _Arg_idx
 {
 };



template<class _Ty>
 class reference_wrapper;

template<class _Ty>
 struct _Unrefwrap_helper
 {
 typedef _Ty type;
 };

template<class _Ty>
 struct _Unrefwrap_helper<reference_wrapper<_Ty> >
 {
 typedef _Ty& type;
 };

template<class _Ty>
 struct _Unrefwrap
 {
 typedef typename decay<_Ty>::type _Ty1;
 typedef typename _Unrefwrap_helper<_Ty1>::type type;
 };


template<class _Ty>
 struct identity
 {
 typedef _Ty type;

 const _Ty& operator()(const _Ty& _Left) const
  {
  return (_Left);
  }
 };





template<class _Ty> inline
 _Ty&& forward(typename remove_reference<_Ty>::type& _Arg)
 {
 return (static_cast<_Ty&&>(_Arg));
 }

template<class _Ty> inline
 _Ty&& forward(typename remove_reference<_Ty>::type&& _Arg)
 {
 static_assert(!is_lvalue_reference<_Ty>::value, "bad forward call");
 return (static_cast<_Ty&&>(_Arg));
 }
#line 2278 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty> inline
 typename remove_reference<_Ty>::type&&
  move(_Ty&& _Arg)
 {
 return ((typename remove_reference<_Ty>::type&&)_Arg);
 }
#line 2297 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty> inline
 typename remove_reference<_Ty>::type&&
  _Move(_Ty&& _Arg)
 {
 return ((typename remove_reference<_Ty>::type&&)_Arg);
 }


template<class _Ty> inline
 typename _If<!has_nothrow_move_constructor<_Ty>::value
  && has_copy_constructor<_Ty>::value,
   const _Ty&, _Ty&&>::type
 move_if_noexcept(_Ty& _Arg)
 {
 return (::std:: move(_Arg));
 }
#line 2384 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
template<class _Ty> inline
 typename decay<_Ty>::type _Decay_copy(_Ty && _Arg)
 {
 return (::std:: forward<_Ty>(_Arg));
 }
}



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"






namespace std {
template<class _Ty>
 class reference_wrapper;



template<class _Ret,
 class... _Types>
 struct _Fun_class_base
 {
 };

template<class _Ret,
 class _Farg0>
 struct _Fun_class_base<_Ret, _Farg0>
  : public unary_function<_Farg0, _Ret>
 {
 };

template<class _Ret,
 class _Farg0,
 class _Farg1>
 struct _Fun_class_base<_Ret, _Farg0, _Farg1>
  : public binary_function<_Farg0, _Farg1, _Ret>
 {
 };

template<class _Ret,
 class _Farg0,
 class _Farg1,
 class... _Types>
 struct _Fun_class_base<_Ret, _Farg0, _Farg1, _Types...>
 {
 };
#line 82 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Fty,
 class... _Args>
 struct _Result_of
 {
 typedef decltype(
  ::std:: declval<_Fty>()(::std:: declval<_Args>()...)) type;
 };
#line 103 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* )(_Mfargs...) , _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* )(_Mfargs...) const, _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* )(_Mfargs...) volatile, _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* )(_Mfargs...) const volatile, _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* const)(_Mfargs...) , _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* const)(_Mfargs...) const, _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* const)(_Mfargs...) volatile, _Obj, _Args...> { typedef _Ret type; }; template<class _Ret, class _Ty, class... _Mfargs, class _Obj, class... _Args> struct _Result_of<_Ret ( _Ty::* const)(_Mfargs...) const volatile, _Obj, _Args...> { typedef _Ret type; };


template<class _Ret,
 class _Ty,
 class _Obj,
 class... _Args>
 struct _Result_of<_Ret _Ty::*, _Obj, _Args...>
 {

 typedef typename _Copy_cv<_Ret,
  typename remove_pointer<
   typename remove_reference<_Obj>::type>::type>::type type;
 };

template<class _Ret,
 class _Ty,
 class _Obj,
 class... _Args>
 struct _Result_of<_Ret _Ty::*const, _Obj, _Args...>
 {

 typedef typename _Copy_cv<_Ret,
  typename remove_pointer<
   typename remove_reference<_Obj>::type>::type>::type const type;
 };

template<class _Fty>
 struct result_of;
#line 147 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Fty, class... _Args> struct result_of<_Fty (_Args...)> { typedef typename _Result_of<_Fty, _Args...>::type type; }; template<class _Fty, class... _Args> struct result_of<reference_wrapper<_Fty> (_Args...)> { typedef typename _Result_of<_Fty, _Args...>::type type; };
#line 366 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Ret,
 class _Arg0>
 struct _Pmd_caller
 {
 template<class _Pmd,
  class _Farg0>
  static _Ret& _Call_pmd(_Pmd _Pm, _Farg0 && _Fx0, true_type)
  {
  return ((_Ret&)(_Fx0.*_Pm));
  }

 template<class _Pmd,
  class _Farg0>
  static _Ret& _Call_pmd(_Pmd _Pm, _Farg0 && _Fx0, false_type)
  {
  return ((_Ret&)((*_Fx0).*_Pm));
  }

 template<class _Pmd,
  class _Farg0>
  static _Ret& _Apply_pmd(_Pmd _Pm, _Farg0 && _Fx0)
  {
  typedef typename remove_cv<
   typename remove_reference<_Arg0>::type>::type _Arg0_bare;
  typedef typename remove_cv<
   typename remove_reference<_Farg0>::type>::type _Farg0_bare;
  typedef _Cat_base<is_same<_Arg0_bare, _Farg0_bare>::value
   || (is_base_of<_Arg0_bare, _Farg0_bare>::value
    && is_same<typename add_reference<_Farg0_bare>::type,
     _Farg0>::value)> _Is_obj;

  return (_Call_pmd<_Pmd, _Farg0>(_Pm,
   ::std:: forward<_Farg0>(_Fx0), _Is_obj()));
  }
 };


template<class _Ty,
 bool _Indirect>
 struct _Callable_base;

template<class _Ty>
 struct _Callable_base<_Ty, false>
 {
 typedef _Ty _MyTy;
 typedef const _Ty& _MyCnstTy;

 _Callable_base(const _Ty& _Val)
  : _Object(_Val)
  {
  }

 const _Ty& _Get() const
  {
  return (_Object);
  }

 _Ty& _Get()
  {
  return (_Object);
  }

 void _Reset(_Ty& _Val)
  {
  static_assert(_Always_false<_Ty>::value, "can't assign to reference_wrapper<T&>");

  }

private:
 _Callable_base& operator=(const _Callable_base&);

 _Ty _Object;
};

template<class _Ty>
 struct _Callable_base<_Ty, true>
 {


 typedef _Ty _MyTy;
 typedef _Ty& _MyCnstTy;

 _Callable_base(_Ty& _Val)
  : _Ptr(::std:: addressof(_Val))
  {
  }

 _MyCnstTy _Get() const
  {
  return (*_Ptr);
  }

 _Ty& _Get()
  {
  return (*_Ptr);
  }

 void _Reset(_Ty& _Val)
  {
  _Ptr = ::std:: addressof(_Val);
  }

private:
 _Ty *_Ptr;
};


template<class _Ty,
 class _Memty,
 bool _Indirect = false>
 struct _Callable_pmd
  : _Callable_base<_Ty, _Indirect>
 {
 _Callable_pmd(const _Callable_pmd& _Right)
  : _Callable_base<_Ty, _Indirect>(_Right._Get())
  {
  }

 _Callable_pmd(_Ty& _Val)
  : _Callable_base<_Ty, _Indirect>(_Val)
  {
  }

 template<class _Ret,
  class _Arg0>
  _Ret& _ApplyX(_Arg0 && _A0) const
  {
  return (_Pmd_caller<_Ret, _Memty>::
   _Apply_pmd(this->_Get(), ::std:: forward<_Arg0>(_A0)));
  }
 };


template<class _Ty,
 bool _Indirect = false>
 struct _Callable_obj
  : _Callable_base<_Ty, _Indirect>
 {
 typedef _Callable_base<_Ty, _Indirect> _Mybase;

 template<class _Ty2>
  _Callable_obj(_Ty2 && _Val)
  : _Mybase(::std:: forward<_Ty2>(_Val))
  {
  }


 template<class _Ret,
  class... _Types>
  _Ret _ApplyX(_Types&&... _Args) const
  {
  return (this->_Get()(::std:: forward<_Types>(_Args)...));
  }

 template<class _Ret,
  class... _Types>
  _Ret _ApplyX(_Types&&... _Args)
  {
  return (this->_Get()(::std:: forward<_Types>(_Args)...));
  }
#line 544 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
 };




template<class _Ret,
 class _Arg0>
 struct _Pmf_caller
 {
 template<class _Pmf,
  class _Farg0,
  class... _Ftypes>
  static _Ret _Call_pmf(_Pmf _Pm, _Farg0&& _Fx0, true_type,
   _Ftypes&&... _Fargs)
  {
  typedef typename _Copy_cv<_Arg0, _Farg0>::type
   _Funobj_cv;
  return (((_Funobj_cv)_Fx0.*_Pm)(::std:: forward<_Ftypes>(_Fargs)...));
  }

 template<class _Pmf,
  class _Farg0,
  class... _Ftypes>
  static _Ret _Call_pmf(_Pmf _Pm, _Farg0&& _Fx0, false_type,
   _Ftypes&&... _Fargs)
  {
  return (((*_Fx0).*_Pm)(::std:: forward<_Ftypes>(_Fargs)...));
  }

 template<class _Pmf,
  class _Farg0,
  class... _Ftypes>
  static _Ret _Apply_pmf(_Pmf _Pm, _Farg0&& _Fx0,
   _Ftypes&&... _Fargs)
  {
  typedef typename remove_reference<_Arg0>::type _Arg0_bare0;
  typedef typename remove_cv<_Arg0_bare0>::type _Arg0_bare;
  typedef typename remove_reference<_Farg0>::type _Farg0_bare;
  typedef _Cat_base<is_same<_Arg0_bare, _Farg0_bare>::value
   || (is_base_of<_Arg0_bare, _Farg0_bare>::value
    && is_same<typename add_reference<_Farg0_bare>::type,
     _Farg0>::value)> _Is_obj;

  return (_Call_pmf<_Pmf, _Farg0&&, _Ftypes&&...>(_Pm,
   ::std:: forward<_Farg0>(_Fx0), _Is_obj(),
    ::std:: forward<_Ftypes>(_Fargs)...));
  }
 };
#line 648 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Ty,
 class _Memty,
 bool _Indirect = false>
 struct _Callable_pmf
  : _Callable_base<_Ty, _Indirect>
 {
 _Callable_pmf(const _Callable_pmf& _Right)
  : _Callable_base<_Ty, _Indirect>(_Right._Get())
  {
  }

 _Callable_pmf(_Ty& _Val)
  : _Callable_base<_Ty, _Indirect>(_Val)
  {
  }


 template<class _Ret,
  class... _Types>
  _Ret _ApplyX(_Types&&... _Args) const
  {
  return (_Pmf_caller<_Ret, _Memty>::
   _Apply_pmf(this->_Get(), ::std:: forward<_Types>(_Args)...));
  }
#line 689 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
 };


template<class _Ty,
 bool _Indirect = false>
 struct _Callable_fun
  : _Callable_base<_Ty, _Indirect>
 {
 _Callable_fun(const _Callable_fun& _Right)
  : _Callable_base<_Ty, _Indirect>(_Right._Get())
  {
  }

 _Callable_fun(_Ty& _Val)
  : _Callable_base<_Ty, _Indirect>(_Val)
  {
  }


 template<class _Ret,
  class... _Types>
  _Ret _ApplyX(_Types&&... _Args) const
  {
  return (this->_Get()(::std:: forward<_Types>(_Args)...));
  }
#line 727 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
 };


template<class _Callable>
 struct _Call_wrapper_base
 {
 typedef typename _Callable::_MyTy _MyTy;
 typedef typename _Callable::_MyCnstTy _MyCnstTy;

 _Call_wrapper_base(_MyTy& _Val)
  : _Callee(_Val)
  {
  }

 void _Reset(_MyTy& _Val)
  {
  _Callee._Reset(_Val);
  }

 _MyCnstTy _Get() const
  {
  return (_Callee._Get());
  }

 _MyCnstTy _Get()
  {
  return (_Callee._Get());
  }

 _Callable _Callee;
 };


template<class _Callable,
 bool _Is_abstract = false>
 struct _Call_wrapper
 : _Call_wrapper_base<_Callable>
 {
 typedef _Call_wrapper_base<_Callable> _Mybase;

 _Call_wrapper(typename _Call_wrapper_base<_Callable>::_MyTy& _Val)
  : _Call_wrapper_base<_Callable>(_Val)
  {
  }


 template<class... _Types>
  typename result_of<
   typename _Callable::_MyTy(_Types...)>::type
   operator()(_Types&&... _Args) const
  {
  typedef typename result_of<
   typename _Callable::_MyTy(_Types...)>::type _Ret;
  return (this->_Callee.template _ApplyX<_Ret>(
   ::std:: forward<_Types>(_Args)...));
  }
#line 800 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
 };

template<class _Callable>
 struct _Call_wrapper<_Callable, true>
 : _Call_wrapper_base<_Callable>
 {
 typedef _Call_wrapper_base<_Callable> _Mybase;

 _Call_wrapper(typename _Call_wrapper_base<_Callable>::_MyTy& _Val)
  : _Call_wrapper_base<_Callable>(_Val)
  {
  }
 };


template<class _Ty>
 struct _Has_result_and_arg_type
  { template<class _Uty> static auto _Fn(int, _Identity<typename _Uty::argument_type> * = 0, _Identity<typename _Uty::result_type> * = 0, _Identity<typename _Uty::result_type> * = 0) -> true_type; template<class _Uty> static auto _Fn(_Wrap_int) -> false_type; typedef decltype(_Fn<_Ty>(0)) type; };


template<class _Ty>
 struct _Has_result_and_2arg_type
  { template<class _Uty> static auto _Fn(int, _Identity<typename _Uty::first_argument_type> * = 0, _Identity<typename _Uty::second_argument_type> * = 0, _Identity<typename _Uty::result_type> * = 0) -> true_type; template<class _Uty> static auto _Fn(_Wrap_int) -> false_type; typedef decltype(_Fn<_Ty>(0)) type; };


template<class _Ty,
 bool>
 struct _Refwrap_result0
 {
 typedef typename _Ty::result_type result_type;
 };

template<class _Ty>
 struct _Refwrap_result0<_Ty, false>
 {
 };


template<class _Ty,
 bool>
 struct _Refwrap_result1_helper
  : _Refwrap_result0<_Ty, _Has_result_type<_Ty>::type::value>
 {
 };

template<class _Ty>
 struct _Refwrap_result1_helper<_Ty, true>
  : unary_function<typename _Ty::argument_type,
   typename _Ty::result_type>
 {
 };


template<class _Ty,
 bool>
 struct _Refwrap_result1
  : _Refwrap_result0<_Ty, _Has_result_type<_Ty>::type::value>
 {
 };

template<class _Ty>
 struct _Refwrap_result1<_Ty, true>
  : _Refwrap_result1_helper<_Ty,
   is_base_of<unary_function<
    typename _Ty::argument_type,
    typename _Ty::result_type>, _Ty>::value>
 {
 };


template<class _Ty,
 bool>
 struct _Refwrap_result2_helper
  : _Refwrap_result1<_Ty, _Has_result_and_arg_type<_Ty>::type::value>
 {
 };

template<class _Ty>
 struct _Refwrap_result2_helper<_Ty, true>
  : binary_function<typename _Ty::first_argument_type,
   typename _Ty::second_argument_type,
   typename _Ty::result_type>,
  _Refwrap_result1<_Ty, _Has_result_and_arg_type<_Ty>::type::value>
 {
 };


template<class _Ty,
 bool>
 struct _Refwrap_result2
  : _Refwrap_result1<_Ty, _Has_result_and_arg_type<_Ty>::type::value>
 {
 };

template<class _Ty>
 struct _Refwrap_result2<_Ty, true>
  : _Refwrap_result2_helper<_Ty,
   is_base_of<binary_function<
    typename _Ty::first_argument_type,
    typename _Ty::second_argument_type,
    typename _Ty::result_type>, _Ty>::value>
 {
 };


template<class _Ty>
 struct _Refwrap_impl
  : _Call_wrapper<_Callable_obj<_Ty, true>,
   is_abstract<_Ty>::value>,
   _Refwrap_result2<_Ty, _Has_result_and_2arg_type<_Ty>::type::value>
 {
 _Refwrap_impl(_Ty& _Val)
  : _Call_wrapper<_Callable_obj<_Ty, true>,
   is_abstract<_Ty>::value>(_Val)
  {
  }
 };

template<class _Rx,
 class _Arg0>
 struct _Refwrap_impl<_Rx _Arg0::*>
  : _Call_wrapper<_Callable_pmd<_Rx _Arg0::*, _Arg0, false> >
 {
 typedef _Rx _Arg0::* _Fty;
 typedef _Rx result_type;

 _Refwrap_impl(_Fty& _Val)
  : _Call_wrapper<_Callable_pmd<_Fty, _Arg0, false> >(_Val)
  {
  }
 };

template<class _Rx,
 class _Arg0>
 struct _Refwrap_impl<_Rx _Arg0::*const>
  : _Call_wrapper<_Callable_pmd<_Rx _Arg0::*const, _Arg0, false> >
 {
 typedef _Rx _Arg0::*const _Fty;
 typedef _Rx result_type;
 _Refwrap_impl(_Fty& _Val)
  : _Call_wrapper<_Callable_pmd<_Fty, _Arg0, false> >(_Val)
  {
  }
 };
#line 963 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Rx, class... _Types> struct _Refwrap_impl<_Rx (_Types...)> : _Call_wrapper<_Callable_fun< _Rx( *)(_Types...), false> >, _Fun_class_base<_Rx, _Types...> { typedef _Rx( *_Fty)(_Types...); typedef _Rx result_type; _Refwrap_impl(_Fty _Val) : _Call_wrapper<_Callable_fun<_Fty, false> >(_Val) { } };
#line 983 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Rx, class... _Types> struct _Refwrap_impl<_Rx( *)(_Types...)> : _Call_wrapper<_Callable_fun< _Rx( *)(_Types...), true> >, _Fun_class_base<_Rx, _Types...> { typedef _Rx( * _Fty)(_Types...); typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_fun<_Fty, true> >(_Val) { } }; template<class _Rx, class... _Types> struct _Refwrap_impl<_Rx( *const)(_Types...)> : _Call_wrapper<_Callable_fun< _Rx( *const)(_Types...), true> >, _Fun_class_base<_Rx, _Types...> { typedef _Rx( *const _Fty)(_Types...); typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_fun<_Fty, true> >(_Val) { } };
#line 1005 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* )(_Types...) > : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* )(_Types...) , _Arg0, true> >, _Fun_class_base<_Rx, _Arg0 *, _Types...> { typedef _Rx( _Arg0::* _Fty)(_Types...) ; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* )(_Types...) const> : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* )(_Types...) const, _Arg0, true> >, _Fun_class_base<_Rx, const _Arg0 *, _Types...> { typedef _Rx( _Arg0::* _Fty)(_Types...) const; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* )(_Types...) volatile> : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* )(_Types...) volatile, _Arg0, true> >, _Fun_class_base<_Rx, volatile _Arg0 *, _Types...> { typedef _Rx( _Arg0::* _Fty)(_Types...) volatile; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* )(_Types...) const volatile> : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* )(_Types...) const volatile, _Arg0, true> >, _Fun_class_base<_Rx, const volatile _Arg0 *, _Types...> { typedef _Rx( _Arg0::* _Fty)(_Types...) const volatile; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* const)(_Types...) > : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* const)(_Types...) , _Arg0, true> >, _Fun_class_base<_Rx, _Arg0 *, _Types...> { typedef _Rx( _Arg0::* const _Fty)(_Types...) ; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* const)(_Types...) const> : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* const)(_Types...) const, _Arg0, true> >, _Fun_class_base<_Rx, const _Arg0 *, _Types...> { typedef _Rx( _Arg0::* const _Fty)(_Types...) const; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* const)(_Types...) volatile> : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* const)(_Types...) volatile, _Arg0, true> >, _Fun_class_base<_Rx, volatile _Arg0 *, _Types...> { typedef _Rx( _Arg0::* const _Fty)(_Types...) volatile; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } }; template<class _Rx, class _Arg0, class... _Types> struct _Refwrap_impl<_Rx( _Arg0::* const)(_Types...) const volatile> : _Call_wrapper<_Callable_pmf< _Rx( _Arg0::* const)(_Types...) const volatile, _Arg0, true> >, _Fun_class_base<_Rx, const volatile _Arg0 *, _Types...> { typedef _Rx( _Arg0::* const _Fty)(_Types...) const volatile; typedef _Rx result_type; _Refwrap_impl(_Fty& _Val) : _Call_wrapper<_Callable_pmf<_Fty, _Arg0, true> >(_Val) { } };
#line 1114 "C:\\src\\winrtl\\include\\dinkumware64\\xrefwrap"
template<class _Ty>
 class reference_wrapper
 : public _Refwrap_impl<_Ty>
 {
public:
 typedef reference_wrapper<_Ty> _Myt;
 typedef _Refwrap_impl<_Ty> _Mybase;
 typedef _Ty type;

 reference_wrapper(_Ty& _Val)
  : _Mybase(_Val)
  {
  }

 reference_wrapper(const _Myt& _Right)
  : _Mybase(_Right.get())
  {
  }

 _Myt& operator=(const _Myt& _Right)
  {
  this->_Reset(_Right.get());
  return (*this);
  }

 operator _Ty&() const
  {
  return (this->_Get());
  }

 _Ty& get() const
  {
  return (this->_Get());
  }







private:
 reference_wrapper(_Ty&&);



 };


template<class _Ty>
 reference_wrapper<_Ty>
  ref(_Ty& _Val)
 {
 return (reference_wrapper<_Ty>(_Val));
 }


template<class _Ty>
 void ref(const _Ty&& _Val);


template<class _Ty>
 reference_wrapper<_Ty>
  ref(reference_wrapper<_Ty> _Val)
 {
 return (_Val);
 }

template<class _Ty>
 reference_wrapper<const _Ty>
  cref(const _Ty& _Val)
 {
 return (reference_wrapper<const _Ty>(_Val));
 }


template<class _Ty>
 void cref(const _Ty&& _Val);


template<class _Ty>
 reference_wrapper<const _Ty>
  cref(reference_wrapper<_Ty> _Val)
 {
 return (reference_wrapper<const _Ty>(_Val.get()));
 }


namespace tr1 {
using ::std:: cref;
using ::std:: ref;
using ::std:: reference_wrapper;
using ::std:: result_of;
 }

}
#line 2392 "C:\\src\\winrtl\\include\\dinkumware64\\type_traits"
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\utility"


namespace std {

template<class _Ty> inline
 void swap(_Ty&, _Ty&)

                                             ;

template<class _FwdIt1,
 class _FwdIt2> inline
 void iter_swap(_FwdIt1 _Left, _FwdIt2 _Right)
 {
 swap(*_Left, *_Right);
 }


template<class _Ty,
 size_t _Size> inline
 void swap(_Ty (&_Left)[_Size], _Ty (&_Right)[_Size])

 {
 if (&_Left != &_Right)
  {
  _Ty *_First1 = _Left;
  _Ty *_Last1 = _First1 + _Size;
  _Ty *_First2 = _Right;
  for (; _First1 != _Last1; ++_First1, ++_First2)
   ::std:: iter_swap(_First1, _First2);
  }
 }

template<class _Ty> inline
 void swap(_Ty& _Left, _Ty& _Right)


 {
 _Ty _Tmp = _Move(_Left);
 _Left = _Move(_Right);
 _Right = _Move(_Tmp);
 }


template<class _Ty> inline
 void _Swap_adl(_Ty& _Left, _Ty& _Right)
 {
 swap(_Left, _Right);
 }


struct piecewise_construct_t
 {
 };

const piecewise_construct_t piecewise_construct =
 piecewise_construct_t();




template<class...>
 class tuple;
#line 80 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
template<class _Ty1,
 class _Ty2>
 struct pair
 {
 typedef pair<_Ty1, _Ty2> _Myt;
 typedef _Ty1 first_type;
 typedef _Ty2 second_type;

            pair()
  : first(), second()
  {
  }





 pair(const _Myt& _Right)
  : first(_Right.first), second(_Right.second)
  {
  }


 pair(const _Ty1& _Val1, const _Ty2& _Val2)
  : first(_Val1), second(_Val2)
  {
  }


 template<class _Other1,
  class _Other2,
  class = typename enable_if<is_convertible<const _Other1&, _Ty1>::value
   && is_convertible<const _Other2&, _Ty2>::value,
   void>::type>
  pair(const pair<_Other1, _Other2>& _Right)
  : first(_Right.first), second(_Right.second)
  {
  }
#line 131 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
 template<class _Other1,
  class _Other2>
  _Myt& operator=(const pair<_Other1, _Other2>& _Right)
  {
  first = _Right.first;
  second = _Right.second;
  return (*this);
  }




 template<class _Tuple1,
  class _Tuple2,
  size_t... _Indexes1,
  size_t... _Indexes2> inline
  pair(_Tuple1& _Val1,
   _Tuple2& _Val2,
   _Arg_idx<_Indexes1...>,
   _Arg_idx<_Indexes2...>);
#line 160 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
 template<class... _Types1,
  class... _Types2> inline
  pair(piecewise_construct_t,
   tuple<_Types1...> _Val1,
   tuple<_Types2...> _Val2)

                                                            ;
#line 204 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
 pair(_Myt&& _Right)
  : first(::std:: forward<first_type>(_Right.first)),
   second(::std:: forward<second_type>(_Right.second))
  {
  }


 template<class _Other1,
  class _Other2,
  class = typename enable_if<is_convertible<_Other1, _Ty1>::value
   && is_convertible<_Other2, _Ty2>::value,
   void>::type>
  pair(_Other1&& _Val1, _Other2&& _Val2)


  : first(::std:: forward<_Other1>(_Val1)),
    second(::std:: forward<_Other2>(_Val2))
  {
  }

 template<class _Other1,
  class _Other2,
  class = typename enable_if<is_convertible<_Other1, _Ty1>::value
   && is_convertible<_Other2, _Ty2>::value,
   void>::type>
  pair(pair<_Other1, _Other2>&& _Right)


  : first(::std:: forward<_Other1>(_Right.first)),
   second(::std:: forward<_Other2>(_Right.second))
  {
  }
#line 265 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
 template<class _Other1,
  class _Other2>
  _Myt& operator=(pair<_Other1, _Other2>&& _Right)


  {
  first = ::std:: forward<_Other1>(_Right.first);
  second = ::std:: forward<_Other2>(_Right.second);
  return (*this);
  }

 _Myt& operator=(_Myt&& _Right)


  {
  first = ::std:: forward<_Ty1>(_Right.first);
  second = ::std:: forward<_Ty2>(_Right.second);
  return (*this);
  }


 void swap(_Myt& _Right)


  {
  if (this != &_Right)
   {
   _Swap_adl(first, _Right.first);
   _Swap_adl(second, _Right.second);
   }
  }

 _Myt& operator=(const _Myt& _Right)
  {
  first = _Right.first;
  second = _Right.second;
  return (*this);
  }

 _Ty1 first;
 _Ty2 second;
 };


template<class _Ty1,
 class _Ty2> inline
 void swap(pair<_Ty1, _Ty2>& _Left, pair<_Ty1, _Ty2>& _Right)

 {
 _Left.swap(_Right);
 }

template<class _Ty1,
 class _Ty2> inline
 bool operator==(const pair<_Ty1, _Ty2>& _Left,
  const pair<_Ty1, _Ty2>& _Right)
 {
 return (_Left.first == _Right.first && _Left.second == _Right.second);
 }

template<class _Ty1,
 class _Ty2> inline
 bool operator!=(const pair<_Ty1, _Ty2>& _Left,
  const pair<_Ty1, _Ty2>& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _Ty1,
 class _Ty2> inline
 bool operator<(const pair<_Ty1, _Ty2>& _Left,
  const pair<_Ty1, _Ty2>& _Right)
 {
 return (_Left.first < _Right.first ||
  (!(_Right.first < _Left.first) && _Left.second < _Right.second));
 }

template<class _Ty1,
 class _Ty2> inline
 bool operator>(const pair<_Ty1, _Ty2>& _Left,
  const pair<_Ty1, _Ty2>& _Right)
 {
 return (_Right < _Left);
 }

template<class _Ty1,
 class _Ty2> inline
 bool operator<=(const pair<_Ty1, _Ty2>& _Left,
  const pair<_Ty1, _Ty2>& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _Ty1,
 class _Ty2> inline
 bool operator>=(const pair<_Ty1, _Ty2>& _Left,
  const pair<_Ty1, _Ty2>& _Right)
 {
 return (!(_Left < _Right));
 }




template<class _Ty1,
 class _Ty2> inline
 pair<typename _Unrefwrap<_Ty1>::type,
  typename _Unrefwrap<_Ty2>::type>
  make_pair(_Ty1&& _Val1, _Ty2&& _Val2)
 {
 typedef pair<typename _Unrefwrap<_Ty1>::type,
  typename _Unrefwrap<_Ty2>::type> _Mypair;
 return (_Mypair(::std:: forward<_Ty1>(_Val1),
  ::std:: forward<_Ty2>(_Val2)));
 }
#line 392 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
 namespace rel_ops
  {
template<class _Ty> inline
 bool operator!=(const _Ty& _Left, const _Ty& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _Ty> inline
 bool operator>(const _Ty& _Left, const _Ty& _Right)
 {
 return (_Right < _Left);
 }

template<class _Ty> inline
 bool operator<=(const _Ty& _Left, const _Ty& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _Ty> inline
 bool operator>=(const _Ty& _Left, const _Ty& _Right)
 {
 return (!(_Left < _Right));
 }
  }

}


namespace std {

template<class _Tuple>
 struct tuple_size
 {
 static_assert(_Always_false<_Tuple>::value, "The C++ Standard doesn't define tuple_size for this type.");

 };

template<class _Ty1,
 class _Ty2>
 struct tuple_size<pair<_Ty1, _Ty2> >
 : integral_constant<size_t, 2>
 {
 };


template<class... _Types>
 struct tuple_size<tuple<_Types...> >
 : integral_constant<size_t, sizeof...(_Types)>
 {
 };
#line 458 "C:\\src\\winrtl\\include\\dinkumware64\\utility"
template<class _Tuple>
 struct tuple_size<const _Tuple>
 : tuple_size<_Tuple>
 {
 };

template<class _Tuple>
 struct tuple_size<volatile _Tuple>
 : tuple_size<_Tuple>
 {
 };

template<class _Tuple>
 struct tuple_size<const volatile _Tuple>
 : tuple_size<_Tuple>
 {
 };


template<size_t _Idx,
 class _Tuple>
 struct tuple_element;

template<int _Idx,
 class _Ty>
 struct _Pair_data;

template<class _Ty1,
 class _Ty2>
 struct _Pair_data<0, pair<_Ty1, _Ty2> >
 {
 typedef typename add_lvalue_reference<const _Ty1>::type _Ctype;
 typedef typename add_lvalue_reference<_Ty1>::type _Rtype;
 typedef typename add_rvalue_reference<_Ty1>::type _RRtype;

 static _Rtype _Val(pair<_Ty1, _Ty2>& _Pr)
  {
  return (_Pr.first);
  }

 static _Ctype _Val(const pair<_Ty1, _Ty2>& _Pr)
  {
  return (_Pr.first);
  }


 static _RRtype _Val(pair<_Ty1, _Ty2>&& _Pr)
  {
  return (::std:: forward<_Ty1>(_Pr.first));
  }

 };

template<class _Ty1,
 class _Ty2>
 struct _Pair_data<1, pair<_Ty1, _Ty2> >
 {
 typedef typename add_lvalue_reference<const _Ty2>::type _Ctype;
 typedef typename add_lvalue_reference<_Ty2>::type _Rtype;
 typedef typename add_rvalue_reference<_Ty2>::type _RRtype;

 static _Rtype _Val(pair<_Ty1, _Ty2>& _Pr)
  {
  return (_Pr.second);
  }

 static _Ctype _Val(const pair<_Ty1, _Ty2>& _Pr)
  {
  return (_Pr.second);
  }


 static _RRtype _Val(pair<_Ty1, _Ty2>&& _Pr)
  {
  return (::std:: forward<_Ty2>(_Pr.second));
  }

 };

template<class _Ty1,
 class _Ty2>
 struct tuple_element<0, pair<_Ty1, _Ty2> >
 {
 typedef _Ty1 type;
 };

template<class _Ty1,
 class _Ty2>
 struct tuple_element<1, pair<_Ty1, _Ty2> >
 {
 typedef _Ty2 type;
 };

template<int _Idx,
 class _Ty1,
 class _Ty2> inline
 typename _Pair_data<_Idx, pair<_Ty1, _Ty2> >::_Rtype
  get(pair<_Ty1, _Ty2>& _Pr)
 {
 return (_Pair_data<_Idx, pair<_Ty1, _Ty2> >::_Val(_Pr));
 }

template<int _Idx,
 class _Ty1,
 class _Ty2> inline
 typename _Pair_data<_Idx, pair<_Ty1, _Ty2> >::_Ctype
  get(const pair<_Ty1, _Ty2>& _Pr)
 {
 return (_Pair_data<_Idx, pair<_Ty1, _Ty2> >::_Val(_Pr));
 }


template<int _Idx,
 class _Ty1,
 class _Ty2> inline
 typename _Pair_data<_Idx, pair<_Ty1, _Ty2> >::_RRtype
  get(pair<_Ty1, _Ty2>&& _Pr)
 {
 typedef typename _Pair_data<_Idx, pair<_Ty1, _Ty2> >::_RRtype
  _RRtype;
 return (::std:: forward<_RRtype>(
  _Pair_data<_Idx, pair<_Ty1, _Ty2> >::_Val(_Pr)));
 }

}



namespace std {
namespace tr1 {
using ::std:: get;
using ::std:: tuple_element;
using ::std:: tuple_size;
}
}
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"



namespace std {
#line 82 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
struct _Container_proxy;
struct _Container_base12;
struct _Iterator_base12;

struct __declspec(dllexport) _Container_base0
 {
 void _Orphan_all()
  {
  }

 void _Swap_all(_Container_base0&)
  {
  }


 _Container_proxy *_Myproxy;

 };

struct _Iterator_base0
 {
 void _Adopt(const void *)
  {
  }

 const _Container_base0 *_Getcont() const
  {
  return (0);
  }


 _Container_proxy *_Myproxy;
 _Iterator_base12 *_Mynextiter;

 };


struct _Container_proxy
 {
 _Container_proxy()
  : _Mycont(0), _Myfirstiter(0)
  {
  }

 const _Container_base12 *_Mycont;
 _Iterator_base12 *_Myfirstiter;
 };

struct __declspec(dllexport) _Container_base12
 {
public:
 _Container_base12()
  : _Myproxy(0)
  {
  }

 _Container_base12(const _Container_base12&)
  : _Myproxy(0)
  {
  }

 _Container_base12& operator=(const _Container_base12&)
  {
  return (*this);
  }

 ~_Container_base12()
  {
  _Orphan_all();
  }

 _Iterator_base12 **_Getpfirst() const
  {
  return (_Myproxy == 0 ? 0 : &_Myproxy->_Myfirstiter);
  }

 void _Orphan_all();
 void _Swap_all(_Container_base12&);

 _Container_proxy *_Myproxy;
 };

struct _Iterator_base12
 {
public:
 _Iterator_base12()
  : _Myproxy(0), _Mynextiter(0)
  {
  }

 _Iterator_base12(const _Iterator_base12& _Right)
  : _Myproxy(0), _Mynextiter(0)
  {
  *this = _Right;
  }

 _Iterator_base12& operator=(const _Iterator_base12& _Right)
  {
  if (_Myproxy == _Right._Myproxy)
   ;
  else if (_Right._Myproxy != 0)
   _Adopt(_Right._Myproxy->_Mycont);
  else
   {




   }
  return (*this);
  }

 ~_Iterator_base12()
  {




  }

 void _Adopt(const _Container_base12 *_Parent)
  {
  if (_Parent == 0)
   {




   }
  else
   {
   _Container_proxy *_Parent_proxy = _Parent->_Myproxy;
#line 226 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
   _Myproxy = _Parent_proxy;

   }
  }

 void _Clrcont()
  {
  _Myproxy = 0;
  }

 const _Container_base12 *_Getcont() const
  {
  return (_Myproxy == 0 ? 0 : _Myproxy->_Mycont);
  }

 _Iterator_base12 **_Getpnext()
  {
  return (&_Mynextiter);
  }

 void _Orphan_me()
  {
#line 261 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
  }

 _Container_proxy *_Myproxy;
 _Iterator_base12 *_Mynextiter;
 };


inline void _Container_base12::_Orphan_all()
 {
#line 281 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
 }

inline void _Container_base12::_Swap_all(_Container_base12& _Right)
 {




 _Container_proxy *_Temp = _Myproxy;
 _Myproxy = _Right._Myproxy;
 _Right._Myproxy = _Temp;

 if (_Myproxy != 0)
  _Myproxy->_Mycont = (_Container_base12 *)this;
 if (_Right._Myproxy != 0)
  _Right._Myproxy->_Mycont = (_Container_base12 *)&_Right;
 }


typedef _Container_base0 _Container_base;
typedef _Iterator_base0 _Iterator_base;
#line 314 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _Ty>
 struct _Get_unchecked_type
  { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::_Unchecked_type>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<_Ty>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty>
 struct _Is_checked_helper
  { template<class _Uty> static auto _Fn(int, _Identity<typename _Uty::_Unchecked_type> * = 0, _Identity<typename _Uty::_Unchecked_type> * = 0, _Identity<typename _Uty::_Unchecked_type> * = 0) -> true_type; template<class _Uty> static auto _Fn(_Wrap_int) -> false_type; typedef decltype(_Fn<_Ty>(0)) type; };


template<class _Iter> inline
 typename _Is_checked_helper<_Iter>::type _Is_checked(_Iter)
 {
 return (typename _Is_checked_helper<_Iter>::type());
 }


template<class _Iter> inline
 _Iter _Unchecked(_Iter _Src)
 {
 return (_Src);
 }


template<class _Iter,
 class _UIter> inline
 _Iter& _Rechecked(_Iter& _Dest, _UIter _Src)
 {
 _Dest = _Src;
 return (_Dest);
 }



struct input_iterator_tag
 {
 };

struct _Mutable_iterator_tag
 {
 };

struct output_iterator_tag
 : _Mutable_iterator_tag
 {
 };

struct forward_iterator_tag
 : input_iterator_tag, _Mutable_iterator_tag
 {
 };

struct bidirectional_iterator_tag
 : forward_iterator_tag
 {
 };

struct random_access_iterator_tag
 : bidirectional_iterator_tag
 {
 };


struct _Nonscalar_ptr_iterator_tag
 {
 };
struct _Scalar_ptr_iterator_tag
 {
 };


template<class _Category,
 class _Ty,
 class _Diff = ptrdiff_t,
 class _Pointer = _Ty *,
 class _Reference = _Ty&>
 struct iterator
 {
 typedef _Category iterator_category;
 typedef _Ty value_type;
 typedef _Diff difference_type;
 typedef _Diff distance_type;
 typedef _Pointer pointer;
 typedef _Reference reference;
 };

template<class _Category,
 class _Ty,
 class _Diff,
 class _Pointer,
 class _Reference,
 class _Base>
 struct _Iterator012
  : public _Base
 {
 typedef _Category iterator_category;
 typedef _Ty value_type;
 typedef _Diff difference_type;
 typedef _Diff distance_type;
 typedef _Pointer pointer;
 typedef _Reference reference;
 };


typedef iterator<output_iterator_tag, void, void, void, void> _Outit;


template<class _Iter>
 struct iterator_traits
 {
 typedef typename _Iter::iterator_category iterator_category;
 typedef typename _Iter::value_type value_type;
 typedef typename _Iter::difference_type difference_type;
 typedef difference_type distance_type;
 typedef typename _Iter::pointer pointer;
 typedef typename _Iter::reference reference;
 };

template<class _Ty>
 struct iterator_traits<_Ty *>
 {
 typedef random_access_iterator_tag iterator_category;
 typedef _Ty value_type;
 typedef ptrdiff_t difference_type;
 typedef ptrdiff_t distance_type;
 typedef _Ty *pointer;
 typedef _Ty& reference;
 };

template<class _Ty>
 struct iterator_traits<const _Ty *>
 {
 typedef random_access_iterator_tag iterator_category;
 typedef _Ty value_type;
 typedef ptrdiff_t difference_type;
 typedef ptrdiff_t distance_type;
 typedef const _Ty *pointer;
 typedef const _Ty& reference;
 };


template<class _Iter> inline
 typename iterator_traits<_Iter>::iterator_category
  _Iter_cat(const _Iter&)
 {
 typename iterator_traits<_Iter>::iterator_category _Cat;
 return (_Cat);
 }


template<class _Iter1,
 class _Iter2> inline
 _Nonscalar_ptr_iterator_tag _Ptr_cat(_Iter1&, _Iter2&)
 {
 _Nonscalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }
#line 504 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
inline _Scalar_ptr_iterator_tag _Ptr_cat(_Bool *, _Bool *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const _Bool *, _Bool *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(char *, char *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const char *, char *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(signed char *, signed char *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const signed char *, signed char *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(unsigned char *,
 unsigned char *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const unsigned char *,
 unsigned char *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(short *, short *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const short *, short *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(unsigned short *,
 unsigned short *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const unsigned short *,
 unsigned short *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(int *, int *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const int *, int *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(unsigned int *, unsigned int *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const unsigned int *, unsigned int *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(long *, long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const long *, long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(unsigned long *,
 unsigned long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const unsigned long *,
 unsigned long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(float *, float *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const float *, float *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(double *, double *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const double *, double *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(long double *, long double *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const long double *, long double *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }


inline _Scalar_ptr_iterator_tag _Ptr_cat(long long *, long long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const long long *, long long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(unsigned long long *, unsigned long long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }

inline _Scalar_ptr_iterator_tag _Ptr_cat(const unsigned long long *, unsigned long long *)
 {
 _Scalar_ptr_iterator_tag _Cat;
 return (_Cat);
 }
#line 900 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _Iter> inline
 typename iterator_traits<_Iter>::value_type *_Val_type(_Iter)
 {
 return (0);
 }


template<class _InIt,
 class _Diff> inline
 void _Advance(_InIt& _Where, _Diff _Off, input_iterator_tag)
 {





 for (; 0 < _Off; --_Off)
  ++_Where;
 }

template<class _FwdIt,
 class _Diff> inline
 void _Advance(_FwdIt& _Where, _Diff _Off, forward_iterator_tag)
 {





 for (; 0 < _Off; --_Off)
  ++_Where;
 }

template<class _BidIt,
 class _Diff> inline
 void _Advance(_BidIt& _Where, _Diff _Off, bidirectional_iterator_tag)
 {
 for (; 0 < _Off; --_Off)
  ++_Where;
 for (; _Off < 0; ++_Off)
  --_Where;
 }

template<class _RanIt,
 class _Diff> inline
 void _Advance(_RanIt& _Where, _Diff _Off, random_access_iterator_tag)
 {
 _Where += _Off;
 }

template<class _InIt,
 class _Diff> inline
 void advance(_InIt& _Where, _Diff _Off)
 {
 _Advance(_Where, _Off, _Iter_cat(_Where));
 }


template<class _Iter> inline
 typename iterator_traits<_Iter>::difference_type
  *_Dist_type(_Iter)
 {
 return (0);
 }


template<class _InIt,
 class _Diff> inline
  void _Distance2(_InIt _First, _InIt _Last, _Diff& _Off,
   input_iterator_tag)
 {
 for (; _First != _Last; ++_First)
  ++_Off;
 }

template<class _FwdIt,
 class _Diff> inline
  void _Distance2(_FwdIt _First, _FwdIt _Last, _Diff& _Off,
   forward_iterator_tag)
 {
 for (; _First != _Last; ++_First)
  ++_Off;
 }

template<class _BidIt,
 class _Diff> inline
  void _Distance2(_BidIt _First, _BidIt _Last, _Diff& _Off,
   bidirectional_iterator_tag)
 {
 for (; _First != _Last; ++_First)
  ++_Off;
 }

template<class _RanIt,
 class _Diff> inline
  void _Distance2(_RanIt _First, _RanIt _Last, _Diff& _Off,
   random_access_iterator_tag)
 {
#line 1006 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
 _Off += _Last - _First;
 }

template<class _InIt> inline
 typename iterator_traits<_InIt>::difference_type
  distance(_InIt _First, _InIt _Last)
 {
 typename iterator_traits<_InIt>::difference_type _Off = 0;
 _Distance2(_First, _Last, _Off, _Iter_cat(_First));
 return (_Off);
 }

template<class _InIt,
 class _Diff> inline
  void _Distance(_InIt _First, _InIt _Last, _Diff& _Off)
 {
 _Distance2(_First, _Last, _Off, _Iter_cat(_First));
 }


template<class _FwdIt> inline
 _FwdIt next(_FwdIt _First,
  typename iterator_traits<_FwdIt>::difference_type _Off = 1)
 {
 static_assert((is_base_of<forward_iterator_tag, typename iterator_traits<_FwdIt>::iterator_category>::value), "next requires forward iterator");



 ::std:: advance(_First, _Off);
 return (_First);
 }


template<class _BidIt> inline
 _BidIt prev(_BidIt _First,
  typename iterator_traits<_BidIt>::difference_type _Off = 1)
 {
 static_assert((is_base_of<bidirectional_iterator_tag, typename iterator_traits<_BidIt>::iterator_category>::value), "prev requires bidirectional iterator");



 ::std:: advance(_First, -_Off);
 return (_First);
 }


template<class _Ty>
 struct pointer_traits;

template<class _RanIt,
 class _Base>
 class _Revranit
  : public _Base
 {
public:
 typedef _Revranit<_RanIt, _Base> _Myt;
 typedef typename _Base::difference_type difference_type;
 typedef typename _Base::pointer pointer;
 typedef typename _Base::reference reference;
 typedef _RanIt iterator_type;

 _Revranit()
  {
  }

 explicit _Revranit(_RanIt _Right)
  : current(_Right)
  {
  }

 template<class _RanIt2,
  class _Base2>
  _Revranit(const _Revranit<_RanIt2, _Base2>& _Right)
  : current(_Right.base())
  {
  }

 _RanIt base() const
  {
  return (current);
  }

 reference operator*() const
  {
  _RanIt _Tmp = current;
  return (*--_Tmp);
  }

 pointer operator->() const
  {
  return (::std:: pointer_traits<pointer>::pointer_to(**this));
  }

 _Myt& operator++()
  {
  --current;
  return (*this);
  }

 _Myt operator++(int)
  {
  _Myt _Tmp = *this;
  --current;
  return (_Tmp);
  }

 _Myt& operator--()
  {
  ++current;
  return (*this);
  }

 _Myt operator--(int)
  {
  _Myt _Tmp = *this;
  ++current;
  return (_Tmp);
  }

 template<class _RanIt2,
  class _Base2>
  bool _Equal(const _Revranit<_RanIt2, _Base2>& _Right) const
  {
  return (current == _Right.base());
  }



 _Myt& operator+=(difference_type _Off)
  {
  current -= _Off;
  return (*this);
  }

 _Myt operator+(difference_type _Off) const
  {
  return (_Myt(current - _Off));
  }

 _Myt& operator-=(difference_type _Off)
  {
  current += _Off;
  return (*this);
  }

 _Myt operator-(difference_type _Off) const
  {
  return (_Myt(current + _Off));
  }

 reference operator[](difference_type _Off) const
  {
  return (*(*this + _Off));
  }

 template<class _RanIt2,
  class _Base2>
  bool _Less(const _Revranit<_RanIt2, _Base2>& _Right) const
  {
  return (_Right.base() < current);
  }

 difference_type operator-(const _Myt& _Right) const
  {
  return (_Right.base() - current);
  }

protected:
 _RanIt current;
 };


template<class _RanIt,
 class _Base,
 class _Diff> inline
 _Revranit<_RanIt, _Base>
  operator+(_Diff _Off,
  const _Revranit<_RanIt, _Base>& _Right)
 {
 return (_Right + _Off);
 }


template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2>
 auto inline operator-(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
   -> decltype(_Right.base() - _Left.base())
 {
 return (_Right.base() - _Left.base());
 }
#line 1214 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2> inline
 bool operator==(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
 {
 return (_Left._Equal(_Right));
 }

template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2> inline
 bool operator!=(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2> inline
 bool operator<(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
 {
 return (_Left._Less(_Right));
 }

template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2> inline
 bool operator>(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
 {
 return (_Right < _Left);
 }

template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2> inline
 bool operator<=(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _RanIt1,
 class _Base1,
 class _RanIt2,
 class _Base2> inline
 bool operator>=(
  const _Revranit<_RanIt1, _Base1>& _Left,
  const _Revranit<_RanIt2, _Base2>& _Right)
 {
 return (!(_Left < _Right));
 }


template<class _RanIt>
 class reverse_iterator
  : public _Revranit<_RanIt, iterator<
   typename iterator_traits<_RanIt>::iterator_category,
   typename iterator_traits<_RanIt>::value_type,
   typename iterator_traits<_RanIt>::difference_type,
   typename iterator_traits<_RanIt>::pointer,
   typename iterator_traits<_RanIt>::reference> >
 {
 typedef reverse_iterator<_RanIt> _Myt;
 typedef _Revranit<_RanIt, iterator<
  typename iterator_traits<_RanIt>::iterator_category,
  typename iterator_traits<_RanIt>::value_type,
  typename iterator_traits<_RanIt>::difference_type,
  typename iterator_traits<_RanIt>::pointer,
  typename iterator_traits<_RanIt>::reference> > _Mybase;

public:
 typedef typename iterator_traits<_RanIt>::difference_type difference_type;
 typedef typename iterator_traits<_RanIt>::pointer pointer;
 typedef typename iterator_traits<_RanIt>::reference reference;
 typedef _RanIt iterator_type;

 reverse_iterator()
  {
  }

 explicit reverse_iterator(_RanIt _Right)
  : _Mybase(_Right)
  {
  }

 template<class _Other>
  reverse_iterator(const reverse_iterator<_Other>& _Right)
  : _Mybase(_Right.base())
  {
  }

 reverse_iterator(_Mybase _Right)
  : _Mybase(_Right)
  {
  }

 template<class _Other>
  _Myt& operator=(const reverse_iterator<_Other>& _Right)
  {
  this->current = _Right.base();
  return (*this);
  }

 _Myt& operator++()
  {
  ++*((_Mybase *)this);
  return (*this);
  }

 _Myt operator++(int)
  {
  _Myt _Tmp = *this;
  ++*this;
  return (_Tmp);
  }

 _Myt& operator--()
  {
  --*((_Mybase *)this);
  return (*this);
  }

 _Myt operator--(int)
  {
  _Myt _Tmp = *this;
  --*this;
  return (_Tmp);
  }

 _Myt& operator+=(difference_type _Off)
  {
  *((_Mybase *)this) += _Off;
  return (*this);
  }

 _Myt operator+(difference_type _Off) const
  {
  _Myt _Tmp = *this;
  return (_Tmp += _Off);
  }

 _Myt& operator-=(difference_type _Off)
  {
  *((_Mybase *)this) -= _Off;
  return (*this);
  }

 _Myt operator-(difference_type _Off) const
  {
  _Myt _Tmp = *this;
  return (_Tmp -= _Off);
  }
 };

template<class _RanIt>
 struct _Is_checked_helper<reverse_iterator<_RanIt> >
  : public _Is_checked_helper<_RanIt>
 {
 };


template<class _RanIt,
 class _Diff> inline
 reverse_iterator<_RanIt> operator+(_Diff _Off,
  const reverse_iterator<_RanIt>& _Right)
 {
 return (_Right + _Off);
 }


template<class _RanIt1,
 class _RanIt2>
 auto inline operator-(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
   -> decltype(_Right.base() - _Left.base())
 {
 return (_Right.base() - _Left.base());
 }
#line 1418 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _RanIt1,
 class _RanIt2> inline
 bool operator==(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
 {
 return (_Left._Equal(_Right));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator!=(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator<(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
 {
 return (_Left._Less(_Right));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator>(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
 {
 return (_Right < _Left);
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator<=(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator>=(const reverse_iterator<_RanIt1>& _Left,
  const reverse_iterator<_RanIt2>& _Right)
 {
 return (!(_Left < _Right));
 }





template<class _Container>
 auto inline begin(_Container& _Cont) -> decltype(_Cont.begin())
 {
 return (_Cont.begin());
 }

template<class _Container>
 auto inline begin(const _Container& _Cont) -> decltype(_Cont.begin())
 {
 return (_Cont.begin());
 }

template<class _Container>
 auto inline end(_Container& _Cont) -> decltype(_Cont.end())
 {
 return (_Cont.end());
 }

template<class _Container>
 auto inline end(const _Container& _Cont) -> decltype(_Cont.end())
 {
 return (_Cont.end());
 }
#line 1520 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _Ty,
 size_t _Size> inline
 _Ty *begin(_Ty (&_Array)[_Size])
 {
 return (_Array);
 }

template<class _Ty,
 size_t _Size> inline
 _Ty *end(_Ty (&_Array)[_Size])
 {
 return (_Array + _Size);
 }


template<class _Container>
 auto inline cbegin(const _Container& _Cont) -> decltype(::std:: begin(_Cont))
 {
 return (::std:: begin(_Cont));
 }

template<class _Container>
 auto inline cend(const _Container& _Cont) -> decltype(::std:: end(_Cont))
 {
 return (::std:: end(_Cont));
 }


template<class _Container>
 auto inline rbegin(_Container& _Cont) -> decltype(_Cont.rbegin())
 {
 return (_Cont.rbegin());
 }

template<class _Container>
 auto inline rbegin(const _Container& _Cont) -> decltype(_Cont.rbegin())
 {
 return (_Cont.rbegin());
 }

template<class _Container>
 auto inline rend(_Container& _Cont) -> decltype(_Cont.rend())
 {
 return (_Cont.rend());
 }

template<class _Container>
 auto inline rend(const _Container& _Cont) -> decltype(_Cont.rend())
 {
 return (_Cont.rend());
 }

template<class _Ty,
 size_t _Size> inline
 reverse_iterator<_Ty *> rbegin(_Ty (&_Array)[_Size])
 {
 return (reverse_iterator<_Ty *>(_Array + _Size));
 }

template<class _Ty,
 size_t _Size> inline
 reverse_iterator<_Ty *> rend(_Ty (&_Array)[_Size])
 {
 return (reverse_iterator<_Ty *>(_Array));
 }

template<class _Elem> inline
 reverse_iterator<const _Elem *>
  rbegin(::std:: initializer_list<_Elem> _Ilist)
 {
 return (reverse_iterator<const _Elem *>(_Ilist.end()));
 }

template<class _Elem> inline
 reverse_iterator<const _Elem *>
  rend(::std:: initializer_list<_Elem> _Ilist)
 {
 return (reverse_iterator<const _Elem *>(_Ilist.begin()));
 }


template<class _Container>
 auto inline crbegin(const _Container& _Cont)
  -> decltype(::std:: rbegin(_Cont))
 {
 return (::std:: rbegin(_Cont));
 }

template<class _Container>
 auto inline crend(const _Container& _Cont)
  -> decltype(::std:: rend(_Cont))
 {
 return (::std:: rend(_Cont));
 }



template<class _Ty,
 size_t _Size>
 class _Array_const_iterator
  : public _Iterator012<random_access_iterator_tag,
   _Ty,
   ptrdiff_t,
   const _Ty *,
   const _Ty&,
   _Iterator_base>
 {
public:
 typedef _Array_const_iterator<_Ty, _Size> _Myiter;
 typedef random_access_iterator_tag iterator_category;

 typedef _Ty value_type;
 typedef size_t size_type;
 typedef ptrdiff_t difference_type;
 typedef const _Ty *pointer;
 typedef const _Ty& reference;


 _Array_const_iterator()
  {
  _Ptr = 0;
  }

 explicit _Array_const_iterator(pointer _Parg, size_t _Off = 0)
  {
  _Ptr = _Parg + _Off;
  }

 typedef pointer _Unchecked_type;

 _Myiter& _Rechecked(_Unchecked_type _Right)
  {
  _Ptr = _Right;
  return (*this);
  }

 _Unchecked_type _Unchecked() const
  {
  return (_Ptr);
  }

 reference operator*() const
  {
  return (*_Ptr);
  }

 pointer operator->() const
  {
  return (::std:: pointer_traits<pointer>::pointer_to(**this));
  }

 _Myiter& operator++()
  {
  ++_Ptr;
  return (*this);
  }

 _Myiter operator++(int)
  {
  _Myiter _Tmp = *this;
  ++*this;
  return (_Tmp);
  }

 _Myiter& operator--()
  {
  --_Ptr;
  return (*this);
  }

 _Myiter operator--(int)
  {
  _Myiter _Tmp = *this;
  --*this;
  return (_Tmp);
  }

 _Myiter& operator+=(difference_type _Off)
  {
  _Ptr += _Off;
  return (*this);
  }

 _Myiter operator+(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp += _Off);
  }

 _Myiter& operator-=(difference_type _Off)
  {
  return (*this += -_Off);
  }

 _Myiter operator-(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp -= _Off);
  }

 difference_type operator-(const _Myiter& _Right) const
  {
  return (_Ptr - _Right._Ptr);
  }

 reference operator[](difference_type _Off) const
  {
  return (*(*this + _Off));
  }

 bool operator==(const _Myiter& _Right) const
  {
  return (_Ptr == _Right._Ptr);
  }

 bool operator!=(const _Myiter& _Right) const
  {
  return (!(*this == _Right));
  }

 bool operator<(const _Myiter& _Right) const
  {
  return (_Ptr < _Right._Ptr);
  }

 bool operator>(const _Myiter& _Right) const
  {
  return (_Right < *this);
  }

 bool operator<=(const _Myiter& _Right) const
  {
  return (!(_Right < *this));
  }

 bool operator>=(const _Myiter& _Right) const
  {
  return (!(*this < _Right));
  }

 pointer _Ptr;
#line 1962 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
 };

template<class _Ty,
 size_t _Size> inline
 typename _Array_const_iterator<_Ty, _Size>::_Unchecked_type
  _Unchecked(_Array_const_iterator<_Ty, _Size> _Iter)
 {
 return (_Iter._Unchecked());
 }

template<class _Ty,
 size_t _Size> inline
 _Array_const_iterator<_Ty, _Size>&
  _Rechecked(_Array_const_iterator<_Ty, _Size>& _Iter,
   typename _Array_const_iterator<_Ty, _Size>
    ::_Unchecked_type _Right)
 {
 return (_Iter._Rechecked(_Right));
 }

template<class _Ty,
 size_t _Size> inline
 _Array_const_iterator<_Ty, _Size> operator+(
  typename _Array_const_iterator<_Ty, _Size>::difference_type _Off,
  _Array_const_iterator<_Ty, _Size> _Next)
 {
 return (_Next += _Off);
 }


template<class _Ty,
 size_t _Size>
 class _Array_iterator
  : public _Array_const_iterator<_Ty, _Size>
 {
public:
 typedef _Array_iterator<_Ty, _Size> _Myiter;
 typedef _Array_const_iterator<_Ty, _Size> _Mybase;
 typedef random_access_iterator_tag iterator_category;

 typedef _Ty value_type;
 typedef size_t size_type;
 typedef ptrdiff_t difference_type;
 typedef _Ty *pointer;
 typedef _Ty& reference;

 _Array_iterator()
  {
  }

 explicit _Array_iterator(pointer _Parg, size_t _Off = 0)
  : _Mybase(_Parg, _Off)
  {
  }

 typedef pointer _Unchecked_type;

 _Myiter& _Rechecked(_Unchecked_type _Right)
  {
  ((_Mybase *)this)->_Rechecked(_Right);
  return (*this);
  }

 _Unchecked_type _Unchecked() const
  {
  return ((pointer)((_Mybase *)this)->_Unchecked());
  }

 reference operator*() const
  {
  return ((reference)**(_Mybase *)this);
  }

 pointer operator->() const
  {
  return (::std:: pointer_traits<pointer>::pointer_to(**this));
  }

 _Myiter& operator++()
  {
  ++*(_Mybase *)this;
  return (*this);
  }

 _Myiter operator++(int)
  {
  _Myiter _Tmp = *this;
  ++*this;
  return (_Tmp);
  }

 _Myiter& operator--()
  {
  --*(_Mybase *)this;
  return (*this);
  }

 _Myiter operator--(int)
  {
  _Myiter _Tmp = *this;
  --*this;
  return (_Tmp);
  }

 _Myiter& operator+=(difference_type _Off)
  {
  *(_Mybase *)this += _Off;
  return (*this);
  }

 _Myiter operator+(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp += _Off);
  }

 _Myiter& operator-=(difference_type _Off)
  {
  return (*this += -_Off);
  }

 _Myiter operator-(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp -= _Off);
  }

 difference_type operator-(const _Mybase& _Right) const
  {
  return (*(_Mybase *)this - _Right);
  }

 reference operator[](difference_type _Off) const
  {
  return (*(*this + _Off));
  }
 };

template<class _Ty,
 size_t _Size> inline
 typename _Array_iterator<_Ty, _Size>::_Unchecked_type
  _Unchecked(_Array_iterator<_Ty, _Size> _Iter)
 {
 return (_Iter._Unchecked());
 }

template<class _Ty,
 size_t _Size> inline
 _Array_iterator<_Ty, _Size>&
  _Rechecked(_Array_iterator<_Ty, _Size>& _Iter,
   typename _Array_iterator<_Ty, _Size>
    ::_Unchecked_type _Right)
 {
 return (_Iter._Rechecked(_Right));
 }

template<class _Ty,
 size_t _Size> inline
 _Array_iterator<_Ty, _Size> operator+(
  typename _Array_iterator<_Ty, _Size>::difference_type _Off,
  _Array_iterator<_Ty, _Size> _Next)
 {
 return (_Next += _Off);
 }



template<class _RanIt>
 class move_iterator
 {
public:
 typedef move_iterator<_RanIt> _Myt;
 typedef typename iterator_traits<_RanIt>::iterator_category
  iterator_category;
 typedef typename iterator_traits<_RanIt>::value_type
  value_type;
 typedef typename iterator_traits<_RanIt>::difference_type
  difference_type;
 typedef _RanIt pointer;
 typedef value_type&& reference;
 typedef _RanIt iterator_type;

 move_iterator()
  {
  }

 explicit move_iterator(iterator_type _Right)
  : current(_Right)
  {
  }

 template<class _RanIt2>
  move_iterator(const move_iterator<_RanIt2>& _Right)
  : current(_Right.base())
  {
  }

 template<class _RanIt2>
  _Myt& operator=(const move_iterator<_RanIt2>& _Right)
  {
  current = _Right.base();
  return (*this);
  }

 _RanIt base() const
  {
  return (current);
  }

 reference operator*() const
  {

  return (::std:: move(*current));




  }

 pointer operator->() const
  {
  return (current);
  }

 _Myt& operator++()
  {
  ++current;
  return (*this);
  }

 _Myt operator++(int)
  {
  _Myt _Tmp = *this;
  ++current;
  return (_Tmp);
  }

 _Myt& operator--()
  {
  --current;
  return (*this);
  }

 _Myt operator--(int)
  {
  _Myt _Tmp = *this;
  --current;
  return (_Tmp);
  }

 template<class _RanIt2>
  bool _Equal(const move_iterator<_RanIt2>& _Right) const
  {
  return (current == _Right.base());
  }



 _Myt& operator+=(difference_type _Off)
  {
  current += _Off;
  return (*this);
  }

 _Myt operator+(difference_type _Off) const
  {
  return (_Myt(current + _Off));
  }

 _Myt& operator-=(difference_type _Off)
  {
  current -= _Off;
  return (*this);
  }

 _Myt operator-(difference_type _Off) const
  {
  return (_Myt(current - _Off));
  }

 reference operator[](difference_type _Off) const
  {

  return (::std:: move(current[_Off]));




  }

 template<class _RanIt2>
  bool _Less(const move_iterator<_RanIt2>& _Right) const
  {
  return (current < _Right.base());
  }

 difference_type operator-(const _Myt& _Right) const
  {
  return (current - _Right.base());
  }

protected:
 iterator_type current;
 };

template<class _RanIt>
 struct _Is_checked_helper<move_iterator<_RanIt> >
  : public _Is_checked_helper<_RanIt>
 {
 };


template<class _RanIt,
 class _Diff> inline
 move_iterator<_RanIt>
  operator+(_Diff _Off,
  const move_iterator<_RanIt>& _Right)
 {
 return (_Right + _Off);
 }


template<class _RanIt1,
 class _RanIt2>
 auto inline operator-(
  move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
   -> decltype(_Left.base() - _Right.base())
 {
 return (_Left.base() - _Right.base());
 }
#line 2305 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _RanIt1,
 class _RanIt2> inline
 bool operator==(
  const move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
 {
 return (_Left._Equal(_Right));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator!=(
  const move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator<(
  const move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
 {
 return (_Left._Less(_Right));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator>(
  const move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
 {
 return (_Right < _Left);
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator<=(
  const move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _RanIt1,
 class _RanIt2> inline
 bool operator>=(
  const move_iterator<_RanIt1>& _Left,
  const move_iterator<_RanIt2>& _Right)
 {
 return (!(_Left < _Right));
 }


template<class _RanIt> inline
 move_iterator<_RanIt> make_move_iterator(_RanIt _Iter)
 {
 return (move_iterator<_RanIt>(_Iter));
 }



template<class _InIt,
 class _OutIt> inline
 _OutIt _Copy_impl(_InIt _First, _InIt _Last,
  _OutIt _Dest, _Nonscalar_ptr_iterator_tag)
 {
 for (; _First != _Last; ++_Dest, ++_First)
  *_Dest = *_First;
 return (_Dest);
 }

template<class _InIt,
 class _OutIt> inline
 _OutIt _Copy_impl(_InIt _First, _InIt _Last,
  _OutIt _Dest, _Scalar_ptr_iterator_tag)
 {
 ptrdiff_t _Count = _Last - _First;
 ::std:: memmove(&*_Dest, &*_First,
  _Count * sizeof (*_First));
 return (_Dest + _Count);
 }

template<class _InIt,
 class _OutIt> inline
 _OutIt _Copy_impl(_InIt _First, _InIt _Last,
  _OutIt _Dest)
 {
 return (_Copy_impl(_First, _Last,
  _Dest, _Ptr_cat(_First, _Dest)));
 }


template<class _InIt,
 class _OutIt> inline
 _OutIt copy(_InIt _First, _InIt _Last,
  _OutIt _Dest)
 {
 return (_Rechecked(_Dest,
  _Copy_impl(_Unchecked(_First), _Unchecked(_Last),
   _Unchecked(_Dest))));
 }
#line 2481 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _InIt,
 class _Diff,
 class _OutIt> inline
 _OutIt _Copy_n(_InIt _First, _Diff _Count,
  _OutIt _Dest, input_iterator_tag)
 {
 *_Dest = *_First;
 while (0 < --_Count)
  *++_Dest = *++_First;
 return (++_Dest);
 }

template<class _InIt,
 class _Diff,
 class _OutIt> inline
 _OutIt _Copy_n(_InIt _First, _Diff _Count,
  _OutIt _Dest, forward_iterator_tag)
 {
 for (; 0 < _Count; --_Count, ++_Dest, ++_First)
  *_Dest = *_First;
 return (_Dest);
 }

template<class _InIt,
 class _Diff,
 class _OutIt> inline
 _OutIt _Copy_n(_InIt _First, _Diff _Count,
  _OutIt _Dest, _Nonscalar_ptr_iterator_tag)
 {
 return (_Copy_n(_First, _Count,
  _Dest, _Iter_cat(_First)));
 }
template<class _InIt,
 class _Diff,
 class _OutIt> inline
 _OutIt _Copy_n(_InIt _First, _Diff _Count,
  _OutIt _Dest, _Scalar_ptr_iterator_tag)
 {
 ::std:: memmove(&*_Dest, &*_First,
  _Count * sizeof (*_First));
 return (_Dest + _Count);
 }

template<class _InIt,
 class _Diff,
 class _OutIt> inline
 _OutIt _Copy_n(_InIt _First, _Diff _Count,
  _OutIt _Dest)
 {
 return (_Copy_n(_First, _Count,
  _Dest, _Ptr_cat(_First, _Dest)));
 }


template<class _InIt,
 class _Diff,
 class _OutIt> inline
 _OutIt copy_n(_InIt _First, _Diff _Count,
  _OutIt _Dest)
 {
 if (_Count <= 0)
  return (_Dest);
 else
  return (_Rechecked(_Dest,
   _Copy_n(_Unchecked(_First), _Count,
    _Unchecked(_Dest))));
 }
#line 2671 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _BidIt1,
 class _BidIt2> inline
 _BidIt2 _Copy_backward(_BidIt1 _First, _BidIt1 _Last,
  _BidIt2 _Dest, _Nonscalar_ptr_iterator_tag)
 {
 while (_First != _Last)
  *--_Dest = *--_Last;
 return (_Dest);
 }

template<class _InIt,
 class _OutIt> inline
 _OutIt _Copy_backward(_InIt _First, _InIt _Last,
  _OutIt _Dest, _Scalar_ptr_iterator_tag)
 {
 ptrdiff_t _Count = _Last - _First;
 ::std:: memmove(&*_Dest - _Count, &*_First,
  _Count * sizeof (*_First));
 return (_Dest - _Count);
 }

template<class _BidIt1,
 class _BidIt2> inline
 _BidIt2 _Copy_backward(_BidIt1 _First, _BidIt1 _Last,
  _BidIt2 _Dest)
 {
 return (_Copy_backward(_First, _Last,
  _Dest, _Ptr_cat(_First, _Dest)));
 }


template<class _BidIt1,
 class _BidIt2> inline
 _BidIt2 copy_backward(_BidIt1 _First, _BidIt1 _Last,
  _BidIt2 _Dest)
 {
 return (_Rechecked(_Dest,
  _Copy_backward(_Unchecked(_First), _Unchecked(_Last),
   _Unchecked(_Dest))));
 }
#line 2744 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _InIt,
 class _OutIt> inline
 _OutIt _Move(_InIt _First, _InIt _Last,
  _OutIt _Dest, _Nonscalar_ptr_iterator_tag)
 {
 for (; _First != _Last; ++_Dest, ++_First)
  *_Dest = ::std:: move(*_First);
 return (_Dest);
 }

template<class _InIt,
 class _OutIt> inline
 _OutIt _Move(_InIt _First, _InIt _Last,
  _OutIt _Dest, _Scalar_ptr_iterator_tag)
 {
 ptrdiff_t _Count = _Last - _First;
 ::std:: memmove(&*_Dest, &*_First,
  _Count * sizeof (*_First));
 return (_Dest + _Count);
 }

template<class _InIt,
 class _OutIt> inline
 _OutIt _Move(_InIt _First, _InIt _Last,
  _OutIt _Dest)
 {
 return (_Move(_First, _Last,
  _Dest, _Ptr_cat(_First, _Dest)));
 }


template<class _InIt,
 class _OutIt> inline
 _OutIt move(_InIt _First, _InIt _Last,
  _OutIt _Dest)
 {
 return (_Rechecked(_Dest,
  _Move(_Unchecked(_First), _Unchecked(_Last),
   _Unchecked(_Dest))));
 }
#line 2851 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _BidIt1,
 class _BidIt2> inline
 _BidIt2 _Move_backward(_BidIt1 _First, _BidIt1 _Last,
  _BidIt2 _Dest, _Nonscalar_ptr_iterator_tag)
 {
 while (_First != _Last)
  *--_Dest = ::std:: move(*--_Last);
 return (_Dest);
 }

template<class _InIt,
 class _OutIt> inline
 _OutIt _Move_backward(_InIt _First, _InIt _Last,
  _OutIt _Dest, _Scalar_ptr_iterator_tag)
 {
 ptrdiff_t _Count = _Last - _First;
 ::std:: memmove(&*_Dest - _Count, &*_First,
  _Count * sizeof (*_First));
 return (_Dest - _Count);
 }

template<class _BidIt1,
 class _BidIt2> inline
 _BidIt2 _Move_backward(_BidIt1 _First, _BidIt1 _Last,
  _BidIt2 _Dest)
 {
 return (_Move_backward(_First, _Last,
  _Dest, _Ptr_cat(_First, _Dest)));
 }


template<class _BidIt1,
 class _BidIt2> inline
 _BidIt2 move_backward(_BidIt1 _First, _BidIt1 _Last,
  _BidIt2 _Dest)
 {
 return (_Rechecked(_Dest,
  _Move_backward(_Unchecked(_First), _Unchecked(_Last),
   _Unchecked(_Dest))));
 }
#line 2924 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _FwdIt,
 class _Ty> inline
 void _Fill(_FwdIt _First, _FwdIt _Last, const _Ty& _Val)
 {
 for (; _First != _Last; ++_First)
  *_First = _Val;
 }

inline void _Fill(char *_First, char *_Last, char _Val)
 {
 ::std:: memset(_First, _Val, _Last - _First);
 }

inline void _Fill(signed char *_First, signed char *_Last, signed char _Val)
 {
 ::std:: memset(_First, _Val, _Last - _First);
 }

inline void _Fill(unsigned char *_First, unsigned char *_Last, unsigned char _Val)
 {
 ::std:: memset(_First, _Val, _Last - _First);
 }

template<class _FwdIt,
 class _Ty> inline
 void fill(_FwdIt _First, _FwdIt _Last, const _Ty& _Val)
 {
                            ;
 _Fill(_Unchecked(_First), _Unchecked(_Last), _Val);
 }


template<class _OutIt,
 class _Diff,
 class _Ty> inline
 _OutIt _Fill_n(_OutIt _Dest, _Diff _Count, const _Ty& _Val)
 {
 for (; 0 < _Count; --_Count, ++_Dest)
  *_Dest = _Val;
 return (_Dest);
 }

inline char *_Fill_n(char *_Dest, size_t _Count, char _Val)
 {
 ::std:: memset(_Dest, _Val, _Count);
 return (_Dest + _Count);
 }

inline signed char *_Fill_n(signed char *_Dest, size_t _Count,
 signed char _Val)
 {
 ::std:: memset(_Dest, _Val, _Count);
 return (_Dest + _Count);
 }

inline unsigned char *_Fill_n(unsigned char *_Dest, size_t _Count,
 unsigned char _Val)
 {
 ::std:: memset(_Dest, _Val, _Count);
 return (_Dest + _Count);
 }


template<class _OutIt,
 class _Diff,
 class _Ty> inline
 _OutIt fill_n(_OutIt _Dest, _Diff _Count, const _Ty& _Val)
 {
 return (_Rechecked(_Dest, _Fill_n(_Unchecked(_Dest), _Count, _Val)));
 }
#line 3061 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _InIt1,
 class _InIt2> inline
 bool _Equal(_InIt1 _First1, _InIt1 _Last1, _InIt2 _First2)
 {
 for (; _First1 != _Last1; ++_First1, ++_First2)
  if (!(*_First1 == *_First2))
   return (false);
 return (true);
 }

inline bool _Equal(const char *_First1, const char *_Last1,
 const char *_First2)
 {
 return (::std:: memcmp(_First1, _First2, _Last1 - _First1) == 0);
 }

inline bool _Equal(const signed char *_First1, const signed char *_Last1,
 const signed char *_First2)
 {
 return (::std:: memcmp(_First1, _First2, _Last1 - _First1) == 0);
 }

inline bool _Equal(const unsigned char *_First1, const unsigned char *_Last1,
 const unsigned char *_First2)
 {
 return (::std:: memcmp(_First1, _First2, _Last1 - _First1) == 0);
 }


template<class _InIt1,
 class _InIt2> inline
 bool equal(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2)
 {
 return (_Equal(_Unchecked(_First1), _Unchecked(_Last1),
  _Unchecked(_First2)));
 }
#line 3144 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _InIt1,
 class _InIt2,
 class _Pr> inline
 bool _Equal(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2, _Pr _Pred)
 {
 for (; _First1 != _Last1; ++_First1, ++_First2)
  if (!_Pred(*_First1, *_First2))
   return (false);
 return (true);
 }


template<class _InIt1,
 class _InIt2,
 class _Pr> inline
 bool equal(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2, _Pr _Pred)
 {
 return (_Equal(_Unchecked(_First1), _Unchecked(_Last1),
  _Unchecked(_First2), _Pred));
 }
#line 3216 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _InIt1,
 class _InIt2> inline
 bool _Lexicographical_compare(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2, _InIt2 _Last2)
 {
 for (; _First1 != _Last1 && _First2 != _Last2; ++_First1, ++_First2)
  if (((*_First1) < (*_First2)))
   return (true);
  else if (*_First2 < *_First1)
   return (false);
 return (_First1 == _Last1 && _First2 != _Last2);
 }

inline bool _Lexicographical_compare(
 const unsigned char *_First1, const unsigned char *_Last1,
 const unsigned char *_First2, const unsigned char *_Last2)
 {
 ptrdiff_t _Num1 = _Last1 - _First1;
 ptrdiff_t _Num2 = _Last2 - _First2;
 int _Ans = ::std:: memcmp(_First1, _First2, _Num1 < _Num2 ? _Num1 : _Num2);
 return (_Ans < 0 || (_Ans == 0 && _Num1 < _Num2));
 }
#line 3251 "C:\\src\\winrtl\\include\\dinkumware64\\xutility"
template<class _InIt1,
 class _InIt2> inline
 bool lexicographical_compare(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2, _InIt2 _Last2)
 {
                              ;
                              ;
 return (_Lexicographical_compare(_Unchecked(_First1), _Unchecked(_Last1),
  _Unchecked(_First2), _Unchecked(_Last2)));
 }


template<class _InIt1,
 class _InIt2,
 class _Pr> inline
 bool _Lexicographical_compare(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2, _InIt2 _Last2, _Pr _Pred)
 {
 for (; _First1 != _Last1 && _First2 != _Last2; ++_First1, ++_First2)
  if (_Pred(*_First1, *_First2))
   return (true);
  else if (_Pred(*_First2, *_First1))
   return (false);
 return (_First1 == _Last1 && _First2 != _Last2);
 }

template<class _InIt1,
 class _InIt2,
 class _Pr> inline
 bool lexicographical_compare(_InIt1 _First1, _InIt1 _Last1,
  _InIt2 _First2, _InIt2 _Last2, _Pr _Pred)
 {
                              ;
                              ;
                      ;
 return (_Lexicographical_compare(_Unchecked(_First1), _Unchecked(_Last1),
  _Unchecked(_First2), _Unchecked(_Last2), _Pred));
 }


template<class _Ty,
 class _Ignored> inline
 bool _Within_limits(const _Ty& _Val, true_type, true_type, _Ignored)
 {
 return ((-128) <= _Val && _Val <= 127);
 }

template<class _Ty> inline
 bool _Within_limits(const _Ty& _Val, true_type, false_type, true_type)
 {
 return (_Val <= 127 || static_cast<_Ty>((-128)) <= _Val);
 }

template<class _Ty> inline
 bool _Within_limits(const _Ty& _Val, true_type, false_type, false_type)
 {
 return (_Val <= 127);
 }

template<class _Ty,
 class _Ignored> inline
 bool _Within_limits(const _Ty& _Val, false_type, true_type, _Ignored)
 {
 return (0 <= _Val && _Val <= 255);
 }

template<class _Ty,
 class _Ignored> inline
 bool _Within_limits(const _Ty& _Val, false_type, false_type, _Ignored)
 {
 return (_Val <= 255);
 }

template<class _InIt,
 class _Ty> inline
 bool _Within_limits(_InIt, const _Ty& _Val)
 {
 typedef typename remove_pointer<_InIt>::type _Elem;
 return (_Within_limits(_Val, is_signed<_Elem>(), is_signed<_Ty>(),
  integral_constant<bool, -1 == static_cast<_Ty>(-1)>()));
 }

template<class _InIt> inline
 bool _Within_limits(_InIt, const bool&)
 {
 return (true);
 }

template<class _InIt,
 class _Ty> inline
 _InIt _Find(_InIt _First, _InIt _Last, const _Ty& _Val, true_type)
 {
 if (!_Within_limits(_First, _Val))
  return (_Last);
 _First = static_cast<_InIt>(::std:: memchr(
  _First, static_cast<unsigned char>(_Val), _Last - _First));
 return (_First ? _First : _Last);
 }

template<class _InIt,
 class _Ty> inline
 _InIt _Find(_InIt _First, _InIt _Last, const _Ty& _Val, false_type)
 {
 for (; _First != _Last; ++_First)
  if (*_First == _Val)
   break;
 return (_First);
 }

template<class _InIt,
 class _Ty> inline
 _InIt _Find(_InIt _First, _InIt _Last, const _Ty& _Val)
 {

 typedef integral_constant<bool,
  ( is_same<_InIt, char *>::value
  || is_same<_InIt, signed char *>::value
  || is_same<_InIt, unsigned char *>::value
  || is_same<_InIt, const char *>::value
  || is_same<_InIt, const signed char *>::value
  || is_same<_InIt, const unsigned char *>::value)
  && is_integral<_Ty>::value
 > _Memchr_opt;
 return (_Find(_First, _Last, _Val, _Memchr_opt()));
 }

template<class _InIt,
 class _Ty> inline
 _InIt find(_InIt _First, _InIt _Last, const _Ty& _Val)
 {
                            ;
 return (_Rechecked(_First,
  _Find(_Unchecked(_First), _Unchecked(_Last), _Val)));
 }


template<class _InIt,
 class _Ty,
 class _Pr> inline
 _InIt _Find_pr(_InIt _First, _InIt _Last, const _Ty& _Val, _Pr _Pred)
 {
 for (; _First != _Last; ++_First)
  if (_Pred(*_First, _Val))
   break;
 return (_First);
 }


template<class _InIt,
 class _Ty> inline
 typename iterator_traits<_InIt>::difference_type
  _Count_np(_InIt _First, _InIt _Last, const _Ty& _Val)
 {
 typename iterator_traits<_InIt>::difference_type _Count = 0;

 for (; _First != _Last; ++_First)
  if (*_First == _Val)
   ++_Count;
 return (_Count);
 }

template<class _InIt,
 class _Ty> inline
 typename iterator_traits<_InIt>::difference_type
  count(_InIt _First, _InIt _Last, const _Ty& _Val)
 {
                            ;
 return (_Count_np(_Unchecked(_First), _Unchecked(_Last), _Val));
 }


template<class _InIt,
 class _Ty,
 class _Pr> inline
 typename iterator_traits<_InIt>::difference_type
  _Count_pr(_InIt _First, _InIt _Last, const _Ty& _Val, _Pr _Pred)
 {
 typename iterator_traits<_InIt>::difference_type _Count = 0;

 for (; _First != _Last; ++_First)
  if (_Pred(*_First, _Val))
   ++_Count;
 return (_Count);
 }


template<class _FwdIt1,
 class _FwdIt2,
 class _Pr> inline
 bool _Is_permutation(_FwdIt1 _First1, _FwdIt1 _Last1,
  _FwdIt2 _First2, _Pr _Pred)
 {
 for (; _First1 != _Last1; ++_First1, ++_First2)
  if (!_Pred(*_First1, *_First2))
   break;
 if (_First1 != _Last1)
  {
  _FwdIt2 _Last2 = _First2;
  advance(_Last2, distance(_First1, _Last1));
  for (_FwdIt1 _Next1 = _First1; _Next1 != _Last1; ++_Next1)
   if (_Next1 == _Find_pr(_First1, _Next1, *_Next1, _Pred))
    {
    typename iterator_traits<_FwdIt2>::difference_type _Count =
     _Count_pr(_First2, _Last2, *_Next1, _Pred);
    if (_Count == 0
     || _Count != _Count_pr(_Next1, _Last1, *_Next1, _Pred))
     return (false);
    }
  }
 return (true);
 }

template<class _FwdIt1,
 class _FwdIt2,
 class _Pr> inline
 bool is_permutation(_FwdIt1 _First1, _FwdIt1 _Last1,
  _FwdIt2 _First2, _Pr _Pred)
 {
                              ;
                      ;
 return _Is_permutation(_Unchecked(_First1), _Unchecked(_Last1),
  _Unchecked(_First2), _Pred);
 }


template<class _FwdIt1,
 class _FwdIt2> inline
 bool is_permutation(_FwdIt1 _First1, _FwdIt1 _Last1,
  _FwdIt2 _First2)
 {
 return (::std:: is_permutation(_First1, _Last1,
  _First2, equal_to<>()));
 }


template<class _BidIt> inline
 void _Reverse(_BidIt _First, _BidIt _Last, bidirectional_iterator_tag)
 {
 for (; _First != _Last && _First != --_Last; ++_First)
  ::std:: iter_swap(_First, _Last);
 }

template<class _BidIt> inline
 void reverse(_BidIt _First, _BidIt _Last)
 {
                            ;
 _Reverse(_Unchecked(_First), _Unchecked(_Last), _Iter_cat(_First));
 }


template<class _FwdIt> inline
 void _Rotate(_FwdIt _First, _FwdIt _Mid, _FwdIt _Last,
  forward_iterator_tag)
 {
 for (_FwdIt _Next = _Mid; ; )
  {
  ::std:: iter_swap(_First, _Next);
  if (++_First == _Mid)
   if (++_Next == _Last)
    break;
   else
    _Mid = _Next;
  else if (++_Next == _Last)
   _Next = _Mid;
  }
 }

template<class _BidIt> inline
 void _Rotate(_BidIt _First, _BidIt _Mid, _BidIt _Last,
  bidirectional_iterator_tag)
 {
 ::std:: reverse(_First, _Mid);
 ::std:: reverse(_Mid, _Last);
 ::std:: reverse(_First, _Last);
 }

template<class _RanIt,
 class _Diff,
 class _Ty> inline
 void _Rotate(_RanIt _First, _RanIt _Mid, _RanIt _Last, _Diff *, _Ty *)
 {
 _Diff _Shift = _Mid - _First;
 _Diff _Count = _Last - _First;

 for (_Diff _Factor = _Shift; _Factor != 0; )
  {
  _Diff _Tmp = _Count % _Factor;
  _Count = _Factor;
  _Factor = _Tmp;
  }

 if (_Count < _Last - _First)
  for (; 0 < _Count; --_Count)
   {
   _RanIt _Hole = _First + _Count;
   _RanIt _Next = _Hole;
   _RanIt _Next1 = _Next + _Shift == _Last ? _First : _Next + _Shift;
   for (; ; )
    {
    iter_swap(_Next, _Next1);
    _Next = _Next1;
    _Next1 = _Shift < _Last - _Next1 ? _Next1 + _Shift
     : _First + (_Shift - (_Last - _Next1));
    if (_Next1 == _Hole)
     break;
    }
   }
 }

template<class _RanIt> inline
 void _Rotate(_RanIt _First, _RanIt _Mid, _RanIt _Last,
  random_access_iterator_tag)
 {
 _Rotate(_First, _Mid, _Last, _Dist_type(_First), _Val_type(_First));
 }

template<class _FwdIt> inline
 _FwdIt rotate(_FwdIt _First, _FwdIt _Mid, _FwdIt _Last)
 {
                           ;
                          ;
 if (_First != _Mid && _Mid != _Last)
  _Rotate(_Unchecked(_First), _Unchecked(_Mid), _Unchecked(_Last),
   _Iter_cat(_First));
 ::std:: advance(_First, ::std:: distance(_Mid, _Last));
 return (_First);
 }


template<class _Diff, class _Urng>
 class _Rng_from_urng
 {
public:

 typedef typename make_unsigned<_Diff>::type _Ty0;
 typedef typename _Urng::result_type _Ty1;

 typedef typename _If<sizeof (_Ty1) < sizeof (_Ty0),
  _Ty0, _Ty1>::type _Udiff;





 explicit _Rng_from_urng(_Urng& _Func)
  : _Ref(_Func), _Bits(8 * sizeof (_Udiff)), _Bmask(_Udiff(-1))
  {
  for (; (_Urng::max)() - (_Urng::min)() < _Bmask; _Bmask >>= 1)
   --_Bits;
  }

 _Diff operator()(_Diff _Index)
  {
  for (; ; )
   {
   _Udiff _Ret = 0;
   _Udiff _Mask = 0;

   while (_Mask < _Udiff(_Index - 1))
    {
    _Ret <<= _Bits - 1;
    _Ret <<= 1;
    _Ret |= _Get_bits();
    _Mask <<= _Bits - 1;
    _Mask <<= 1;
    _Mask |= _Bmask;
    }


   if (_Ret / _Index < _Mask / _Index
    || _Mask % _Index == _Udiff(_Index - 1))
    return (_Ret % _Index);
   }
  }

 _Udiff _Get_all_bits()
  {
  _Udiff _Ret = 0;

  for (size_t _Num = 0; _Num < 8 * sizeof (_Udiff);
   _Num += _Bits)
   {
   _Ret <<= _Bits - 1;
   _Ret <<= 1;
   _Ret |= _Get_bits();
   }

  return (_Ret);
  }

private:
 _Udiff _Get_bits()
  {
  for (; ; )
   {
   _Udiff _Val = _Ref() - (_Urng::min)();

   if (_Val <= _Bmask)
    return (_Val);
   }
  }

 _Urng& _Ref;
 size_t _Bits;
 _Udiff _Bmask;

 _Rng_from_urng(const _Rng_from_urng&);
 _Rng_from_urng& operator=(const _Rng_from_urng&);
 };


template<class _Elem>
 class __declspec(dllexport) _Yarn
 {
public:
 typedef _Yarn<_Elem> _Myt;

        _Yarn()
  : _Myptr(0), _Nul(0)
  {
  }

        _Yarn(const _Myt& _Right)
  : _Myptr(0), _Nul(0)
  {
  *this = _Right;
  }

        _Yarn(const _Elem *_Right)
  : _Myptr(0), _Nul(0)
  {
  *this = _Right;
  }

 _Myt& operator=(const _Myt& _Right)
  {
  return (*this = _Right._Myptr);
  }

 _Myt& operator=(const _Elem *_Right)
  {
  if (_Myptr != _Right)
   {
   _Tidy();

   if (_Right != 0)
    {
    const _Elem *_Ptr = _Right;
    while (*_Ptr != (_Elem)0)
     ++_Ptr;
    size_t _Count = ((const char *)++_Ptr - (const char *)_Right);

    _Myptr = (_Elem *)::std:: malloc(_Count);
    if (_Myptr != 0)
     ::std:: memcpy(_Myptr, _Right, _Count);
    }
   }
  return (*this);
  }

        ~_Yarn()
  {
  _Tidy();
  }

 bool empty() const
  {
  return (_Myptr == 0);
  }

 const _Elem * c_str() const
  {
  return (_Myptr != 0 ? _Myptr : &_Nul);
  }

private:
 void _Tidy()
  {
  if (_Myptr != 0)
   ::std:: free(_Myptr);

  _Myptr = 0;
  }

 _Elem *_Myptr;
 _Elem _Nul;
 };


template<class _Ty,
 class _Alloc>
 struct _Has_allocator_type
 {

 template<class _Uty>
  static auto _Fn(int)
   -> is_convertible<_Alloc,
    typename _Uty::allocator_type>;
 template<class _Uty>
  static auto _Fn(_Wrap_int)
   -> false_type;

 typedef decltype(_Fn<_Ty>(0)) type;




 };


struct allocator_arg_t
 {
 };

const allocator_arg_t allocator_arg = allocator_arg_t();

__declspec(dllexport) void _Xbad_alloc();
__declspec(dllexport) void _Xinvalid_argument(const char *);
__declspec(dllexport) void _Xlength_error(const char *);
__declspec(dllexport) void _Xout_of_range(const char *);
__declspec(dllexport) void _Xoverflow_error(const char *);
__declspec(dllexport) void _Xruntime_error(const char *);
}

namespace std {

template<class _Ty,
 class _Alloc>
 struct uses_allocator
  : _Has_allocator_type<_Ty, _Alloc>::type
 {
 };
}
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"


namespace std {

template<class _Ty> inline
 _Ty *_Allocate(size_t _Count, _Ty *)
 {
 void *_Ptr = 0;

 if (_Count == 0)
  ;
 else if (((size_t)(-1) / sizeof (_Ty) < _Count)
  || (_Ptr = ::operator new(_Count * sizeof (_Ty))) == 0)
  _Xbad_alloc();

 return ((_Ty *)_Ptr);
 }


template<class _Ty1,
 class _Ty2> inline
 void _Construct(_Ty1 *_Ptr, _Ty2 && _Val)
 {
 void *_Vptr = _Ptr;
 ::new (_Vptr) _Ty1(::std:: forward<_Ty2>(_Val));
 }
#line 49 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
template<class _Ty1> inline
 void _Construct(_Ty1 *_Ptr)
 {
 void *_Vptr = _Ptr;

 ::new (_Vptr) _Ty1();
 }


template<class _Ty> inline
 void _Destroy(_Ty *_Ptr)
 {
 _Ptr->~_Ty();
 }

template<> inline
 void _Destroy(char *)
 {
 }

template<> inline
 void _Destroy(wchar_t *)
 {
 }


template<class _Alloc> inline
 void _Destroy_range(typename _Alloc::pointer _First,
  typename _Alloc::pointer _Last, _Alloc& _Al,
  _Nonscalar_ptr_iterator_tag)
 {
 for (; _First != _Last; ++_First)
  _Al.destroy(_First);
 }

template<class _Alloc> inline
 void _Destroy_range(typename _Alloc::pointer _First,
  typename _Alloc::pointer _Last, _Alloc& _Al,
  _Scalar_ptr_iterator_tag)
 {
 }

template<class _Alloc> inline
 void _Destroy_range(typename _Alloc::pointer _First,
  typename _Alloc::pointer _Last, _Alloc& _Al)
 {
 _Destroy_range(_First, _Last, _Al, _Ptr_cat(_First, _Last));
 }


template<class _Alty>
 struct _Is_simple_alloc
  : _Cat_base<is_same<typename _Alty::size_type, size_t>::value
  && is_same<typename _Alty::difference_type, ptrdiff_t>::value
  && is_same<typename _Alty::pointer,
   typename _Alty::value_type *>::value
  && is_same<typename _Alty::const_pointer,
   const typename _Alty::value_type *>::value
  && is_same<typename _Alty::reference,
   typename _Alty::value_type&>::value
  && is_same<typename _Alty::const_reference,
   const typename _Alty::value_type&>::value>
 {
 };


template<class _Value_type>
 struct _Simple_types
 {
 typedef _Value_type value_type;
 typedef size_t size_type;
 typedef ptrdiff_t difference_type;
 typedef value_type *pointer;
 typedef const value_type *const_pointer;
 typedef value_type& reference;
 typedef const value_type& const_reference;
 };


template<class _Alty,
 class _Pointer>
 struct _Get_voidptr
 {
 typedef typename _Alty::template rebind<void>::other _Alvoid;
 typedef typename _Alvoid::pointer type;
 };

template<class _Alty,
 class _Ty>
 struct _Get_voidptr<_Alty, _Ty *>
 {
 typedef void *type;
 };


template<class _Iter>
 struct _Is_iterator
 : public integral_constant<bool, !is_integral<_Iter>::value>
 {
 };


template<class _Ty>
 struct pointer_traits;



template<class _Ty>
 struct _Get_first_parameter;

template<template<class, class...> class _Ty,
 class _First,
 class... _Rest>
 struct _Get_first_parameter<_Ty<_First, _Rest...> >
 {
 typedef _First type;
 };


template<class _Newfirst,
 class _Ty>
 struct _Replace_first_parameter;

template<class _Newfirst,
 template<class, class...> class _Ty,
 class _First,
 class... _Rest>
 struct _Replace_first_parameter<_Newfirst, _Ty<_First, _Rest...> >
 {
 typedef _Ty<_Newfirst, _Rest...> type;
 };
#line 198 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
template<class _Ty>
 struct _Get_element_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::element_type>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename _Get_first_parameter<_Uty>::type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty>
 struct _Get_ptr_difference_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::difference_type>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<ptrdiff_t>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty,
 class _Other>
 struct _Get_rebind_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::template rebind<_Other>::other>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename _Replace_first_parameter<_Other , _Uty>::type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty>
 struct pointer_traits
 {
 typedef pointer_traits<_Ty> other;

 typedef typename _Get_element_type<_Ty>::type element_type;
 typedef _Ty pointer;
 typedef typename _Get_ptr_difference_type<_Ty>::type difference_type;






 template<class _Other>
  struct rebind
  {
  typedef typename _Get_rebind_type<_Ty, _Other>::type other;
  };


 typedef typename _If<is_void<element_type>::value,
  char&,
  typename add_reference<element_type>::type>::type _Reftype;

 static pointer pointer_to(_Reftype _Val)
  {
  return (_Ty::pointer_to(_Val));
  }
 };


template<class _Ty>
 struct pointer_traits<_Ty *>
 {
 typedef pointer_traits<_Ty *> other;

 typedef _Ty element_type;
 typedef _Ty *pointer;
 typedef ptrdiff_t difference_type;






 template<class _Other>
  struct rebind
  {
  typedef _Other *other;
  };


 typedef typename _If<is_void<_Ty>::value,
  char&,
  typename add_reference<_Ty>::type>::type _Reftype;

 static pointer pointer_to(_Reftype _Val)
  {
  return (::std:: addressof(_Val));
  }
 };


template<class _Ty>
 struct _Get_pointer_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::pointer>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename _Ty::value_type *>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty>
 struct _Get_const_pointer_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::const_pointer>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename pointer_traits<typename _Get_pointer_type<_Ty>::type> ::template rebind<const typename _Ty::value_type> :: other>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };




template<class _Ty>
 struct _Get_void_pointer_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::void_pointer>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename pointer_traits<typename _Get_pointer_type<_Ty>::type> ::template rebind<void> :: other>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };




template<class _Ty>
 struct _Get_const_void_pointer_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::const_void_pointer>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename pointer_traits<typename _Get_pointer_type<_Ty>::type> ::template rebind<const void> :: other>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };




template<class _Ty>
 struct _Get_difference_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::difference_type>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename _Get_ptr_difference_type< typename _Get_pointer_type<_Ty>::type>::type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };




template<class _Ty>
 struct _Get_size_type
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::size_type>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<typename make_unsigned< typename _Get_difference_type<_Ty>::type>::type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };




template<class _Ty>
 struct _Get_propagate_on_container_copy
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::propagate_on_container_copy_assignment>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<false_type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty>
 struct _Get_propagate_on_container_move
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::propagate_on_container_move_assignment>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<false_type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



template<class _Ty>
 struct _Get_propagate_on_container_swap
 { template<class _Uty> static auto _Fn(int) -> _Identity<typename _Uty::propagate_on_container_swap>; template<class _Uty> static auto _Fn(_Wrap_int) -> _Identity<false_type>; typedef decltype(_Fn<_Ty>(0)) _Decltype; typedef typename _Decltype::type type; };



struct _Alloc_allocate
 {



 template<class _Alloc,
  class _Size_type,
  class _Const_void_pointer>
  static auto _Fn(int, _Alloc& _Al,
   _Size_type _Count,
   _Const_void_pointer _Hint)
   -> decltype(_Al.allocate(_Count, _Hint))
  {
  return (_Al.allocate(_Count, _Hint));
  }

 template<class _Alloc,
  class _Size_type,
  class _Const_void_pointer>
  static auto _Fn(_Wrap_int, _Alloc& _Al,
   _Size_type _Count,
   _Const_void_pointer)
   -> decltype(_Al.allocate(_Count))
  {
  return (_Al.allocate(_Count));
  }
#line 378 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 };


struct _Alloc_construct
 {





 template<class _Ty,
  class _Objty,
  class... _Types>
  static auto _Fn(int, _Ty& _Al, _Objty *_Ptr,
   _Types&&... _Args)
   -> decltype(
    _Al.construct(_Ptr, ::std:: forward<_Types>(_Args)...))
  {
  _Al.construct(_Ptr, ::std:: forward<_Types>(_Args)...);
  }

 template<class _Ty,
  class _Objty,
  class... _Types>
  static auto _Fn(_Wrap_int, _Ty&, _Objty *_Ptr,
   _Types&&... _Args)
   -> void
  {
  ::new (static_cast<void *>(_Ptr))
   _Objty(::std:: forward<_Types>(_Args)...);
  }
#line 455 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 };


struct _Alloc_destroy
 {

 template<class _Ty,
  class _Objty>
  static auto _Fn(int, _Ty& _Al, _Objty *_Ptr)
   -> decltype(_Al.destroy(_Ptr))
  {
  _Al.destroy(_Ptr);
  }

 template<class _Ty,
  class _Objty>
  static auto _Fn(_Wrap_int, _Ty&, _Objty *_Ptr)
   -> void
  {
  _Ptr->~_Objty();
  }
#line 485 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 };


struct _Alloc_max_size
 {

 template<class _Ty>
  static auto _Fn(int, const _Ty& _Al)
   -> decltype(_Al.max_size())
  {
  return (_Al.max_size());
  }

 template<class _Ty>
  static auto _Fn(_Wrap_int, const _Ty&)
   -> typename _Get_size_type<_Ty>::type
  {
  return ((numeric_limits<typename _Get_size_type<_Ty>::type>::max)());
  }
#line 513 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 };


struct _Alloc_select
 {



 template<class _Ty>
  static auto _Fn(int, const _Ty& _Al)
   -> decltype((_Ty)_Al.select_on_container_copy_construction())
  {
  return (_Al.select_on_container_copy_construction());
  }

 template<class _Ty>
  static auto _Fn(_Wrap_int, const _Ty& _Al)
   -> _Ty
  {
  return (_Al);
  }
#line 542 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 };


template<class _Alloc>
 struct allocator_traits
 {
 typedef allocator_traits<_Alloc> other;

 typedef _Alloc allocator_type;
 typedef typename _Alloc::value_type value_type;

 typedef typename _Get_pointer_type<_Alloc>::type
  pointer;
 typedef typename _Get_const_pointer_type<_Alloc>::type
  const_pointer;
 typedef typename _Get_void_pointer_type<_Alloc>::type
  void_pointer;
 typedef typename _Get_const_void_pointer_type<_Alloc>::type
  const_void_pointer;

 typedef typename _Get_size_type<_Alloc>::type size_type;
 typedef typename _Get_difference_type<_Alloc>::type difference_type;

 typedef typename _Get_propagate_on_container_copy<_Alloc>::type
  propagate_on_container_copy_assignment;
 typedef typename _Get_propagate_on_container_move<_Alloc>::type
  propagate_on_container_move_assignment;
 typedef typename _Get_propagate_on_container_swap<_Alloc>::type
  propagate_on_container_swap;
#line 580 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Other>
  struct rebind_alloc
  {
  typedef typename _Get_rebind_type<_Alloc, _Other>::type other;
  };

 template<class _Other>
  struct rebind_traits
  {

  typedef typename rebind_alloc<_Other>::other _Other_alloc;
  typedef allocator_traits<_Other_alloc> other;
  };


 static pointer allocate(_Alloc& _Al, size_type _Count)
  {
  return (_Al.allocate(_Count));
  }

 static pointer allocate(_Alloc& _Al, size_type _Count,
  const_void_pointer _Hint)
  {
  return (_Alloc_allocate::_Fn(0, _Al, _Count, _Hint));
  }

 static void deallocate(_Alloc& _Al,
  pointer _Ptr, size_type _Count)
  {
  _Al.deallocate(_Ptr, _Count);
  }


 template<class _Ty,
  class... _Types>
  static void construct(_Alloc& _Al, _Ty *_Ptr,
   _Types&&... _Args)
  {
  _Alloc_construct::_Fn(0, _Al, _Ptr,
   ::std:: forward<_Types>(_Args)...);
  }
#line 636 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Ty>
  static void destroy(_Alloc& _Al, _Ty *_Ptr)
  {
  _Alloc_destroy::_Fn(0, _Al, _Ptr);
  }

 static size_type max_size(const _Alloc& _Al)
  {
  return (_Alloc_max_size::_Fn(0, _Al));
  }

 static _Alloc select_on_container_copy_construction(
  const _Alloc& _Al)
  {
  return (_Alloc_select::_Fn(0, _Al));
  }
 };


template<class _Ty>
 struct _Allocator_base
 {
 typedef _Ty value_type;
 };


template<class _Ty>
 struct _Allocator_base<const _Ty>
 {
 typedef _Ty value_type;
 };


template<class _Ty>
 class allocator
  : public _Allocator_base<_Ty>
 {
public:
 typedef allocator<_Ty> other;

 typedef _Allocator_base<_Ty> _Mybase;
 typedef typename _Mybase::value_type value_type;

 typedef value_type *pointer;
 typedef const value_type *const_pointer;
 typedef void *void_pointer;
 typedef const void *const_void_pointer;

 typedef value_type& reference;
 typedef const value_type& const_reference;

 typedef size_t size_type;
 typedef ptrdiff_t difference_type;

 typedef false_type propagate_on_container_copy_assignment;
 typedef false_type propagate_on_container_move_assignment;
 typedef false_type propagate_on_container_swap;

 allocator<_Ty> select_on_container_copy_construction() const
  {
  return (*this);
  }

 template<class _Other>
  struct rebind
  {
  typedef allocator<_Other> other;
  };

 pointer address(reference _Val) const
  {
  return (::std:: addressof(_Val));
  }

 const_pointer address(const_reference _Val) const
  {
  return (::std:: addressof(_Val));
  }

 allocator()
  {
  }

 allocator(const allocator<_Ty>&)
  {
  }

 template<class _Other>
  allocator(const allocator<_Other>&)
  {
  }

 template<class _Other>
  allocator<_Ty>& operator=(const allocator<_Other>&)
  {
  return (*this);
  }

 void deallocate(pointer _Ptr, size_type)
  {
  ::operator delete(_Ptr);
  }

 pointer allocate(size_type _Count)
  {
  return (_Allocate(_Count, (pointer)0));
  }

 pointer allocate(size_type _Count, const void *)
  {
  return (allocate(_Count));
  }

 void construct(_Ty *_Ptr)
  {
  ::new ((void *)_Ptr) _Ty();
  }

 void construct(_Ty *_Ptr, const _Ty& _Val)
  {
  ::new ((void *)_Ptr) _Ty(_Val);
  }


 template<class _Objty,
  class... _Types>
  void construct(_Objty *_Ptr, _Types&&... _Args)
  {
  ::new ((void *)_Ptr) _Objty(::std:: forward<_Types>(_Args)...);
  }
#line 780 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Uty>
  void destroy(_Uty *_Ptr)
  {
  _Ptr->~_Uty();
  }

 size_t max_size() const
  {
  return ((size_t)(-1) / sizeof (_Ty));
  }
 };


template<>
 class allocator<void>
 {
public:
 typedef allocator<void> other;

 typedef void value_type;

 typedef void *pointer;
 typedef const void *const_pointer;
 typedef void *void_pointer;
 typedef const void *const_void_pointer;

 template<class _Other>
  struct rebind
  {
  typedef allocator<_Other> other;
  };

 allocator()
  {
  }

 allocator(const allocator<void>&)
  {
  }

 template<class _Other>
  allocator(const allocator<_Other>&)
  {
  }

 template<class _Other>
  allocator<void>& operator=(const allocator<_Other>&)
  {
  return (*this);
  }
 };

template<class _Ty,
 class _Other> inline
 bool operator==(const allocator<_Ty>&,
  const allocator<_Other>&)
 {
 return (true);
 }

template<class _Ty,
 class _Other> inline
 bool operator!=(const allocator<_Ty>& _Left,
  const allocator<_Other>& _Right)
 {
 return (!(_Left == _Right));
 }


template<class _Ty>
 struct allocator_traits<allocator<_Ty> >
 {
 typedef allocator<_Ty> _Alloc;

 typedef allocator_traits<_Alloc> other;

 typedef _Alloc allocator_type;
 typedef typename _Alloc::value_type value_type;

 typedef value_type *pointer;
 typedef const value_type *const_pointer;
 typedef void *void_pointer;
 typedef const void *const_void_pointer;

 typedef value_type& reference;
 typedef const value_type& const_reference;

 typedef size_t size_type;
 typedef ptrdiff_t difference_type;

 typedef false_type propagate_on_container_copy_assignment;
 typedef false_type propagate_on_container_move_assignment;
 typedef false_type propagate_on_container_swap;
#line 882 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Other>
  struct rebind_alloc
  {
  typedef allocator<_Other> other;
  };

 template<class _Other>
  struct rebind_traits
  {

  typedef allocator_traits<allocator<_Other> > other;
  };


 static pointer allocate(_Alloc& _Al, size_type _Count)
  {
  return (_Al.allocate(_Count));
  }

 static pointer allocate(_Alloc& _Al, size_type _Count,
  const_void_pointer _Hint)
  {
  return (_Al.allocate(_Count, _Hint));
  }

 static void deallocate(_Alloc& _Al,
  pointer _Ptr, size_type _Count)
  {
  _Al.deallocate(_Ptr, _Count);
  }


 template<class _Objty,
  class... _Types>
  static void construct(_Alloc& _Al, _Objty *_Ptr,
   _Types&&... _Args)
  {
  _Al.construct(_Ptr, ::std:: forward<_Types>(_Args)...);
  }
#line 936 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Uty>
  static void destroy(_Alloc& _Al, _Uty *_Ptr)
  {
  _Al.destroy(_Ptr);
  }

 static size_type max_size(const _Alloc& _Al)
  {
  return (_Al.max_size());
  }

 static _Alloc select_on_container_copy_construction(
  const _Alloc& _Al)
  {
  return (_Al.select_on_container_copy_construction());
  }
 };


template<class _Alloc>
 struct _Wrap_alloc
  : public _Alloc
 {
 typedef _Wrap_alloc<_Alloc> other;

 typedef _Alloc _Mybase;
 typedef allocator_traits<_Alloc> _Mytraits;

 typedef typename _Mytraits::value_type value_type;

 typedef typename _Mytraits::pointer pointer;
 typedef typename _Mytraits::const_pointer const_pointer;
 typedef typename _Mytraits::void_pointer void_pointer;
 typedef typename _Mytraits::const_void_pointer const_void_pointer;

 typedef typename _If<is_void<value_type>::value,
  int, value_type>::type& reference;
 typedef typename _If<is_void<const value_type>::value,
  const int, const value_type>::type& const_reference;

 typedef typename _Mytraits::size_type size_type;
 typedef typename _Mytraits::difference_type difference_type;

 typedef typename _Mytraits::propagate_on_container_copy_assignment
  propagate_on_container_copy_assignment;
 typedef typename _Mytraits::propagate_on_container_move_assignment
  propagate_on_container_move_assignment;
 typedef typename _Mytraits::propagate_on_container_swap
  propagate_on_container_swap;

 _Wrap_alloc select_on_container_copy_construction() const
  {
  return (_Mytraits::select_on_container_copy_construction(*this));
  }
#line 1000 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Other>
  struct rebind
  {
  typedef typename _Mytraits::template rebind_alloc<_Other>::other
   _Other_alloc;
  typedef _Wrap_alloc<_Other_alloc> other;
  };


 pointer address(reference _Val) const
  {
  return (::std:: addressof(_Val));
  }

 const_pointer address(const_reference _Val) const
  {
  return (::std:: addressof(_Val));
  }

 _Wrap_alloc()
  : _Mybase()
  {
  }

 _Wrap_alloc(const _Mybase& _Right)
  : _Mybase(_Right)
  {
  }

 _Wrap_alloc(const _Wrap_alloc& _Right)
  : _Mybase(_Right)
  {
  }

 template<class _Other>
  _Wrap_alloc(const _Other& _Right)
  : _Mybase(_Right)
  {
  }

 template<class _Other>
  _Wrap_alloc(_Other& _Right)
  : _Mybase(_Right)
  {
  }

 _Wrap_alloc& operator=(const _Mybase& _Right)
  {
  _Mybase::operator=(_Right);
  return (*this);
  }

 _Wrap_alloc& operator=(const _Wrap_alloc& _Right)
  {
  _Mybase::operator=(_Right);
  return (*this);
  }

 template<class _Other>
  _Wrap_alloc& operator=(const _Other& _Right)
  {
  _Mybase::operator=(_Right);
  return (*this);
  }

 pointer allocate(size_type _Count)
  {
  return (_Mybase::allocate(_Count));
  }

 pointer allocate(size_type _Count,
  const_void_pointer _Hint)
  {
  return (_Mytraits::allocate(*this, _Count, _Hint));
  }

 void deallocate(pointer _Ptr, size_type _Count)
  {
  _Mybase::deallocate(_Ptr, _Count);
  }

 void construct(value_type *_Ptr)
  {
  _Mytraits::construct(*this, _Ptr);
  }


 template<class _Ty,
  class... _Types>
  void construct(_Ty *_Ptr,
   _Types&&... _Args)
  {
  _Mytraits::construct(*this, _Ptr,
   ::std:: forward<_Types>(_Args)...);
  }
#line 1109 "C:\\src\\winrtl\\include\\dinkumware64\\xmemory0"
 template<class _Ty>
  void destroy(_Ty *_Ptr)
  {
  _Mytraits::destroy(*this, _Ptr);
  }

 size_type max_size() const
  {
  return (_Mytraits::max_size(*this));
  }
 };

template<class _Ty,
 class _Other> inline
 bool operator==(const _Wrap_alloc<_Ty>& _Left,
  const _Wrap_alloc<_Other>& _Right)
 {
 return (static_cast<_Ty>(_Left) == static_cast<_Other>(_Right));
 }

template<class _Ty,
 class _Other> inline
 bool operator!=(const _Wrap_alloc<_Ty>& _Left,
  const _Wrap_alloc<_Other>& _Right)
 {
 return (!(_Left == _Right));
 }
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"


namespace std {
template<class _Elem,
 class _Traits = char_traits<_Elem>,
 class _Ax = allocator<_Elem> >
 class basic_string;
#line 23 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
template<class _Mystr>
 class _String_const_iterator
  : public _Iterator012<random_access_iterator_tag,
   typename _Mystr::value_type,
   typename _Mystr::difference_type,
   typename _Mystr::const_pointer,
   typename _Mystr::const_reference,
   _Iterator_base>
 {
public:
 typedef _String_const_iterator<_Mystr> _Myiter;
 typedef random_access_iterator_tag iterator_category;

 typedef typename _Mystr::value_type value_type;
 typedef typename _Mystr::difference_type difference_type;
 typedef typename _Mystr::const_pointer pointer;
 typedef typename _Mystr::const_reference reference;

 _String_const_iterator()
  {
  this->_Ptr = 0;
  }

 _String_const_iterator(pointer _Parg, const _Container_base *_Pstring)
  {
  this->_Adopt(_Pstring);
  this->_Ptr = _Parg;
  }

 typedef pointer _Unchecked_type;

 _Myiter& _Rechecked(_Unchecked_type _Right)
  {
  this->_Ptr = _Right;
  return (*this);
  }

 _Unchecked_type _Unchecked() const
  {
  return (_Unchecked_type(this->_Ptr));
  }

 reference operator*() const
  {
#line 86 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
  return (*this->_Ptr);
  }

 pointer operator->() const
  {
  return (::std:: pointer_traits<pointer>::pointer_to(**this));
  }

 _Myiter& operator++()
  {
#line 113 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
  ++this->_Ptr;
  return (*this);
  }

 _Myiter operator++(int)
  {
  _Myiter _Tmp = *this;
  ++*this;
  return (_Tmp);
  }

 _Myiter& operator--()
  {
#line 141 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
  --this->_Ptr;
  return (*this);
  }

 _Myiter operator--(int)
  {
  _Myiter _Tmp = *this;
  --*this;
  return (_Tmp);
  }

 _Myiter& operator+=(difference_type _Off)
  {
#line 173 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
  _Ptr += _Off;
  return (*this);
  }

 _Myiter operator+(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp += _Off);
  }

 _Myiter& operator-=(difference_type _Off)
  {
  return (*this += -_Off);
  }

 _Myiter operator-(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp -= _Off);
  }

 difference_type operator-(const _Myiter& _Right) const
  {
  _Compat(_Right);
  return (this->_Ptr - _Right._Ptr);
  }

 reference operator[](difference_type _Off) const
  {
  return (*(*this + _Off));
  }

 bool operator==(const _Myiter& _Right) const
  {
  _Compat(_Right);
  return (this->_Ptr == _Right._Ptr);
  }

 bool operator!=(const _Myiter& _Right) const
  {
  return (!(*this == _Right));
  }

 bool operator<(const _Myiter& _Right) const
  {
  _Compat(_Right);
  return (this->_Ptr < _Right._Ptr);
  }

 bool operator>(const _Myiter& _Right) const
  {
  return (_Right < *this);
  }

 bool operator<=(const _Myiter& _Right) const
  {
  return (!(_Right < *this));
  }

 bool operator>=(const _Myiter& _Right) const
  {
  return (!(*this < _Right));
  }
#line 256 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
 void _Compat(const _Myiter&) const
  {
  }


 pointer _Ptr;
 };

template<class _Mystr> inline
 typename _String_const_iterator<_Mystr>::_Unchecked_type
  _Unchecked(_String_const_iterator<_Mystr> _Iter)
 {
 return (_Iter._Unchecked());
 }

template<class _Mystr> inline
 _String_const_iterator<_Mystr>
  _Rechecked(_String_const_iterator<_Mystr>& _Iter,
   typename _String_const_iterator<_Mystr>
    ::_Unchecked_type _Right)
 {
 return (_Iter._Rechecked(_Right));
 }

template<class _Mystr> inline
 _String_const_iterator<_Mystr> operator+(
  typename _String_const_iterator<_Mystr>
   ::difference_type _Off,
  _String_const_iterator<_Mystr> _Next)
 {
 return (_Next += _Off);
 }


template<class _Mystr>
 class _String_iterator
  : public _String_const_iterator<_Mystr>
 {
public:
 typedef _String_iterator<_Mystr> _Myiter;
 typedef _String_const_iterator<_Mystr> _Mybase;
 typedef random_access_iterator_tag iterator_category;

 typedef typename _Mystr::value_type value_type;
 typedef typename _Mystr::difference_type difference_type;
 typedef typename _Mystr::pointer pointer;
 typedef typename _Mystr::reference reference;

 _String_iterator()
  {
  }

 _String_iterator(pointer _Parg, const _Container_base *_Pstring)
  : _Mybase(_Parg, _Pstring)
  {
  }

 typedef pointer _Unchecked_type;

 _Myiter& _Rechecked(_Unchecked_type _Right)
  {
  this->_Ptr = _Right;
  return (*this);
  }

 _Unchecked_type _Unchecked() const
  {
  return (_Unchecked_type(this->_Ptr));
  }

 reference operator*() const
  {
  return ((reference)**(_Mybase *)this);
  }

 pointer operator->() const
  {
  return (::std:: pointer_traits<pointer>::pointer_to(**this));
  }

 _Myiter& operator++()
  {
  ++*(_Mybase *)this;
  return (*this);
  }

 _Myiter operator++(int)
  {
  _Myiter _Tmp = *this;
  ++*this;
  return (_Tmp);
  }

 _Myiter& operator--()
  {
  --*(_Mybase *)this;
  return (*this);
  }

 _Myiter operator--(int)
  {
  _Myiter _Tmp = *this;
  --*this;
  return (_Tmp);
  }

 _Myiter& operator+=(difference_type _Off)
  {
  *(_Mybase *)this += _Off;
  return (*this);
  }

 _Myiter operator+(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp += _Off);
  }

 _Myiter& operator-=(difference_type _Off)
  {
  return (*this += -_Off);
  }

 _Myiter operator-(difference_type _Off) const
  {
  _Myiter _Tmp = *this;
  return (_Tmp -= _Off);
  }

 difference_type operator-(const _Mybase& _Right) const
  {
  return ((_Mybase)*this - _Right);
  }

 reference operator[](difference_type _Off) const
  {
  return (*(*this + _Off));
  }
 };

template<class _Mystr> inline
 typename _String_iterator<_Mystr>::_Unchecked_type
  _Unchecked(_String_iterator<_Mystr> _Iter)
 {
 return (_Iter._Unchecked());
 }

template<class _Mystr> inline
 _String_iterator<_Mystr>
  _Rechecked(_String_iterator<_Mystr>& _Iter,
   typename _String_iterator<_Mystr>
    ::_Unchecked_type _Right)
 {
 return (_Iter._Rechecked(_Right));
 }

template<class _Mystr> inline
 _String_iterator<_Mystr> operator+(
  typename _String_iterator<_Mystr>
   ::difference_type _Off,
  _String_iterator<_Mystr> _Next)
 {
 return (_Next += _Off);
 }



template<class _Value_type,
 class _Size_type,
 class _Difference_type,
 class _Pointer,
 class _Const_pointer,
 class _Reference,
 class _Const_reference>
 struct _String_iter_types
 {
 typedef _Value_type value_type;
 typedef _Size_type size_type;
 typedef _Difference_type difference_type;
 typedef _Pointer pointer;
 typedef _Const_pointer const_pointer;
 typedef _Reference reference;
 typedef _Const_reference const_reference;
 };

template<class _Ty,
 class _Alloc0>
 struct _String_base_types
 {
 typedef _Alloc0 _Alloc;
 typedef _String_base_types<_Ty, _Alloc> _Myt;


 typedef _Wrap_alloc<_Alloc> _Alty0;
 typedef typename _Alty0::template rebind<_Ty>::other _Alty;





 typedef typename _Alty::pointer _Tptr;
 typedef typename _Alty::template rebind<_Tptr>::other _Alpty;

 typedef typename _If<_Is_simple_alloc<_Alty>::value,
  _Simple_types<typename _Alty::value_type>,
  _String_iter_types<typename _Alty::value_type,
   typename _Alty::size_type,
   typename _Alty::difference_type,
   typename _Alty::pointer,
   typename _Alty::const_pointer,
   typename _Alty::reference,
   typename _Alty::const_reference> >::type
  _Val_types;
 };
#line 485 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
template<class _Val_types>
 class _String_val
  : public _Container_base
 {
public:
 typedef _String_val<_Val_types> _Myt;


 typedef typename _Val_types::value_type value_type;
 typedef typename _Val_types::size_type size_type;
 typedef typename _Val_types::difference_type difference_type;
 typedef typename _Val_types::pointer pointer;
 typedef typename _Val_types::const_pointer const_pointer;
 typedef typename _Val_types::reference reference;
 typedef typename _Val_types::const_reference const_reference;

 typedef _String_iterator<_Myt> iterator;
 typedef _String_const_iterator<_Myt> const_iterator;

 _String_val()
  {
  _Mysize = 0;
  _Myres = 0;
  }

 enum
  {
  _BUF_SIZE = 16 / sizeof (value_type) < 1 ? 1
   : 16 / sizeof (value_type)};
 enum
  {
  _ALLOC_MASK = sizeof (value_type) <= 1 ? 15
   : sizeof (value_type) <= 2 ? 7
   : sizeof (value_type) <= 4 ? 3
   : sizeof (value_type) <= 8 ? 1 : 0};

 value_type *_Myptr()
  {
  return (this->_BUF_SIZE <= this->_Myres
   ? ::std:: addressof(*this->_Bx._Ptr)
   : this->_Bx._Buf);
  }

 const value_type *_Myptr() const
  {
  return (this->_BUF_SIZE <= this->_Myres
   ? ::std:: addressof(*this->_Bx._Ptr)
   : this->_Bx._Buf);
  }

 union _Bxty
  {
  value_type _Buf[_BUF_SIZE];
  pointer _Ptr;
  char _Alias[_BUF_SIZE];
  } _Bx;

 size_type _Mysize;
 size_type _Myres;
 };


template<bool _Al_has_storage,
 class _Alloc_types>
 class _String_alloc







  : public _String_val<typename _Alloc_types::_Val_types>
 {
public:
 typename _Alloc_types::_Alty _Alval;


 typedef _String_alloc<_Al_has_storage, _Alloc_types> _Myt;
 typedef typename _Alloc_types::_Alloc _Alloc;
 typedef typename _Alloc_types::_Alty _Alty;
#line 576 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
 _String_alloc(const _Alloc& _Al = _Alloc())
  : _Alval(_Al)
  {
  }


 void _Change_alloc(const _Alty& _Al)
  {
  this->_Alval = _Al;
  }

 void _Swap_alloc(_Myt& _Right)
  {
  _Swap_adl(this->_Alval, _Right._Alval);
  }
#line 647 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
 _Alty& _Getal()
  {
  return (this->_Alval);
  }

 const _Alty& _Getal() const
  {
  return (this->_Alval);
  }
 };




template<class _Alloc_types>
 class _String_alloc<false, _Alloc_types>
  : public _String_val<typename _Alloc_types::_Val_types>
 {
public:
 typedef _String_alloc<false, _Alloc_types> _Myt;
 typedef typename _Alloc_types::_Alloc _Alloc;

 typedef typename _Alloc_types::_Alty _Alty;


 _String_alloc(const _Alloc& = _Alloc())
  {
  }

 void _Change_alloc(const _Alty&)
  {
  }

 void _Swap_alloc(_Myt&)
  {
  }
#line 724 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
 _Alty _Getal() const
  {
  return (_Alty());
  }
 };



template<class _Elem,
 class _Traits,
 class _Alloc>
 class basic_string
  : public _String_alloc<!is_empty<_Alloc>::value,
   _String_base_types<_Elem, _Alloc> >
 {
public:
 typedef basic_string<_Elem, _Traits, _Alloc> _Myt;
 typedef _String_alloc<!is_empty<_Alloc>::value,
  _String_base_types<_Elem, _Alloc> > _Mybase;
 typedef _Traits traits_type;
 typedef _Alloc allocator_type;

 typedef typename _Mybase::_Alty _Alty;

 typedef typename _Mybase::value_type value_type;
 typedef typename _Mybase::size_type size_type;
 typedef typename _Mybase::difference_type difference_type;
 typedef typename _Mybase::pointer pointer;
 typedef typename _Mybase::const_pointer const_pointer;
 typedef typename _Mybase::reference reference;
 typedef typename _Mybase::const_reference const_reference;
#line 768 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
 typedef typename _Mybase::iterator iterator;
 typedef typename _Mybase::const_iterator const_iterator;

 typedef ::std:: reverse_iterator<iterator> reverse_iterator;
 typedef ::std:: reverse_iterator<const_iterator> const_reverse_iterator;


 basic_string(const _Myt& _Right)


  : _Mybase(_Right._Getal().select_on_container_copy_construction())





  {
  _Tidy();
  assign(_Right, 0, npos);
  }


 basic_string(const _Myt& _Right, const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  assign(_Right, 0, npos);
  }


 basic_string()
  : _Mybase()
  {
  _Tidy();
  }

 explicit basic_string(const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  }

 basic_string(const _Myt& _Right, size_type _Roff,
  size_type _Count = npos)
  : _Mybase(_Right._Getal())
  {
  _Tidy();
  assign(_Right, _Roff, _Count);
  }

 basic_string(const _Myt& _Right, size_type _Roff, size_type _Count,
  const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  assign(_Right, _Roff, _Count);
  }

 basic_string(const _Elem *_Ptr, size_type _Count)
  : _Mybase()
  {
  _Tidy();
  assign(_Ptr, _Count);
  }

 basic_string(const _Elem *_Ptr, size_type _Count, const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  assign(_Ptr, _Count);
  }

 basic_string(const _Elem *_Ptr)
  : _Mybase()
  {
  _Tidy();
  assign(_Ptr);
  }

 basic_string(const _Elem *_Ptr, const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  assign(_Ptr);
  }

 basic_string(size_type _Count, _Elem _Ch)
  : _Mybase()
  {
  _Tidy();
  assign(_Count, _Ch);
  }

 basic_string(size_type _Count, _Elem _Ch, const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  assign(_Count, _Ch);
  }


 template<class _Iter,
  class = typename enable_if<_Is_iterator<_Iter>::value,
   void>::type>
  basic_string(_Iter _First, _Iter _Last)
  : _Mybase()
  {
  _Tidy();
  _Construct(_First, _Last, _Iter_cat(_First));
  }

 template<class _Iter,
  class = typename enable_if<_Is_iterator<_Iter>::value,
   void>::type>
  basic_string(_Iter _First, _Iter _Last, const _Alloc& _Al)
  : _Mybase(_Al)
  {
  _Tidy();
  _Construct(_First, _Last, _Iter_cat(_First));
  }
#line 911 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
 template<class _Iter>
  void _Construct(_Iter _First,
   _Iter _Last, input_iterator_tag)
  {
  {{
  for (; _First != _Last; ++_First)
   append((size_type)1, (_Elem)*_First);
  } if (0) {
  _Tidy(true);
          ;
  }}
  }

 template<class _Iter>
  void _Construct(_Iter _First,
   _Iter _Last, forward_iterator_tag)
  {
                             ;
  size_type _Count = 0;
  _Distance(_First, _Last, _Count);
  reserve(_Count);

  {{
  for (; _First != _Last; ++_First)
   append((size_type)1, (_Elem)*_First);
  } if (0) {
  _Tidy(true);
          ;
  }}
  }




 basic_string(const_pointer _First, const_pointer _Last)
  : _Mybase()
  {
                             ;
  _Tidy();
  if (_First != _Last)
   assign(&*_First, _Last - _First);
  }

 basic_string(const_pointer _First, const_pointer _Last,
  const _Alloc& _Al)
  : _Mybase(_Al)
  {
                             ;
  _Tidy();
  if (_First != _Last)
   assign(&*_First, _Last - _First);
  }


 basic_string(const_iterator _First, const_iterator _Last)
  : _Mybase()
  {
                             ;
  _Tidy();
  if (_First != _Last)
   assign(&*_First, _Last - _First);
  }


 basic_string(_Myt&& _Right)
  : _Mybase(_Right._Getal())
  {
  _Tidy();
  _Assign_rv(::std:: forward<_Myt>(_Right));
  }

 basic_string(_Myt&& _Right, const _Alloc& _Al)
  : _Mybase(_Al)
  {
  if (this->_Getal() != _Right._Getal())
   assign(_Right.begin(), _Right.end());
  else
   _Assign_rv(::std:: forward<_Myt>(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  if (this != &_Right)
   {
   _Tidy(true);


   if (_Alty::propagate_on_container_move_assignment::value
    && this->_Getal() != _Right._Getal())
    this->_Change_alloc(_Right._Getal());


   if (this->_Getal() != _Right._Getal())
    assign(_Right.begin(), _Right.end());
   else
    _Assign_rv(::std:: forward<_Myt>(_Right));
   }
  return (*this);
  }

 _Myt& assign(_Myt&& _Right)
  {
  if (this == &_Right)
   ;
  else if (get_allocator() != _Right.get_allocator()
   && this->_BUF_SIZE <= _Right._Myres)
   *this = _Right;
  else
   {
   _Tidy(true);
   _Assign_rv(::std:: forward<_Myt>(_Right));
   }
  return (*this);
  }

 void _Assign_rv(_Myt&& _Right)
  {
  if (_Right._Myres < this->_BUF_SIZE)
   _Traits::move(this->_Bx._Buf, _Right._Bx._Buf,
    _Right._Mysize + 1);
  else
   {
   this->_Getal().construct(&this->_Bx._Ptr, _Right._Bx._Ptr);
   _Right._Bx._Ptr = pointer();
   }
  this->_Mysize = _Right._Mysize;
  this->_Myres = _Right._Myres;
  _Right._Tidy();
  }



 basic_string(::std:: initializer_list<_Elem> _Ilist,
  const _Alloc& _Al = allocator_type())
  : _Mybase(_Al)
  {
  _Tidy();
  assign(_Ilist.begin(), _Ilist.end());
  }

 _Myt& operator=(::std:: initializer_list<_Elem> _Ilist)
  {
  return (assign(_Ilist.begin(), _Ilist.end()));
  }

 _Myt& operator+=(::std:: initializer_list<_Elem> _Ilist)
  {
  return (append(_Ilist.begin(), _Ilist.end()));
  }

 _Myt& assign(::std:: initializer_list<_Elem> _Ilist)
  {
  return (assign(_Ilist.begin(), _Ilist.end()));
  }

 _Myt& append(::std:: initializer_list<_Elem> _Ilist)
  {
  return (append(_Ilist.begin(), _Ilist.end()));
  }

 iterator insert(const_iterator _Where,
  ::std:: initializer_list<_Elem> _Ilist)
  {
  return (insert(_Where, _Ilist.begin(), _Ilist.end()));
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  ::std:: initializer_list<_Elem> _Ilist)
  {
  return (replace(_First, _Last, _Ilist.begin(), _Ilist.end()));
  }


 ~basic_string()
  {
  _Tidy(true);
  }

 static const size_type npos = (size_t)(-1);

 _Myt& operator=(const _Myt& _Right)
  {
  if (this != &_Right)
   {

   if (this->_Getal() != _Right._Getal()
    && _Alty::propagate_on_container_copy_assignment::value)
    {
    _Tidy(true);
    this->_Change_alloc(_Right._Getal());
    }


   assign(_Right);
   }
  return (*this);
  }

 _Myt& operator=(const _Elem *_Ptr)
  {
  return (assign(_Ptr));
  }

 _Myt& operator=(_Elem _Ch)
  {
  return (assign(1, _Ch));
  }

 _Myt& operator+=(const _Myt& _Right)
  {
  return (append(_Right));
  }

 _Myt& operator+=(const _Elem *_Ptr)
  {
  return (append(_Ptr));
  }

 _Myt& operator+=(_Elem _Ch)
  {
  return (append((size_type)1, _Ch));
  }

 _Myt& append(const _Myt& _Right)
  {
  return (append(_Right, 0, npos));
  }

 _Myt& append(const _Myt& _Right,
  size_type _Roff, size_type _Count)
  {
  if (_Right.size() < _Roff)
   _Xran();
  size_type _Num = _Right.size() - _Roff;
  if (_Num < _Count)
   _Count = _Num;
  if (npos - this->_Mysize <= _Count)
   _Xlen();

  if (0 < _Count && _Grow(_Num = this->_Mysize + _Count))
   {
   _Traits::copy(this->_Myptr() + this->_Mysize,
    _Right._Myptr() + _Roff, _Count);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& append(const _Elem *_Ptr, size_type _Count)
  {





  if (_Inside(_Ptr))
   return (append(*this,
    _Ptr - this->_Myptr(), _Count));
  if (npos - this->_Mysize <= _Count)
   _Xlen();

  size_type _Num;
  if (0 < _Count && _Grow(_Num = this->_Mysize + _Count))
   {
   _Traits::copy(this->_Myptr() + this->_Mysize, _Ptr, _Count);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& append(const _Elem *_Ptr)
  {
                      ;
  return (append(_Ptr, _Traits::length(_Ptr)));
  }

 _Myt& append(size_type _Count, _Elem _Ch)
  {
  if (npos - this->_Mysize <= _Count)
   _Xlen();

  size_type _Num;
  if (0 < _Count && _Grow(_Num = this->_Mysize + _Count))
   {
   _Chassign(this->_Mysize, _Count, _Ch);
   _Eos(_Num);
   }
  return (*this);
  }

 template<class _Iter>
  typename enable_if<_Is_iterator<_Iter>::value,
   _Myt&>::type
  append(_Iter _First, _Iter _Last)
  {
  return (replace(end(), end(), _First, _Last));
  }




 _Myt& append(const_pointer _First, const_pointer _Last)
  {
  return (replace(end(), end(), _First, _Last));
  }


 _Myt& append(const_iterator _First, const_iterator _Last)
  {
  return (replace(end(), end(), _First, _Last));
  }

 _Myt& assign(const _Myt& _Right)
  {
  return (assign(_Right, 0, npos));
  }

 _Myt& assign(const _Myt& _Right,
  size_type _Roff, size_type _Count)
  {
  if (_Right.size() < _Roff)
   _Xran();
  size_type _Num = _Right.size() - _Roff;
  if (_Count < _Num)
   _Num = _Count;

  if (this == &_Right)
   erase((size_type)(_Roff + _Num)), erase(0, _Roff);
  else if (_Grow(_Num))
   {
   _Traits::copy(this->_Myptr(),
    _Right._Myptr() + _Roff, _Num);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& assign(const _Elem *_Ptr, size_type _Count)
  {





  if (_Inside(_Ptr))
   return (assign(*this,
    _Ptr - this->_Myptr(), _Count));

  if (_Grow(_Count))
   {
   _Traits::copy(this->_Myptr(), _Ptr, _Count);
   _Eos(_Count);
   }
  return (*this);
  }

 _Myt& assign(const _Elem *_Ptr)
  {
                      ;
  return (assign(_Ptr, _Traits::length(_Ptr)));
  }

 _Myt& assign(size_type _Count, _Elem _Ch)
  {
  if (_Count == npos)
   _Xlen();

  if (_Grow(_Count))
   {
   _Chassign(0, _Count, _Ch);
   _Eos(_Count);
   }
  return (*this);
  }

 template<class _Iter>
  typename enable_if<_Is_iterator<_Iter>::value,
   _Myt&>::type
  assign(_Iter _First, _Iter _Last)
  {
  return (replace(begin(), end(), _First, _Last));
  }




 _Myt& assign(const_pointer _First, const_pointer _Last)
  {
  return (replace(begin(), end(), _First, _Last));
  }


 _Myt& assign(const_iterator _First, const_iterator _Last)
  {
  return (replace(begin(), end(), _First, _Last));
  }

 _Myt& insert(size_type _Off, const _Myt& _Right)
  {
  return (insert(_Off, _Right, 0, npos));
  }

 _Myt& insert(size_type _Off,
  const _Myt& _Right, size_type _Roff, size_type _Count)
  {
  if (this->_Mysize < _Off || _Right.size() < _Roff)
   _Xran();
  size_type _Num = _Right.size() - _Roff;
  if (_Num < _Count)
   _Count = _Num;
  if (npos - this->_Mysize <= _Count)
   _Xlen();

  if (0 < _Count && _Grow(_Num = this->_Mysize + _Count))
   {
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off,
    this->_Mysize - _Off);
   if (this == &_Right)
    _Traits::move(this->_Myptr() + _Off,
     this->_Myptr() + (_Off < _Roff ? _Roff + _Count : _Roff),
      _Count);
   else
    _Traits::copy(this->_Myptr() + _Off,
     _Right._Myptr() + _Roff, _Count);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& insert(size_type _Off,
  const _Elem *_Ptr, size_type _Count)
  {





  if (_Inside(_Ptr))
   return (insert(_Off, *this,
    _Ptr - this->_Myptr(), _Count));
  if (this->_Mysize < _Off)
   _Xran();
  if (npos - this->_Mysize <= _Count)
   _Xlen();
  size_type _Num;
  if (0 < _Count && _Grow(_Num = this->_Mysize + _Count))
   {
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off,
    this->_Mysize - _Off);
   _Traits::copy(this->_Myptr() + _Off, _Ptr, _Count);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& insert(size_type _Off, const _Elem *_Ptr)
  {
                      ;
  return (insert(_Off, _Ptr, _Traits::length(_Ptr)));
  }

 _Myt& insert(size_type _Off,
  size_type _Count, _Elem _Ch)
  {
  if (this->_Mysize < _Off)
   _Xran();
  if (npos - this->_Mysize <= _Count)
   _Xlen();
  size_type _Num;
  if (0 < _Count && _Grow(_Num = this->_Mysize + _Count))
   {
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off,
    this->_Mysize - _Off);
   _Chassign(_Off, _Count, _Ch);
   _Eos(_Num);
   }
  return (*this);
  }

 iterator insert(const_iterator _Where)
  {
  return (insert(_Where, _Elem()));
  }

 iterator insert(const_iterator _Where, _Elem _Ch)
  {
  size_type _Off = _Pdif(_Where, begin());
  insert(_Off, 1, _Ch);
  return (begin() + _Off);
  }

 iterator insert(const_iterator _Where, size_type _Count, _Elem _Ch)
  {
  size_type _Off = _Pdif(_Where, begin());
  insert(_Off, _Count, _Ch);
  return (begin() + _Off);
  }

 template<class _Iter>
  typename enable_if<_Is_iterator<_Iter>::value,
   iterator>::type
  insert(const_iterator _Where, _Iter _First, _Iter _Last)
  {
  size_type _Off = _Pdif(_Where, begin());
  replace(_Where, _Where, _First, _Last);
  return (begin() + _Off);
  }




 iterator insert(const_iterator _Where,
  const_pointer _First, const_pointer _Last)
  {
  size_type _Off = _Pdif(_Where, begin());
  replace(_Where, _Where, _First, _Last);
  return (begin() + _Off);
  }


 iterator insert(const_iterator _Where,
  const_iterator _First, const_iterator _Last)
  {
  size_type _Off = _Pdif(_Where, begin());
  replace(_Where, _Where, _First, _Last);
  return (begin() + _Off);
  }

 _Myt& erase(size_type _Off = 0)
  {
  if (this->_Mysize < _Off)
   _Xran();
  _Eos(_Off);
  return (*this);
  }

 _Myt& erase(size_type _Off, size_type _Count)
  {
  if (this->_Mysize < _Off)
   _Xran();
  if (this->_Mysize - _Off <= _Count)
   _Eos(_Off);
  else if (0 < _Count)
   {
   value_type *_Ptr = this->_Myptr() + _Off;
   size_type _Newsize = this->_Mysize - _Count;
   _Traits::move(_Ptr, _Ptr + _Count, _Newsize - _Off);
   _Eos(_Newsize);
   }
  return (*this);
  }

 iterator erase(const_iterator _Where)
  {
  size_type _Count = _Pdif(_Where, begin());
  erase(_Count, 1);
  return (iterator(this->_Myptr() + _Count, this));
  }

 iterator erase(const_iterator _First, const_iterator _Last)
  {
                             ;
  size_type _Count = _Pdif(_First, begin());
  erase(_Count, _Pdif(_Last, _First));
  return (iterator(this->_Myptr() + _Count, this));
  }

 void clear()
  {
  _Eos(0);
  }

 _Myt& replace(size_type _Off, size_type _N0, const _Myt& _Right)
  {
  return (replace(_Off, _N0, _Right, 0, npos));
  }

 _Myt& replace(size_type _Off,
  size_type _N0, const _Myt& _Right, size_type _Roff, size_type _Count)
  {
  if (this->_Mysize < _Off || _Right.size() < _Roff)
   _Xran();
  if (this->_Mysize - _Off < _N0)
   _N0 = this->_Mysize - _Off;
  size_type _Num = _Right.size() - _Roff;
  if (_Num < _Count)
   _Count = _Num;
  if (npos - _Count <= this->_Mysize - _N0)
   _Xlen();

  size_type _Nm = this->_Mysize - _N0 - _Off;
  size_type _Newsize = this->_Mysize + _Count - _N0;
  if (this->_Mysize < _Newsize)
   _Grow(_Newsize);

  if (this != &_Right)
   {
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0, _Nm);
   _Traits::copy(this->_Myptr() + _Off,
    _Right._Myptr() + _Roff, _Count);
   }
  else if (_Count <= _N0)
   {
   _Traits::move(this->_Myptr() + _Off,
    this->_Myptr() + _Roff, _Count);
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0, _Nm);
   }
  else if (_Roff <= _Off)
   {
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0, _Nm);
   _Traits::move(this->_Myptr() + _Off,
    this->_Myptr() + _Roff, _Count);
   }
  else if (_Off + _N0 <= _Roff)
   {
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0, _Nm);
   _Traits::move(this->_Myptr() + _Off,
    this->_Myptr() + (_Roff + _Count - _N0),
    _Count);
   }
  else
   {
   _Traits::move(this->_Myptr() + _Off,
    this->_Myptr() + _Roff, _N0);
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0, _Nm);
   _Traits::move(this->_Myptr() + _Off + _N0,
    this->_Myptr() + _Roff + _Count,
    _Count - _N0);
   }

  _Eos(_Newsize);
  return (*this);
  }

 _Myt& replace(size_type _Off,
  size_type _N0, const _Elem *_Ptr, size_type _Count)
  {





  if (_Inside(_Ptr))
   return (replace(_Off, _N0, *this,
    _Ptr - this->_Myptr(),
    _Count));
  if (this->_Mysize < _Off)
   _Xran();
  if (this->_Mysize - _Off < _N0)
   _N0 = this->_Mysize - _Off;
  if (npos - _Count <= this->_Mysize - _N0)
   _Xlen();
  size_type _Nm = this->_Mysize - _N0 - _Off;

  if (_Count < _N0)
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0,
    _Nm);
  size_type _Num;
  if ((0 < _Count || 0 < _N0)
   && _Grow(_Num = this->_Mysize + _Count - _N0))
   {
   if (_N0 < _Count)
    _Traits::move(this->_Myptr() + _Off + _Count,
     this->_Myptr() + _Off + _N0, _Nm);
   _Traits::copy(this->_Myptr() + _Off, _Ptr, _Count);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& replace(size_type _Off, size_type _N0, const _Elem *_Ptr)
  {
                      ;
  return (replace(_Off, _N0, _Ptr, _Traits::length(_Ptr)));
  }

 _Myt& replace(size_type _Off,
  size_type _N0, size_type _Count, _Elem _Ch)
  {
  if (this->_Mysize < _Off)
   _Xran();
  if (this->_Mysize - _Off < _N0)
   _N0 = this->_Mysize - _Off;
  if (npos - _Count <= this->_Mysize - _N0)
   _Xlen();
  size_type _Nm = this->_Mysize - _N0 - _Off;

  if (_Count < _N0)
   _Traits::move(this->_Myptr() + _Off + _Count,
    this->_Myptr() + _Off + _N0,
    _Nm);
  size_type _Num;
  if ((0 < _Count || 0 < _N0)
   && _Grow(_Num = this->_Mysize + _Count - _N0))
   {
   if (_N0 < _Count)
    _Traits::move(this->_Myptr() + _Off + _Count,
     this->_Myptr() + _Off + _N0, _Nm);
   _Chassign(_Off, _Count, _Ch);
   _Eos(_Num);
   }
  return (*this);
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  const _Myt& _Right)
  {
  return (replace(
   _Pdif(_First, begin()), _Pdif(_Last, _First), _Right));
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  const _Elem *_Ptr, size_type _Count)
  {
  return (replace(
   _Pdif(_First, begin()), _Pdif(_Last, _First), _Ptr, _Count));
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  const _Elem *_Ptr)
  {
  return (replace(
   _Pdif(_First, begin()), _Pdif(_Last, _First), _Ptr));
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  size_type _Count, _Elem _Ch)
  {
  return (replace(
   _Pdif(_First, begin()), _Pdif(_Last, _First), _Count, _Ch));
  }

 template<class _Iter>
  typename enable_if<_Is_iterator<_Iter>::value,
   _Myt&>::type
  replace(const_iterator _First, const_iterator _Last,
   _Iter _First2, _Iter _Last2)
  {
  _Myt _Right(_First2, _Last2);
  replace(_First, _Last, _Right);
  return (*this);
  }




 _Myt& replace(const_iterator _First, const_iterator _Last,
  const_pointer _First2, const_pointer _Last2)
  {
  if (_First2 == _Last2)
   erase(_Pdif(_First, begin()), _Pdif(_Last, _First));
  else
   replace(_Pdif(_First, begin()), _Pdif(_Last, _First),
    &*_First2, _Last2 - _First2);
  return (*this);
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  pointer _First2, pointer _Last2)
  {
  if (_First2 == _Last2)
   erase(_Pdif(_First, begin()), _Pdif(_Last, _First));
  else
   replace(_Pdif(_First, begin()), _Pdif(_Last, _First),
    &*_First2, _Last2 - _First2);
  return (*this);
  }


 _Myt& replace(const_iterator _First, const_iterator _Last,
  const_iterator _First2, const_iterator _Last2)
  {
  if (_First2 == _Last2)
   erase(_Pdif(_First, begin()), _Pdif(_Last, _First));
  else
   replace(_Pdif(_First, begin()), _Pdif(_Last, _First),
    &*_First2, _Last2 - _First2);
  return (*this);
  }

 _Myt& replace(const_iterator _First, const_iterator _Last,
  iterator _First2, iterator _Last2)
  {
  if (_First2 == _Last2)
   erase(_Pdif(_First, begin()), _Pdif(_Last, _First));
  else
   replace(_Pdif(_First, begin()), _Pdif(_Last, _First),
    &*_First2, _Last2 - _First2);
  return (*this);
  }

 iterator begin()
  {
  return (iterator(this->_Myptr(), this));
  }

 const_iterator begin() const
  {
  return (const_iterator(this->_Myptr(), this));
  }

 iterator end()
  {
  return (iterator(this->_Myptr() + this->_Mysize, this));
  }

 const_iterator end() const
  {
  return (const_iterator(this->_Myptr() + this->_Mysize, this));
  }

 reverse_iterator rbegin()
  {
  return (reverse_iterator(end()));
  }

 const_reverse_iterator rbegin() const
  {
  return (const_reverse_iterator(end()));
  }

 reverse_iterator rend()
  {
  return (reverse_iterator(begin()));
  }

 const_reverse_iterator rend() const
  {
  return (const_reverse_iterator(begin()));
  }


 const_iterator cbegin() const
  {
  return (((const _Myt *)this)->begin());
  }

 const_iterator cend() const
  {
  return (((const _Myt *)this)->end());
  }

 const_reverse_iterator crbegin() const
  {
  return (((const _Myt *)this)->rbegin());
  }

 const_reverse_iterator crend() const
  {
  return (((const _Myt *)this)->rend());
  }

 void shrink_to_fit()
  {
  if ((size() | this->_ALLOC_MASK) < capacity())
   {
   _Myt _Tmp(*this);
   swap(_Tmp);
   }
  }


 reference at(size_type _Off)
  {
  if (this->_Mysize <= _Off)
   _Xran();
  return (this->_Myptr()[_Off]);
  }

 const_reference at(size_type _Off) const
  {
  if (this->_Mysize <= _Off)
   _Xran();
  return (this->_Myptr()[_Off]);
  }

 reference operator[](size_type _Off)
  {
#line 1806 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
  return (this->_Myptr()[_Off]);
  }

 const_reference operator[](size_type _Off) const
  {
#line 1819 "C:\\src\\winrtl\\include\\dinkumware64\\xstring"
  return (this->_Myptr()[_Off]);
  }

 void push_back(_Elem _Ch)
  {
  insert(end(), _Ch);
  }


 void pop_back()
  {
  erase(this->_Mysize - 1);
  }

 reference front()
  {
  return (*begin());
  }

 const_reference front() const
  {
  return (*begin());
  }

 reference back()
  {
  return (*(end() - 1));
  }

 const_reference back() const
  {
  return (*(end() - 1));
  }


 const _Elem *c_str() const
  {
  return (this->_Myptr());
  }

 const _Elem *data() const
  {
  return (c_str());
  }

 size_type length() const
  {
  return (this->_Mysize);
  }

 size_type size() const
  {
  return (this->_Mysize);
  }

 size_type max_size() const
  {
  size_type _Num = this->_Getal().max_size();
  return (_Num <= 1 ? 1 : _Num - 1);
  }

 void resize(size_type _Newsize)
  {
  resize(_Newsize, _Elem());
  }

 void resize(size_type _Newsize, _Elem _Ch)
  {
  if (_Newsize <= this->_Mysize)
   _Eos(_Newsize);
  else
   append(_Newsize - this->_Mysize, _Ch);
  }

 size_type capacity() const
  {
  return (this->_Myres);
  }

 void reserve(size_type _Newcap = 0)
  {
  if (this->_Mysize <= _Newcap && this->_Myres != _Newcap)
   {
   size_type _Size = this->_Mysize;
   if (_Grow(_Newcap, true))
    _Eos(_Size);
   }
  }

 bool empty() const
  {
  return (this->_Mysize == 0);
  }

 size_type copy(_Elem *_Ptr,
  size_type _Count, size_type _Off = 0) const
  {





  if (this->_Mysize < _Off)
   _Xran();
  if (this->_Mysize - _Off < _Count)
   _Count = this->_Mysize - _Off;
  _Traits::copy(_Ptr, this->_Myptr() + _Off, _Count);
  return (_Count);
  }

 void _Swap_bx(_Myt& _Right)
  {
  if (this->_BUF_SIZE <= this->_Myres)
   if (this->_BUF_SIZE <= _Right._Myres)
    _Swap_adl(this->_Bx._Ptr, _Right._Bx._Ptr);
   else
    {
    pointer _Ptr = this->_Bx._Ptr;
    this->_Getal().destroy(&this->_Bx._Ptr);
    _Traits::copy(this->_Bx._Buf,
     _Right._Bx._Buf, _Right._Mysize + 1);
    this->_Getal().construct(&_Right._Bx._Ptr, _Ptr);
    }
  else
   if (_Right._Myres < this->_BUF_SIZE)
    ::std:: swap(this->_Bx._Buf, _Right._Bx._Buf);
   else
    {
    pointer _Ptr = _Right._Bx._Ptr;
    this->_Getal().destroy(&_Right._Bx._Ptr);
    _Traits::copy(_Right._Bx._Buf,
     this->_Bx._Buf, this->_Mysize + 1);
    this->_Getal().construct(&this->_Bx._Ptr, _Ptr);
    }
  }

 void swap(_Myt& _Right)
  {
  if (this == &_Right)
   ;
  else if (this->_Getal() == _Right._Getal())
   {
   this->_Swap_all(_Right);
   _Swap_bx(_Right);
   ::std:: swap(this->_Mysize, _Right._Mysize);
   ::std:: swap(this->_Myres, _Right._Myres);
   }


  else if (_Alty::propagate_on_container_swap::value)
   {
   this->_Swap_alloc(_Right);
   _Swap_bx(_Right);
   ::std:: swap(this->_Bx, _Right._Bx);
   ::std:: swap(this->_Mysize, _Right._Mysize);
   ::std:: swap(this->_Myres, _Right._Myres);
   }


  else
   {
   _Myt _Tmp = *this;

   *this = _Right;
   _Right = _Tmp;
   }
  }

 size_type find(const _Myt& _Right, size_type _Off = 0) const
  {
  return (find(_Right._Myptr(), _Off, _Right.size()));
  }

 size_type find(const _Elem *_Ptr,
  size_type _Off, size_type _Count) const
  {





  if (_Count == 0 && _Off <= this->_Mysize)
   return (_Off);

  size_type _Nm;
  if (_Off < this->_Mysize && _Count <= (_Nm = this->_Mysize - _Off))
   {
   const _Elem *_Uptr, *_Vptr;
   for (_Nm -= _Count - 1, _Vptr = this->_Myptr() + _Off;
    (_Uptr = _Traits::find(_Vptr, _Nm, *_Ptr)) != 0;
    _Nm -= _Uptr - _Vptr + 1, _Vptr = _Uptr + 1)
    if (_Traits::compare(_Uptr, _Ptr, _Count) == 0)
     return (_Uptr - this->_Myptr());
   }

  return (npos);
  }

 size_type find(const _Elem *_Ptr, size_type _Off = 0) const
  {
                      ;
  return (find(_Ptr, _Off, _Traits::length(_Ptr)));
  }

 size_type find(_Elem _Ch, size_type _Off = 0) const
  {
  return (find((const _Elem *)&_Ch, _Off, 1));
  }

 size_type rfind(const _Myt& _Right, size_type _Off = npos) const
  {
  return (rfind(_Right._Myptr(), _Off, _Right.size()));
  }

 size_type rfind(const _Elem *_Ptr,
  size_type _Off, size_type _Count) const
  {





  if (_Count == 0)
   return (_Off < this->_Mysize ? _Off
    : this->_Mysize);
  if (_Count <= this->_Mysize)
   {
   const _Elem *_Uptr = this->_Myptr() +
    (_Off < this->_Mysize - _Count ? _Off
     : this->_Mysize - _Count);
   for (; ; --_Uptr)
    if (_Traits::eq(*_Uptr, *_Ptr)
     && _Traits::compare(_Uptr, _Ptr, _Count) == 0)
     return (_Uptr - this->_Myptr());
    else if (_Uptr == this->_Myptr())
     break;
   }

  return (npos);
  }

 size_type rfind(const _Elem *_Ptr, size_type _Off = npos) const
  {
                      ;
  return (rfind(_Ptr, _Off, _Traits::length(_Ptr)));
  }

 size_type rfind(_Elem _Ch, size_type _Off = npos) const
  {
  return (rfind((const _Elem *)&_Ch, _Off, 1));
  }

 size_type find_first_of(const _Myt& _Right,
  size_type _Off = 0) const
  {
  return (find_first_of(_Right._Myptr(), _Off, _Right.size()));
  }

 size_type find_first_of(const _Elem *_Ptr,
  size_type _Off, size_type _Count) const
  {





  if (0 < _Count && _Off < this->_Mysize)
   {
   const _Elem *const _Vptr = this->_Myptr() + this->_Mysize;
   for (const _Elem *_Uptr = this->_Myptr() + _Off;
    _Uptr < _Vptr; ++_Uptr)
    if (_Traits::find(_Ptr, _Count, *_Uptr) != 0)
     return (_Uptr - this->_Myptr());
   }

  return (npos);
  }

 size_type find_first_of(const _Elem *_Ptr,
  size_type _Off = 0) const
  {
                      ;
  return (find_first_of(_Ptr, _Off, _Traits::length(_Ptr)));
  }

 size_type find_first_of(_Elem _Ch,
  size_type _Off = 0) const
  {
  return (find((const _Elem *)&_Ch, _Off, 1));
  }

 size_type find_last_of(const _Myt& _Right,
  size_type _Off = npos) const
  {
  return (find_last_of(_Right._Myptr(), _Off, _Right.size()));
  }

 size_type find_last_of(const _Elem *_Ptr,
  size_type _Off, size_type _Count) const
  {





  if (0 < _Count && 0 < this->_Mysize)
   {
   const _Elem *_Uptr = this->_Myptr()
    + (_Off < this->_Mysize ? _Off : this->_Mysize - 1);
   for (; ; --_Uptr)
    if (_Traits::find(_Ptr, _Count, *_Uptr) != 0)
     return (_Uptr - this->_Myptr());
    else if (_Uptr == this->_Myptr())
     break;
   }

  return (npos);
  }

 size_type find_last_of(const _Elem *_Ptr,
  size_type _Off = npos) const
  {
                      ;
  return (find_last_of(_Ptr, _Off, _Traits::length(_Ptr)));
  }

 size_type find_last_of(_Elem _Ch,
  size_type _Off = npos) const
  {
  return (rfind((const _Elem *)&_Ch, _Off, 1));
  }

 size_type find_first_not_of(const _Myt& _Right,
  size_type _Off = 0) const
  {
  return (find_first_not_of(_Right._Myptr(), _Off,
   _Right.size()));
  }

 size_type find_first_not_of(const _Elem *_Ptr,
  size_type _Off, size_type _Count) const
  {





  if (_Off < this->_Mysize)
   {
   const _Elem *const _Vptr = this->_Myptr() + this->_Mysize;
   for (const _Elem *_Uptr = this->_Myptr() + _Off;
    _Uptr < _Vptr; ++_Uptr)
    if (_Traits::find(_Ptr, _Count, *_Uptr) == 0)
     return (_Uptr - this->_Myptr());
   }
  return (npos);
  }

 size_type find_first_not_of(const _Elem *_Ptr,
  size_type _Off = 0) const
  {
                      ;
  return (find_first_not_of(_Ptr, _Off, _Traits::length(_Ptr)));
  }

 size_type find_first_not_of(_Elem _Ch,
  size_type _Off = 0) const
  {
  return (find_first_not_of((const _Elem *)&_Ch, _Off, 1));
  }

 size_type find_last_not_of(const _Myt& _Right,
  size_type _Off = npos) const
  {
  return (find_last_not_of(_Right._Myptr(), _Off, _Right.size()));
  }

 size_type find_last_not_of(const _Elem *_Ptr,
  size_type _Off, size_type _Count) const
  {





  if (0 < this->_Mysize)
   {
   const _Elem *_Uptr = this->_Myptr()
    + (_Off < this->_Mysize ? _Off : this->_Mysize - 1);
   for (; ; --_Uptr)
    if (_Traits::find(_Ptr, _Count, *_Uptr) == 0)
     return (_Uptr - this->_Myptr());
    else if (_Uptr == this->_Myptr())
     break;
   }
  return (npos);
  }

 size_type find_last_not_of(const _Elem *_Ptr,
  size_type _Off = npos) const
  {
                      ;
  return (find_last_not_of(_Ptr, _Off, _Traits::length(_Ptr)));
  }

 size_type find_last_not_of(_Elem _Ch,
  size_type _Off = npos) const
  {
  return (find_last_not_of((const _Elem *)&_Ch, _Off, 1));
  }

 _Myt substr(size_type _Off = 0, size_type _Count = npos) const
  {
  return (_Myt(*this, _Off, _Count, get_allocator()));
  }

 int compare(const _Myt& _Right) const
  {
  return (compare(0, this->_Mysize, _Right._Myptr(), _Right.size()));
  }

 int compare(size_type _Off, size_type _N0,
  const _Myt& _Right) const
  {
  return (compare(_Off, _N0, _Right, 0, npos));
  }

 int compare(size_type _Off,
  size_type _N0, const _Myt& _Right,
  size_type _Roff, size_type _Count) const
  {
  if (_Right.size() < _Roff)
   _Xran();
  if (_Right._Mysize - _Roff < _Count)
   _Count = _Right._Mysize - _Roff;
  return (compare(_Off, _N0, _Right._Myptr() + _Roff, _Count));
  }

 int compare(const _Elem *_Ptr) const
  {
                      ;
  return (compare(0, this->_Mysize, _Ptr, _Traits::length(_Ptr)));
  }

 int compare(size_type _Off, size_type _N0, const _Elem *_Ptr) const
  {
                      ;
  return (compare(_Off, _N0, _Ptr, _Traits::length(_Ptr)));
  }

 int compare(size_type _Off,
  size_type _N0, const _Elem *_Ptr, size_type _Count) const
  {





  if (this->_Mysize < _Off)
   _Xran();
  if (this->_Mysize - _Off < _N0)
   _N0 = this->_Mysize - _Off;

  size_type _Ans = _Traits::compare(this->_Myptr() + _Off, _Ptr,
   _N0 < _Count ? _N0 : _Count);
  return (_Ans != 0 ? (int)_Ans : _N0 < _Count ? -1
   : _N0 == _Count ? 0 : +1);
  }

 allocator_type get_allocator() const
  {
  return (this->_Getal());
  }

 void _Chassign(size_type _Off, size_type _Count, _Elem _Ch)
  {
  if (_Count == 1)
   _Traits::assign(*(this->_Myptr() + _Off), _Ch);
  else
   _Traits::assign(this->_Myptr() + _Off, _Count, _Ch);
  }

 void _Copy(size_type _Newsize, size_type _Oldlen)
  {
  size_type _Newres = _Newsize | this->_ALLOC_MASK;
  if (max_size() < _Newres)
   _Newres = _Newsize;
  else if (this->_Myres / 2 <= _Newres / 3)
   ;
  else if (this->_Myres <= max_size() - this->_Myres / 2)
   _Newres = this->_Myres
    + this->_Myres / 2;
  else
   _Newres = max_size();

  _Elem *_Ptr;
  {{
   _Ptr = this->_Getal().allocate(_Newres + 1);
  } if (0) {
   _Newres = _Newsize;
   {{
    _Ptr = this->_Getal().allocate(_Newres + 1);
   } if (0) {
   _Tidy(true);
           ;
   }}
  }}

  if (0 < _Oldlen)
   _Traits::copy(_Ptr, this->_Myptr(),
    _Oldlen);
  _Tidy(true);
  this->_Getal().construct(&this->_Bx._Ptr, _Ptr);
  this->_Myres = _Newres;
  _Eos(_Oldlen);
  }

 void _Eos(size_type _Newsize)
  {
  _Traits::assign(this->_Myptr()[this->_Mysize = _Newsize], _Elem());
  }

 bool _Grow(size_type _Newsize,
  bool _Trim = false)
  {
  if (max_size() < _Newsize)
   _Xlen();
  if (this->_Myres < _Newsize)
   _Copy(_Newsize, this->_Mysize);
  else if (_Trim && _Newsize < this->_BUF_SIZE)
   _Tidy(true,
    _Newsize < this->_Mysize ? _Newsize : this->_Mysize);
  else if (_Newsize == 0)
   _Eos(0);
  return (0 < _Newsize);
  }

 bool _Inside(const _Elem *_Ptr)
  {
  if (_Ptr == 0 || _Ptr < this->_Myptr()
   || this->_Myptr() + this->_Mysize <= _Ptr)
   return (false);
  else
   return (true);
  }

 static size_type _Pdif(const_iterator _P2,
  const_iterator _P1)
  {
  return ((_P2)._Ptr == 0 ? 0 : _P2 - _P1);
  }

 void _Tidy(bool _Built = false,
  size_type _Newsize = 0)
  {
  if (!_Built)
   ;
  else if (this->_BUF_SIZE <= this->_Myres)
   {
   pointer _Ptr = this->_Bx._Ptr;
   this->_Getal().destroy(&this->_Bx._Ptr);
   if (0 < _Newsize)
    _Traits::copy(this->_Bx._Buf,
     ::std:: addressof(*_Ptr), _Newsize);
   this->_Getal().deallocate(_Ptr, this->_Myres + 1);
   }
  this->_Myres = this->_BUF_SIZE - 1;
  _Eos(_Newsize);
  }

 void _Xlen() const
  {
  _Xlength_error("string too long");
  }

 void _Xran() const
  {
  _Xout_of_range("invalid string position");
  }
 };




template<class _Elem,
 class _Traits,
 class _Alloc> inline
 void swap(basic_string<_Elem, _Traits, _Alloc>& _Left,
  basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 _Left.swap(_Right);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 basic_string<_Elem, _Traits, _Alloc> _Ans;
 _Ans.reserve(_Left.size() + _Right.size());
 _Ans += _Left;
 _Ans += _Right;
 return (_Ans);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const _Elem *_Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 basic_string<_Elem, _Traits, _Alloc> _Ans;
 _Ans.reserve(_Traits::length(_Left) + _Right.size());
 _Ans += _Left;
 _Ans += _Right;
 return (_Ans);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const _Elem _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 basic_string<_Elem, _Traits, _Alloc> _Ans;
 _Ans.reserve(1 + _Right.size());
 _Ans += _Left;
 _Ans += _Right;
 return (_Ans);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 basic_string<_Elem, _Traits, _Alloc> _Ans;
 _Ans.reserve(_Left.size() + _Traits::length(_Right));
 _Ans += _Left;
 _Ans += _Right;
 return (_Ans);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem _Right)
 {
 basic_string<_Elem, _Traits, _Alloc> _Ans;
 _Ans.reserve(_Left.size() + 1);
 _Ans += _Left;
 _Ans += _Right;
 return (_Ans);
 }


template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  basic_string<_Elem, _Traits, _Alloc>&& _Right)
 {
 return (::std:: move(_Right.insert(0, _Left)));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  basic_string<_Elem, _Traits, _Alloc>&& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (::std:: move(_Left.append(_Right)));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  basic_string<_Elem, _Traits, _Alloc>&& _Left,
  basic_string<_Elem, _Traits, _Alloc>&& _Right)
 {
 if (_Right.size() <= _Left.capacity() - _Left.size()
  || _Right.capacity() - _Right.size() < _Left.size())
  return (::std:: move(_Left.append(_Right)));
 else
  return (::std:: move(_Right.insert(0, _Left)));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const _Elem *_Left,
  basic_string<_Elem, _Traits, _Alloc>&& _Right)
 {
 return (::std:: move(_Right.insert(0, _Left)));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  const _Elem _Left,
  basic_string<_Elem, _Traits, _Alloc>&& _Right)
 {
 return (::std:: move(_Right.insert(0, 1, _Left)));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  basic_string<_Elem, _Traits, _Alloc>&& _Left,
  const _Elem *_Right)
 {
 return (::std:: move(_Left.append(_Right)));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 basic_string<_Elem, _Traits, _Alloc> operator+(
  basic_string<_Elem, _Traits, _Alloc>&& _Left,
  const _Elem _Right)
 {
 return (::std:: move(_Left.append(1, _Right)));
 }


template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator==(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (_Left.compare(_Right) == 0);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator==(
  const _Elem * _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (_Right.compare(_Left) == 0);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator==(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 return (_Left.compare(_Right) == 0);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator!=(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator!=(
  const _Elem *_Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (!(_Left == _Right));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator!=(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 return (!(_Left == _Right));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator<(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (_Left.compare(_Right) < 0);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator<(
  const _Elem * _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (_Right.compare(_Left) > 0);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator<(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 return (_Left.compare(_Right) < 0);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator>(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (_Right < _Left);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator>(
  const _Elem * _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (_Right < _Left);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator>(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 return (_Right < _Left);
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator<=(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator<=(
  const _Elem * _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (!(_Right < _Left));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator<=(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 return (!(_Right < _Left));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator>=(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (!(_Left < _Right));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator>=(
  const _Elem * _Left,
  const basic_string<_Elem, _Traits, _Alloc>& _Right)
 {
 return (!(_Left < _Right));
 }

template<class _Elem,
 class _Traits,
 class _Alloc> inline
 bool operator>=(
  const basic_string<_Elem, _Traits, _Alloc>& _Left,
  const _Elem *_Right)
 {
 return (!(_Left < _Right));
 }

typedef basic_string<char, char_traits<char>, allocator<char> >
 string;
typedef basic_string<wchar_t, char_traits<wchar_t>, allocator<wchar_t> >
 wstring;


}
namespace std {

template<class _Elem,
 class _Traits,
 class _Alloc>
 struct hash<basic_string<_Elem, _Traits, _Alloc> >
  : public unary_function<basic_string<_Elem, _Traits, _Alloc>, size_t>
 {
 typedef basic_string<_Elem, _Traits, _Alloc> _Kty;

 size_t operator()(const _Kty& _Keyval) const
  {
  return (_Hash_seq((const unsigned char *)_Keyval.c_str(),
   _Keyval.size() * sizeof (_Elem)));
  }
 };
}
namespace std {
typedef basic_string<char16_t, char_traits<char16_t>, allocator<char16_t> >
 u16string;
typedef basic_string<char32_t, char_traits<char32_t>, allocator<char32_t> >
 u32string;

}
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\stdexcept"

namespace std {
#line 19 "C:\\src\\winrtl\\include\\dinkumware64\\stdexcept"
class logic_error
 : public ::std:: exception
 {
public:
 explicit logic_error(const string& _Message)
  : _Str(_Message)
  {
  }

 explicit logic_error(const char *_Message)
  : _Str(_Message)
  {
  }

 virtual ~logic_error()
  {
  }

 virtual const char *what() const
  {
  return (_Str.c_str());
  }

private:
 string _Str;




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class domain_error
 : public logic_error
 {
public:
 typedef logic_error _Mybase;

 explicit domain_error(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit domain_error(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class invalid_argument
 : public logic_error
 {
public:
 typedef logic_error _Mybase;

 explicit invalid_argument(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit invalid_argument(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class length_error
 : public logic_error
 {
public:
 typedef logic_error _Mybase;

 explicit length_error(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit length_error(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class out_of_range
 : public logic_error
 {
public:
 typedef logic_error _Mybase;

 explicit out_of_range(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit out_of_range(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class runtime_error
 : public ::std:: exception
 {
public:
 explicit runtime_error(const string& _Message)
  : _Str(_Message)
  {
  }

 explicit runtime_error(const char *_Message)
  : _Str(_Message)
  {
  }

 virtual ~runtime_error()
  {
  }

 virtual const char *what() const
  {
  return (_Str.c_str());
  }

private:
 string _Str;




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class overflow_error
 : public runtime_error
 {
public:
 typedef runtime_error _Mybase;

 explicit overflow_error(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit overflow_error(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class underflow_error
 : public runtime_error
 {
public:
 typedef runtime_error _Mybase;

 explicit underflow_error(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit underflow_error(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };


class range_error
 : public runtime_error
 {
public:
 typedef runtime_error _Mybase;

 explicit range_error(const string& _Message)
  : _Mybase(_Message.c_str())
  {
  }

 explicit range_error(const char *_Message)
  : _Mybase(_Message)
  {
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };
}
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\typeinfo"






#line 1 "C:\\src\\winrtl\\include\\string.h"





#line 1 "C:\\src\\winrtl\\include\\_str.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 1 "C:\\src\\winrtl\\include\\mem.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 6 "C:\\src\\winrtl\\include\\string.h"
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\typeinfo"




#line 1 "C:\\src\\winrtl\\include\\typeinfo.h"
#line 16 "C:\\src\\winrtl\\include\\typeinfo.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 16 "C:\\src\\winrtl\\include\\typeinfo.h"



#line 1 "C:\\src\\winrtl\\include\\cstring"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 1 "C:\\src\\winrtl\\include\\_str.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 1 "C:\\src\\winrtl\\include\\mem.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 19 "C:\\src\\winrtl\\include\\typeinfo.h"








#pragma option -Vt-
#pragma option -RT



typedef struct
{
    unsigned long Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char Data4[ 8 ];
} _BORGUID;







class tpid;

namespace std {

class __declspec(dllexport) __rtti type_info
{

public:

        tpid * tpp;


private:



                        type_info(const type_info &);
    type_info & operator=(const type_info &);

public:
    virtual ~type_info();

    bool operator==(const type_info &) const;
    bool operator!=(const type_info &) const;

    bool before(const type_info &) const;

    const char * name() const;
#line 127 "C:\\src\\winrtl\\include\\typeinfo.h"
};
#line 147 "C:\\src\\winrtl\\include\\typeinfo.h"
class bad_cast : public std::exception {};
class bad_typeid : public std::exception {};

}



typedef std::type_info typeinfo;
typedef std::type_info Type_info;
typedef std::bad_cast Bad_cast;
typedef std::bad_typeid Bad_typeid;

#pragma obsolete typeinfo
#pragma obsolete Type_info
#pragma obsolete Bad_cast
#pragma obsolete Bad_typeid




#pragma option -RT.
#pragma option -Vt.
#line 11 "C:\\src\\winrtl\\include\\dinkumware64\\typeinfo"
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"



#line 1 "C:\\src\\winrtl\\include\\cctype"
#line 10 "C:\\src\\winrtl\\include\\cctype"
#line 1 "C:\\src\\winrtl\\include\\ctype.h"
#line 15 "C:\\src\\winrtl\\include\\ctype.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 15 "C:\\src\\winrtl\\include\\ctype.h"




#line 1 "C:\\src\\winrtl\\include\\mbctype.h"
#line 14 "C:\\src\\winrtl\\include\\mbctype.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\mbctype.h"
#line 25 "C:\\src\\winrtl\\include\\mbctype.h"
extern unsigned char __declspec(dllexport) _mbctype[];
#line 43 "C:\\src\\winrtl\\include\\mbctype.h"
extern "C" {


int __export _setmbcp(int newCodePage);
int __export _getmbcp(void);

int _ismbbkalpha(unsigned int __c);
int _ismbbkpunct(unsigned int __c);
int _ismbbkana (unsigned int __c);
int _ismbbalpha (unsigned int __c);
int _ismbbpunct (unsigned int __c);
int _ismbbalnum (unsigned int __c);
int _ismbbprint (unsigned int __c);
int _ismbbgraph (unsigned int __c);



int _ismbblead (unsigned int __c);
int _ismbbtrail (unsigned int __c);
int _ismbslead (const unsigned char *__s1, const unsigned char *__s2);
int _ismbstrail (const unsigned char *__s1, const unsigned char *__s2);



}
#line 19 "C:\\src\\winrtl\\include\\ctype.h"








namespace std {
#line 37 "C:\\src\\winrtl\\include\\ctype.h"
extern "C" {


extern unsigned short __declspec(dllexport) _chartype[ 257 ];
extern unsigned char __declspec(dllexport) _lower[ 256 ];
extern unsigned char __declspec(dllexport) _upper[ 256 ];

int __export isalnum (int __c);
int __export isalpha (int __c);
int __export isblank (int __c);
int __export iscntrl (int __c);
int __export isdigit (int __c);
int __export isgraph (int __c);
int __export islower (int __c);
int __export isprint (int __c);
int __export ispunct (int __c);
int __export isspace (int __c);
int __export isupper (int __c);
int __export isxdigit(int __c);
int __export isascii (int __c);

int __export iswalnum (std::wint_t __c);
int __export iswalpha (std::wint_t __c);
int __export iswblank (std::wint_t __c);
int __export iswcntrl (std::wint_t __c);
int __export iswdigit (std::wint_t __c);
int __export iswgraph (std::wint_t __c);
int __export iswlower (std::wint_t __c);
int __export iswprint (std::wint_t __c);
int __export iswpunct (std::wint_t __c);
int __export iswspace (std::wint_t __c);
int __export iswupper (std::wint_t __c);
int __export iswxdigit(std::wint_t __c);
int __export iswascii (std::wint_t __c);

}
#line 130 "C:\\src\\winrtl\\include\\ctype.h"
extern "C" {
#line 141 "C:\\src\\winrtl\\include\\ctype.h"
int __export _ltolower(int __ch);
int __export _ltolower_lcid(int __ch, unsigned long __handle);
int __export _ltoupper(int __ch);
int __export _ltoupper_lcid(int __ch, unsigned long __handle);
wchar_t __export _ltowupper(wchar_t __ch);
wchar_t __export _ltowlower(wchar_t __ch);
#line 155 "C:\\src\\winrtl\\include\\ctype.h"
}
#line 168 "C:\\src\\winrtl\\include\\ctype.h"
#pragma option push -vi


__inline

int tolower(int __ch) { return _ltolower(__ch); }


__inline

int toupper(int __ch) { return _ltoupper(__ch); }


__inline

std::wint_t towlower(std::wint_t __ch) { return _ltowlower(__ch); }


__inline

std::wint_t towupper(std::wint_t __ch) { return _ltowupper(__ch); }

#pragma option pop
#line 209 "C:\\src\\winrtl\\include\\ctype.h"
}
#line 10 "C:\\src\\winrtl\\include\\cctype"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"

#line 1 "C:\\src\\winrtl\\include\\clocale"
#line 10 "C:\\src\\winrtl\\include\\clocale"
#line 1 "C:\\src\\winrtl\\include\\_loc.h"
#line 10 "C:\\src\\winrtl\\include\\clocale"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"

#line 1 "C:\\src\\winrtl\\include\\cstdlib"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 1 "C:\\src\\winrtl\\include\\stdlib.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"
#line 1 "C:\\src\\winrtl\\include\\search.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"

#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 522 "C:\\src\\winrtl\\include\\stdlib.h"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 6 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"

#line 1 "C:\\src\\winrtl\\include\\cstring"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 1 "C:\\src\\winrtl\\include\\_str.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 1 "C:\\src\\winrtl\\include\\mem.h"
#line 447 "C:\\src\\winrtl\\include\\_str.h"
#line 10 "C:\\src\\winrtl\\include\\cstring"
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"

#line 1 "C:\\src\\winrtl\\include\\ctime"
#line 10 "C:\\src\\winrtl\\include\\ctime"
#line 1 "C:\\src\\winrtl\\include\\time.h"
#line 14 "C:\\src\\winrtl\\include\\time.h"
#line 1 "C:\\src\\winrtl\\include\\_stddef.h"
#line 14 "C:\\src\\winrtl\\include\\time.h"



namespace std {








#pragma pack(push, 1)








typedef long time_t;
#line 46 "C:\\src\\winrtl\\include\\time.h"
typedef long clock_t;





struct tm
{
  int tm_sec;
  int tm_min;
  int tm_hour;
  int tm_mday;
  int tm_mon;
  int tm_year;
  int tm_wday;
  int tm_yday;
  int tm_isdst;
};


extern "C" {



errno_t __export asctime_s(char *s, rsize_t maxsize, const struct tm *tmPtr);
errno_t __export wasctime_s(wchar_t *s, rsize_t maxsize, const struct tm *tmPtr);
errno_t __export ctime_s(char *s, rsize_t maxsize, const time_t *timer);
errno_t __export wctime_s(wchar_t *s, rsize_t maxsize, const time_t *timer);
struct tm * __export gmtime_s(const time_t * clock,
     struct tm * result);
struct tm * __export localtime_s(const time_t * clock,
        struct tm * result);


char * __export asctime(const struct tm *__tblock);
char * __export ctime(const time_t *__time);
double __export difftime(time_t __time2, time_t __time1);
struct tm * __export gmtime(const time_t *__timer);
struct tm * __export localtime(const time_t *__timer);
time_t __export time(time_t *__timer);
time_t __export mktime(struct tm *__timeptr);
clock_t __export clock(void);
std::size_t __export strftime(char *__s, std::size_t __maxsize,
                                        const char *__fmt, const struct tm *__t);
char * __export strptime(const char *__s,
                                        const char *__fmt, struct tm *__t);
std::size_t __export _lstrftim(char *__s, std::size_t __maxsize,
                                          const char *__fmt, const struct tm *__t);
wchar_t * __export _wasctime(const struct tm *__tblock);
wchar_t * __export _wctime(const time_t *__time);
wchar_t * __export _wstrdate(wchar_t *__datestr);
wchar_t * __export _wstrtime(wchar_t *__timestr);
std::size_t __export wcsftime(wchar_t *__s, std::size_t __maxsize,
                                        const wchar_t *__fmt, const struct tm *__t);
void __export _wtzset(void);

extern int __declspec(dllexport) _daylight;
extern long __declspec(dllexport) _timezone;



extern char * const __declspec(dllexport) _tzname[2];
extern wchar_t * const __declspec(dllexport) _wtzname[2];





extern unsigned char __declspec(dllexport) _PREFER_END_STANDARD_TIME;
extern unsigned char __declspec(dllexport) _PREFER_START_DAYLIGHT_TIME;
#pragma obsolete _PREFER_END_STANDARD_TIME
#pragma obsolete _PREFER_START_DAYLIGHT_TIME

int stime(time_t *__tp);
void __export _tzset(void);
char * __export _strdate(char *__datestr);
char * __export _strtime(char *__timestr);


void __export tzset(void);


unsigned int __export _getsystime(struct tm *__timeptr);
unsigned int __export _setsystime(struct tm *__timeptr, unsigned int __ms);




}






#pragma pack(pop)








}
#line 10 "C:\\src\\winrtl\\include\\ctime"
#line 8 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"


#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo.h"



#line 1 "C:\\src\\winrtl\\include\\locale.h"





#line 1 "C:\\src\\winrtl\\include\\_loc.h"
#line 123 "C:\\src\\winrtl\\include\\_loc.h"
    using std::lconv;
    using std::_lsetlocale;
    using std::_lsetlocale;
    using std::localeconv;
    using std::_llocaleconv;
    using std::_wsetlocale;
    using std::_lwsetlocale;
#line 6 "C:\\src\\winrtl\\include\\locale.h"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo.h"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\yvals.h"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo.h"

namespace std {
extern "C" {
#line 66 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo.h"
typedef struct _Collvec
 {
 unsigned long _Hand;
 unsigned int _Page;
 } _Collvec;

typedef struct _Ctypevec
 {
 unsigned long _Hand;
 unsigned int _Page;
 const short *_Table;
 int _Delfl;
 } _Ctypevec;

typedef struct _Cvtvec
 {
 unsigned long _Hand;
 unsigned int _Page;
 } _Cvtvec;


__declspec(dllexport) const short *_Getctyptab();
extern __declspec(dllexport) float _Stof(const char *, char **, long);
extern __declspec(dllexport) double _Stod(const char *, char **, long);
extern __declspec(dllexport) long double _Stold(const char *, char **, long);
}
}
#line 10 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"


namespace std {
#line 36 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"
class __declspec(dllexport) _Timevec
 {
public:
 void *_Getptr() const
  {
  return (0);
  }
 char _Pad;
 };


class __declspec(dllexport) _Locinfo
 {
public:
 typedef ::std:: _Collvec _Collvec;
 typedef ::std:: _Ctypevec _Ctypevec;
 typedef ::std:: _Cvtvec _Cvtvec;

 typedef ::std:: _Timevec _Timevec;

 _Locinfo(const char * = "C");
 _Locinfo(const string&);
 _Locinfo(int, const char *);

 ~_Locinfo() ;

 _Locinfo& _Addcats(int, const char *);

 const char *_Getname() const
  {
  return (_Newlocname.c_str());
  }

 _Collvec _Getcoll() const
  {
  _Collvec _Vec = {0};
  return (_Vec);
  }

 _Ctypevec _Getctype() const
  {
  _Ctypevec _Vec = {_Handle, _Page};
  _Vec._Table = ::std:: _Getctyptab();
  _Vec._Delfl = 1;
  return (_Vec);
  }

 _Cvtvec _Getcvt() const
  {
  _Cvtvec _Vec = {_Handle, _Page};
  return (_Vec);
  }

 const lconv *_Getlconv() const
  {
  return (localeconv());
  }

 _Timevec _Gettnames() const
  {
  _Timevec _Vec = {0};
  return (_Vec);
  }

 const char *_Getdays() const
  {
  return (":Sun:Sunday:Mon:Monday:Tue:Tuesday:Wed:Wednesday"
   ":Thu:Thursday:Fri:Friday:Sat:Saturday");
  }

 const char *_Getmonths() const
  {
  return (":Jan:January:Feb:February:Mar:March"
   ":Apr:April:May:May:Jun:June"
   ":Jul:July:Aug:August:Sep:September"
   ":Oct:October:Nov:November:Dec:December");
  }

 const char *_Getfalse() const
  {
  return ("false");
  }

 const char *_Gettrue() const
  {
  return ("true");
  }

private:

 _Yarn<char> _Oldlocname;
 _Yarn<char> _Newlocname;
 unsigned long _Handle;
 unsigned int _Page;
 };


template<class _Elem> inline
 int _LStrcoll(const _Elem *_First1, const _Elem *_Last1,
  const _Elem *_First2, const _Elem *_Last2, const _Collvec *)
 {
 for (; _First1 != _Last1 && _First2 != _Last2; ++_First1, ++_First2)
  if (*_First1 < *_First2)
   return (-1);
  else if (*_First2 < *_First1)
   return (+1);
 return (_First2 != _Last2 ? -1 : _First1 != _Last1 ? +1 : 0);
 }


template<class _Elem> inline
 size_t _LStrxfrm(_Elem *_First1, _Elem *_Last1,
  const _Elem *_First2, const _Elem *_Last2,
   const _Locinfo::_Collvec *)
 {
 size_t _Count = _Last2 - _First2;

 if (_Count <= (size_t)(_Last1 - _First1))
  ::std:: memcpy(_First1, _First2, _Count * sizeof (_Elem));
 return (_Count);
 }


inline int _Mbrtowc(wchar_t *_Wptr, const char *_Ptr, size_t _Count,
 mbstate_t *_Pstate, const _Cvtvec *_Cvt)
 {



 return (::std:: mbrtowc_cp(_Wptr, _Ptr, _Count, (mbstate_t *)_Pstate, _Cvt->_Page));

 }


inline size_t _Strftime(char *_Ptr, size_t _Count, const char *_Format,
 const struct tm *_Ptime, void *)
 {
 return (::std:: strftime(_Ptr, _Count, _Format, _Ptime));
 }


inline int _Tolower(int _Byte, const _Ctypevec *_Ct)
 {



 return (::std:: _ltolower_lcid(_Byte & 0xff, _Ct->_Hand));

 }


inline int _Toupper(int _Byte, const _Ctypevec *_Ct)
 {



 return (::std:: _ltoupper_lcid(_Byte & 0xff, _Ct->_Hand));

 }


inline int _Wcrtomb(char *_Ptr, wchar_t _Char,
 mbstate_t *_Pstate, const _Cvtvec *_Cvt)
 {



 return (::std:: wcrtomb_cp(_Ptr, _Char, _Pstate, _Cvt->_Page));

 }
#line 230 "C:\\src\\winrtl\\include\\dinkumware64\\xlocinfo"
}
#line 8 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"

#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\xdebug"
#line 9 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
#line 18 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
namespace std {
extern "C" {
__declspec(dllexport) void * _Getgloballocale();
__declspec(dllexport) void _Setgloballocale(void *);
}
}

namespace std {

class __declspec(dllexport) _Facet_base
 {
public:
 virtual ~_Facet_base()
  {
  }

 virtual void _Incref() = 0;
 virtual _Facet_base * _Decref() = 0;
 };


template<class _Dummy>
 class __declspec(dllexport) _Locbase
 {
public:
 static const int collate = (1 << ((0) - (0 < 1 ? 0 : 1)));
 static const int ctype = (1 << ((1) - (0 < 1 ? 0 : 1)));
 static const int monetary = (1 << ((2) - (0 < 1 ? 0 : 1)));
 static const int numeric = (1 << ((3) - (0 < 1 ? 0 : 1)));
 static const int time = (1 << ((4) - (0 < 1 ? 0 : 1)));
 static const int messages = (1 << ((5) - (0 < 1 ? 0 : 1)));
 static const int all = ((1 << (((5 + 1)) - (0 < 1 ? 0 : 1))) - 1);
 static const int none = 0;
 };

template<class _Dummy>
 const int _Locbase<_Dummy>::collate;
template<class _Dummy>
 const int _Locbase<_Dummy>::ctype;
template<class _Dummy>
 const int _Locbase<_Dummy>::monetary;
template<class _Dummy>
 const int _Locbase<_Dummy>::numeric;
template<class _Dummy>
 const int _Locbase<_Dummy>::time;
template<class _Dummy>
 const int _Locbase<_Dummy>::messages;
template<class _Dummy>
 const int _Locbase<_Dummy>::all;
template<class _Dummy>
 const int _Locbase<_Dummy>::none;


class locale;
template<class _Facet>
 const _Facet& use_facet(const locale&);
template<class _Elem>
 class collate;

class __declspec(dllexport) locale
 : public _Locbase<int>
 {
public:
 typedef int category;


 class __declspec(dllexport) id
  {
 public:
         id(size_t _Val = 0)
   : _Id(_Val)
   {
   }

         operator size_t()
   {
   if (_Id == 0)
    {
    {
     if (_Id == 0)
      _Id = ++_Id_cnt;
    }
    }
   return (_Id);
   }

 private:
  size_t _Id;

  static int _Id_cnt;







         id(const id&);
  id& operator=(const id&);

  };

 class _Locimp;


 class __declspec(dllexport) facet
  : public _Facet_base
  {
  friend class locale;
  friend class _Locimp;

 public:
  static size_t _Getcat(const facet ** = 0,
   const locale * = 0)
   {
   return ((size_t)(-1));
   }

  void _Register();

  virtual void _Incref()
   {
   (++_Refs);
   }

  virtual _Facet_base * _Decref()
   {
   if ((--_Refs) == 0)
    return (this);
   else
    return (0);
   }
#line 172 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
 private:
  long _Refs;
#line 192 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
 protected:
  explicit facet(size_t _Initrefs = 0)
   : _Refs((long)_Initrefs)
   {
   }

 public:
  virtual ~facet()
   {
   }


  bool _Shared() const
   {
   return (1 < _Refs);
   }
#line 216 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
  private:
          facet(const facet&);

  };



 class __declspec(dllexport) _Locimp
  : public facet
  {
 protected:
         ~_Locimp() ;

 private:
  friend class locale;

  static _Locimp * _New_Locimp(bool _Transparent = false)
   {
   return (new _Locimp(_Transparent));
   }

  static _Locimp * _New_Locimp(const _Locimp& _Right)
   {
   return (new _Locimp(_Right));
   }

         _Locimp(bool _Transparent = false);

         _Locimp(const _Locimp&);

  void _Addfac(facet *, size_t);

  static _Locimp * _Makeloc(const _Locinfo&,
   category, _Locimp *, const locale *);

  static void _Makewloc(const _Locinfo&,
   category, _Locimp *, const locale *);

  static void _Makexloc(const _Locinfo&,
   category, _Locimp *, const locale *);

  facet **_Facetvec;
  size_t _Facetcount;
  category _Catmask;
  bool _Xparent;

  _Yarn<char> _Name;

  static _Locimp *_Clocptr;
  };

             locale& _Addfac(facet *_Fac, size_t _Id,
  size_t _Catmask)
  {
  if (_Ptr->_Shared())
   {
   _Ptr->_Decref();
   _Ptr = _Locimp::_New_Locimp(*_Ptr);
   }
  _Ptr->_Addfac(_Fac, _Id);

  if (_Catmask != 0)
   _Ptr->_Name = "*";
  return (*this);
  }

 template<class _Elem,
  class _Traits,
  class _Alloc>
  bool operator()(const basic_string<_Elem, _Traits, _Alloc>&,
   const basic_string<_Elem, _Traits, _Alloc>&)
    const;

 template<class _Facet>
  locale combine(const locale& _Loc) const
  {
  _Facet *_Facptr;

  {{
   _Facptr = (_Facet *)&use_facet<_Facet>(_Loc);
  } if (0) {
   _Xruntime_error("locale::combine facet missing");
  }}

  _Locimp *_Newimp = _Locimp::_New_Locimp(*_Ptr);
  _Newimp->_Addfac(_Facptr, _Facet::id);
  _Newimp->_Catmask = 0;
  _Newimp->_Name = "*";
  return (locale(_Newimp));
  }

 template<class _Facet>
  locale(const locale& _Loc, const _Facet *_Facptr)
   : _Ptr(_Locimp::_New_Locimp(*_Loc._Ptr))
  {
  if (_Facptr != 0)
   {
   _Ptr->_Addfac((_Facet *)_Facptr, _Facet::id);
   if (_Facet::_Getcat() != (size_t)(-1))
    {
    _Ptr->_Catmask = 0;
    _Ptr->_Name = "*";
    }
   }
  }

 locale(_Uninitialized)
  {
  }
#line 347 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
 locale(const locale& _Right)
  : _Ptr(_Right._Ptr)
  {
  _Ptr->_Incref();
  }

 locale()
  : _Ptr(_Init(true))
  {
  }


 locale(const locale& _Loc, const locale& _Other,
  category _Cat)
  : _Ptr(_Locimp::_New_Locimp(*_Loc._Ptr))
  {
  {{
  { _Locinfo _Lobj(_Loc._Ptr->_Catmask, _Loc._Ptr->_Name.c_str());
   _Locimp::_Makeloc(_Lobj._Addcats(_Cat & _Other._Ptr->_Catmask,
    _Other._Ptr->_Name.c_str()), _Cat, _Ptr, &_Other);
  }
  } if (0) {
  delete (_Ptr->_Decref());
          ;
  }}
  }

private:
 void _Construct(const string &_Str,
  category _Cat)
  {
  bool _Bad = false;
  {{
  _Init();
  { _Locinfo _Lobj(_Cat, _Str.c_str());
   if (_Badname(_Lobj))
    _Bad = true;
   else
    _Locimp::_Makeloc(_Lobj, _Cat, _Ptr, 0);
  }
  } if (0) {
  delete (_Ptr->_Decref());
          ;
  }}

  if (_Bad)
   {
   delete (_Ptr->_Decref());
   _Xruntime_error("bad locale name");
   }
  }

 void _Construct(const locale& _Loc, const string &_Str,
  category _Cat)
  {
  bool _Bad = false;
  {{
  { _Locinfo _Lobj(_Loc._Ptr->_Catmask, _Loc._Ptr->_Name.c_str());
   bool _Hadname = !_Badname(_Lobj);
   _Lobj._Addcats(_Cat, _Str.c_str());

   if (_Hadname && _Badname(_Lobj))
    _Bad = true;
   else
    _Locimp::_Makeloc(_Lobj, _Cat, _Ptr, 0);
  }
  } if (0) {
  delete (_Ptr->_Decref());
          ;
  }}

  if (_Bad)
   {
   delete (_Ptr->_Decref());
   _Xruntime_error("bad locale name");
   }
  }

public:
 explicit locale(const char *_Locname,
  category _Cat = all)
  : _Ptr(_Locimp::_New_Locimp())
  {


  if (_Locname == 0)
   _Xruntime_error("bad locale name");
  _Construct(_Locname, _Cat);
  }

 locale(const locale& _Loc, const char *_Locname,
  category _Cat)
  : _Ptr(_Locimp::_New_Locimp(*_Loc._Ptr))
  {


  if (_Locname == 0)
   _Xruntime_error("bad locale name");
  _Construct(_Loc, _Locname, _Cat);
  }


 explicit locale(const string& _Str,
  category _Cat = all)
  : _Ptr(_Locimp::_New_Locimp())
  {
  _Construct(_Str, _Cat);
  }

 locale(const locale& _Loc, const string& _Str,
  category _Cat)
  : _Ptr(_Locimp::_New_Locimp(*_Loc._Ptr))
  {
  _Construct(_Loc, _Str, _Cat);
  }




 ~locale()
  {
  if (_Ptr != 0)
   delete (_Ptr->_Decref());
  }

 locale& operator=(const locale& _Right)
  {
  if (_Ptr != _Right._Ptr)
   {
   delete (_Ptr->_Decref());
   _Ptr = _Right._Ptr;
   _Ptr->_Incref();
   }
  return (*this);
  }


 string name() const
  {
  return (_Ptr == 0 ? string() : _Ptr->_Name.c_str());
  }

 const char *c_str() const
  {
  return (_Ptr == 0 ? "" : _Ptr->_Name.c_str());
  }

 const facet *_Getfacet(size_t _Id) const
  {
  const facet *_Facptr = _Id < _Ptr->_Facetcount
   ? _Ptr->_Facetvec[_Id] : 0;
  if (_Facptr != 0 || !_Ptr->_Xparent)
   return (_Facptr);
  else
   {
   locale::_Locimp *_Ptr = _Getgloballocale();
   return (_Id < _Ptr->_Facetcount
    ? _Ptr->_Facetvec[_Id]
    : 0);
   }
  }

 bool operator==(const locale& _Loc) const
  {
  return (_Ptr == _Loc._Ptr
   || (name().compare("*") != 0
    && name().compare(_Loc.name()) == 0));
  }

 bool operator!=(const locale& _Right) const
  {
  return (!(*this == _Right));
  }

 static __declspec(dllexport) const locale& classic();

 static __declspec(dllexport) locale global(const locale&);

 static __declspec(dllexport) locale empty();

private:
 locale(_Locimp *_Ptrimp)
  : _Ptr(_Ptrimp)
  {
  }

 static __declspec(dllexport) _Locimp * _Init(
  bool _Do_incref = false);
 static __declspec(dllexport) _Locimp * _Getgloballocale();
 static __declspec(dllexport) void _Setgloballocale(void *);

 bool _Badname(const _Locinfo& _Lobj)
  {
  return (::std:: strcmp(_Lobj._Getname(), "*") == 0);
  }

 _Locimp *_Ptr;
 };
#line 567 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
template<class _Facet>
 struct _Facetptr
 {
 static const locale::facet *_Psave;
 };

template<class _Facet>
 const locale::facet *_Facetptr<_Facet>::
  _Psave = 0;






template<class _Facet> inline
 const _Facet& use_facet(const locale& _Loc)

 {





 {
  const locale::facet *_Psave =
   _Facetptr<_Facet>::_Psave;

  size_t _Id = _Facet::id;
  const locale::facet *_Pf = _Loc._Getfacet(_Id);

  if (_Pf != 0)
   ;
  else if (_Psave != 0)
   _Pf = _Psave;
  else if (_Facet::_Getcat(&_Psave, &_Loc) == (size_t)(-1))





   abort();


  else
   {
   _Pf = _Psave;
   _Facetptr<_Facet>::_Psave = _Psave;

   locale::facet *_Pfmod = (_Facet *)_Psave;
   _Pfmod->_Incref();
   _Pfmod->_Register();
   }

  return ((const _Facet&)(*_Pf));
 }

 }


template<class _Elem,
 class _InIt> inline
 int _Getloctxt(_InIt& _First, _InIt& _Last, size_t _Numfields,
  const _Elem *_Ptr)
 {
 for (size_t _Off = 0; _Ptr[_Off] != (_Elem)0; ++_Off)
  if (_Ptr[_Off] == _Ptr[0])
   ++_Numfields;
 string _Str(_Numfields, '\0');

 int _Ans = -2;
 for (size_t _Column = 1; ; ++_Column, ++_First, _Ans = -1)
  {
  bool _Prefix = false;
  size_t _Off = 0;
  size_t _Field = 0;

  for (; _Field < _Numfields; ++_Field)
   {
   for (; _Ptr[_Off] != (_Elem)0 && _Ptr[_Off] != _Ptr[0]; ++_Off)
    ;

   if (_Str[_Field] != '\0')
    _Off += _Str[_Field];
   else if (_Ptr[_Off += _Column] == _Ptr[0]
    || _Ptr[_Off] == (_Elem)0)
    {
    _Str[_Field] = (char)(_Column < 127
     ? _Column : 127);
    _Ans = (int)_Field;
    }
   else if (_First == _Last || _Ptr[_Off] != *_First)
    _Str[_Field] = (char)(_Column < 127
     ? _Column : 127);
   else
    _Prefix = true;
   }

  if (!_Prefix || _First == _Last)
   break;
  }
 return (_Ans);
 }





template<class _Elem> inline
 char _Maklocbyte(_Elem _Char,
  const _Locinfo::_Cvtvec&)
 {
 return ((char)(unsigned char)_Char);
 }

template<> inline
 char _Maklocbyte(wchar_t _Char,
  const _Locinfo::_Cvtvec& _Cvt)
 {
 char _Byte = '\0';
 _Mbstatet _Mbst1 = {0};
 _Wcrtomb(&_Byte, _Char, &_Mbst1, &_Cvt);
 return (_Byte);
 }





template<class _Elem> inline
 _Elem _Maklocchr(char _Byte, _Elem *,
  const _Locinfo::_Cvtvec&)
 {
 return ((_Elem)(unsigned char)_Byte);
 }

template<> inline
 wchar_t _Maklocchr(char _Byte, wchar_t *,
  const _Locinfo::_Cvtvec& _Cvt)
 {
 wchar_t _Wc = L'\0';
 _Mbstatet _Mbst1 = {0};
 _Mbrtowc(&_Wc, &_Byte, 1, &_Mbst1, &_Cvt);
 return (_Wc);
 }





template<class _Elem> inline
 _Elem * _Maklocstr(const char *_Ptr, _Elem *,
  const _Locinfo::_Cvtvec&)
 {
 size_t _Count = ::std:: strlen(_Ptr) + 1;
 _Elem *_Ptrdest = new _Elem[_Count];

 for (_Elem *_Ptrnext = _Ptrdest; 0 < _Count; --_Count, ++_Ptrnext, ++_Ptr)
  *_Ptrnext = (_Elem)(unsigned char)*_Ptr;
 return (_Ptrdest);
 }

template<> inline
 wchar_t * _Maklocstr(const char *_Ptr, wchar_t *,
  const _Locinfo::_Cvtvec& _Cvt)
 {
 size_t _Count, _Count1;
 size_t _Wchars;
 const char *_Ptr1;
 int _Bytes;
 wchar_t _Wc;
 _Mbstatet _Mbst1 = {0};

 _Count1 = ::std:: strlen(_Ptr) + 1;
 for (_Count = _Count1, _Wchars = 0, _Ptr1 = _Ptr; 0 < _Count;
  _Count -= _Bytes, _Ptr1 += _Bytes, ++_Wchars)
  if ((_Bytes = _Mbrtowc(&_Wc, _Ptr1, _Count, &_Mbst1, &_Cvt)) <= 0)
   break;
 ++_Wchars;

 wchar_t *_Ptrdest = new wchar_t[_Wchars];
 wchar_t *_Ptrnext = _Ptrdest;
 _Mbstatet _Mbst2 = {0};

 for (; 0 < _Wchars;
  _Count -= _Bytes, _Ptr += _Bytes, --_Wchars, ++_Ptrnext)
  if ((_Bytes = _Mbrtowc(_Ptrnext, _Ptr, _Count1, &_Mbst2, &_Cvt)) <= 0)
   break;
 *_Ptrnext = L'\0';
 return (_Ptrdest);
 }



class __declspec(dllexport) codecvt_base
 : public locale::facet
 {
public:
 enum
  {
  ok, partial, error, noconv};
 typedef int result;

        codecvt_base(size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  }

 bool always_noconv() const
  {
  return (do_always_noconv());
  }

 int max_length() const
  {
  return (do_max_length());
  }

 int encoding() const
  {
  return (do_encoding());
  }

        ~codecvt_base()
  {
  }

protected:
 virtual bool do_always_noconv() const
  {
  return (false);
  }

 virtual int do_max_length() const
  {
  return (1);
  }

 virtual int do_encoding() const
  {
  return (1);
  }
 };


template<class _Elem,
 class _Byte,
 class _Statype>
 class codecvt
  : public codecvt_base
 {
public:
 typedef _Elem intern_type;
 typedef _Byte extern_type;
 typedef _Statype state_type;

 result in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  return (do_in(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_out(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result unshift(_Statype& _State,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_unshift(_State, _First2, _Last2, _Mid2));
  }

 int length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  return (do_length(_State, _First1, _Last1, _Count));
  }

 static locale::id id;

 explicit codecvt(size_t _Refs = 0)
  : codecvt_base(_Refs)
  {
  _Init(_Locinfo());
  }

        codecvt(const _Locinfo& _Lobj, size_t _Refs = 0)
  : codecvt_base(_Refs)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new codecvt<_Elem, _Byte, _Statype>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

protected:
 virtual ~codecvt()
  {
  }

 void _Init(const _Locinfo&)
  {
  }

 virtual bool do_always_noconv() const
  {
  return (is_same<_Byte, _Elem>::value);
  }

 virtual result do_in(_Statype&,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  _Mid1 = _First1, _Mid2 = _First2;
  if (is_same<_Byte, _Elem>::value)
   return (noconv);
  else
   {
   for (; _Mid1 != _Last1 && _Mid2 != _Last2; ++_Mid1, ++_Mid2)
    *_Mid2 = (_Elem)*_Mid1;
   return (ok);
   }
  }

 virtual result do_out(_Statype&,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  _Mid1 = _First1, _Mid2 = _First2;
  if (is_same<_Byte, _Elem>::value)
   return (noconv);
  else
   {
   for (; _Mid1 != _Last1 && _Mid2 != _Last2; ++_Mid1, ++_Mid2)
    *_Mid2 = (_Byte)*_Mid1;
   return (ok);
   }
  }

 virtual result do_unshift(_Statype&,
  _Byte *_First2, _Byte *, _Byte *&_Mid2) const
  {
  _Mid2 = _First2;
  return (ok);
  }

 virtual int do_length(_Statype&, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  return ((int)(_Count < (size_t)(_Last1 - _First1)
   ? _Count : _Last1 - _First1));
  }
 };


template<class _Elem,
 class _Byte,
 class _Statype>
 locale::id codecvt<_Elem, _Byte, _Statype>::id;



enum _Codecvt_mode {
 _Consume_header = 4,
 _Generate_header = 2
 };


template<>
 class __declspec(dllexport) codecvt<char16_t, char, _Mbstatet>
 : public codecvt_base
 {
public:
 typedef codecvt<char16_t, char, _Mbstatet> _Mybase;
 typedef char16_t _Elem;
 typedef char _Byte;
 typedef _Mbstatet _Statype;
 typedef _Elem intern_type;
 typedef _Byte extern_type;
 typedef _Statype state_type;

 result in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  return (do_in(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_out(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result unshift(_Statype& _State,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_unshift(_State,
   _First2, _Last2, _Mid2));
  }

 int length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  return (do_length(_State, _First1, _Last1, _Count));
  }

 static locale::id id;

 explicit codecvt(size_t _Refs = 0)
  : codecvt_base(_Refs), _Maxcode(0x10ffff), _Mode(_Consume_header)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        codecvt(const _Locinfo& _Lobj, size_t _Refs = 0)
  : codecvt_base(_Refs), _Maxcode(0x10ffff), _Mode(_Consume_header)
  {
  _Init(_Lobj);
  }

        codecvt(const _Locinfo& _Lobj, unsigned long _Maxcode_arg,
  _Codecvt_mode _Mode_arg, size_t _Refs = 0)
  : codecvt_base(_Refs), _Maxcode(_Maxcode_arg), _Mode(_Mode_arg)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new codecvt<_Elem, _Byte, _Statype>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

protected:
 virtual ~codecvt()
  {
  }

 void _Init(const _Locinfo&)
  {
  }

 virtual result do_in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  unsigned short *_Pstate = (unsigned short *)&_State;
  _Mid1 = _First1;
  _Mid2 = _First2;

  for (; _Mid1 != _Last1 && _Mid2 != _Last2; )
   {
   unsigned char _By = (unsigned char)*_Mid1;
   unsigned long _Ch;
   int _Nextra, _Nskip;

   if (*_Pstate <= 1)
    ;
   else if (_By < 0x80 || 0xc0 <= _By)
    return (_Mybase::error);
   else
    {
    ++_Mid1;
    *_Mid2++ = (_Elem)(*_Pstate | (_By & 0x3f));
    *_Pstate = 1;
    continue;
    }

   if (_By < 0x80)
    _Ch = _By, _Nextra = 0;
   else if (_By < 0xc0)
    {
    ++_Mid1;
    return (_Mybase::error);
    }
   else if (_By < 0xe0)
    _Ch = _By & 0x1f, _Nextra = 1;
   else if (_By < 0xf0)
    _Ch = _By & 0x0f, _Nextra = 2;
   else if (_By < 0xf8)
    _Ch = _By & 0x07, _Nextra = 3;
   else
    _Ch = _By & 0x03, _Nextra = _By < 0xfc ? 4 : 5;

   _Nskip = _Nextra < 3 ? 0 : 1;
   _First1 = _Mid1;

   if (_Nextra == 0)
    ++_Mid1;
   else if (_Last1 - _Mid1 < _Nextra + 1 - _Nskip)
    break;
   else
    for (++_Mid1; _Nskip < _Nextra; --_Nextra, ++_Mid1)
     if ((_By = (unsigned char)*_Mid1) < 0x80 || 0xc0 <= _By)
      return (_Mybase::error);
     else
      _Ch = _Ch << 6 | (_By & 0x3f);
   if (0 < _Nskip)
    _Ch <<= 6;

   if ((_Maxcode < 0x10ffff ? _Maxcode : 0x10ffff) < _Ch)
    return (_Mybase::error);
   else if (0xffff < _Ch)
    {
    unsigned short _Ch0 =
     (unsigned short)(0xd800 | (_Ch >> 10) - 0x0040);

    *_Mid2++ = (_Elem)_Ch0;
    *_Pstate = (unsigned short)(0xdc00 | (_Ch & 0x03ff));
    continue;
    }

   if (_Nskip == 0)
    ;
   else if (_Mid1 == _Last1)
    {
    _Mid1 = _First1;
    break;
    }
   else if ((_By = (unsigned char)*_Mid1++) < 0x80 || 0xc0 <= _By)
    return (_Mybase::error);
   else
    _Ch |= _By & 0x3f;

   if (*_Pstate == 0)
    {
    *_Pstate = 1;

    if ((_Mode & _Consume_header) != 0 && _Ch == 0xfeff)
     {
     result _Ans = do_in(_State, _Mid1, _Last1, _Mid1,
      _First2, _Last2, _Mid2);

     if (_Ans == _Mybase::partial)
      {
      *_Pstate = 0;
      _Mid1 = _First1;
      }
     return (_Ans);
     }
    }

   *_Mid2++ = (_Elem)_Ch;
   }

  return (_First1 == _Mid1 ? _Mybase::partial : _Mybase::ok);
  }

 virtual result do_out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  unsigned short *_Pstate = (unsigned short *)&_State;
  _Mid1 = _First1;
  _Mid2 = _First2;

  for (; _Mid1 != _Last1 && _Mid2 != _Last2; )
   {
   unsigned long _Ch;
   unsigned short _Ch1 = (unsigned short)*_Mid1;
   bool _Save = false;

   if (1 < *_Pstate)
    {
    if (_Ch1 < 0xdc00 || 0xe000 <= _Ch1)
     return (_Mybase::error);
    _Ch = (*_Pstate << 10) | (_Ch1 - 0xdc00);
    }
   else if (0xd800 <= _Ch1 && _Ch1 < 0xdc00)
    {
    _Ch = (_Ch1 - 0xd800 + 0x0040) << 10;
    _Save = true;
    }
   else
    _Ch = _Ch1;

   _Byte _By;
   int _Nextra;

   if (_Ch < 0x0080)
    _By = (_Byte)_Ch, _Nextra = 0;
   else if (_Ch < 0x0800)
    _By = (_Byte)(0xc0 | _Ch >> 6), _Nextra = 1;
   else if (_Ch < 0x10000)
    _By = (_Byte)(0xe0 | _Ch >> 12), _Nextra = 2;
   else
    _By = (_Byte)(0xf0 | _Ch >> 18), _Nextra = 3;

   int _Nput = _Nextra < 3 ? _Nextra + 1 : _Save ? 1 : 3;

   if (_Last2 - _Mid2 < _Nput)
    break;
   else if (*_Pstate != 0 || (_Mode & _Generate_header) == 0)
    ;
   else if (_Last2 - _Mid2 < 3 + _Nput)
    break;
   else
    {
    *_Mid2++ = (_Byte)(unsigned char)0xef;
    *_Mid2++ = (_Byte)(unsigned char)0xbb;
    *_Mid2++ = (_Byte)(unsigned char)0xbf;
    }

   ++_Mid1;
   if (_Save || _Nextra < 3)
    {
    *_Mid2++ = _By;
    --_Nput;
    }
   for (; 0 < _Nput; --_Nput)
    *_Mid2++ = (_Byte)((_Ch >> 6 * --_Nextra & 0x3f) | 0x80);

   *_Pstate = (unsigned short)(_Save ? _Ch >> 10 : 1);
   }

  return (_First1 == _Mid1 ? _Mybase::partial : _Mybase::ok);
  }

 virtual result do_unshift(_Statype& _State,
  _Byte *_First2, _Byte *, _Byte *& _Mid2) const
  {
  unsigned short *_Pstate = (unsigned short *)&_State;
  _Mid2 = _First2;

  return (1 < *_Pstate
   ? _Mybase::error : _Mybase::ok);
  }

 virtual int do_length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  size_t _Wchars = 0;
  _Statype _Mystate = _State;

  for (; _Wchars < _Count && _First1 != _Last1; )
   {
   const _Byte *_Mid1;
   _Elem *_Mid2;
   _Elem _Ch;

   switch (do_in(_Mystate, _First1, _Last1, _Mid1,
    &_Ch, &_Ch + 1, _Mid2))
    {
   case _Mybase::noconv:
    return ((int)(_Wchars + (_Last1 - _First1)));

   case _Mybase::ok:
    if (_Mid2 == &_Ch + 1)
     ++_Wchars;
    _First1 = _Mid1;
    break;

   default:
    return ((int)_Wchars);
    }
   }

  return ((int)_Wchars);
  }

 virtual bool do_always_noconv() const
  {
  return (false);
  }

 virtual int do_max_length() const
  {
  return ((_Mode & _Consume_header) != 0 ? 9
   : (_Mode & _Generate_header) != 0 ? 7
   : 6);
  }

 virtual int do_encoding() const
  {
  return (0);
  }

private:
 unsigned long _Maxcode;
 _Codecvt_mode _Mode;
 };


template<>
 class __declspec(dllexport) codecvt<char32_t, char, _Mbstatet>
 : public codecvt_base
 {
public:
 typedef codecvt<char32_t, char, _Mbstatet> _Mybase;
 typedef char32_t _Elem;
 typedef char _Byte;
 typedef _Mbstatet _Statype;
 typedef _Elem intern_type;
 typedef _Byte extern_type;
 typedef _Statype state_type;

 result in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  return (do_in(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_out(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result unshift(_Statype& _State,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_unshift(_State,
   _First2, _Last2, _Mid2));
  }

 int length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  return (do_length(_State, _First1, _Last1, _Count));
  }

 static locale::id id;

 explicit codecvt(size_t _Refs = 0)
  : codecvt_base(_Refs), _Maxcode(0xffffffff), _Mode(_Consume_header)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        codecvt(const _Locinfo& _Lobj, size_t _Refs = 0)
  : codecvt_base(_Refs), _Maxcode(0xffffffff), _Mode(_Consume_header)
  {
  _Init(_Lobj);
  }

        codecvt(const _Locinfo& _Lobj, unsigned long _Maxcode_arg,
  _Codecvt_mode _Mode_arg, size_t _Refs = 0)
  : codecvt_base(_Refs), _Maxcode(_Maxcode_arg), _Mode(_Mode_arg)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new codecvt<_Elem, _Byte, _Statype>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

protected:
 virtual ~codecvt()
  {
  }

 void _Init(const _Locinfo&)
  {
  }

 virtual result do_in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  char *_Pstate = (char *)&_State;
  _Mid1 = _First1;
  _Mid2 = _First2;

  for (; _Mid1 != _Last1 && _Mid2 != _Last2; )
   {
   unsigned char _By = (unsigned char)*_Mid1;
   unsigned long _Ch;
   int _Nextra;

   if (_By < 0x80)
    _Ch = _By, _Nextra = 0;
   else if (_By < 0xc0)
    {
    ++_Mid1;
    return (_Mybase::error);
    }
   else if (_By < 0xe0)
    _Ch = _By & 0x1f, _Nextra = 1;
   else if (_By < 0xf0)
    _Ch = _By & 0x0f, _Nextra = 2;
   else if (_By < 0xf8)
    _Ch = _By & 0x07, _Nextra = 3;
   else
    _Ch = _By & 0x03, _Nextra = _By < 0xfc ? 4 : 5;

   if (_Nextra == 0)
    ++_Mid1;
   else if (_Last1 - _Mid1 < _Nextra + 1)
    break;
   else
    for (++_Mid1; 0 < _Nextra; --_Nextra, ++_Mid1)
     if ((_By = (unsigned char)*_Mid1) < 0x80 || 0xc0 <= _By)
      return (_Mybase::error);
     else
      _Ch = _Ch << 6 | (_By & 0x3f);

   if (*_Pstate == 0)
    {
    *_Pstate = 1;

    if ((_Mode & _Consume_header) != 0 && _Ch == 0xfeff)
     {
     result _Ans = do_in(_State, _Mid1, _Last1, _Mid1,
      _First2, _Last2, _Mid2);

     if (_Ans == _Mybase::partial)
      {
      *_Pstate = 0;
      _Mid1 = _First1;
      }
     return (_Ans);
     }
    }

   if (_Maxcode < _Ch)
    return (_Mybase::error);
   *_Mid2++ = (_Elem)_Ch;
   }

  return (_First1 == _Mid1 ? _Mybase::partial : _Mybase::ok);
  }

 virtual result do_out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  char *_Pstate = (char *)&_State;
  _Mid1 = _First1;
  _Mid2 = _First2;

  for (; _Mid1 != _Last1 && _Mid2 != _Last2; )
   {
   _Byte _By;
   int _Nextra;
   unsigned long _Ch = (unsigned long)*_Mid1;

   if (_Maxcode < _Ch)
    return (_Mybase::error);

   if (_Ch < 0x0080)
    _By = (_Byte)_Ch, _Nextra = 0;
   else if (_Ch < 0x0800)
    _By = (_Byte)(0xc0 | _Ch >> 6), _Nextra = 1;
   else if (_Ch < 0x00010000)
    _By = (_Byte)(0xe0 | _Ch >> 12), _Nextra = 2;
   else if (_Ch < 0x00200000)
    _By = (_Byte)(0xf0 | _Ch >> 18), _Nextra = 3;
   else if (_Ch < 0x04000000)
    _By = (_Byte)(0xf8 | _Ch >> 24), _Nextra = 4;
   else
    _By = (_Byte)(0xfc | (_Ch >> 30 & 0x03)), _Nextra = 5;

   if (*_Pstate == 0)
    {
    *_Pstate = 1;
    if ((_Mode & _Generate_header) == 0)
     ;
    else if (_Last2 - _Mid2 < 3 + 1 + _Nextra)
     return (_Mybase::partial);
    else
     {
     *_Mid2++ = (_Byte)(unsigned char)0xef;
     *_Mid2++ = (_Byte)(unsigned char)0xbb;
     *_Mid2++ = (_Byte)(unsigned char)0xbf;
     }
    }

   if (_Last2 - _Mid2 < 1 + _Nextra)
    break;

   ++_Mid1;
   for (*_Mid2++ = _By; 0 < _Nextra; )
    *_Mid2++ = (_Byte)((_Ch >> 6 * --_Nextra & 0x3f) | 0x80);
   }
  return (_First1 == _Mid1 ? _Mybase::partial : _Mybase::ok);
  }

 virtual result do_unshift(_Statype&,
  _Byte *_First2, _Byte *, _Byte *& _Mid2) const
  {
  _Mid2 = _First2;
  return (_Mybase::ok);
  }

 virtual int do_length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  int _Wchars = 0;
  _Statype _Mystate = _State;

  for (; (size_t)_Wchars < _Count && _First1 != _Last1; )
   {
   const _Byte *_Mid1;
   _Elem *_Mid2;
   _Elem _Ch;

   switch (do_in(_Mystate, _First1, _Last1, _Mid1,
    &_Ch, &_Ch + 1, _Mid2))
    {
   case _Mybase::noconv:
    return ((int)(_Wchars + (int)(_Last1 - _First1)));

   case _Mybase::ok:
    if (_Mid2 == &_Ch + 1)
     ++_Wchars;
    _First1 = _Mid1;
    break;

   default:
    return ((int)_Wchars);
    }
   }

  return ((int)_Wchars);
  }

 virtual bool do_always_noconv() const
  {
  return (false);
  }

 virtual int do_max_length() const
  {
  return ((_Mode & (_Consume_header | _Generate_header)) != 0
   ? 9 : 6);
  }

 virtual int do_encoding() const
  {
  return ((_Mode & (_Consume_header | _Generate_header)) != 0
   ? -1 : 0);
  }

private:
 unsigned long _Maxcode;
 _Codecvt_mode _Mode;
 };



template<>
 class __declspec(dllexport) codecvt<wchar_t, char, _Mbstatet>
 : public codecvt_base
 {
public:
 typedef wchar_t _Elem;
 typedef char _Byte;
 typedef _Mbstatet _Statype;
 typedef _Elem intern_type;
 typedef _Byte extern_type;
 typedef _Statype state_type;

 result in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
  _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
  return (do_in(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_out(_State,
   _First1, _Last1, _Mid1, _First2, _Last2, _Mid2));
  }

 result unshift(_Statype& _State,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
  return (do_unshift(_State,
   _First2, _Last2, _Mid2));
  }

 int length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
  return (do_length(_State, _First1, _Last1, _Count));
  }

 static locale::id id;

 explicit codecvt(size_t _Refs = 0)
  : codecvt_base(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        codecvt(const _Locinfo& _Lobj, size_t _Refs = 0)
  : codecvt_base(_Refs)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new codecvt<_Elem, _Byte, _Statype>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

protected:
 virtual ~codecvt()
  {
  }

 void _Init(const _Locinfo& _Lobj)
  {
  _Cvt = _Lobj._Getcvt();
  }

 virtual result do_in(_Statype& _State,
  const _Byte *_First1, const _Byte *_Last1, const _Byte *& _Mid1,
   _Elem *_First2, _Elem *_Last2, _Elem *& _Mid2) const
  {
                               ;
                               ;
  _Mid1 = _First1, _Mid2 = _First2;
  result _Ans = _Mid1 == _Last1 ? ok : partial;
  int _Bytes;

  while (_Mid1 != _Last1 && _Mid2 != _Last2)
   switch (_Bytes = _Mbrtowc(_Mid2, _Mid1, _Last1 - _Mid1,
    &_State, &_Cvt))
   {
   case -2:
    _Mid1 = _Last1;
    return (_Ans);

   case -1:
    return (error);

   case 0:
    if (*_Mid2 == (_Elem)0)
     _Bytes = (int)::std:: strlen(_Mid1) + 1;


   default:
    if (_Bytes == -3)
     _Bytes = 0;
    _Mid1 += _Bytes;
    ++_Mid2;
    _Ans = ok;
   }
  return (_Ans);
  }

 virtual result do_out(_Statype& _State,
  const _Elem *_First1, const _Elem *_Last1, const _Elem *& _Mid1,
   _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
                               ;
                               ;
  _Mid1 = _First1, _Mid2 = _First2;
  result _Ans = _Mid1 == _Last1 ? ok : partial;
  int _Bytes;

  while (_Mid1 != _Last1 && _Mid2 != _Last2)
   if ((int)std::__mb_cur_max <= _Last2 - _Mid2)
    if ((_Bytes = _Wcrtomb(_Mid2, *_Mid1,
     &_State, &_Cvt)) < 0)
     return (error);
    else
     ++_Mid1, _Mid2 += _Bytes, _Ans = ok;
   else
    {
    _Byte _Buf[2];
    _Statype _Stsave = _State;

    if ((_Bytes = _Wcrtomb(_Buf, *_Mid1,
     &_State, &_Cvt)) < 0)
     return (error);
    else if (_Last2 - _Mid2 < _Bytes)
     {
     _State = _Stsave;
     return (_Ans);
     }
    else
     {
     ::std:: memcpy(_Mid2, _Buf, _Bytes);
     ++_Mid1, _Mid2 += _Bytes, _Ans = ok;
     }
    }
  return (_Ans);
  }

 virtual result do_unshift(_Statype& _State,
  _Byte *_First2, _Byte *_Last2, _Byte *& _Mid2) const
  {
                               ;
  _Mid2 = _First2;
  result _Ans = ok;
  int _Bytes;
  _Byte _Buf[2];
  _Statype _Stsave = _State;

  if ((_Bytes = _Wcrtomb(_Buf, L'\0', &_State, &_Cvt)) <= 0)
   _Ans = error;
  else if (_Last2 - _Mid2 < --_Bytes)
   {
   _State = _Stsave;
   _Ans = partial;
   }
  else if (0 < _Bytes)
   {
   ::std:: memcpy(_Mid2, _Buf, _Bytes);
   _Mid2 += _Bytes;
   }
  return (_Ans);
  }

 virtual int do_length(_Statype& _State, const _Byte *_First1,
  const _Byte *_Last1, size_t _Count) const
  {
                               ;
  int _Wchars;
  const _Byte *_Mid1;
  _Statype _Mystate = _State;

  for (_Wchars = 0, _Mid1 = _First1;
   (size_t)_Wchars < _Count && _Mid1 != _Last1; )
   {
   int _Bytes;
   _Elem _Ch;

   switch (_Bytes = _Mbrtowc(&_Ch, _Mid1, _Last1 - _Mid1,
    &_Mystate, &_Cvt))
    {
   case -2:
    return (_Wchars);

   case -1:
    return (_Wchars);

   case 0:
    if (_Ch == (_Elem)0)
     _Bytes = (int)::std:: strlen(_Mid1) + 1;


   default:
    if (_Bytes == -3)
     _Bytes = 0;
    _Mid1 += _Bytes;
    ++_Wchars;
    }
   }
  return (_Wchars);
  }

 virtual bool do_always_noconv() const
  {
  return (false);
  }

 virtual int do_max_length() const
  {
  return (2);
  }

 virtual int do_encoding() const
  {
  return (0);
  }

private:
 _Locinfo::_Cvtvec _Cvt;
 };


template<class _Elem,
 class _Byte,
 class _Statype>
 class codecvt_byname
  : public codecvt<_Elem, _Byte, _Statype>
 {
public:
 explicit codecvt_byname(const char *_Locname, size_t _Refs = 0)
  : codecvt<_Elem, _Byte, _Statype>(_Locinfo(_Locname), _Refs)
  {
  }


 explicit codecvt_byname(const string& _Str, size_t _Refs = 0)
  : codecvt<_Elem, _Byte, _Statype>(_Locinfo(_Str.c_str()), _Refs)
  {
  }


protected:
 virtual ~codecvt_byname()
  {
  }
 };



struct __declspec(dllexport) ctype_base
 : public locale::facet
 {
 enum
  {
  alnum = 0x20 | 0x10 | 0x02 | 0x200, alpha = 0x10 | 0x02 | 0x200,
  cntrl = 0x80, digit = 0x20, graph = 0x20 | 0x10 | 0x08 | 0x02 | 0x200,
  lower = 0x10, print = 0x20 | 0x10 | 0x08 | 0x04 | 0x02 | 0x200 | 0x01,
  punct = 0x08, space = 0x40 | 0x04 | 0x100, upper = 0x02,
  xdigit = 0x01, blank = 0x40 | 0x04 | 0x100 | 0x400};
 typedef short mask;

        ctype_base(size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  }

        ~ctype_base()
  {
  }
 };


template<class _Elem>
 class ctype
  : public ctype_base
 {
public:
 typedef _Elem char_type;

 bool is(mask _Maskval, _Elem _Ch) const
  {
  return (do_is(_Maskval, _Ch));
  }

 const _Elem * is(const _Elem *_First, const _Elem *_Last,
  mask *_Dest) const
  {
  return (do_is(_First, _Last, _Dest));
  }

 const _Elem * scan_is(mask _Maskval, const _Elem *_First,
  const _Elem *_Last) const
  {
  return (do_scan_is(_Maskval, _First, _Last));
  }

 const _Elem * scan_not(mask _Maskval, const _Elem *_First,
  const _Elem *_Last) const
  {
  return (do_scan_not(_Maskval, _First, _Last));
  }

 _Elem tolower(_Elem _Ch) const
  {
  return (do_tolower(_Ch));
  }

 const _Elem * tolower(_Elem *_First, const _Elem *_Last) const
  {
  return (do_tolower(_First, _Last));
  }

 _Elem toupper(_Elem _Ch) const
  {
  return (do_toupper(_Ch));
  }

 const _Elem * toupper(_Elem *_First, const _Elem *_Last) const
  {
  return (do_toupper(_First, _Last));
  }

 _Elem widen(char _Byte) const
  {
  return (do_widen(_Byte));
  }

 const char * widen(const char *_First, const char *_Last,
  _Elem *_Dest) const
  {
  return (do_widen(_First, _Last, _Dest));
  }

 char narrow(_Elem _Ch, char _Dflt = '\0') const
  {
  return (do_narrow(_Ch, _Dflt));
  }

 const _Elem * narrow(const _Elem *_First, const _Elem *_Last,
  char _Dflt, char *_Dest) const
  {
  return (do_narrow(_First, _Last, _Dflt, _Dest));
  }

 static locale::id id;

 explicit ctype(size_t _Refs = 0)
  : ctype_base(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        ctype(const _Locinfo& _Lobj, size_t _Refs = 0)
  : ctype_base(_Refs)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new ctype<_Elem>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

protected:
 virtual ~ctype()
  {
  if (_Ctype._Delfl)
   free((void *)_Ctype._Table);
  }

 void _Init(const _Locinfo& _Lobj)
  {
  _Ctype = _Lobj._Getctype();
  _Cvt = _Lobj._Getcvt();
  }

 virtual bool do_is(mask _Maskval, _Elem _Ch) const
  {
  return ((_Ctype._Table[(unsigned char)narrow(_Ch)]
   & _Maskval) != 0);
  }

 virtual const _Elem * do_is(const _Elem *_First, const _Elem *_Last,
  mask *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Ctype._Table[(unsigned char)narrow(*_First)];
  return (_First);
  }

 virtual const _Elem * do_scan_is(mask _Maskval,
  const _Elem *_First, const _Elem *_Last) const
  {
                             ;
  for (; _First != _Last && !is(_Maskval, *_First); ++_First)
   ;
  return (_First);
  }

 virtual const _Elem * do_scan_not(mask _Maskval,
  const _Elem *_First, const _Elem *_Last) const
  {
                             ;
  for (; _First != _Last && is(_Maskval, *_First); ++_First)
   ;
  return (_First);
  }

 virtual _Elem do_tolower(_Elem _Ch) const
  {
  unsigned char _Byte = (unsigned char)narrow(_Ch, '\0');
  if (_Byte == '\0')
   return (_Ch);
  else
   return (widen((char)_Tolower(_Byte, &_Ctype)));
  }

 virtual const _Elem * do_tolower(_Elem *_First,
  const _Elem *_Last) const
  {
                                            ;
  for (; _First != _Last; ++_First)
   {
   unsigned char _Byte = (unsigned char)narrow(*_First, '\0');
   if (_Byte != '\0')
    *_First = (widen((char)_Tolower(_Byte, &_Ctype)));
   }
  return ((const _Elem *)_First);
  }

 virtual _Elem do_toupper(_Elem _Ch) const
  {
  unsigned char _Byte = (unsigned char)narrow(_Ch, '\0');
  if (_Byte == '\0')
   return (_Ch);
  else
   return (widen((char)_Toupper(_Byte, &_Ctype)));
  }

 virtual const _Elem * do_toupper(_Elem *_First,
  const _Elem *_Last) const
  {
                                            ;
  for (; _First != _Last; ++_First)
   {
   unsigned char _Byte = (unsigned char)narrow(*_First, '\0');
   if (_Byte != '\0')
    *_First = (widen((char)_Toupper(_Byte, &_Ctype)));
   }
  return ((const _Elem *)_First);
  }

 virtual _Elem do_widen(char _Byte) const
  {
  return (_Maklocchr(_Byte, (_Elem *)0, _Cvt));
  }

 virtual const char * do_widen(const char *_First,
  const char *_Last, _Elem *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Maklocchr(*_First, (_Elem *)0, _Cvt);
  return (_First);
  }

 char _Donarrow(_Elem _Ch, char _Dflt) const
  {
  char _Byte;
  if (_Ch == (_Elem)0)
   return ('\0');
  else if ((_Byte = _Maklocbyte((_Elem)_Ch, _Cvt)) == '\0')
   return (_Dflt);
  else
   return (_Byte);
  }

 virtual char do_narrow(_Elem _Ch, char _Dflt) const
  {
  return (_Donarrow(_Ch, _Dflt));
  }

 virtual const _Elem * do_narrow(const _Elem *_First,
  const _Elem *_Last, char _Dflt, char *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Donarrow(*_First, _Dflt);
  return (_First);
  }

private:
 _Locinfo::_Ctypevec _Ctype;
 _Locinfo::_Cvtvec _Cvt;
 };


template<class _Elem>
 locale::id ctype<_Elem>::id;


template<>
 class __declspec(dllexport) ctype<char>
 : public ctype_base
 {
 typedef ctype<char> _Myt;

public:
 typedef char _Elem;
 typedef _Elem char_type;

 bool is(mask _Maskval, _Elem _Ch) const
  {
  return ((_Ctype._Table[(unsigned char)_Ch] & _Maskval) != 0);
  }

 const _Elem * is(const _Elem *_First,
  const _Elem *_Last, mask *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Ctype._Table[(unsigned char)*_First];
  return (_First);
  }

 const _Elem * scan_is(mask _Maskval,
  const _Elem *_First, const _Elem *_Last) const
  {
                             ;
  for (; _First != _Last && !is(_Maskval, *_First); ++_First)
   ;
  return (_First);
  }

 const _Elem * scan_not(mask _Maskval,
  const _Elem *_First, const _Elem *_Last) const
  {
                             ;
  for (; _First != _Last && is(_Maskval, *_First); ++_First)
   ;
  return (_First);
  }

 _Elem tolower(_Elem _Ch) const
  {
  return (do_tolower(_Ch));
  }

 const _Elem * tolower(_Elem *_First, const _Elem *_Last) const
  {
  return (do_tolower(_First, _Last));
  }

 _Elem toupper(_Elem _Ch) const
  {
  return (do_toupper(_Ch));
  }

 const _Elem * toupper(_Elem *_First, const _Elem *_Last) const
  {
  return (do_toupper(_First, _Last));
  }

 _Elem widen(char _Byte) const
  {
  return (do_widen(_Byte));
  }

 const _Elem * widen(const char *_First, const char *_Last,
  _Elem *_Dest) const
  {
  return (do_widen(_First, _Last, _Dest));
  }

 _Elem narrow(_Elem _Ch, char _Dflt = '\0') const
  {
  return (do_narrow(_Ch, _Dflt));
  }

 const _Elem * narrow(const _Elem *_First, const _Elem *_Last,
  char _Dflt, char *_Dest) const
  {
  return (do_narrow(_First, _Last, _Dflt, _Dest));
  }

 static locale::id id;

 explicit ctype(const mask *_Table = 0,
  bool _Deletetable = false,
  size_t _Refs = 0)
  : ctype_base(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }

  _Tidy();
  if (_Table != 0)
   {
   _Ctype._Table = _Table;
   _Ctype._Delfl = _Deletetable ? -1 : 0;
   }
  else
   {
   _Ctype._Table = classic_table();
   _Ctype._Delfl = 0;
   }
  }

        ctype(const _Locinfo& _Lobj, size_t _Refs = 0)
  : ctype_base(_Refs)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new ctype<_Elem>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

 const mask * table() const
  {
  return (_Ctype._Table);
  }

 static const mask * classic_table()
  {
  const _Myt& _Ctype_fac = use_facet< _Myt >(locale::classic());
  return (_Ctype_fac.table());
  }

 static const size_t table_size;

protected:
 virtual ~ctype()
  {
  _Tidy();
  }

 void _Init(const _Locinfo& _Lobj)
  {

  *(size_t *)&table_size = 1 << 8;


  _Ctype = _Lobj._Getctype();
  }

 void _Tidy()
  {
  if (0 < _Ctype._Delfl)
   free((void *)_Ctype._Table);
  else if (_Ctype._Delfl < 0)
   delete[] _Ctype._Table;
  }

 virtual _Elem do_tolower(_Elem _Ch) const
  {
  return ((_Elem)_Tolower((unsigned char)_Ch, &_Ctype));
  }

 virtual const _Elem * do_tolower(_Elem *_First,
  const _Elem *_Last) const
  {
                                            ;
  for (; _First != _Last; ++_First)
   *_First = (_Elem)_Tolower((unsigned char)*_First, &_Ctype);
  return ((const _Elem *)_First);
  }

 virtual _Elem do_toupper(_Elem _Ch) const
  {
  return ((_Elem)_Toupper((unsigned char)_Ch, &_Ctype));
  }

 virtual const _Elem * do_toupper(_Elem *_First,
  const _Elem *_Last) const
  {
                                            ;
  for (; _First != _Last; ++_First)
   *_First = (_Elem)_Toupper((unsigned char)*_First, &_Ctype);
  return ((const _Elem *)_First);
  }

 virtual _Elem do_widen(char _Byte) const
  {
  return (_Byte);
  }

 virtual const _Elem * do_widen(const char *_First,
  const char *_Last, _Elem *_Dest) const
  {
                             ;
                       ;
  ::std:: memcpy(_Dest, _First, _Last - _First);
  return (_Last);
  }

 virtual _Elem do_narrow(_Elem _Ch, char) const
  {
  return (_Ch);
  }

 virtual const _Elem * do_narrow(const _Elem *_First,
  const _Elem *_Last, char, char *_Dest) const
  {
                             ;
                       ;
  ::std:: memcpy(_Dest, _First, _Last - _First);
  return (_Last);
  }

private:
 _Locinfo::_Ctypevec _Ctype;
 };


template<>
 class __declspec(dllexport) ctype<wchar_t>
 : public ctype_base
 {
 typedef ctype<wchar_t> _Myt;

public:
 typedef wchar_t _Elem;
 typedef _Elem char_type;

 bool is(mask _Maskval, _Elem _Ch) const
  {
  return (do_is(_Maskval, _Ch));
  }

 const _Elem * is(const _Elem *_First, const _Elem *_Last,
  mask *_Dest) const
  {
  return (do_is(_First, _Last, _Dest));
  }

 const _Elem * scan_is(mask _Maskval, const _Elem *_First,
  const _Elem *_Last) const
  {
  return (do_scan_is(_Maskval, _First, _Last));
  }

 const _Elem * scan_not(mask _Maskval, const _Elem *_First,
  const _Elem *_Last) const
  {
  return (do_scan_not(_Maskval, _First, _Last));
  }

 _Elem tolower(_Elem _Ch) const
  {
  return (do_tolower(_Ch));
  }

 const _Elem * tolower(_Elem *_First, const _Elem *_Last) const
  {
  return (do_tolower(_First, _Last));
  }

 _Elem toupper(_Elem _Ch) const
  {
  return (do_toupper(_Ch));
  }

 const _Elem * toupper(_Elem *_First, const _Elem *_Last) const
  {
  return (do_toupper(_First, _Last));
  }

 _Elem widen(char _Byte) const
  {
  return (do_widen(_Byte));
  }

 const char * widen(const char *_First, const char *_Last,
  _Elem *_Dest) const
  {
  return (do_widen(_First, _Last, _Dest));
  }

 char narrow(_Elem _Ch, char _Dflt = '\0') const
  {
  return (do_narrow(_Ch, _Dflt));
  }

 const _Elem * narrow(const _Elem *_First, const _Elem *_Last,
  char _Dflt, char *_Dest) const
  {
  return (do_narrow(_First, _Last, _Dflt, _Dest));
  }

 static locale::id id;

 explicit ctype(size_t _Refs = 0)
  : ctype_base(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        ctype(const _Locinfo& _Lobj, size_t _Refs = 0)
  : ctype_base(_Refs)
  {
  _Init(_Lobj);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new ctype<_Elem>(
    _Locinfo(_Ploc->c_str()));
  return (1);
  }

protected:
 virtual ~ctype()
  {
  if (_Ctype._Delfl)
   free((void *)_Ctype._Table);
  }

 void _Init(const _Locinfo& _Lobj)
  {
  _Ctype = _Lobj._Getctype();
  _Cvt = _Lobj._Getcvt();
  }

 virtual bool do_is(mask _Maskval, _Elem _Ch) const
  {
  return ((_Ctype._Table[(unsigned char)narrow(_Ch)]
   & _Maskval) != 0);
  }

 virtual const _Elem * do_is(const _Elem *_First,
  const _Elem *_Last, mask *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Ctype._Table[(unsigned char)narrow(*_First)];
  return (_First);
  }

 virtual const _Elem * do_scan_is(mask _Maskval,
  const _Elem *_First, const _Elem *_Last) const
  {
                             ;
  for (; _First != _Last && !is(_Maskval, *_First); ++_First)
   ;
  return (_First);
  }

 virtual const _Elem * do_scan_not(mask _Maskval,
  const _Elem *_First, const _Elem *_Last) const
  {
                             ;
  for (; _First != _Last && is(_Maskval, *_First); ++_First)
   ;
  return (_First);
  }

 virtual _Elem do_tolower(_Elem _Ch) const
  {
  unsigned char _Byte = (unsigned char)narrow(_Ch, '\0');
  if (_Byte == '\0')
   return (_Ch);
  else
   return (widen((char)_Tolower(_Byte, &_Ctype)));
  }

 virtual const _Elem * do_tolower(_Elem *_First,
  const _Elem *_Last) const
  {
                                            ;
  for (; _First != _Last; ++_First)
   {
   unsigned char _Byte = (unsigned char)narrow(*_First, '\0');
   if (_Byte != '\0')
    *_First = (widen((char)_Tolower(_Byte, &_Ctype)));
   }
  return ((const _Elem *)_First);
  }

 virtual _Elem do_toupper(_Elem _Ch) const
  {
  unsigned char _Byte = (unsigned char)narrow(_Ch, '\0');
  if (_Byte == '\0')
   return (_Ch);
  else
   return (widen((char)_Toupper(_Byte, &_Ctype)));
  }

 virtual const _Elem * do_toupper(_Elem *_First,
  const _Elem *_Last) const
  {
                                            ;
  for (; _First != _Last; ++_First)
   {
   unsigned char _Byte = (unsigned char)narrow(*_First, '\0');
   if (_Byte != '\0')
    *_First = (widen((char)_Toupper(_Byte, &_Ctype)));
   }
  return ((const _Elem *)_First);
  }

 _Elem _Dowiden(char _Byte) const
  {
  _Mbstatet _Mbst = {0};
  wchar_t _Wc;
  return (_Mbrtowc(&_Wc, &_Byte, 1, &_Mbst, &_Cvt) < 0
   ? (wchar_t)(std::wint_t)(0xFFFF) : _Wc);
  }

 virtual _Elem do_widen(char _Byte) const
  {
  return (_Dowiden(_Byte));
  }

 virtual const char * do_widen(const char *_First,
  const char *_Last, _Elem *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Dowiden(*_First);
  return (_First);
  }

 char _Donarrow(_Elem _Ch, char _Dflt) const
  {
  char _Buf[2];
  _Mbstatet _Mbst = {0};
  return (_Wcrtomb(_Buf, _Ch, &_Mbst, &_Cvt) != 1
   ? _Dflt : _Buf[0]);
  }

 virtual char do_narrow(_Elem _Ch, char _Dflt) const
  {
  return (_Donarrow(_Ch, _Dflt));
  }

 virtual const _Elem * do_narrow(const _Elem *_First,
  const _Elem *_Last, char _Dflt, char *_Dest) const
  {
                             ;
                       ;
  for (; _First != _Last; ++_First, ++_Dest)
   *_Dest = _Donarrow(*_First, _Dflt);
  return (_First);
  }

private:
 _Locinfo::_Ctypevec _Ctype;
 _Locinfo::_Cvtvec _Cvt;
 };


template<class _Elem>
 class ctype_byname
 : public ctype<_Elem>
 {
public:
 explicit ctype_byname(const char *_Locname, size_t _Refs = 0)
  : ctype<_Elem>(_Locinfo(_Locname), _Refs)
  {
  }


 explicit ctype_byname(const string& _Str, size_t _Refs = 0)
  : ctype<_Elem>(_Locinfo(_Str.c_str()), _Refs)
  {
  }


protected:
 virtual ~ctype_byname()
  {
  }
 };


template<>
 class ctype_byname<char>
 : public ctype<char>
 {
public:
 explicit ctype_byname(const char *_Locname, size_t _Refs = 0)
  : ctype<char>(_Locinfo(_Locname), _Refs)
  {
  }


 explicit ctype_byname(const string& _Str, size_t _Refs = 0)
  : ctype<char>(_Locinfo(_Str.c_str()), _Refs)
  {
  }


protected:
 virtual ~ctype_byname()
  {
  }
 };
#line 2586 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
         template class __declspec(dllexport) codecvt<char, char, _Mbstatet>;
#line 2598 "C:\\src\\winrtl\\include\\dinkumware64\\xlocale"
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\xiosbase"



#line 1 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"



#line 1 "C:\\src\\winrtl\\include\\cerrno"
#line 10 "C:\\src\\winrtl\\include\\cerrno"
#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 10 "C:\\src\\winrtl\\include\\cerrno"
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"

#line 1 "C:\\src\\winrtl\\include\\cstdlib"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 1 "C:\\src\\winrtl\\include\\stdlib.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"
#line 1 "C:\\src\\winrtl\\include\\search.h"
#line 521 "C:\\src\\winrtl\\include\\stdlib.h"

#line 1 "C:\\src\\winrtl\\include\\errno.h"
#line 522 "C:\\src\\winrtl\\include\\stdlib.h"
#line 10 "C:\\src\\winrtl\\include\\cstdlib"
#line 5 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"
#line 14 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"
namespace std {



enum class errc {





 address_family_not_supported = 1004,
 address_in_use = 1002,
 address_not_available = 1003,
 already_connected = 1028,
 argument_list_too_long = 20,
 argument_out_of_domain = 33,
 bad_address = 14,
 bad_file_descriptor = 6,
 bad_message = 1008,
 broken_pipe = 32,
 connection_aborted = 1012,
 connection_already_in_progress = 1006,
 connection_refused = 1013,
 connection_reset = 1014,
 cross_device_link = 22,
 destination_address_required = 1016,
 device_or_resource_busy = 44,
 directory_not_empty = 49,
 executable_format_error = 21,
 file_exists = 35,
 file_too_large = 27,
 filename_too_long = 48,
 function_not_supported = 1052,
 host_unreachable = 1021,
 identifier_removed = 1022,
 illegal_byte_sequence = 88,
 inappropriate_io_control_operation = 25,
 interrupted = 39,
 invalid_argument = 19,
 invalid_seek = 29,
 io_error = 40,
 is_a_directory = 46,
 message_size = 1033,
 network_down = 1035,
 network_reset = 1036,
 network_unreachable = 1037,
 no_buffer_space = 1039,
 no_child_process = 24,
 no_link = 1045,
 no_lock_available = 1044,
 no_message_available = 1040,
 no_message = 1047,
 no_protocol_option = 1048,
 no_space_on_device = 28,
 no_stream_resources = 1050,
 no_such_device_or_address = 41,
 no_such_device = 15,
 no_such_file_or_directory = 2,
 no_such_process = 38,
 not_a_directory = 45,
 not_a_socket = 1057,
 not_a_stream = 1051,
 not_connected = 1053,
 not_enough_memory = 8,
 not_supported = 1058,
 operation_canceled = 1019,
 operation_in_progress = 1024,
 operation_not_permitted = 37,
 operation_not_supported = 1061,
 operation_would_block = 1077,
 owner_dead = 1064,
 permission_denied = 5,
 protocol_error = 1067,
 protocol_not_supported = 1068,
 read_only_file_system = 30,
 resource_deadlock_would_occur = 1015,
 resource_unavailable_try_again = 42,
 result_out_of_range = 34,
 state_not_recoverable = 1056,
 stream_timeout = 1074,
 text_file_busy = 26,
 timed_out = 1075,
 too_many_files_open_in_system = 23,
 too_many_files_open = 4,
 too_many_links = 31,
 too_many_symbolic_link_levels = 1030,
 value_too_large = 1063,
 wrong_protocol_type = 1069
 };


typedef errc generic_errno;
#line 116 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"
enum class io_errc {
 stream = 1
 };

typedef io_errc _Io_errc;
#line 131 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"
}
namespace std {

template<class _Enum>
 struct is_error_code_enum
  : public false_type
 {
 };

template<>
 struct is_error_code_enum<_Io_errc>
  : public true_type
 {
 };


template<class _Enum>
 struct is_error_condition_enum
  : public false_type
 {
 };

template<>
 struct is_error_condition_enum<generic_errno>
  : public true_type
 {
 };
}
namespace std {





class error_code;
class error_condition;
error_code make_error_code(generic_errno) ;
error_code make_error_code(_Io_errc) ;
error_condition make_error_condition(generic_errno) ;
error_condition make_error_condition(_Io_errc) ;


class error_category;

const error_category& generic_category() ;
const error_category& iostream_category() ;
const error_category& system_category() ;

class error_category
 {
public:
 error_category()
  {
  }

 virtual ~error_category()
  {
  }

 virtual const char *name() const = 0;

 virtual string message(int _Errval) const = 0;

 virtual error_condition
  default_error_condition(int _Errval) const ;

 virtual bool equivalent(int _Errval,
  const error_condition& _Cond) const ;

 virtual bool equivalent(const error_code& _Code,
  int _Errval) const ;

 bool operator==(const error_category& _Right) const
  {
  return (this == &_Right);
  }

 bool operator!=(const error_category& _Right) const
  {
  return (!(*this == _Right));
  }

 bool operator<(const error_category& _Right) const
  {
  return (this < &_Right);
  }







private:
 error_category(const error_category&);

 error_category& operator=(const error_category&);

 };


class error_code
 {
public:
 typedef error_code _Myt;

 error_code()
  : _Myval(0),
   _Mycat(&system_category())
  {
  }

 error_code(int _Val, const error_category& _Cat)
  : _Myval(_Val), _Mycat(&_Cat)
  {
  }


 template<class _Enum,
  class = typename enable_if<is_error_code_enum<_Enum>::value,
   void>::type>
  error_code(_Enum _Errcode)
  : _Myval(0), _Mycat(0)
  {
  *this = make_error_code(_Errcode);
  }
#line 269 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"
 void assign(int _Val, const error_category& _Cat)
  {
  _Myval = _Val;
  _Mycat = &_Cat;
  }

 template<class _Enum>
  typename enable_if<is_error_code_enum<_Enum>::value,
   error_code>::type& operator=(_Enum _Errcode)
  {
  *this = make_error_code(_Errcode);
  return (*this);
  }

 void clear()
  {
  _Myval = 0;
  _Mycat = &system_category();
  }

 int value() const
  {
  return (_Myval);
  }

 const error_category& category() const
  {
  return (*_Mycat);
  }

 error_condition default_error_condition() const;

 string message() const
  {
  return (category().message(value()));
  }

         operator bool() const
  {
  return (value() != 0);
  }

 bool operator==(const error_code& _Right) const
  {
  return (category() == _Right.category()
   && value() == _Right.value());
  }

 bool operator!=(const error_code& _Right) const
  {
  return (!(*this == _Right));
  }

 bool operator<(const error_code& _Right) const
  {
  return (category() < _Right.category()
   || (category() == _Right.category()
    && value() < _Right.value()));
  }

private:
 int _Myval;
 const error_category *_Mycat;
 };


class error_condition
 {
public:
 typedef error_condition _Myt;

 error_condition()
  : _Myval(0),
   _Mycat(&generic_category())
  {
  }

 error_condition(int _Val, const error_category& _Cat)
  : _Myval(_Val), _Mycat(&_Cat)
  {
  }


 template<class _Enum,
  class = typename enable_if<is_error_condition_enum<_Enum>::value,
   void>::type>
  error_condition(_Enum _Errcode)
  : _Myval(0), _Mycat(0)
  {
  *this = make_error_condition(_Errcode);
  }
#line 372 "C:\\src\\winrtl\\include\\dinkumware64\\system_error"
 void assign(int _Val, const error_category& _Cat)
  {
  _Myval = _Val;
  _Mycat = &_Cat;
  }

 template<class _Enum>
  typename enable_if<is_error_condition_enum<_Enum>::value,
   error_condition>::type& operator=(_Enum _Errcode)
  {
  *this = make_error_condition(_Errcode);
  return (*this);
  }

 void clear()
  {
  _Myval = 0;
  _Mycat = &generic_category();
  }

 int value() const
  {
  return (_Myval);
  }

 const error_category& category() const
  {
  return (*_Mycat);
  }

 string message() const
  {
  return (category().message(value()));
  }

         operator bool() const
  {
  return (value() != 0);
  }

 bool operator==(const error_condition& _Right) const
  {
  return (category() == _Right.category()
   && value() == _Right.value());
  }

 bool operator!=(const error_condition& _Right) const
  {
  return (!(*this == _Right));
  }

 bool operator<(const error_condition& _Right) const
  {
  return (category() < _Right.category()
   || (category() == _Right.category()
    && value() < _Right.value()));
  }

private:
 int _Myval;
 const error_category *_Mycat;
 };


inline error_condition
 error_category::default_error_condition(int _Errval) const
 {
 return (error_condition(_Errval, *this));
 }

inline bool
 error_category::equivalent(int _Errval,
  const error_condition& _Cond) const
 {
 return (default_error_condition(_Errval) == _Cond);
 }

inline bool
 error_category::equivalent(const error_code& _Code,
  int _Errval) const
 {
 return (*this == _Code.category() && _Code.value() == _Errval);
 }


inline error_condition error_code::default_error_condition() const
 {
 return (category().default_error_condition(value()));
 }


inline bool operator==(
 const error_code& _Left,
 const error_condition& _Right)
 {
 return (_Left.category().equivalent(_Left.value(), _Right)
  || _Right.category().equivalent(_Left, _Right.value()));
 }

inline bool operator==(
 const error_condition& _Left,
 const error_code& _Right)
 {
 return (_Right.category().equivalent(_Right.value(), _Left)
  || _Left.category().equivalent(_Right, _Left.value()));
 }


inline bool operator!=(
 const error_code& _Left,
 const error_condition& _Right)
 {
 return (!(_Left == _Right));
 }

inline bool operator!=(
 const error_condition& _Left,
 const error_code& _Right)
 {
 return (!(_Left == _Right));
 }


inline error_code make_error_code(generic_errno _Errno)
 {
 return (error_code((int)_Errno, generic_category()));
 }

inline error_code make_error_code(_Io_errc _Errno)
 {
 return (error_code((int)_Errno, iostream_category()));
 }


inline error_condition make_error_condition(generic_errno _Errno)
 {
 return (error_condition((int)_Errno, generic_category()));
 }

inline error_condition make_error_condition(_Io_errc _Errno)
 {
 return (error_condition((int)_Errno, iostream_category()));
 }
}
namespace std {

template<>
 struct hash<error_code>
  : public unary_function<error_code, size_t>
 {
 typedef error_code _Kty;

 size_t operator()(const _Kty& _Keyval) const
  {
  return (hash<int>()(_Keyval.value()));
  }
 };
}
namespace std {

class _System_error
 : public runtime_error
 {
private:
 static string _Makestr(error_code _Errcode, string _Message)
  {
  if (!_Message.empty())
   _Message.append(": ");
  _Message.append(_Errcode.message());
  return (_Message);
  }

protected:
 _System_error(error_code _Errcode, const string& _Message)
  : runtime_error(_Makestr(_Errcode, _Message)), _Mycode(_Errcode)
  {
  }

 error_code _Mycode;
 };

class system_error
 : public _System_error
 {
private:
 typedef _System_error _Mybase;

public:
 explicit system_error(error_code _Errcode)
  : _Mybase(_Errcode, "")
  {
  }

 system_error(error_code _Errcode, const string& _Message)
  : _Mybase(_Errcode, _Message)
  {
  }

 system_error(error_code _Errcode, const char *_Message)
  : _Mybase(_Errcode, _Message)
  {
  }

 system_error(int _Errval, const error_category& _Errcat)
  : _Mybase(error_code(_Errval, _Errcat), "")
  {
  }

 system_error(int _Errval, const error_category& _Errcat,
  const string& _Message)
  : _Mybase(error_code(_Errval, _Errcat), _Message)
  {
  }

 system_error(int _Errval, const error_category& _Errcat,
  const char *_Message)
  : _Mybase(error_code(_Errval, _Errcat), _Message)
  {
  }

 const error_code& code() const
  {
  return (_Mycode);
  }




protected:
 virtual void _Doraise() const
  {
  ::std:: _Throw(*this);
  }

 };

__declspec(dllexport) const char * _Syserror_map(int);


class _Generic_error_category
 : public error_category
 {
public:
 _Generic_error_category()
  {
  }

 virtual const char *name() const
  {
  return ("generic");
  }

 virtual string message(int _Errcode) const
  {
  const char *_Name = _Syserror_map(_Errcode);
  return (string(_Name != 0 ? _Name : "unknown error"));
  }
 };


class _Iostream_error_category
 : public _Generic_error_category
 {
public:
 _Iostream_error_category()
  {
  }

 virtual const char *name() const
  {
  return ("iostream");
  }

 virtual string message(int _Errcode) const
  {
  if (_Errcode == (int)io_errc::stream)
   return ("iostream stream error");
  else
   return (_Generic_error_category::message(_Errcode));
  }
 };


class _System_error_category
 : public _Generic_error_category
 {
public:
 _System_error_category()
  {
  }

 virtual const char *name() const
  {
  return ("system");
  }

 virtual string message(int _Errcode) const
  {
  return (_Generic_error_category::message(_Errcode));
  }

 virtual error_condition
  default_error_condition(int _Errval) const
  {
  if (_Syserror_map(_Errval))
   return (error_condition(_Errval, generic_category()));
  else
   return (error_condition(_Errval, system_category()));
  }
 };

template<class _Cat>
 struct _Error_objects
 {
 _Error_objects()
  {
  }

 static _Generic_error_category _Generic_object;
 static _Iostream_error_category _Iostream_object;
 static _System_error_category _System_object;
 };

template<class _Cat>
 _Generic_error_category _Error_objects<_Cat>::_Generic_object;
template<class _Cat>
 _Iostream_error_category _Error_objects<_Cat>::_Iostream_object;
template<class _Cat>
 _System_error_category _Error_objects<_Cat>::_System_object;




inline const error_category& generic_category()
 {
 return (_Error_objects<int>::_Generic_object);
 }

inline const error_category& iostream_category()
 {
 return (_Error_objects<int>::_Iostream_object);
 }

inline const error_category& system_category()
 {
 return (_Error_objects<int>::_System_object);
 }

}
#line 7 "C:\\src\\winrtl\\include\\dinkumware64\\xiosbase"





namespace std {
#line 71 "C:\\src\\winrtl\\include\\dinkumware64\\xiosbase"
template<class _Dummy>
 class _Iosb
 {
public:
 enum _Dummy_enum {_Dummy_enum_val = 1};
 enum _Fmtflags
  {
  _Fmtmask = 0xffff, _Fmtzero = 0};

 static const _Fmtflags skipws = (_Fmtflags)0x0001;
 static const _Fmtflags unitbuf = (_Fmtflags)0x2000;
 static const _Fmtflags uppercase = (_Fmtflags)0x0200;
 static const _Fmtflags showbase = (_Fmtflags)0x0080;
 static const _Fmtflags showpoint = (_Fmtflags)0x0100;
 static const _Fmtflags showpos = (_Fmtflags)0x0400;
 static const _Fmtflags left = (_Fmtflags)0x0002;
 static const _Fmtflags right = (_Fmtflags)0x0004;
 static const _Fmtflags internal = (_Fmtflags)0x0008;
 static const _Fmtflags dec = (_Fmtflags)0x0010;
 static const _Fmtflags oct = (_Fmtflags)0x0020;
 static const _Fmtflags hex = (_Fmtflags)0x0040;
 static const _Fmtflags scientific = (_Fmtflags)0x0800;
 static const _Fmtflags fixed = (_Fmtflags)0x1000;

 static const _Fmtflags hexfloat =
  (_Fmtflags)0x1800;

 static const _Fmtflags boolalpha = (_Fmtflags)0x8000;
 static const _Fmtflags _Stdio = (_Fmtflags)0x4000;
 static const _Fmtflags adjustfield = (_Fmtflags)(0x0002
  | 0x0004 | 0x0008);
 static const _Fmtflags basefield = (_Fmtflags)(0x0010
  | 0x0020 | 0x0040);
 static const _Fmtflags floatfield = (_Fmtflags)(0x0800
  | 0x1000);

 enum _Iostate
  {
  _Statmask = 0x17};

 static const _Iostate goodbit = (_Iostate)0x0;
 static const _Iostate eofbit = (_Iostate)0x1;
 static const _Iostate failbit = (_Iostate)0x2;
 static const _Iostate badbit = (_Iostate)0x4;
 static const _Iostate _Hardfail = (_Iostate)0x10;

 enum _Openmode
  {
  _Openmask = 0xff};

 static const _Openmode in = (_Openmode)0x01;
 static const _Openmode out = (_Openmode)0x02;
 static const _Openmode ate = (_Openmode)0x04;
 static const _Openmode app = (_Openmode)0x08;
 static const _Openmode trunc = (_Openmode)0x10;
 static const _Openmode _Nocreate = (_Openmode)0x20;
 static const _Openmode _Noreplace = (_Openmode)0x40;
 static const _Openmode binary = (_Openmode)0x80;

 enum _Seekdir
  {
  _Seekmask = 0x3};

 static const _Seekdir beg = (_Seekdir)0;
 static const _Seekdir cur = (_Seekdir)1;
 static const _Seekdir end = (_Seekdir)2;

 enum
  {
  _Openprot = 0666};
 };

template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::skipws;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::unitbuf;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::uppercase;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::showbase;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::showpoint;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::showpos;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::left;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::right;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::internal;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::dec;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::oct;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::hex;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::scientific;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::fixed;

template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags
  _Iosb<_Dummy>::hexfloat;

template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::boolalpha;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::_Stdio;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::adjustfield;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::basefield;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Fmtflags _Iosb<_Dummy>::floatfield;

template<class _Dummy>
 const typename _Iosb<_Dummy>::_Iostate _Iosb<_Dummy>::goodbit;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Iostate _Iosb<_Dummy>::eofbit;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Iostate _Iosb<_Dummy>::failbit;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Iostate _Iosb<_Dummy>::badbit;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Iostate _Iosb<_Dummy>::_Hardfail;

template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::in;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::out;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::ate;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::app;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::trunc;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::_Nocreate;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::_Noreplace;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Openmode _Iosb<_Dummy>::binary;

template<class _Dummy>
 const typename _Iosb<_Dummy>::_Seekdir _Iosb<_Dummy>::beg;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Seekdir _Iosb<_Dummy>::cur;
template<class _Dummy>
 const typename _Iosb<_Dummy>::_Seekdir _Iosb<_Dummy>::end;


class __declspec(dllexport) ios_base
 : public _Iosb<int>
 {
public:
 typedef _Fmtflags fmtflags;
 typedef _Iostate iostate;
 typedef _Openmode openmode;
 typedef _Seekdir seekdir;

 typedef ::std:: streamoff streamoff;
 typedef ::std:: streampos streampos;

 enum event
  {
  erase_event, imbue_event, copyfmt_event};

 typedef void ( *event_callback)(event, ios_base&, int);
 typedef unsigned int io_state, open_mode, seek_dir;


 class failure


  : public system_error
  {
 public:
  explicit failure(const string &_Message,
   const error_code& _Errcode = make_error_code(io_errc::stream))
   : system_error(_Errcode, _Message)
   {
   }

  explicit failure(const char *_Message,
   const error_code& _Errcode = make_error_code(io_errc::stream))
   : system_error(_Errcode, _Message)
   {
   }
#line 279 "C:\\src\\winrtl\\include\\dinkumware64\\xiosbase"
 protected:
  virtual void _Doraise() const
   {
   ::std:: _Throw(*this);
   }

  };


 class __declspec(dllexport) Init
  {
 public:
         Init();

         ~Init() ;

 private:
  static int _Init_cnt;
  };

        operator void *() const
  {
  return (fail() ? 0 : (void *)this);
  }

                operator bool() const
  {
  return (!fail());
  }

 bool operator!() const
  {
  return (fail());
  }

 void clear(iostate _State, bool _Reraise)
  {
  _Mystate = (iostate)(_State & _Statmask);
  if ((_Mystate & _Except) == 0)
   ;
  else if (_Reraise)
           ;
  else if (_Mystate & _Except & badbit)
   failure("ios_base::badbit set")._Raise();
  else if (_Mystate & _Except & failbit)
   failure("ios_base::failbit set")._Raise();
  else
   failure("ios_base::eofbit set")._Raise();
  }

 void clear(iostate _State = goodbit)
  {
  clear(_State, false);
  }

 void clear(io_state _State)
  {
  clear((iostate)_State);
  }

 iostate rdstate() const
  {
  return (_Mystate);
  }

 void setstate(iostate _State, bool _Exreraise)
  {
  if (_State != goodbit)
   clear((iostate)((int)rdstate() | (int)_State), _Exreraise);
  }

 void setstate(iostate _State)
  {
  if (_State != goodbit)
   clear((iostate)((int)rdstate() | (int)_State), false);
  }

 void setstate(io_state _State)
  {
  setstate((iostate)_State);
  }

 bool good() const
  {
  return (rdstate() == goodbit);
  }

 bool eof() const
  {
  return ((int)rdstate() & (int)eofbit);
  }

 bool fail() const
  {
  return (((int)rdstate()
   & ((int)badbit | (int)failbit)) != 0);
  }

 bool bad() const
  {
  return (((int)rdstate() & (int)badbit) != 0);
  }

 iostate exceptions() const
  {
  return (_Except);
  }

 void exceptions(iostate _Newexcept)
  {
  _Except = (iostate)((int)_Newexcept & (int)_Statmask);
  clear(_Mystate);
  }

 void exceptions(io_state _State)
  {
  exceptions((iostate)_State);
  }

 fmtflags flags() const
  {
  return (_Fmtfl);
  }

 fmtflags flags(fmtflags _Newfmtflags)
  {
  fmtflags _Oldfmtflags = _Fmtfl;
  _Fmtfl = (fmtflags)((int)_Newfmtflags & (int)_Fmtmask);
  return (_Oldfmtflags);
  }

 fmtflags setf(fmtflags _Newfmtflags)
  {
  ios_base::fmtflags _Oldfmtflags = _Fmtfl;
  _Fmtfl = (fmtflags)((int)_Fmtfl
   | ((int)_Newfmtflags & (int)_Fmtmask));
  return (_Oldfmtflags);
  }

 fmtflags setf(fmtflags _Newfmtflags, fmtflags _Mask)
  {
  ios_base::fmtflags _Oldfmtflags = _Fmtfl;
  _Fmtfl = (fmtflags)(((int)_Fmtfl & (int)~_Mask)
   | ((int)_Newfmtflags & (int)_Mask & (int)_Fmtmask));
  return (_Oldfmtflags);
  }

 void unsetf(fmtflags _Mask)
  {
  _Fmtfl = (fmtflags)((int)_Fmtfl & (int)~_Mask);
  }

 streamsize precision() const
  {
  return (_Prec);
  }

 streamsize precision(streamsize _Newprecision)
  {
  streamsize _Oldprecision = _Prec;
  _Prec = _Newprecision;
  return (_Oldprecision);
  }

 streamsize width() const
  {
  return (_Wide);
  }

 streamsize width(streamsize _Newwidth)
  {
  streamsize _Oldwidth = _Wide;
  _Wide = _Newwidth;
  return (_Oldwidth);
  }

 locale getloc() const
  {
  return (*_Ploc);
  }

 locale imbue(const locale& _Loc)
  {
  locale _Oldlocale = *_Ploc;
  *_Ploc = _Loc;
  _Callfns(imbue_event);
  return (_Oldlocale);
  }

 static int xalloc()
  {
  {
   return (_Index++);
  }
  }

 long& iword(int _Idx)
  {
  return (_Findarr(_Idx)._Lo);
  }

 void *& pword(int _Idx)
  {
  return (_Findarr(_Idx)._Vp);
  }

 void register_callback(event_callback _Pfn,
  int _Idx)
  {
  _Calls = new _Fnarray(_Idx, _Pfn, _Calls);
  }

 ios_base& copyfmt(const ios_base& _Other)
  {
  if (this != &_Other)
   {
   _Tidy();
   *_Ploc = *_Other._Ploc;
   _Fmtfl = _Other._Fmtfl;
   _Prec = _Other._Prec;
   _Wide = _Other._Wide;
   _Iosarray *_Ptr = _Other._Arr;

   for (_Arr = 0; _Ptr != 0; _Ptr = _Ptr->_Next)
    if (_Ptr->_Lo != 0 || _Ptr->_Vp != 0)
     {
     iword(_Ptr->_Index) = _Ptr->_Lo;
     pword(_Ptr->_Index) = _Ptr->_Vp;
     }

   for (_Fnarray *_Pfa = _Other._Calls; _Pfa != 0;
    _Pfa = _Pfa->_Next)
    register_callback(_Pfa->_Pfn, _Pfa->_Index);

   _Callfns(copyfmt_event);
   exceptions(_Other._Except);
   }
  return (*this);
  }

 static bool sync_with_stdio(bool _Newsync = true)
  {
  {
   const bool _Oldsync = _Sync;
   _Sync = _Newsync;
   return (_Oldsync);
  }
  }

 void swap(ios_base& _Right)
  {
  if (this != &_Right)
   {
   ::std:: swap(_Mystate, _Right._Mystate);
   ::std:: swap(_Except, _Right._Except);
   ::std:: swap(_Fmtfl, _Right._Fmtfl);
   ::std:: swap(_Prec, _Right._Prec);
   ::std:: swap(_Wide, _Right._Wide);

   ::std:: swap(_Arr, _Right._Arr);
   ::std:: swap(_Calls, _Right._Calls);
   ::std:: swap(_Ploc, _Right._Ploc);
   }
  }

 virtual ~ios_base() ;

 static void _Addstd(ios_base *);
#line 555 "C:\\src\\winrtl\\include\\dinkumware64\\xiosbase"
 size_t _Stdstr;

protected:
        ios_base()
  {
  }

 void _Init()
  {
  _Ploc = 0;
  _Stdstr = 0;
  _Except = goodbit;
  _Fmtfl = (fmtflags)(skipws | dec);
  _Prec = 6;
  _Wide = 0;
  _Arr = 0;
  _Calls = 0;
  clear(goodbit);
  _Ploc = new locale;
  }

private:

 struct _Iosarray
  {
 public:
         _Iosarray(int _Idx, _Iosarray *_Link)
   : _Next(_Link), _Index(_Idx), _Lo(0), _Vp(0)
   {
   }

  _Iosarray *_Next;
  int _Index;
  long _Lo;
  void *_Vp;
  };


 struct _Fnarray
  {
         _Fnarray(int _Idx, event_callback _Pnew, _Fnarray *_Link)
   : _Next(_Link), _Index(_Idx), _Pfn(_Pnew)
   {
   }

  _Fnarray *_Next;
  int _Index;
  event_callback _Pfn;
  };

 void _Callfns(event _Ev)
  {
  for (_Fnarray *_Pfa = _Calls; _Pfa != 0; _Pfa = _Pfa->_Next)
   (*_Pfa->_Pfn)(_Ev, *this, _Pfa->_Index);
  }

 _Iosarray& _Findarr(int _Idx)
  {
  _Iosarray *_Ptr1, *_Ptr2;

  for (_Ptr1 = _Arr, _Ptr2 = 0; _Ptr1 != 0; _Ptr1 = _Ptr1->_Next)
   if (_Ptr1->_Index == _Idx)
    return (*_Ptr1);
   else if (_Ptr2 == 0 && _Ptr1->_Lo == 0 && _Ptr1->_Vp == 0)
    _Ptr2 = _Ptr1;

  if (_Ptr2 != 0)
   {
   _Ptr2->_Index = _Idx;
   return (*_Ptr2);
   }

  _Arr = new _Iosarray(_Idx, _Arr);
  return (*_Arr);
  }

 void _Tidy()
  {
  _Callfns(erase_event);
  _Iosarray *_Ptr1, *_Ptr2;

  for (_Ptr1 = _Arr; _Ptr1 != 0; _Ptr1 = _Ptr2)
   {
   _Ptr2 = _Ptr1->_Next;
   delete (_Ptr1);
   }
  _Arr = 0;

  _Fnarray *_Pfa1, *_Pfa2;
  for (_Pfa1 = _Calls; _Pfa1 != 0; _Pfa1 = _Pfa2)
   {
   _Pfa2 = _Pfa1->_Next;
   delete (_Pfa1);
   }
  _Calls = 0;
  }

 iostate _Mystate;
 iostate _Except;
 fmtflags _Fmtfl;
 streamsize _Prec;
 streamsize _Wide;
 _Iosarray *_Arr;
 _Fnarray *_Calls;
 locale *_Ploc;

 static int _Index;
 static bool _Sync;







 ios_base(const ios_base&);
 ios_base& operator=(const ios_base&);

 };

inline ios_base::_Fmtflags& operator&=(ios_base::_Fmtflags& _Left, ios_base::_Fmtflags _Right) { _Left = (ios_base::_Fmtflags)((int)_Left & (int)_Right); return _Left; } inline ios_base::_Fmtflags& operator|=(ios_base::_Fmtflags& _Left, ios_base::_Fmtflags _Right) { _Left = (ios_base::_Fmtflags)((int)_Left | (int)_Right); return _Left; } inline ios_base::_Fmtflags& operator^=(ios_base::_Fmtflags& _Left, ios_base::_Fmtflags _Right) { _Left = (ios_base::_Fmtflags)((int)_Left ^ (int)_Right); return _Left; } inline ios_base::_Fmtflags operator&(ios_base::_Fmtflags _Left, ios_base::_Fmtflags _Right) { return ((ios_base::_Fmtflags)((int)_Left & (int)_Right)); } inline ios_base::_Fmtflags operator|(ios_base::_Fmtflags _Left, ios_base::_Fmtflags _Right) { return ((ios_base::_Fmtflags)((int)_Left | (int)_Right)); } inline ios_base::_Fmtflags operator^(ios_base::_Fmtflags _Left, ios_base::_Fmtflags _Right) { return ((ios_base::_Fmtflags)((int)_Left ^ (int)_Right)); } inline ios_base::_Fmtflags operator~(ios_base::_Fmtflags _Left) { return ((ios_base::_Fmtflags)~(int)_Left); }
inline ios_base::_Iostate& operator&=(ios_base::_Iostate& _Left, ios_base::_Iostate _Right) { _Left = (ios_base::_Iostate)((int)_Left & (int)_Right); return _Left; } inline ios_base::_Iostate& operator|=(ios_base::_Iostate& _Left, ios_base::_Iostate _Right) { _Left = (ios_base::_Iostate)((int)_Left | (int)_Right); return _Left; } inline ios_base::_Iostate& operator^=(ios_base::_Iostate& _Left, ios_base::_Iostate _Right) { _Left = (ios_base::_Iostate)((int)_Left ^ (int)_Right); return _Left; } inline ios_base::_Iostate operator&(ios_base::_Iostate _Left, ios_base::_Iostate _Right) { return ((ios_base::_Iostate)((int)_Left & (int)_Right)); } inline ios_base::_Iostate operator|(ios_base::_Iostate _Left, ios_base::_Iostate _Right) { return ((ios_base::_Iostate)((int)_Left | (int)_Right)); } inline ios_base::_Iostate operator^(ios_base::_Iostate _Left, ios_base::_Iostate _Right) { return ((ios_base::_Iostate)((int)_Left ^ (int)_Right)); } inline ios_base::_Iostate operator~(ios_base::_Iostate _Left) { return ((ios_base::_Iostate)~(int)_Left); }
inline ios_base::_Openmode& operator&=(ios_base::_Openmode& _Left, ios_base::_Openmode _Right) { _Left = (ios_base::_Openmode)((int)_Left & (int)_Right); return _Left; } inline ios_base::_Openmode& operator|=(ios_base::_Openmode& _Left, ios_base::_Openmode _Right) { _Left = (ios_base::_Openmode)((int)_Left | (int)_Right); return _Left; } inline ios_base::_Openmode& operator^=(ios_base::_Openmode& _Left, ios_base::_Openmode _Right) { _Left = (ios_base::_Openmode)((int)_Left ^ (int)_Right); return _Left; } inline ios_base::_Openmode operator&(ios_base::_Openmode _Left, ios_base::_Openmode _Right) { return ((ios_base::_Openmode)((int)_Left & (int)_Right)); } inline ios_base::_Openmode operator|(ios_base::_Openmode _Left, ios_base::_Openmode _Right) { return ((ios_base::_Openmode)((int)_Left | (int)_Right)); } inline ios_base::_Openmode operator^(ios_base::_Openmode _Left, ios_base::_Openmode _Right) { return ((ios_base::_Openmode)((int)_Left ^ (int)_Right)); } inline ios_base::_Openmode operator~(ios_base::_Openmode _Left) { return ((ios_base::_Openmode)~(int)_Left); }
inline ios_base::_Seekdir& operator&=(ios_base::_Seekdir& _Left, ios_base::_Seekdir _Right) { _Left = (ios_base::_Seekdir)((int)_Left & (int)_Right); return _Left; } inline ios_base::_Seekdir& operator|=(ios_base::_Seekdir& _Left, ios_base::_Seekdir _Right) { _Left = (ios_base::_Seekdir)((int)_Left | (int)_Right); return _Left; } inline ios_base::_Seekdir& operator^=(ios_base::_Seekdir& _Left, ios_base::_Seekdir _Right) { _Left = (ios_base::_Seekdir)((int)_Left ^ (int)_Right); return _Left; } inline ios_base::_Seekdir operator&(ios_base::_Seekdir _Left, ios_base::_Seekdir _Right) { return ((ios_base::_Seekdir)((int)_Left & (int)_Right)); } inline ios_base::_Seekdir operator|(ios_base::_Seekdir _Left, ios_base::_Seekdir _Right) { return ((ios_base::_Seekdir)((int)_Left | (int)_Right)); } inline ios_base::_Seekdir operator^(ios_base::_Seekdir _Left, ios_base::_Seekdir _Right) { return ((ios_base::_Seekdir)((int)_Left ^ (int)_Right)); } inline ios_base::_Seekdir operator~(ios_base::_Seekdir _Left) { return ((ios_base::_Seekdir)~(int)_Left); }
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\streambuf"


namespace std {

template<class _Elem,
 class _Traits>
 class basic_streambuf
 {
 typedef basic_streambuf<_Elem, _Traits> _Myt;

protected:
        basic_streambuf()
  : _Plocale(new locale)
  {
  _Init();
  }

        basic_streambuf(_Uninitialized)





  {
  }


        basic_streambuf(const _Myt& _Right)
  : _Plocale(new locale(_Right.getloc()))
  {
  _Init();
  setp(_Right.pbase(), _Right.pptr(), _Right.epptr());
  setg(_Right.eback(), _Right.gptr(), _Right.egptr());
  }

 _Myt& operator=(const _Myt& _Right)
  {
  if (this != &_Right)
   {
   setp(_Right.pbase(), _Right.pptr(), _Right.epptr());
   setg(_Right.eback(), _Right.gptr(), _Right.egptr());
   pubimbue(_Right.getloc());
   }
  return (*this);
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   {
   _Elem *_Pfirst = pbase();
   _Elem *_Pnext = pptr();
   _Elem *_Pend = epptr();
   _Elem *_Gfirst = eback();
   _Elem *_Gnext = gptr();
   _Elem *_Gend = egptr();

   setp(_Right.pbase(), _Right.pptr(), _Right.epptr());
   _Right.setp(_Pfirst, _Pnext, _Pend);

   setg(_Right.eback(), _Right.gptr(), _Right.egptr());
   _Right.setg(_Gfirst, _Gnext, _Gend);

   ::std:: swap(_Plocale, _Right._Plocale);
   }
  }
#line 78 "C:\\src\\winrtl\\include\\dinkumware64\\streambuf"
public:
 typedef _Elem char_type;
 typedef _Traits traits_type;

 virtual ~basic_streambuf()
  {
  delete (_Plocale);
  }

 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;

 pos_type pubseekoff(off_type _Off,
  ios_base::seekdir _Way,
  ios_base::openmode _Mode = ios_base::in | ios_base::out)
  {
  return (seekoff(_Off, _Way, _Mode));
  }

 pos_type pubseekoff(off_type _Off,
  ios_base::seek_dir _Way,
  ios_base::open_mode _Mode)
  {
  return (pubseekoff(_Off, (ios_base::seekdir)_Way,
   (ios_base::openmode)_Mode));
  }

 pos_type pubseekpos(pos_type _Pos,
  ios_base::openmode _Mode = ios_base::in | ios_base::out)
  {
  return (seekpos(_Pos, _Mode));
  }

 pos_type pubseekpos(pos_type _Pos,
  ios_base::open_mode _Mode)
  {
  return (seekpos(_Pos, (ios_base::openmode)_Mode));
  }

 _Myt * pubsetbuf(_Elem *_Buffer,
  streamsize _Count)
  {
  return (setbuf(_Buffer, _Count));
  }

 locale pubimbue(const locale &_Newlocale)
  {
  locale _Oldlocale = *_Plocale;
  imbue(_Newlocale);
  *_Plocale = _Newlocale;
  return (_Oldlocale);
  }

 locale getloc() const
  {
  return (*_Plocale);
  }

 streamsize in_avail()
  {
  streamsize _Res = _Gnavail();
  return (0 < _Res ? _Res : showmanyc());
  }

 int pubsync()
  {
  return (sync());
  }

 int_type sbumpc()
  {
  return (0 < _Gnavail()
   ? _Traits::to_int_type(*_Gninc()) : uflow());
  }

 int_type sgetc()
  {
  return (0 < _Gnavail()
   ? _Traits::to_int_type(*gptr()) : underflow());
  }

 streamsize sgetn(_Elem *_Ptr,
  streamsize _Count)
  {
  return (xsgetn(_Ptr, _Count));
  }

 int_type snextc()
  {
  return (1 < _Gnavail()
   ? _Traits::to_int_type(*_Gnpreinc())
   : _Traits::eq_int_type(_Traits::eof(), sbumpc())
    ? _Traits::eof() : sgetc());
  }

 int_type sputbackc(_Elem _Ch)
  {
  return (gptr() != 0 && eback() < gptr()
   && _Traits::eq(_Ch, gptr()[-1])
   ? _Traits::to_int_type(*_Gndec())
   : pbackfail(_Traits::to_int_type(_Ch)));
  }

 void stossc()
  {
  if (0 < _Gnavail())
   _Gninc();
  else
   uflow();
  }

 int_type sungetc()
  {
  return (gptr() != 0 && eback() < gptr()
   ? _Traits::to_int_type(*_Gndec()) : pbackfail());
  }

 int_type sputc(_Elem _Ch)
  {
  return (0 < _Pnavail()
   ? _Traits::to_int_type(*_Pninc() = _Ch)
   : overflow(_Traits::to_int_type(_Ch)));
  }

 streamsize sputn(const _Elem *_Ptr,
  streamsize _Count)
  {
  return (xsputn(_Ptr, _Count));
  }

 virtual void _Lock()
  {



  }

 virtual void _Unlock()
  {



  }

protected:
 _Elem * eback() const
  {
  return (*_IGfirst);
  }

 _Elem * gptr() const
  {
  return (*_IGnext);
  }

 _Elem * pbase() const
  {
  return (*_IPfirst);
  }

 _Elem * pptr() const
  {
  return (*_IPnext);
  }


 _Elem * egptr() const
  {
  return (*_IGnext + *_IGcount);
  }

 void gbump(int _Off)
  {
  *_IGcount -= _Off;
  *_IGnext += _Off;
  }

 void setg(_Elem *_First, _Elem *_Next, _Elem *_Last)
  {
  *_IGfirst = _First;
  *_IGnext = _Next;
  *_IGcount = (int)(_Last - _Next);
  }

 _Elem * epptr() const
  {
  return (*_IPnext + *_IPcount);
  }

 _Elem * _Gndec()
  {
  ++*_IGcount;
  return (--*_IGnext);
  }

 _Elem * _Gninc()
  {
  --*_IGcount;
  return ((*_IGnext)++);
  }

 _Elem * _Gnpreinc()
  {
  --*_IGcount;
  return (++(*_IGnext));
  }

 streamsize _Gnavail() const
  {
  return (*_IGnext != 0 ? *_IGcount : 0);
  }

 void pbump(int _Off)
  {
  *_IPcount -= _Off;
  *_IPnext += _Off;
  }

 void setp(_Elem *_First, _Elem *_Last)
  {
  *_IPfirst = _First;
  *_IPnext = _First;
  *_IPcount = (int)(_Last - _First);
  }

 void setp(_Elem *_First, _Elem *_Next, _Elem *_Last)
  {
  *_IPfirst = _First;
  *_IPnext = _Next;
  *_IPcount = (int)(_Last - _Next);
  }

 _Elem * _Pninc()
  {
  --*_IPcount;
  return ((*_IPnext)++);
  }

 streamsize _Pnavail() const
  {
  return (*_IPnext != 0 ? *_IPcount : 0);
  }

 void _Init()
  {
  _IGfirst = &_Gfirst;
  _IPfirst = &_Pfirst;
  _IGnext = &_Gnext;
  _IPnext = &_Pnext;
  _IGcount = &_Gcount;
  _IPcount = &_Pcount;
  setp(0, 0);
  setg(0, 0, 0);
  }

 void _Init(_Elem **_Gf, _Elem **_Gn, int *_Gc,
  _Elem **_Pf, _Elem **_Pn, int *_Pc)
  {
  _IGfirst = _Gf;
  _IPfirst = _Pf;
  _IGnext = _Gn;
  _IPnext = _Pn;
  _IGcount = _Gc;
  _IPcount = _Pc;
  }
#line 440 "C:\\src\\winrtl\\include\\dinkumware64\\streambuf"
public:
 int allocate()
  {
  return (0);
  }

 _Elem * base() const
  {
  return (eback());
  }

 int blen() const
  {
  return (egptr() == 0 ? 0 : (int)(egptr() - eback()));
  }

 int in_avail() const
  {
  return (egptr() == 0 ? 0 : (int)(egptr() - gptr()));
  }

 int out_waiting() const
  {
  return (epptr() == 0 ? 0 : (int)(epptr() - pptr()));
  }

 void setb(char *, char *, int)
  {
  }


 virtual int_type overflow(int_type = _Traits::eof())
  {
  return (_Traits::eof());
  }

 virtual int_type pbackfail(int_type = _Traits::eof())
  {
  return (_Traits::eof());
  }

 virtual streamsize showmanyc()
  {
  return (0);
  }

 virtual int_type underflow()
  {
  return (_Traits::eof());
  }

 virtual int_type uflow()
  {
  return (_Traits::eq_int_type(_Traits::eof(), underflow())
   ? _Traits::eof() : _Traits::to_int_type(*_Gninc()));
  }

 virtual streamsize xsgetn(_Elem * _Ptr,
  streamsize _Count)
  {
  int_type _Meta;
  streamsize _Size, _Copied;

  for (_Copied = 0; 0 < _Count; )
   if (0 < (_Size = _Gnavail()))
    {
    if (_Count < _Size)
     _Size = _Count;
    _Traits::copy(_Ptr, gptr(), (size_t)_Size);
    _Ptr += _Size;
    _Copied += _Size;
    _Count -= _Size;
    gbump((int)_Size);
    }
   else if (_Traits::eq_int_type(_Traits::eof(), _Meta = uflow()))
    break;
   else
    {
    *_Ptr++ = _Traits::to_char_type(_Meta);
    ++_Copied;
    --_Count;
    }

  return (_Copied);
  }

 virtual streamsize xsputn(const _Elem *_Ptr,
  streamsize _Count)
  {
  streamsize _Size, _Copied;

  for (_Copied = 0; 0 < _Count; )
   if (0 < (_Size = _Pnavail()))
    {
    if (_Count < _Size)
     _Size = _Count;
    _Traits::copy(pptr(), _Ptr, (size_t)_Size);
    _Ptr += _Size;
    _Copied += _Size;
    _Count -= _Size;
    pbump((int)_Size);
    }
   else if (_Traits::eq_int_type(_Traits::eof(),
    overflow(_Traits::to_int_type(*_Ptr))))
    break;
   else
    {
    ++_Ptr;
    ++_Copied;
    --_Count;
    }

  return (_Copied);
  }

 virtual pos_type seekoff(off_type,
  ios_base::seekdir,
  ios_base::openmode = ios_base::in | ios_base::out)
  {
  return (streampos(_BADOFF));
  }

 virtual pos_type seekpos(pos_type,
  ios_base::openmode = ios_base::in | ios_base::out)
  {
  return (streampos(_BADOFF));
  }

 virtual _Myt * setbuf(_Elem *, streamsize)
  {
  return (this);
  }

 virtual int sync()
  {
  return (0);
  }

 virtual void imbue(const locale&)
  {
  }

private:




 _Elem *_Gfirst;
 _Elem *_Pfirst;
 _Elem **_IGfirst;
 _Elem **_IPfirst;
 _Elem *_Gnext;
 _Elem *_Pnext;
 _Elem **_IGnext;
 _Elem **_IPnext;


 int _Gcount;
 int _Pcount;
 int *_IGcount;
 int *_IPcount;
#line 609 "C:\\src\\winrtl\\include\\dinkumware64\\streambuf"
protected:
 locale *_Plocale;
 };


template<class _Elem,
 class _Traits>
 class istreambuf_iterator
  : public iterator<input_iterator_tag,
   _Elem, typename _Traits::off_type, const _Elem *, _Elem>
 {
 typedef istreambuf_iterator<_Elem, _Traits> _Myt;
public:
 typedef _Elem char_type;
 typedef _Traits traits_type;
 typedef basic_streambuf<_Elem, _Traits> streambuf_type;
 typedef basic_istream<_Elem, _Traits> istream_type;

 typedef typename traits_type::int_type int_type;
 typedef const _Elem *pointer;

            istreambuf_iterator(streambuf_type *_Sb = 0)
  : _Strbuf(_Sb), _Got(_Sb == 0)
  {
  }

 istreambuf_iterator(istream_type& _Istr)
  : _Strbuf(_Istr.rdbuf()), _Got(_Istr.rdbuf() == 0)
  {
  }







 _Elem operator*() const
  {
  if (!_Got)
   _Peek();






  return (_Val);
  }

 const _Elem *operator->() const
  {
  return (::std:: pointer_traits<pointer>::pointer_to(**this));
  }

 _Myt& operator++()
  {





  _Inc();
  return (*this);
  }

 _Myt operator++(int)
  {
  if (!_Got)
   _Peek();
  _Myt _Tmp = *this;
  ++*this;
  return (_Tmp);
  }

 bool equal(const _Myt& _Right) const
  {
  if (!_Got)
   _Peek();
  if (!_Right._Got)
   _Right._Peek();
  return ((_Strbuf == 0 && _Right._Strbuf == 0)
   || (_Strbuf != 0 && _Right._Strbuf != 0));
  }

private:
 void _Inc()
  {
  if (_Strbuf == 0
   || traits_type::eq_int_type(traits_type::eof(),
    _Strbuf->sbumpc()))
   _Strbuf = 0, _Got = true;
  else
   _Got = false;
  }

 _Elem _Peek() const
  {
  int_type _Meta;
  if (_Strbuf == 0
   || traits_type::eq_int_type(traits_type::eof(),
    _Meta = _Strbuf->sgetc()))
   _Strbuf = 0;
  else
   _Val = traits_type::to_char_type(_Meta);
  _Got = true;
  return (_Val);
  }

 mutable streambuf_type *_Strbuf;
 mutable bool _Got;
 mutable _Elem _Val;
 };

template<class _Elem,
 class _Traits>
 struct _Is_checked_helper<istreambuf_iterator<_Elem, _Traits> >
  : public true_type
 {
 };


template<class _Elem,
 class _Traits> inline
 bool operator==(
  const istreambuf_iterator<_Elem, _Traits>& _Left,
  const istreambuf_iterator<_Elem, _Traits>& _Right)
 {
 return (_Left.equal(_Right));
 }

template<class _Elem,
 class _Traits> inline
 bool operator!=(
  const istreambuf_iterator<_Elem, _Traits>& _Left,
  const istreambuf_iterator<_Elem, _Traits>& _Right)
 {
 return (!(_Left == _Right));
 }


template<class _Elem,
 class _Traits>
 class ostreambuf_iterator
  : public _Outit
 {
 typedef ostreambuf_iterator<_Elem, _Traits> _Myt;
public:
 typedef _Elem char_type;
 typedef _Traits traits_type;
 typedef basic_streambuf<_Elem, _Traits> streambuf_type;
 typedef basic_ostream<_Elem, _Traits> ostream_type;

 ostreambuf_iterator(streambuf_type *_Sb)
  : _Failed(false), _Strbuf(_Sb)
  {
  }

 ostreambuf_iterator(ostream_type& _Ostr)
  : _Failed(false), _Strbuf(_Ostr.rdbuf())
  {
  }

 _Myt& operator=(_Elem _Right)
  {
  if (_Strbuf == 0
   || traits_type::eq_int_type(_Traits::eof(),
    _Strbuf->sputc(_Right)))
   _Failed = true;
  return (*this);
  }

 _Myt& operator*()
  {
  return (*this);
  }

 _Myt& operator++()
  {
  return (*this);
  }

 _Myt& operator++(int)
  {
  return (*this);
  }

 bool failed() const
  {
  return (_Failed);
  }

private:
 bool _Failed;
 streambuf_type *_Strbuf;
 };

template<class _Elem,
 class _Traits>
 struct _Is_checked_helper<ostreambuf_iterator<_Elem, _Traits> >
  : public true_type
 {
 };
}
#line 8 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"



namespace std {
extern "C" {
extern __declspec(dllexport) float _Stofx(const char *, char **,
 long, int *);
extern __declspec(dllexport) double _Stodx(const char *, char **,
 long, int *);
extern __declspec(dllexport) long double _Stoldx(const char *, char **,
 long, int *);
extern __declspec(dllexport) long _Stolx(const char *, char **,
 int, int *);
extern __declspec(dllexport) unsigned long _Stoulx(const char *, char **,
 int, int *);
extern __declspec(dllexport) long long _Stollx(const char *, char **,
 int, int *);
extern __declspec(dllexport) unsigned long long _Stoullx(const char *, char **,
 int, int *);
}
}

namespace std {



template<class _Elem> inline
 size_t _Find_elem(_Elem *_Base, _Elem _Ch)
 {
 _Elem *_Ptr = _Base;
 for (; *_Ptr != (_Elem)0 && *_Ptr != _Ch; ++_Ptr)
  ;
 return ((size_t)(_Ptr - _Base));
 }

inline wchar_t *_Maklocwcs(const wchar_t *_Ptr)
 {
 size_t _Count = ::std:: wcslen(_Ptr) + 1;
 wchar_t *_Ptrdest = new wchar_t[_Count];
 ::std:: wmemcpy(_Ptrdest, _Ptr, _Count);
 return (_Ptrdest);
 }


template<class _Elem>
 class numpunct
  : public locale::facet
 {
public:
 typedef basic_string<_Elem, char_traits<_Elem>, allocator<_Elem> >
  string_type;
 typedef _Elem char_type;

 static locale::id id;

 _Elem decimal_point() const
  {
  return (do_decimal_point());
  }

 _Elem thousands_sep() const
  {
  return (do_thousands_sep());
  }

 string grouping() const
  {
  return (do_grouping());
  }

 string_type falsename() const
  {
  return (do_falsename());
  }

 string_type truename() const
  {
  return (do_truename());
  }

 explicit numpunct(size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
   if (_Kseparator == 0)
    _Kseparator =
     _Maklocchr(',', (_Elem *)0, _Lobj._Getcvt());
  }
  }

 numpunct(const _Locinfo& _Lobj, size_t _Refs = 0, bool _Isdef = false)
  : locale::facet(_Refs)
  {
  _Init(_Lobj, _Isdef);
  }

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new numpunct<_Elem>(
    _Locinfo(_Ploc->c_str()), 0, true);
  return (3);
  }

protected:
 virtual ~numpunct()
  {
  _Tidy();
  }

 numpunct(const char *_Locname, size_t _Refs = 0, bool _Isdef = false)
  : locale::facet(_Refs)
  {
  { _Locinfo _Lobj(_Locname);
   _Init(_Lobj, _Isdef);
  }
  }

 template<class _Elem2>
  void _Getvals(_Elem2, const lconv *_Ptr, _Locinfo::_Cvtvec _Cvt)
  {
  _Dp = _Maklocchr(_Ptr->decimal_point[0], (_Elem2 *)0, _Cvt);
  _Kseparator = _Maklocchr(_Ptr->thousands_sep[0], (_Elem2 *)0, _Cvt);
  }

 void _Init(const _Locinfo& _Lobj, bool _Isdef = false)
  {
  const lconv *_Ptr = _Lobj._Getlconv();
  _Locinfo::_Cvtvec _Cvt = _Lobj._Getcvt();

  _Grouping = 0;
  _Falsename = 0;
  _Truename = 0;

  {{
  _Grouping = _Maklocstr(_Isdef ? "" : _Ptr->grouping, (char *)0, _Lobj._Getcvt());

  _Falsename = _Maklocstr(_Lobj._Getfalse(), (_Elem *)0, _Cvt);
  _Truename = _Maklocstr(_Lobj._Gettrue(), (_Elem *)0, _Cvt);
  } if (0) {
  _Tidy();
          ;
  }}

  if (_Isdef)
   {

   _Dp = _Maklocchr('.', (_Elem *)0, _Cvt);
   _Kseparator = _Maklocchr(',', (_Elem *)0, _Cvt);
   }
  else
   _Getvals((_Elem)0, _Ptr, _Cvt);
  }

 virtual _Elem do_decimal_point() const
  {
  return (_Dp);
  }

 virtual _Elem do_thousands_sep() const
  {
  return (_Kseparator);
  }

 virtual string do_grouping() const
  {
  return (string(_Grouping));
  }

 virtual string_type do_falsename() const
  {
  return (string_type(_Falsename));
  }

 virtual string_type do_truename() const
  {
  return (string_type(_Truename));
  }

private:
 void _Tidy()
  {
  delete[] _Grouping;
  delete[] _Falsename;
  delete[] _Truename;
 }

 const char *_Grouping;
 _Elem _Dp;
 _Elem _Kseparator;
 const _Elem *_Falsename;
 const _Elem *_Truename;
 };


template<class _Elem>
 class numpunct_byname
  : public numpunct<_Elem>
 {
public:
 explicit numpunct_byname(const char *_Locname, size_t _Refs = 0)
  : numpunct<_Elem>(_Locname, _Refs)
  {
  }


 explicit numpunct_byname(const string& _Str, size_t _Refs = 0)
  : numpunct<_Elem>(_Str.c_str(), _Refs)
  {
  }


protected:
 virtual ~numpunct_byname()
  {
  }
 };


template<class _Elem>
 locale::id numpunct<_Elem>::id;


template<class _Elem,
 class _InIt = istreambuf_iterator<_Elem, char_traits<_Elem> > >
 class num_get
  : public locale::facet
 {
public:
 typedef numpunct<_Elem> _Mypunct;
 typedef basic_string<_Elem, char_traits<_Elem>, allocator<_Elem> >
  _Mystr;

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new num_get<_Elem, _InIt>(
    _Locinfo(_Ploc->c_str()));
  return (3);
  }

 static locale::id id;

protected:
 virtual ~num_get()
  {
  }

 void _Init(const _Locinfo&)
  {
  }

public:
 explicit num_get(size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        num_get(const _Locinfo& _Lobj, size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  _Init(_Lobj);
  }

 typedef _Elem char_type;
 typedef _InIt iter_type;

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   _Bool& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned short& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned int& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   long& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned long& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }


 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   long long& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned long long& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }


 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   float& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   double& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   long double& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

 _InIt get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   void *& _Val) const
  {
  return (do_get(_First, _Last, _Iosbase, _State, _Val));
  }

protected:
 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   _Bool& _Val) const
  {
                             ;
  int _Ans = -1;

  if (_Iosbase.flags() & ios_base::boolalpha)
   {
   typedef typename _Mystr::size_type _Mystrsize;
   const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
   _Mystr _Str((_Mystrsize)1, (char_type)0);
   _Str += _Punct_fac.falsename();
   _Str += (char_type)0;
   _Str += _Punct_fac.truename();
   _Ans = _Getloctxt(_First, _Last, (size_t)2, _Str.c_str());
   }
  else
   {
   char _Ac[32], *_Ep;
   int _Errno = 0;
   const unsigned long _Ulo = ::std:: _Stoulx(_Ac, &_Ep,
    _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
     _Iosbase.getloc()), &_Errno);
   if (_Ep != _Ac && _Errno == 0 && _Ulo <= 1)
    _Ans = _Ulo;
   }

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ans < 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans != 0;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned short& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;
  int _Base = _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
   _Iosbase.getloc());
  char *_Ptr = _Ac[0] == '-' ? _Ac + 1 : _Ac;
  const unsigned long _Ans =
   ::std:: _Stoulx(_Ptr, &_Ep, _Base, &_Errno);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ptr || _Errno != 0 || 65535U < _Ans)
   _State |= ios_base::failbit;
  else
   _Val = (unsigned short)(_Ac[0] == '-'
    ? 0 -_Ans : _Ans);
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned int& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;
  int _Base = _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
   _Iosbase.getloc());
  char *_Ptr = _Ac[0] == '-' ? _Ac + 1 : _Ac;
  const unsigned long _Ans =
   ::std:: _Stoulx(_Ptr, &_Ep, _Base, &_Errno);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ptr || _Errno != 0 || 4294967295UL < _Ans)
   _State |= ios_base::failbit;
  else
   _Val = _Ac[0] == '-' ? 0 -_Ans : _Ans;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   long& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;
  const long _Ans = ::std:: _Stolx(_Ac, &_Ep,
   _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
    _Iosbase.getloc()), &_Errno);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned long& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;
  const unsigned long _Ans = ::std:: _Stoulx(_Ac, &_Ep,
   _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
    _Iosbase.getloc()), &_Errno);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }


 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   long long& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;
  const long long _Ans = ::std:: _Stollx(_Ac, &_Ep,
   _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
    _Iosbase.getloc()), &_Errno);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   unsigned long long& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;
  const unsigned long long _Ans = ::std:: _Stoullx(_Ac, &_Ep,
   _Getifld(_Ac, _First, _Last, _Iosbase.flags(),
    _Iosbase.getloc()), &_Errno);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }


 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   float& _Val) const
  {
                             ;
  char _Ac[8 + 48 + 16], *_Ep;
  int _Errno = 0;
  int _Hexexp = 0;
  float _Ans = ::std:: _Stofx(_Ac, &_Ep,
   _Getffld(_Ac, _First, _Last,
    _Iosbase, &_Hexexp), &_Errno);

  if (_Hexexp != 0)
   _Ans = ::std:: ldexpf(_Ans, 4 * _Hexexp);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   double& _Val) const
  {
                             ;
  char _Ac[8 + 48 + 16], *_Ep;
  int _Errno = 0;
  int _Hexexp = 0;
  double _Ans = ::std:: _Stodx(_Ac, &_Ep,
   _Getffld(_Ac, _First, _Last,
    _Iosbase, &_Hexexp), &_Errno);

  if (_Hexexp != 0)
   _Ans = ::std:: ldexp(_Ans, 4 * _Hexexp);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   long double& _Val) const
  {
                             ;
  char _Ac[8 + 48 + 16], *_Ep;
  int _Errno = 0;
  int _Hexexp = 0;
  long double _Ans = ::std:: _Stoldx(_Ac, &_Ep,
   _Getffld(_Ac, _First, _Last,
    _Iosbase, &_Hexexp), &_Errno);

  if (_Hexexp != 0)
   _Ans = ::std:: ldexpl(_Ans, 4 * _Hexexp);

  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = _Ans;
  return (_First);
  }

 virtual _InIt do_get(_InIt _First, _InIt _Last,
  ios_base& _Iosbase, ios_base::iostate& _State,
   void *& _Val) const
  {
                             ;
  char _Ac[32], *_Ep;
  int _Errno = 0;


  int _Base = _Getifld(_Ac, _First, _Last, ios_base::hex,
   _Iosbase.getloc());
  const unsigned long long _Ans =
   (sizeof (void *) == sizeof (unsigned long))
    ? (unsigned long long)::std:: _Stoulx(_Ac, &_Ep, _Base, &_Errno)
    : ::std:: _Stoullx(_Ac, &_Ep, _Base, &_Errno);







  if (_First == _Last)
   _State |= ios_base::eofbit;
  if (_Ep == _Ac || _Errno != 0)
   _State |= ios_base::failbit;
  else
   _Val = (void *)((char *)0 + _Ans);
  return (_First);
  }

private:
 int _Getifld(char *_Ac,
  _InIt& _First, _InIt& _Last, ios_base::fmtflags _Basefield,
   const locale& _Loc) const
  {
  const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Loc);
  const string _Grouping = _Punct_fac.grouping();
  const _Elem _Kseparator = _Grouping.size() == 0
   ? (_Elem)0 : _Punct_fac.thousands_sep();

  enum {
   _NUMGET_SIGNOFF = 22,
   _NUMGET_XOFF = 24};
  static const char _Src[] = {"0123456789ABCDEFabcdef-+Xx"};
  _Elem _Atoms[sizeof (_Src) - 1];
  const ctype<_Elem>& _Ctype_fac =
   use_facet< ctype<_Elem> >(_Loc);
  _Ctype_fac.widen(&_Src[0], &_Src[sizeof (_Src) - 1], _Atoms);

  char *_Ptr = _Ac;

  if (_First == _Last)
   ;
  else if (*_First == _Atoms[_NUMGET_SIGNOFF + 1])
   *_Ptr++ = '+', ++_First;
  else if (*_First == _Atoms[_NUMGET_SIGNOFF])
   *_Ptr++ = '-', ++_First;

  _Basefield &= ios_base::basefield;
  int _Base = _Basefield == ios_base::oct ? 8
   : _Basefield == ios_base::hex ? 16
   : _Basefield == ios_base::_Fmtzero ? 0 : 10;

  bool _Seendigit = false;
  bool _Nonzero = false;

  if (_First != _Last && *_First == _Atoms[0])
   {
   _Seendigit = true, ++_First;
   if (_First != _Last && (*_First == _Atoms[_NUMGET_XOFF + 1]
     || *_First == _Atoms[_NUMGET_XOFF])
    && (_Base == 0 || _Base == 16))
    _Base = 16, _Seendigit = false, ++_First;
   else if (_Base == 0)
    _Base = 8;
   }

  size_t _Dlen = _Base == 0 || _Base == 10 ? 10
   : _Base == 8 ? 8 : 16 + 6;
  string _Groups((size_t)1, (char)_Seendigit);
  size_t _Group = 0;

  for (char *const _Pe = &_Ac[32 - 1];
   _First != _Last; ++_First)
   {
   size_t _Idx = _Find_elem(_Atoms, *_First);
   if (_Idx < _Dlen)
    {
    *_Ptr = _Src[_Idx];
    if ((_Nonzero || *_Ptr != '0') && _Ptr < _Pe)
     ++_Ptr, _Nonzero = true;
    _Seendigit = true;
    if (_Groups[_Group] != 127)
     ++_Groups[_Group];
    }
   else if (_Groups[_Group] == '\0'
    || _Kseparator == (_Elem)0
    || *_First != _Kseparator)
    break;
   else
    {
    _Groups.append((string::size_type)1, '\0');
    ++_Group;
    }
   }

  if (_Group == 0)
   ;
  else if ('\0' < _Groups[_Group])
   ++_Group;
  else
   _Seendigit = false;

  for (const char *_Pg = &_Grouping[0]; _Seendigit && 0 < _Group; )
   if (*_Pg == 127)
    break;
   else if ((0 < --_Group && *_Pg != _Groups[_Group])
    || (0 == _Group && *_Pg < _Groups[_Group]))
    _Seendigit = false;
   else if ('\0' < _Pg[1])
    ++_Pg;

  if (_Seendigit && !_Nonzero)
   *_Ptr++ = '0';
  else if (!_Seendigit)
   _Ptr = _Ac;
  *_Ptr = '\0';
  return (_Base);
  }

 int _Getffld(char *_Ac,
  _InIt& _First, _InIt &_Last,
  ios_base& _Iosbase, int *_Phexexp) const
  {
  if ((_Iosbase.flags() & ios_base::floatfield) == ios_base::hexfloat)
   return (_Getffldx(_Ac, _First, _Last,
    _Iosbase, _Phexexp));

  const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  const string _Grouping = _Punct_fac.grouping();
  char *_Ptr = _Ac;
  bool _Bad = false;

  enum {
   _NUMGET_SIGNOFF = 10,
   _NUMGET_EOFF = 12};
  static const char _Src[] = {"0123456789-+Ee"};
  _Elem _Atoms[sizeof (_Src) - 1];
  const ctype<_Elem>& _Ctype_fac =
   use_facet< ctype<_Elem> >(_Iosbase.getloc());
  _Ctype_fac.widen(&_Src[0], &_Src[sizeof (_Src) - 1], _Atoms);

  if (_First == _Last)
   ;
  else if (*_First == _Atoms[_NUMGET_SIGNOFF + 1])
   *_Ptr++ = '+', ++_First;
  else if (*_First == _Atoms[_NUMGET_SIGNOFF])
   *_Ptr++ = '-', ++_First;

  bool _Seendigit = false;
  int _Significant = 0;
  int _Pten = 0;
  size_t _Idx;

  const char *_Pg = &_Grouping[0];
  if (*_Pg == 127 || *_Pg <= '\0')
   for (; _First != _Last
    && (_Idx = _Find_elem(_Atoms, *_First)) < 10;
     _Seendigit = true, ++_First)
    if (48 <= _Significant)
     ++_Pten;
    else if (_Idx == 0 && _Significant == 0)
     ;
    else
     {
     *_Ptr++ = _Src[_Idx];
     ++_Significant;
     }
  else
   {
   const _Elem _Kseparator = _Grouping.size() == 0
    ? (_Elem)0 : _Punct_fac.thousands_sep();
   string _Groups((size_t)1, '\0');
   size_t _Group = 0;

   for (; _First != _Last; ++_First)
    if ((_Idx = _Find_elem(_Atoms, *_First)) < 10)
     {
     _Seendigit = true;
     if (48 <= _Significant)
      ++_Pten;
     else if (_Idx == 0 && _Significant == 0)
      ;
     else
      {
      *_Ptr++ = _Src[_Idx];
      ++_Significant;
      }
     if (_Groups[_Group] != 127)
      ++_Groups[_Group];
     }
    else if (_Groups[_Group] == '\0'
     || _Kseparator == (_Elem)0
     || *_First != _Kseparator)
     break;
    else
     {
     _Groups.append((size_t)1, '\0');
     ++_Group;
     }
   if (_Group == 0)
    ;
   else if ('\0' < _Groups[_Group])
    ++_Group;
   else
    _Bad = true;

   while (!_Bad && 0 < _Group)
    if (*_Pg == 127)
     break;
    else if ((0 < --_Group && *_Pg != _Groups[_Group])
     || (0 == _Group && *_Pg < _Groups[_Group]))
     _Bad = true;
    else if ('\0' < _Pg[1])
     ++_Pg;
   }

  if (_Seendigit && _Significant == 0)
   *_Ptr++ = '0';

  if (_First != _Last && *_First == _Punct_fac.decimal_point())
   *_Ptr++ = localeconv()->decimal_point[0], ++_First;

  if (_Significant == 0)
   {
   for (; _First != _Last && *_First == _Atoms[0];
    _Seendigit = true, ++_First)
    --_Pten;
   if (_Pten < 0)
    *_Ptr++ = '0', ++_Pten;
   }

  for (; _First != _Last
    && (_Idx = _Find_elem(_Atoms, *_First)) < 10;
    _Seendigit = true, ++_First)
   if (_Significant < 48)
    {
    *_Ptr++ = _Src[_Idx];
    ++_Significant;
    }

  if (_Seendigit && _First != _Last
   && (*_First == _Atoms[_NUMGET_EOFF + 1]
    || *_First == _Atoms[_NUMGET_EOFF]))
   {
   *_Ptr++ = 'e', ++_First;
   _Seendigit = false, _Significant = 0;

   if (_First == _Last)
    ;
   else if (*_First == _Atoms[_NUMGET_SIGNOFF + 1])
    *_Ptr++ = '+', ++_First;
   else if (*_First == _Atoms[_NUMGET_SIGNOFF])
    *_Ptr++ = '-', ++_First;
   for (; _First != _Last && *_First == _Atoms[0]; )
    _Seendigit = true, ++_First;
   if (_Seendigit)
    *_Ptr++ = '0';
   for (; _First != _Last
    && (_Idx = _Find_elem(_Atoms, *_First)) < 10;
    _Seendigit = true, ++_First)
    if (_Significant < 8)
     {
     *_Ptr++ = _Src[_Idx];
     ++_Significant;
     }
   }

  if (_Bad || !_Seendigit)
   _Ptr = _Ac;
  *_Ptr = '\0';
  return (_Pten);
  }

 int _Getffldx(char *_Ac,
  _InIt& _First, _InIt &_Last,
  ios_base& _Iosbase, int *_Phexexp) const
  {
  const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  const string _Grouping = _Punct_fac.grouping();

  enum {
   _NUMGET_SIGNOFF = 22,
   _NUMGET_XOFF = 24,
   _NUMGET_POFF = 26};
  static const char _Src[] = {"0123456789ABCDEFabcdef-+XxPp"};
  _Elem _Atoms[sizeof (_Src) - 1];
  const ctype<_Elem>& _Ctype_fac =
   use_facet< ctype<_Elem> >(_Iosbase.getloc());
  _Ctype_fac.widen(&_Src[0], &_Src[sizeof (_Src) - 1], _Atoms);

  char *_Ptr = _Ac;
  bool _Bad = false;
  size_t _Idx;

  if (_First == _Last)
   ;
  else if (*_First == _Atoms[_NUMGET_SIGNOFF + 1])
   *_Ptr++ = '+', ++_First;
  else if (*_First == _Atoms[_NUMGET_SIGNOFF])
   *_Ptr++ = '-', ++_First;

  *_Ptr++ = '0';
  *_Ptr++ = 'x';

  bool _Seendigit = false;
  int _Significant = 0;
  int _Phex = 0;

  if (_First == _Last || *_First != _Atoms[0])
   ;
  else if (++_First != _Last
   && (*_First == _Atoms[_NUMGET_XOFF + 1]
     || *_First == _Atoms[_NUMGET_XOFF]))
   ++_First;
  else
   _Seendigit = true;

  const char *_Pg = &_Grouping[0];
  if (*_Pg == 127 || *_Pg <= '\0')
   for (; _First != _Last
    && (_Idx = _Find_elem(_Atoms, *_First)) < _NUMGET_SIGNOFF;
     _Seendigit = true, ++_First)
    if (48 <= _Significant)
     ++_Phex;
    else if (_Idx == 0 && _Significant == 0)
     ;
    else
     {
     *_Ptr++ = _Src[_Idx];
     ++_Significant;
     }
  else
   {
   const _Elem _Kseparator = _Grouping.size() == 0
    ? (_Elem)0 : _Punct_fac.thousands_sep();
   string _Groups((size_t)1, '\0');
   size_t _Group = 0;

   for (; _First != _Last; ++_First)
    if ((_Idx = _Find_elem(_Atoms, *_First)) < _NUMGET_SIGNOFF)
     {
     _Seendigit = true;
     if (48 <= _Significant)
      ++_Phex;
     else if (_Idx == 0 && _Significant == 0)
      ;
     else
      {
      *_Ptr++ = _Src[_Idx];
      ++_Significant;
      }
     if (_Groups[_Group] != 127)
      ++_Groups[_Group];
     }
    else if (_Groups[_Group] == '\0'
     || _Kseparator == (_Elem)0
     || *_First != _Kseparator)
     break;
    else
     {
     _Groups.append((size_t)1, '\0');
     ++_Group;
     }
   if (_Group == 0)
    ;
   else if ('\0' < _Groups[_Group])
    ++_Group;
   else
    _Bad = true;

   while (!_Bad && 0 < _Group)
    if (*_Pg == 127)
     break;
    else if ((0 < --_Group && *_Pg != _Groups[_Group])
     || (0 == _Group && *_Pg < _Groups[_Group]))
     _Bad = true;
    else if ('\0' < _Pg[1])
     ++_Pg;
   }

  if (_Seendigit && _Significant == 0)
   *_Ptr++ = '0';

  if (_First != _Last && *_First == _Punct_fac.decimal_point())
   *_Ptr++ = localeconv()->decimal_point[0], ++_First;

  if (_Significant == 0)
   {
   for (; _First != _Last && *_First == _Atoms[0];
    _Seendigit = true, ++_First)
    --_Phex;
   if (_Phex < 0)
    *_Ptr++ = '0', ++_Phex;
   }

  for (; _First != _Last
    && (_Idx = _Find_elem(_Atoms, *_First)) < _NUMGET_SIGNOFF;
    _Seendigit = true, ++_First)
   if (_Significant < 48)
    {
    *_Ptr++ = _Src[_Idx];
    ++_Significant;
    }

  if (_Seendigit && _First != _Last
   && (*_First == _Atoms[_NUMGET_POFF + 1]
    || *_First == _Atoms[_NUMGET_POFF]))
   {
   *_Ptr++ = 'p', ++_First;
   _Seendigit = false, _Significant = 0;

   if (_First == _Last)
    ;
   else if (*_First == _Atoms[_NUMGET_SIGNOFF + 1])
    *_Ptr++ = '+', ++_First;
   else if (*_First == _Atoms[_NUMGET_SIGNOFF])
    *_Ptr++ = '-', ++_First;
   for (; _First != _Last && *_First == _Atoms[0]; )
    _Seendigit = true, ++_First;
   if (_Seendigit)
    *_Ptr++ = '0';
   for (; _First != _Last
    && (_Idx = _Find_elem(_Atoms, *_First)) < _NUMGET_SIGNOFF;
    _Seendigit = true, ++_First)
    if (_Significant < 8)
     {
     *_Ptr++ = _Src[_Idx];
     ++_Significant;
     }
   }

  if (_Bad || !_Seendigit)
   _Ptr = _Ac;
  *_Ptr = '\0';
  *_Phexexp = _Phex;
  return (0);
  }
 };


template<class _Elem,
 class _InIt>
 locale::id num_get<_Elem, _InIt>::id;


template<class _Elem,
 class _OutIt = ostreambuf_iterator<_Elem, char_traits<_Elem> > >
 class num_put
  : public locale::facet
 {
public:
 typedef numpunct<_Elem> _Mypunct;
 typedef basic_string<_Elem, char_traits<_Elem>, allocator<_Elem> >
  _Mystr;

 static size_t _Getcat(const locale::facet **_Ppf = 0,
  const locale *_Ploc = 0)
  {
  if (_Ppf != 0 && *_Ppf == 0)
   *_Ppf = new num_put<_Elem, _OutIt>(
    _Locinfo(_Ploc->c_str()));
  return (3);
  }

 static locale::id id;

protected:
 virtual ~num_put()
  {
  }

 void _Init(const _Locinfo&)
  {
  }

public:
 explicit num_put(size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  { _Locinfo _Lobj;
   _Init(_Lobj);
  }
  }

        num_put(const _Locinfo& _Lobj, size_t _Refs = 0)
  : locale::facet(_Refs)
  {
  _Init(_Lobj);
  }

 typedef _Elem char_type;
 typedef _OutIt iter_type;

 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, _Bool _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }

 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, long _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }

 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, unsigned long _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }


 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, long long _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }

 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, unsigned long long _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }


 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, double _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }

 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, long double _Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }

 _OutIt put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, const void *_Val) const
  {
  return (do_put(_Dest, _Iosbase, _Fill, _Val));
  }

protected:
 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, _Bool _Val) const
  {
                       ;
  if (!(_Iosbase.flags() & ios_base::boolalpha))
   return (do_put(_Dest, _Iosbase, _Fill, (long)_Val));
  else
   {
   const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
   _Mystr _Str;
   if (_Val)
    _Str.assign(_Punct_fac.truename());
   else
    _Str.assign(_Punct_fac.falsename());

   size_t _Fillcount = _Iosbase.width() <= 0
    || (size_t)_Iosbase.width() <= _Str.size()
     ? 0 : (size_t)_Iosbase.width() - _Str.size();

   if ((_Iosbase.flags() & ios_base::adjustfield) != ios_base::left)
    {
    _Dest = _Rep(_Dest, _Fill, _Fillcount);
    _Fillcount = 0;
    }
   _Dest = _Put(_Dest, _Str.c_str(), _Str.size());
   _Iosbase.width(0);
   return (_Rep(_Dest, _Fill, _Fillcount));
   }
  }

 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, long _Val) const
  {
  char _Buf[2 * 32], _Fmt[6];
  return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
   ::std:: sprintf(_Buf, _Ifmt(_Fmt, "ld",
    _Iosbase.flags()), _Val)));
  }

 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, unsigned long _Val) const
  {
  char _Buf[2 * 32], _Fmt[6];
  return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
   ::std:: sprintf(_Buf, _Ifmt(_Fmt, "lu",
    _Iosbase.flags()), _Val)));
  }


 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, long long _Val) const
  {
  char _Buf[2 * 32], _Fmt[8];
  return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
   ::std:: sprintf(_Buf, _Ifmt(_Fmt, "Ld",
    _Iosbase.flags()), _Val)));
  }

 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, unsigned long long _Val) const
  {
  char _Buf[2 * 32], _Fmt[8];
  return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
   ::std:: sprintf(_Buf, _Ifmt(_Fmt, "Lu",
    _Iosbase.flags()), _Val)));
  }


 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, double _Val) const
  {
  char _Buf[8 + 48 + 64], _Fmt[8];
  streamsize _Precision = _Iosbase.precision() <= 0
   && !(_Iosbase.flags() & ios_base::fixed)
    ? 6 : _Iosbase.precision();
  int _Significance = 48 < _Precision
   ? 48 : (int)_Precision;
  _Precision -= _Significance;
  size_t _Beforepoint = 0;
  size_t _Afterpoint = 0;

  if ((_Iosbase.flags() & ios_base::floatfield) == ios_base::fixed
   && _Val * 0.5 != _Val)
   {
   bool _Signed = _Val < 0;
   if (_Signed)
    _Val = -_Val;

   for (; 1e35 <= _Val && _Beforepoint < 5000; _Beforepoint += 10)
    _Val /= 1e10;

   if (0 < _Val)
    for (; 10 <= _Precision && _Val <= 1e-35
     && _Afterpoint < 5000; _Afterpoint += 10)
     {
     _Val *= 1e10;
     _Precision -= 10;
     }

   if (_Signed)
    _Val = -_Val;
   }

  return (_Fput(_Dest, _Iosbase, _Fill, _Buf,
   _Beforepoint, _Afterpoint, (size_t)_Precision,
    ::std:: sprintf(_Buf,
     _Ffmt(_Fmt, 0, _Iosbase.flags()),
     _Significance, _Val)));
  }

 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, long double _Val) const
  {
  char _Buf[8 + 48 + 64], _Fmt[8];
  streamsize _Precision = _Iosbase.precision() <= 0
   && !(_Iosbase.flags() & ios_base::fixed)
    ? 6 : _Iosbase.precision();
  int _Significance = 48 < _Precision
   ? 48 : (int)_Precision;
  _Precision -= _Significance;
  size_t _Beforepoint = 0;
  size_t _Afterpoint = 0;

  if ((_Iosbase.flags() & ios_base::floatfield) == ios_base::fixed)
   {
   bool _Signed = _Val < 0;
   if (_Signed)
    _Val = -_Val;

   for (; 1e35 <= _Val && _Beforepoint < 5000; _Beforepoint += 10)
    _Val /= 1e10;

   if (0 < _Val)
    for (; 10 <= _Precision && _Val <= 1e-35
     && _Afterpoint < 5000; _Afterpoint += 10)
     {
     _Val *= 1e10;
     _Precision -= 10;
     }

   if (_Signed)
    _Val = -_Val;
   }

  return (_Fput(_Dest, _Iosbase, _Fill, _Buf,
   _Beforepoint, _Afterpoint, (size_t)_Precision,
    ::std:: sprintf(_Buf,
     _Ffmt(_Fmt, 'L', _Iosbase.flags()),
     _Significance, _Val)));
  }

 virtual _OutIt do_put(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, const void *_Val) const
  {

  char _Buf[2 * 32], _Fmt[8];
  unsigned long long _Off = (unsigned long long)((char *)_Val - (char *)0);
  if (sizeof (void *) == sizeof (unsigned long))
   _Off = (unsigned long)_Off;
  return (_Iput(_Dest, _Iosbase, _Fill, _Buf,
   ::std:: sprintf(_Buf, _Ifmt(_Fmt, "Lu",
    ios_base::hex), _Off)));
#line 1323 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"
  }

private:
 char * _Ffmt(char *_Fmt,
  char _Spec, ios_base::fmtflags _Flags) const
  {
  char *_Ptr = _Fmt;
  *_Ptr++ = '%';

  if (_Flags & ios_base::showpos)
   *_Ptr++ = '+';
  if (_Flags & ios_base::showpoint)
   *_Ptr++ = '#';
  *_Ptr++ = '.';
  *_Ptr++ = '*';
  if (_Spec != '\0')
   *_Ptr++ = _Spec;

  ios_base::fmtflags _Ffl = _Flags & ios_base::floatfield;
  if (_Flags & ios_base::uppercase)
   *_Ptr++ = _Ffl == ios_base::fixed ? 'f'
    : _Ffl == ios_base::hexfloat ? 'A'
    : _Ffl == ios_base::scientific ? 'E' : 'G';
  else
   *_Ptr++ = _Ffl == ios_base::fixed ? 'f'
    : _Ffl == ios_base::hexfloat ? 'a'
    : _Ffl == ios_base::scientific ? 'e' : 'g';

  *_Ptr = '\0';
  return (_Fmt);
  }

 _OutIt _Fput(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, const char *_Buf,
   size_t _Beforepoint, size_t _Afterpoint,
    size_t _Trailing, size_t _Count) const
  {
                       ;
  size_t _Prefix = 0 < _Count && (*_Buf == '+' || *_Buf == '-')
   ? 1 : 0;

  const char *_Exps;
  if ((_Iosbase.flags() & ios_base::floatfield) != ios_base::hexfloat)
   _Exps = "eE";
  else
   {
   _Exps = "pP";
   if (_Prefix + 2 <= _Count && _Buf[_Prefix] == '0'
    && (_Buf[_Prefix + 1] == 'x' || _Buf[_Prefix + 1] == 'X'))
    _Prefix += 2;
   }
  const size_t _Eoff =
   ::std:: strcspn(&_Buf[0], _Exps);
  char _Dp[2] = {"."};
  _Dp[0] = ::std:: localeconv()->decimal_point[0];
  const size_t _Poff =
   ::std:: strcspn(&_Buf[0], &_Dp[0]);

  const ctype<_Elem>& _Ctype_fac =
   use_facet< ctype<_Elem> >(_Iosbase.getloc());
  const _Elem _E0 = _Ctype_fac.widen('0');
  _Mystr _Groupstring(_Count, _Elem(0));
  _Ctype_fac.widen(&_Buf[0], &_Buf[_Count], &_Groupstring[0]);

  const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  const string _Grouping = _Punct_fac.grouping();
  const _Elem _Kseparator = _Punct_fac.thousands_sep();

  size_t _Off = _Beforepoint;
  if (_Poff == _Count)
   {
   _Off += _Eoff;
   _Groupstring.insert(_Eoff, _Beforepoint, _E0);
   }
  else
   {
   _Off += _Poff;
   _Groupstring.insert(_Eoff, _Trailing, _E0);
   _Groupstring.insert(_Poff + 1, _Afterpoint, _E0);
   _Groupstring[_Poff] = _Punct_fac.decimal_point();
   _Groupstring.insert(_Poff, _Beforepoint, _E0);
   }

  const char *_Pg = &_Grouping[0];
  while (*_Pg != 127 && '\0' < *_Pg
   && (size_t)*_Pg < _Off - _Prefix)
   {
   _Groupstring.insert(_Off -= *_Pg, (size_t)1, _Kseparator);
   if ('\0' < _Pg[1])
    ++_Pg;
   }

  _Count = _Groupstring.size();
  size_t _Fillcount = _Iosbase.width() <= 0
   || (size_t)_Iosbase.width() <= _Count
    ? 0 : (size_t)_Iosbase.width() - _Count;

  ios_base::fmtflags _Adjustfield =
   _Iosbase.flags() & ios_base::adjustfield;
  if (_Adjustfield != ios_base::left
   && _Adjustfield != ios_base::internal)
   {
   _Dest = _Rep(_Dest, _Fill, _Fillcount);
   _Fillcount = 0;
   _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
   }
  else if (_Adjustfield == ios_base::internal)
   {
   _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
   _Dest = _Rep(_Dest, _Fill, _Fillcount);
   _Fillcount = 0;
   }
  else
   _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);

  _Dest = _Put(_Dest, &_Groupstring[_Prefix], _Count - _Prefix);
  _Iosbase.width(0);
  return (_Rep(_Dest, _Fill, _Fillcount));
  }

 char * _Ifmt(char *_Fmt,
  const char *_Spec, ios_base::fmtflags _Flags) const
  {
  char *_Ptr = _Fmt;
  *_Ptr++ = '%';

  if (_Flags & ios_base::showpos)
   *_Ptr++ = '+';
  if (_Flags & ios_base::showbase)
   *_Ptr++ = '#';
  if (_Spec[0] != 'L')
   *_Ptr++ = _Spec[0];
  else
#line 1464 "C:\\src\\winrtl\\include\\dinkumware64\\xlocnum"
   {
   *_Ptr++ = 'l';
   *_Ptr++ = 'l';
   }


  ios_base::fmtflags _Basefield = _Flags & ios_base::basefield;
  *_Ptr++ = _Basefield == ios_base::oct ? 'o'
   : _Basefield != ios_base::hex ? _Spec[1]
   : _Flags & ios_base::uppercase ? 'X' : 'x';
  *_Ptr = '\0';
  return (_Fmt);
  }

 _OutIt _Iput(_OutIt _Dest,
  ios_base& _Iosbase, _Elem _Fill, char *_Buf, size_t _Count) const
  {
                       ;
  size_t _Prefix = 0 < _Count && (*_Buf == '+' || *_Buf == '-')
   ? 1 : 0;
  if ((_Iosbase.flags() & ios_base::basefield) == ios_base::hex
   && _Prefix + 2 <= _Count && _Buf[_Prefix] == '0'
   && (_Buf[_Prefix + 1] == 'x' || _Buf[_Prefix + 1] == 'X'))
   _Prefix += 2;

  const ctype<_Elem>& _Ctype_fac =
   use_facet< ctype<_Elem> >(_Iosbase.getloc());
  _Mystr _Groupstring(_Count, _Elem(0));
  _Ctype_fac.widen(&_Buf[0], &_Buf[_Count], &_Groupstring[0]);

  const _Mypunct& _Punct_fac = use_facet< _Mypunct >(_Iosbase.getloc());
  const string _Grouping = _Punct_fac.grouping();
  const char *_Pg = &_Grouping[0];
  if (*_Pg != 127 && '\0' < *_Pg)
   {
   const _Elem _Kseparator = _Punct_fac.thousands_sep();
   while (*_Pg != 127 && '\0' < *_Pg
    && (size_t)*_Pg < _Count - _Prefix)
    {
    _Count -= *_Pg;
    _Groupstring.insert(_Count, 1, _Kseparator);
    if ('\0' < _Pg[1])
     ++_Pg;
    }
   }

  _Count = _Groupstring.size();
  size_t _Fillcount = _Iosbase.width() <= 0
   || (size_t)_Iosbase.width() <= _Count
    ? 0 : (size_t)_Iosbase.width() - _Count;

  ios_base::fmtflags _Adjustfield =
   _Iosbase.flags() & ios_base::adjustfield;
  if (_Adjustfield != ios_base::left
   && _Adjustfield != ios_base::internal)
   {
   _Dest = _Rep(_Dest, _Fill, _Fillcount);
   _Fillcount = 0;
   _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
   }
  else if (_Adjustfield == ios_base::internal)
   {
   _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);
   _Dest = _Rep(_Dest, _Fill, _Fillcount);
   _Fillcount = 0;
   }
  else
   _Dest = _Put(_Dest, &_Groupstring[0], _Prefix);

  _Dest = _Put(_Dest, &_Groupstring[_Prefix], _Count - _Prefix);
  _Iosbase.width(0);
  return (_Rep(_Dest, _Fill, _Fillcount));
  }

 _OutIt _Put(_OutIt _Dest,
  const _Elem *_Ptr, size_t _Count) const
  {
  for (; 0 < _Count; --_Count, ++_Dest, ++_Ptr)
   *_Dest = *_Ptr;
  return (_Dest);
  }

 _OutIt _Rep(_OutIt _Dest,
  _Elem _Ch, size_t _Count) const
  {
  for (; 0 < _Count; --_Count, ++_Dest)
   *_Dest = _Ch;
  return (_Dest);
  }
 };


template<class _Elem,
 class _OutIt>
 locale::id num_put<_Elem, _OutIt>::id;
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\ios"


namespace std {

template<class _Elem,
 class _Traits>
 class basic_ios
  : public ios_base
 {
public:
 typedef basic_ios<_Elem, _Traits> _Myt;
 typedef basic_ostream<_Elem, _Traits> _Myos;
 typedef basic_streambuf<_Elem, _Traits> _Mysb;
 typedef ctype<_Elem> _Ctype;
 typedef _Elem char_type;
 typedef _Traits traits_type;
 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;

 explicit basic_ios(_Mysb *_Strbuf)
  {
  init(_Strbuf);
  }

 virtual ~basic_ios()
  {
  }

 void clear(iostate _State = goodbit,
  bool _Reraise = false)
  {
  ios_base::clear((iostate)(_Mystrbuf == 0
   ? (int)_State | (int)badbit : (int)_State), _Reraise);
  }

 void clear(io_state _State)
  {
  clear((iostate)_State);
  }

 void setstate(iostate _State,
  bool _Reraise = false)
  {
  if (_State != goodbit)
   clear((iostate)((int)rdstate() | (int)_State), _Reraise);
  }

 void setstate(io_state _State)
  {
  setstate((iostate)_State);
  }

 _Myt& copyfmt(const _Myt& _Right)
  {
  _Tiestr = _Right.tie();
  _Fillch = _Right.fill();
  ios_base::copyfmt(_Right);
  return (*this);
  }

 _Myos * tie() const
  {
  return (_Tiestr);
  }

 _Myos * tie(_Myos *_Newtie)
  {
  _Myos *_Oldtie = _Tiestr;
  _Tiestr = _Newtie;
  return (_Oldtie);
  }

 _Mysb * rdbuf() const
  {
  return (_Mystrbuf);
  }

 _Mysb * rdbuf(_Mysb *_Strbuf)
  {
  _Mysb *_Oldstrbuf = _Mystrbuf;
  _Mystrbuf = _Strbuf;
  clear();
  return (_Oldstrbuf);
  }

 locale imbue(const locale& _Loc)
  {
  locale _Oldlocale = ios_base::imbue(_Loc);
  if (rdbuf() != 0)
   rdbuf()->pubimbue(_Loc);
  return (_Oldlocale);
  }

 _Elem fill() const
  {
  return (_Fillch);
  }

 _Elem fill(_Elem _Newfill)
  {
  _Elem _Oldfill = _Fillch;
  _Fillch = _Newfill;
  return (_Oldfill);
  }

 char narrow(_Elem _Ch, char _Dflt = '\0') const
  {
  const _Ctype& _Ctype_fac = use_facet< _Ctype >(getloc());
  return (_Ctype_fac.narrow(_Ch, _Dflt));
  }

 _Elem widen(char _Byte) const
  {
  const _Ctype& _Ctype_fac = use_facet< _Ctype >(getloc());
  return (_Ctype_fac.widen(_Byte));
  }


 void move(_Myt& _Right)
  {
  if (this != &_Right)
   {
   _Mystrbuf = 0;
   _Tiestr = 0;
   this->swap(_Right);
   }
  }

 void move(_Myt&& _Right)
  {
  if (this != &_Right)
   {
   _Mystrbuf = 0;
   _Tiestr = 0;
   this->swap(_Right);
   }
  }

 void swap(_Myt& _Right)
  {
  ios_base::swap(_Right);
  ::std:: swap(_Fillch, _Right._Fillch);
  ::std:: swap(_Tiestr, _Right._Tiestr);
  }

 void set_rdbuf(_Mysb *_Strbuf)
  {
  _Mystrbuf = _Strbuf;
  }


protected:
 void init(_Mysb *_Strbuf = 0,
  bool _Isstd = false)
  {
  _Init();
  _Mystrbuf = _Strbuf;
  _Tiestr = 0;
  _Fillch = widen(' ');

  if (_Mystrbuf == 0)
   setstate(badbit);

  if (_Isstd)
   _Addstd(this);
  }

        basic_ios()
  {
  }

private:
 _Mysb *_Mystrbuf;
 _Myos *_Tiestr;
 _Elem _Fillch;
#line 193 "C:\\src\\winrtl\\include\\dinkumware64\\ios"
 };


inline ios_base& boolalpha(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::boolalpha);
 return (_Iosbase);
 }

inline ios_base& dec(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::dec, ios_base::basefield);
 return (_Iosbase);
 }


inline ios_base& defaultfloat(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::floatfield);
 return (_Iosbase);
 }


inline ios_base& fixed(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::fixed, ios_base::floatfield);
 return (_Iosbase);
 }

inline ios_base& hex(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::hex, ios_base::basefield);
 return (_Iosbase);
 }


inline ios_base& hexfloat(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::hexfloat, ios_base::floatfield);
 return (_Iosbase);
 }



namespace tr1 {
using ::std:: hexfloat;
}


inline ios_base& internal(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::internal, ios_base::adjustfield);
 return (_Iosbase);
 }

inline ios_base& left(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::left, ios_base::adjustfield);
 return (_Iosbase);
 }

inline ios_base& noboolalpha(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::boolalpha);
 return (_Iosbase);
 }

inline ios_base& noshowbase(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::showbase);
 return (_Iosbase);
 }

inline ios_base& noshowpoint(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::showpoint);
 return (_Iosbase);
 }

inline ios_base& noshowpos(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::showpos);
 return (_Iosbase);
 }

inline ios_base& noskipws(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::skipws);
 return (_Iosbase);
 }

inline ios_base& nounitbuf(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::unitbuf);
 return (_Iosbase);
 }

inline ios_base& nouppercase(ios_base& _Iosbase)
 {
 _Iosbase.unsetf(ios_base::uppercase);
 return (_Iosbase);
 }

inline ios_base& oct(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::oct, ios_base::basefield);
 return (_Iosbase);
 }

inline ios_base& right(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::right, ios_base::adjustfield);
 return (_Iosbase);
 }

inline ios_base& scientific(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::scientific, ios_base::floatfield);
 return (_Iosbase);
 }

inline ios_base& showbase(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::showbase);
 return (_Iosbase);
 }

inline ios_base& showpoint(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::showpoint);
 return (_Iosbase);
 }

inline ios_base& showpos(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::showpos);
 return (_Iosbase);
 }

inline ios_base& skipws(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::skipws);
 return (_Iosbase);
 }

inline ios_base& unitbuf(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::unitbuf);
 return (_Iosbase);
 }

inline ios_base& uppercase(ios_base& _Iosbase)
 {
 _Iosbase.setf(ios_base::uppercase);
 return (_Iosbase);
 }
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\ostream"


namespace std {
#line 27 "C:\\src\\winrtl\\include\\dinkumware64\\ostream"
template<class _Elem,
 class _Traits>
 class basic_ostream
  : virtual public basic_ios<_Elem, _Traits>
 {
public:
 typedef basic_ostream<_Elem, _Traits> _Myt;
 typedef basic_ios<_Elem, _Traits> _Myios;
 typedef basic_streambuf<_Elem, _Traits> _Mysb;
 typedef ostreambuf_iterator<_Elem, _Traits> _Iter;
 typedef num_put<_Elem, _Iter> _Nput;


 explicit basic_ostream(
  basic_streambuf<_Elem, _Traits> *_Strbuf = 0,






  bool _Isstd = false)
  {
  _Myios::init(_Strbuf, _Isstd);
  }

        basic_ostream(_Uninitialized, bool _Addit = true)
  {
  if (_Addit)
   this->_Addstd(this);
  }


protected:
        basic_ostream(_Myt&& _Right)
  {
  _Myios::init();
  _Myios::move(::std:: move(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  this->swap(_Right);
  return (*this);
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   _Myios::swap(_Right);
  }
#line 86 "C:\\src\\winrtl\\include\\dinkumware64\\ostream"
private:
         basic_ostream(const _Myt& _Right);
  _Myt& operator=(const _Myt&);

public:


 virtual ~basic_ostream()
  {
  }

 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;

 class _Sentry_base
  {
 public:
         _Sentry_base(_Myt& _Ostr)
   : _Myostr(_Ostr)
   {
   if (_Myostr.rdbuf() != 0)
    _Myostr.rdbuf()->_Lock();
   }

         ~_Sentry_base()
   {
   if (_Myostr.rdbuf() != 0)
    _Myostr.rdbuf()->_Unlock();
   }

  _Myt& _Myostr;

 private:
  _Sentry_base& operator=(const _Sentry_base&);
  };

 class sentry
  : public _Sentry_base
  {
 public:
  explicit sentry(_Myt& _Ostr)
   : _Sentry_base(_Ostr)
   {
   if (_Ostr.good() && _Ostr.tie() != 0 && _Ostr.tie() != &_Ostr)
    _Ostr.tie()->flush();
   _Ok = _Ostr.good();
   }

         ~sentry()
   {





   this->_Myostr._Osfx();

   }

                 operator bool() const
   {
   return (_Ok);
   }

 private:
  bool _Ok;







         sentry(const sentry&);
  sentry& operator=(const sentry&);

  };

 bool opfx()
  {
  if (this->good() && _Myios::tie() != 0 && _Myios::tie() != this)
   _Myios::tie()->flush();
  return (this->good());
  }

 void osfx()
  {
  _Osfx();
  }

 void _Osfx()
  {
  {{
  if (this->good() && this->flags() & ios_base::unitbuf)
   if (_Myios::rdbuf()->pubsync() == -1)
    _Myios::setstate(ios_base::badbit);
  } if (0) {
  }}
  }

 _Myt& operator<<(_Myt& ( *_Pfn)(_Myt&))
  {
                      ;
  return ((*_Pfn)(*this));
  }

 _Myt& operator<<(_Myios& ( *_Pfn)(_Myios&))
  {
                      ;
  (*_Pfn)(*(_Myios *)this);
  return (*this);
  }

 _Myt& operator<<(ios_base& ( *_Pfn)(ios_base&))
  {
                      ;
  (*_Pfn)(*(ios_base *)this);
  return (*this);
  }

 _Myt& operator<<(_Bool _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(short _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());
   ios_base::fmtflags _Bfl =
    this->flags() & ios_base::basefield;
   long _Tmp = (_Bfl == ios_base::oct
    || _Bfl == ios_base::hex)
    ? (long)(unsigned short)_Val : (long)_Val;

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Tmp).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(unsigned short _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), (unsigned long)_Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(int _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());
   ios_base::fmtflags _Bfl =
    this->flags() & ios_base::basefield;
   long _Tmp = (_Bfl == ios_base::oct
    || _Bfl == ios_base::hex)
    ? (long)(unsigned int)_Val : (long)_Val;

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Tmp).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(unsigned int _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), (unsigned long)_Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(long _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(unsigned long _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }


 _Myt& operator<<(long long _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(unsigned long long _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }


 _Myt& operator<<(float _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), (double)_Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(double _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(long double _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(const void *_Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nput& _Nput_fac = use_facet< _Nput >(this->getloc());

   {
   if (_Nput_fac.put(_Iter(_Myios::rdbuf()), *this,
    _Myios::fill(), _Val).failed())
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator<<(_Mysb *_Strbuf)
  {
  ios_base::iostate _State = ios_base::goodbit;
  bool _Copied = false;
  const sentry _Ok(*this);

  if (_Ok && _Strbuf != 0)
   for (int_type _Meta = _Traits::eof(); ; _Copied = true)
    {
    {{
    _Meta = _Traits::eq_int_type(_Traits::eof(), _Meta)
     ? _Strbuf->sgetc() : _Strbuf->snextc();
    } if (0) {
     _Myios::setstate(ios_base::failbit);
             ;
    }}

    if (_Traits::eq_int_type(_Traits::eof(), _Meta))
     break;

    {
     if (_Traits::eq_int_type(_Traits::eof(),
      _Myios::rdbuf()->sputc(
       _Traits::to_char_type(_Meta))))
      {
      _State |= ios_base::badbit;
      break;
      }
    }
    }

  this->width(0);
  _Myios::setstate(_Strbuf == 0 ? ios_base::badbit
   : !_Copied ? _State | ios_base::failbit : _State);
  return (*this);
  }

 _Myt& put(_Elem _Ch)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (!_Ok)
   _State |= ios_base::badbit;
  else
   {
   {
   if (_Traits::eq_int_type(_Traits::eof(),
    _Myios::rdbuf()->sputc(_Ch)))
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& write(const _Elem *_Str,
  streamsize _Count)
  {





  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (!_Ok)
   _State |= ios_base::badbit;
  else
   {
   {
   if (_Myios::rdbuf()->sputn(_Str, _Count) != _Count)
    _State |= ios_base::badbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& flush()
  {
  if (_Myios::rdbuf() != 0)
   {
   const sentry _Ok(*this);

   if (_Ok && _Myios::rdbuf()->pubsync() == -1)
    _Myios::setstate(ios_base::badbit);
   }
  return (*this);
  }

 _Myt& seekp(pos_type _Pos)
  {
  const sentry _Ok(*this);

  if (!this->fail()
   && (off_type)_Myios::rdbuf()->pubseekpos(_Pos,
    ios_base::out) == _BADOFF)
   _Myios::setstate(ios_base::failbit);
  return (*this);
  }

 _Myt& seekp(off_type _Off, ios_base::seekdir _Way)
  {
  const sentry _Ok(*this);

  if (!this->fail()
   && (off_type)_Myios::rdbuf()->pubseekoff(_Off, _Way,
    ios_base::out) == _BADOFF)
   _Myios::setstate(ios_base::failbit);
  return (*this);
  }

 pos_type tellp()
  {
  const sentry _Ok(*this);

  if (!this->fail())
   return (_Myios::rdbuf()->pubseekoff(0,
    ios_base::cur, ios_base::out));
  else
   return (pos_type(_BADOFF));
  }
 };




template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>& operator<<(
  basic_ostream<_Elem, _Traits>& _Ostr, const char *_Val)
 {
 ios_base::iostate _State = ios_base::goodbit;
 streamsize _Count = (streamsize)::std:: strlen(_Val);
 streamsize _Pad = _Ostr.width() <= 0 || _Ostr.width() <= _Count
  ? 0 : _Ostr.width() - _Count;
 const typename basic_ostream<_Elem, _Traits>::sentry _Ok(_Ostr);

 if (!_Ok)
  _State |= ios_base::badbit;
 else
  {
  {
  const ctype<_Elem>& _Ctype_fac = use_facet< ctype<_Elem> >(_Ostr.getloc());
  if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   for (; 0 < _Pad; --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     {
     _State |= ios_base::badbit;
     break;
     }

  for (; _State == ios_base::goodbit && 0 < _Count; --_Count, ++_Val)
   if (_Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ctype_fac.widen(*_Val))))
     _State |= ios_base::badbit;

  if (_State == ios_base::goodbit)
   for (; 0 < _Pad; --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     {
     _State |= ios_base::badbit;
     break;
     }
  _Ostr.width(0);
  }
  }

 _Ostr.setstate(_State);
 return (_Ostr);
 }

template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>& operator<<(
  basic_ostream<_Elem, _Traits>& _Ostr, char _Ch)
 {
 ios_base::iostate _State = ios_base::goodbit;
 const typename basic_ostream<_Elem, _Traits>::sentry _Ok(_Ostr);

 if (_Ok)
  {
  const ctype<_Elem>& _Ctype_fac = use_facet< ctype<_Elem> >(_Ostr.getloc());
  streamsize _Pad = _Ostr.width() <= 1 ? 0 : _Ostr.width() - 1;

  {
  if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   for (; _State == ios_base::goodbit && 0 < _Pad;
    --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     _State |= ios_base::badbit;

  if (_State == ios_base::goodbit
   && _Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ctype_fac.widen(_Ch))))
   _State |= ios_base::badbit;

  for (; _State == ios_base::goodbit && 0 < _Pad;
   --_Pad)
   if (_Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ostr.fill())))
    _State |= ios_base::badbit;
  }
  }

 _Ostr.width(0);
 _Ostr.setstate(_State);
 return (_Ostr);
 }

template<class _Traits> inline
 basic_ostream<char, _Traits>& operator<<(
  basic_ostream<char, _Traits>& _Ostr,
  const char *_Val)
 {
 typedef char _Elem;
 typedef basic_ostream<_Elem, _Traits> _Myos;
 ios_base::iostate _State = ios_base::goodbit;
 streamsize _Count = (streamsize)_Traits::length(_Val);
 streamsize _Pad = _Ostr.width() <= 0 || _Ostr.width() <= _Count
  ? 0 : _Ostr.width() - _Count;
 const typename _Myos::sentry _Ok(_Ostr);

 if (!_Ok)
  _State |= ios_base::badbit;
 else
  {
  {
  if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   for (; 0 < _Pad; --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     {
     _State |= ios_base::badbit;
     break;
     }

  if (_State == ios_base::goodbit
   && _Ostr.rdbuf()->sputn(_Val, _Count) != _Count)
   _State |= ios_base::badbit;

  if (_State == ios_base::goodbit)
   for (; 0 < _Pad; --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     {
     _State |= ios_base::badbit;
     break;
     }
  _Ostr.width(0);
  }
  }

 _Ostr.setstate(_State);
 return (_Ostr);
 }

template<class _Traits> inline
 basic_ostream<char, _Traits>& operator<<(
  basic_ostream<char, _Traits>& _Ostr, char _Ch)
 {
 typedef char _Elem;
 typedef basic_ostream<_Elem, _Traits> _Myos;
 ios_base::iostate _State = ios_base::goodbit;
 const typename _Myos::sentry _Ok(_Ostr);

 if (_Ok)
  {
  streamsize _Pad = _Ostr.width() <= 1 ? 0 : _Ostr.width() - 1;

  {
  if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   for (; _State == ios_base::goodbit && 0 < _Pad;
    --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     _State |= ios_base::badbit;

  if (_State == ios_base::goodbit
   && _Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ch)))
   _State |= ios_base::badbit;

  for (; _State == ios_base::goodbit && 0 < _Pad;
   --_Pad)
   if (_Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ostr.fill())))
    _State |= ios_base::badbit;
  }
  }

 _Ostr.width(0);
 _Ostr.setstate(_State);
 return (_Ostr);
 }

template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>& operator<<(
  basic_ostream<_Elem, _Traits>& _Ostr, const _Elem *_Val)
 {
 typedef basic_ostream<_Elem, _Traits> _Myos;

 ios_base::iostate _State = ios_base::goodbit;
 streamsize _Count = (streamsize)_Traits::length(_Val);
 streamsize _Pad = _Ostr.width() <= 0 || _Ostr.width() <= _Count
  ? 0 : _Ostr.width() - _Count;
 const typename _Myos::sentry _Ok(_Ostr);

 if (!_Ok)
  _State |= ios_base::badbit;
 else
  {
  {
  if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   for (; 0 < _Pad; --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     {
     _State |= ios_base::badbit;
     break;
     }

  if (_State == ios_base::goodbit
   && _Ostr.rdbuf()->sputn(_Val, _Count) != _Count)
   _State |= ios_base::badbit;

  if (_State == ios_base::goodbit)
   for (; 0 < _Pad; --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     {
     _State |= ios_base::badbit;
     break;
     }
  _Ostr.width(0);
  }
  }

 _Ostr.setstate(_State);
 return (_Ostr);
 }

template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>& operator<<(
  basic_ostream<_Elem, _Traits>& _Ostr, _Elem _Ch)
 {
 typedef basic_ostream<_Elem, _Traits> _Myos;

 ios_base::iostate _State = ios_base::goodbit;
 const typename _Myos::sentry _Ok(_Ostr);

 if (_Ok)
  {
  streamsize _Pad = _Ostr.width() <= 1 ? 0 : _Ostr.width() - 1;

  {
  if ((_Ostr.flags() & ios_base::adjustfield) != ios_base::left)
   for (; _State == ios_base::goodbit && 0 < _Pad;
    --_Pad)
    if (_Traits::eq_int_type(_Traits::eof(),
     _Ostr.rdbuf()->sputc(_Ostr.fill())))
     _State |= ios_base::badbit;

  if (_State == ios_base::goodbit
   && _Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ch)))
   _State |= ios_base::badbit;

  for (; _State == ios_base::goodbit && 0 < _Pad;
   --_Pad)
   if (_Traits::eq_int_type(_Traits::eof(),
    _Ostr.rdbuf()->sputc(_Ostr.fill())))
    _State |= ios_base::badbit;
  }
  }

 _Ostr.width(0);
 _Ostr.setstate(_State);
 return (_Ostr);
 }

template<class _Traits> inline
 basic_ostream<char, _Traits>& operator<<(
  basic_ostream<char, _Traits>& _Ostr, const signed char *_Val)
 {
 return (_Ostr << (const char *)_Val);
 }

template<class _Traits> inline
 basic_ostream<char, _Traits>& operator<<(
  basic_ostream<char, _Traits>& _Ostr, signed char _Ch)
 {
 return (_Ostr << (char)_Ch);
 }

template<class _Traits> inline
 basic_ostream<char, _Traits>& operator<<(
  basic_ostream<char, _Traits>& _Ostr, const unsigned char *_Val)
 {
 return (_Ostr << (const char *)_Val);
 }

template<class _Traits> inline
 basic_ostream<char, _Traits>& operator<<(
  basic_ostream<char, _Traits>& _Ostr, unsigned char _Ch)
 {
 return (_Ostr << (char)_Ch);
 }




template<class _Elem,
 class _Traits,
 class _Ty> inline
 basic_ostream<_Elem, _Traits>&
  operator<<(basic_ostream<_Elem, _Traits>&& _Ostr, const _Ty& _Val)
 {
 return (_Ostr << _Val);
 }
#line 989 "C:\\src\\winrtl\\include\\dinkumware64\\ostream"
template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>&
          endl(basic_ostream<_Elem, _Traits>& _Ostr)
 {
 _Ostr.put(_Ostr.widen('\n'));
 _Ostr.flush();
 return (_Ostr);
 }

template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>&
          ends(basic_ostream<_Elem, _Traits>& _Ostr)
 {
 _Ostr.put(_Elem());
 return (_Ostr);
 }

template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>&
          flush(basic_ostream<_Elem, _Traits>& _Ostr)
 {
 _Ostr.flush();
 return (_Ostr);
 }



template<class _Elem,
 class _Traits> inline
 basic_ostream<_Elem, _Traits>&
  operator<<(basic_ostream<_Elem, _Traits>& _Ostr,
   const error_code& _Errcode)
 {
 return (_Ostr << _Errcode.category().name() << ':' << _Errcode.value());
 }

}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\istream"


namespace std {

template<class _Elem,
 class _Traits>
 class basic_istream
  : virtual public basic_ios<_Elem, _Traits>
 {
public:
 typedef basic_istream<_Elem, _Traits> _Myt;
 typedef basic_ios<_Elem, _Traits> _Myios;
 typedef basic_streambuf<_Elem, _Traits> _Mysb;
 typedef istreambuf_iterator<_Elem, _Traits> _Iter;
 typedef ctype<_Elem> _Ctype;
 typedef num_get<_Elem, _Iter> _Nget;


 explicit basic_istream(_Mysb *_Strbuf = 0,
  bool _Isstd = false)






  : _Chcount(0)
  {
  _Myios::init(_Strbuf, _Isstd);
  }

        basic_istream(_Uninitialized)
  {
  this->_Addstd(this);
  }


protected:
        basic_istream(_Myt&& _Right)
  : _Chcount(_Right._Chcount)
  {
  _Myios::init();
  _Myios::move(::std:: move(_Right));
  _Right._Chcount = 0;
  }

 _Myt& operator=(_Myt&& _Right)
  {
  this->swap(_Right);
  return (*this);
  }

 void swap(_Myt& _Right)
  {
  _Myios::swap(_Right);
  ::std:: swap(_Chcount, _Right._Chcount);
  }
#line 69 "C:\\src\\winrtl\\include\\dinkumware64\\istream"
private:
         basic_istream(const _Myt& _Right);
  _Myt& operator=(const _Myt&);

public:


 virtual ~basic_istream()
  {
  }

 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;


 class _Sentry_base
  {
 public:
         _Sentry_base(_Myt& _Istr)
   : _Myistr(_Istr)
   {
   if (_Myistr.rdbuf() != 0)
    _Myistr.rdbuf()->_Lock();
   }

         ~_Sentry_base()
   {
   if (_Myistr.rdbuf() != 0)
    _Myistr.rdbuf()->_Unlock();
   }

  _Myt& _Myistr;

 private:
  _Sentry_base& operator=(const _Sentry_base&);
  };

 class sentry
  : public _Sentry_base
  {
 public:
  explicit sentry(_Myt& _Istr, bool _Noskip = false)
   : _Sentry_base(_Istr)
   {
   _Ok = this->_Myistr._Ipfx(_Noskip);
   }

                 operator bool() const
   {
   return (_Ok);
   }

 private:
  bool _Ok;







         sentry(const sentry&);
  sentry& operator=(const sentry&);

  };

 bool _Ipfx(bool _Noskip = false)
  {
  if (this->good())
   {
   if (_Myios::tie() != 0)
    _Myios::tie()->flush();

   if (!_Noskip && this->flags() & ios_base::skipws)
    {
    const _Ctype& _Ctype_fac = use_facet< _Ctype >(this->getloc());

    {
    int_type _Meta = _Myios::rdbuf()->sgetc();

    for (; ; _Meta = _Myios::rdbuf()->snextc())
     if (_Traits::eq_int_type(_Traits::eof(), _Meta))
      {
      _Myios::setstate(ios_base::eofbit);
      break;
      }
     else if (!_Ctype_fac.is(_Ctype::space,
      _Traits::to_char_type(_Meta)))
      break;
    }
    }

   if (this->good())
    return (true);
   }
  _Myios::setstate(ios_base::failbit);
  return (false);
  }

 bool ipfx(bool _Noskip = false)
  {
  return (_Ipfx(_Noskip));
  }

 void isfx()
  {
  }

 _Myt& operator>>(_Myt& ( *_Pfn)(_Myt&))
  {
                      ;
  return ((*_Pfn)(*this));
  }

 _Myt& operator>>(_Myios& ( *_Pfn)(_Myios&))
  {
                      ;
  (*_Pfn)(*(_Myios *)this);
  return (*this);
  }

 _Myt& operator>>(ios_base& ( *_Pfn)(ios_base&))
  {
                      ;
  (*_Pfn)(*(ios_base *)this);
  return (*this);
  }

 _Myt& operator>>(_Bool& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(short& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   long _Tmp = 0;
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Tmp);
   }

   if (_State & ios_base::failbit
    || _Tmp < (-32767 -1) || 32767 < _Tmp)
    _State |= ios_base::failbit;
   else
    _Val = (short)_Tmp;
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(unsigned short& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(int& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   long _Tmp = 0;
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Tmp);
   }

   if (_State & ios_base::failbit
    || _Tmp < (-2147483647L -1) || 2147483647L < _Tmp)
    _State |= ios_base::failbit;
   else
    _Val = _Tmp;
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(unsigned int& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);
  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(long& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());
   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(unsigned long& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }


 _Myt& operator>>(long long& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(unsigned long long& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);
  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }


 _Myt& operator>>(float& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(double& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);
  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(long double& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());
   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(void *& _Val)
  {
  ios_base::iostate _State = ios_base::goodbit;
  const sentry _Ok(*this);

  if (_Ok)
   {
   const _Nget& _Nget_fac = use_facet< _Nget >(this->getloc());

   {
   _Nget_fac.get(_Iter(_Myios::rdbuf()), _Iter(0),
    *this, _State, _Val);
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& operator>>(_Mysb *_Strbuf)
  {
  ios_base::iostate _State = ios_base::goodbit;
  bool _Copied = false;
  const sentry _Ok(*this);

  if (_Ok && _Strbuf != 0)
   {
   {
   int_type _Meta = _Myios::rdbuf()->sgetc();

   for (; ; _Meta = _Myios::rdbuf()->snextc())
    if (_Traits::eq_int_type(_Traits::eof(), _Meta))
     {
     _State |= ios_base::eofbit;
     break;
     }
    else
     {
     {{
      if (_Traits::eq_int_type(_Traits::eof(),
       _Strbuf->sputc(_Traits::to_char_type(_Meta))))
       break;
     } if (0) {
      break;
     }}
     _Copied = true;
     }
   }
   }

  _Myios::setstate(!_Copied ? _State | ios_base::failbit : _State);
  return (*this);
  }

 int_type get()
  {
  int_type _Meta = 0;
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);

  if (!_Ok)
   _Meta = _Traits::eof();
  else
   {
   {
   _Meta = _Myios::rdbuf()->sgetc();

   if (_Traits::eq_int_type(_Traits::eof(), _Meta))
    _State |= ios_base::eofbit | ios_base::failbit;
   else
    {
    _Myios::rdbuf()->sbumpc();
    ++_Chcount;
    }
   }
   }

  _Myios::setstate(_State);
  return (_Meta);
  }

 _Myt& get(_Elem *_Str, streamsize _Count)
  {
  return (get(_Str, _Count, _Myios::widen('\n')));
  }

 _Myt& get(_Elem *_Str,
  streamsize _Count, _Elem _Delim)
  {
                      ;
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);

  if (_Ok && 0 < _Count)
   {
   {
   int_type _Meta = _Myios::rdbuf()->sgetc();

   for (; 0 < --_Count; _Meta = _Myios::rdbuf()->snextc())
    if (_Traits::eq_int_type(_Traits::eof(), _Meta))
     {
     _State |= ios_base::eofbit;
     break;
     }
    else if (_Traits::to_char_type(_Meta) == _Delim)
     break;
    else
     {
     *_Str++ = _Traits::to_char_type(_Meta);
     ++_Chcount;
     }
   }
   }

  _Myios::setstate(_Chcount == 0
   ? _State | ios_base::failbit : _State);
  *_Str = _Elem();
  return (*this);
  }

 _Myt& get(_Elem& _Ch)
  {
  int_type _Meta = get();
  if (!_Traits::eq_int_type(_Traits::eof(), _Meta))
   _Ch = _Traits::to_char_type(_Meta);
  return (*this);
  }

 _Myt& get(_Mysb& _Strbuf)
  {
  return (get(_Strbuf, _Myios::widen('\n')));
  }

 _Myt& get(_Mysb& _Strbuf, _Elem _Delim)
  {
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);

  if (_Ok)
   {
   {
   int_type _Meta = _Myios::rdbuf()->sgetc();

   for (; ; _Meta = _Myios::rdbuf()->snextc())
    if (_Traits::eq_int_type(_Traits::eof(), _Meta))
     {
     _State |= ios_base::eofbit;
     break;
     }
    else
     {
     {{
      _Elem _Ch = _Traits::to_char_type(_Meta);
      if (_Ch == _Delim
       || _Traits::eq_int_type(_Traits::eof(),
        _Strbuf.sputc(_Ch)))
       break;
     } if (0) {
      break;
     }}
     ++_Chcount;
     }
   }
   }

  if (_Chcount == 0)
   _State |= ios_base::failbit;
  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& getline(_Elem *_Str, streamsize _Count)
  {
  return (getline(_Str, _Count, _Myios::widen('\n')));
  }

 _Myt& getline(_Elem *_Str,
  streamsize _Count, _Elem _Delim)
  {
                      ;
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);

  if (_Ok && 0 < _Count)
   {
   int_type _Metadelim = _Traits::to_int_type(_Delim);

   {
   int_type _Meta = _Myios::rdbuf()->sgetc();

   for (; ; _Meta = _Myios::rdbuf()->snextc())
    if (_Traits::eq_int_type(_Traits::eof(), _Meta))
     {
     _State |= ios_base::eofbit;
     break;
     }
    else if (_Meta == _Metadelim)
     {
     ++_Chcount;
     _Myios::rdbuf()->sbumpc();
     break;
     }
    else if (--_Count <= 0)
     {
     _State |= ios_base::failbit;
     break;
     }
    else
     {
     ++_Chcount;
     *_Str++ = _Traits::to_char_type(_Meta);
     }
   }
   }

  *_Str = _Elem();
  _Myios::setstate(_Chcount == 0 ? _State | ios_base::failbit : _State);
  return (*this);
  }

 _Myt& ignore(streamsize _Count = 1,
  int_type _Metadelim = _Traits::eof())
  {
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);

  if (_Ok && 0 < _Count)
   {
   {
   for (; ; )
    {
    int_type _Meta;
    if (_Count != 2147483647L && --_Count < 0)
     break;
    else if (_Traits::eq_int_type(_Traits::eof(),
     _Meta = _Myios::rdbuf()->sbumpc()))
     {
     _State |= ios_base::eofbit;
     break;
     }
    else
     {
     ++_Chcount;
     if (_Meta == _Metadelim)
      break;
     }
    }
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& read(_Elem *_Str, streamsize _Count)
  {
                      ;
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);

  if (_Ok)
   {
   {
   const streamsize _Num = _Myios::rdbuf()->sgetn(_Str, _Count);
   _Chcount += _Num;
   if (_Num != _Count)
    _State |= ios_base::eofbit | ios_base::failbit;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 streamsize readsome(_Elem *_Str,
  streamsize _Count)
  {
                      ;
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  const sentry _Ok(*this, true);
  streamsize _Num;

  if (!_Ok)
   _State |= ios_base::failbit;
  else if ((_Num = _Myios::rdbuf()->in_avail()) < 0)
   _State |= ios_base::eofbit;
  else if (0 < _Num)
   read(_Str, _Num < _Count ? _Num : _Count);

  _Myios::setstate(_State);
  return (gcount());
  }

 int_type peek()
  {
  ios_base::iostate _State = ios_base::goodbit;
  _Chcount = 0;
  int_type _Meta = 0;
  const sentry _Ok(*this, true);

  if (!_Ok)
   _Meta = _Traits::eof();
  else
   {
   {
   if (_Traits::eq_int_type(_Traits::eof(),
    _Meta = _Myios::rdbuf()->sgetc()))
    _State |= ios_base::eofbit;
   }
   }

  _Myios::setstate(_State);
  return (_Meta);
  }

 _Myt& putback(_Elem _Ch)
  {
  _Chcount = 0;
  ios_base::iostate _State = ios_base::goodbit;
  ios_base::iostate _Oldstate = _Myios::rdstate();
  _Myios::clear(_Oldstate & ~ios_base::eofbit);
  const sentry _Ok(*this, true);

  if (_Ok)
   {
   {
   if (_Traits::eq_int_type(_Traits::eof(),
    _Myios::rdbuf()->sputbackc(_Ch)))
    _State |= ios_base::badbit | _Oldstate;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 _Myt& unget()
  {
  _Chcount = 0;
  ios_base::iostate _State = ios_base::goodbit;
  ios_base::iostate _Oldstate = _Myios::rdstate();
  _Myios::clear(_Oldstate & ~ios_base::eofbit);
  const sentry _Ok(*this, true);

  if (_Ok)
   {
   {
   if (_Traits::eq_int_type(_Traits::eof(),
    _Myios::rdbuf()->sungetc()))
    _State |= ios_base::badbit | _Oldstate;
   }
   }

  _Myios::setstate(_State);
  return (*this);
  }

 streamsize gcount() const
  {
  return (_Chcount);
  }

 int sync()
  {
  const sentry _Ok(*this, true);

  if (_Myios::rdbuf() == 0)
   return (-1);
  else if (_Myios::rdbuf()->pubsync() == -1)
   {
   _Myios::setstate(ios_base::badbit);
   return (-1);
   }
  else
   return (0);
  }

 _Myt& seekg(pos_type _Pos)
  {
  ios_base::iostate _State = ios_base::goodbit;
  ios_base::iostate _Oldstate = _Myios::rdstate();
  _Myios::clear(_Oldstate & ~ios_base::eofbit);
  const sentry _Ok(*this, true);

  if (!this->fail()
   && (off_type)_Myios::rdbuf()->pubseekpos(_Pos,
    ios_base::in) == _BADOFF)
   _Myios::setstate(_State | ios_base::failbit);
  return (*this);
  }

 _Myt& seekg(off_type _Off, ios_base::seekdir _Way)
  {
  ios_base::iostate _State = ios_base::goodbit;
  ios_base::iostate _Oldstate = _Myios::rdstate();
  _Myios::clear(_Oldstate & ~ios_base::eofbit);
  const sentry _Ok(*this, true);

  if (!this->fail()
   && (off_type)_Myios::rdbuf()->pubseekoff(_Off, _Way,
    ios_base::in) == _BADOFF)
   _Myios::setstate(_State | ios_base::failbit);
  return (*this);
  }

 pos_type tellg()
  {
  const sentry _Ok(*this, true);

  if (!this->fail())
   return (_Myios::rdbuf()->pubseekoff(0,
    ios_base::cur, ios_base::in));
  else
   return (pos_type(_BADOFF));
  }

private:
 streamsize _Chcount;
 };




template<class _Elem,
 class _Traits>
 class basic_iostream
 : public basic_istream<_Elem, _Traits>,
  public basic_ostream<_Elem, _Traits>
 {
public:
 typedef basic_iostream<_Elem, _Traits> _Myt;
 typedef basic_istream<_Elem, _Traits> _Myis;
 typedef basic_ostream<_Elem, _Traits> _Myos;
 typedef basic_ios<_Elem, _Traits> _Myios;
 typedef _Elem char_type;
 typedef _Traits traits_type;
 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;

 explicit basic_iostream(basic_streambuf<_Elem, _Traits> *_Strbuf)
  : _Myis(_Strbuf, false),
   _Myos(_Noinit, false)
  {
  }


protected:
        basic_iostream(_Myt&& _Right)
  : _Myis(_Right.rdbuf(), false),
   _Myos(_Noinit, false)
  {
  _Myios::init();
  _Myios::move(::std:: forward<_Myt>(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  this->swap(_Right);
  return (*this);
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   _Myios::swap(_Right);
  }
#line 919 "C:\\src\\winrtl\\include\\dinkumware64\\istream"
private:
         basic_iostream(const _Myt& _Right);
  _Myt& operator=(const _Myt&);
public:


 virtual ~basic_iostream()
  {
  }
 };
#line 941 "C:\\src\\winrtl\\include\\dinkumware64\\istream"
template<class _Elem,
 class _Traits> inline
 basic_istream<_Elem, _Traits>& operator>>(
  basic_istream<_Elem, _Traits> & _Istr, _Elem *_Str)
 {
                     ;
 typedef basic_istream<_Elem, _Traits> _Myis;
 typedef ctype<_Elem> _Ctype;
 ios_base::iostate _State = ios_base::goodbit;
 _Elem *_Str0 = _Str;
 const typename _Myis::sentry _Ok(_Istr);

 if (_Ok)
  {
  const _Ctype& _Ctype_fac = use_facet< _Ctype >(_Istr.getloc());

  {
  streamsize _Count = 0 < _Istr.width() ? _Istr.width() : 2147483647L;
  typename _Myis::int_type _Meta = _Istr.rdbuf()->sgetc();
  _Elem _Ch;
  for (; 0 < --_Count; _Meta = _Istr.rdbuf()->snextc())
   if (_Traits::eq_int_type(_Traits::eof(), _Meta))
    {
    _State |= ios_base::eofbit;
    break;
    }
   else if (_Ctype_fac.is(_Ctype::space,
    _Ch = _Traits::to_char_type(_Meta))
     || _Ch == _Elem())
    break;
   else
    *_Str++ = _Traits::to_char_type(_Meta);
  }
  }

 *_Str = _Elem();
 _Istr.width(0);
 _Istr.setstate(_Str == _Str0 ? _State | ios_base::failbit : _State);
 return (_Istr);
 }

template<class _Elem,
 class _Traits> inline
 basic_istream<_Elem, _Traits>& operator>>(
  basic_istream<_Elem, _Traits> & _Istr, _Elem& _Ch)
 {
 typedef basic_istream<_Elem, _Traits> _Myis;

 typename _Myis::int_type _Meta;
 ios_base::iostate _State = ios_base::goodbit;
 const typename _Myis::sentry _Ok(_Istr);

 if (_Ok)
  {
  {
  _Meta = _Istr.rdbuf()->sbumpc();
  if (_Traits::eq_int_type(_Traits::eof(), _Meta))
   _State |= ios_base::eofbit | ios_base::failbit;
  else
   _Ch = _Traits::to_char_type(_Meta);
  }
  }

 _Istr.setstate(_State);
 return (_Istr);
 }

template<class _Traits> inline
 basic_istream<char, _Traits>& operator>>(
  basic_istream<char, _Traits> & _Istr, signed char *_Str)
 {
 return (_Istr >> (char *)_Str);
 }

template<class _Traits> inline
 basic_istream<char, _Traits>& operator>>(
  basic_istream<char, _Traits> & _Istr, signed char& _Ch)
 {
 return (_Istr >> (char&)_Ch);
 }

template<class _Traits> inline
 basic_istream<char, _Traits>& operator>>(
  basic_istream<char, _Traits> & _Istr, unsigned char *_Str)
 {
 return (_Istr >> (char *)_Str);
 }

template<class _Traits> inline
 basic_istream<char, _Traits>& operator>>(
  basic_istream<char, _Traits> & _Istr, unsigned char& _Ch)
 {
 return (_Istr >> (char&)_Ch);
 }


template<class _Elem,
 class _Traits,
 class _Ty> inline
 basic_istream<_Elem, _Traits>&
  operator>>(basic_istream<_Elem, _Traits>&& _Istr, _Ty& _Val)
 {
 return (_Istr >> _Val);
 }
#line 1060 "C:\\src\\winrtl\\include\\dinkumware64\\istream"
template<class _Elem,
 class _Traits> inline
 basic_istream<_Elem, _Traits>&
          ws(basic_istream<_Elem, _Traits>& _Istr)
 {
 typedef basic_istream<_Elem, _Traits> _Myis;
 typedef ctype<_Elem> _Ctype;

 if (!_Istr.eof())
  {
  ios_base::iostate _State = ios_base::goodbit;
  const typename _Myis::sentry _Ok(_Istr, true);

  if (_Ok)
   {
   const _Ctype& _Ctype_fac = use_facet< _Ctype >(_Istr.getloc());

   {
   for (typename _Traits::int_type _Meta = _Istr.rdbuf()->sgetc(); ;
    _Meta = _Istr.rdbuf()->snextc())
    if (_Traits::eq_int_type(_Traits::eof(), _Meta))
     {
     _State |= ios_base::eofbit;
     break;
     }
    else if (!_Ctype_fac.is(_Ctype::space,
     _Traits::to_char_type(_Meta)))
     break;
   }
   }

  _Istr.setstate(_State);
  }
 return (_Istr);
 }
}
#line 4 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"


namespace std {
extern FILE *_Fiopen(const char *, ios_base::openmode, int);
extern FILE *_Fiopen(const wchar_t *, ios_base::openmode, int);


template<class _Elem> inline
 bool _Fgetc(_Elem& _Ch, FILE *_File)
 {
 return (fread(&_Ch, sizeof (_Elem), 1, _File) == 1);
 }

template<> inline bool _Fgetc(char& _Byte, FILE *_File)
 {
 int _Meta;
 if ((_Meta = fgetc(_File)) == (-1))
  return (false);
 else
  {
  _Byte = (char)_Meta;
  return (true);
  }
 }

template<> inline bool _Fgetc(wchar_t& _Wchar, FILE *_File)
 {
 wint_t _Meta;
 if ((_Meta = ::std:: fgetwc(_File)) == (std::wint_t)(0xFFFF))
  return (false);
 else
  {
  _Wchar = (wchar_t)_Meta;
  return (true);
  }
 }


template<class _Elem> inline
 bool _Fputc(_Elem _Ch, FILE *_File)
 {
 return (fwrite(&_Ch, 1, sizeof (_Elem), _File) == sizeof (_Elem));
 }

template<> inline bool _Fputc(char _Byte, FILE *_File)
 {
 return (fputc(_Byte, _File) != (-1));
 }

template<> inline bool _Fputc(wchar_t _Wchar, FILE *_File)
 {
 return (::std:: fputwc(_Wchar, _File) != (std::wint_t)(0xFFFF));
 }


template<class _Elem> inline
 bool _Ungetc(const _Elem& _Ch, FILE *_File)
 {
 return (false);
 }

template<> inline bool _Ungetc(const char& _Byte, FILE *_File)
 {
 return (ungetc((unsigned char)_Byte, _File) != (-1));
 }

template<> inline bool _Ungetc(const signed char& _Byte, FILE *_File)
 {
 return (ungetc((unsigned char)_Byte, _File) != (-1));
 }

template<> inline bool _Ungetc(const unsigned char& _Byte, FILE *_File)
 {
 return (ungetc(_Byte, _File) != (-1));
 }

template<> inline bool _Ungetc(const wchar_t& _Wchar, FILE *_File)
 {
 return (::std:: ungetwc(_Wchar, _File) != (std::wint_t)(0xFFFF));
 }


template<class _Elem,
 class _Traits>
 class basic_filebuf
  : public basic_streambuf<_Elem, _Traits>
 {
public:
 typedef basic_filebuf<_Elem, _Traits> _Myt;
 typedef basic_streambuf<_Elem, _Traits> _Mysb;
 typedef typename _Traits::state_type _Myst;
 typedef codecvt<_Elem, char, typename _Traits::state_type> _Cvt;

 basic_filebuf(FILE *_File = 0)
  : _Mysb()
  {
  _Init(_File, _Newfl);
  }

 virtual ~basic_filebuf()
  {
  if (_Myfile != 0)
   _Reset_back();
  if (_Closef)
   close();
  }

 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;

 basic_filebuf(_Uninitialized)
  : _Mysb(_Noinit)
  {
  }


 basic_filebuf(_Myt&& _Right)
  {
  _Init(_Right._Myfile, _Newfl);
  _Init((FILE *)0, _Closefl);
  _Assign_rv(::std:: forward<_Myt>(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  return (*this);
  }

 void _Assign_rv(_Myt&& _Right)
  {
  if (this != &_Right)
   {
   close();
   this->swap(_Right);
   }
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   {

   FILE *_Myfile_sav = _Myfile;
   const _Cvt *_Pcvt_sav = _Pcvt;
   typename _Traits::state_type _State_sav = _State;
   bool _Wrotesome_sav = _Wrotesome;
   bool _Closef_sav = _Closef;
   bool _Set_eback_sav = _Mysb::eback() == &_Mychar;
   bool _Set_eback_live = _Mysb::gptr() == &_Mychar;

   _Elem *_Pfirst = _Mysb::pbase();
   _Elem *_Pnext = _Mysb::pptr();
   _Elem *_Pend = _Mysb::epptr();
   _Elem *_Gfirst = _Mysb::eback();
   _Elem *_Gnext = _Mysb::gptr();
   _Elem *_Gend = _Mysb::egptr();


   _Init(_Right._Myfile, _Right._Myfile != 0 ? _Openfl : _Newfl);
   _Mysb::setp(_Right.pbase(), _Right.pptr(), _Right.epptr());
   if (_Right.eback() != &_Right._Mychar)
    _Mysb::setg(_Right.eback(), _Right.gptr(), _Right.egptr());
   else if (_Right.gptr() != &_Right._Mychar)
    _Mysb::setg(&_Mychar, &_Mychar + 1, &_Mychar + 1);
   else
    _Mysb::setg(&_Mychar, &_Mychar, &_Mychar + 1);

   _Pcvt = _Right._Pcvt;
   _State = _Right._State;
   _Wrotesome = _Right._Wrotesome;
   _Closef = _Right._Closef;


   _Right._Init(_Myfile_sav, _Myfile_sav != 0 ? _Openfl : _Newfl);
   _Right.setp(_Pfirst, _Pnext, _Pend);
   if (!_Set_eback_sav)
    _Right.setg(_Gfirst, _Gnext, _Gend);
   else if (!_Set_eback_live)
    _Right.setg(&_Right._Mychar, &_Right._Mychar + 1,
     &_Right._Mychar + 1);
   else
    _Right.setg(&_Right._Mychar, &_Right._Mychar,
     &_Right._Mychar + 1);

   _Right._Pcvt = _Pcvt_sav;
   _Right._State = _State_sav;
   _Right._Wrotesome = _Wrotesome_sav;
   _Right._Closef = _Closef_sav;






   ::std:: swap(_Set_eback, _Right._Set_eback);
   ::std:: swap(_Set_egptr, _Right._Set_egptr);


   ::std:: swap(_Mychar, _Right._Mychar);
   ::std:: swap(_Mysb::_Plocale, _Right._Plocale);
   }
  }
#line 216 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
private:
  basic_filebuf(const _Myt& _Right);
  _Myt& operator=(const _Myt&);
public:


 enum _Initfl
  {
  _Newfl, _Openfl, _Closefl};

 bool is_open() const
  {
  return (_Myfile != 0);
  }

 _Myt *open(const char *_Filename,
  ios_base::openmode _Mode,
  int _Prot = (int)ios_base::_Openprot)
  {
  FILE *_File;
  if (_Myfile != 0 || (_File = _Fiopen(_Filename, _Mode, _Prot)) == 0)
   return (0);

  _Init(_File, _Openfl);
  _Initcvt(&use_facet< _Cvt >(_Mysb::getloc()));
  return (this);
  }


 _Myt *open(const string& _Str,
  ios_base::openmode _Mode,
  int _Prot = (int)ios_base::_Openprot)
  {
  return (open(_Str.c_str(), _Mode, _Prot));
  }


 _Myt *open(const char *_Filename, ios_base::open_mode _Mode)
  {
  return (open(_Filename, (ios_base::openmode)_Mode));
  }

 _Myt *open(const wchar_t *_Filename,
  ios_base::openmode _Mode,
  int _Prot = (int)ios_base::_Openprot)
  {
  FILE *_File;
  if (_Myfile != 0 || (_File = _Fiopen(_Filename, _Mode, _Prot)) == 0)
   return (0);

  _Init(_File, _Openfl);
  _Initcvt(&use_facet< _Cvt >(_Mysb::getloc()));
  return (this);
  }


 _Myt *open(const wstring& _Str,
  ios_base::openmode _Mode,
  int _Prot = (int)ios_base::_Openprot)
  {
  return (open(_Str.c_str(), _Mode, _Prot));
  }


 _Myt *open(const wchar_t *_Filename,
  ios_base::open_mode _Mode)
  {
  return (open(_Filename, (ios_base::openmode)_Mode));
  }

 _Myt *close()
  {
  _Myt *_Ans = this;
  if (_Myfile == 0)
   _Ans = 0;
  else
   {
   if (!_Endwrite())
    _Ans = 0;
   if (fclose(_Myfile) != 0)
    _Ans = 0;
   }
  _Init(0, _Closefl);
  return (_Ans);
  }
#line 315 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
 enum
  {
  _Openprot = 0666};

 _Myt *attach(signed char _Fd, const char *_Mode = "r+")
  {
  FILE *_File;
  if (_Myfile != 0 || (_File = ::std:: fdopen(_Fd, (char *)_Mode)) == 0)
   return (0);

  _Init(_File, _Openfl);
  _Initcvt(&use_facet< _Cvt >(_Mysb::getloc()));
  return (this);
  }

 FILE *stdiofile() const
  {
  return (_Myfile);
  }

 int fd() const
  {
  return (::std:: fileno(_Myfile));
  }


protected:
 virtual int_type overflow(int_type _Meta =
  _Traits::eof())
  {
  if (_Traits::eq_int_type(_Traits::eof(), _Meta))
   return (_Traits::not_eof(_Meta));
  else if (_Mysb::pptr() != 0
   && _Mysb::pptr() < _Mysb::epptr())
   {
   *_Mysb::_Pninc() = _Traits::to_char_type(_Meta);
   return (_Meta);
   }
  else if (_Myfile == 0)
   return (_Traits::eof());
  _Reset_back();
  if (_Pcvt == 0)
   return (_Fputc(_Traits::to_char_type(_Meta), _Myfile)
    ? _Meta : _Traits::eof());
  else
   {
   const int _STRING_INC = 8;
   const _Elem _Ch = _Traits::to_char_type(_Meta);
   const _Elem *_Src;
   char *_Dest;

   string _Str(_STRING_INC, '\0');
   for (; ; )
    switch (_Pcvt->out(_State,
     &_Ch, &_Ch + 1, _Src,
     &*_Str.begin(), &*_Str.begin() + _Str.size(), _Dest))
    {
    case codecvt_base::partial:
    case codecvt_base::ok:
     {
     size_t _Count = _Dest - &*_Str.begin();
     if (0 < _Count && _Count !=
      fwrite(&*_Str.begin(), 1, _Count, _Myfile))
      return (_Traits::eof());

     _Wrotesome = true;
     if (_Src != &_Ch)
      return (_Meta);

     if (0 < _Count)
      ;
     else if (_Str.size() < 4 * _STRING_INC)
      _Str.append(_STRING_INC, '\0');
     else
      return (_Traits::eof());
     break;
     }

    case codecvt_base::noconv:
     return (_Fputc(_Ch, _Myfile) ? _Meta
      : _Traits::eof());

    default:
     return (_Traits::eof());
    }
   }
 }

 virtual int_type pbackfail(int_type _Meta =
  _Traits::eof())
  {
  if (_Mysb::gptr() != 0
   && _Mysb::eback() < _Mysb::gptr()
   && (_Traits::eq_int_type(_Traits::eof(), _Meta)
   || _Traits::eq_int_type(_Traits::to_int_type(_Mysb::gptr()[-1]),
    _Meta)))
   {
   _Mysb::_Gndec();
   return (_Traits::not_eof(_Meta));
   }
  else if (_Myfile == 0 || _Traits::eq_int_type(_Traits::eof(), _Meta))
   return (_Traits::eof());
  else if (_Pcvt == 0 && _Ungetc(_Traits::to_char_type(_Meta), _Myfile))
   return (_Meta);
  else if (_Mysb::gptr() != &_Mychar)
   {
   _Mychar = _Traits::to_char_type(_Meta);
   _Set_back();
   return (_Meta);
   }
  else
   return (_Traits::eof());
 }

 virtual int_type underflow()
  {
  int_type _Meta;
  if (_Mysb::gptr() != 0
   && _Mysb::gptr() < _Mysb::egptr())
   return (_Traits::to_int_type(*_Mysb::gptr()));
  else if (_Traits::eq_int_type(_Traits::eof(), _Meta = uflow()))
   return (_Meta);
  else
   {
   pbackfail(_Meta);
   return (_Meta);
   }
  }

 virtual int_type uflow()
  {
  if (_Mysb::gptr() != 0
   && _Mysb::gptr() < _Mysb::egptr())
   return (_Traits::to_int_type(
    *_Mysb::_Gninc()));
  else if (_Myfile == 0)
   return (_Traits::eof());
  _Reset_back();
  if (_Pcvt == 0)
   {
   _Elem _Ch = 0;
   return (_Fgetc(_Ch, _Myfile) ? _Traits::to_int_type(_Ch)
    : _Traits::eof());
   }
  else
   {
   string _Str;

   for (; ; )
    {
    _Elem _Ch, *_Dest;
    const char *_Src;
    int _Nleft;
    int _Meta = fgetc(_Myfile);

    if (_Meta == (-1))
     return (_Traits::eof());

    _Str.append(1, (char)_Meta);
    switch (_Pcvt->in(_State,
     &*_Str.begin(), &*_Str.begin() + _Str.size(), _Src,
     &_Ch, &_Ch + 1, _Dest))
     {
    case codecvt_base::partial:
    case codecvt_base::ok:
     if (_Dest != &_Ch)
      {
      _Nleft = (int)(&*_Str.begin() + _Str.size() - _Src);
      for (; 0 < _Nleft; )
       ungetc(_Src[--_Nleft], _Myfile);
      return (_Traits::to_int_type(_Ch));
      }
     else
      _Str.erase((size_t)0,
       (size_t)(_Src - &*_Str.begin()));
     break;

    case codecvt_base::noconv:
     if (_Str.size() < sizeof (_Elem))
      break;

     memcpy(&_Ch, &*_Str.begin(),
      sizeof (_Elem));

     return (_Traits::to_int_type(_Ch));

    default:
     return (_Traits::eof());
     }
    }
   }
  }

 virtual pos_type seekoff(off_type _Off,
  ios_base::seekdir _Way,
  ios_base::openmode =
   (ios_base::openmode)(ios_base::in | ios_base::out))
  {
  fpos_t _Fileposition;

  if (_Mysb::gptr() == &_Mychar
   && _Way == ios_base::cur
   && _Pcvt == 0)
   _Off -= (off_type)sizeof (_Elem);

  if (_Myfile == 0 || !_Endwrite()
   || ((_Off != 0 || _Way != ios_base::cur)
    && fseek(_Myfile, _Off, _Way) != 0)
   || fgetpos(_Myfile, &_Fileposition) != 0)
   return (pos_type(_BADOFF));

  _Reset_back();
  return (pos_type(_State, _Fileposition));

  }

 virtual pos_type seekpos(pos_type _Pos,
  ios_base::openmode =
   (ios_base::openmode)(ios_base::in | ios_base::out))
  {
  fpos_t _Fileposition = _Pos.seekpos();
  off_type _Off = (off_type)_Pos - (off_type)((long)(_Fileposition));

  if (_Myfile == 0 || !_Endwrite()
   || fsetpos(_Myfile, &_Fileposition) != 0
   || (_Off != 0 && fseek(_Myfile, _Off, 1) != 0)
   || fgetpos(_Myfile, &_Fileposition) != 0)
   return (pos_type(_BADOFF));

  _State = _Pos.state();

  _Reset_back();
  return (pos_type(_State, _Fileposition));

  }

 virtual _Mysb * setbuf(_Elem *_Buffer, streamsize _Count)
  {
  if (_Myfile == 0 || setvbuf(_Myfile, (char *)_Buffer,
   _Buffer == 0 && _Count == 0 ? 2 : 0,
   (size_t)_Count * sizeof (_Elem)) != 0)
   return (0);
  else
   {
   _Init(_Myfile, _Openfl);
   return (this);
   }
  }

 virtual int sync()
  {
  return (_Myfile == 0
   || _Traits::eq_int_type(_Traits::eof(), overflow())
   || 0 <= fflush(_Myfile) ? 0 : -1);
  }

 virtual void imbue(const locale& _Loc)
  {
  _Initcvt(&use_facet< _Cvt >(_Loc));
  }

 void _Init(FILE *_File, _Initfl _Which)
  {
  static _Myst _Stinit;

  _Closef = _Which == _Openfl;
  _Wrotesome = false;

  _Mysb::_Init();
#line 611 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
  if (_File != 0 && sizeof (_Elem) == 1)
   {
#line 630 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
   _Elem **_Pb = (_Elem **)&_File->buffer;
   _Elem **_Pn = (_Elem **)&_File->curp;
   int *_Nr = (int *)&_File->level;
   int *_Nw = (int *)&_File->level;
   _Mysb::_Init(_Pb, _Pn, _Nr, _Pb, _Pn, _Nw);

   }


  _Myfile = _File;
  _State = _Stinit;
  _Pcvt = 0;
  }

 bool _Endwrite()
  {
  if (_Pcvt == 0 || !_Wrotesome)
   return (true);
  else
   {
   const int _STRING_INC = 8;
   char *_Dest;
   if (_Traits::eq_int_type(_Traits::eof(), overflow()))
    return (false);

   string _Str(_STRING_INC, '\0');
   for (; ; )
    switch (_Pcvt->unshift(_State,
     &*_Str.begin(), &*_Str.begin() + _Str.size(), _Dest))
    {
    case codecvt_base::ok:
     _Wrotesome = false;

    case codecvt_base::partial:
     {
     size_t _Count = _Dest - &*_Str.begin();
     if (0 < _Count && _Count !=
      fwrite(&*_Str.begin(), 1, _Count, _Myfile))
      return (false);
     if (!_Wrotesome)
      return (true);
     if (_Count == 0)
      _Str.append(_STRING_INC, '\0');
     break;
     }

    case codecvt_base::noconv:
     return (true);

    default:
     return (false);
    }
   }
  }

 void _Initcvt(const _Cvt *_Newpcvt)
  {
  if (_Newpcvt->always_noconv())
   _Pcvt = 0;
  else
   {
   _Pcvt = _Newpcvt;
   _Mysb::_Init();
   }
  }

private:
#line 710 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
 void _Reset_back()
  {
  if (_Mysb::eback() == &_Mychar)
   _Mysb::setg(_Set_eback, _Set_eback, _Set_egptr);
  }

 void _Set_back()
  {
  if (_Mysb::eback() != &_Mychar)
   {
   _Set_eback = _Mysb::eback();
   _Set_egptr = _Mysb::egptr();
   }
  _Mysb::setg(&_Mychar, &_Mychar, &_Mychar + 1);
  }

 _Elem *_Set_eback;
 _Elem *_Set_egptr;


 const _Cvt *_Pcvt;
 _Elem _Mychar;
 bool _Wrotesome;
 typename _Traits::state_type _State;
 bool _Closef;
 FILE *_Myfile;
 };



template<class _Elem,
 class _Traits> inline
 void swap(basic_filebuf<_Elem, _Traits>& _Left,
  basic_filebuf<_Elem, _Traits>& _Right)
 {
 _Left.swap(_Right);
 }



template<class _Elem,
 class _Traits>
 class basic_ifstream
  : public basic_istream<_Elem, _Traits>
 {
public:
 typedef basic_ifstream<_Elem, _Traits> _Myt;
 typedef basic_istream<_Elem, _Traits> _Mybase;
 typedef basic_filebuf<_Elem, _Traits> _Myfb;
 typedef basic_ios<_Elem, _Traits> _Myios;

 basic_ifstream()
  : _Mybase(&_Filebuffer)
  {
  }

 explicit basic_ifstream(const char *_Filename,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::in, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ifstream(const string& _Str,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Str.c_str(), _Mode | ios_base::in, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ifstream(const wchar_t *_Filename,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::in, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ifstream(const wstring& _Str,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Str.c_str(), _Mode | ios_base::in, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ifstream(FILE *_File)
  : _Mybase(&_Filebuffer),
   _Filebuffer(_File)
  {
  }


 explicit basic_ifstream(signed char _Fd)
  : _Mybase(&_Filebuffer),
   _Filebuffer(::std:: fdopen(_Fd, "r"))
  {
  }



 basic_ifstream(_Myt&& _Right)
  : _Mybase(&_Filebuffer)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  return (*this);
  }

 void _Assign_rv(_Myt&& _Right)
  {
  if (this != &_Right)
   {
   _Filebuffer.close();
   this->swap(_Right);
   }
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   {
   _Mybase::swap(_Right);
   _Filebuffer.swap(_Right._Filebuffer);
   }
  }
#line 858 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
private:
  basic_ifstream(const _Myt& _Right);
  _Myt& operator=(const _Myt&);
public:



 _Myt *attach(signed char _Fd, const char *_Mode = "r")
  {
  return (_Filebuffer.attach(_Fd, _Mode) != 0 ? this : 0);
  }


 void open(const wchar_t *_Filename,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::in, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  else
   _Myios::clear();
  }


 void open(const wstring& _Str,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  {
  open(_Str.c_str(), _Mode, _Prot);
  }


 void open(const wchar_t *_Filename, ios_base::open_mode _Mode)
  {
  open(_Filename, (ios_base::openmode)_Mode);
  }

 virtual ~basic_ifstream()
  {
  }

 _Myfb *rdbuf() const
  {
  return ((_Myfb *)&_Filebuffer);
  }

 bool is_open() const
  {
  return (_Filebuffer.is_open());
  }

 void open(const char *_Filename,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::in, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  else
   _Myios::clear();
  }


 void open(const string& _Str,
  ios_base::openmode _Mode = ios_base::in,
  int _Prot = (int)ios_base::_Openprot)
  {
  open(_Str.c_str(), _Mode, _Prot);
  }


 void open(const char *_Filename, ios_base::open_mode _Mode)
  {
  open(_Filename, (ios_base::openmode)_Mode);
  }

 void close()
  {
  if (_Filebuffer.close() == 0)
   _Myios::setstate(ios_base::failbit);
  }

private:
 _Myfb _Filebuffer;
 };



template<class _Elem,
 class _Traits> inline
 void swap(basic_ifstream<_Elem, _Traits>& _Left,
  basic_ifstream<_Elem, _Traits>& _Right)
 {
 _Left.swap(_Right);
 }



template<class _Elem,
 class _Traits>
 class basic_ofstream
  : public basic_ostream<_Elem, _Traits>
 {
public:
 typedef basic_ofstream<_Elem, _Traits> _Myt;
 typedef basic_ostream<_Elem, _Traits> _Mybase;
 typedef basic_filebuf<_Elem, _Traits> _Myfb;
 typedef basic_ios<_Elem, _Traits> _Myios;

 basic_ofstream()
  : _Mybase(&_Filebuffer)
  {
  }

 explicit basic_ofstream(const char *_Filename,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::out, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ofstream(const string& _Str,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Str.c_str(), _Mode | ios_base::out, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ofstream(const wchar_t *_Filename,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::out, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ofstream(const wstring& _Str,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Str.c_str(), _Mode | ios_base::out, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_ofstream(FILE *_File)
  : _Mybase(&_Filebuffer),
   _Filebuffer(_File)
  {
  }


 explicit basic_ofstream(signed char _Fd)
  : _Mybase(&_Filebuffer),
   _Filebuffer(::std:: fdopen(_Fd, "w"))
  {
  }



 basic_ofstream(_Myt&& _Right)
  : _Mybase(&_Filebuffer)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  return (*this);
  }

 void _Assign_rv(_Myt&& _Right)
  {
  if (this != &_Right)
   {
   _Filebuffer.close();
   this->swap(_Right);
   }
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   {
   _Mybase::swap(_Right);
   _Filebuffer.swap(_Right._Filebuffer);
   }
  }
#line 1063 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
private:
  basic_ofstream(const _Myt& _Right);
  _Myt& operator=(const _Myt&);
public:



 _Myt *attach(signed char _Fd, const char *_Mode = "w")
  {
  return (_Filebuffer.attach(_Fd, _Mode) != 0 ? this : 0);
  }


 void open(const wchar_t *_Filename,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::out, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  else
   _Myios::clear();
  }


 void open(const wstring& _Str,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  open(_Str.c_str(), _Mode, _Prot);
  }


 void open(const wchar_t *_Filename, ios_base::open_mode _Mode)
  {
  open(_Filename, (ios_base::openmode)_Mode);
  }

 virtual ~basic_ofstream()
  {
  }

 _Myfb *rdbuf() const
  {
  return ((_Myfb *)&_Filebuffer);
  }

 bool is_open() const
  {
  return (_Filebuffer.is_open());
  }

 void open(const char *_Filename,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  if (_Filebuffer.open(_Filename, _Mode | ios_base::out, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  else
   _Myios::clear();
  }


 void open(const string& _Str,
  ios_base::openmode _Mode = ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  open(_Str.c_str(), _Mode, _Prot);
  }


 void open(const char *_Filename, ios_base::open_mode _Mode)
  {
  open(_Filename, (ios_base::openmode)_Mode);
  }

 void close()
  {
  if (_Filebuffer.close() == 0)
   _Myios::setstate(ios_base::failbit);
  }

private:
 _Myfb _Filebuffer;
 };



template<class _Elem,
 class _Traits> inline
 void swap(basic_ofstream<_Elem, _Traits>& _Left,
  basic_ofstream<_Elem, _Traits>& _Right)
 {
 _Left.swap(_Right);
 }



template<class _Elem,
 class _Traits>
 class basic_fstream
  : public basic_iostream<_Elem, _Traits>
 {
public:
 typedef basic_fstream<_Elem, _Traits> _Myt;
 typedef basic_iostream<_Elem, _Traits> _Mybase;
 typedef basic_filebuf<_Elem, _Traits> _Myfb;
 typedef basic_ios<_Elem, _Traits> _Myios;
 typedef _Elem char_type;
 typedef _Traits traits_type;
 typedef typename _Traits::int_type int_type;
 typedef typename _Traits::pos_type pos_type;
 typedef typename _Traits::off_type off_type;

 basic_fstream()
  : _Mybase(&_Filebuffer)
  {
  }

 explicit basic_fstream(const char *_Filename,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Filename, _Mode, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_fstream(const string& _Str,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Str.c_str(), _Mode, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_fstream(const wchar_t *_Filename,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Filename, _Mode, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_fstream(const wstring& _Str,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  : _Mybase(&_Filebuffer)
  {
  if (_Filebuffer.open(_Str.c_str(), _Mode, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  }


 explicit basic_fstream(FILE *_File)
  : _Mybase(&_Filebuffer),
   _Filebuffer(_File)
  {
  }


 explicit basic_fstream(signed char _Fd)
  : _Mybase(&_Filebuffer),
   _Filebuffer(::std:: fdopen(_Fd, "r+"))
  {
  }



 basic_fstream(_Myt&& _Right)
  : _Mybase(&_Filebuffer)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  }

 _Myt& operator=(_Myt&& _Right)
  {
  _Assign_rv(::std:: forward<_Myt>(_Right));
  return (*this);
  }

 void _Assign_rv(_Myt&& _Right)
  {
  if (this != &_Right)
   {
   _Filebuffer.close();
   this->swap(_Right);
   }
  }

 void swap(_Myt& _Right)
  {
  if (this != &_Right)
   {
   _Mybase::swap(_Right);
   _Filebuffer.swap(_Right._Filebuffer);
   }
  }
#line 1273 "C:\\src\\winrtl\\include\\dinkumware64\\fstream"
private:
  basic_fstream(const _Myt& _Right);
  _Myt& operator=(const _Myt&);
public:



 _Myt *attach(signed char _Fd, const char *_Mode = "r+")
  {
  return (_Filebuffer.attach(_Fd, _Mode) != 0 ? this : 0);
  }


 void open(const wchar_t *_Filename,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  if (_Filebuffer.open(_Filename, _Mode, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  else
   _Myios::clear();
  }


 void open(const wstring& _Str,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  open(_Str.c_str(), _Mode, _Prot);
  }


 void open(const wchar_t *_Filename, ios_base::open_mode _Mode)
  {
  open(_Filename, (ios_base::openmode)_Mode);
  }

 virtual ~basic_fstream()
  {
  }

 _Myfb *rdbuf() const
  {
  return ((_Myfb *)&_Filebuffer);
  }

 bool is_open() const
  {
  return (_Filebuffer.is_open());
  }

 void open(const char *_Filename,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  if (_Filebuffer.open(_Filename, _Mode, _Prot) == 0)
   _Myios::setstate(ios_base::failbit);
  else
   _Myios::clear();
  }


 void open(const string& _Str,
  ios_base::openmode _Mode = ios_base::in | ios_base::out,
  int _Prot = (int)ios_base::_Openprot)
  {
  open(_Str.c_str(), _Mode, _Prot);
  }


 void open(const char *_Filename, ios_base::open_mode _Mode)
  {
  open(_Filename, (ios_base::openmode)_Mode);
  }

 void close()
  {
  if (_Filebuffer.close() == 0)
   _Myios::setstate(ios_base::failbit);
 }

private:
 _Myfb _Filebuffer;
 };



template<class _Elem,
 class _Traits> inline
 void swap(basic_fstream<_Elem, _Traits>& _Left,
  basic_fstream<_Elem, _Traits>& _Right)
 {
 _Left.swap(_Right);
 }

}
#line 2 "fiopen.cpp"
#line 27 "fiopen.cpp"
namespace std {
__declspec(dllexport) FILE * _Fiopen(const wchar_t *filename,
 ios_base::openmode mode, int prot)
 {
 char c_name[260];

 if (wcstombs(c_name, filename, 260) == (size_t)(-1))
  return (0);
 return _Fiopen(c_name, mode, prot);
 }


__declspec(dllexport) FILE * _Fiopen(const ::std:: _Sysch_t *filename,
 ios_base::openmode mode, int)
 {
 static const ::std:: _Sysch_t *mods[] =
  {
  "r", "w", "w", "a",
  "rb", "wb", "wb", "ab",
  "r+", "w+", "a+",
  "r+b", "w+b", "a+b",
  0};

 static const int valid[] =
  {
  ios_base::in,
  ios_base::out,
  ios_base::out | ios_base::trunc,
  ios_base::out | ios_base::app,
  ios_base::in | ios_base::binary,
  ios_base::out | ios_base::binary,
  ios_base::out | ios_base::trunc | ios_base::binary,
  ios_base::out | ios_base::app | ios_base::binary,
  ios_base::in | ios_base::out,
  ios_base::in | ios_base::out | ios_base::trunc,
  ios_base::in | ios_base::out | ios_base::app,
  ios_base::in | ios_base::out | ios_base::binary,
  ios_base::in | ios_base::out | ios_base::trunc
   | ios_base::binary,
  ios_base::in | ios_base::out | ios_base::app
   | ios_base::binary,
  0};

 FILE *fp = 0;
 int n;
 ios_base::openmode atendflag = mode & ios_base::ate;
 ios_base::openmode norepflag = mode & ios_base::_Noreplace;

 if (mode & ios_base::_Nocreate)
  mode |= ios_base::in;
 if (mode & ios_base::app)
  mode |= ios_base::out;

 mode &= ~(ios_base::ate | ios_base::_Nocreate | ios_base::_Noreplace);
 for (n = 0; valid[n] != 0 && valid[n] != mode; ++n)
  ;

 if (valid[n] == 0)
  return (0);
 else if (norepflag && (mode & (ios_base::out || ios_base::app))
  && (fp = fopen(filename, "r")) != 0)
  {
  fclose(fp);
  return (0);
  }
 else if (fp != 0 && fclose(fp) != 0)
  return (0);

 else if ((fp = fopen(filename, mods[n])) == 0)
  return (0);

 if (!atendflag || fseek(fp, 0, 2) == 0)
  return (fp);

 fclose(fp);
 return (0);
 }
}
