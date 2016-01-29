#pragma once

#ifndef _IMPL_ALGORITHM_IMPL_H_
#define _IMPL_ALGORITHM_IMPL_H_ 1

#pragma warning(push)
#pragma warning(disable: 4503) // decorated name length exceeded, name was truncated

#include <vector>
#include <string>
#include <iterator>
#include <type_traits>
#include <deque>
#include <memory>
#include <thread>
#include <atomic>

#include "defines.h"
#include <experimental/execution_policy>
#include <experimental/exception>

#include "algorithm_scheduler.h"
#include "event.h"

_PSTL_NS1_BEGIN
namespace details {

#pragma warning(push)
	// object allocated on the heap may not be aligned 64
#pragma warning(disable: 4316)

	/// <summary>
	///     The <c>combinable&lt;T&gt;</c> object is intended to provide thread-private copies of data, to perform lock-free
	///     thread-local sub-computations during parallel algorithms. At the end of the parallel operation, the
	///     thread-private sub-computations can then be merged into a final result. This class can be used instead of
	///     a shared variable, and can result in a performance improvement if there would otherwise be a lot of
	///     contention on that shared variable.
	/// </summary>
	/// <typeparam name="_Ty">
	///     The data type of the final merged result. The type must have a move constructor and/or default constructor.
	/// </typeparam>
	/// <remarks>
	///     For more information, see <see cref="Parallel Containers and Objects"/>.
	/// </remarks>
	template<typename _Ty>
	class combinable
	{
	private:

		// Disable warning C4324: structure was padded due to __declspec(align())
		// This padding is expected and necessary.
#pragma warning(push)
#pragma warning(disable: 4324)
		__declspec(align(64))
		struct _Node
		{
			size_t _Key;
			_Ty _Value;
			_Node* _Chain;

			_Node(size_t _K, _Ty _FwdItialValue)
				: _Key(_K), _Value(_FwdItialValue), _Chain(nullptr)
			{
			}
		};
#pragma warning(pop)

		static _Ty _Default_init()
		{
			return _Ty();
		}

	public:
		/// <summary>
		///     Constructs a new <c>combinable</c> object.
		/// </summary>
		/// <remarks>
		///     <para>The first constructor initializes new elements with the default constructor for the type <paramref name="_Ty"/>.</para>
		///     <para>The second constructor initializes new elements using the initialization functor supplied as the
		///           <paramref name="_Fn_initialize"/> parameter.</para>
		///     <para>The third constructor is the copy constructor.</para>
		/// </remarks>
		/// <seealso cref="Parallel Containers and Objects"/>
		combinable()
			: _Fn_initialize(_Default_init)
		{
			_FwdItNew();
		}

		/// <summary>
		///     Constructs a new <c>combinable</c> object.
		/// </summary>
		/// <typeparam name="_Function">
		///     The type of the initialization functor object.
		/// </typeparam>
		/// <param name="_Initialize">
		///     A function which will be called to initialize each new thread-private value of the type <paramref name="_Ty"/>.
		///     It must support a function call operator with the signature <c>_Ty ()</c>.
		/// </param>
		/// <remarks>
		///     <para>The first constructor initializes new elements with the default constructor for the type <paramref name="_Ty"/>.</para>
		///     <para>The second constructor initializes new elements using the initialization functor supplied as the
		///           <paramref name="_Initialize"/> parameter.</para>
		///     <para>The third constructor is the copy constructor.</para>
		/// </remarks>
		/// <seealso cref="Parallel Containers and Objects"/>
		template <typename _Function>
		explicit combinable(_Function _Initialize)
			: _Fn_initialize(_Initialize)
		{
			_FwdItNew();
		}

		/// <summary>
		///     Constructs a new <c>combinable</c> object.
		/// </summary>
		/// <param name="_Copy">
		///     An existing <c>combinable</c> object to be copied into this one.
		/// </param>
		/// <remarks>
		///     <para>The first constructor initializes new elements with the default constructor for the type <paramref name="_Ty"/>.</para>
		///     <para>The second constructor initializes new elements using the initialization functor supplied as the
		///           <paramref name="_Fn_initialize"/> parameter.</para>
		///     <para>The third constructor is the copy constructor.</para>
		/// </remarks>
		/// <seealso cref="Parallel Containers and Objects"/>
		combinable(const combinable& _Copy)
			: _Size(_Copy._Size), _Fn_initialize(_Copy._Fn_initialize)
		{
			_FwdItCopy(_Copy);
		}

		/// <summary>
		///     Assigns to a <c>combinable</c> object from another <c>combinable</c> object.
		/// </summary>
		/// <param name="_Copy">
		///     An existing <c>combinable</c> object to be copied into this one.
		/// </param>
		/// <returns>
		///     A reference to this <c>combinable</c> object.
		/// </returns>
		combinable& operator=(const combinable& _Copy)
		{
			clear();
			delete [] _Buckets;
			_Fn_initialize = _Copy._Fn_initialize;
			_Size = _Copy._M_size;
			_FwdItCopy(_Copy);

			return *this;
		}

		/// <summary>
		///     Destroys a <c>combinable</c> object.
		/// </summary>
		~combinable()
		{
			clear();
			delete [] _Buckets;
		}

		/// <summary>
		///     Returns a reference to the thread-private sub-computation.
		/// </summary>
		/// <returns>
		///     A reference to the thread-private sub-computation.
		/// </returns>
		/// <seealso cref="Parallel Containers and Objects"/>
		_Ty& local()
		{
			bool _Exists;
			return local(_Exists);
		}

		/// <summary>
		///     Returns a reference to the thread-private sub-computation.
		/// </summary>
		/// <param name="_Exists">
		///     A reference to a boolean. The boolean value referenced by this argument will be
		///     set to <c>true</c> if the sub-computation already existed on this thread, and set to
		///     <c>false</c> if this was the first sub-computation on this thread.
		/// </param>
		/// <returns>
		///     A reference to the thread-private sub-computation.
		/// </returns>
		/// <seealso cref="Parallel Containers and Objects"/>
		_Ty& local(bool& _Exists)
		{
			auto _Key = get_current_thread_id();
			size_t _Index;
			_Node* _ExistingNode = _FindLocalItem(_Key, &_Index);
			if (_ExistingNode == nullptr)
			{
				_Exists = false;
				_ExistingNode = _AddLocalItem(_Key, _Index);
			}
			else
			{
				_Exists = true;
			}

			_ASSERTE(_ExistingNode != nullptr);
			return _ExistingNode->_Value;
		}

		/// <summary>
		///     Clears any intermediate computational results from a previous usage.
		/// </summary>
		void clear()
		{
			for (size_t _Index = 0; _Index < _Size; ++_Index)
			{
				_Node* _CurrentNode = _Buckets[_Index];
				while (_CurrentNode != nullptr)
				{
					_Node* _NextNode = _CurrentNode->_Chain;
					delete _CurrentNode;
					_CurrentNode = _NextNode;
				}
			}
			memset((void*) _Buckets, 0, _Size * sizeof _Buckets[0]);
		}

		/// <summary>
		///     Computes a final value from the set of thread-local sub-computations by calling the supplied combine functor.
		/// </summary>
		/// <typeparam name="_Function">
		///     The type of the function object that will be invoked to combine two thread-local sub-computations.
		/// </typeparam>
		/// <param name="_Fn_combine">
		///     The functor that is used to combine the sub-computations. Its signature is <c>T (T, T)</c> or
		///     <c>T (const T&amp;, const T&amp;)</c>, and it must be associative and commutative.
		/// </param>
		/// <returns>
		///     The final result of combining all the thread-private sub-computations.
		/// </returns>
		/// <seealso cref="Parallel Containers and Objects"/>
		template<typename _Function>
		_Ty combine(_Function _Fn_combine) const
		{
			_Node* _CurrentNode = nullptr;
			size_t _Index;

			// Look for the first value in the set, and use (a copy of) that as the result.
			// This eliminates a single call (of unknown cost) to _Fn_initialize.
			for (_Index = 0; _Index < _Size; ++_Index)
			{
				_CurrentNode = _Buckets[_Index];
				if (_CurrentNode != nullptr)
				{
					break;
				}
			}

			// No values... return the initializer value.
			if (_CurrentNode == nullptr)
			{
				return _Fn_initialize();
			}

			// Accumulate the rest of the items in the current bucket.
			_Ty _Result = _CurrentNode->_Value;
			for (_CurrentNode = _CurrentNode->_Chain; _CurrentNode != nullptr; _CurrentNode = _CurrentNode->_Chain)
			{
				_Result = _Fn_combine(_Result, _CurrentNode->_Value);
			}

			// Accumulate values from the rest of the buckets.
			_ASSERTE(_Index < _Size);
			for (++_Index; _Index < _Size; ++_Index)
			{
				for (_CurrentNode = _Buckets[_Index]; _CurrentNode != nullptr; _CurrentNode = _CurrentNode->_Chain)
				{
					_Result = _Fn_combine(_Result, _CurrentNode->_Value);
				}
			}

			return _Result;
		}

		/// <summary>
		///     Computes a final value from the set of thread-local sub-computations by calling the supplied combine functor
		///     once per thread-local sub-computation. The final result is accumulated by the function object.
		/// </summary>
		/// <typeparam name="_Function">
		///     The type of the function object that will be invoked to combine a single thread-local sub-computation.
		/// </typeparam>
		/// <param name="_FnCombine">
		///     The functor that is used to combine one sub-computation. Its signature is <c>void (T)</c> or
		///     <c>void (const T&amp;)</c>, and must be associative and commutative.
		/// </param>
		/// <seealso cref="Parallel Containers and Objects"/>
		template<typename _Function>
		void combine_each(_Function _Fn_combine) const
		{
			for (size_t _Index = 0; _Index < _Size; ++_Index)
			{
				for (_Node* _CurrentNode = _Buckets[_Index]; _CurrentNode != nullptr; _CurrentNode = _CurrentNode->_Chain)
				{
					_Fn_combine(_CurrentNode->_Value);
				}
			}
		}

		size_t size() const _NOEXCEPT
		{
			return _Size;
		}
	private:
		size_t _GetCombinableSize() const _NOEXCEPT
		{
			// Candidate primes... these must be sorted.  Note that this isn't a complete list of primes, and is
			// capped at reasonable level (e.g., a size of 281 means you expect to have about that many threads).
			static const unsigned long _Candidate_primes [] = {
				11, 19, 37, 67, 73, 151, 281
			};
			const int _Num_candidate_primes = sizeof _Candidate_primes / sizeof _Candidate_primes[0];

			size_t _CombinableSize = get_hardware_concurrency();

			// ConcRT gave us the number of vprocs.
			_CombinableSize *= 2;
			int _Index;
			for (_Index = 0; _Index < _Num_candidate_primes; ++_Index)
			{
				if (_CombinableSize < _Candidate_primes[_Index])
					break;
			}

			if (_Index < _Num_candidate_primes)
				_CombinableSize = _Candidate_primes[_Index];
			else
				_CombinableSize = _Candidate_primes[_Num_candidate_primes - 1];

			return _CombinableSize;
		}

		void _FwdItNew()
		{
			_Size = _GetCombinableSize();
			_Buckets = new _Node*[_Size];
			memset((void*) _Buckets, 0, _Size * sizeof _Buckets[0]);
		}

		void _FwdItCopy(const combinable& _Copy)
		{
			_Buckets = new _Node*[_Size];
			for (size_t _Index = 0; _Index < _Size; ++_Index)
			{
				_Buckets[_Index] = nullptr;
				for (_Node* _CurrentNode = _Copy._Buckets[_Index]; _CurrentNode != nullptr; _CurrentNode = _CurrentNode->_Chain)
				{
					_Node* _NewNode = new _Node(_CurrentNode->_Key, _CurrentNode->_Value);
					_NewNode->_Chain = _Buckets[_Index];
					_Buckets[_Index] = _NewNode;
				}
			}
		}

		_Node* _FindLocalItem(size_t _Key, size_t* _PIndex)
		{
			_ASSERTE(_PIndex != nullptr);

			*_PIndex = _Key % _Size;

			// Search at this index for an existing value.
			_Node* _CurrentNode = _Buckets[*_PIndex];
			while (_CurrentNode != nullptr)
			{
				if (_CurrentNode->_Key == _Key)
				{
					return _CurrentNode;
				}

				_CurrentNode = _CurrentNode->_Chain;
			}

			return nullptr;
		}

		_Node* _AddLocalItem(size_t _Key, size_t _Index)
		{
			_Node* _NewNode = new _Node(_Key, _Fn_initialize());
			_Node* _TopNode;
			do
			{
				_TopNode = _Buckets[_Index];
				_NewNode->_Chain = _TopNode;
			} while (_InterlockedCompareExchangePointer(reinterpret_cast<void * volatile *>(&_Buckets[_Index]), _NewNode, _TopNode) != _TopNode);

			return _NewNode;
		}

	private:
		_Node *volatile * _Buckets;
		size_t _Size;
		std::function<_Ty()> _Fn_initialize;
	};

#pragma warning(pop) // C4316

	// Helper that picks the lowest common iterator type from given iterator tags
	template<class _IterTag0, class _IterTag1>
	struct common_iterator_helper
	{
		typedef std::input_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::random_access_iterator_tag, std::random_access_iterator_tag>
	{
		typedef std::random_access_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::random_access_iterator_tag, std::bidirectional_iterator_tag>
	{
		typedef std::bidirectional_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::bidirectional_iterator_tag, std::random_access_iterator_tag>
	{
		typedef std::bidirectional_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::forward_iterator_tag, std::random_access_iterator_tag>
	{
		typedef std::forward_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::random_access_iterator_tag, std::forward_iterator_tag>
	{
		typedef std::forward_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::bidirectional_iterator_tag, std::forward_iterator_tag>
	{
		typedef std::forward_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::forward_iterator_tag, std::bidirectional_iterator_tag>
	{
		typedef std::forward_iterator_tag iterator_category;
	};

	template<>
	struct common_iterator_helper<std::forward_iterator_tag, std::forward_iterator_tag>
	{
		typedef std::forward_iterator_tag iterator_category;
	};

	// provides that lowest common iterator category for iterators
	template<typename _Iter0, typename _Iter1, typename ... _IterN>
	struct common_iterator
	{
		typedef typename common_iterator_helper<
			typename std::iterator_traits<_Iter0>::iterator_category,
			typename common_iterator<_Iter1, _IterN...>::iterator_category
		>::iterator_category iterator_category;
	};

	template<typename _Iter0, typename _Iter1>
	struct common_iterator<_Iter0, _Iter1>
	{
		typedef typename common_iterator_helper<
			typename std::iterator_traits<_Iter0>::iterator_category,
			typename std::iterator_traits<_Iter1>::iterator_category
		>::iterator_category iterator_category;
	};

	template<typename _It0, typename ... _It>
	struct extract_iterator
	{
		typedef _It0 iterator;
	};

	// composable_iterator support only random access iterator at the time
	template<class _IterCat, typename ... _It>
	class composable_iterator_base :
		public std::iterator<
		_IterCat,
		std::tuple<_It...>,
		typename iterator_traits<typename extract_iterator<_It...>::iterator>::difference_type>
	{
	private:
		template<typename _Tuple, size_t _Count>
		struct iterate
		{
			static void increment(_Tuple& _T)
			{
				auto &_It = std::get<_Count>(_T);
				++_It;
				iterate<_Tuple, _Count - 1>::increment(_T);
			}

			static void decrement(_Tuple& _T)
			{
				auto &_It = std::get<_Count>(_T);
				--_It;

				iterate<_Tuple, _Count - 1>::decrement(_T);
			}

			static void offset(_Tuple& _T, difference_type _Off)
			{
				auto &_It = std::get<_Count>(_T);
				_It += _Off;

				iterate<_Tuple, _Count - 1>::offset(_T, _Off);
			}
		};

		template<typename _Tuple>
		struct iterate<_Tuple, -1>
		{
			static void increment(_Tuple&)
			{
			}

			static void decrement(_Tuple&)
			{
			}

			static void offset(_Tuple&, difference_type)
			{
			}
		};
	public:
		typedef composable_iterator_base<_IterCat, _It... > _Myiter;

		composable_iterator_base(const _It&... _Args) : _Myval(std::make_tuple(_Args...))
		{
		}

		composable_iterator_base() {}

		reference operator*()
		{	// return designated object
			return _Myval;
		}

		pointer operator->() const
		{
			static_assert(!std::is_same<_IterCat, std::output_iterator_tag>::value, "Not supported for output iterator.");
			// return pointer to class object
			return (_STD pointer_traits<pointer>::pointer_to(**this));
		}

		_Myiter& operator++()
		{
			iterate<value_type, std::tuple_size<value_type>::value - 1>::increment(_Myval);
			return (*this);
		}

		_Myiter operator++(int)
		{	// postincrement
			_Myiter _Tmp = *this;
			++*this;
			return (_Tmp);
		}

		_Myiter& operator--()
		{	// predecrement
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value ||
				std::is_same<_IterCat, std::bidirectional_iterator_tag>::value, "Supported for random access iterator only.");

			iterate<value_type, std::tuple_size<value_type>::value - 1>::decrement(_Myval);
			return (*this);
		}

		_Myiter operator--(int)
		{	// postdecrement
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value ||
				std::is_same<_IterCat, std::bidirectional_iterator_tag>::value, "Supported for random access iterator only.");

			_Myiter _Tmp = *this;
			--*this;
			return (_Tmp);
		}

		_Myiter& operator+=(difference_type _Off)
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// increment by integer
			iterate<value_type, std::tuple_size<value_type>::value - 1>::offset(_Myval, _Off);
			return (*this);
		}

		_Myiter operator+(difference_type _Off) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// return this + integer
			_Myiter _Tmp = *this;
			return (_Tmp += _Off);
		}

		_Myiter& operator-=(difference_type _Off)
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// decrement by integer
			return (*this += -_Off);
		}

		_Myiter operator-(difference_type _Off) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// return this - integer
			_Myiter _Tmp = *this;
			return (_Tmp -= _Off);
		}

		difference_type operator-(const _Myiter& _Right) const
		{	// return difference of iterators
			return (std::get<0>(_Myval) - std::get<0>(_Right._Myval));
		}

		value_type operator[](difference_type _Off) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");

			value_type _It = _Myval;
			iterate<value_type, std::tuple_size<value_type>::value - 1>::offset(_It, _Off);
			return _It;
		}

		bool operator==(const _Myiter& _Right) const
		{	// test for iterator equality
			return (std::get<0>(_Myval) == std::get<0>(_Right._Myval));
		}

		bool operator!=(const _Myiter& _Right) const
		{	// test for iterator inequality
			return (!(*this == _Right));
		}

		bool operator<(const _Myiter& _Right) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// test if this < _Right
			return (std::get<0>(_Myval) < std::get<0>(_Right._Myval));
		}

		bool operator>(const _Myiter& _Right) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// test if this > _Right
			return (_Right < *this);
		}

		bool operator<=(const _Myiter& _Right) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// test if this <= _Right
			return (!(_Right < *this));
		}

		bool operator>=(const _Myiter& _Right) const
		{
			static_assert(std::is_same<_IterCat, std::random_access_iterator_tag>::value, "Supported for random access iterator only.");
			// test if this >= _Right
			return (!(*this < _Right));
		}
	private:
		value_type _Myval;
	};
	template<typename ... _It>
	class composable_iterator :
		public composable_iterator_base<typename common_iterator<_It...>::iterator_category, _It...>
	{
	public:
		composable_iterator(const _It&... _Val) :
			composable_iterator_base(_Val...) {}

		composable_iterator() : composable_iterator_base() {}
	};

	template<typename _It>
	class composable_iterator<_It> :
		public composable_iterator_base<typename std::iterator_traits<_It>::iterator_category, _It>
	{
	public:
		composable_iterator(const _It& _Val) :
			composable_iterator_base(_Val) {}

		composable_iterator() : composable_iterator_base() {}
	};

	template<typename ... _It>
	composable_iterator<_It...> make_composable_iterator(const _It&... _Val)
	{
		return composable_iterator<_It...>(_Val...);
	}


	class _Partition_status_tracker
	{
		size_t _PartitionNum;
	public:
		_Partition_status_tracker() : _PartitionNum(0) {}

		_EXP_IMPL bool _IsPartitionNumUnderLimit();

		_EXP_IMPL void _AddPartitions(size_t);

		_EXP_IMPL ~_Partition_status_tracker();
	};

	class _Contextaware_waitable_chore : public _Threadpool_chore
	{
		CompletionEvent *_ChoreSetCmpEvent;
		std::atomic<size_t> _Counter;

		void _CompleteOne()
		{
			auto _Ref = --_Counter;
			_ASSERTE(_Ref >= 0);
			if (_Ref == 0)
			{
				_ASSERT(_ChoreSetCmpEvent);
				_ChoreSetCmpEvent->completeOne();
			}
		}

		_EXP_IMPL static void _Set_current_chore(_Contextaware_waitable_chore *);
	public:
		virtual void waitable_invoke() = 0;

		virtual void __cdecl invoke() override final
		{
			_Contextaware_waitable_chore *_Backup = current_chore();
			_Set_current_chore(this);
			waitable_invoke();
			_Set_current_chore(_Backup);
			_CompleteOne();
		}

		_Contextaware_waitable_chore() : _ChoreSetCmpEvent(nullptr), _Counter(2) {}
		_Contextaware_waitable_chore(const _Contextaware_waitable_chore &) : _ChoreSetCmpEvent(nullptr), _Counter(2) {}

		// hide the base case reschedule() method
		void reschedule()
		{
			auto _Ref = ++_Counter;
			_ASSERTE(_Ref >= 1);
			if (_Ref == 1)
			{
				_ASSERT(_ChoreSetCmpEvent);
				_ChoreSetCmpEvent->addOne();
			}
			_Threadpool_chore::reschedule();
		}

		// wait can only be called once
		template <typename _RangeCt>
		static void wait(_RangeCt &_Range)
		{
			if (_Range.empty())
				return;

			CompletionEvent _Event(_Range.size());
			for (auto &_Chore : _Range)
			{
				if (_Chore.is_scheduled())
				{
					_ASSERT(_Chore._ChoreSetCmpEvent == nullptr);
					_Chore._ChoreSetCmpEvent = &_Event;
					_Chore._CompleteOne();
				}
				else // we assume the chore is completed if it has never been scheduled
					_Event.completeOne();
			}

			_Event.wait();
		}

		_EXP_IMPL static _Contextaware_waitable_chore * current_chore();

	};

	// Disable warning C4324: structure was padded due to __declspec(align())
	// This padding is expected and necessary.
#pragma warning(push)
#pragma warning(disable: 4324)			
	template <typename _It, typename _UserData, typename _Callback>
	class __declspec(align(64)) _Static_chore_noexcept :
		public _Contextaware_waitable_chore
	{
	protected:
		_Static_chore_noexcept& operator=(const _Static_chore_noexcept&) {};

		_It _Begin;
		size_t _Count;
		const _Callback& _AlgoCallback;
		_UserData _AlgoData;
	public:
		_Static_chore_noexcept()
		{
		}

		_Static_chore_noexcept(_It _First, size_t _Dist, _UserData _Data, const _Callback& _Func) :
			_Begin(std::move(_First)), _Count(_Dist), _AlgoData(std::move(_Data)), _AlgoCallback(_Func) {}

		virtual void waitable_invoke() override
		{
			_ASSERTE(_Count > 0);
			_AlgoCallback(_Begin, _Count, _AlgoData);
		}

		void rethrow_exception()
		{
		}
		template <typename _PartTag, bool _IsNoExcept> friend struct _Partitioner;
	};

	template <typename _It, typename _UserData, typename _Callback>
	class __declspec(align(64)) _Static_chore :
		public _Static_chore_noexcept<_It, _UserData, _Callback>
	{
		_Static_chore& operator=(const _Static_chore&) {}

		std::exception_ptr _Exception;
	public:
		_Static_chore()
		{
		}

		_Static_chore(_It _First, size_t _Count, _UserData _Data, const _Callback& _Func) :
			_Static_chore_noexcept(std::move(_First), _Count, std::move(_Data), _Func), _Exception(nullptr)
		{
		}

		virtual void waitable_invoke() override
		{
			try {
				_ASSERTE(_Count > 0);
				_AlgoCallback(_Begin, _Count, _AlgoData);
			}
			catch (...) {
				_Exception = std::current_exception();
			}
		}

		void rethrow_exception()
		{
			if (_Exception != nullptr)
			{
				std::list<std::exception_ptr> _ExList;
				_ExList.push_back(std::move(_Exception));
				throw exception_list(std::move(_ExList));
			}
		}

		template <typename _RangeCt>
		static void wait(_RangeCt &_Range)
		{
			_Contextaware_waitable_chore::wait(_Range);
			std::list<std::exception_ptr> _ExList;
			for (auto &_Chore : _Range)
			{
				if (_Chore._Exception != nullptr)
					_ExList.push_back(std::move(_Chore._Exception));
			}

			if (!_ExList.empty())
				throw exception_list(std::move(_ExList));
		}

		template <typename _PartTag, bool _IsNoExcept> friend struct _Partitioner;
	};
#pragma warning(pop) // C4324

	/*
	//The implementation of dynamic partitioner is broken thus commented out
	template <typename _It, typename _Fn>
	class _Semi_splittable_chore : public _Contextaware_waitable_chore
	{
	_Semi_splittable_chore& operator=(const _Semi_splittable_chore&) {}

	_It _Begin;
	// TODO: change long back to atomic<size_t> after testing the performance of new STL
	volatile long _Size;
	long _Chunk_size;

	struct ExceptionListNode
	{
	std::exception_ptr _Exception;
	ExceptionListNode *_Next;
	};

	ExceptionListNode * volatile _Exception_list;

	void push_exception(std::exception_ptr&& _ExPtr)
	{
	auto _Node = new ExceptionListNode;
	_Node->_Exception = std::move(_ExPtr);
	_Node->_Next = _Exception_list;

	while (_InterlockedCompareExchangePointer(reinterpret_cast<void *volatile *>(&_Exception_list), _Node, _Node->_Next) != _Node->_Next)
	_Node->_Next = _Exception_list;
	}

	const _Fn _Func;
	public:

	_Semi_splittable_chore(_It _First, size_t _S, const _Fn& _Fn, size_t _Chunk) :
	_Begin(_First), _Size(static_cast<long>(_S)), _Func(_Fn), _Chunk_size(static_cast<long>(_Chunk)), _Exception_list(nullptr)
	{
	}

	virtual void waitable_invoke() override
	{
	long _Len = _Size;
	_It _Curr = _Begin;
	_Size = 0;

	try
	{
	while (_Len > _Chunk_size)
	{
	if (!_Size && _InterlockedCompareExchange(&_Size, (_Len - _Len) / 2, 0) == 0)
	{
	_Len /= 2;
	_Begin = _Curr;
	std::advance(_Begin, _Len);
	reschedule();
	}

	_Func(_Curr, (std::min)(_Len, _Chunk_size));
	_Len -= _Chunk_size;
	std::advance(_Curr, _Chunk_size);
	}

	if (_Len > 0)
	_Func(_Curr, _Len);
	}
	catch (...)
	{
	push_exception(std::current_exception());
	}
	}

	template <typename _RangeCt>
	static void wait(_RangeCt &_Range)
	{
	_Contextaware_waitable_chore::wait(_Range);
	std::list<std::exception_ptr> _ExList;
	for (auto &_Chore : _Range)
	{
	ExceptionListNode *_Head = _Chore._Exception_list;
	while (_Head != nullptr)
	{
	_ExList.push_back(std::move(_Head->_Exception));
	auto _Next = _Head->_Next;
	delete _Head;
	_Head = _Next;
	}
	}

	if (!_ExList.empty())
	throw exception_list(std::move(_ExList));
	}
	};
	*/

	struct static_partitioner_tag {};
	struct auto_partitioner_tag {}; // self_guided that is default
	struct dynamic_partitioner_tag {};
	struct copy_partitioner_tag {};
	struct remove_partitioner_tag {};


	template<typename _PartTag, bool _IsNoExcept = std::is_base_of<parallel_vector_execution_policy, _PartTag>::value>
	struct _Partitioner;

	// Partitioners implementation
	template<typename _PartTag, bool _IsNoExcept>
	struct _Partitioner
	{
		static_assert(sizeof(_PartTag) == 0, "Partitioner tag not supported.");
	};

	template<bool _IsNoExcept>
	struct _Partitioner<static_partitioner_tag, _IsNoExcept>
	{
	private:
		template<typename _Container, typename _FwdIt, typename _UserData, typename _Callback>
		static _FwdIt _For_Each_impl(_Container& _Chores, _FwdIt _First, size_t _Count, _UserData _Data, const _Callback& _Func, size_t _Chunk_size = 0)
		{
			_Partition_status_tracker _Tracker;

			// when we are nested loops and there are too many chores, we run the loop inline
			if (_Contextaware_waitable_chore::current_chore() != nullptr && !_Tracker._IsPartitionNumUnderLimit())
			{
				typename _Container::value_type _Chore(_First, _Count, _Data, _Func);
				_Chore.invoke();
				_Chore.rethrow_exception();
			}
			else
			{
				if (_Chunk_size == 0) {
					const unsigned int _HdConc = get_hardware_concurrency();
					_Chunk_size = (_Count + _HdConc - 1) / _HdConc;
				}

				_Chores.reserve(_Count / _Chunk_size + 1);

				_Tracker._AddPartitions(_Count / _Chunk_size);

				while (_Count > _Chunk_size)
				{
					_Chores.emplace_back(_First, _Chunk_size, _Data, _Func);
					schedule_chore(&_Chores.back());
					_Count -= _Chunk_size;
					std::advance(_First, _Chunk_size);
				}

				_Chores.emplace_back(_First, _Count, _Data, _Func);
				_Chores.back().invoke();

				std::iterator_traits<_Container::iterator>::value_type::wait(_Chores);
			}
			std::advance(_First, _Count);
			return _First;
		}
	public:
		template<typename _FwdIt, typename _UserData, typename _Callback>
		static _FwdIt _For_Each(_FwdIt _First, size_t _Count, _UserData _Data, const _Callback& _Func, size_t _Chunk_size = 0)
		{
			typedef std::conditional < _IsNoExcept, _Static_chore_noexcept<_FwdIt, _UserData, _Callback>,
				_Static_chore < _FwdIt, _UserData, _Callback >> ::type _ChoreType;
			std::vector<_ChoreType> _Chores;

			return _For_Each_impl(_Chores, std::move(_First), _Count, std::move(_Data), _Func, _Chunk_size);
		}

		template<typename _FwdIt, typename _UserData, typename _Callback, typename _Cleanup_callback>
		static _FwdIt _For_each_with_cleanup(_FwdIt _First, size_t _Count, _UserData _Data, const _Callback& _Func, _Cleanup_callback _Cleanup, size_t _Chunk_size = 0)
		{
			typedef _Static_chore<_FwdIt, _UserData, _Callback> _ChoreType;
			std::vector<_ChoreType> _Chores;

			try {
				return _For_Each_impl(_Chores, std::move(_First), _Count, std::move(_Data), _Func, _Chunk_size);
			}
			catch (const exception_list&) {
				for (auto _It = std::begin(_Chores); _It != std::end(_Chores); ++_It)
					_Cleanup(_It->_Begin, _It->_Count, _It->_Exception);

				throw;
			}
		}
	};

	template<bool _IsNoExcept>
	struct _Partitioner<auto_partitioner_tag, _IsNoExcept>
	{
	protected:
		template<typename _Container, typename _FwdIt, typename _UserData, typename _Callback>
		static _FwdIt _For_Each_impl(_Container& _Chores, _FwdIt _First, size_t _Count, _UserData _Data, const _Callback& _Func, size_t _Chunk_size)
		{
			_Partition_status_tracker _Tracker;

			// when we are nested loops and there are too many chores, we run the loop inline
			if (_Contextaware_waitable_chore::current_chore() != nullptr && !_Tracker._IsPartitionNumUnderLimit())
			{
				typename _Container::value_type _Chore(_First, _Count, _Data, _Func);
				_Chore.invoke();
				_Chore.rethrow_exception();
			}
			else
			{
				if (_Chunk_size == 0)
					_Chunk_size = 2u;

				const unsigned int _HdConc = get_hardware_concurrency();
				size_t _Chores_size = 1;

				size_t _Count_tmp = _Count;
				while (_Count_tmp > _Chunk_size)
				{
					size_t _Step = (std::max)(_Count_tmp / _HdConc, _Chunk_size);
					_Count_tmp -= _Step;
					_Chores_size++;
				}

				_Tracker._AddPartitions(_Chores_size - 1);
				_Chores.reserve(_Chores_size);

				while (_Count > _Chunk_size)
				{
					size_t _Step = (std::max)(_Count / _HdConc, _Chunk_size);
					_Chores.emplace_back(_First, _Step, _Data, _Func);
					schedule_chore(&_Chores.back());
					_Count -= _Step;
					std::advance(_First, _Step);
				}

				_Chores.emplace_back(_First, _Count, _Data, _Func);
				_Chores.back().invoke();
				std::iterator_traits<_Container::iterator>::value_type::wait(_Chores);
			}

			std::advance(_First, _Count);
			return _First;
		}
	public:
		template<typename _FwdIt, typename _UserData, typename _Callback>
		static _FwdIt _For_Each(_FwdIt _First, size_t _Count, _UserData _Data, const _Callback& _Func, size_t _Chunk_size = 0)
		{
			typedef std::conditional < _IsNoExcept, _Static_chore_noexcept<_FwdIt, _UserData, _Callback>,
				_Static_chore < _FwdIt, _UserData, _Callback >> ::type _ChoreType;

			std::vector<_ChoreType> _Chores;

			return _For_Each_impl(_Chores, std::move(_First), _Count, std::move(_Data), _Func, _Chunk_size);
		}
	};

	template<typename _OutIt, typename _DiffType = typename std::iterator_traits<_OutIt>::difference_type>
	class _Output_token
	{
		_OutIt _Begin;
		_DiffType _Iter_pos;
	public:
		const static _DiffType EMPTY_POSITION = static_cast<_DiffType>(-1);

		_Output_token(_OutIt _It) : _Begin(_It)
		{
		}

		// Can be called only on one thread and set once
		void set_position(_DiffType _Pos)
		{
			_Iter_pos = _Pos;
		}

		_OutIt get() const
		{
			return _Begin;
		}

		_OutIt get_result() const
		{
			_OutIt _Out = _Begin;
			std::advance(_Out, _Iter_pos);
			return _Out;
		}

		template <typename _It, typename _OutIt, typename _First_stage, typename _Second_stage> friend class _Copy_chore;
	public:
		void move(_Output_token& _Token)
		{
			_Begin = _Token._Begin;
			std::advance(_Begin, _Token._Iter_pos);
		}

		bool empty() const
		{
			return _Iter_pos == 0;
		}
	};

	template<typename _OutIt, typename _OutIt2, typename _DiffType = typename std::iterator_traits<_OutIt>::difference_type>
	class _Output_token_double
	{
		_OutIt _Begin;
		_OutIt2 _Begin2;
		_DiffType _Iter_pos;
		_DiffType _Iter_pos2;
	public:
		const static _DiffType EMPTY_POSITION = static_cast<_DiffType>(-1);

		_Output_token_double(_OutIt _It, _OutIt2 _It2) : _Begin(_It), _Begin2(_It2)
		{
		}

		// Can be called only on one thread and set once
		void set_position(_DiffType _Pos, _DiffType _Pos2)
		{
			_Iter_pos = _Pos;
			_Iter_pos2 = _Pos2;
		}

		std::pair<_OutIt, _OutIt2> get() const
		{
			return std::pair<_OutIt, _OutIt2>(_Begin, _Begin2);
		}

		std::pair<_OutIt, _OutIt2> get_result() const
		{
			_OutIt _Out = _Begin;
			std::advance(_Out, _Iter_pos);

			_OutIt _Out2 = _Begin2;
			std::advance(_Out2, _Iter_pos2);

			return std::pair<_OutIt, _OutIt2>(_Out, _Out2);
		}

		template <typename _It, typename _OutIt, typename _First_stage, typename _Second_stage> friend class _Copy_chore;
	public:
		void move(_Output_token_double& _Token)
		{
			_Begin = _Token._Begin;
			std::advance(_Begin, _Token._Iter_pos);

			_Begin2 = _Token._Begin2;
			std::advance(_Begin2, _Token._Iter_pos2);
		}

		bool empty() const
		{
			return _Iter_pos == 0 && _Iter_pos2 == 0;
		}
	};

	// Disable warning C4324: structure was padded due to __declspec(align())
	// This padding is expected and necessary.
#pragma warning(push)
#pragma warning(disable: 4324)
	template <typename _It, typename _OutToken, typename _First_stage, typename _Second_stage>
	class __declspec(align(64)) _Copy_chore : public _Contextaware_waitable_chore
	{
	protected:
		enum _ChoreInternalState {
			_Started = 0x00,
			_Filtered = 0x00,
			_Missed = 0x01,
			_NotFiltered = 0x02
		};

		_It _Begin;
		size_t _Size;
		_First_stage _Stage1;
		_Second_stage _Stage2;
		_Copy_chore* _Next_chore;
		_OutToken _Output;
		std::exception_ptr _Exception;
		std::atomic<int> _State;

		bool try_filter()
		{
			return (_State.fetch_or(_Missed | _NotFiltered) & _NotFiltered) == _Filtered;
		}

		bool try_filter_missed()
		{
			int _ExpectedState = _Missed | _Filtered;
			return _State.compare_exchange_strong(_ExpectedState, _Missed | _NotFiltered);
		}

		bool is_started()
		{
			return (_State.load() & _Missed) == _Started;
		}

		void set_filtered()
		{
			_State.fetch_and(~_NotFiltered);
		}
	public:
		_Copy_chore(_It _First, size_t _S, _OutToken _Dest, const _First_stage& _St1, const _Second_stage& _St2, bool _Is_first = false) :
			_Begin(_First), _Size(_S), _Output(_Dest), _Stage1(_St1), _Stage2(_St2), _Next_chore(nullptr), _Exception(nullptr)
		{
			_State = _Started | (_Is_first ? _Filtered : _NotFiltered);
		}

		void set_next(_Copy_chore* _Next)
		{
			_Next_chore = _Next;
		}

		// Can be executed on the single thread only
		_OutToken get_output_token()
		{
			_ASSERT(_Next_chore == nullptr);
			return _Output;
		}

		virtual void waitable_invoke() override
		{
			try {
				if (is_started())
					_Stage1(_Begin, _Size, _Output);

				if (try_filter()) { // Check if the output buffer position was set
					_Copy_chore* _Next = this;
					do {
						if (_Next->_Next_chore != nullptr) { // Pass the results to the next chore in chain
							_Next->_Next_chore->_Output.move(_Next->_Output);
							_Next->_Next_chore->set_filtered();

							if (!_Next->_Next_chore->is_started() && _Next->_Next_chore->is_scheduled())
								_Next->_Next_chore->reschedule();
						}

						// If none of the element was filtered there will be no copy to the buffer
						// Skipping the stage2 handler
						if (!_Next->_Output.empty())
							_Next->_Stage2(_Next->_Begin, _Next->_Size, _Next->_Output);

						_Next = _Next->_Next_chore;

						// Pick up the work if it's not beeing executed yet
					} while (_Next != nullptr && _Next->try_filter_missed());
				}
			}
			catch (...) {
				_Exception = std::current_exception();
			}
		}

		template <typename _RangeCt>
		static void wait(_RangeCt &_Range)
		{
			_Contextaware_waitable_chore::wait(_Range);
			std::list<std::exception_ptr> _ExList;
			for (auto &_Chore : _Range)
			{
				if (_Chore._Exception != nullptr)
					_ExList.push_back(std::move(_Chore._Exception));
			}

			if (!_ExList.empty())
				throw exception_list(std::move(_ExList));
		}

		template <typename _It, typename _OutToken, typename _First_stage, typename _Second_stage>
		friend class _Remove_chore;
	};

	template <typename _It, typename _OutToken, typename _First_stage, typename _Second_stage>
	class __declspec(align(64)) _Remove_chore :
		public _Copy_chore<_It, _OutToken, _First_stage, _Second_stage>
	{
	public:
		_Remove_chore(_It _First, size_t _S, _OutToken _Dest, const _First_stage& _St1, const _Second_stage& _St2, bool _Is_first = false) :
			_Copy_chore(_First, _S, _Dest, _St1, _St2, _Is_first)
		{
		}

		virtual void waitable_invoke() override
		{
			try {
				if (is_started())
					_Stage1(_Begin, _Size, _Output);

				if (try_filter()) { // Check if the output buffer position was set
					_Copy_chore* _Next = this;
					do {
						// If none of the element was filtered there will be no copy to the buffer
						// Skipping the stage2 handler
						if (!_Next->_Output.empty())
							_Next->_Stage2(_Next->_Begin, _Next->_Size, _Next->_Output);

						if (_Next->_Next_chore != nullptr) { // Pass the results to the next chore in chain
							_Next->_Next_chore->_Output.move(_Next->_Output);
							_Next->_Next_chore->set_filtered();
						}

						_Next = _Next->_Next_chore;

						// Pick up the work if it's not beeing executed yet
					} while (_Next != nullptr && _Next->try_filter_missed());
				}
			}
			catch (...) {
				_Exception = std::current_exception();
			}
		}
	};
#pragma warning(pop) // C4324

	template<>
	struct _Partitioner<copy_partitioner_tag>
	{
	protected:
		template<typename _ChoreType, typename _FwdIt, typename _OutToken, typename _First_stage, typename _Second_stage>
		static _OutToken _For_Each_impl(_FwdIt _First, size_t _Count, _OutToken _Dest, const _First_stage& _Stage1, const _Second_stage& _Stage2, size_t _Chunk_size = 0)
		{
			_ChoreType* _Prev_chore = nullptr;

			if (_Chunk_size == 0) {
				const unsigned int _HdConc = get_hardware_concurrency();
				_Chunk_size = (_Count + _HdConc - 1) / _HdConc;
			}

			std::list<_ChoreType> _Chores;

			while (_Count > _Chunk_size) {
				if (!_Chores.empty())
					_Prev_chore = &_Chores.back();

				_Chores.emplace_back(_First, _Chunk_size, _Dest, _Stage1, _Stage2, _Prev_chore == nullptr);

				if (_Prev_chore != nullptr) {
					auto _Current = &_Chores.back();
					_Prev_chore->set_next(_Current);
					schedule_chore(_Prev_chore);
				}

				_Count -= _Chunk_size;
				std::advance(_First, _Chunk_size);
			}

			if (!_Chores.empty())
				_Prev_chore = &_Chores.back();

			_Chores.emplace_back(_First, _Count, _Dest, _Stage1, _Stage2, _Prev_chore == nullptr);

			if (_Prev_chore != nullptr) {
				_Prev_chore->set_next(&_Chores.back());
				schedule_chore(_Prev_chore);
			}

			_Prev_chore = &_Chores.back();
			_Prev_chore->waitable_invoke();
			_ChoreType::wait(_Chores);

			return _Prev_chore->get_output_token();
		}

	public:
		template<typename _FwdIt, typename _OutToken, typename _First_stage, typename _Second_stage>
		static _OutToken _For_Each(_FwdIt _First, size_t _Count, _OutToken _Dest, const _First_stage& _Stage1, const _Second_stage& _Stage2, size_t _Chunk_size = 0)
		{
			typedef _Copy_chore<_FwdIt, _OutToken, _First_stage, _Second_stage> _ChoreType;

			return _For_Each_impl<_ChoreType>(_First, _Count, _Dest, _Stage1, _Stage2, _Chunk_size);
		}
	};

	template<bool _IsNoExcept>
	struct _Partitioner<remove_partitioner_tag, _IsNoExcept> :
		public _Partitioner<copy_partitioner_tag, _IsNoExcept>
	{
		template<typename _FwdIt, typename _OutToken, typename _First_stage, typename _Second_stage>
		static _OutToken _For_Each(_FwdIt _First, size_t _Count, _OutToken _Dest, const _First_stage& _Stage1, const _Second_stage& _Stage2, size_t _Chunk_size = 0)
		{
			typedef _Remove_chore<_FwdIt, _OutToken, _First_stage, _Second_stage> _ChoreType;

			return _For_Each_impl<_ChoreType>(_First, _Count, _Dest, _Stage1, _Stage2, _Chunk_size);
		}
	};

	// The implementation of dynamic partitioner is broken thus commented out
	/*
	template<>
	struct _Partitioner<dynamic_partitioner_tag>
	{
	template<typename _FwdIt, typename _Fn>
	static _FwdIt _For_Each(_FwdIt _First, size_t _Count, const _Fn& _Func, size_t _Trunk_size)
	{
	typedef _Semi_splitable_chore<_FwdIt, _Fn> _ChoreType;

	const unsigned int _HdConc = get_hardware_concurrency();

	std::vector<_ChoreType> _Chores;
	_Chores.reserve(_HdConc);

	if (_Trunk_size == 0)
	_Trunk_size = 1;

	size_t _Big_chunk_size = (_Count + _HdConc - 1) / _HdConc;

	while (_Count > _Big_chunk_size)
	{
	_Chores.emplace_back(_First, _Big_chunk_size, _Func, _Trunk_size);
	schedule_chore(&_Chores.back());
	_Count -= _Big_chunk_size;
	std::advance(_First, _Big_chunk_size);
	}

	_Chores.emplace_back(_First, _Count, _Func, _Trunk_size);
	schedule_chore(&_Chores.back());

	_ChoreType::wait(_Chores);

	std::advance(_First, _Count);
	return _First;
	}
	};
	*/

	// parallel_execution_policy defaults to self guided partitioner
	template<bool _IsNoExcept>
	struct _Partitioner<parallel_execution_policy, _IsNoExcept> :
		public _Partitioner<auto_partitioner_tag, _IsNoExcept>
	{
	};

	// parallel_vector_execution_policy defaults to self guided partitioner
	template<bool _IsNoExcept>
	struct _Partitioner<parallel_vector_execution_policy, _IsNoExcept> :
		public _Partitioner<auto_partitioner_tag, _IsNoExcept>
	{
	};

	// Abstracting loop helpers
	template <typename _ExPolicy, typename _It, typename _IterCat = typename std::iterator_traits<_It>::iterator_category>
	struct LoopHelper
	{
		template<typename _Fn>
		static _It Loop(_It _It, size_t _Count, const _Fn& _Func)
		{
			for (; 0 < _Count; --_Count) {
				_Func(*_It);
				++_It;
			}

			return _It;
		}

		template<typename _Fn, typename _CancellationToken>
		static _It Loop(_It _It, size_t _Count, const _Fn& _Func, const _CancellationToken& _Token)
		{
			for (; 0 < _Count; --_Count) {
				_Func(*_It);

				if (_Token.is_cancelled())
					return _It;

				++_It;
			}

			return _It;
		}
	};

	template <typename _ExPolicy, typename _It>
	struct LoopHelper<_ExPolicy, _It, std::random_access_iterator_tag>
	{
		template<typename _Fn>
		static _It Loop(_It _It, size_t _Count, const _Fn& _Func)
		{
			for (size_t _I = 0; _I < _Count; ++_I)
				_Func(_It[_I]);

			std::advance(_It, _Count);
			return _It;
		}

		template<typename _Fn, typename _CancellationToken>
		static _It Loop(_It _It, size_t _Count, const _Fn& _Func, const _CancellationToken& _Token)
		{
			size_t _I = 0;

			for (; _I < _Count; ++_I) {
				_Func(_It[_I]);

				if (_Token.is_cancelled())	{
					std::advance(_It, _I);
					return _It;
				}
			}

			std::advance(_It, _I);
			return _It;
		}
	};

	// Contiguous Container Iterator Traits
	// Please note, it will NOT identify all contiguous iterators. It only tries its best.
	template <typename _ItrType>
	struct _Contiguous_container_iterator_traits : std::integral_constant<bool,
		std::is_convertible<_ItrType, typename std::vector<typename std::iterator_traits<_ItrType>::value_type>::const_iterator>::value
		|| std::is_convertible<_ItrType, typename std::string::const_iterator>::value
		|| std::is_convertible<_ItrType, typename std::wstring::const_iterator>::value>
	{};

	//  cancellation tokens
	class cancellation_token
	{
		std::atomic_bool _State;
	public:
		cancellation_token()
		{
			_State.store(false, std::memory_order_relaxed);
		}

		bool is_cancelled() const throw()
		{
			return _State.load(std::memory_order_relaxed);
		}

		void cancel() throw()
		{
			_State.store(true, std::memory_order_relaxed);
		}
	};

	class thread_cancellation_token
	{
		bool _State;
	public:
		thread_cancellation_token() throw() : _State(false)
		{
		}

		bool is_cancelled() const throw()
		{
			return _State;
		}

		void cancel() throw()
		{
			_State = true;
		}
	};

	// The implementation requires the _Pred to define a total order over _Ty
	template<typename _Ty, typename _Pred = std::less_equal<_Ty>>
	class cancellation_token_with_position
	{
		std::atomic<_Ty> _State;
	public:

		cancellation_token_with_position(_Ty _Pos) throw() : _State(_Pos)
		{
		}

		bool is_cancelled(_Ty _Pos) const throw()
		{
			return _Pred()(_State.load(std::memory_order_relaxed), _Pos);
		}

		void cancel(_Ty _Pos) throw()
		{
			_Ty _Old = _State.load(std::memory_order_relaxed);

			do {
				// Must not replace if there is closer match already found
				if (_Pred()(_Old, _Pos))
					return;

			} while (!_State.compare_exchange_strong(_Old, _Pos, std::memory_order_relaxed));
		}

		_Ty get_position() throw()
		{
			_Ty _Dummy = 0;
			return _State.exchange(_Dummy, std::memory_order_relaxed);
		}
	};

	template<typename _ExPolicy, typename _Ty>
	struct _enable_if_parallel :
		public std::enable_if<
		std::is_base_of<parallel_execution_policy, typename std::decay<_ExPolicy>::type>::value ||
		std::is_base_of<parallel_vector_execution_policy, typename std::decay<_ExPolicy>::type>::value,
		_Ty>
	{
	};

	template<typename _ExPolicy, typename _Ty>
	struct _enable_if_policy :
		public std::enable_if<
		std::is_base_of<sequential_execution_policy, typename std::decay<_ExPolicy>::type>::value ||
		std::is_base_of<parallel_execution_policy, typename std::decay<_ExPolicy>::type>::value ||
		std::is_base_of<parallel_vector_execution_policy, typename std::decay<_ExPolicy>::type>::value ||
		std::is_base_of<execution_policy, typename std::decay<_ExPolicy>::type>::value,
		_Ty>
	{
	};
}
_PSTL_NS1_END // std::experimental::experimental::parallel::details

#pragma warning(pop)
#endif // _IMPL_ALGORITHM_IMPL_H_
