//
// CheckData.cpp : implementation file
//

#include "ace/ACE.h"

#include "common/components/rtl/Garant/EVD/eeReader.h"

#include "Log.h"
#include "CheckData.h"
#include "DocAnalyzer_i.h"

namespace Compiler {

struct Dumper {
	static void dump (const char* file_name, const GCL::StrSet& in) {
		FILE* file = mpcxc_fopen (file_name, "a");
		for (GCL::StrSet::const_iterator it = in.begin (); it != in.end (); ++it) {
			ACE_OS::fprintf (file, "%s\n", it->c_str ());
		}
		ACE_OS::fclose (file);
	}

	static void dump (const char* file_name, const StrIntMap& in) {
		FILE* file = mpcxc_fopen (file_name, "a");
		for (StrIntMap::const_iterator it = in.begin (); it != in.end (); ++it) {
			ACE_OS::fprintf (file, "%s, %d\n", it->first.c_str (), it->second);
		}
		ACE_OS::fclose (file);
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////

CompileInfo::CompileInfo () {
}

CompileInfo::~CompileInfo () {
}

void CompileInfo::init (const ConfigData& data) {
	TextFileParser parser;

	parser.parse (data.cat_file.c_str (), m_source);

	parser.parse_belongs (data.belong_file.c_str (), m_belongs);

	///////////////////////////////////////////////////////
	//Dumper::dump ("C:\\Compiler\\src.txt", m_source);
	//Dumper::dump ("C:\\Compiler\\belongs.txt", m_belongs);
	///////////////////////////////////////////////////////
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

Checker::Checker () {
}

Checker::~Checker () {
}

void Checker::execute (const CompileInfo& data) {
	//for(Pix i= tcinfo.Sources->first(), belong; i; tcinfo.Sources->next(i) ) {}
	//LogSingleton::instance ()->out_e (cp_Koi, "Не могу открыть файл '%s'\n", "xxx");

	const GCL::StrSet& sources = data.get_sources ();

	for (GCL::StrSet::const_iterator it = sources.begin (); it != sources.end (); ++it) {
		this->check_doc (it->c_str ());
	}
}

void Checker::check_doc (const char* file_name) {
	int m_handle = ace_os_open (file_name, O_RDONLY | O_BINARY);

	try {
		if (m_handle != -1) {
			long file_size = ace_os_filesize (m_handle);

			if (file_size > 0) {
				Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buffer = new char [file_size + 1];

				int size = ace_os_read (m_handle, buffer.inout (), file_size);

				ace_os_close (m_handle);

				if (size > 0) {
					(buffer.ptr ()) [size] = '\0';

					//this->check_doc (buffer.in (), (size_t) size);
				}
			}
		}
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
	}
}

void Checker::check_doc (const char* buffer, size_t size) {
	//evd::IeeGenerator_var generator = new DocAnalyzer_i (m_endt_writer.in (), size);

	evd::IeeGenerator_var generator = new DocAnalyzer_i (0, size);

	generator->Start ();
	{
		try {
			evd::EvdReader_var reader = new evd::EvdReader (buffer, size, generator.in ());
			reader->convert ();
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		}
	}
	generator->Finish ();
}

}


