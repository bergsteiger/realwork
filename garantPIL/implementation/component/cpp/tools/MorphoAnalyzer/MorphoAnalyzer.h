////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "MorphoAnalyzer.h"

#ifndef __MORPHO_ANALYZER_H__
#define __MORPHO_ANALYZER_H__

#include <fstream>

#include "shared/Morpho/Facade/Factory.h"

namespace MorphoAnalyze {

	struct Properties {
		std::string in;  // путь к файлу с исходными данными
		std::string out; // путь к файлу с результатом
	};

	//////////////////////////////////////////////////////////////////////////////////////////////

	class MorphoAnalyzer {
	public:
		MorphoAnalyzer (const std::string& path);

		virtual ~MorphoAnalyzer ();

	public:
		void execute (const Properties& properties);

	private:
		void out (const std::string& norma, const std::string& req, const Morpho::Def::AnalysisInfo& info);

	private:
		std::ofstream m_ofs;

		Morpho::Def::INormalizer_var m_normalizer;
	};

} // namespace MorphoAnalyze

#endif //__MORPHO_ANALYZER_H__
