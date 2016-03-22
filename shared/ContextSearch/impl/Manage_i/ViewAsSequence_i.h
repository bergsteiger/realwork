////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSequence_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSequence_i
// ��������� ���������� ������ �������� ��� ��������� IRequestView
//
// ������������� ������� � ���� ������������������ ������������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/ContextSearch/MorphoBase/Synonymizer.h"

namespace ContextSearch {
namespace Manage_i {

class ViewAsSequence_i; // self forward Var
typedef ::Core::Var<ViewAsSequence_i> ViewAsSequence_i_var;
typedef ::Core::Var<const ViewAsSequence_i> ViewAsSequence_i_cvar;

class ViewAsSequence_i_factory;

// ������������� ������� � ���� ������������������ ������������ ��������
class ViewAsSequence_i:
	virtual public Search::IRequestView
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ViewAsSequence_i)
	friend class ViewAsSequence_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ������ ���������� �������
	struct ReqData {
		// ���������� ������������� �������� ���������
		size_t syn_counter;
		// ����� �������
		std::string text;
		ReqData () : syn_counter(0) {
			//#UC START# *4CA1FEB70031_DEF_INIT_CTOR*
			//#UC END# *4CA1FEB70031_DEF_INIT_CTOR**cpp*
		}
		//#UC START# *4CA1FEB70031*
		ReqData (const std::string& str) : syn_counter (0), text (str) {
		}

		bool operator == (const ReqData& val) const {
			return text == val.text;
		}

		bool operator < (const ReqData& val) const {
			return syn_counter < val.syn_counter;
		}
		//#UC END# *4CA1FEB70031*
	};

	// ������ ������������ ��������
	typedef std::vector < ReqData > RequestsInfo;

	// �������� ������ ����������� ���������� ��������
	class ExceededLimit : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

	// ��������� ��������� �������������
	static const size_t MAX_WORDS_COUNT; // ����������� ���������� ���������� ���� � ��������
	static const size_t MAX_REQUEST_COUNT; // ������������ ���������� ��������
	static const size_t GENERATE_REQUESTS_LIMIT; // ���������� �������� ��� ���������� �������� ���������� ���������

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// �������� �������
	static void add (const std::string& syn, const std::string& src, const ReqData& in, RequestsInfo& data);

	// ��������
	static void add_ (const std::string& str, const Search::Phrase& syns, RequestsInfo& data);

	// ����� ���������� ����������
	static void print_info (const RequestsInfo& data);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	ViewAsSequence_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

	~ViewAsSequence_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// �������� ������
	void add_request (const std::string& req);

	// �������������
	void mutate (const std::string& str, RequestsInfo& info);

	// ����������� ������ ������������ ��������
	size_t transform (RequestsInfo& info);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

	Search::SplitRequests m_sequence;

	Core::Box<Synonymizer> m_synonymizer;

	Manage::IRequestTransformer_var m_transformer;

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
}; // class ViewAsSequence_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
