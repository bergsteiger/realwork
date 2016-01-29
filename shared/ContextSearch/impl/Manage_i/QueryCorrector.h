////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/QueryCorrector.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Manage_i::QueryCorrector
//
// ��������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_QUERYCORRECTOR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_QUERYCORRECTOR_H__

#include "shared/Core/sys/std_inc.h"

namespace ContextSearch {
namespace Manage_i {

// ��������� �������
class QueryCorrector {
	SET_OBJECT_COUNTER (QueryCorrector)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// ����
	struct Info {
		// ��������������
		bool has_syn;
		// ������������ ������ ���������
		size_t max_fragment;
		Info () : has_syn(true), max_fragment(0) {
			//#UC START# *5515463200B8_DEF_INIT_CTOR*
			//#UC END# *5515463200B8_DEF_INIT_CTOR**cpp*
		}
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit QueryCorrector (bool uwc);

public:
	virtual ~QueryCorrector ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������
	const std::string execute (const std::string& str, Info& out);

private:
	// ����������� ���������
	void correct (std::string& str, char delim = ' ');

	// ����������� ���������
	void correct_special (std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_uwc;
}; // class QueryCorrector

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_QUERYCORRECTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

