#ifndef RECOVERABLE_INDEX_H_
#define RECOVERABLE_INDEX_H_

#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/index.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/exceptions.h"

namespace NdtClone {

struct IgnoreRecovery {
	static void handle_recovery (const char* key_file, const char* stream_file);
};

struct ThrowRecovery {
	static void handle_recovery (const char* key_file, const char* stream_file);
};

template<typename RecoveryPolicy>
class RecoverableIndex : public Index {
public:	
	RecoverableIndex (
		PagedFile* paged_file
		, const char* name
		, StreamFile* stream_file
		, short key_size
		, short rndv                 // <-- это маги€, про нее даже ярослав не знает 
		, int stream_count
	) : Index (paged_file, name, stream_file) {

		if (Root == -1) {
			try {
				this->Create (key_size, rndv, stream_count);
			} catch (...) {
				throw Error ();
			}
		} else if (!this->KeyCount) {
			;//RecoveryPolicy::handle_recovery (streams->pKfile->FileName, streams->file->FileName);
		}
	}
};

} // namespace 

#endif // RECOVERABLE_INDEX_H_




