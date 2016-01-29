////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/loki_extension.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::loki_extension
//
// расширение Локи, позволяющее получить номер типа из списка типов, при условии что данный тип в
// списке встречается несколько раз
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_ALG_LOKI_EXTENSION_H__
#define __SHARED_GCL_ALG_LOKI_EXTENSION_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450133A803C8_USER_INCLUDES*
//#UC END# *450133A803C8_USER_INCLUDES*

namespace GCL {

//#UC START# *450133A803C8_USER_DEFINITION*
//input: TList, int head
//output: TList tail (TList without head elements)
template <class TList, int head> struct TLTail;

template<int head>
struct TLTail< ::Loki::NullType, head> {
	typedef ::Loki::NullType Result;     
};

template<class Head, class TList>
struct TLTail< ::Loki::Typelist <Head, TList>, 0> {
	typedef typename ::Loki::Typelist <Head, TList> Result;
};

template<class Head, class TList, int head>
struct TLTail< ::Loki::Typelist <Head, TList>, head> {
	typedef typename TLTail<TList, head-1>::Result Result;
};


//input: TList,  T, int number
//output: index of T or -1 if absent
template <class TList, class T, int num=0> struct IndexOfNum;

template<class T, int num>
struct IndexOfNum< ::Loki::NullType, T, num> {
	enum {value = -1};
};

template<class Head, class Tail, class T>
struct IndexOfNum< ::Loki::Typelist<Head, Tail>, T, 0> {
	typedef typename ::Loki::Typelist<Head, Tail> List;
	enum {value = ::Loki::TL::IndexOf<List, T>::value};
};

template<class Head, class Tail, class T, int num>
struct IndexOfNum< ::Loki::Typelist<Head, Tail>, T, num> {
	typedef typename ::Loki::Typelist<Head, Tail> List;

private:
	enum {temp = ::Loki::TL::IndexOf<List, T>::value+1};
	typedef typename ::TLTail<List, temp>::Result Result;

public:
	enum {value = ::IndexOfNum<Result, T, num-1>::value == -1 ? -1 : temp + ::IndexOfNum<Result, T, num-1>::value};
};
//#UC END# *450133A803C8_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_ALG_LOKI_EXTENSION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
