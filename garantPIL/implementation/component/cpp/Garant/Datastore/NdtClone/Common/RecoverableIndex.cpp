#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/RecoverableIndex.h"

namespace NdtClone {

void IgnoreRecovery::handle_recovery (const char* key_file, const char* stream_file) {
}

void ThrowRecovery::handle_recovery (const char* key_file, const char* stream_file) {
	throw RecoveredIndex (key_file + std::string (", ") + stream_file);
}

} // namespace 

