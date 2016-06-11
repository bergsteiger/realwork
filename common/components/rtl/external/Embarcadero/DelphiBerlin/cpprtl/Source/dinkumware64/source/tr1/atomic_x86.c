/* atomic_x86.c -- atomic implementation for x86 */
#include <yvals.h>

 #if _MULTI_THREAD
#include <xatomic.h>
_STD_BEGIN
_EXTERN_C

 #if defined(_MSC_VER)
  #define _Compiler_barrier()	_ReadWriteBarrier()

void _ReadWriteBarrier();
short _InterlockedExchangeAdd16(volatile short *, short);
short _InterlockedAnd16(volatile short *, short);
short _InterlockedOr16(volatile short *, short);
short _InterlockedXor16(volatile short *, short);

long _InterlockedCompareExchange(volatile long *, long, long);
long _InterlockedExchange(volatile long *, long);
long _InterlockedExchangeAdd(volatile long *, long);
long _InterlockedAnd(volatile long *, long);
long _InterlockedOr(volatile long *, long);
long _InterlockedXor(volatile long *, long);

  #pragma intrinsic(_ReadWriteBarrier)
  #pragma intrinsic(_InterlockedExchangeAdd16)
  #pragma intrinsic(_InterlockedAnd16)
  #pragma intrinsic(_InterlockedOr16)
  #pragma intrinsic(_InterlockedXor16)
  #pragma intrinsic(_InterlockedAnd)
  #pragma intrinsic(_InterlockedOr)
  #pragma intrinsic(_InterlockedXor)
  #pragma intrinsic(_InterlockedExchange)
  #pragma intrinsic(_InterlockedCompareExchange)
  #pragma intrinsic(_InterlockedExchangeAdd)

  #if defined(_DEBUG) && _MSC_VER <= 1400

   #if _MS_64
	/* add missing functions for v8x64 db */
static long _InterlockedOr(volatile long *p, long v)
	{
	return (long)(*p | v);
	}

static long _InterlockedAnd(volatile long *p, long v)
	{
	return (long)(*p & v);
	}

static long _InterlockedXor(volatile long *p, long v)
	{
	return (long)(*p ^ v);
	}

static _LONGLONG _InterlockedOr64(volatile _LONGLONG *p, _LONGLONG v)
	{
	return (_LONGLONG)(*p | v);
	}

static _LONGLONG _InterlockedAnd64(volatile _LONGLONG *p, _LONGLONG v)
	{
	return (_LONGLONG)(*p & v);
	}

static _LONGLONG _InterlockedXor64(volatile _LONGLONG *p, _LONGLONG v)
	{
	return (_LONGLONG)(*p ^ v);
	}

  #pragma intrinsic(_InterlockedOr)
  #pragma intrinsic(_InterlockedAnd)
  #pragma intrinsic(_InterlockedXor)
  #pragma intrinsic(_InterlockedOr64)
  #pragma intrinsic(_InterlockedAnd64)
  #pragma intrinsic(_InterlockedAnd64)
 #endif /* _MS_64 */

  #endif /* defined(_DEBUG) && _MSC_VER <= 1400 */

 #elif defined(__GNUC__)
  #define _Compiler_barrier()	__asm__ __volatile__ ("" : : : "memory")

 #elif  defined(__CODEGEARC__) && defined(__clang__)
 #define _Compiler_barrier()	__asm__ __volatile__ ("" : : : "memory")

 #else /* compiler type */
  #error Unknown compiler
 #endif /* compiler type */

  #ifndef _INVALID_MEMORY_ORDER

   #if _ITERATOR_DEBUG_LEVEL == 2
    #define _INVALID_MEMORY_ORDER \
		{_DEBUG_ERROR("Invalid memory_order"); \
		_SCL_SECURE_INVALID_ARGUMENT}

   #elif _ITERATOR_DEBUG_LEVEL == 1
    #define _INVALID_MEMORY_ORDER \
		_SCL_SECURE_VALIDATE("Invalid memory_order" && 0)

   #elif _ITERATOR_DEBUG_LEVEL == 0
    #define _INVALID_MEMORY_ORDER
   #endif /* _ITERATOR_DEBUG_LEVEL */

  #endif /* _INVALID_MEMORY_ORDER */

static memory_order _Memory_order_upper_bound(memory_order _Order1,
	memory_order _Order2)
	{	/* find upper bound of two memory orders,
			based on the following partial order:

	                           seq_cst
	                              |
	                           acq_rel
	                           /     \
	                       acquire  release
	                          |       |
	                       consume    |
	                           \     /
	                           relaxed

		*/

	static const memory_order _Upper[6][6] = {	/* combined upper bounds */
		{ memory_order_relaxed, memory_order_consume, memory_order_acquire,
		memory_order_release, memory_order_acq_rel, memory_order_seq_cst },
		{ memory_order_consume, memory_order_consume, memory_order_acquire,
		memory_order_acq_rel, memory_order_acq_rel, memory_order_seq_cst },
		{ memory_order_acquire, memory_order_acquire, memory_order_acquire,
		memory_order_acq_rel, memory_order_acq_rel, memory_order_seq_cst },
		{ memory_order_release, memory_order_acq_rel, memory_order_acq_rel,
		memory_order_release, memory_order_acq_rel, memory_order_seq_cst },
		{ memory_order_acq_rel, memory_order_acq_rel, memory_order_acq_rel,
		memory_order_acq_rel, memory_order_acq_rel, memory_order_seq_cst },
		{ memory_order_seq_cst, memory_order_seq_cst, memory_order_seq_cst,
		memory_order_seq_cst, memory_order_seq_cst, memory_order_seq_cst
		}
		};

 #if _CLANG	/* compiler test */
	if ((6 <= _Order1) || (6 <= _Order2))

 #else /* _CLANG */
	if ((_Order1 < 0) || (6 <= _Order1)
		|| (_Order2 < 0) || (6 <= _Order2))
 #endif /* _CLANG */

		{	/* launder memory order */
		_INVALID_MEMORY_ORDER;
		return (memory_order_seq_cst);
		}
	return (_Upper[_Order1][_Order2]);
	}

static void _Validate_compare_exchange_memory_order(
	memory_order _Success, memory_order _Failure)
	{	/* validate success/failure */
	/* _Failure may not be memory_order_release or memory_order_acq_rel
		and may not be stronger than _Success */
	switch (_Failure)
		{
	case memory_order_relaxed:
		break;

	case memory_order_seq_cst:
		if (_Success != memory_order_seq_cst)
			_INVALID_MEMORY_ORDER;
		break;

	case memory_order_acquire:
		if ((_Success == memory_order_consume) ||
			(_Success == memory_order_relaxed))
			_INVALID_MEMORY_ORDER;
		break;

	case memory_order_consume:
		if (_Success == memory_order_relaxed)
			_INVALID_MEMORY_ORDER;
		break;

	default:
		_INVALID_MEMORY_ORDER;
		break;
		}
	}

 #if _MS_64

 #else /* _MS_64 */
	/* 1-byte and 2-byte functions; not used with MS 64-bit */
static void _Store_relaxed_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* store _Value atomically with relaxed memory order */
  #if defined(_M_ARM)
	__iso_volatile_store8((volatile char *)_Tgt, _Value);

 #elif _MS_32
	_Compiler_barrier();
	__asm
		{
		mov al, _Value;
		mov edx, _Tgt;
		mov [edx], al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		);
	_Compiler_barrier();
#elif defined(__CODEGEARC__) && defined(__clang__)
        __c11_atomic_store(_Tgt, _Value, memory_order_seq_relaxed);
 #endif /* _MS_32 */
	}

static void _Store_release_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* store _Value atomically with release memory order */
  #if defined(_M_ARM)
	_Memory_barrier();
	__iso_volatile_store8((volatile char *)_Tgt, _Value);

 #elif _MS_32
	_Compiler_barrier();
	__asm
		{
		mov al, _Value;
		mov edx, _Tgt;
		mov [edx], al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

	/* _Atomic_store_1 */
static void _Store_seq_cst_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* store _Value atomically with sequentially
			consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov al, _Value;
		mov edx, _Tgt;
		lock xchg [edx], al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgb %1, %0\n\t"
		: "+m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
#elif defined(__CODEGEARC__) && defined(__clang__)
        __c11_atomic_store(_Tgt, _Value, memory_order_seq_cst);
 #endif /* _MS_32 */
	}

void _Atomic_store_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value,
	memory_order _Order)
	{	/* store _Value atomically */
	switch(_Order)
		{
		case memory_order_relaxed:
			_Store_relaxed_1(_Tgt, _Value);
			break;

		case memory_order_release:
			_Store_release_1(_Tgt, _Value);
			break;

		case memory_order_seq_cst:
			_Store_seq_cst_1(_Tgt, _Value);
			break;

		default:
			_INVALID_MEMORY_ORDER;
			break;
		}
	}

	/* _Atomic_load_1 */
static _Uint1_t _Load_seq_cst_1(volatile _Uint1_t *_Tgt)
	{	/* load from *_Tgt atomically with
			sequentially consistent memory order */
	_Uint1_t _Value;

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov al, [edx];
		mov _Value, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %1, %0\n\t"
		: "=r" (_Value)
		: "m" (*_Tgt)
		: "memory"
		);
	_Compiler_barrier();
#elif defined(__CODEGEARC__) && defined(__clang__)
        __c11_atomic_load(_Tgt, &_Value, memory_order_seq_cst);
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint1_t _Atomic_load_1(volatile _Uint1_t *_Tgt,
	memory_order _Order)
	{	/* load from *_Tgt atomically
		use sequentially consistent for all memory orders: */
	return (_Load_seq_cst_1(_Tgt));
	}

	/* _Atomic_exchange_1 */
static _Uint1_t _Exchange_seq_cst_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov al, _Value;
		mov edx, _Tgt;
		lock xchg [edx], al;
		mov _Value, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgb %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
#elif defined(__CODEGEARC__) && defined(__clang__)
        __c11_atomic_exchange(_Tgt, _Value, memory_order_seq_cst);
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint1_t _Atomic_exchange_1(volatile _Uint1_t *_Tgt,
	_Uint1_t _Value, memory_order _Order)
	{	/* exchange _Value and *_Tgt atomically
		use sequentially consistent for all memory orders: */
	return (_Exchange_seq_cst_1(_Tgt, _Value));
	}

	/* _Atomic_compare_exchange_weak_1, _Atomic_compare_exchange_strong_1 */
static int _Compare_exchange_seq_cst_1(volatile _Uint1_t *_Tgt,
	_Uint1_t *_Exp, _Uint1_t _Value)
	{	/* compare and exchange values atomically with
			sequentially consistent memory order */
	_Uint1_t _Res;

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ecx, _Exp;
		mov bl, _Value;
		mov al, [ecx];
		lock cmpxchg [edx], bl;
		jz eql;
		mov [ecx], al;
	eql:
		setz al;
		mov _Res, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %2, %%al\n\t"
		"lock cmpxchgb %3, %1\n\t"
		"jz 0f\n\t"
		"movb %%al, %2\n"
	"0:\n\t"
		"setzb %0\n\t"
		: "=m" (_Res),
		  "+m" (*_Tgt),
		  "+m" (*_Exp)
		: "r" (_Value)
		: "al", "memory", "cc"
		);
	_Compiler_barrier();
#elif defined(__CODEGEARC__) && defined(__clang__)
        _Res = __c11_atomic_compare_exchange_strong(_Tgt, _Exp, _Value, memory_order_seq_cst);
 #endif /* _MS_32 */

	return (_Res);
	}

int _Atomic_compare_exchange_strong_1(
	volatile _Uint1_t *_Tgt, _Uint1_t *_Exp, _Uint1_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Compare_exchange_seq_cst_1(_Tgt, _Exp, _Value));
	}

int _Atomic_compare_exchange_weak_1(
	volatile _Uint1_t *_Tgt, _Uint1_t *_Exp, _Uint1_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Compare_exchange_seq_cst_1(_Tgt, _Exp, _Value));
	}

	/* _Atomic_fetch_add_1, _Atomic_fetch_sub_1 */
static _Uint1_t _Fetch_add_seq_cst_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* add _Value to *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov al, _Value;
		lock xadd [edx], al;
		mov _Value, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xaddb %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint1_t _Atomic_fetch_add_1(
	volatile _Uint1_t *_Tgt, _Uint1_t _Value, memory_order _Order)
	{	/* add _Value to *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_add_seq_cst_1(_Tgt, _Value));
	}

_Uint1_t _Atomic_fetch_sub_1(
	volatile _Uint1_t *_Tgt, _Uint1_t _Value, memory_order _Order)
	{	/* subtract _Value from *_Tgt atomically */
	return (_Atomic_fetch_add_1(_Tgt, 0 - _Value, _Order));
	}

	/* _Atomic_fetch_and_1 */
static _Uint1_t _Fetch_and_seq_cst_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* and _Value with *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov al, [edx];
	again:
		mov bl, al;
		and bl, _Value;
		lock cmpxchg [edx], bl;
		jnz again;
		mov _Value, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %0, %%al\n"
	"0:\n\t"
		"movb %%al, %%bl\n\t"
		"andb %1, %%bl\n\t"
		"lock cmpxchgb %%bl, %0\n\t"
		"jnz 0b\n\t"
		"movb %%al, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "al", "bl", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint1_t _Atomic_fetch_and_1(
	volatile _Uint1_t *_Tgt, _Uint1_t _Value, memory_order _Order)
	{	/* and _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_and_seq_cst_1(_Tgt, _Value));
	}

	/* _Atomic_fetch_or_1 */
static _Uint1_t _Fetch_or_seq_cst_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* or _Value with *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov al, [edx];
	again:
		mov bl, al;
		or bl, _Value;
		lock cmpxchg [edx], bl;
		jnz again;
		mov _Value, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %0, %%al\n"
	"0:\n\t"
		"movb %%al, %%bl\n\t"
		"orb %1, %%bl\n\t"
		"lock cmpxchgb %%bl, %0\n\t"
		"jnz 0b\n\t"
		"movb %%al, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "al", "bl", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint1_t _Atomic_fetch_or_1(
	volatile _Uint1_t *_Tgt, _Uint1_t _Value, memory_order _Order)
	{	/* or _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_or_seq_cst_1(_Tgt, _Value));
	}

	/* _Atomic_fetch_xor_1 */
static _Uint1_t _Fetch_xor_seq_cst_1(volatile _Uint1_t *_Tgt, _Uint1_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov al, [edx];
	again:
		mov bl, al;
		xor bl, _Value;
		lock cmpxchg [edx], bl;
		jnz again;
		mov _Value, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movb %0, %%al\n"
	"0:\n\t"
		"movb %%al, %%bl\n\t"
		"xorb %1, %%bl\n\t"
		"lock cmpxchgb %%bl, %0\n\t"
		"jnz 0b\n\t"
		"movb %%al, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "al", "bl", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint1_t _Atomic_fetch_xor_1(
	volatile _Uint1_t *_Tgt, _Uint1_t _Value, memory_order _Order)
	{	/* xor _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_xor_seq_cst_1(_Tgt, _Value));
	}

	/* _Atomic_store_2 */
static void _Store_relaxed_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* store _Value atomically with relaxed memory order */
  #if defined(_M_ARM)
	__iso_volatile_store16((volatile short *)_Tgt, _Value);

 #elif _MS_32
	_Compiler_barrier();
	__asm
		{
		mov ax, _Value;
		mov edx, _Tgt;
		mov [edx], ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

static void _Store_release_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* store _Value atomically with release memory order */
  #if defined(_M_ARM)
	_Memory_barrier();
	__iso_volatile_store16((volatile short *)_Tgt, _Value);

 #elif _MS_32
	_Compiler_barrier();
	__asm
		{
		mov ax, _Value;
		mov edx, _Tgt;
		mov [edx], ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

static void _Store_seq_cst_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* store _Value atomically with sequentially
			consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov ax, _Value;
		mov edx, _Tgt;
		lock xchg [edx], ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgw %1, %0\n\t"
		: "+m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

void _Atomic_store_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* store _Value atomically */
	switch(_Order)
		{
		case memory_order_relaxed:
			_Store_relaxed_2(_Tgt, _Value);
			break;
		case memory_order_release:
			_Store_release_2(_Tgt, _Value);
			break;
		case memory_order_seq_cst:
			_Store_seq_cst_2(_Tgt, _Value);
			break;
		default:
			_INVALID_MEMORY_ORDER;
			break;
		}
	}

	/* _Atomic_load_2 */
static _Uint2_t _Load_seq_cst_2(volatile _Uint2_t *_Tgt)
	{	/* load from *_Tgt atomically with
			sequentially consistent memory order */
	_Uint2_t _Value;

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ax, [edx];
		mov _Value, ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %1, %0\n\t"
		: "=r" (_Value)
		: "m" (*_Tgt)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint2_t _Atomic_load_2(
	volatile _Uint2_t *_Tgt, memory_order _Order)
	{	/* load from *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Load_seq_cst_2(_Tgt));
	}

	/* _Atomic_exchange_2 */
static _Uint2_t _Exchange_seq_cst_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov ax, _Value;
		mov edx, _Tgt;
		lock xchg [edx], ax;
		mov _Value, ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgw %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint2_t _Atomic_exchange_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* exchange _Value and *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Exchange_seq_cst_2(_Tgt, _Value));
	}

	/* _Atomic_compare_exchange_weak_2, _Atomic_compare_exchange_strong_2 */
static int _Compare_exchange_seq_cst_2(volatile _Uint2_t *_Tgt,
	_Uint2_t *_Exp, _Uint2_t _Value)
	{	/* compare and exchange values atomically with
			sequentially consistent memory order */
	_Uint1_t _Res;

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ecx, _Exp;
		mov bx, _Value;
		mov ax, [ecx];
		lock cmpxchg [edx], bx;
		jz eql;
		mov [ecx], ax;
	eql:
		setz al;
		mov _Res, al;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %2, %%ax\n\t"
		"lock cmpxchgw %3, %1\n\t"
		"jz 0f\n\t"
		"movw %%ax, %2\n"
	"0:\n\t"
		"setzb %0\n\t"
		: "=m" (_Res),
		  "+m" (*_Tgt),
		  "+m" (*_Exp)
		: "r" (_Value)
		: "ax", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Res);
	}

int _Atomic_compare_exchange_weak_2(
	volatile _Uint2_t *_Tgt, _Uint2_t *_Exp, _Uint2_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Compare_exchange_seq_cst_2(_Tgt, _Exp, _Value));
	}

int _Atomic_compare_exchange_strong_2(
	volatile _Uint2_t *_Tgt, _Uint2_t *_Exp, _Uint2_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Compare_exchange_seq_cst_2(_Tgt, _Exp, _Value));
	}

	/* _Atomic_fetch_add_2, _Atomic_fetch_sub_2 */
static _Uint2_t _Fetch_add_seq_cst_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* add _Value to *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ax, _Value;
		lock xadd [edx], ax;
		mov _Value, ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xaddw %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint2_t _Atomic_fetch_add_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* add _Value to *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_add_seq_cst_2(_Tgt, _Value));
	}

_Uint2_t _Atomic_fetch_sub_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* subtract _Value from *_Tgt atomically */
	return (_Atomic_fetch_add_2(_Tgt, 0 - _Value, _Order));
	}

	/* _Atomic_fetch_and_2 */
static _Uint2_t _Fetch_and_seq_cst_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* and _Value with *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ax, [edx];
	again:
		mov bx, ax;
		and bx, _Value;
		lock cmpxchg [edx], bx;
		jnz again;
		mov _Value, ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %0, %%ax\n"
	"0:\n\t"
		"movw %%ax, %%bx\n\t"
		"andw %1, %%bx\n\t"
		"lock cmpxchgw %%bx, %0\n\t"
		"jnz 0b\n\t"
		"movw %%ax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "ax", "bx", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint2_t _Atomic_fetch_and_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* and _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_and_seq_cst_2(_Tgt, _Value));
	}

	/* _Atomic_fetch_or_2 */
static _Uint2_t _Fetch_or_seq_cst_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* or _Value with *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ax, [edx];
	again:
		mov bx, ax;
		or bx, _Value;
		lock cmpxchg [edx], bx;
		jnz again;
		mov _Value, ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %0, %%ax\n"
	"0:\n\t"
		"movw %%ax, %%bx\n\t"
		"orw %1, %%bx\n\t"
		"lock cmpxchgw %%bx, %0\n\t"
		"jnz 0b\n\t"
		"movw %%ax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "ax", "bx", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint2_t _Atomic_fetch_or_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* or _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_or_seq_cst_2(_Tgt, _Value));
	}

	/* _Atomic_fetch_xor_2 */
static _Uint2_t _Fetch_xor_seq_cst_2(volatile _Uint2_t *_Tgt, _Uint2_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			sequentially consistent memory order */

  #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ax, [edx];
	again:
		mov bx, ax;
		xor bx, _Value;
		lock cmpxchg [edx], bx;
		jnz again;
		mov _Value, ax;
		}
	_Compiler_barrier();

  #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movw %0, %%ax\n"
	"0:\n\t"
		"movw %%ax, %%bx\n\t"
		"xorw %1, %%bx\n\t"
		"lock cmpxchgw %%bx, %0\n\t"
		"jnz 0b\n\t"
		"movw %%ax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "ax", "bx", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint2_t _Atomic_fetch_xor_2(
	volatile _Uint2_t *_Tgt, _Uint2_t _Value, memory_order _Order)
	{	/* xor _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_xor_seq_cst_2(_Tgt, _Value));
	}
 #endif /* _MS_64 */

	/* _Atomic_store_4 */
static void _Store_relaxed_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* store _Value atomically with relaxed memory order */
 #if defined(_M_ARM)
	__iso_volatile_store32((volatile int *)_Tgt, _Value);

 #elif _MS_32
	_Compiler_barrier();
	__asm
		{
		mov eax, _Value;
		mov edx, _Tgt;
		mov [edx], eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Compiler_barrier();
	*_Tgt = _Value;
	_Compiler_barrier();

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

static void _Store_release_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* store _Value atomically with release memory order */
 #if defined(_M_ARM)
	_Memory_barrier();
	__iso_volatile_store32((volatile int *)_Tgt, _Value);

 #elif _MS_32
	_Compiler_barrier();
	__asm
		{
		mov eax, _Value;
		mov edx, _Tgt;
		mov [edx], eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Compiler_barrier();
	*_Tgt = _Value;
	_Compiler_barrier();

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

static void _Store_seq_cst_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* store _Value atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov eax, _Value;
		mov edx, _Tgt;
		lock xchg [edx], eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_InterlockedExchange((volatile long *)_Tgt, _Value);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgl %1, %0\n\t"
		: "+m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

void _Atomic_store_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* store _Value atomically */
	switch(_Order)
		{
		case memory_order_relaxed:
			_Store_relaxed_4(_Tgt, _Value);
			break;
		case memory_order_release:
			_Store_release_4(_Tgt, _Value);
			break;
		case memory_order_seq_cst:
			_Store_seq_cst_4(_Tgt, _Value);
			break;
		default:
			_INVALID_MEMORY_ORDER;
			break;
		}
	}

	/* _Atomic_load_4 */
static _Uint4_t _Load_seq_cst_4(volatile _Uint4_t *_Tgt)
	{	/* load from *_Tgt atomically with
			sequentially consistent memory order */
	_Uint4_t _Value;

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov eax, [edx];
		mov _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedOr((volatile long *)_Tgt, 0);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %1, %0\n\t"
		: "=r" (_Value)
		: "m" (*_Tgt)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint4_t _Atomic_load_4(
	volatile _Uint4_t *_Tgt, memory_order _Order)
	{	/* load from *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Load_seq_cst_4(_Tgt));
	}

	/* _Atomic_exchange_4 */
static _Uint4_t _Exchange_seq_cst_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov eax, _Value;
		mov edx, _Tgt;
		lock xchg [edx], eax;
		mov _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedExchange((volatile long *)_Tgt, _Value);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgl %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint4_t _Atomic_exchange_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* exchange _Value and *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Exchange_seq_cst_4(_Tgt, _Value));
	}

	/* _Atomic_compare_exchange_weak_4, _Atomic_compare_exchange_strong_4 */
static int _Compare_exchange_seq_cst_4(volatile _Uint4_t *_Tgt,
	_Uint4_t *_Exp, _Uint4_t _Value)
	{	/* compare and exchange values atomically with
			sequentially consistent memory order */
	_Uint1_t _Res;

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov ecx, _Exp;
		mov ebx, _Value;
		mov eax, [ecx];
		lock cmpxchg [edx], ebx;
		jz eql;
		mov [ecx], eax;
	eql:
		setz al;
		mov _Res, al;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Uint4_t prev = _InterlockedCompareExchange((volatile long *)_Tgt,
		_Value, *_Exp);
	if (prev == *_Exp)
		_Res = 1;
	else
		{	/* copy old value */
		_Res = 0;
		*_Exp = prev;
		}

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %2, %%eax\n\t"
		"lock cmpxchgl %3, %1\n\t"
		"jz 0f\n\t"
		"movl %%eax, %2\n"
	"0:\n\t"
		"setzb %0\n\t"
		: "=m" (_Res),
		  "+m" (*_Tgt),
		  "+m" (*_Exp)
		: "r" (_Value)
		: "eax", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Res);
	}

int _Atomic_compare_exchange_strong_4(
	volatile _Uint4_t *_Tgt, _Uint4_t *_Exp, _Uint4_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Compare_exchange_seq_cst_4(_Tgt, _Exp, _Value));
	}

int _Atomic_compare_exchange_weak_4(
	volatile _Uint4_t *_Tgt, _Uint4_t *_Exp, _Uint4_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* No weak compare-exchange is currently available,
		even for ARM, so fall back to strong */
	return (_Atomic_compare_exchange_strong_4(_Tgt, _Exp, _Value,
		_Order1, _Order2));
	}

	/* _Atomic_fetch_add_4, _Atomic_fetch_sub_4 */
static _Uint4_t _Fetch_add_seq_cst_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* add _Value to *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov eax, _Value;
		lock xadd [edx], eax;
		mov _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedExchangeAdd((volatile long *)_Tgt, _Value);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xaddl %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint4_t _Atomic_fetch_add_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* add _Value to *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_add_seq_cst_4(_Tgt, _Value));
	}

_Uint4_t _Atomic_fetch_sub_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* subtract _Value from *_Tgt atomically */
	return (_Atomic_fetch_add_4(_Tgt, 0 - _Value, _Order));
	}

	/* _Atomic_fetch_and_4 */
static _Uint4_t _Fetch_and_seq_cst_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* and _Value with *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov eax, [edx];
	again:
		mov ebx, eax;
		and ebx, _Value;
		lock cmpxchg [edx], ebx;
		jnz again;
		mov _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedAnd((volatile long *)_Tgt, _Value);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %0, %%eax\n"
	"0:\n\t"
		"movl %%eax, %%ebx\n\t"
		"andl %1, %%ebx\n\t"
		"lock cmpxchgl %%ebx, %0\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "eax", "ebx", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint4_t _Atomic_fetch_and_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* and _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_and_seq_cst_4(_Tgt, _Value));
	}

	/* _Atomic_fetch_or_4 */
static _Uint4_t _Fetch_or_seq_cst_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* or _Value with *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov eax, [edx];
	again:
		mov ebx, eax;
		or ebx, _Value;
		lock cmpxchg [edx], ebx;
		jnz again;
		mov _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedOr((volatile long *)_Tgt, _Value);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %0, %%eax\n"
	"0:\n\t"
		"movl %%eax, %%ebx\n\t"
		"orl %1, %%ebx\n\t"
		"lock cmpxchgl %%ebx, %0\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "eax", "ebx", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint4_t _Atomic_fetch_or_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* or _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_or_seq_cst_4(_Tgt, _Value));
	}

	/* _Atomic_fetch_xor_4 */
static _Uint4_t _Fetch_xor_seq_cst_4(volatile _Uint4_t *_Tgt, _Uint4_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov edx, _Tgt;
		mov eax, [edx];
	again:
		mov ebx, eax;
		xor ebx, _Value;
		lock cmpxchg [edx], ebx;
		jnz again;
		mov _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedXor((volatile long *)_Tgt, _Value);

 #elif _GCC_32 || _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %0, %%eax\n"
	"0:\n\t"
		"movl %%eax, %%ebx\n\t"
		"xorl %1, %%ebx\n\t"
		"lock cmpxchgl %%ebx, %0\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "eax", "ebx", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

_Uint4_t _Atomic_fetch_xor_4(
	volatile _Uint4_t *_Tgt, _Uint4_t _Value, memory_order _Order)
	{	/* xor _Value with *_Tgt atomically */
	/* use sequentially consistent for all memory orders: */
	return (_Fetch_xor_seq_cst_4(_Tgt, _Value));
	}

	/* _Atomic_store_8 */
static void _Store_seq_cst_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* store _Value atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov ecx, dword ptr _Value[4];
		mov ebx, dword ptr _Value;
	again:
		lock cmpxchg8b [esi];
		jnz again;
		}
	_Compiler_barrier();

 #elif _MS_64
	_InterlockedExchange64((volatile _LONGLONG *)_Tgt, _Value);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl 4%1, %%ecx\n\t"
		"movl %1, %%ebx\n"
	"0:\n\t"
		"lock cmpxchg8b %0\n\t"
		"jnz 0b\n\t"
		: "+m" (*_Tgt)
		: "o" (_Value)
		: "eax", "ebx", "ecx", "edx", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */
	}

static void _Store_relaxed_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* store _Value atomically with relaxed memory order */
 #if defined(_M_ARM)
	_InterlockedExchange64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #elif _MS_64
	_Compiler_barrier();
	*_Tgt = _Value;
	_Compiler_barrier();

 #elif _MS_32
	_Store_seq_cst_8(_Tgt, _Value);

  #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		);
	_Compiler_barrier();
 #endif /* _MS_64 */
	}

static void _Store_release_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* store _Value atomically with relaxed memory order */
 #if defined(_M_ARM)
	_Memory_barrier();
	_InterlockedExchange64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #elif _MS_64
	_Compiler_barrier();
	*_Tgt = _Value;
	_Compiler_barrier();

 #elif _MS_32
	_Store_seq_cst_8(_Tgt, _Value);

  #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %1, %0\n\t"
		: "=m" (*_Tgt)
		: "r" (_Value)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_64 */
	}

void _Atomic_store_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* store _Value atomically */
	_Store_seq_cst_8(_Tgt, _Value);
	}

	/* _Atomic_load_8 */
static _Uint8_t _Load_seq_cst_8(volatile _Uint8_t *_Tgt)
	{	/* load from *_Tgt atomically with
			sequentially consistent memory order */
	_Uint8_t _Value;

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov ecx, edx;
		mov ebx, eax;
		lock cmpxchg8b [esi];
		mov dword ptr _Value[4], edx;
		mov dword ptr _Value, eax;
		}
	_Compiler_barrier();

 #elif defined(_M_ARM)
	_Memory_barrier();
	_Value = __ldrexd((volatile _LONGLONG *)_Tgt);
	_Memory_barrier();

 #elif _MS_64
	_Value = _InterlockedOr64((volatile _LONGLONG *)_Tgt, 0);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %%ecx, %%edx\n\t"
		"movl %%ebx, %%eax\n\t"
		"lock cmpxchg8b %0\n\t"
		"movl %%edx, 4%1\n\t"
		"movl %%eax, %1\n\t"
		: "+m" (*_Tgt)
		: "o" (_Value)
		: "eax", "ebx", "ecx", "edx", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %1, %0\n\t"
		: "=r" (_Value)
		: "m" (*_Tgt)
		: "memory"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

static _Uint8_t _Load_relaxed_8(volatile _Uint8_t *_Tgt)
	{	/* load from *_Tgt atomically with
			relaxed memory order */
	_Uint8_t _Value;

 #if defined(_M_ARM)
	_Value = __ldrexd((volatile _LONGLONG *)_Tgt);

 #else
	_Value = _Load_seq_cst_8(_Tgt);
 #endif

	return (_Value);
	}

static _Uint8_t _Load_acquire_8(volatile _Uint8_t *_Tgt)
	{	/* load from *_Tgt atomically with
			acquire memory order */
	_Uint8_t _Value;

 #if defined(_M_ARM)
	_Value = __ldrexd((volatile _LONGLONG *)_Tgt);
	_Memory_barrier();

 #else
	_Value = _Load_seq_cst_8(_Tgt);
 #endif

	return (_Value);
	}

_Uint8_t _Atomic_load_8(
	volatile _Uint8_t *_Tgt, memory_order _Order)
	{	/* load from *_Tgt atomically */
	switch(_Order)
		{
		case memory_order_relaxed:
			return (_Load_relaxed_8(_Tgt));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Load_acquire_8(_Tgt));

		case memory_order_seq_cst:
			return (_Load_seq_cst_8(_Tgt));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

	/* _Atomic_exchange_8 */
static _Uint8_t _Exchange_seq_cst_8(volatile _Uint8_t *_Tgt,
	_Uint8_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov ecx, dword ptr _Value[4];
		mov ebx, dword ptr _Value;
	again:
		lock cmpxchg8b [esi];
		jnz again;
		mov dword ptr _Value[4], edx;
		mov dword ptr _Value, eax;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedExchange64((volatile _LONGLONG *)_Tgt, _Value);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl 4%1, %%ecx\n\t"
		"movl %1, %%ebx\n"
	"0:\n\t"
		"lock cmpxchg8b %0\n\t"
		"jnz 0b\n\t"
		"movl %%edx, 4%1\n\t"
		"movl %%eax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "eax", "ebx", "ecx", "edx", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xchgq %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

static _Uint8_t _Exchange_relaxed_8(volatile _Uint8_t *_Tgt,
	_Uint8_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			relaxed memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedExchange64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Exchange_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Exchange_acquire_8(volatile _Uint8_t *_Tgt,
	_Uint8_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			acquire memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedExchange64_acq((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Exchange_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Exchange_release_8(volatile _Uint8_t *_Tgt,
	_Uint8_t _Value)
	{	/* exchange _Value and *_Tgt atomically with
			release memory order */

 #if defined(_M_ARM)
	_Memory_barrier();
	_Value = _InterlockedExchange64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Exchange_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

_Uint8_t _Atomic_exchange_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* exchange _Value and *_Tgt atomically */
	switch (_Order)
		{
		case memory_order_relaxed:
			return (_Exchange_relaxed_8(_Tgt, _Value));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Exchange_acquire_8(_Tgt, _Value));

		case memory_order_release:
			return (_Exchange_release_8(_Tgt, _Value));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_Exchange_seq_cst_8(_Tgt, _Value));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

	/* _Atomic_compare_exchange_weak_8, _Atomic_compare_exchange_strong_8 */
static int _Compare_exchange_seq_cst_8(volatile _Uint8_t *_Tgt,
	_Uint8_t *_Exp, _Uint8_t _Value)
	{	/* compare and exchange values atomically with
			sequentially consistent memory order */
	_Uint1_t _Res;

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov ecx, dword ptr _Exp;
		mov edx, 4[ecx];
		mov eax, [ecx];
		mov ecx, dword ptr _Value[4];
		mov ebx, dword ptr _Value;
		lock cmpxchg8b [esi];
		jz eql;
		mov ecx, _Exp;
		mov 4[ecx], edx;
		mov [ecx], eax;
	eql:
		setz al;
		mov _Res, al;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Uint8_t prev = _InterlockedCompareExchange64((volatile _LONGLONG *)_Tgt,
		_Value, *_Exp);
	if (prev == *_Exp)
		_Res = 1;
	else
		{	/* copy value */
		_Res = 0;
		*_Exp = prev;
		}

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl %2, %%esi\n\t"
		"movl %3, %%ecx\n\t"
		"movl 4(%%ecx), %%edx\n\t"
		"movl (%%ecx), %%eax\n\t"
		"movl 4%0, %%ecx\n\t"
		"movl %0, %%ebx\n\t"
		"lock cmpxchg8b (%%esi)\n\t"
		"jz 0f\n\t"
		"movl %3, %%ecx\n\t"
		"movl %%edx, 4(%%ecx)\n\t"
		"movl %%eax, (%%ecx)\n"
	"0:\n\t"
		"setzb %%al\n\t"
		"movb %%al, %1\n\t"
		: "+m" (_Value),
		  "=m" (_Res)
		: "m" (_Tgt),
		  "m" (_Exp)
		: "eax", "ebx", "ecx", "edx", "esi", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %2, %%rax\n\t"
		"lock cmpxchgq %3, %1\n\t"
		"jz 0f\n\t"
		"movq %%rax, %2\n"
	"0:\n\t"
		"setzb %0\n\t"
		: "=m" (_Res),
		  "+m" (*_Tgt),
		  "+m" (*_Exp)
		: "r" (_Value)
		: "rax", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Res);
	}

static int _Compare_exchange_relaxed_8(volatile _Uint8_t *_Tgt,
	_Uint8_t *_Exp, _Uint8_t _Value)
	{	/* compare and exchange values atomically with
			relaxed memory order */
	int _Res;

 #if defined(_M_ARM)
	_Uint8_t _Prev =
		_InterlockedCompareExchange64_nf((volatile _LONGLONG *)_Tgt,
			_Value, *_Exp);
	if (_Prev == *_Exp)
		_Res = 1;
	else
		{	/* copy value */
		_Res = 0;
		*_Exp = _Prev;
		}

 #else
	_Res = _Compare_exchange_seq_cst_8(_Tgt, _Exp, _Value);
 #endif

	return (_Res);
	}

static int _Compare_exchange_acquire_8(volatile _Uint8_t *_Tgt,
	_Uint8_t *_Exp, _Uint8_t _Value)
	{	/* compare and exchange values atomically with
			acquire memory order */
	int _Res;

 #if defined(_M_ARM)
	_Uint8_t _Prev =
		_InterlockedCompareExchange64_acq((volatile _LONGLONG *)_Tgt,
			_Value, *_Exp);
	if (_Prev == *_Exp)
		_Res = 1;
	else
		{	/* copy value */
		_Res = 0;
		*_Exp = _Prev;
		}

 #else
	_Res = _Compare_exchange_seq_cst_8(_Tgt, _Exp, _Value);
 #endif

	return (_Res);
	}

static int _Compare_exchange_release_8(volatile _Uint8_t *_Tgt,
	_Uint8_t *_Exp, _Uint8_t _Value)
	{	/* compare and exchange values atomically with
			release memory order */
	int _Res;

 #if defined(_M_ARM)
	_Uint8_t _Prev =
		_InterlockedCompareExchange64_rel((volatile _LONGLONG *)_Tgt,
			_Value, *_Exp);
	if (_Prev == *_Exp)
		_Res = 1;
	else
		{	/* copy value */
		_Res = 0;
		*_Exp = _Prev;
		}

 #else
	_Res = _Compare_exchange_seq_cst_8(_Tgt, _Exp, _Value);
 #endif

	return (_Res);
	}

int _Atomic_compare_exchange_strong_8(
	volatile _Uint8_t *_Tgt, _Uint8_t *_Exp, _Uint8_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	_Validate_compare_exchange_memory_order(_Order1, _Order2);

	switch (_Memory_order_upper_bound(_Order1, _Order2))
		{
		case memory_order_relaxed:
			return (_Compare_exchange_relaxed_8(_Tgt, _Exp, _Value));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Compare_exchange_acquire_8(_Tgt, _Exp, _Value));

		case memory_order_release:
			return (_Compare_exchange_release_8(_Tgt, _Exp, _Value));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_Compare_exchange_seq_cst_8(_Tgt, _Exp, _Value));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

int _Atomic_compare_exchange_weak_8(
	volatile _Uint8_t *_Tgt, _Uint8_t *_Exp, _Uint8_t _Value,
	memory_order _Order1, memory_order _Order2)
	{	/* compare and exchange values atomically */
	/* No weak compare-exchange is currently available,
		even for ARM, so fall back to strong */
	return (_Atomic_compare_exchange_strong_8(_Tgt, _Exp, _Value,
		_Order1, _Order2));
	}

	/* _Atomic_fetch_add_8 */
static _Uint8_t _Fetch_add_seq_cst_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* add _Value to *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov edx, 4[esi];
		mov eax, [esi];
	again:
		mov ecx, edx;
		mov ebx, eax;
		add ebx, dword ptr _Value;
		adc ecx, dword ptr _Value[4];
		lock cmpxchg8b [esi];
		jnz again;
		mov dword ptr _Value, eax;
		mov dword ptr _Value[4], edx;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedExchangeAdd64((volatile _LONGLONG *)_Tgt, _Value);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl 4(%1), %%edx\n\t"
		"movl (%1), %%eax\n"
	"0:\n\t"
		"movl %%edx, %%ecx\n\t"
		"movl %%eax, %%ebx\n\t"
		"addl %0, %%ebx\n\t"
		"adcl 4%0, %%ecx\n\t"
		"lock cmpxchg8b (%1)\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %0\n\t"
		"movl %%edx, 4%0\n\t"
		: "+m" (_Value)
		: "r" (_Tgt)
		: "eax", "ebx", "ecx", "edx", "esi", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"lock xaddq %1, %0\n\t"
		: "+m" (*_Tgt),
		  "+r" (_Value)
		:
		: "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

static _Uint8_t _Fetch_add_relaxed_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* add _Value to *_Tgt atomically with
			relaxed memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedExchangeAdd64_nf((volatile _LONGLONG *)_Tgt,
		_Value);

 #else
	_Value = _Fetch_add_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_add_acquire_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* add _Value to *_Tgt atomically with
			acquire memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedExchangeAdd64_acq((volatile _LONGLONG *)_Tgt,
		_Value);

 #else
	_Value = _Fetch_add_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_add_release_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* add _Value to *_Tgt atomically with
			release memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedExchangeAdd64_rel((volatile _LONGLONG *)_Tgt,
		_Value);

 #else
	_Value = _Fetch_add_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

_Uint8_t _Atomic_fetch_add_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* add _Value to *_Tgt atomically */
	switch (_Order)
		{
		case memory_order_relaxed:
			return (_Fetch_add_relaxed_8(_Tgt, _Value));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Fetch_add_acquire_8(_Tgt, _Value));

		case memory_order_release:
			return (_Fetch_add_release_8(_Tgt, _Value));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_Fetch_add_seq_cst_8(_Tgt, _Value));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

	/* _Atomic_fetch_sub_8 */
_Uint8_t _Atomic_fetch_sub_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* subtract _Value from *_Tgt atomically */
	return (_Atomic_fetch_add_8(_Tgt, 0 - _Value, _Order));
	}

	/* _Atomic_fetch_and_8 */
static _Uint8_t _Fetch_and_seq_cst_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* and _Value with *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov eax, [esi];
		mov edx, 4[esi];
	again:
		mov ecx, edx;
		mov ebx, eax;
		and ebx, dword ptr _Value;
		and ecx, dword ptr _Value[4];
		lock cmpxchg8b [esi];
		jnz again;
		mov dword ptr _Value, eax;
		mov dword ptr _Value[4], edx;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedAnd64((volatile _LONGLONG *)_Tgt, _Value);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl 4(%1), %%edx\n\t"
		"movl (%1), %%eax\n"
	"0:\n\t"
		"movl %%edx, %%ecx\n\t"
		"movl %%eax, %%ebx\n\t"
		"andl %0, %%ebx\n\t"
		"andl 4%0, %%ecx\n\t"
		"lock cmpxchg8b (%1)\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %0\n\t"
		"movl %%edx, 4%0\n\t"
		: "+m" (_Value)
		: "r" (_Tgt)
		: "eax", "ebx", "ecx", "edx", "esi", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %0, %%rax\n"
	"0:\n\t"
		"movq %%rax, %%rbx\n\t"
		"andq %1, %%rbx\n\t"
		"lock cmpxchgq %%rbx, %0\n\t"
		"jnz 0b\n\t"
		"movq %%rax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "al", "bl", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

static _Uint8_t _Fetch_and_relaxed_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* and _Value with *_Tgt atomically with
			relaxed memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedAnd64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_and_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_and_acquire_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* and _Value with *_Tgt atomically with
			acquire memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedAnd64_acq((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_and_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_and_release_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* and _Value with *_Tgt atomically with
			release memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedAnd64_rel((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_and_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

_Uint8_t _Atomic_fetch_and_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* and _Value with *_Tgt atomically */
	switch (_Order)
		{
		case memory_order_relaxed:
			return (_Fetch_and_relaxed_8(_Tgt, _Value));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Fetch_and_acquire_8(_Tgt, _Value));

		case memory_order_release:
			return (_Fetch_and_release_8(_Tgt, _Value));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_Fetch_and_seq_cst_8(_Tgt, _Value));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

	/* _Atomic_fetch_or_8 */
static _Uint8_t _Fetch_or_seq_cst_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* or _Value with *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov eax, [esi];
		mov edx, 4[esi];
	again:
		mov ecx, edx;
		mov ebx, eax;
		or ebx, dword ptr _Value;
		or ecx, dword ptr _Value[4];
		lock cmpxchg8b [esi];
		jnz again;
		mov dword ptr _Value, eax;
		mov dword ptr _Value[4], edx;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedOr64((volatile _LONGLONG *)_Tgt, _Value);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl 4(%1), %%edx\n\t"
		"movl (%1), %%eax\n"
	"0:\n\t"
		"movl %%edx, %%ecx\n\t"
		"movl %%eax, %%ebx\n\t"
		"orl %0, %%ebx\n\t"
		"orl 4%0, %%ecx\n\t"
		"lock cmpxchg8b (%1)\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %0\n\t"
		"movl %%edx, 4%0\n\t"
		: "+m" (_Value)
		: "r" (_Tgt)
		: "eax", "ebx", "ecx", "edx", "esi", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %0, %%rax\n"
	"0:\n\t"
		"movq %%rax, %%rbx\n\t"
		"orq %1, %%rbx\n\t"
		"lock cmpxchgq %%rbx, %0\n\t"
		"jnz 0b\n\t"
		"movq %%rax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "al", "bl", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

static _Uint8_t _Fetch_or_relaxed_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* or _Value with *_Tgt atomically with
			relaxed memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedOr64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_or_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_or_acquire_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* or _Value with *_Tgt atomically with
			acquire memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedOr64_acq((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_or_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_or_release_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* or _Value with *_Tgt atomically with
			release memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedOr64_rel((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_or_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

_Uint8_t _Atomic_fetch_or_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* or _Value with *_Tgt atomically */
	switch (_Order)
		{
		case memory_order_relaxed:
			return (_Fetch_or_relaxed_8(_Tgt, _Value));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Fetch_or_acquire_8(_Tgt, _Value));

		case memory_order_release:
			return (_Fetch_or_release_8(_Tgt, _Value));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_Fetch_or_seq_cst_8(_Tgt, _Value));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

	/* _Atomic_fetch_xor_8 */
static _Uint8_t _Fetch_xor_seq_cst_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			sequentially consistent memory order */

 #if _MS_32
	_Compiler_barrier();
	__asm
		{
		mov esi, _Tgt;
		mov eax, [esi];
		mov edx, 4[esi];
	again:
		mov ecx, edx;
		mov ebx, eax;
		xor ebx, dword ptr _Value;
		xor ecx, dword ptr _Value[4];
		lock cmpxchg8b [esi];
		jnz again;
		mov dword ptr _Value, eax;
		mov dword ptr _Value[4], edx;
		}
	_Compiler_barrier();

 #elif _MS_64
	_Value = _InterlockedXor64((volatile _LONGLONG *)_Tgt, _Value);

 #elif _GCC_32
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movl 4(%1), %%edx\n\t"
		"movl (%1), %%eax\n"
	"0:\n\t"
		"movl %%edx, %%ecx\n\t"
		"movl %%eax, %%ebx\n\t"
		"xorl %0, %%ebx\n\t"
		"xorl 4%0, %%ecx\n\t"
		"lock cmpxchg8b (%1)\n\t"
		"jnz 0b\n\t"
		"movl %%eax, %0\n\t"
		"movl %%edx, 4%0\n\t"
		: "+m" (_Value)
		: "r" (_Tgt)
		: "eax", "ebx", "ecx", "edx", "esi", "memory", "cc"
		);
	_Compiler_barrier();

 #elif _GCC_64
	_Compiler_barrier();
	__asm__ __volatile__
		(
		"movq %0, %%rax\n"
	"0:\n\t"
		"movq %%rax, %%rbx\n\t"
		"xorq %1, %%rbx\n\t"
		"lock cmpxchgq %%rbx, %0\n\t"
		"jnz 0b\n\t"
		"movq %%rax, %1\n\t"
		: "+m" (*_Tgt),
		  "+m" (_Value)
		:
		: "al", "bl", "memory", "cc"
		);
	_Compiler_barrier();
 #endif /* _MS_32 */

	return (_Value);
	}

static _Uint8_t _Fetch_xor_relaxed_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			relaxed memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedXor64_nf((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_xor_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_xor_acquire_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			acquire memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedXor64_acq((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_xor_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

static _Uint8_t _Fetch_xor_release_8(volatile _Uint8_t *_Tgt, _Uint8_t _Value)
	{	/* xor _Value with *_Tgt atomically with
			release memory order */

 #if defined(_M_ARM)
	_Value = _InterlockedXor64_rel((volatile _LONGLONG *)_Tgt, _Value);

 #else
	_Value = _Fetch_xor_seq_cst_8(_Tgt, _Value);
 #endif

	return (_Value);
	}

_Uint8_t _Atomic_fetch_xor_8(
	volatile _Uint8_t *_Tgt, _Uint8_t _Value, memory_order _Order)
	{	/* xor _Value with *_Tgt atomically */
	switch (_Order)
		{
		case memory_order_relaxed:
			return (_Fetch_xor_relaxed_8(_Tgt, _Value));

		case memory_order_consume:
		case memory_order_acquire:
			return (_Fetch_xor_acquire_8(_Tgt, _Value));

		case memory_order_release:
			return (_Fetch_xor_release_8(_Tgt, _Value));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_Fetch_xor_seq_cst_8(_Tgt, _Value));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}
	}

int _Atomic_flag_test_and_set(volatile _Atomic_flag_t *_Flag,
	memory_order _Order)
	{	/* atomically test flag and set to true */
  #ifdef _M_ARM
	switch (_Order)
		{
		case memory_order_relaxed:
			return (_InterlockedExchange_nf(_Flag, 1));

		case memory_order_consume:
		case memory_order_acquire:
			return (_InterlockedExchange_acq(_Flag, 1));

		case memory_order_release:
			_Memory_barrier();
			return (_InterlockedExchange_nf(_Flag, 1));

		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_InterlockedExchange(_Flag, 1));

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}

 #elif _MS_64
	switch (_Order)
		{
		case memory_order_relaxed:
		case memory_order_consume:
		case memory_order_acquire:
		case memory_order_release:
		case memory_order_acq_rel:
		case memory_order_seq_cst:
			return (_interlockedbittestandset(_Flag, 0));	/* set bit 0 */

		default:
			_INVALID_MEMORY_ORDER;
			return (0);
		}

 #elif _GCC_64 || _GCC_32 || _MS_32
		return (_Atomic_exchange_1(_Flag, 1, _Order));
 #endif /* _MS_32 */
	}

void _Atomic_flag_clear(volatile _Atomic_flag_t *_Flag,
	memory_order _Order)
	{	/* atomically clear flag */
  #ifdef _M_ARM
	if (_Order == memory_order_consume)
		{
		/* Strangely, the standard permits memory_order_consume here */
		_Order = memory_order_relaxed;
		}

	static_assert(sizeof(_Atomic_flag_t) == sizeof(_Uint4_t),
		"Unexpected _Atomic_flag_t size");
	_Atomic_store_4((volatile _Uint4_t *)_Flag, 0, _Order);

 #elif _MS_64
	switch (_Order)
		{
		case memory_order_consume:	/* see _M_ARM above */
		case memory_order_relaxed:
		case memory_order_release:
		case memory_order_seq_cst:
			_interlockedbittestandreset(_Flag, 0);	/* reset bit 0 */
			break;

		default:
			_INVALID_MEMORY_ORDER;
			break;
		}

 #elif _GCC_64 || _GCC_32 || _MS_32
	_Atomic_store_1(_Flag, 0, _Order);
 #endif /* _MS_32 */
	}

void _Atomic_thread_fence(memory_order _Order)
	{	/* force memory visibility and inhibit compiler reordering */
 #if defined(_M_ARM)
	if (_Order != memory_order_relaxed)
		{
		_Memory_barrier();
		}

 #else
	_Compiler_barrier();
	if (_Order == memory_order_seq_cst)
		{	/* force visibility */
		static _Uint4_t _Guard;
		_Atomic_exchange_4(&_Guard, 0, memory_order_seq_cst);
		_Compiler_barrier();
		}
 #endif
	}

void _Atomic_signal_fence(memory_order _Order)
	{	/* inhibit compiler reordering */
	_Compiler_barrier();
	}
_END_EXTERN_C
_STD_END
 #endif /* _MULTI_THREAD */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
