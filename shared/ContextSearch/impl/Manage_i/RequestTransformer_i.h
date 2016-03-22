////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/RequestTransformer_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::RequestTransformer_i
// ��������� ���������� ������ �������� ��� ��������� IRequestTransformer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/Morpho/Def/Def.h"

namespace ContextSearch {
namespace Manage_i {

class RequestTransformer_i; // self forward Var
typedef ::Core::Var<RequestTransformer_i> RequestTransformer_i_var;
typedef ::Core::Var<const RequestTransformer_i> RequestTransformer_i_cvar;

class RequestTransformer_i_factory;

class RequestTransformer_i:
	virtual public Manage::IRequestTransformer
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (RequestTransformer_i)
	friend class RequestTransformer_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ��������� ����� � �����
	static void _exclude (std::string& str, const GCL::StrVector& data);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	RequestTransformer_i (Morpho::Def::INormalizer* normalizer);

	~RequestTransformer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// �������� �������� ����
	const std::string& correct_date (std::string& str);

	// ���������� ����-���� c ������ hard-��������������
	void exclude_hard (std::string& req, const GCL::StrVector& data, const GCL::StrVector& hard);

	// �������� ������ �� �������� "�", "�.", "���",..
	bool is_year (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Morpho::Def::INormalizer_var m_normalizer;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Manage::IRequestTransformer
	// �������������
	void correct (const std::string& in, std::string& out);

	// implemented method from Manage::IRequestTransformer
	// ���������� ����-����
	size_t exclude (std::string& req, const GCL::StrVector& data);

	// implemented method from Manage::IRequestTransformer
	// ���������
	GCL::StrVector* execute (const std::string& in, const GCL::StrVector& data, const GCL::StrVector& hard);
}; // class RequestTransformer_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_REQUESTTRANSFORMER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
