////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/StreamsManager.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::StreamsManager
//
// �������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_STREAMSMANAGER_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_STREAMSMANAGER_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/DB/DBCore/DBCore.h"

namespace SearchAdapterLib {
namespace DBComm_i {

// �������� �������
class StreamsManager;
typedef Core::Var<StreamsManager> StreamsManager_var;
typedef Core::Var<const StreamsManager> StreamsManager_cvar;

class StreamsManager :
	virtual public DBCore::IStreamsFactory
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StreamsManager)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ��� �������
	typedef std::map < std::string, DBCore::Streams > CachedStreams;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	StreamsManager (DBCore::IBase* base, const std::string& src, const std::string& form_src);

public:
	~StreamsManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ������
	void close (DBCore::Streams& streams_);

	// ������� ��� ������
	void close ();

	// ��������� �����
	unsigned char get_form (const std::string& key, std::string& out_key);

	// �������
	DBCore::StreamsPair* make_ (const std::string& key, unsigned long flags);

	// ������� ������
	unsigned char open (const std::string& key, bool is_form, DBCore::Streams& streams_);

	// ������� ������ (� ����������� � ���, ���� �� �������)
	void open (const std::string& key, DBCore::Streams& streams_);

	// ������� ������
	void open_streams (const std::string& key, DBCore::Streams& streams_);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBCore::IBase_var m_base;

	std::string m_form_src;

	DBCore::IIndex_var m_index;

	CachedStreams m_streams;

	bool m_use_cache;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DBCore::IStreamsFactory
	// �������� �� ����������
	bool is_valid () const;

	// implemented method from DBCore::IStreamsFactory
	// �������
	DBCore::StreamsPair* make (const std::string& key, unsigned long flags);
}; // class StreamsManager

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_STREAMSMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

