////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "PairsBuilder.h"

#ifndef __PAIRS_BUILDER_H__
#define __PAIRS_BUILDER_H__

#include "SearchB.h"

namespace ConnectedContexts {

	using namespace ContextSearch;

	typedef std::pair <std::string, std::string> SynPair;
	typedef std::vector <SynPair> Dict;

	typedef std::map <std::string, GCL::StrSet> ConContexts;

	struct Properties {
		std::string in;  // путь к файлу с исходными данными
		std::string out; // путь к файлу с результатом
	};

	class PairsBuilder {
	public:
		PairsBuilder (const std::string& path);

		virtual ~PairsBuilder ();

	public:
		void execute (const Properties& properties);

	private:
		void build_dict (const std::string& path);
		void find_contexts (const SynPair& val, ConContexts& out);
		void get_syns (const std::string& req, GCL::StrVector& out, Manage::IQuery* query);

	private:
		Dict m_dict;

		Manage::Env m_env;

		Core::Aptr <ToolsBase> m_base;
		Morpho::Def::INormalizer_var m_normalizer;
	};

} // namespace InformersDictionary

#endif //__PAIRS_BUILDER_H__
