#ifndef SINGLE_INDEX_BASE_H_
#define SINGLE_INDEX_BASE_H_
#include "loki/static_check.h"

#include "shared/Core/mng/Var.h"
#include "shared/Core/GDS/ObjectCounter.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/SimpleIndex.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/SimpleBase.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/RecoverableIndex.h"

//          База NdtClone с одним индексом.
//          
// - описания KeyType & DataTypeList см. в SimpleIndex.h
// 
// - BaseType - SimpleBase, настроенный на размер страницы
//              и версию базы
//              
// - в констукторе задаются имена файлов ключей, стримов и 
//   количество стримов (количество стримов должно быть равно 
//   количетсву типов в DataTypeList);
//   в 'strict' версии количество стримов определяется автоматически

namespace NdtClone {

// common routines 
template <typename KeyType, typename DataTypeList, typename BaseType, typename IndexType>
class SingleIndexBaseBase {
	SET_OBJECT_COUNTER (SingleIndexBaseBase)

public:
	typedef typename IndexType::IndexMutexType MutexType;
	typedef typename IndexType::AllKeySelector AllKeySelector;
	
protected:
	SingleIndexBaseBase (const std::string& key_file_name, const std::string& stream_file_name) {
	}

public:
	void remove (const KeyType& key) {
		m_index->remove (key);
	}

	bool is_exist (const KeyType& key) const {
		return m_index->is_exist (key);
	}
	
	long key_count () const {
		return m_index->KeyCount;
	}

	void remove_files () {
		m_base.delete_files_after_use ();
	}

	MutexType& get_mutex () const {
		return m_index->get_mutex ();
	}
	
	template <typename KeySelector>
	void get_keys (const KeySelector& selector, std::vector<KeyType>& keys) const {
		return m_index->get_keys (selector, keys);
	}

	virtual ~SingleIndexBaseBase () {
		// в момент разрушения индекса, база должна быть еще открыта,
		// т.е. в своих хранилищах или пишите явно:
		// 1. m_index.reset ();
		// 2. m_base.close ();
		// или следите за порядком объявления переменных в классе,
		// их деструкторы выполняются в обратном порядке.
		LOG_D ((GDS_CURRENT_FUNCTION));
	}

protected:
	std::pair <PagedFile*, StreamFile*> open (const std::string& key_file_name, const std::string& stream_file_name) {
		return m_base.open (key_file_name, stream_file_name);
	}

protected:
	BaseType m_base;
	IndexType *m_index;
};




// Single Index Base 
template <typename KeyType, typename DataTypeList, typename RecoveryPolicy, typename BaseType>
class SingleIndexBase
	: public SingleIndexBaseBase <
		KeyType
		, DataTypeList
		, BaseType
		, SimpleIndex<KeyType, DataTypeList, RecoveryPolicy>  
	> {

	SET_OBJECT_COUNTER (SingleIndexBase)

public:
	SingleIndexBase (const std::string& key_file_name, const std::string& stream_file_name)
		: SingleIndexBaseBase < 
			KeyType
			, DataTypeList
			, BaseType
			, SimpleIndex<KeyType, DataTypeList, RecoveryPolicy>
		> (key_file_name, stream_file_name) {		
		std::pair <PagedFile*, StreamFile*> base = this->open (key_file_name, stream_file_name);
		this->m_index = new SimpleIndex<KeyType, DataTypeList, RecoveryPolicy> (
			base.first
			, "index"
			, base.second
		);
	}

	template <typename DataType>	
	void write (const KeyType& key, const DataType& data, int stream_number = 0)	{
		this->m_index->write (key, data, stream_number);
	}

	template <typename DataType>		
	void read (const KeyType& key, DataType& data, int stream_number = 0) const {
		return this->m_index->read (key, data, stream_number);
	}
};





// Strict version: with unique fields types
template <typename KeyType, typename DataTypeList, typename RecoveryPolicy, typename BaseType>
class StrictSingleIndexBase
	: public SingleIndexBaseBase <
		KeyType
		, DataTypeList
		, BaseType
		, StrictSimpleIndex<KeyType, DataTypeList, RecoveryPolicy>  
	> {

	SET_OBJECT_COUNTER (StrictSingleIndexBase)

public:
	StrictSingleIndexBase (const std::string& key_file_name, const std::string& stream_file_name)
		: SingleIndexBaseBase < 
			KeyType
			, DataTypeList
			, BaseType
			, StrictSimpleIndex<KeyType, DataTypeList, RecoveryPolicy>
		> (key_file_name, stream_file_name) {		
		std::pair <PagedFile*, StreamFile*> base = this->open (key_file_name, stream_file_name);
		this->m_index = new StrictSimpleIndex<KeyType, DataTypeList, RecoveryPolicy> (base.first, "index", base.second);
	}

	template <typename DataType>	
	void write (const KeyType& key, const DataType& data)	{
		this->m_index->write (key, data);
	}

	template <typename DataType>		
	void read (const KeyType& key, DataType& data) const {
		this->m_index->read (key, data);
	}
};

} // namespace

#endif // SINGLE_INDEX_BASE_H_




