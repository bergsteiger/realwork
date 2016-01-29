#ifndef __PROFILE_H
#define __PROFILE_H

#ifndef __BTYPES_H
/* #include "btypes.h" */
#endif // __BTYPES_H

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __PROFILE_C
extern int SetProfile         (char * lpszProfile);
extern int SetDefaultProfile  (char * lpszProfile);

extern int  ReadProfileString  (char * lpszSection, char * lpszEntry, char * lpszBuf, short cbSize);
extern int  ReadProfileInt     (char * lpszSection, char * lpszEntry, int *value);
extern int  ReadProfileLong     (char * lpszSection, char * lpszEntry, long *value);

extern int  WriteProfileString (char * lpszSection, char * lpszEntry, char * lpszValue);
extern int  WriteProfileInt    (char * lpszSection, char * lpszEntry, int value);
extern int  WriteProfileLong   (char * lpszSection, char * lpszEntry, long value);
#endif

#ifdef __cplusplus
}
#endif

#endif // __PROFILE_H

