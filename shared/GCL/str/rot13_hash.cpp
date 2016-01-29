#include "shared/GCL/str/rot13_hash.h"


namespace GCL {

unsigned long get_rot13_hash (const char* source) {
    unsigned long hash = 0;
    for(; *source; ++source) {
        hash += static_cast <unsigned char>(*source);
        hash -= (hash << 13) | (hash >> 19);
    }
    return hash;

}

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

