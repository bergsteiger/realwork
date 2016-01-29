//
// Cache.h : header file
//

#ifndef __CONVERT_CACHE_H__
#define __CONVERT_CACHE_H__

#include "shared/Core/sys/std_inc.h"
#include "base.h"

namespace EndtConvertor {

	struct ObjInfo_ {
		std::string name;
		unsigned long type;

		ObjInfo_ () : type (0) { }
	};

	/////////////////////////////////////////////////////////////////////////////////////////////

	class Cache {
	public:
		Cache ();

	public:
		void init (const std::string& path);
		void load_editions (const std::string& path);
		void load_pics (const std::string& path);

		bool load_doc_info (Base* base, size_t pos);

	public:
		bool is_splash (long doc_id) const;
		short get_status (long doc_id) const;

		long get_active_redaction (long doc_id, short status);
		long get_active_redaction_ex (long doc_id);

		void get_blob_info (long obj_id, ObjInfo_& info);

		Base* get_base ();
		DocCollection* get_all_topics ();
		DocCollection* get_all_docs ();

	private:
		void load_edis ();
		void load_doc_info ();
		void load_splash_topics ();
		void load_blob_info ();
		void load_blob_info (unsigned long obj_id, ObjInfo_& info);

	public:
		typedef ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX>;

	private:
		typedef std::map <long, long> Editions;
		typedef std::map <long, short> DocStatus;
		typedef std::map <long, ObjInfo_> ObjInfo_map;

	private:
		Core::Mutex m_mutex;

		Editions m_editions;
		Editions m_editions_ext;

		DocStatus m_doc_status;
		ObjInfo_map m_obj_info;

		std::set <long> m_pics;
		std::vector <long> m_splashes;

		Core::Aptr <Base> m_base;
		Core::Aptr <DocCollection> m_topics;
	};

} // namespace

#endif // #ifndef __CONVERT_CACHE_H__