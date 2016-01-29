////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/StreamReader.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::StreamReader
//
// StreamReader
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_STREAMREADER_H__
#define __GARANTCORE_DBEXT_READERS_STREAMREADER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantCore/DBExt/Readers/BaseReader.h"

namespace DBExt {

// StreamReader
class StreamReader;
typedef Core::Var<StreamReader> StreamReader_var;
typedef Core::Var<const StreamReader> StreamReader_cvar;

class StreamReader :
	virtual public DBCore::IRefStream
	, virtual public BaseReader
{
	SET_OBJECT_COUNTER (StreamReader)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���������
	static const size_t BUFFER_SIZE; // ������ ������� ������ ��� ������ ����������

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	StreamReader (DBCore::Store* stream, DBCore::IIndex* index);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ���������� doc_id �� �������� ������� � ������
	bool get_id (size_t pos, DBCore::Ref_& ref, long& res);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	char* m_ptr;

	size_t m_tail;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DBCore::IRefStream
	// �����
	unsigned long get_length () const;

	// implemented method from DBCore::IRefStream
	// ��������� ��������� ������ ������
	bool get_next (DBCore::Ref_& ref, long border);

	// implemented method from DBCore::IRefStream
	// ������� �������
	unsigned long get_tell () const;

	// implemented method from DBCore::IRefStream
	// ����� ��������� ���������
	bool search (DBCore::Ref_& ref);
}; // class StreamReader

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_STREAMREADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

