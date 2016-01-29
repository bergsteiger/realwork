////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "EntryPointAnalyzer.h"

#ifndef __ENTRY_POINT_ANALYZER_H__
#define __ENTRY_POINT_ANALYZER_H__

#include "SearchB.h"

namespace EntryPointAnalyze {

	static const size_t MIN_RATE = 1;        // минимальная частотность
	static const size_t MAX_REFS_COUNT = 3;  // максимальное количество cохраняемых ссылок
	static const size_t MAX_DOCS_COUNT = 50; // количество обрабатываемых документов

	//////////////////////////////////////////////////////////////////////////////////////////////

	enum RateType {rt_None, rt_Absolute, rt_Relative};

	struct Properties {
		size_t count;     // количество обрабатываемых документов
		size_t min_rate;  // минимальная частотность
		size_t ref_count; // максимальное количество cохраняемых ссылок

		std::string in;   // путь к файлу с исходными данными
		std::string out;  // путь к файлу с результатом

		RateType type;

		Properties () 
			: count (MAX_DOCS_COUNT)
			, min_rate (MIN_RATE)
			, ref_count (MAX_REFS_COUNT) 
			, type (rt_None) {
		}
	};

	//////////////////////////////////////////////////////////////////////////////////////////////

	class EntryPointAnalyzer {
	public:
		EntryPointAnalyzer (const std::string& path);

		virtual ~EntryPointAnalyzer ();

	public:
		void execute (const Properties& properties);

	private:
		// Ссылка и значения частотности
		struct RRef {
			Ref ref;
			size_t rate;     // абсолютная частота
			size_t rel_rate; // относительная частота

			RRef ();

			bool operator == (const RRef& val) const;
		};

		typedef std::vector <RRef> RefVector;
		typedef std::vector <long> DocVector;

		// Предикат сравнения ссылок по частотности
		struct CompareByRate : public std::binary_function <std::string, std::string, bool> {
			bool operator () (const RRef& first_, const RRef& second_) const;
		};

		// Функтор вычисления относительной частотности
		struct CalcRelativeRate : public std::unary_function <RefVector, void> {
			CalcRelativeRate (Index* corr_index);

			void operator () (RRef& param_) const;

		private:
			Index* m_index;
		};

	private:
		void execute (const std::string& req_str, size_t count, RefVector& ref_vector);
		void execute (const RefwRele& item, RefVector& ref_vector, bool& has_rate);
		void load_abolished ();

	private:
		Core::Aptr <ToolsBase> m_base;

		IndexReq* m_request;

		DocVector m_abolished_docs;
	};

} // namespace EntryPointAnalyze

#endif //__ENTRY_POINT_ANALYZER_H__
