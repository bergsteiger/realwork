//
// MorphoAnalyzer.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/bind.hpp"

#include "MorphoAnalyzer.h"
#include "ROCBase.h"
#include "DBComm.h"

namespace MorphoAnalyze {

MorphoAnalyzer::MorphoAnalyzer (const std::string& path) {
	Core::Aptr <CachedBaseRO> base = new CachedBaseRO (path.c_str ());
	GDS_ASSERT (base->IsOk () && base->check_version ());

	DBCore::IBase_var _base = DBCore::DBFactory::make (base.in ());

	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (_base.in ());

	m_normalizer = Morpho::Factory::make (cache.in ());
}

MorphoAnalyzer::~MorphoAnalyzer () {
}

void MorphoAnalyzer::execute (const Properties& properties) {
	std::string str;

	std::ifstream ifs (properties.in.c_str ());

	if (ifs) {
		m_ofs.open (properties.out.c_str (), std::ios_base::trunc);

		if (m_ofs) {
			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () || str [0] == ';') {
					continue;
				}

				std::cout << str << std::endl;

				try {
					Core::Aptr <GCL::StrSet> res = m_normalizer->execute (str, false);

					const Morpho::Def::AnalysisInfo& info = m_normalizer->get_info ();

					std::for_each (res->begin (), res->end ()
						, boost::bind (&MorphoAnalyzer::out, this, _1
						, boost::cref (str)
						, boost::cref (info))
					);
				} catch (...) {
					LOG_E (("%s: normalizer execute", GDS_CURRENT_FUNCTION));
				}
			}

			m_ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
		}
		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.in.c_str ()));
	}
}

void MorphoAnalyzer::out (
	const std::string& norma
	, const std::string& req
	, const Morpho::Def::AnalysisInfo& info
) {
	m_ofs << req <<";" << norma << ";";

	if (info.is_pseudo) {
		m_ofs << "P;";
	} else {
		m_ofs << "N;";
	}

	switch (info.kind) {
		case Morpho::Def::ak_Morpho:
			m_ofs << "M";
			break;
		case Morpho::Def::ak_Prefix:
			m_ofs << "P";
			break;
		case Morpho::Def::ak_Postfix:
			m_ofs << "O";
			break;
		case Morpho::Def::ak_NPseudo:
			m_ofs << "NP";
			break;
		case Morpho::Def::ak_Pseudo:
			m_ofs << "SP";
			break;
		case Morpho::Def::ak_Unknown:
			m_ofs << "U";
			break;
	}

	m_ofs << std::endl;
}

}