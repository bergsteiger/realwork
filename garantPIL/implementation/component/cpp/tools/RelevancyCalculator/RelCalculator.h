////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "RelCalculator.h"

#ifndef __RELEVANCY_CALCULATOR_H__
#define __RELEVANCY_CALCULATOR_H__

#include <fstream>

#include "shared/ContextSearch/Defs/Defs.h"

#include "garantCore/Search/Facade/Factory.h"

#include "ROCBase.h"

namespace RelCalculate {

	using namespace ContextSearch;

	struct OutProp {
		bool out_pos;
		bool out_label;

		OutProp () : out_pos (false), out_label (false) {
		}

		OutProp& operator = (const OutProp& copy) {
			out_pos = copy.out_pos;
			out_label = copy.out_label;
			return *this;
		}
	};

	struct Properties {
		std::string in;        // путь к файлу с исходными данными
		std::string out;       // путь к файлу с результатом
		std::string docs_path; // путь к файлу cо списком документов

		size_t req_count;

		bool in_details;

		OutProp out_prop;

		Properties () : req_count (0), in_details (false) {
		}
	};

	//////////////////////////////////////////////////////////////////////////////////////////////

	class RelCalculator {
	public:
		RelCalculator (const std::string& path);

		virtual ~RelCalculator ();

	public:
		void execute (const Properties& properties);

	private:
		void search (const std::string& req_str);

		long find_sub_or_block_with_word (long doc_id, long word);

		void out (Defs::DetailInfo& data, size_t req_count, bool in_detail);
		void out_info (const std::string& req, long doc_id, long pos);
		void out_detail (const Defs::Detail& data);
		void out (const Defs::Detail& data);

	private:
		std::ofstream m_ofs;
		std::string m_header;
		std::string m_request;

		Core::Aptr <CachedBaseRO> m_base;
		Core::Aptr <DocCollection> m_docs;

		Search::SearchProp m_prop;
		Search::ISearcher_var m_searcher;

		Defs::IRelevancyInfo_var m_info;

		size_t m_count;

		OutProp m_out_prop;
	};

} // namespace RelCalculate

#endif //__RELEVANCY_CALCULATOR_H__
