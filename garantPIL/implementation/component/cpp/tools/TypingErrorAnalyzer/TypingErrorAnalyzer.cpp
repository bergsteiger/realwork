//
// TypingErrorAnalyzer.cpp : implementation file
//

#include "ace/ACE.h"

#include <iterator>
#include <fstream>

#include "garantPIL/implementation/component/cpp/libs/endt/Common.h"

#include "WordFinder.h"
#include "TypingErrorAnalyzer.h"

namespace TypingErrorAnalyze {

const long REF_DOC_ID = 3100000; // максимальная длина слова

TypingErrorAnalyzer::TypingErrorAnalyzer (const std::string& path) {
	m_base = new ToolsBase (path);
}

TypingErrorAnalyzer::~TypingErrorAnalyzer () {
}

void TypingErrorAnalyzer::execute (const std::string& out) {
	Core::Aptr <DocCollection> topics = m_base->AllDocs ();

	EndtTools::ProcessIndicator indicator ("start process ");
	indicator.init (topics->ItemCount);
	indicator.start ();

	GDS_ASSERT (topics.is_nil () == false);

	size_t topics_count = (size_t) topics->ItemCount;

	long doc_id = 0, refs_count = 0, para_count = 0;

	GCL::StrSet words;

	IndexLoader loader (m_base.in ());

	std::ofstream ofs (out.c_str (), std::ios_base::trunc);

	for (size_t i = 0; i < topics_count; ++i) {
		doc_id = (*topics)[i];

		indicator.update_ (i);

		INDEX_DATA (RespRef) refs = loader.load <RespRef> (doc_id, IDD_REFS, refs_count);

		if (refs_count) {
			words.clear ();

			WordFinder finder (m_base.in ());

			const RespRef* data = refs.ptr ();

			for (long j = 0; j < refs_count; ++j) {
				const RespRef& ref = data [j];

				if (ref.DocId == REF_DOC_ID) {
					try {
						INDEX_DATA (long) ids = loader.load <long> (doc_id, IDD2_PARAIDS, para_count);

						if (para_count) {
							const long* loc = std::find (ids.in (), ids.in () + para_count, ref.ParaId);

							if (loc != ids.in () + para_count) {
								std::string str = finder.execute (doc_id, loc - ids.in (), ref.Offset);

								if (str.empty () == false) {
									words.insert (str);
								}
							}
						}
					} catch (...) {
						LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
					}
				}
			}

			if (words.empty () == false) {
				ofs << doc_id << ": ";
				std::copy (words.begin (), words.end (), std::ostream_iterator <std::string> (ofs, ","));
				ofs << std::endl;
			}
		}
	}

	ofs.close ();
}

}

