////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/ViewAsParts_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsParts_i
// ��������� ���������� ������ �������� ��� ��������� IRequestView
//
// ������������� ������� � ���� ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/MorphoBase/Synonymizer.h"

namespace ContextSearch {
namespace Manage_i {

class ViewAsParts_i; // self forward Var
typedef ::Core::Var<ViewAsParts_i> ViewAsParts_i_var;
typedef ::Core::Var<const ViewAsParts_i> ViewAsParts_i_cvar;

class ViewAsParts_i_factory;

// ������������� ������� � ���� ���������� ������
class ViewAsParts_i:
	virtual public Search::IRequestView
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ViewAsParts_i)
	friend class ViewAsParts_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ������ ����
	typedef std::vector < Search::PhraseEx > PhraseList;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// �������� �����
	static void add_phrase (const GCL::StrVector& in, PhraseList& out);

	// �������� �����
	static void add_phrase (const GCL::StrVector& in, Search::PhraseEx& out);

	// ������� �����
	static bool is_strong (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	ViewAsParts_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

	~ViewAsParts_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������
	void add (const Search::StringSet& in);

	// ������ �����
	bool deflate (GCL::StrVector& out);

	// ������� ��������� ������
	bool make_spans (const GCL::StrVector& in);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

	Search::Phrases m_spans;

	Core::Box<Synonymizer> m_synonymizer;

	bool m_was_compression;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Search::IRequestView
	// �������
	bool build (const Search::Phrase& in, const std::string& src);

	// implemented method from Search::IRequestView
	// ������ ������������
	const Search::SplitRequests& get_sequence () const;

	// implemented method from Search::IRequestView
	// �����
	const Search::Phrases& get_spans () const;

	// implemented method from Search::IRequestView
	// ���
	Search::AlgorithmSelector get_type () const;
}; // class ViewAsParts_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
