//
// ContextPartsHelper.h : header file
//

#ifndef __CONTEXT_PARTS_HELPER_H
#define __CONTEXT_PARTS_HELPER_H

#include <vector>

#include "boost/tuple/tuple.hpp"
#include "base.h"

class ContextPartsHelper {
public:
	typedef boost::tuple <long, std::string, std::string> PartInfo;

public:
	static void init (Base* base);
	static void fini ();

public:
	static bool is_parts ();

	static PartInfo get_info (const std::string& name);
	static const std::vector <long>& get_changed_docs ();

	static void get_context_parts_names (GCL::StrVector& out, bool with_editions);
	static void get_form_parts_names (GCL::StrVector& out, bool with_editions);

	static std::string get_pharm_context_index_name ();
	static std::string get_context_index_name (long doc_id);
	static std::string get_swords_index_name (long doc_id);
};

#endif // __CONTEXT_PARTS_HELPER_H
