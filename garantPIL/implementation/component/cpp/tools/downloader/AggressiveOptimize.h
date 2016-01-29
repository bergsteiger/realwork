//
// AggressiveOptimize.h 
//

#if !defined __AGGRESSIVEOPTIMIZE_H
#define __AGGRESSIVEOPTIMIZE_H

/*
#ifdef NDEBUG
// /Og (global optimizations), /Os (favor small code), /Oy (no frame pointers)
#pragma optimize("gsy",on)

#pragma comment(linker,"/RELEASE")
#pragma comment(linker,"/merge:.rdata=.data")
#pragma comment(linker,"/merge:.text=.data")
#pragma comment(linker,"/merge:.reloc=.data")

#if _MSC_VER >= 1000
// Only supported/needed with VC6; VC5 already does 0x200 for release builds.
// Totally undocumented! And if you set it lower than 512 bytes, the program crashes.
// Either leave at 0x200 or 0x1000
#pragma comment(linker,"/FILEALIGN:0x200")
#endif // _MSC_VER >= 1000
#endif
*/

#endif // !defined(__AGGRESSIVEOPTIMIZE_H)