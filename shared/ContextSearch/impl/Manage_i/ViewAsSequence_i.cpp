////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSequence_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSequence_i
//
// ѕредставление запроса в виде последовательности синонимичных запросов
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSequence_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "shared/ContextSearch/MorphoBase/RequestBuilder.h"
#include "boost/bind.hpp"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

const char* ViewAsSequence_i::ExceededLimit::uid () const /*throw ()*/ {
	return "7E4E8815-2676-4E16-8A40-4AB9FA13F2B0";
}

const char* ViewAsSequence_i::ExceededLimit::what () const throw () {
	//#UC START# *4C80B20302FF_WHAT_IMPL*
	return "ExceededLimit (ѕревышен предел допустимого количества запросов)";
	//#UC END# *4C80B20302FF_WHAT_IMPL*
}



//  онстанты алгоритма синонимизации
const size_t ViewAsSequence_i::MAX_WORDS_COUNT = 400; // максимально допустимое количество слов в запросах
const size_t ViewAsSequence_i::MAX_REQUEST_COUNT = 100; // максимальное количество запросов
const size_t ViewAsSequence_i::GENERATE_REQUESTS_LIMIT = 1000; // количество запросов при достижении которого прекращаем генерацию

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// добавить синоним
void ViewAsSequence_i::add (const std::string& syn, const std::string& src, const ReqData& in, RequestsInfo& data) {
	//#UC START# *53919C560199*
	data.push_back (in);

	ReqData& item = data.back ();
	item.text += (in.text.empty ())? syn : std::string (" ") + syn;

	if (syn != src) {
		++item.syn_counter;
	}
	//#UC END# *53919C560199*
}

// добавить
void ViewAsSequence_i::add_ (const std::string& str, const Search::Phrase& syns, RequestsInfo& data) {
	//#UC START# *53919C790289*
	if (data.empty ()) {
		std::for_each (syns.begin (), syns.end ()
			, boost::bind (&add, _1, str, ReqData (), boost::ref (data))
		);
	} else {
		RequestsInfo data_;

		for (size_t i = 0; i < data.size (); ++i) {
			std::for_each (syns.begin (), syns.end ()
				, boost::bind (&add, _1, str, boost::cref (data [i]), boost::ref (data_))
			);
		}

		data = data_;
	}
	//#UC END# *53919C790289*
}

// вывод отладочной информации
void ViewAsSequence_i::print_info (const RequestsInfo& data) {
	//#UC START# *53919C9E00C9*
#ifdef _DEBUG
	std::cout << std::endl << std::endl;
	for (RequestsInfo::const_iterator it = data.begin (); it != data.end (); ++it) {
		std::cout << it->text << " <-> " << it->syn_counter << std::endl;
	}
	std::cout << std::endl;
#endif
	//#UC END# *53919C9E00C9*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ViewAsSequence_i::ViewAsSequence_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer)
//#UC START# *5273986F01D9_52739AA90277_5390900700B2_BASE_INIT*
	: m_communicator (comm)
//#UC END# *5273986F01D9_52739AA90277_5390900700B2_BASE_INIT*
{
	//#UC START# *5273986F01D9_52739AA90277_5390900700B2_BODY*
	GDS_ASSERT (comm);
	GDS_ASSERT (normalizer);

	m_transformer = Manage::IRequestTransformerFactory::make (normalizer);
	m_synonymizer = new Synonymizer (comm, normalizer);
	//#UC END# *5273986F01D9_52739AA90277_5390900700B2_BODY*
}

ViewAsSequence_i::~ViewAsSequence_i () {
	//#UC START# *5390900700B2_DESTR_BODY*
	//#UC END# *5390900700B2_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить запрос
void ViewAsSequence_i::add_request (const std::string& req) {
	//#UC START# *5391AE310142*
	Search::SplitRequest request;
	RequestBuilder::make (req, request);

	if (request.context.empty () == false) {
		m_sequence.push_back (request);
	}
	//#UC END# *5391AE310142*
}

// синонимизаци€
void ViewAsSequence_i::mutate (const std::string& str, RequestsInfo& info) {
	//#UC START# *53919E170029*
	const DBComm::Synonyms& syns = m_communicator->get_syns ();

	if (syns.empty ()) {
		info.push_back (ReqData (str));
		return;
	}

	size_t offset = 0;
	std::string word, req_str;

	RequestsInfo data;
	RequestsInfo::iterator it;

	for (const char* req = str.c_str (); *req && data.size () <= GENERATE_REQUESTS_LIMIT; req += offset) {
		req_str = req;

		Core::Aptr <Search::Phrase> res = m_synonymizer->get (req_str, offset);

		if (offset == 0) {
			offset = ContextUtility::get_first_word (word, req);

			Search::Phrase tmp;

			if (ContextUtility::is_alnum (word)) {
				tmp.resize (2, word);
				Synonymizer::split (tmp.back ());
			} else {
				tmp.resize (1, word);
			}

			ViewAsSequence_i::add_ (word, tmp, data);
		} else if (offset == req_str.size ()) {
			ViewAsSequence_i::add_ (req_str, *res, data);
		} else {
			ViewAsSequence_i::add_ (req_str.substr (0, offset - 1), *res, data);
		}
	}

	for (it = info.begin (); it != info.end (); ++it) {
		if (std::find (data.begin (), data.end (), *it) != data.end ()) {
			it->text.clear (); // избавл€емс€ от избыточных запросов
		}
	}

	info.insert (info.begin (), data.begin (), data.end ());

	if (info.size () > MAX_REQUEST_COUNT) {
		throw ExceededLimit ();
	}
	//#UC END# *53919E170029*
}

// модификаци€ списка синонимичных запросов
size_t ViewAsSequence_i::transform (
	RequestsInfo& info
	, const GCL::StrVector& data
	, const DBComm::PSDTemplates& templates
) {
	//#UC START# *53919DC90201*
	size_t ret = 0, i = 0, count = info.size ();

	for (; i < count && ret <= MAX_WORDS_COUNT; ++i) {
		ret += m_transformer->exclude (info [i].text, data, templates, false); // исключение стоп-слов
	}

	if (i != count) {
		info.erase (info.begin () + i, info.end ()); // усечение списка запросов
	}

	return ret;
	//#UC END# *53919DC90201*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Search::IRequestView
// создать
bool ViewAsSequence_i::build (const Search::Phrase& in, const Morpho::Def::StrStrMap& pseudo, const std::string& src) {
	//#UC START# *528CD00602B1_5390900700B2*
	GDS_ASSERT (in.empty () == false);

	bool was_exceeded_limit = false;

	RequestsInfo info;

	try {
		std::for_each (in.begin (), in.end () // синонимизаци€
			, boost::bind (&ViewAsSequence_i::mutate, this, _1, boost::ref (info))
		);
	} catch (ExceededLimit& ex) {
		was_exceeded_limit = true;
		LOG_I ((ex.what ()));
	} catch (...) {
		LOG_UEX (("%s: mutate", GDS_CURRENT_FUNCTION));
	}

	{
		std::sort (info.begin (), info.end ()); // сортировка по убыванию количества синонимичных замен

		RequestsInfo::iterator it = std::remove_if (info.begin (), info.end ()
			, boost::bind (&std::string::empty, boost::bind (&ReqData::text, _1))
		);

		info.erase (it, info.end ());
	}

	//print_info (info);

	// »сключение стоп-слов & формирование результирующего контейнера

	const GCL::StrVector& exl_data = m_communicator->get_exclude_data ();

	const DBComm::PSDTemplates fake;
	//const DBComm::PSDTemplates& templates = (ext_multiply)? m_communicator->get_templates () : fake;

	bool invalid_req_size = (this->transform (info, exl_data, fake) > MAX_WORDS_COUNT);

	GCL::StrSet ret;

	if (was_exceeded_limit || invalid_req_size) {
		std::string corrected = src;
		m_transformer->exclude (corrected,  exl_data, fake, false);
		ret.insert (corrected); // исходный исправленный запрос
	}

	for (RequestsInfo::iterator it = info.begin (); it != info.end (); ++it) {
		if (pseudo.empty () == false) {
			ContextUtility::replace (it->text, pseudo); // замен€ем псевдонормализованные формы на исходные
		}

		ret.insert (it->text);
	}

	m_sequence.reserve (ret.size ());

	std::for_each (ret.begin (), ret.end (), boost::bind (&ViewAsSequence_i::add_request, this, _1));

	return true;
	//#UC END# *528CD00602B1_5390900700B2*
}

// implemented method from Search::IRequestView
// список синонимичных
const Search::SplitRequests& ViewAsSequence_i::get_sequence () const {
	//#UC START# *5273997201A4_5390900700B2*
	return m_sequence;
	//#UC END# *5273997201A4_5390900700B2*
}

// implemented method from Search::IRequestView
// спаны
const Search::Phrases& ViewAsSequence_i::get_spans () const {
	//#UC START# *5273994602A8_5390900700B2*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *5273994602A8_5390900700B2*
}

// implemented method from Search::IRequestView
// тип
Search::AlgorithmSelector ViewAsSequence_i::get_type () const {
	//#UC START# *5280F02702AB_5390900700B2*
	return Search::as_Default;
	//#UC END# *5280F02702AB_5390900700B2*
}
} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

