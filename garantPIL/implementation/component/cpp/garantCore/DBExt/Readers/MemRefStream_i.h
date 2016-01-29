////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/MemRefStream_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::MemRefStream_i
//
// MemRefStream
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_READERS_MEMREFSTREAM_I_H__
#define __GARANTCORE_DBEXT_READERS_MEMREFSTREAM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// MemRefStream
class MemRefStream_i;
typedef Core::Var<MemRefStream_i> MemRefStream_i_var;
typedef Core::Var<const MemRefStream_i> MemRefStream_i_cvar;

class MemRefStream_i :
	virtual public DBCore::IRefStream
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MemRefStream_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	MemRefStream_i (const char* data, int length);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ���������� doc_id �� �������� ������� � ������
	bool get_id (size_t pos, DBCore::Ref_& ref, long& res);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned long m_length;

	unsigned long m_pos;

	const char* m_ptr;

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
}; // class MemRefStream_i

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_READERS_MEMREFSTREAM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

