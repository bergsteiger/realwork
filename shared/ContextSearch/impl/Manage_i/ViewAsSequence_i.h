////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSequence_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSequence_i
// «аголовок реализации класса серванта дл€ интерфеса IRequestView
//
// ѕредставление запроса в виде последовательности синонимичных запросов
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
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

// ѕредставление запроса в виде последовательности синонимичных запросов
class ViewAsSequence_i:
	virtual public Search::IRequestView
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ViewAsSequence_i)
	friend class ViewAsSequence_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ƒанные поискового запроса
	struct ReqData {
		// количество произведенных операций синонимии
		size_t syn_counter;
		// текст запроса
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

	// ƒанные синонимичных запросов
	typedef std::vector < ReqData > RequestsInfo;

	// ѕревышен предел допустимого количества запросов
	class ExceededLimit : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

	//  онстанты алгоритма синонимизации
	static const size_t MAX_WORDS_COUNT; // максимально допустимое количество слов в запросах
	static const size_t MAX_REQUEST_COUNT; // максимальное количество запросов
	static const size_t GENERATE_REQUESTS_LIMIT; // количество запросов при достижении которого прекращаем генерацию

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// добавить синоним
	static void add (const std::string& syn, const std::string& src, const ReqData& in, RequestsInfo& data);

	// добавить
	static void add_ (const std::string& str, const Search::Phrase& syns, RequestsInfo& data);

	// вывод отладочной информации
	static void print_info (const RequestsInfo& data);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	ViewAsSequence_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

	~ViewAsSequence_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// добавить запрос
	void add_request (const std::string& req);

	// синонимизаци€
	void mutate (const std::string& str, RequestsInfo& info);

	// модификаци€ списка синонимичных запросов
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
	// создать
	bool build (const Search::Phrase& in, const std::string& src);

	// implemented method from Search::IRequestView
	// список синонимичных
	const Search::SplitRequests& get_sequence () const;

	// implemented method from Search::IRequestView
	// спаны
	const Search::Phrases& get_spans () const;

	// implemented method from Search::IRequestView
	// тип
	Search::AlgorithmSelector get_type () const;
}; // class ViewAsSequence_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
