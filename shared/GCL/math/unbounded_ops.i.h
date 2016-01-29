////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/math/unbounded_ops.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::math::unbounded_ops
// Файл inline реализации утилитного набора unbounded_ops
//
// Набор функций и макросов для работы с массивами произвольной длинны
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *4501954D0280_CUSTOM_INCLUDES*
//#UC END# *4501954D0280_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4501954D0280*
template <typename T>
struct Max {
	static T exec (const T& p1, const T& p2) {
		return (p1 > p2) ? p1 : p2;
	}
};

template <typename T>
struct Min {
	static T exec (const T& p1, const T& p2) {
		return (p1 < p2) ? p1 : p2;
	}
};

template <typename T>
struct Sum {
	static T exec (const T& p1, const T& p2) {
		return p1 + p2;
	}
};
template<template <typename T> class Operation, typename T>	
T gcl_operation (const T& a1) {				
	return a1;
}

template<template <typename T> class Operation, typename T>	
T gcl_operation (const T& a1, const T& a2) {				
	return Operation<T>::exec (a1, a2);
}	

template<template <typename T> class Operation, typename T>
T gcl_operation (const T& a1, const T& a2, const T& a3) {				
	return Operation<T>::exec (a1, gcl_operation<Operation> (a2, a3));
}	
template<template <typename T> class Operation, typename T>
T gcl_operation (const T& a1, const T& a2, const T& a3, const T& a4) {		
	return Operation<T>::exec (a1, gcl_operation<Operation> (a2, a3, a4));
}	
template<template <typename T> class Operation, typename T>
T gcl_operation (const T& a1, const T& a2, const T& a3, const T& a4, const T& a5) {		
	return Operation<T>::exec (a1, gcl_operation<Operation> (a2, a3, a4, a5));
}	
template<template <typename T> class Operation, typename T>
T gcl_operation (const T& a1, const T& a2, const T& a3, const T& a4, const T& a5, const T& a6) {		
	return Operation<T>::exec (a1, gcl_operation<Operation> (a2, a3, a4, a5, a6));
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
) {				
	return Operation<T>::exec (a1, gcl_operation<Operation> (a2, a3, a4, a5, a6, a7));
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
) {		
	return Operation<T>::exec (a1, gcl_operation<Operation> (a2, a3, a4, a5, a6, a7, a8));
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
) {		
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
		)
	);
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
	, const T& a10
) {		
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
			, a10
		)
	);
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
	, const T& a10
	, const T& a11
) {				
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
			, a10
			, a11
		)
	);
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
	, const T& a10
	, const T& a11
	, const T& a12
) {				
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
			, a10
			, a11
			, a12
		)
	);
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
	, const T& a10
	, const T& a11
	, const T& a12
	, const T& a13
) {				
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
			, a10
			, a11
			, a12
			, a13
		)
	);
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
	, const T& a10
	, const T& a11
	, const T& a12
	, const T& a13
	, const T& a14
) {				
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
			, a10
			, a11
			, a12
			, a13
			, a14
		)
	);
}
template<template <typename T> class Operation, typename T>
T gcl_operation (
	const T& a1
	, const T& a2
	, const T& a3
	, const T& a4
	, const T& a5
	, const T& a6
	, const T& a7
	, const T& a8
	, const T& a9
	, const T& a10
	, const T& a11
	, const T& a12
	, const T& a13
	, const T& a14
	, const T& a15
) {				
	return Operation<T>::exec (
		a1
		, gcl_operation<Operation> (
			a2
			, a3
			, a4
			, a5
			, a6
			, a7
			, a8
			, a9
			, a10
			, a11
			, a12
			, a13
			, a14
			, a15
		)
	);
}

//#UC END# *4501954D0280*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

