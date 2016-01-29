#include "shared/Core/fix/mpcxc.h"
//#include <sys/stat.h> // GARANT_GCC
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <errno.h>

//#include <fcntl.h> // GARANT_GCC

#include "gdbapi.h"

#define ERR_FILE_TOO_BIG 0x301
#define ERR_NO_PROFILE   0x302
#define ERR_NO_SECTION   0x303
#define ERR_NO_ENTRY     0x304
#define ERR_OUT_OF_MEM   0x101

#define TRUE 1 // GARANT_GCC no bool keyword in C (C++ only)
#define FALSE 0

u_int16_t errLastError;

static struct {
  char * lpszDefProfile;
  char * lpszProfile;
  char * lpszBuffer;
  u_int16_t cbSize;
  u_int16_t cbAlloc;
} pfli = { NULL, NULL, NULL, 0, 0 };

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

static void ProfilesCleanUp(void)
{
  if(pfli.lpszBuffer != NULL) free(pfli.lpszBuffer);
  if(pfli.lpszDefProfile != NULL) free(pfli.lpszDefProfile);
  if(pfli.lpszProfile != NULL) free(pfli.lpszProfile);
}

int SetDefaultProfile(char * lpszProfile)
{
  char * lpszOld;
  int bLoaded;

  lpszOld = pfli.lpszDefProfile;
  pfli.lpszDefProfile = strdup(lpszProfile);
  if ( pfli.lpszProfile == NULL )
    pfli.lpszProfile = strdup(pfli.lpszDefProfile);
  if (pfli.lpszBuffer) {
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = NULL;
    pfli.cbSize = 0;
    pfli.cbAlloc = 0;
  }
  bLoaded = LoadProfile();
  if (!bInstalled) {
    bInstalled = TRUE;
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
  if (lpszProfile == NULL)
    pfli.lpszProfile = strdup(pfli.lpszDefProfile);
  else
    pfli.lpszProfile = strdup(lpszProfile);
  if (pfli.lpszBuffer) {
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = NULL;
    pfli.cbSize = 0;
    pfli.cbAlloc = 0;
  }
  bLoaded = LoadProfile();
  if (!bInstalled) {
    bInstalled = TRUE;
    atexit(ProfilesCleanUp);
  }
  if ( lpszOld ) free(lpszOld);
  return bLoaded;
}

static int  LoadProfile()
{
  long fsize;
  int hProfile;

  if (pfli.lpszBuffer != NULL) {
    free(pfli.lpszBuffer);
    pfli.lpszBuffer = NULL;
    pfli.cbSize = 0;
    pfli.cbAlloc = 0;
  }
  hProfile = ace_os_open(pfli.lpszProfile, ACE_OS_O_RDONLY | ACE_OS_O_TEXT);
  if (hProfile == -1) {
    errLastError = ERR_NO_PROFILE;
    return FALSE;
  }
  fsize = filelength(hProfile);
  if (fsize == 0) {
    errLastError = ERR_NO_PROFILE;
    return FALSE;
  }
  if (fsize > 0xFE00) { // .ini file must be placed in one mem segment !
    errLastError = ERR_FILE_TOO_BIG;
    return FALSE;
  }
  pfli.cbAlloc = (int)fsize + 0x101;

  pfli.lpszBuffer = (char *)ml_calloc(1, pfli.cbAlloc);

  pfli.cbSize = ace_os_read(hProfile, pfli.lpszBuffer, (int)fsize);
  ace_os_close(hProfile);
  memset(pfli.lpszBuffer+pfli.cbSize, 0, pfli.cbAlloc-pfli.cbSize);
  if ( pfli.lpszBuffer[pfli.cbSize-1] != '\n' )
    pfli.lpszBuffer[pfli.cbSize++] = '\n';
  return TRUE;
}

int ReadProfileString(char * lpszSection, char * lpszEntry, char * lpszBuf, u_int16_t cbSize)
{
  char * lpsz, *eol;

  if ( pfli.lpszBuffer == NULL ) {
    errLastError = ERR_NO_PROFILE;
    return FALSE;
  }
  if ( lpszSection == NULL ) return FALSE;
  if ((lpsz = FindSection(lpszSection)) == NULL) { // Section not found
    errLastError = ERR_NO_SECTION;
    return FALSE;
  }
  if ( lpszEntry == NULL ) return FALSE;
  if ((lpsz=FindEntry(lpsz, lpszEntry)) == NULL) { // Entry not found
    errLastError = ERR_NO_ENTRY;
    return FALSE;
  }
  lpsz = strchr(lpsz, '=') + 1;
  eol = strchr(lpsz, '\n'); // '\n' always exist
  *eol = '\0';
  strncpy(lpszBuf, lpsz, cbSize);
  *eol = '\n';
  return TRUE;
}

int ReadProfileInt(char * lpszSection, char * lpszEntry, int *value)
{
  if (!ReadProfileString(lpszSection, lpszEntry, buf, 24))
    return FALSE;
  *value = atoi(buf);
  return TRUE;
}

int ReadProfileLong(char * lpszSection, char * lpszEntry, long *value)
{
  if (!ReadProfileString(lpszSection, lpszEntry, buf, 24))
    return FALSE;
  *value = atol(buf);
  return TRUE;
}

int WriteProfileString(char * lpszSection, char * lpszEntry, char * lpszValue)
{
  char * sect, *entry;
  int hProfile;

  if (pfli.lpszBuffer == NULL) { // Assume that profile does not exist
    if(lpszSection == NULL || (lpszEntry == NULL && lpszValue == NULL))
      return FALSE;
    pfli.cbAlloc = strlen(lpszSection) + strlen(lpszEntry) + strlen(lpszValue) + 0x107;
    pfli.lpszBuffer = (char *)ml_calloc(1, pfli.cbAlloc);
  }
  hProfile = ace_os_open(pfli.lpszProfile, ACE_OS_O_WRONLY | ACE_OS_O_TEXT | ACE_OS_O_TRUNC | ACE_OS_O_CREAT); // GARANT_GCC
  if (hProfile == -1) {
    errLastError = ERR_NO_PROFILE;
    return FALSE;
  }
  if(!(lpszSection && lpszEntry)) return FALSE; // Deleting sect/entr not implemented
  if ( (sect = FindSection(lpszSection)) != NULL) {
    entry = FindEntry(sect, lpszEntry);
  }
  else entry = NULL;
  if (sect == NULL)
    AddSection(lpszSection, lpszEntry, lpszValue);
  else if (entry != NULL) {
    if (lpszValue == NULL) DeleteEntry(entry);
    else UpdateEntry(entry, lpszValue);
  }
  else if (lpszValue != NULL) AddEntry(sect, lpszEntry, lpszValue);
  ace_os_write(hProfile, pfli.lpszBuffer, pfli.cbSize);
  ace_os_close(hProfile);
  return TRUE;
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
      eol = strchr(lpsz, '\n'); // eol != NULL due to adding \n to end of file if it's absent
      *eol = '\0';
      if ((eos = strchr(lpsz, ']')) == NULL) {
        *eol = '\n';
        return NULL;
      }
      *eos = '\0';
      notmatch = strcmp(lpszSection, ++lpsz); // or stricmp for ignore case
      *eos = ']';
      *eol = '\n';
      lpsz = eol+1;
      if (!notmatch) return lpsz; // Target section found!
    }
  }
  return NULL; // We come here only if EOF reached : section not found
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
        return NULL;
      case ';' : // Comment
        lpsz = strchr(lpsz, '\n');
      case '\n': // Empty line
        lpsz++;
        break;
      default  : // Any string that may be entry
        if ((eos = strchr(lpsz, '=')) != NULL) { // Entry line : '=' present
          *eos = '\0';
          notmatch = strcmp(lpsz, lpszEntry); // or stricmp for ignore case
          *eos++ = '=';
          if (!notmatch) return lpsz; // Entry found
        }
        lpsz = strchr(lpsz, '\n') + 1;
        break;
    }
  }
  return NULL;
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
    lpsz = (char *)ml_calloc(1, pfli.cbSize+len+0x101);
    if ( lpsz == NULL ) {
      errLastError = ERR_OUT_OF_MEM;
      errno = ENOMEM;
      return FALSE;
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
  return TRUE;
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
    lpsz = (char *)ml_calloc(1, pfli.cbSize+len+0x101);
    if(lpsz) pfli.cbAlloc = pfli.cbSize+len+0x101;
    else {
      errLastError = ERR_OUT_OF_MEM;
      errno = ENOMEM;
      return FALSE;
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
    return TRUE;
  }
  else {
    memmove(lpszpos + len, lpszpos, pfli.cbSize-offs);
    strcpy(lpszpos, lpszEntry); lpszpos += el; *lpszpos++ = '=';
    strcpy(lpszpos, lpszValue); lpszpos += vl; *lpszpos = '\n';
  }
  pfli.cbSize += len;
  return TRUE;
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
      lpsz = (char *)ml_calloc(1, pfli.cbSize+(nl-ol)+0x101);
      if(lpsz == NULL) {
        errLastError = ERR_OUT_OF_MEM;
        errno = ENOMEM;
        return FALSE;
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
  return TRUE;
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
  return TRUE;
}

