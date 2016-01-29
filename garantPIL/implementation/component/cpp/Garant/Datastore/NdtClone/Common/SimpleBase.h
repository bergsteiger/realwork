#ifndef SIMPLE_BASE_H_
#define SIMPLE_BASE_H_

#include "shared/Core/GDS/ObjectCounter.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/RecoverableIndex.h"

// Note: ≈сли создаетс€ база с несколькими индексами, расположенными
//       в одной паре stream & key файлов, то база отвечает за синхронизацию
//       доступа к этим файлам. Ќ≈Ћ№«я одновременно из разных потоков
//       осуществл€ть операции над индексами, наход€щимис€ в одном файле!  

namespace NdtClone {

	extern const char *pBuckupFileExt;

template <short STORAGE_PAGE_SIZE, long VALID_VERSION>
class SimpleBase {
	SET_OBJECT_COUNTER (SimpleBase)
public:
	SimpleBase ()
		: m_key_file (0)
		, m_stream_file (0)
		, m_stream (0)
		, m_delete_files (false) {
	}

	virtual ~SimpleBase () {
		this->close ();
	}

	void delete_files_after_use () {
		m_delete_files = true;
	}

	std::pair <PagedFile*, StreamFile*> open (
		const std::string& key_file_name
		, const std::string& stream_file_name, bool bRW= true
	) {
		try {
			if(bRW){
				m_key_file = GetUpdatedPagedFile (key_file_name.c_str (), VALID_VERSION);
				if (!m_key_file->IsOk ()) {
					m_key_file->Create (STORAGE_PAGE_SIZE);
					if (!m_key_file->IsOk ()) {
						throw Error ();
					}
					m_stream = new StreamFile (m_stream_file, STORAGE_PAGE_SIZE);
					m_stream->Create ();
				} else {
					m_stream = new StreamFile (m_stream_file);
				}
			}else{
				m_key_file = GetReadOnlyPagedFile(key_file_name.c_str (), VALID_VERSION);
				m_stream_file = GetReadOnlyPagedFile(stream_file_name.c_str (), VALID_VERSION);
				m_stream = new StreamFile (m_stream_file);
			}
			m_key_file_name = key_file_name;
			m_stream_file_name = stream_file_name;
			return std::pair <PagedFile*, StreamFile*> (m_key_file, m_stream);
		} catch (...) {
			this->close ();
			throw;
		}		
	}

	void close () {
		delete m_stream;
		m_stream = 0;
		delete m_key_file;
		m_key_file = 0;
		if (m_delete_files) {
			{
				m_key_file = GetUpdatedPagedFile (m_key_file_name.c_str (), VALID_VERSION);
				if(m_key_file->IsOk())
					m_key_file->Remove();
				delete m_key_file;
			}
			m_stream_file = GetUpdatedPagedFile (m_stream_file_name.c_str (), VALID_VERSION);
			if(m_stream_file->IsOk())
				m_stream_file->Remove();
			delete m_stream_file;
		}
	}

private:
	PagedFile* m_key_file;
	PagedFile* m_stream_file;
	StreamFile* m_stream;

	bool m_delete_files;
	std::string m_key_file_name;
	std::string m_stream_file_name;
};

} // namespace

#endif // SIMPLE_BASE_H_




