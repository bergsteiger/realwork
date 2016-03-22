
#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Morpho/Facade/Factory.h"

#include <fstream>

#include "ru_garant_SolrExtensions_MorphoAdapter.h"

static const std::string morpho_dll_name = "MLMA32RU";

Core::AutoInit init;

///////////////////////////////////////////////////////////////////////////////////////////

class Logger : public std::ofstream {
public:
	Logger (const char* file_name, std::ios_base::openmode mode = std::ios_base::app) 
		: std::ofstream (file_name, mode) {
	}

	virtual ~Logger () {
		std::ofstream::close ();
	}
};

///////////////////////////////////////////////////////////////////////////////////////////

typedef short (__stdcall *LEMMATIZE_IMPL) (
	const char*
	, unsigned short
	, char*
	, unsigned long*
	, char*
	, unsigned short
	, unsigned short
	, unsigned short
);

class MorphoAdapter_i :
	virtual public Morpho::Def::IMorphoAdapter
	, virtual public Core::RefCountObjectBase
{
public:
	MorphoAdapter_i (LEMMATIZE_IMPL ptr) : m_lemmatize_func_ptr (ptr)  {
	}

	virtual ~MorphoAdapter_i () {
	}

protected:
	virtual short lemmatize (const char* in, char* buf, size_t buf_len) {
		if (m_lemmatize_func_ptr) {
			return (*this->m_lemmatize_func_ptr)(in, 2, buf, 0, 0, (short)(buf_len & 0xFFFF), 0, 0);
		}
		return 0;
	}

	virtual short get_gramm (const char* in, char* out, unsigned short size) {
		throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	}
private:
	LEMMATIZE_IMPL m_lemmatize_func_ptr;
};

///////////////////////////////////////////////////////////////////////////////////////////

class MorphoAdapter {
public:
	MorphoAdapter () : m_handle (ACE_SHLIB_INVALID_HANDLE) {
	}

	~MorphoAdapter () {
		if (m_handle != ACE_SHLIB_INVALID_HANDLE) {
			ACE_OS::dlclose (m_handle);
		}
	}
public:
	void load (const char* path, bool is_ext) {
		if (m_handle == ACE_SHLIB_INVALID_HANDLE) {
			GUARD (m_mutex);

			if (m_handle == ACE_SHLIB_INVALID_HANDLE) {
				std::string mlma_path = path;

				if (*(mlma_path.rbegin ()) != '\\') {
					mlma_path += "\\";
				}

				mlma_path += morpho_dll_name;

				m_handle = ACE_OS::dlopen (mlma_path.c_str ());

				if (m_normalizer.is_nil ()) {
					Morpho::Def::IMorphoAdapter_var adapter = new MorphoAdapter_i (
						this->get_func_ptr <LEMMATIZE_IMPL> ("mlmaruLemmatize")
					);

					if (is_ext) {
						m_cache = Morpho::Factory::make_for_txt (path);
						m_cache->load (0);
					} 

					m_normalizer = Morpho::Factory::make (m_cache.in (), adapter.in ());
				}
			}
		}
	}

	GCL::StrSet* execute (const std::string& word) {
		return m_normalizer->execute (word, false);
	}

	const GCL::StrVector& get_simple_syns (const std::string& key) {
		if (m_cache.is_nil () == false) {
			//return m_cache->get_syns (key);
		}

		static const GCL::StrVector fake_ret;
		return fake_ret;
	}

private:
	template <typename T>
	T get_func_ptr (const char* name) {
		T ret = reinterpret_cast <T> (ACE_OS::dlsym (m_handle, ACE_TEXT (name)));
		if (!ret) {
			LOG_W (("%s: symbol '%s' not found", GDS_CURRENT_FUNCTION, name));
			throw std::exception ();
		}
		return ret;
	}

public:
	typedef ACE_Singleton <MorphoAdapter, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MorphoAdapter, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	Core::Mutex m_mutex;

	ACE_SHLIB_HANDLE m_handle;

	Morpho::Def::ICache_var m_cache;
	Morpho::Def::INormalizer_var m_normalizer;
};

///////////////////////////////////////////////////////////////////////////////////////////

JNIEXPORT void JNICALL Java_ru_garant_SolrExtensions_MorphoAdapter_init
(JNIEnv* env, jobject obj, jstring string) {
	const char* path = env->GetStringUTFChars (string, 0);

	std::string path_1251 = GCL::utf8_to_win1251 (path);

	env->ReleaseStringUTFChars (string, path);

	MorphoAdapter::Singleton::instance ()->load (path_1251.c_str (), false);
}

JNIEXPORT void JNICALL Java_ru_garant_SolrExtensions_MorphoAdapter_initEx
(JNIEnv* env, jobject obj, jstring string) {
	const char* path = env->GetStringUTFChars (string, 0);

	std::string path_1251 = GCL::utf8_to_win1251 (path);

	env->ReleaseStringUTFChars (string, path);

	MorphoAdapter::Singleton::instance ()->load (path_1251.c_str (), true);
}

JNIEXPORT jobjectArray JNICALL Java_ru_garant_SolrExtensions_MorphoAdapter_normalize
(JNIEnv* env, jobject obj, jstring string) {
	const char* str = env->GetStringUTFChars (string, 0);

	Core::Aptr <GCL::StrSet> res = MorphoAdapter::Singleton::instance ()->execute (
		GCL::utf8_to_win1251 (str)
	);

#ifdef _DEBUG
	std::cout << "\nlemmas: ";
	std::copy (res->begin (), res->end (), std::ostream_iterator <std::string> (std::cout, ", "));
#endif

	jobjectArray ret = (jobjectArray) env->NewObjectArray (
		(jsize) ((res->size ()) & 0xFFFF)
		, env->FindClass ("java/lang/String")
		, env->NewStringUTF ("")
	);

	std::string copy_str;

	jsize i = 0;

	for (GCL::StrSet::const_iterator it = res->begin (); it != res->end (); ++it, ++i) {
		copy_str = *it;
		GCL::to_lower (copy_str);

		env->SetObjectArrayElement (
			ret, i, env->NewStringUTF (GCL::win1251_to_utf8 (copy_str.c_str ()).c_str ())
		);
	}

	env->ReleaseStringUTFChars (string, str);
	return ret;
}

JNIEXPORT jobjectArray JNICALL Java_ru_garant_SolrExtensions_MorphoAdapter_getSSyns
(JNIEnv* env, jobject obj, jstring string) {
	const char* str = env->GetStringUTFChars (string, 0);

	std::string key = GCL::utf8_to_win1251 (str);

	GCL::to_upper (key);

	const GCL::StrVector& res = MorphoAdapter::Singleton::instance ()->get_simple_syns (key);

	jobjectArray ret = (jobjectArray) env->NewObjectArray (
		(jsize) ((res.size ()) & 0xFFFF)
		, env->FindClass ("java/lang/String")
		, env->NewStringUTF ("")
	);

	std::string copy_str;

	jsize i = 0;

	for (GCL::StrVector::const_iterator it = res.begin (); it != res.end (); ++it, ++i) {
		copy_str = *it;
		GCL::to_lower (copy_str);

		env->SetObjectArrayElement (
			ret, i, env->NewStringUTF (GCL::win1251_to_utf8 (copy_str.c_str ()).c_str ())
		);
	}

	env->ReleaseStringUTFChars (string, str);
	return ret;
}

