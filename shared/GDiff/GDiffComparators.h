#ifndef SHARED_GDIFF_GDIFFCOMPARATORS_H_
#define	SHARED_GDIFF_GDIFFCOMPARATORS_H_

#pragma  warning (push)
	#pragma  warning (disable: 4244) // 'argument' : conversion from 'type1' to 'type2', possible loss of data

	#include "ace/ACE.h"
	#include "ace/Array.h"
	#include "ace/Hash_Map_Manager.h"
	#include "ace/Null_Mutex.h"
	#include "ace/OS.h"
	#include "ace/SString.h"
	#include "ace/Synch_Traits.h" // remove after TAO update on nemesis-linux  
#pragma  warning (pop)

#include <cassert>
#include <vector>

namespace GDiff {
namespace Private {

const size_t c_unknown_text_size (static_cast <size_t> (-1L));

class BaseComparator {
public:
	typedef std::vector<unsigned long> Data;
public:
	typedef void (*PutCompareInfo) (
		void* a_this
		, size_t a_lposition
		, size_t a_ldeleted
		, size_t a_rposition
		, size_t a_rinserted
	);
protected:
	class Diff {
	public:
		typedef ACE_Array <bool> Modified;
	public:
		Diff (
			const Data& a_data
		)
			: m_data (a_data)
			, m_modified (m_data.size ()* 2, false)
		{
			// do nothing
		}
	public:
		inline size_t size (
			void
		) const {
			return (m_data.size ());
		}
	public:
		inline Modified& modified (
			void
		) {
			return (m_modified);
		}
	public:
		inline int operator [] (
			size_t a_index
		) const {
			return (m_data [a_index]);
		}
	private:
		const Data& m_data;

		Modified m_modified;
	}; // class Diff
private:
	class Info {
	public:
		Info (
			void
		)
			: m_x (0)
			, m_y (0)
		{
			// do nothing
		}
	public:
		inline size_t x (
			void
		) const {
			return (m_x);
		}

		inline size_t y (
			void
		) const {
			return (m_y);
		}
	public:
		inline void set (
			size_t a_x
			, size_t a_y
		) {
			m_x = a_x;
			m_y = a_y;
		}
	private:
		size_t m_x;
		size_t m_y;
	}; // class Info
private:
	typedef ACE_Array <ssize_t> Vector;
public:
	inline static void compare (
		void* a_this
		, PutCompareInfo a_put_compare_info
		, const Data& a_ldata
		, const Data& a_rdata
	) {
		BaseComparator l_comparator; {
			l_comparator.compare_i (a_this, a_put_compare_info, a_ldata, a_rdata);
		}
	}
protected:
	BaseComparator (
		void
	) {
		// do nothing
	}
protected:
	void compare_i (
		void* a_this
		, PutCompareInfo a_put_compare_info
		, const Data& a_ldata
		, const Data& a_rdata
	) const;
protected:
	virtual void fixup (
		Diff& a_diff
	) const;
}; // class BaseComparator


class ParaComparator: virtual private BaseComparator {
public:
	typedef const char* (*GetNextPara) (
			void* a_this
			, size_t& a_size
	);

	typedef BaseComparator::PutCompareInfo PutCompareInfo;
protected:
	typedef BaseComparator::Diff Diff;
private:
	typedef ACE_CString HashTable_Key;
	typedef unsigned long HashTable_Value;

	typedef ACE_Hash_Map_Manager_Ex <                                                                                  \
		HashTable_Key                                                                                                  \
		, HashTable_Value                                                                                              \
		, ACE_Hash <HashTable_Key>                                                                                     \
		, ACE_Equal_To <HashTable_Key>                                                                                 \
		, ACE_SYNCH_NULL_MUTEX                                                                                         \
	> HashTable;
public:
	inline static void compare (
		void* a_this
		, PutCompareInfo a_put_compare_info
		, GetNextPara a_get_next_lpara
		, GetNextPara a_get_next_rpara
	) {
		ParaComparator l_comparator; {
			l_comparator.compare_i (a_this, a_put_compare_info, a_get_next_lpara, a_get_next_rpara);
		}
	}
protected:
	ParaComparator (
		void
	): BaseComparator () {
		// do nothing
	}
protected:
	void compare_i (
		void* a_this
		, PutCompareInfo a_put_compare_info
		, GetNextPara a_get_next_lpara
		, GetNextPara a_get_next_rpara
	) const;
}; // class ParaComparator

template <typename CHAR_TYPE> // CHAR_TYPE := [char | wchar_t]
class TextComparator: virtual private BaseComparator {
public:
	typedef BaseComparator::PutCompareInfo PutCompareInfo;
protected:
	typedef BaseComparator::Diff Diff;
public:
	inline static void compare (
		void* a_this
		, PutCompareInfo a_put_compare_info
		, const CHAR_TYPE* a_ltext
		, const CHAR_TYPE* a_rtext
		, size_t a_llength = c_unknown_text_size
		, size_t a_rlength = c_unknown_text_size
	) {
		TextComparator <CHAR_TYPE> l_comparator; {
			l_comparator.compare_i (a_this, a_put_compare_info, a_ltext, a_rtext, a_llength, a_rlength);
		}
	}
protected:
	TextComparator (
		void
	): BaseComparator () {
		// do nothing
	}
protected:
	void compare_i (
		void* a_this
		, PutCompareInfo a_put_compare_info
		, const CHAR_TYPE* a_ltext
		, const CHAR_TYPE* a_rtext
		, size_t a_llength
		, size_t a_rlength
	) const {
		class StaticHelper {
		public:
			static size_t get_length (
				const CHAR_TYPE* a_text
				, size_t a_length
			) {
				return (
					(
						a_length != c_unknown_text_size
					) ? (
						a_length
					) : (
						ACE_OS::strlen ((assert (a_text != 0), a_text))
					)
				);
			}
		public:
			static void create_data (
				const CHAR_TYPE* a_text
				, size_t a_length
				, Data& a_data
			) {
				class TypeTransformer {
				public:
					inline static unsigned long src2dst (
						CHAR_TYPE a_type
					) {
						return (static_cast <unsigned long> ((unsigned)a_type));
					}
				};

				a_data.size (a_length);

				for (size_t i = 0; i < a_length; ++i) {
					a_data [i] = TypeTransformer::src2dst (a_text [i]);
				}
			}
		}; // class StaticHelper

		const size_t l_llength (StaticHelper::get_length (a_ltext, a_llength));
		const size_t l_rlength (StaticHelper::get_length (a_rtext, a_rlength));

		Data l_ldata (l_llength); {
			StaticHelper::create_data (a_ltext, l_llength, l_ldata);
		}

		Data l_rdata (l_rlength); {
			StaticHelper::create_data (a_rtext, l_rlength, l_rdata);
		}

		BaseComparator::compare_i (a_this, a_put_compare_info, l_ldata, l_rdata);
	}
}; // class TextComparator


template <typename CHAR_TYPE> // CHAR_TYPE := [char | wchar_t]
class TextAsParaComparator {
public:
	inline static void compare (
		void* a_this
		, ParaComparator::PutCompareInfo a_put_compare_info
		, const CHAR_TYPE* a_ltext
		, const CHAR_TYPE* a_rtext
	) {
		class CallbackWrapper {
		public:
			static const char* get_next_lpara (
				void* a_this
				, size_t& a_size
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->get_next_lpara (
						a_size
					)
				);
			}

			static const char* get_next_rpara (
				void* a_this
				, size_t& a_size
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->get_next_rpara (
						a_size
					)
				);
			}
		public:
			static void put_compare_info (
				void* a_this
				, size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->put_compare_info (
						a_lposition
						, a_ldeleted
						, a_rposition
						, a_rinserted
					)
				);
			}
		public:
			CallbackWrapper (
				void* a_this
				, ParaComparator::PutCompareInfo a_put_compare_info
				, const CHAR_TYPE* a_ltext
				, const CHAR_TYPE* a_rtext
			)
				: m_this (a_this)
				, m_put_compare_info (a_put_compare_info)
				, m_lindex (0)
				, m_ltext (a_ltext)
				, m_rindex (0)
				, m_rtext (a_rtext)
			{
				// do nothing
			}

			~CallbackWrapper (
				void
			) {
				// do nothing
			}
		private:
			const char* get_next_lpara (
				size_t& a_size
			) {
				return (this->get_next_para (m_ltext, m_lindex, a_size));
			}

			const char* get_next_rpara (
				size_t& a_size
			) {
				return (this->get_next_para (m_rtext, m_rindex, a_size));
			}
		private:
			void put_compare_info (
				size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				if (m_put_compare_info != 0) {
					m_put_compare_info (m_this, a_lposition, a_ldeleted, a_rposition, a_rinserted);
				}
			}
		private:
			const char* get_next_para (
				const CHAR_TYPE* a_text
				, size_t& a_index
				, size_t& a_size
			) {
				a_size = sizeof (CHAR_TYPE);

				if (a_text [a_index] == (CHAR_TYPE)0) {
					return (0); // end of data
				} else {
					return ((const char*)&a_text [a_index++]);
				}
			}
		private:
			void* m_this;
			ParaComparator::PutCompareInfo m_put_compare_info;

			size_t m_lindex;
			const CHAR_TYPE* m_ltext;

			size_t m_rindex;
			const CHAR_TYPE* m_rtext;
		} l_callback_wrapper (a_this, a_put_compare_info, a_ltext, a_rtext); // class CallbackWrapper

		ParaComparator::compare (
			&l_callback_wrapper
			, &CallbackWrapper::put_compare_info
			, &CallbackWrapper::get_next_lpara
			, &CallbackWrapper::get_next_rpara
		);
	}
protected:
	TextAsParaComparator (
		void
	) {
		// do nothing
	}
}; // class TextAsParaComparator

class CompareHandler {
public:
	virtual void handle_next_result (
		size_t a_lposition
		, size_t a_ldeleted
		, size_t a_rposition
		, size_t a_rinserted
	) = 0;
}; // class CompareHandler

class CompareIterator {
public:
	virtual const char* next (
		size_t& a_size
	) = 0;
}; // class CompareHandler

template <typename TYPE>
class ParaCompareAdapter {
public:
	inline static void compare (
		CompareHandler* a_compare_handler
		, CompareIterator* a_compare_literator
		, CompareIterator* a_compare_riterator
	) {
		class CallbackWrapper {
		public:
			static const char* get_next_lpara (
				void* a_this
				, size_t& a_size
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->get_next_lpara (
						a_size
					)
				);
			}

			static const char* get_next_rpara (
				void* a_this
				, size_t& a_size
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->get_next_rpara (
						a_size
					)
				);
			}
		public:
			static void put_compare_info (
				void* a_this
				, size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->put_compare_info (
					a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);
			}
		public:
			CallbackWrapper (
				CompareHandler* a_compare_handler
				, CompareIterator* a_compare_literator
				, CompareIterator* a_compare_riterator
			)
				: m_compare_handler ((assert (a_compare_handler != 0), a_compare_handler))
				, m_compare_literator ((assert (a_compare_literator != 0), a_compare_literator))
				, m_compare_riterator ((assert (a_compare_riterator != 0), a_compare_riterator))
			{
				// do nothing
			}

			~CallbackWrapper (void) {
				// do nothing
			}
		private:
			const char* get_next_lpara (
				size_t& a_size
			) {
				return (this->get_next_para (m_compare_literator, a_size));
			}

			const char* get_next_rpara (
				size_t& a_size
			) {
				return (this->get_next_para (m_compare_riterator, a_size));
			}
		private:
			void put_compare_info (
				size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				m_compare_handler->handle_next_result (a_lposition, a_ldeleted, a_rposition, a_rinserted);
			}
		private:
			const char* get_next_para (
				CompareIterator* a_compare_iterator
				, size_t& a_size
			) {
				return (a_compare_iterator->next (a_size));
			}
		private:
			CompareHandler* m_compare_handler;

			CompareIterator* m_compare_literator;
			CompareIterator* m_compare_riterator;
		} l_callback_wrapper (a_compare_handler, a_compare_literator, a_compare_riterator); // class CallbackWrapper

		TYPE::compare (
			&l_callback_wrapper
			, &CallbackWrapper::put_compare_info
			, &CallbackWrapper::get_next_lpara
			, &CallbackWrapper::get_next_rpara
		);
	}
}; // class ParaCompareAdapter

template <typename TYPE, typename CHAR_TYPE> // CHAR_TYPE := [char | wchar_t]
class TextCompareAdapter {
public:
	inline static void compare (
		CompareHandler* a_compare_handler
		, const CHAR_TYPE* a_ltext
		, const CHAR_TYPE* a_rtext
		, size_t a_llength = c_unknown_text_size
		, size_t a_rlength = c_unknown_text_size
	) {
		class CallbackWrapper {
		public:
			CallbackWrapper (
				CompareHandler* a_compare_handler
			)
				: m_compare_handler ((assert (a_compare_handler != 0), a_compare_handler))
			{
				// do nothing
			}

			~CallbackWrapper (
				void
			) {
				// do nothing
			}
		public:
			static void put_compare_info (
				void* a_this
				, size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->put_compare_info (
					a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);
			}
		private:
			void put_compare_info (
				size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				m_compare_handler->handle_next_result (a_lposition, a_ldeleted, a_rposition, a_rinserted);
			}
		private:
			CompareHandler* m_compare_handler;
		} l_callback_wrapper (a_compare_handler); // class CallbackWrapper

		TYPE::compare (
			&l_callback_wrapper
			, &CallbackWrapper::put_compare_info
			, a_ltext
			, a_rtext
			, a_llength
			, a_rlength
		);
	}
}; // class TextCompareAdapter

template <typename TYPE, typename CHAR_TYPE> // CHAR_TYPE := [char | wchar_t]
class TextAsParaCompareAdapter {
public:
	inline static void compare (
		CompareHandler* a_compare_handler
		, const CHAR_TYPE* a_ltext
		, const CHAR_TYPE* a_rtext
	) {
		class CallbackWrapper {
		public:
			CallbackWrapper (
				CompareHandler* a_compare_handler
			)
				: m_compare_handler ((assert (a_compare_handler != 0), a_compare_handler))
			{
				// do nothing
			}

			~CallbackWrapper (
				void
			) {
				// do nothing
			}
		public:
			static void put_compare_info (
				void* a_this
				, size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->put_compare_info (
					a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);
			}
		private:
			void put_compare_info (
				size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				m_compare_handler->handle_next_result (a_lposition, a_ldeleted, a_rposition, a_rinserted);
			}
		private:
			CompareHandler* m_compare_handler;
		} l_callback_wrapper (a_compare_handler); // class CallbackWrapper

		TYPE::compare (
			&l_callback_wrapper
			, &CallbackWrapper::put_compare_info
			, a_ltext
			, a_rtext
		);
	}
}; // class TextAsParaCompareAdapter
} // namespace Private

typedef Private::CompareHandler CompareHandler;
typedef Private::CompareIterator CompareIterator;

typedef Private::ParaComparator ParaComparator;
typedef Private::ParaCompareAdapter <ParaComparator> ParaComparatorEx;

typedef Private::TextComparator <char> TextComparatorA;
typedef Private::TextCompareAdapter <TextComparatorA, char> TextComparatorExA;
#if defined (ACE_HAS_WCHAR)
typedef Private::TextComparator <wchar_t> TextComparatorW;
typedef Private::TextCompareAdapter <TextComparatorW, wchar_t> TextComparatorExW;
#endif // defined (ACE_HAS_WCHAR)

typedef Private::TextAsParaComparator <char> TextAsParaComparatorA;
typedef Private::TextAsParaCompareAdapter <TextAsParaComparatorA, char> TextAsParaComparatorExA;
#if defined (ACE_HAS_WCHAR)
typedef Private::TextAsParaComparator <wchar_t> TextAsParaComparatorW;
typedef Private::TextAsParaCompareAdapter <TextAsParaComparatorW, wchar_t> TextAsParaComparatorExW;
#endif // defined (ACE_HAS_WCHAR)

} // namespace GDiff

#endif // SHARED_GDIFF_GDIFFCOMPARATORS_H_ 
