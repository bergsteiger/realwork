//
// decompile.h : header file
//

#ifndef __DECOMPILE_H
#define __DECOMPILE_H

#include "shared/Core/mng/Var.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

#include "stdbase.h"

class Decompile {
public:
	typedef Core::Aptr <Document> Document_aptr;

public:
	Decompile (Base* base, bool is_full) 
		: m_base (base)
		, m_here (0)
		, m_here_count (0)
		, m_is_full (is_full) 
	{
		m_parser = new EndtTools::EndtParser (base);
		m_parser->log_activate ("nsrc_generator.log");
	}

	~Decompile () {
		if (m_here) {
			delete [] m_here;
			m_here = 0;
		}
	}

	void decompile_documents (const char* dir, long from_doc = 0);
	void decompile_blobs (const char* dir);
	void load_here ();

protected:
	Document* open_evd_document (const long doc_id, const DocInfo* info = 0);
	bool check_here (Document* doc);

private:
	Base* m_base;
	bool m_is_full;

	size_t m_here_count;
	short* m_here;

	Core::Aptr <EndtTools::EndtParser> m_parser;
};

#endif	// __NSRCWRITER_H
