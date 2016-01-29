#ifndef SIMPLE_INDEX_H_
#define SIMPLE_INDEX_H_

#include <memory>
#include <vector>

#include "loki/Typelist.h"
#include "loki/static_check.h"

//#include "shared/GCL/alg/loki_extension.h"

#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/Core/sys/synch.h"
#include "shared/Core/sys/assert.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/RecoverableIndex.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/btiter.h"
	
// SimpleIndex
// ќбертка над NdtClone::Index, упрощающа€ запись и чтение данных в Ѕƒ
// ѕредставл€ет сущность 'таблица'
//
// KeyType      - ключ (поддерживаетс€ только один ключ)
//                должен быть фиксированного размера и не превышать 160 байт
//                при этом база данных может содержать не более 8 индексов (таблиц):
//                зависимость кол-во индексов от размера ключей:
//                sizeof (KeyType) <= 256-12*кол-во индексов
//                (при размере ключа 160 байт заложились на 8 индексов)
//
// DataTypeList - список типов полей таблицы, объекты перечисленных типов
//                хран€тс€ в соответсвующих индексах, т.е. первый указанный тип -
//                в нулевом индексе, второй указанный тип в - первом индексе и т.д. 
//
//                список типов ограничен 10, его можно расширить см. методы
//                SimpleIndexBase::init
//                SimpleIndex::check_stream_type
//
//                ƒл€ типов данных должны быть определены операторы:
//                void operator << (NdtClone::Stream&, const DataType&);
//                void operator >> (NdtClone::Stream&, DataType&);

namespace NdtClone {

const unsigned long MAX_KEY_SIZE = 160; 
const unsigned long MAX_STREAM_COUNT = 10; 

template <class T>
class AllKeySelector {
public:
	bool operator () (const T&) const {
		return true;
	}
};

template <class Stream, class Index>
class AutoStream {
public:
	AutoStream (Stream* stream, Index* index) : m_stream (stream), m_index (index) {
		GDS_ASSERT (index);
		if (!m_stream) {
			throw Error ();
		}
	}
	~AutoStream () {
		m_index->Close (m_stream);
	}

	Stream* operator-> () {
		return m_stream; 
	}

	Stream& operator* () {
		return *m_stream;
	}

	Stream* get () {
		return m_stream; 
	}
	
private:
	Stream* m_stream;
	Index* m_index;
};


template <typename KeyType, typename DataTypeList, typename RecoveryPolicy, typename MutexType>
class SimpleIndexBase : public RecoverableIndex <RecoveryPolicy> {
	SET_OBJECT_COUNTER (SimpleIndexBase)

public:
	typedef MutexType    IndexMutexType;
	typedef KeyType      IndexKeyType;
	typedef DataTypeList IndexDataTypeList;
	typedef typename ::NdtClone::AllKeySelector<KeyType> AllKeySelector;

protected:
	SimpleIndexBase (PagedFile* paged_file, const char* name, StreamFile* stream_file, int stream_count)
		: RecoverableIndex<RecoveryPolicy> (paged_file, name, stream_file, sizeof (KeyType), 8, stream_count) {
		GDS_ASSERT (sizeof (KeyType) <= MAX_KEY_SIZE);
		GDS_ASSERT (stream_count <= MAX_STREAM_COUNT);
	}	

public:	
	virtual int Compare (BTKEY key1, BTKEY key2) const {
		int size = sizeof (KeyType);
		return memcmp (key1, key2, sizeof (KeyType));
	}

	void remove (const KeyType& key) {
		GUARD (m_mutex);
		if (this->Delete (&key) != BT_OK) {
			throw Error ();
		}
	}

	bool is_exist (const KeyType& key) const {
		GUARD (m_mutex);

		if (!this->KeyCount) {  // TODO: remove this patch when 
			return false;         //       NdtClone::Index will be fixed.
		}

		if (Stream* stream = const_cast<SimpleIndexBase*> (this)->Open(&key, false)) {
			const_cast<SimpleIndexBase*> (this)->Close (stream);
			return true;
		}
		return false;
	}

	template <typename KeySelector>
	void get_keys (const KeySelector& selector, typename std::vector<KeyType>& keys) const {
		GUARD (m_mutex);
		BTIterator it (this);
		while (!it.End ()) {
			const KeyType& key = *(reinterpret_cast<const KeyType*> (it.Key ()));
			if (selector (key)) {
				keys.push_back (key);
			}
			++it;
		}
	}

	IndexMutexType& get_mutex () const {
		return m_mutex;
	}

protected:
	template<typename DataType>
	void write_i (const KeyType& key, const DataType& data, int stream_number) {
		GUARD (m_mutex);
		{
			AutoStream<Stream, Index> stream (this->OpenN(&key, stream_number, true), this);
			(*stream) << data;
			stream->Trunc ();
		}
		this->flush_files ();
	}

	template<typename DataType>
	void read_i (const KeyType& key, DataType& data, int stream_number) const {
		GUARD (m_mutex);

		AutoStream<Stream, Index> stream (
			const_cast<SimpleIndexBase*>(this)->OpenN (&key, stream_number, false)
			, const_cast<SimpleIndexBase*>(this)
		);
		(*stream) >> data;
	}

private:
	mutable IndexMutexType m_mutex;
};


#define IS_SAME_TYPE(index) (Loki::IsSameType<typename ::Loki::TL::TypeAtNonStrict<DataTypeList, (index)>::Result, DataType>::value)

template <typename KeyType, typename DataTypeList, typename RecoveryPolicy, typename MutexType = ::Core::Mutex>
class SimpleIndex : public SimpleIndexBase<KeyType, DataTypeList, RecoveryPolicy, MutexType> {
	SET_OBJECT_COUNTER (SimpleIndex)
	
public:
	SimpleIndex (PagedFile* paged_file, const char* name, StreamFile* stream_file)
		: SimpleIndexBase<KeyType, DataTypeList, RecoveryPolicy, MutexType> (
				paged_file
				, name
				, stream_file
				, ::Loki::TL::Length<DataTypeList>::value
			) {
	}

	template<typename DataType>
	void write (const KeyType& key, const DataType& data, int stream_number) {
		GDS_ASSERT (this->check_stream_type<DataType> (stream_number) || !"Stream Datatype Mismatch!");
		this->write_i (key, data, stream_number);
	}

	template<typename DataType>
	void read (const KeyType& key, DataType& data, int stream_number) const {
		GDS_ASSERT (this->check_stream_type<DataType> (stream_number) || !"Stream Datatype Mismatch!");
		this->read_i (key, data, stream_number);
	}

	// LOKI_STATIC_CHECK version of read & write methods.
	// Its need two template arguments:
	//   - DataType:    type of data to store
	//   - type_number: number of entry 'DataType' in 'DataTypeList', e.g.:
	//                  typedef TYPELIST_6(
	//                    string                  // name 
	//                    , int
	//                    , long
	//                    , double
	//                    , string                // nick
	//                    , bool
	//                    , string                // street
	//                  ) MyTypeList;
	//                  to read/write 'string' data from MyTypeList you must use one of
	//                  next expressions:
	//                  index->read/write<string, 0> (key, "Bob");    // operate with name
	//                  index->read/write<string, 1> (key, "Eagle");  // operate with nick
	//                  index->read/write<string, 2> (key, "Avenue"); // operate with street
	//                  ATTENTION: MUST be used '0', '1' & '2' indices, NOT actual indices 
	//                  of type 'string' in MyTypeList (0, 4, 6)
	//
	//
	//template<typename DataType, int type_number>
	//void read (const KeyType& key, DataType& data) {
	//	LOKI_STATIC_CHECK (
	//		(
	//			::IndexOfWithNum<DataTypeList, DataType, type_number>::value
	//				!= ::Loki::TL::IndexOf<DataTypeList, Loki::NullType>::value
	//		)
	//		, Writing_unknown_type
	//	);
	//	this->read_i (key, data, ::IndexOfWithNum<DataTypeList, DataType, type_number>::value);
	//}
  //
	//template<typename DataType, int type_number>
	//void write (const KeyType& key, const DataType& data) {
	//	LOKI_STATIC_CHECK (
	//		(
	//			::IndexOfWithNum<DataTypeList, DataType, type_number>::value
	//				!= ::Loki::TL::IndexOf<DataTypeList, Loki::NullType>::value
	//		)
	//		, Writing_unknown_type
	//	);
	//	this->write_i (key, data, ::IndexOfWithNum<DataTypeList, DataType, type_number>::value);
	//}


private:
	template<typename DataType>
	bool check_stream_type (int stream_number) const {
		switch (stream_number) {
			case 0: return IS_SAME_TYPE (0);
			case 1: return IS_SAME_TYPE (1);
			case 2: return IS_SAME_TYPE (2);
			case 3: return IS_SAME_TYPE (3);
			case 4: return IS_SAME_TYPE (4);
			case 5: return IS_SAME_TYPE (5);
			case 6: return IS_SAME_TYPE (6);
			case 7: return IS_SAME_TYPE (7);
			case 8: return IS_SAME_TYPE (8);
			case 9: return IS_SAME_TYPE (9);
			default: GDS_ASSERT (!"Stream number is out of range"); return false;
		}
	}
};


template <typename KeyType, typename DataTypeList, typename RecoveryPolicy, typename MutexType = ::Core::Mutex>
class StrictSimpleIndex : public SimpleIndexBase<KeyType, DataTypeList, RecoveryPolicy, MutexType> {
	SET_OBJECT_COUNTER (StrictSimpleIndex)

public:
	StrictSimpleIndex (PagedFile* paged_file, const char* name, StreamFile* stream_file)
		: SimpleIndexBase<KeyType, DataTypeList, RecoveryPolicy, MutexType> (
				paged_file
				, name
				, stream_file
				, ::Loki::TL::Length<DataTypeList>::value
			) {

		typedef typename ::Loki::TL::NoDuplicates<DataTypeList>::Result UniqueTypeList;
		LOKI_STATIC_CHECK (
			::Loki::TL::Length<DataTypeList>::value == ::Loki::TL::Length<UniqueTypeList>::value
			, Types_of_DataTypeList_for_StrictSimpleIndex_MUST_be_unique
		);
	}

	template<typename DataType>
	void write (const KeyType& key, const DataType& data) {
		LOKI_STATIC_CHECK (
			(
				::Loki::TL::IndexOf<DataTypeList, DataType>::value
					!= ::Loki::TL::IndexOf<DataTypeList, Loki::NullType>::value
			)
			, Writing_unknown_type
		);
		this->write_i (key, data, ::Loki::TL::IndexOf<DataTypeList, DataType>::value);
	}

	template<typename DataType>
	void read (const KeyType& key, DataType& data) const {
		LOKI_STATIC_CHECK (
			(
				::Loki::TL::IndexOf<DataTypeList, DataType>::value
					!= ::Loki::TL::IndexOf<DataTypeList, Loki::NullType>::value
			)
			, Reading_unknown_type
		);
		this->read_i (key, data, ::Loki::TL::IndexOf<DataTypeList, DataType>::value);
	}
};


} // namespace GCL

#endif // SIMPLE_INDEX_H_




