////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/BaseReader.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::BaseReader
//
// ������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_BASEREADER_H__
#define __GARANTCORE_DBEXT_READERS_BASEREADER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// ������� �����
class BaseReader;
typedef Core::Var<BaseReader> BaseReader_var;
typedef Core::Var<const BaseReader> BaseReader_cvar;

class BaseReader :
	virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BaseReader)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BaseReader (DBCore::Store* stream, DBCore::IIndex* index);

public:
	~BaseReader ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// ���� ������ ������
	size_t get_length () const;

	// ����� ������
	size_t get_stream_length () const;

	// ������� ������� � ������
	size_t get_tell () const;

	// ������ ������
	char* read (size_t data_size, int pos);

	// ������ ������
	char* read_more ();

private:
	// ������ ������
	size_t read (char* buffer, size_t count);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������ ��� ������
	char* m_buffer;

	// ����� �������
	size_t m_buffer_size;

	DBCore::IIndex* m_index;

	// ����� ������ ������
	size_t m_length;

	// ��������� �� �������� �����
	DBCore::Store* m_stream;
}; // class BaseReader

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_BASEREADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

