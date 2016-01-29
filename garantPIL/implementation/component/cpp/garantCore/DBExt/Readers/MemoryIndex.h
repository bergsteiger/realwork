////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/MemoryIndex.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::MemoryIndex
//
// MemoryIndex
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_MEMORYINDEX_H__
#define __GARANTCORE_DBEXT_READERS_MEMORYINDEX_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantCore/DBExt/Def/Def.h"

//#UC START# *51532B59030D_CUSTOM_INCLUDES*
struct Data {
	SET_OBJECT_COUNTER (Data)

	std::string key;

	bool has_form;

	char* ref_buf;
	int ref_len;

	char* data_buf;
	int data_len;

	Data () : ref_buf (0), data_buf (0), ref_len (0), data_len (0), has_form (false) {
	}

	~Data () {
		if (ref_buf) {
			delete [] ref_buf;
		}
		if (data_buf) {
			delete [] data_buf;
		}
	}

	bool operator < (const Data& val) const {
		return key < val.key;
	}
};
//#UC END# *51532B59030D_CUSTOM_INCLUDES*

namespace DBExt {

// MemoryIndex
class MemoryIndex {
	SET_OBJECT_COUNTER (MemoryIndex)

	// singleton declaration
	typedef ACE_Singleton <MemoryIndex, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MemoryIndex, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static MemoryIndex* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ������ ������
	static GCL::StrVector* get_lexemes (DBCore::IBase* base);

	// ������� ����� ������
	static long get_stream_len (DBCore::IIndex* index, const char* key, unsigned short stream_no);

	// �������� �� �� ��, ��� ������� ������������� ��������� �������
	static bool is_skip (const char* key);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MemoryIndex ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������
	void clear ();

	// ������� ������ ��� ��������� �����
	DBCore::StreamsPair* get (const std::string& key, Def::Type type);

	// �������� �� ��, ��� ��� ���������������
	bool is_load () const;

	// ��������� memcache ���������� �������
	void load (const DBCore::MemCacheSettings& settings);

private:
	// �������� ����
	bool add (DBCore::IIndex* index, const char* key, bool is_load, DBCore::LoadType type);

	// �������� ����
	bool add_ (DBCore::IIndex* index, const char* key, bool is_load, bool filtering);

	// ���������
	void load (DBCore::IBase* base);

	// ��������������� ��������
	void prev_load (const DBCore::MemCacheSettings& settings);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Mutex m_mutex;

	unsigned long long m_total;

//#UC START# *51532B59030D*
public:
	static void filtrate (Data& data);

private:
	typedef std::vector <Data> _Index;
	_Index m_data;
//#UC END# *51532B59030D*
}; // class MemoryIndex

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_MEMORYINDEX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

