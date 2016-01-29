////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Queries_i/BooleanQuery_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Queries_i::BooleanQuery_i
//
// ���������� �������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_QUERIES_I_BOOLEANQUERY_I_H__
#define __GARANTCORE_SEARCH_QUERIES_I_BOOLEANQUERY_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Def/Def.h"

namespace Search {
namespace Queries_i {

// ���������� �������������� �������
class BooleanQuery_i;
typedef Core::Var<BooleanQuery_i> BooleanQuery_i_var;
typedef Core::Var<const BooleanQuery_i> BooleanQuery_i_cvar;

class BooleanQuery_i :
	virtual public IBooleanQuery
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BooleanQuery_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	BooleanQuery_i ();

	explicit BooleanQuery_i (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	size_t m_count;

	std::string m_data;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IBooleanQuery
	// �������� ������
	void add (IQuery* query, MergeOp op);

	// implemented method from IBooleanQuery
	// ���������� ��������
	size_t get_count () const;

	// implemented method from IQuery
	// ������
	const std::string& get_data () const;

	// implemented method from IQuery
	// ���
	const std::string& get_type () const;
}; // class BooleanQuery_i

} // namespace Queries_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_QUERIES_I_BOOLEANQUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

