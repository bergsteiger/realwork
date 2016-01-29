#include "shared/Core/fix/mpcxc.h"
#include <sys/stat.h>
#include <stdlib.h>
#include <ctype.h>
#include <errno.h>
#include <stdio.h>

#include <fcntl.h>

#include <string.h>
//#include <unistd.h>
//#include <alloca.h>

#include "osdep.h"

/*
#if !defined (unix) && !defined(__MSVC__)
	#include <io.h>
#endif
*/

#define __PROFILE_C
#include "profile.h"

#define ERR_FILE_TOO_BIG 0x301
#define ERR_NO_PROFILE   0x302
#define ERR_NO_SECTION   0x303
#define ERR_NO_ENTRY     0x304
#define ERR_OUT_OF_MEM   0x101

u_int16_t errLastError;

static struct {
  char * lpszDefProfile;
  char * lpszProfile;
  char * lpszBuffer;
  u_int16_t cbSize;
  u_int16_t cbAlloc;
} pfli = { 0, 0, 0, 0, 0 };

static char buf[25];
static u_int16_t bInstalled = 0;

#undef isspace

static char * FindEntry(char * lpszSection, char * lpszEntry);
static char * FindSection(char * lpszSection);
static int UpdateEntry(char * lpentpos, char * lpszValue);
static int AddEntry(char * lpstpos, char * lpszEntry, char * lpszValue);
static int AddSection(char * lpszSection, char * lpszEntry, char * lpszValue);
static int LoadProfile(void);
static int DeleteEntry(char * lpszEntry);
extern off_t ace_os_filesize(int);

static void ProfilesCleanUp(void)
{
  if(pfli.lpszBuffer != 0) free(pfli.lpszBuffer);
  if(pfli.lpszDefProfile != 0) free(pfli.lpszDefProfile);
  if(pfli.lpszProfile != 0) free(pfli.lpszProfile);
}

int SetDefaultProfile(char * lpszProfile)
{
  char * lpszOld;
  int bLoaded;

  lpszOld = pfli.lpszDefProfile;
  pfli.lpszDefProfile = strdup(lpszProfile);
  if ( pfli.lpszProfile == 0 )
    pfli.lpszProfile = strdup(pfli.lpszDefProfile);
  if (pfli.lpszBuffer) {
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = 0;
    pfli.cbSize = 0;
    pfli.cbAlloc = 0;
  }
  bLoaded = LoadProfile();
  if (!bInstalled) {
    bInstalled = 1;
    atexit(ProfilesCleanUp);
  }
  if(lpszOld) free(lpszOld);
  return bLoaded;
}

int SetProfile(char * lpszProfile)
{
  char * lpszOld;
  int bLoaded;

  lpszOld = pfli.lpszProfile;
  if (lpszProfile == 0)
    pfli.lpszProfile = strdup(pfli.lpszDefProfile);
  else
    pfli.lpszProfile = strdup(lpszProfile);
  if (pfli.lpszBuffer) {
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = 0;
    pfli.cbSize = 0;
    pfli.cbAlloc = 0;
  }
  bLoaded = LoadProfile();
  if (!bInstalled) {
    bInstalled = 1;
    atexit(ProfilesCleanUp);
  }
  if ( lpszOld ) free(lpszOld);
  return bLoaded;
}

static int  LoadProfile()
{
  long fsize;
  int hProfile;

  if (pfli.lpszBuffer != 0) {
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = 0;
    pfli.cbSize = 0;
    pfli.cbAlloc = 0;
  }
  hProfile = ace_os_open(pfli.lpszProfile, ACE_OS_O_RDONLY | ACE_OS_O_TEXT);
  if (hProfile == -1) {
    errLastError = ERR_NO_PROFILE;
    return 0;
  }
  fsize = ace_os_filesize(hProfile);
  if (fsize == 0) {
    errLastError = ERR_NO_PROFILE;
    return 0;
  }
  if (fsize > 0xFE00) { // .ini file must be placed in one mem segment !
    errLastError = ERR_FILE_TOO_BIG;
    return 0;
  }
  pfli.cbAlloc = (int)fsize + 0x101;
  pfli.lpszBuffer = (char *)calloc(1, pfli.cbAlloc);
  pfli.cbSize = ace_os_read(hProfile, pfli.lpszBuffer, (int)fsize);
  ace_os_close(hProfile);
  memset(pfli.lpszBuffer+pfli.cbSize, 0, pfli.cbAlloc-pfli.cbSize);
  if ( pfli.lpszBuffer[pfli.cbSize-1] != '\n' )
    pfli.lpszBuffer[pfli.cbSize++] = '\n';
  return 1;
}

int ReadProfileString(char * lpszSection, char * lpszEntry, char * lpszBuf, u_int16_t cbSize)
{
  char * lpsz, *eol;

  if ( pfli.lpszBuffer == 0 ) {
    errLastError = ERR_NO_PROFILE;
    return 0;
  }
  if ( lpszSection == 0 ) return 0;
  if ((lpsz = FindSection(lpszSection)) == 0) { // Section not found
    errLastError = ERR_NO_SECTION;
    return 0;
  }
  if ( lpszEntry == 0 ) return 0;
  if ((lpsz=FindEntry(lpsz, lpszEntry)) == 0) { // Entry not found
    errLastError = ERR_NO_ENTRY;
    return 0;
  }
  lpsz = strchr(lpsz, '=') + 1;
  eol = strchr(lpsz, '\n'); // '\n' always exist
  *eol = '\0';
  strncpy(lpszBuf, lpsz, cbSize);
  *eol = '\n';
  return 1;
}

int ReadProfileInt(char * lpszSection, char * lpszEntry, int *value)
{
  if (!ReadProfileString(lpszSection, lpszEntry, buf, 24))
    return 0;
  *value = atoi(buf);
  return 1;
}

int ReadProfileLong(char * lpszSection, char * lpszEntry, long *value)
{
  if (!ReadProfileString(lpszSection, lpszEntry, buf, 24))
    return 0;
  *value = atol(buf);
  return 1;
}

int WriteProfileString(char * lpszSection, char * lpszEntry, char * lpszValue)
{
  char * sect, *entry;
  int hProfile;

  if (pfli.lpszBuffer == 0) { // Assume that profile does not exist
    if(lpszSection == 0 || (lpszEntry == 0 && lpszValue == 0))
      return 0;
    pfli.cbAlloc = strlen(lpszSection) + strlen(lpszEntry) + strlen(lpszValue) + 0x107;
    pfli.lpszBuffer = (char *)calloc(1, pfli.cbAlloc);
  }
  hProfile = ace_os_open(pfli.lpszProfile, ACE_OS_O_WRONLY | ACE_OS_O_TEXT | ACE_OS_O_TRUNC | ACE_OS_O_CREAT, S_IREAD | S_IWRITE);
  if (hProfile == -1) {
    errLastError = ERR_NO_PROFILE;
    return 0;
  }
  if(!(lpszSection && lpszEntry)) return 0; // Deleting sect/entr not implemented
  if ( (sect = FindSection(lpszSection)) != 0) {
    entry = FindEntry(sect, lpszEntry);
  }
  else entry = 0;
  if (sect == 0)
    AddSection(lpszSection, lpszEntry, lpszValue);
  else if (entry != 0) {
    if (lpszValue == 0) DeleteEntry(entry);
    else UpdateEntry(entry, lpszValue);
  }
  else if (lpszValue != 0) AddEntry(sect, lpszEntry, lpszValue);
  ace_os_write(hProfile, pfli.lpszBuffer, pfli.cbSize);
  ace_os_close(hProfile);
  return 1;
}

int WriteProfileInt(char * lpszSection, char * lpszEntry, int value)
{
  sprintf(buf,"%d",value);
  return WriteProfileString(lpszSection, lpszEntry, buf);
}

int WriteProfileLong(char * lpszSection, char * lpszEntry, long value)
{
  sprintf(buf,"%ld",value);
  return WriteProfileString(lpszSection, lpszEntry, buf);
}

static char *  FindSection(char * lpszSection)
{
  char * lpsz, *eol, *eos;
  int notmatch;

  lpsz = pfli.lpszBuffer;
  while (*lpsz) { // Until buffer ends
    while(isspace(*lpsz)) lpsz++;
    if (*lpsz != '[') // Not the section line
      lpsz = strchr(lpsz, '\n')+1;
    else { // Section Begins
      eol = strchr(lpsz, '\n'); // eol != 0 due to adding \n to end of file if it's absent
      *eol = '\0';
      if ((eos = strchr(lpsz, ']')) == 0) {
        *eol = '\n';
        return 0;
      }
      *eos = '\0';
      notmatch = strcmp(lpszSection, ++lpsz); // or stricmp for ignore case
      *eos = ']';
      *eol = '\n';
      lpsz = eol+1;
      if (!notmatch) return lpsz; // Target section found!
    }
  }
  return 0; // We come here only if EOF reached : section not found
}

static char *  FindEntry(char * lpszSection, char * lpszEntry)
{
  char * lpsz=lpszSection, *eos;
  int notmatch;

  while(*lpsz) {
    while(isspace(*lpsz)) lpsz++;
    switch ( *lpsz ) {
      case '[' : // Next section
      case '\0': // EOF
        return 0;
      case ';' : // Comment
        lpsz = strchr(lpsz, '\n');
      case '\n': // Empty line
        lpsz++;
        break;
      default  : // Any string that may be entry
        if ((eos = strchr(lpsz, '=')) != 0) { // Entry line : '=' present
          *eos = '\0';
          notmatch = strcmp(lpsz, lpszEntry); // or stricmp for ignore case
          *eos++ = '=';
          if (!notmatch) return lpsz; // Entry found
        }
        lpsz = strchr(lpsz, '\n') + 1;
        break;
    }
  }
  return 0;
}

static int  AddSection(char * lpszSection, char * lpszEntry, char * lpszValue)
{
  int sl, el, vl, len;
  char * lpsz, *eol;

  sl = strlen(lpszSection);
  el = strlen(lpszEntry);
  vl = strlen(lpszValue);
  len = el + sl + vl + 6;
  if (pfli.cbAlloc < pfli.cbSize+len) {
    lpsz = (char *)calloc(1, pfli.cbSize+len+0x101);
    if ( lpsz == 0 ) {
      errLastError = ERR_OUT_OF_MEM;
      errno = ENOMEM;
      return 0;
    }
    strcpy(lpsz, pfli.lpszBuffer);
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = lpsz;
    pfli.cbAlloc = pfli.cbSize + len + 0x101;
  }
  eol = pfli.lpszBuffer + pfli.cbSize;
  pfli.cbSize += len;
  *eol++ = '\n';
  *eol++ = '['; strcpy(eol, lpszSection);
  eol += sl; *eol++ = ']'; *eol++ = '\n';
  strcpy(eol, lpszEntry); eol += el; *eol++ = '=';
  strcpy(eol, lpszValue); eol += vl; *eol = '\n';
  return 1;
}

static int  AddEntry(char * lpszpos, char * lpszEntry, char * lpszValue)
{
  int len, el, vl, offs;
  char * lpsz;

  el = strlen(lpszEntry);
  vl = strlen(lpszValue);
  len = el + vl + 2;
  offs = lpszpos - pfli.lpszBuffer;
  if (pfli.cbSize+len > pfli.cbAlloc) {
    lpsz = (char *)calloc(1, pfli.cbSize+len+0x101);
    if(lpsz) pfli.cbAlloc = pfli.cbSize+len+0x101;
    else {
      errLastError = ERR_OUT_OF_MEM;
      errno = ENOMEM;
      return 0;
    }
    strncpy(lpsz, pfli.lpszBuffer, offs);
    lpszpos = lpsz+offs;
    strcpy(lpszpos, lpszEntry);
    lpszpos += el; *lpszpos++ = '=';
    strcpy(lpszpos, lpszValue);
    lpszpos += vl;
    *lpszpos++ = '\n';
    strcpy(lpszpos, pfli.lpszBuffer+offs);
    pfli.cbSize += len;
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = lpsz;
    return 1;
  }
  else {
    memmove(lpszpos + len, lpszpos, pfli.cbSize-offs);
    strcpy(lpszpos, lpszEntry); lpszpos += el; *lpszpos++ = '=';
    strcpy(lpszpos, lpszValue); lpszpos += vl; *lpszpos = '\n';
  }
  pfli.cbSize += len;
  return 1;
}

static int  UpdateEntry(char * lpentpos, char * lpszValue)
{
  int ol, nl, tl, entoffs;
  char * lpsz, *eol;

  lpentpos = strchr(lpentpos, '=') + 1;
  nl = strlen(lpszValue);
  eol = strchr(lpentpos, '\n');
  ol = (int)((long)eol - (long)lpentpos);
  tl = pfli.cbSize - (int)((long)eol - (long)pfli.lpszBuffer);
  entoffs = (int)((long)lpentpos - (long)pfli.lpszBuffer);
  if ( ol > nl ) {
    memmove(lpentpos+nl, eol, tl);
    strncpy(lpentpos, lpszValue, nl);
    pfli.cbSize -= ol - nl;
    memset(pfli.lpszBuffer+pfli.cbSize, 0, ol-nl);
  }
  else {
    if (pfli.cbSize+nl-ol+1 > pfli.cbAlloc) {
      lpsz = (char *)calloc(1, pfli.cbSize+(nl-ol)+0x101);
      if(lpsz == 0) {
        errLastError = ERR_OUT_OF_MEM;
        errno = ENOMEM;
        return 0;
      }
      lpentpos = lpsz+entoffs;
      strncpy(lpsz, pfli.lpszBuffer, entoffs); // copy unchanged file part
      strncpy(lpentpos, lpszValue, nl); // copy new value
      strcpy(lpentpos+nl, eol); // copy unchanged file tail
      pfli.cbAlloc = pfli.cbSize + (nl-ol) + 0x101;
      free(pfli.lpszBuffer);
      pfli.lpszBuffer = lpsz;
    }
    else {
      memmove(eol+(nl-ol), eol, tl); // shift the tail of file to place new value
      strncpy(lpentpos, lpszValue, nl); //place new value
    }
    pfli.cbSize += nl-ol;
  }
  return 1;
}

static int  DeleteEntry(char * lpszEntry)
{
  int tl, offs, len;
  char * eol;

  eol = strchr(lpszEntry, '\n');
  offs = (int)((long)lpszEntry - (long)pfli.lpszBuffer);
  len = (int)((long)eol - (long)lpszEntry) + 1;
  tl = pfli.cbSize - offs - len;
  memmove(lpszEntry + len, lpszEntry, tl);
  pfli.cbSize -= len;
  memset(pfli.lpszBuffer+pfli.cbSize, 0, len);
  return 1;
}












