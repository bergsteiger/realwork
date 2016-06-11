/********************************************************
*                                                       *
*                Delphi Runtime Library                 *
*                                                       *
* Copyright(c) 2016 Embarcadero Technologies, Inc.      *
*               All rights reserved                     *
*                                                       *
*   Copyright and license exceptions noted in source    *
*                                                       *
********************************************************/

#ifndef BDETYPES_H
#define BDETYPES_H

#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

#if defined(_MSC_VER) || (defined(__GNUC__) && !defined(__APPLE__) && !defined(__arm__) && !defined(__arm64__))
#define _Windows _WIN32
#endif

#if defined(_UNIX) && defined(__GNUC__)
#if defined(__arm__) || defined(__arm64__)
  #define DBIFN
#else
  #define DBIFN __attribute__ ((__stdcall__))
#endif
#else
  #define DBIFN __stdcall
#endif
#if defined(_UNIX)
  #define far
#endif

// Constants

#define DBIMAXNAMELEN         31            // Name limit (table, field etc)
#define DBIMAXSPNAMELEN       64            // Max stored procedure name length
#define DBIMAXFUNCNAMELEN    255            // Max function name len
#define DBIMAXFLDSINKEY       16            // Max fields in a key
#define DBIMAXKEYEXPLEN      220            // Max Key expression length
#define DBIMAXEXTLEN           3            // Max file extension len, not incl. dot (excluding zero termination)
#define DBIMAXTBLNAMELEN     260            // Max table name length
#define DBIMAXDRIVELEN       127            // Max drive length
#define DBIMAXPATHLEN        260            // Max path+file name len (excluding zero termination)

#define DBIMAXMSGLEN         127            // Max message len
#define DBIMAXVCHKLEN        255            // Max val check len
#define DBIMAXPICTLEN        175            // Max picture len
#define DBIMAXFLDSINSEC      256            // Max fields in security spec

#define DBIMAXSCFIELDS        40            // max nbr of fields in a config section
#define DBIMAXSCFLDLEN       128            // max field length

#define DBIMAXSCRECSIZE     DBIMAXSCFIELDS*DBIMAXSCFLDLEN  // max rec size

#define DBIMAXUSERNAMELEN     14            // Max user name (general)
#define DBIMAXXBUSERNAMELEN   16            // Max user name length (xBASE)
#define DBIMAXBOOKMARKLEN   4104            // Max Bookmark length

#define DBIMAXTRACELEN      8192            // Max trace msg len

#define DBIMAXTYPEDESC       127            // Max Type Description size
#define DBIMAXDRSQLSTR       8192           // Max Size of SQL Constraint


#ifdef far
#undef far
#endif // far
#define far


#ifndef TRUE
#  define TRUE 1
#endif // TRUE
#ifndef FALSE
#  define FALSE 0
#endif // FALSE

//For pointers
#ifndef NULL
#  define NULL (0)
#endif // NULL

#if !defined(VOID)
#  define VOID    void
   typedef char CHAR;                     // from winnt.h
   typedef short SHORT;
   typedef long LONG;
#endif

typedef unsigned char       BYTE;
#if defined(_Windows)
typedef LONG_PTR LONGP;
typedef ULONG_PTR ULONGP;
typedef LONGP* pLONGP;
typedef ULONGP* pULONGP;
#else
typedef long LONGP;
typedef unsigned long ULONGP;
typedef long* pLONGP;
typedef unsigned long* pULONGP;
#endif

#ifndef INT8
#  define INT8    char
#endif // INT8

#ifndef UINT8
#  define UINT8   unsigned char
#endif // UINT8

#ifndef INT16
  #  define INT16   short
#endif // INT16

#ifndef UINT16
  #  define UINT16  unsigned short
#endif // UINT16

#ifndef INT32
#  define INT32   int
#endif // INT32

#ifndef UINT32
#  define UINT32  unsigned int
#endif // UINT32

#ifndef INT64
#  define INT64 long long
#endif // INT64

#ifndef UINT64
#  define UINT64 unsigned long long
#endif // UINT64

#ifndef BOOL
typedef int BOOL;                      // from windows.h
#endif

#ifndef INT
typedef int INT;
#endif

#ifndef UINT
typedef unsigned int        UINT;
#endif

typedef unsigned char BOOL8;
typedef short         BOOL16;


typedef double              DFLOAT;
typedef float               SINGLE;

typedef int      DBIDATE;
typedef int      TIME;
typedef double    TIMESTAMP;
#ifdef _UNIX
     #include <time.h>
     typedef unsigned short WORD;
     typedef struct {
      WORD wYear;
      WORD wMonth;
      WORD wDayOfWeek;
      WORD wDay;
      WORD wHour;
      WORD wMinute;
      WORD wSecond;
      WORD wMilliseconds;
   } SYSTEMTIME;
   void GetLocalTime( SYSTEMTIME * t );
#endif

typedef struct  // for SQLObjects fldDATETIME
{
   INT16   year;
   UINT16  month;
   UINT16  day;
   UINT16  hour;
   UINT16  minute;
   UINT16  second;
   UINT32  fraction;

} CTIMESTAMP;

typedef struct  // for SQLObjects fldDATETIMEOFFSET
{
   INT16   year;
   UINT16  month;
   UINT16  day;
   UINT16  hour;
   UINT16  minute;
   UINT16  second;
   UINT32  fraction;
   INT16   timezone_hour;
   INT16   timezone_minute;

} CTIMESTAMPOFFSET;
 
typedef CTIMESTAMP* pCTIMESTAMP;
typedef CTIMESTAMP  SQLTIMESTAMP;
typedef SQLTIMESTAMP*  pSQLLTIMESTAMP;

typedef CTIMESTAMPOFFSET* pCTIMESTAMPOFFSET;
typedef CTIMESTAMPOFFSET  SQLTIMESTAMPOFFSET;
typedef SQLTIMESTAMPOFFSET*  pSQLLTIMESTAMPOFFSET;

typedef UINT32    hDBICfg;

typedef VOID      far *pVOID;
typedef pVOID     far *ppVOID;
typedef CHAR      far *pCHAR;
typedef const CHAR far *pCCHAR;
typedef BYTE      far *pBYTE;
typedef INT8      far *pINT8;
typedef UINT8     far *pUINT8;
typedef INT16     far *pINT16;
typedef UINT16    far *pUINT16;
typedef INT32     far *pINT32;
typedef UINT32    far *pUINT32;
typedef INT64     far *pINT64;
typedef UINT64    far *pUINT64;
typedef SINGLE    far *pSINGLE;
typedef DFLOAT    far *pDFLOAT;
typedef DBIDATE   far *pDBIDATE;
typedef TIME      far *pTIME;
typedef BOOL      far *pBOOL;
typedef BOOL16    far *pBOOL16;
typedef INT       far *pINT;
typedef UINT      far *pUINT;
typedef TIMESTAMP far *pTIMESTAMP;

#define FLOAT     DFLOAT            // for compatibility with BDE 2.0
#define pFLOAT    pDFLOAT
#define DATE      DBIDATE
#define pDATE     pDBIDATE

typedef pBYTE     far *ppBYTE;
typedef pCHAR     far *ppCHAR;
typedef pBOOL     far *ppBOOL;
typedef pBOOL16   far *ppBOOL16;

typedef hDBICfg   far *phDBICfg;

// Constants

//===========================================================================
//                            G e n e r a l
//===========================================================================
#ifndef _UNIX
  #define DBIFN  __stdcall               // All functions are this type
#endif // ifdef _UNIX

typedef UINT16          DBIResult;     // Function result
typedef DBIResult  far *pDBIResult;    // Function result pointer

typedef UINT32           hDBIObj;      // Generic object handle

typedef hDBIObj          hDBIDb;       // Database handle
typedef hDBIObj          hDBIQry;      // Query handle
typedef hDBIObj          hDBIStmt;     // Statement handle ("new query")
typedef hDBIObj          hDBICur;      // Cursor handle
typedef hDBIObj          hDBISes;      // Session handle
typedef hDBIObj          hDBIXlt;      // Translation handle

typedef hDBIObj    far *phDBIObj;      // pointer to generic object handle
typedef hDBIDb     far *phDBIDb;       // pointer to Database  handle
typedef hDBIQry    far *phDBIQry;      // pointer to Query     handle
typedef hDBIStmt   far *phDBIStmt;     // pointer to Statement handle
typedef hDBICur    far *phDBICur;      // pointer to Cursor    handle
typedef hDBISes    far *phDBISes;      // pointer to Session   handle
typedef hDBIXlt    far *phDBIXlt;      // pointer to Translation handle

typedef UINT32          hDBIXact;      // Transaction handle
typedef hDBIXact   far *phDBIXact;     // pointer to Transaction handle

typedef hDBIObj         hDBIDR ;       // Handle to a Client Data Repository (CDR) Object
typedef hDBIDR     far  *phDBIDR ;     // Ptr to CDR Handle

// typedefs for buffers of various common sizes:
//
typedef CHAR   DBIPATH    [DBIMAXPATHLEN+1];     // holds a DOS path
typedef CHAR   DBINAME    [DBIMAXNAMELEN+1];     // holds a name
typedef CHAR   DBIEXT     [DBIMAXEXTLEN+1];      // holds an extension EXT
typedef CHAR   DBIDOTEXT  [DBIMAXEXTLEN+2];      // holds an extension EXT including '.'
typedef CHAR   DBIDRIVE   [DBIMAXDRIVELEN+1];    // holds a drive name
typedef CHAR   DBITBLNAME [DBIMAXTBLNAMELEN+1];  // holds a table name
typedef CHAR   DBISPNAME  [DBIMAXSPNAMELEN+1];   // holds a stored procedure name
typedef CHAR   DBIUSERNAME[DBIMAXUSERNAMELEN+1]; // holds a user name
typedef UINT16 DBIKEY     [DBIMAXFLDSINKEY];     // holds list of fields in a key
typedef CHAR   DBIKEYEXP  [DBIMAXKEYEXPLEN+1];   // holds a key expression
typedef BYTE   DBIVCHK    [DBIMAXVCHKLEN+1];     // holds a validity check
typedef CHAR   DBIPICT    [DBIMAXPICTLEN+1];     // holds a picture (Pdox)
typedef CHAR   DBIMSG     [DBIMAXMSGLEN+1];      // holds an error message
typedef CHAR   DBIDRTYPEDESC [DBIMAXTYPEDESC+1]; // holds a Type Description string
typedef CHAR   DBISQLSTR   [DBIMAXDRSQLSTR+1];    // a SQL string

#define ErrCat(rslt)  ((UINT16)(rslt) >> 8)
#define ErrCode(rslt) ((UINT16)(rslt) & 0x00FF)

//============================================================================
//                            Error Categories
//============================================================================

#define ERRCAT_NONE                0   //  0   No error
#define ERRCAT_SYSTEM            0x21  //  33  System related (Fatal Error)
#define ERRCAT_NOTFOUND          0x22  //  34  Object of interest Not Found
#define ERRCAT_DATACORRUPT       0x23  //  35  Physical Data Corruption
#define ERRCAT_IO                0x24  //  36  I/O related error
#define ERRCAT_LIMIT             0x25  //  37  Resource or Limit error
#define ERRCAT_INTEGRITY         0x26  //  38  Integrity Violation
#define ERRCAT_INVALIDREQ        0x27  //  39  Invalid Request
#define ERRCAT_LOCKCONFLICT      0x28  //  40  Locking/Contention related
#define ERRCAT_SECURITY          0x29  //  41  Access Violation - Security related
#define ERRCAT_INVALIDCONTEXT    0x2A  //  42  Invalid context
#define ERRCAT_OS                0x2B  //  43  Os Error not handled by Idapi
#define ERRCAT_NETWORK           0x2C  //  44  Network related
#define ERRCAT_OPTPARAM          0x2D  //  45  Optional parameter related
#define ERRCAT_QUERY             0x2E  //  46  Query related
#define ERRCAT_VERSION           0x2F  //  47  Version Mismatch Category
#define ERRCAT_CAPABILITY        0x30  //  48  Capability not supported
#define ERRCAT_CONFIG            0x31  //  49  System configuration error
#define ERRCAT_WARNING           0x32  //  50
#define ERRCAT_OTHER             0x33  //  51  Miscellaneous
#define ERRCAT_COMPATIBILITY     0x34  //  52  Compatibility related
#define ERRCAT_REPOSITORY        0x35  //  53  Data Repository related

#define ERRCAT_DRIVER            0x3E  //  62  Driver related
#define ERRCAT_RC                0x3F  //  63  Internal

#define ERRBASE_NONE              0     // No error
#define ERRBASE_SYSTEM          0x2100  // System related (Fatal Error)
#define ERRBASE_NOTFOUND        0x2200  // Object of interest Not Found
#define ERRBASE_DATACORRUPT     0x2300  // Physical Data Corruption
#define ERRBASE_IO              0x2400  // I/O related error
#define ERRBASE_LIMIT           0x2500  // Resource or Limit error
#define ERRBASE_INTEGRITY       0x2600  // Integrity Violation
#define ERRBASE_INVALIDREQ      0x2700  // Invalid Request
#define ERRBASE_LOCKCONFLICT    0x2800  // Locking/Contention related
#define ERRBASE_SEC             0x2900  // Access Violation - Security related
#define ERRBASE_IC              0x2A00  // Invalid context
#define ERRBASE_OS              0x2B00  // Os Error not handled by Idapi
#define ERRBASE_NETWORK         0x2C00  // Network related
#define ERRBASE_OPTPARAM        0x2D00  // Optional Parameter related
#define ERRBASE_QUERY           0x2E00  // Query related
#define ERRBASE_VERSION         0x2F00  // Version Mismatch Category
#define ERRBASE_CAPABILITY      0x3000  // Capability not supported
#define ERRBASE_CONFIG          0x3100  // System configuration error
#define ERRBASE_WARNING         0x3200  //
#define ERRBASE_OTHER           0x3300  // Miscellaneous
#define ERRBASE_COMPATIBILITY   0x3400  // Compatibility related
#define ERRBASE_REPOSITORY      0x3500  // Data Repository related

#define ERRBASE_DRIVER          0x3E00  // Driver related
#define ERRBASE_RC              0x3F00  // Internal

//=============================================================================
//                           Error Codes By Category
//=============================================================================

// ERRCAT_NONE                  (0)
// ===========

#define ERRCODE_NONE             0

#define DBIERR_NONE                (ERRBASE_NONE + ERRCODE_NONE)

//  ERRCAT_SYSTEM
//  =============

#define  ERRCODE_SYSFILEOPEN     1   // Cannot open a system file
#define  ERRCODE_SYSFILEIO       2   // I/O error on a system file
#define  ERRCODE_SYSCORRUPT      3   // Data structure corruption
#define  ERRCODE_NOCONFIGFILE    4   // Cannot find config file
#define  ERRCODE_CFGCANNOTWRITE  5   // Cannot write config file (READONLY)
#define  ERRCODE_CFGMULTIFILE    6   // Initializing with different ini file
#define  ERRCODE_REENTERED       7   // System has been illegally re-entered
#define  ERRCODE_CANTFINDIDAPI   8   // Cannot locate IDAPIxx.DLL
#define  ERRCODE_CANTLOADIDAPI   9   // Cannot load IDAPIxx.DLL
#define  ERRCODE_CANTLOADLIBRARY 10  // Cannot load a service DLL
#define  ERRCODE_TEMPFILEERR     11  // Cannot create or open temporary file
#define  ERRCODE_MULTIPLEIDAPI   12  // Trying to load multiple IDAPIxx.DLL

#define  DBIERR_SYSFILEOPEN      (ERRBASE_SYSTEM + ERRCODE_SYSFILEOPEN)
#define  DBIERR_SYSFILEIO        (ERRBASE_SYSTEM + ERRCODE_SYSFILEIO)
#define  DBIERR_SYSCORRUPT       (ERRBASE_SYSTEM + ERRCODE_SYSCORRUPT)
#define  DBIERR_NOCONFIGFILE     (ERRBASE_SYSTEM + ERRCODE_NOCONFIGFILE)
#define  DBIERR_CFGCANNOTWRITE   (ERRBASE_SYSTEM + ERRCODE_CFGCANNOTWRITE)
#define  DBIERR_CFGMULTIFILE     (ERRBASE_SYSTEM + ERRCODE_CFGMULTIFILE)
#define  DBIERR_REENTERED        (ERRBASE_SYSTEM + ERRCODE_REENTERED)
#define  DBIERR_CANTFINDIDAPI    (ERRBASE_SYSTEM + ERRCODE_CANTFINDIDAPI)
#define  DBIERR_CANTLOADIDAPI    (ERRBASE_SYSTEM + ERRCODE_CANTLOADIDAPI)
#define  DBIERR_CANTLOADLIBRARY  (ERRBASE_SYSTEM + ERRCODE_CANTLOADLIBRARY)
#define  DBIERR_TEMPFILEERR      (ERRBASE_SYSTEM + ERRCODE_TEMPFILEERR)
#define  DBIERR_MULTIPLEIDAPI    (ERRBASE_SYSTEM + ERRCODE_MULTIPLEIDAPI)

#define  DBIERR_CANTFINDODAPI    DBIERR_CANTFINDIDAPI
#define  DBIERR_CANTLOADODAPI    DBIERR_CANTLOADIDAPI

//  ERRCAT_NOTFOUND
//  ===============

#define  ERRCODE_BOF             1        // Beginning of Virtual table
#define  ERRCODE_EOF             2        // End of Virtual table
#define  ERRCODE_RECMOVED        3        // Fly-away
#define  ERRCODE_KEYORRECDELETED 4        // Record Deleted/Key Modified
#define  ERRCODE_NOCURRREC       5        // No current record
#define  ERRCODE_RECNOTFOUND     6        // Record was not found
#define  ERRCODE_ENDOFBLOB       7        // End of Blob reached
#define  ERRCODE_OBJNOTFOUND     8        // Generic Not found
#define  ERRCODE_FMLMEMBERNOTFOUND 9      // Family member not found
#define  ERRCODE_BLOBFILEMISSING 10       // 0x0a Blob file for table is missing
#define  ERRCODE_LDNOTFOUND      11       // 0x0b Language driver not found

#define  DBIERR_BOF              (ERRBASE_NOTFOUND + ERRCODE_BOF)
#define  DBIERR_EOF              (ERRBASE_NOTFOUND + ERRCODE_EOF)
#define  DBIERR_RECMOVED         (ERRBASE_NOTFOUND + ERRCODE_RECMOVED)
#define  DBIERR_RECDELETED       (ERRBASE_NOTFOUND + ERRCODE_KEYORRECDELETED)
#define  DBIERR_KEYORRECDELETED  (ERRBASE_NOTFOUND + ERRCODE_KEYORRECDELETED)
#define  DBIERR_NOCURRREC        (ERRBASE_NOTFOUND + ERRCODE_NOCURRREC)
#define  DBIERR_RECNOTFOUND      (ERRBASE_NOTFOUND + ERRCODE_RECNOTFOUND)
#define  DBIERR_ENDOFBLOB        (ERRBASE_NOTFOUND + ERRCODE_ENDOFBLOB)
#define  DBIERR_OBJNOTFOUND      (ERRBASE_NOTFOUND + ERRCODE_OBJNOTFOUND)
#define  DBIERR_FMLMEMBERNOTFOUND (ERRBASE_NOTFOUND + ERRCODE_FMLMEMBERNOTFOUND)
#define  DBIERR_BLOBFILEMISSING (ERRBASE_NOTFOUND + ERRCODE_BLOBFILEMISSING)
#define  DBIERR_LDNOTFOUND (ERRBASE_NOTFOUND + ERRCODE_LDNOTFOUND)

// ERRCAT_DATACORRUPT
// ==================

#define  ERRCODE_HEADERCORRUPT   1        // Corrupt Header
#define  ERRCODE_FILECORRUPT     2        // File corrupt - other than header
#define  ERRCODE_MEMOCORRUPT     3        // Memo file corrupted
#define  ERRCODE_BMPCORRUPT      4        // BitMap is corrupt (Internal error)
#define  ERRCODE_INDEXCORRUPT    5        // Index is corrupt
#define  ERRCODE_CORRUPTLOCKFILE 6        // Corrupt lock file
#define  ERRCODE_FAMFILEINVALID  7        // Corrupt family file
#define  ERRCODE_VALFILECORRUPT  8        // Val file is missing or corrupt
#define  ERRCODE_FOREIGNINDEX    9        // Index is in a foreign format - import first


#define  DBIERR_HEADERCORRUPT    (ERRBASE_DATACORRUPT + ERRCODE_HEADERCORRUPT)
#define  DBIERR_FILECORRUPT      (ERRBASE_DATACORRUPT + ERRCODE_FILECORRUPT)
#define  DBIERR_MEMOCORRUPT      (ERRBASE_DATACORRUPT + ERRCODE_MEMOCORRUPT)
#define  DBIERR_BMPCORRUPT       (ERRBASE_DATACORRUPT + ERRCODE_BMPCORRUPT)
#define  DBIERR_INDEXCORRUPT     (ERRBASE_DATACORRUPT + ERRCODE_INDEXCORRUPT)
#define  DBIERR_CORRUPTLOCKFILE  (ERRBASE_DATACORRUPT + ERRCODE_CORRUPTLOCKFILE)
#define  DBIERR_FAMFILEINVALID   (ERRBASE_DATACORRUPT + ERRCODE_FAMFILEINVALID)
#define  DBIERR_VALFILECORRUPT   (ERRBASE_DATACORRUPT + ERRCODE_VALFILECORRUPT)
#define  DBIERR_FOREIGNINDEX     (ERRBASE_DATACORRUPT + ERRCODE_FOREIGNINDEX)

// ERRCAT_IO
// =========

#define  ERRCODE_READERR         1        // Read failure (not expected)
#define  ERRCODE_WRITEERR        2        // Write failure (not expected)
#define  ERRCODE_DIRNOACCESS     3        // No access to dir
#define  ERRCODE_FILEDELETEFAIL  4        // File delete failed
#define  ERRCODE_FILENOACCESS    5        // No access to file
#define  ERRCODE_ACCESSDISABLED  6        // Access to table disabled (previous error)

#define  DBIERR_READERR          (ERRBASE_IO + ERRCODE_READERR)
#define  DBIERR_WRITEERR         (ERRBASE_IO + ERRCODE_WRITEERR)
#define  DBIERR_DIRNOACCESS      (ERRBASE_IO + ERRCODE_DIRNOACCESS)
#define  DBIERR_FILEDELETEFAIL   (ERRBASE_IO + ERRCODE_FILEDELETEFAIL)
#define  DBIERR_FILENOACCESS     (ERRBASE_IO + ERRCODE_FILENOACCESS)
#define  DBIERR_ACCESSDISABLED   (ERRBASE_IO + ERRCODE_ACCESSDISABLED)

// ERRCAT_LIMIT
// ============

#define  ERRCODE_NOMEMORY        1        // Not enough Memory for this op
#define  ERRCODE_NOFILEHANDLES   2        // Not enough File handles
#define  ERRCODE_NODISKSPACE     3        // Not enough Disk space
#define  ERRCODE_NOTEMPTBLSPACE  4        // Temporary Table resource limit
#define  ERRCODE_RECTOOBIG       5        // Too big a record size for table
#define  ERRCODE_CURSORLIMIT     6        // Too many open cursors
#define  ERRCODE_TABLEFULL       7        // Table is full
#define  ERRCODE_WSSESLIMIT      8        // Too many sessions from this WS
#define  ERRCODE_SERNUMLIMIT     9        // Serial number limit (paradox)
#define  ERRCODE_INTERNALLIMIT   10       // 0x0a Some internal limit (see context)
#define  ERRCODE_OPENTBLLIMIT    11       // 0x0b Too many open tables
#define  ERRCODE_TBLCURSORLIMIT  12       // 0x0c Too many cursors per table
#define  ERRCODE_RECLOCKLIMIT    13       // 0x0d Too many record locks on table
#define  ERRCODE_CLIENTSLIMIT    14       // 0x0e Too many clients
#define  ERRCODE_INDEXLIMIT      15       // 0x0f Too many indexes (also in Table Create)
#define  ERRCODE_SESSIONSLIMIT   16       // 0x10 Too many sessions
#define  ERRCODE_DBLIMIT         17       // 0x11 Too many databases
#define  ERRCODE_PASSWORDLIMIT   18       // 0x12 Too many passwords
#define  ERRCODE_DRIVERLIMIT     19       // 0x13 Too many active drivers
#define  ERRCODE_FLDLIMIT        20       // 0x14 Too many Fields in Table Create
#define  ERRCODE_TBLLOCKLIMIT    21       // 0x15 Too many table locks
#define  ERRCODE_OPENBLOBLIMIT   22       // 0x16 Too many open blobs
#define  ERRCODE_LOCKFILELIMIT   23       // 0x17 Lock file has grown too big
#define  ERRCODE_OPENQRYLIMIT    24       // 0x18 Too many open queries
#define  ERRCODE_THREADLIMIT     25       // 0x19 Too many threads for client
#define  ERRCODE_BLOBLIMIT       26       // 0x1a Too many blobs
#define  ERRCODE_PDX50NAMELIMIT  27       // 0x1b Pathname is too long for a Paradox 5.0 or less table
#define  ERRCODE_ROWFETCHLIMIT   28       // 0x1c Row fetch limit
#define  ERRCODE_LONGNAMENOTALLOWED 29    // 0x1d Long name is not allowed for this tableversion

#define  DBIERR_NOMEMORY         (ERRBASE_LIMIT + ERRCODE_NOMEMORY)
#define  DBIERR_NOFILEHANDLES    (ERRBASE_LIMIT + ERRCODE_NOFILEHANDLES)
#define  DBIERR_NODISKSPACE      (ERRBASE_LIMIT + ERRCODE_NODISKSPACE)
#define  DBIERR_NOTEMPTBLSPACE   (ERRBASE_LIMIT + ERRCODE_NOTEMPTBLSPACE)
#define  DBIERR_RECTOOBIG        (ERRBASE_LIMIT + ERRCODE_RECTOOBIG)
#define  DBIERR_CURSORLIMIT      (ERRBASE_LIMIT + ERRCODE_CURSORLIMIT)
#define  DBIERR_TABLEFULL        (ERRBASE_LIMIT + ERRCODE_TABLEFULL)
#define  DBIERR_WSSESLIMIT       (ERRBASE_LIMIT + ERRCODE_WSSESLIMIT)
#define  DBIERR_SERNUMLIMIT      (ERRBASE_LIMIT + ERRCODE_SERNUMLIMIT)
#define  DBIERR_INTERNALLIMIT    (ERRBASE_LIMIT + ERRCODE_INTERNALLIMIT)
#define  DBIERR_OPENTBLLIMIT     (ERRBASE_LIMIT + ERRCODE_OPENTBLLIMIT)
#define  DBIERR_TBLCURSORLIMIT   (ERRBASE_LIMIT + ERRCODE_TBLCURSORLIMIT)
#define  DBIERR_RECLOCKLIMIT     (ERRBASE_LIMIT + ERRCODE_RECLOCKLIMIT)
#define  DBIERR_CLIENTSLIMIT     (ERRBASE_LIMIT + ERRCODE_CLIENTSLIMIT)
#define  DBIERR_INDEXLIMIT       (ERRBASE_LIMIT + ERRCODE_INDEXLIMIT)
#define  DBIERR_SESSIONSLIMIT    (ERRBASE_LIMIT + ERRCODE_SESSIONSLIMIT)
#define  DBIERR_DBLIMIT          (ERRBASE_LIMIT + ERRCODE_DBLIMIT)
#define  DBIERR_PASSWORDLIMIT    (ERRBASE_LIMIT + ERRCODE_PASSWORDLIMIT)
#define  DBIERR_DRIVERLIMIT      (ERRBASE_LIMIT + ERRCODE_DRIVERLIMIT)
#define  DBIERR_FLDLIMIT         (ERRBASE_LIMIT + ERRCODE_FLDLIMIT)
#define  DBIERR_TBLLOCKLIMIT     (ERRBASE_LIMIT + ERRCODE_TBLLOCKLIMIT)
#define  DBIERR_OPENBLOBLIMIT    (ERRBASE_LIMIT + ERRCODE_OPENBLOBLIMIT)
#define  DBIERR_LOCKFILELIMIT    (ERRBASE_LIMIT + ERRCODE_LOCKFILELIMIT)
#define  DBIERR_OPENQRYLIMIT     (ERRBASE_LIMIT + ERRCODE_OPENQRYLIMIT)
#define  DBIERR_THREADLIMIT      (ERRBASE_LIMIT + ERRCODE_THREADLIMIT)
#define  DBIERR_BLOBLIMIT        (ERRBASE_LIMIT + ERRCODE_BLOBLIMIT)
#define  DBIERR_PDX50NAMELIMIT   (ERRBASE_LIMIT + ERRCODE_PDX50NAMELIMIT)
#define  DBIERR_ROWFETCHLIMIT    (ERRBASE_LIMIT + ERRCODE_ROWFETCHLIMIT)
#define  DBIERR_LONGNAMENOTALLOWED (ERRBASE_LIMIT + ERRCODE_LONGNAMENOTALLOWED)

// ERRCAT_INTEGRITY
// ================

#define ERRCODE_KEYVIOL             1     // Key violation
#define ERRCODE_MINVALERR           2     // Min val check failed
#define ERRCODE_MAXVALERR           3     // Max val check failed
#define ERRCODE_REQDERR             4     // Field value required
#define ERRCODE_FORIEGNKEYERR       5     // Master record missing
#define ERRCODE_DETAILRECORDSEXIST  6     // Cannot MODIFY or DELETE this Master record
#define ERRCODE_MASTERTBLLEVEL      7     // Master Table Level is incorrect
#define ERRCODE_LOOKUPTABLEERR      8     // Field value out of lookup tbl range
#define ERRCODE_LOOKUPTBLOPENERR    9     // Lookup Table Open failed
#define ERRCODE_DETAILTBLOPENERR   10     // 0x0a Detail Table Open failed
#define ERRCODE_MASTERTBLOPENERR   11     // 0x0b Master Table Open failed
#define ERRCODE_FIELDISBLANK       12     // 0x0c Field is blank

#define ERRCODE_MASTEREXISTS       13     // 0x0d Master Table exists
#define ERRCODE_MASTERTBLOPEN      14     // 0x0e Master Table is open

#define ERRCODE_DETAILTABLESEXIST    15   // 0x0f Detail Tables exist ( cannot delete, rename ... )
#define ERRCODE_DETAILRECEXISTEMPTY  16   // 0x10 Cannot empty because details exist
#define ERRCODE_MASTERREFERENCEERR   17   // 0x11 Cannot modify while adding self referencing Referential Integrity
#define ERRCODE_DETAILTBLOPEN        18   // 0x12 Detail Table is opened
#define ERRCODE_DEPENDENTSMUSTBEEMPTY  19 // 0x13 Cannot make a master a detail of another table if its details are not empty !
#define ERRCODE_RINTREQINDEX         20   // 0x14 Ref. integrity fields must be indexed
#define ERRCODE_LINKEDTBLPROTECTED   21   // 0x15 Master Table is protected ( requires password to open)
#define ERRCODE_FIELDMULTILINKED     22   // 0x16 Field has more than one master

#define DBIERR_KEYVIOL             (ERRBASE_INTEGRITY + ERRCODE_KEYVIOL)
#define DBIERR_MINVALERR           (ERRBASE_INTEGRITY + ERRCODE_MINVALERR)
#define DBIERR_MAXVALERR           (ERRBASE_INTEGRITY + ERRCODE_MAXVALERR)
#define DBIERR_REQDERR             (ERRBASE_INTEGRITY + ERRCODE_REQDERR)
#define DBIERR_FORIEGNKEYERR       (ERRBASE_INTEGRITY + ERRCODE_FORIEGNKEYERR)
#define DBIERR_DETAILRECORDSEXIST  (ERRBASE_INTEGRITY + ERRCODE_DETAILRECORDSEXIST)
#define DBIERR_MASTERTBLLEVEL      (ERRBASE_INTEGRITY + ERRCODE_MASTERTBLLEVEL)
#define DBIERR_LOOKUPTABLEERR      (ERRBASE_INTEGRITY + ERRCODE_LOOKUPTABLEERR)
#define DBIERR_LOOKUPTBLOPENERR    (ERRBASE_INTEGRITY + ERRCODE_LOOKUPTBLOPENERR)
#define DBIERR_DETAILTBLOPENERR    (ERRBASE_INTEGRITY + ERRCODE_DETAILTBLOPENERR)
#define DBIERR_MASTERTBLOPENERR    (ERRBASE_INTEGRITY + ERRCODE_MASTERTBLOPENERR)
#define DBIERR_FIELDISBLANK        (ERRBASE_INTEGRITY + ERRCODE_FIELDISBLANK)
#define DBIERR_MASTEREXISTS        (ERRBASE_INTEGRITY + ERRCODE_MASTEREXISTS)
#define DBIERR_MASTERTBLOPEN       (ERRBASE_INTEGRITY + ERRCODE_MASTERTBLOPEN)
#define DBIERR_DETAILTABLESEXIST   (ERRBASE_INTEGRITY + ERRCODE_DETAILTABLESEXIST)
#define DBIERR_DETAILRECEXISTEMPTY (ERRBASE_INTEGRITY + ERRCODE_DETAILRECEXISTEMPTY)
#define DBIERR_MASTERREFERENCEERR  (ERRBASE_INTEGRITY + ERRCODE_MASTERREFERENCEERR)
#define DBIERR_DETAILTBLOPEN       (ERRBASE_INTEGRITY + ERRCODE_DETAILTBLOPEN)
#define DBIERR_DEPENDENTSMUSTBEEMPTY  (ERRBASE_INTEGRITY + ERRCODE_DEPENDENTSMUSTBEEMPTY)
#define DBIERR_RINTREQINDEX        (ERRBASE_INTEGRITY + ERRCODE_RINTREQINDEX)
#define DBIERR_LINKEDTBLPROTECTED  (ERRBASE_INTEGRITY + ERRCODE_LINKEDTBLPROTECTED)
#define DBIERR_FIELDMULTILINKED    (ERRBASE_INTEGRITY + ERRCODE_FIELDMULTILINKED)

// ERRCAT_INVALIDREQ
// =================

#define  ERRCODE_OUTOFRANGE           1     // Number out of range (e.g field no)
#define  ERRCODE_INVALIDPARAM         2     // Generic invalid parameter
#define  ERRCODE_INVALIDFILENAME      3     // Invalid file name
#define  ERRCODE_NOSUCHFILE           4     // No such file
#define  ERRCODE_INVALIDOPTION        5     // Invalid option for a parameter
#define  ERRCODE_INVALIDHNDL          6     // Invalid handle to the function
#define  ERRCODE_UNKNOWNTBLTYPE       7     // Table type given not known
#define  ERRCODE_UNKNOWNFILE          8     // Dont know how to open file
#define  ERRCODE_PRIMARYKEYREDEFINE   9     // Cannot redefine primary key
#define  ERRCODE_INVALIDRINTDESCNUM   10    // 0x0a Cannot change this RINTDesc
#define  ERRCODE_KEYFLDTYPEMISMATCH   11    // 0x0b Foreign & Primary Key Mismatch
#define  ERRCODE_INVALIDMODIFYREQUEST 12    // 0x0c Invalid modify request
#define  ERRCODE_NOSUCHINDEX          13    // 0x0d Index does not exist
#define  ERRCODE_INVALIDBLOBOFFSET    14    // 0x0e Invalid Offset into the Blob
#define  ERRCODE_INVALIDDESCNUM       15    // 0x0f Invalid descriptor number
#define  ERRCODE_INVALIDFLDTYPE       16    // 0x10 Invalid field type
#define  ERRCODE_INVALIDFLDDESC       17    // 0x11 Invalid field descriptor
#define  ERRCODE_INVALIDFLDXFORM      18    // 0x12 Invalid field transform
#define  ERRCODE_INVALIDRECSTRUCT     19    // 0x13 Invalid record structure
#define  ERRCODE_INVALIDDESC          20    // 0x14 Generic: invalid descriptor
#define  ERRCODE_INVALIDINDEXSTRUCT   21    // 0x15 Invalid array of indexes descriptors
#define  ERRCODE_INVALIDVCHKSTRUCT    22    // 0x16 Invalid array of  val. check descriptors
#define  ERRCODE_INVALIDRINTSTRUCT    23    // 0x17 Invalid array of ref. integrity descriptors
#define  ERRCODE_INVALIDRESTRTBLORDER 24    // 0x18 Invalid ordering of tables during restructure
#define  ERRCODE_NAMENOTUNIQUE        25    // 0x19 Name not unique in this context
#define  ERRCODE_INDEXNAMEREQUIRED    26    // 0x1a Index name required
#define  ERRCODE_INVALIDSESHANDLE     27    // 0x1b Invalid ses handle
#define  ERRCODE_INVALIDRESTROP       28    // 0x1c Invalid restructure operation
#define  ERRCODE_UNKNOWNDRIVER        29    // 0x1d Driver not known to system
#define  ERRCODE_UNKNOWNDB            30    // 0x1e Unknown db
#define  ERRCODE_INVALIDPASSWORD      31    // 0x1f Invalid password given
#define  ERRCODE_NOCALLBACK           32    // 0x20 No callback function
#define  ERRCODE_INVALIDCALLBACKBUFLEN 33   // 0x21 Invalid callback buffer length
#define  ERRCODE_INVALIDDIR            34   // 0x22 Invalid directory
#define  ERRCODE_INVALIDXLATION        35   // 0x23 Translate Error - Translate DID NOT happen
#define  ERRCODE_DIFFERENTTABLES       36   // 0x24 Cannot Set Cursor of one Table to another
#define  ERRCODE_INVALIDBOOKMARK       37   // 0x25 Bookmarks does not match table, etc.
#define  ERRCODE_INVALIDINDEXNAME      38   // 0x26 Index/Tag Name is invalid
#define  ERRCODE_INVALIDIDXDESC        39   // 0x27 Invalid index descriptor
#define  ERRCODE_NOSUCHTABLE           40   // 0x28 No such table
#define  ERRCODE_USECOUNT              41   // 0x29 Table has too many users
#define  ERRCODE_INVALIDKEY            42   // 0x2a Key does not pass filter condition
#define  ERRCODE_INDEXEXISTS           43   // 0x2b Index already exists
#define  ERRCODE_INDEXOPEN             44   // 0x2c Index is open
#define  ERRCODE_INVALIDBLOBLEN        45   // 0x2d Invalid Blob Length
#define  ERRCODE_INVALIDBLOBHANDLE     46   // 0x2e Invalid Blob handle (in record buffer)
#define  ERRCODE_TABLEOPEN             47   // 0x2f Table is open
#define  ERRCODE_NEEDRESTRUCTURE       48   // 0x30 Need to do (hard) restructure
#define  ERRCODE_INVALIDMODE           49   // 0x31 Invalid mode
#define  ERRCODE_CANNOTCLOSE            50  // 0x32 Cannot close index
#define  ERRCODE_ACTIVEINDEX            51  // 0x33 Index is being used to order tbl
#define  ERRCODE_INVALIDUSRPASS         52  // 0x34 Bad user name or password
#define  ERRCODE_MULTILEVELCASCADE      53  // 0x35 Multi level Cascade not supported
#define  ERRCODE_INVALIDFIELDNAME       54  // 0x36 Invalid field name
#define  ERRCODE_INVALIDTABLENAME       55  // 0x37 Invalid table name
#define  ERRCODE_INVALIDLINKEXPR        56  // 0x38 Invalid linked cursor expression
#define  ERRCODE_NAMERESERVED           57  // 0x39 Name is reserved
#define  ERRCODE_INVALIDFILEEXTN        58  // 0x3a Invalid file extention
#define  ERRCODE_INVALIDLANGDRV         59  // 0x3b Invalid language driver
#define  ERRCODE_ALIASNOTOPEN           60  // 0x3c Requested alias in not open
#define  ERRCODE_INCOMPATRECSTRUCTS     61  // 0x3d Incompatible record structures
#define  ERRCODE_RESERVEDDOSNAME        62  // 0x3e Reserved dos name
#define  ERRCODE_DESTMUSTBEINDEXED      63  // 0x3f Destination must be indexed
#define  ERRCODE_INVALIDINDEXTYPE       64  // 0x40 Invalid index type
#define  ERRCODE_LANGDRVMISMATCH        65  // 0x41 Language driver of table and index do not match
#define  ERRCODE_NOSUCHFILTER           66  // 0x42 Filter handle is invalid
#define  ERRCODE_INVALIDFILTER          67  // 0x43 Invalid filter

#define  ERRCODE_INVALIDTABLECREATE     68  // 0x44 Bad table create request (exact prob unknown)
#define  ERRCODE_INVALIDTABLEDELETE     69  // 0x45 Bad table delete request (exact prob unknown)
#define  ERRCODE_INVALIDINDEXCREATE     70  // 0x46 Bad index create request (exact prob unknown)
#define  ERRCODE_INVALIDINDEXDELETE     71  // 0x47 Bad index delete request (exact prob unknown)
#define  ERRCODE_INVALIDTABLE           72  // 0x48 Invalid table name specified
#define  ERRCODE_MULTIRESULTS           73  // 0X49 Multi results
#define  ERRCODE_INVALIDTIME            74  // 0X4A Multi results
#define  ERRCODE_INVALIDDATE            75  // 0X4B Multi results
#define  ERRCODE_INVALIDTIMESTAMP       76  // 0X4C Multi results
#define  ERRCODE_DIFFERENTPATH          77  // 0X4d Tables in different paths
#define  ERRCODE_MISMATCHARGS           78  // 0x4e MisMatch in the # of arguments
#define  ERRCODE_FUNCTIONNOTFOUND       79  // 0x4f Loaderlib cant find a func in the DLL (bad version?)
#define  ERRCODE_MUSTUSEBASEORDER       80  // 0x50 Must use baseorder for this operation
#define  ERRCODE_INVALIDPROCEDURENAME   81  // 0x51 Invalid procedure name
#define  ERRCODE_INVALIDFLDMAP          82  // 0x52 invalid field map


#define  DBIERR_OUTOFRANGE           (ERRBASE_INVALIDREQ + ERRCODE_OUTOFRANGE)
#define  DBIERR_INVALIDPARAM         (ERRBASE_INVALIDREQ + ERRCODE_INVALIDPARAM)
#define  DBIERR_INVALIDFILENAME      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFILENAME)
#define  DBIERR_NOSUCHFILE           (ERRBASE_INVALIDREQ + ERRCODE_NOSUCHFILE)
#define  DBIERR_INVALIDOPTION        (ERRBASE_INVALIDREQ + ERRCODE_INVALIDOPTION)
#define  DBIERR_INVALIDHNDL          (ERRBASE_INVALIDREQ + ERRCODE_INVALIDHNDL)
#define  DBIERR_UNKNOWNTBLTYPE       (ERRBASE_INVALIDREQ + ERRCODE_UNKNOWNTBLTYPE)
#define  DBIERR_UNKNOWNFILE          (ERRBASE_INVALIDREQ + ERRCODE_UNKNOWNFILE)
#define  DBIERR_PRIMARYKEYREDEFINE   (ERRBASE_INVALIDREQ + ERRCODE_PRIMARYKEYREDEFINE)
#define  DBIERR_INVALIDRINTDESCNUM   (ERRBASE_INVALIDREQ + ERRCODE_INVALIDRINTDESCNUM)
#define  DBIERR_KEYFLDTYPEMISMATCH   (ERRBASE_INVALIDREQ + ERRCODE_KEYFLDTYPEMISMATCH)
#define  DBIERR_INVALIDMODIFYREQUEST (ERRBASE_INVALIDREQ + ERRCODE_INVALIDMODIFYREQUEST)
#define  DBIERR_NOSUCHINDEX          (ERRBASE_INVALIDREQ + ERRCODE_NOSUCHINDEX)
#define  DBIERR_INVALIDBLOBOFFSET    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDBLOBOFFSET)
#define  DBIERR_INVALIDDESCNUM       (ERRBASE_INVALIDREQ + ERRCODE_INVALIDDESCNUM)
#define  DBIERR_INVALIDFLDTYPE       (ERRBASE_INVALIDREQ +  ERRCODE_INVALIDFLDTYPE)
#define  DBIERR_INVALIDFLDDESC       (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFLDDESC)
#define  DBIERR_INVALIDFLDXFORM      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFLDXFORM)
#define  DBIERR_INVALIDRECSTRUCT     (ERRBASE_INVALIDREQ + ERRCODE_INVALIDRECSTRUCT)
#define  DBIERR_INVALIDDESC          (ERRBASE_INVALIDREQ + ERRCODE_INVALIDDESC)
#define  DBIERR_INVALIDINDEXSTRUCT   (ERRBASE_INVALIDREQ + ERRCODE_INVALIDINDEXSTRUCT)
#define  DBIERR_INVALIDVCHKSTRUCT    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDVCHKSTRUCT)
#define  DBIERR_INVALIDRINTSTRUCT    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDRINTSTRUCT)
#define  DBIERR_INVALIDRESTRTBLORDER (ERRBASE_INVALIDREQ + ERRCODE_INVALIDRESTRTBLORDER)
#define  DBIERR_NAMENOTUNIQUE        (ERRBASE_INVALIDREQ + ERRCODE_NAMENOTUNIQUE)
#define  DBIERR_INDEXNAMEREQUIRED    (ERRBASE_INVALIDREQ + ERRCODE_INDEXNAMEREQUIRED)
#define  DBIERR_INVALIDSESHANDLE     (ERRBASE_INVALIDREQ + ERRCODE_INVALIDSESHANDLE)
#define  DBIERR_INVALIDRESTROP       (ERRBASE_INVALIDREQ + ERRCODE_INVALIDRESTROP)
#define  DBIERR_UNKNOWNDRIVER        (ERRBASE_INVALIDREQ + ERRCODE_UNKNOWNDRIVER)
#define  DBIERR_UNKNOWNDB            (ERRBASE_INVALIDREQ + ERRCODE_UNKNOWNDB)
#define  DBIERR_INVALIDPASSWORD      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDPASSWORD)
#define  DBIERR_NOCALLBACK           (ERRBASE_INVALIDREQ + ERRCODE_NOCALLBACK)
#define  DBIERR_INVALIDCALLBACKBUFLEN  (ERRBASE_INVALIDREQ + ERRCODE_INVALIDCALLBACKBUFLEN )
#define  DBIERR_INVALIDDIR          (ERRBASE_INVALIDREQ + ERRCODE_INVALIDDIR)
#define  DBIERR_INVALIDXLATION      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDXLATION)
#define  DBIERR_DIFFERENTTABLES     (ERRBASE_INVALIDREQ + ERRCODE_DIFFERENTTABLES)
#define  DBIERR_INVALIDBOOKMARK     (ERRBASE_INVALIDREQ + ERRCODE_INVALIDBOOKMARK)
#define  DBIERR_INVALIDINDEXNAME    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDINDEXNAME)
#define  DBIERR_INVALIDIDXDESC      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDIDXDESC)
#define  DBIERR_NOSUCHTABLE         (ERRBASE_INVALIDREQ + ERRCODE_NOSUCHTABLE)
#define  DBIERR_USECOUNT            (ERRBASE_INVALIDREQ + ERRCODE_USECOUNT)
#define  DBIERR_INVALIDKEY          (ERRBASE_INVALIDREQ + ERRCODE_INVALIDKEY)
#define  DBIERR_INDEXEXISTS         (ERRBASE_INVALIDREQ + ERRCODE_INDEXEXISTS)
#define  DBIERR_INDEXOPEN           (ERRBASE_INVALIDREQ + ERRCODE_INDEXOPEN)
#define  DBIERR_INVALIDBLOBLEN      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDBLOBLEN)
#define  DBIERR_INVALIDBLOBHANDLE   (ERRBASE_INVALIDREQ + ERRCODE_INVALIDBLOBHANDLE)
#define  DBIERR_TABLEOPEN           (ERRBASE_INVALIDREQ + ERRCODE_TABLEOPEN)
#define  DBIERR_NEEDRESTRUCTURE     (ERRBASE_INVALIDREQ + ERRCODE_NEEDRESTRUCTURE)
#define  DBIERR_INVALIDMODE         (ERRBASE_INVALIDREQ + ERRCODE_INVALIDMODE)
#define  DBIERR_CANNOTCLOSE         (ERRBASE_INVALIDREQ + ERRCODE_CANNOTCLOSE)
#define  DBIERR_ACTIVEINDEX         (ERRBASE_INVALIDREQ + ERRCODE_ACTIVEINDEX)
#define  DBIERR_INVALIDUSRPASS      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDUSRPASS)
#define  DBIERR_MULTILEVELCASCADE   (ERRBASE_INVALIDREQ + ERRCODE_MULTILEVELCASCADE)
#define  DBIERR_INVALIDFIELDNAME    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFIELDNAME)
#define  DBIERR_INVALIDTABLENAME    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDTABLENAME)
#define  DBIERR_INVALIDLINKEXPR     (ERRBASE_INVALIDREQ + ERRCODE_INVALIDLINKEXPR)
#define  DBIERR_NAMERESERVED        (ERRBASE_INVALIDREQ + ERRCODE_NAMERESERVED)
#define  DBIERR_INVALIDFILEEXTN     (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFILEEXTN)
#define  DBIERR_INVALIDLANGDRV      (ERRBASE_INVALIDREQ + ERRCODE_INVALIDLANGDRV)
#define  DBIERR_ALIASNOTOPEN        (ERRBASE_INVALIDREQ + ERRCODE_ALIASNOTOPEN)
#define  DBIERR_INCOMPATRECSTRUCTS  (ERRBASE_INVALIDREQ + ERRCODE_INCOMPATRECSTRUCTS)
#define  DBIERR_RESERVEDOSNAME      (ERRBASE_INVALIDREQ + ERRCODE_RESERVEDDOSNAME)
#define  DBIERR_DESTMUSTBEINDEXED   (ERRBASE_INVALIDREQ + ERRCODE_DESTMUSTBEINDEXED)
#define  DBIERR_INVALIDINDEXTYPE    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDINDEXTYPE)
#define  DBIERR_LANGDRVMISMATCH     (ERRBASE_INVALIDREQ + ERRCODE_LANGDRVMISMATCH)
#define  DBIERR_NOSUCHFILTER        (ERRBASE_INVALIDREQ + ERRCODE_NOSUCHFILTER)
#define  DBIERR_INVALIDFILTER       (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFILTER)
#define  DBIERR_INVALIDTABLECREATE  (ERRBASE_INVALIDREQ + ERRCODE_INVALIDTABLECREATE)
#define  DBIERR_INVALIDTABLEDELETE  (ERRBASE_INVALIDREQ + ERRCODE_INVALIDTABLEDELETE)
#define  DBIERR_INVALIDINDEXCREATE  (ERRBASE_INVALIDREQ + ERRCODE_INVALIDINDEXCREATE)
#define  DBIERR_INVALIDINDEXDELETE  (ERRBASE_INVALIDREQ + ERRCODE_INVALIDINDEXDELETE)
#define  DBIERR_INVALIDTABLE        (ERRBASE_INVALIDREQ + ERRCODE_INVALIDTABLE)
#define  DBIERR_MULTIRESULTS        (ERRBASE_INVALIDREQ + ERRCODE_MULTIRESULTS)
#define  DBIERR_INVALIDTIME         (ERRBASE_INVALIDREQ + ERRCODE_INVALIDTIME)
#define  DBIERR_INVALIDDATE         (ERRBASE_INVALIDREQ + ERRCODE_INVALIDDATE)
#define  DBIERR_INVALIDTIMESTAMP    (ERRBASE_INVALIDREQ + ERRCODE_INVALIDTIMESTAMP)
#define  DBIERR_DIFFERENTPATH       (ERRBASE_INVALIDREQ + ERRCODE_DIFFERENTPATH)
#define  DBIERR_MISMATCHARGS        (ERRBASE_INVALIDREQ + ERRCODE_MISMATCHARGS)
#define  DBIERR_FUNCTIONNOTFOUND    (ERRBASE_INVALIDREQ + ERRCODE_FUNCTIONNOTFOUND)
#define  DBIERR_MUSTUSEBASEORDER    (ERRBASE_INVALIDREQ + ERRCODE_MUSTUSEBASEORDER)
#define  DBIERR_INVALIDPROCEDURENAME (ERRBASE_INVALIDREQ + ERRCODE_INVALIDPROCEDURENAME)
#define  DBIERR_INVALIDFLDMAP       (ERRBASE_INVALIDREQ + ERRCODE_INVALIDFLDMAP)

// ERRCAT_LOCKCONFLICT
// ===================

#define ERRCODE_LOCKED           1
#define ERRCODE_UNLOCKFAILED     2
#define ERRCODE_FILEBUSY         3
#define ERRCODE_DIRBUSY          4
#define ERRCODE_FILELOCKED       5
#define ERRCODE_DIRLOCKED        6
#define ERRCODE_ALREADYLOCKED    7
#define ERRCODE_NOTLOCKED        8
#define ERRCODE_LOCKTIMEOUT      9
#define ERRCODE_GROUPLOCKED      10    // 0x0a
#define ERRCODE_LOSTTBLLOCK      11    // 0x0b
#define ERRCODE_LOSTEXCLACCESS   12    // 0x0c
#define ERRCODE_NEEDEXCLACCESS   13    // 0x0d
#define ERRCODE_RECGROUPCONFLICT 14    // 0x0e
#define ERRCODE_DEADLOCK         15
#define ERRCODE_ACTIVETRAN       16
#define ERRCODE_NOACTIVETRAN     17
#define ERRCODE_RECLOCKFAILED    18
#define ERRCODE_OPTRECLOCKFAILED 19
#define ERRCODE_OPTRECLOCKRECDEL 20
#define ERRCODE_LOCKEDRECS       21
#define ERRCODE_NEEDWRITELOCK    22

#define DBIERR_LOCKED            (ERRBASE_LOCKCONFLICT + ERRCODE_LOCKED)
#define DBIERR_UNLOCKFAILED      (ERRBASE_LOCKCONFLICT + ERRCODE_UNLOCKFAILED)
#define DBIERR_FILEBUSY          (ERRBASE_LOCKCONFLICT + ERRCODE_FILEBUSY)
#define DBIERR_DIRBUSY           (ERRBASE_LOCKCONFLICT + ERRCODE_DIRBUSY)
#define DBIERR_FILELOCKED        (ERRBASE_LOCKCONFLICT + ERRCODE_FILELOCKED)
#define DBIERR_DIRLOCKED         (ERRBASE_LOCKCONFLICT + ERRCODE_DIRLOCKED)
#define DBIERR_ALREADYLOCKED     (ERRBASE_LOCKCONFLICT + ERRCODE_ALREADYLOCKED)
#define DBIERR_NOTLOCKED         (ERRBASE_LOCKCONFLICT + ERRCODE_NOTLOCKED)
#define DBIERR_LOCKTIMEOUT       (ERRBASE_LOCKCONFLICT + ERRCODE_LOCKTIMEOUT)
#define DBIERR_GROUPLOCKED       (ERRBASE_LOCKCONFLICT + ERRCODE_GROUPLOCKED)
#define DBIERR_LOSTTBLLOCK       (ERRBASE_LOCKCONFLICT + ERRCODE_LOSTTBLLOCK)
#define DBIERR_LOSTEXCLACCESS    (ERRBASE_LOCKCONFLICT + ERRCODE_LOSTEXCLACCESS)
#define DBIERR_NEEDEXCLACCESS    (ERRBASE_LOCKCONFLICT  + ERRCODE_NEEDEXCLACCESS)
#define DBIERR_RECGROUPCONFLICT  (ERRBASE_LOCKCONFLICT + ERRCODE_RECGROUPCONFLICT)
#define DBIERR_DEADLOCK          (ERRBASE_LOCKCONFLICT + ERRCODE_DEADLOCK)
#define DBIERR_ACTIVETRAN        (ERRBASE_LOCKCONFLICT + ERRCODE_ACTIVETRAN)
#define DBIERR_NOACTIVETRAN      (ERRBASE_LOCKCONFLICT + ERRCODE_NOACTIVETRAN)
#define DBIERR_RECLOCKFAILED     (ERRBASE_LOCKCONFLICT + ERRCODE_RECLOCKFAILED)
#define DBIERR_OPTRECLOCKFAILED  (ERRBASE_LOCKCONFLICT + ERRCODE_OPTRECLOCKFAILED)
#define DBIERR_OPTRECLOCKRECDEL  (ERRBASE_LOCKCONFLICT + ERRCODE_OPTRECLOCKRECDEL)

// ERRCAT_SECURITY
// ===============

#define ERRCODE_NOTSUFFFIELDRIGHTS   1        // Not sufficient field  rights for operation
#define ERRCODE_NOTSUFFTABLERIGHTS   2        // Not sufficient table  rights for operation
#define ERRCODE_NOTSUFFFAMILYRIGHTS  3        // Not sufficient family rights for operation
#define ERRCODE_READONLYDIR          4        // Is a read-only directory
#define ERRCODE_READONLYDB           5        // Database is read-only
#define ERRCODE_READONLYFLD          6        // Trying to modify read-only field
#define ERRCODE_TBLENCRYPTED         7        // Table is encrypted (dBASE only)
#define ERRCODE_NOTSUFFSQLRIGHTS     8        // Not sufficient sql rights for operation


#define DBIERR_NOTSUFFFIELDRIGHTS  (ERRBASE_SEC + ERRCODE_NOTSUFFFIELDRIGHTS)
#define DBIERR_NOTSUFFTABLERIGHTS  (ERRBASE_SEC + ERRCODE_NOTSUFFTABLERIGHTS)
#define DBIERR_NOTSUFFFAMILYRIGHTS (ERRBASE_SEC + ERRCODE_NOTSUFFFAMILYRIGHTS)
#define DBIERR_READONLYDIR         (ERRBASE_SEC + ERRCODE_READONLYDIR)
#define DBIERR_READONLYDB          (ERRBASE_SEC + ERRCODE_READONLYDB)
#define DBIERR_READONLYFLD         (ERRBASE_SEC + ERRCODE_READONLYFLD)
#define DBIERR_TBLENCRYPTED        (ERRBASE_SEC + ERRCODE_TBLENCRYPTED)
#define DBIERR_NOTSUFFSQLRIGHTS    (ERRBASE_SEC + ERRCODE_NOTSUFFSQLRIGHTS)


// ERRCAT_INVALIDCONTEXT
// =====================

#define ERRCODE_NOTABLOB         1        // Field is not a blob
#define ERRCODE_BLOBOPENED       2        // Blob already opened
#define ERRCODE_BLOBNOTOPENED    3        // Blob not opened
#define ERRCODE_NA               4        // Operation not applicable
#define ERRCODE_NOTINDEXED       5        // Table is not indexed
#define ERRCODE_NOTINITIALIZED   6        // Engine not initialized
#define ERRCODE_MULTIPLEINIT     7        // Attempt to re-initialize engine
#define ERRCODE_NOTSAMESESSION   8        // Attempt to mix objs from diff ses
#define ERRCODE_PDXDRIVERNOTACTIVE 9      // Paradox driver not active
#define ERRCODE_DRIVERNOTLOADED  10       // 0x0a Driver not loaded
#define ERRCODE_TABLEREADONLY    11       // 0x0b Table is read only
#define ERRCODE_NOASSOCINDEX     12       // 0x0c No index associated with the cursor
#define ERRCODE_HASOPENCURSORS   13       // 0x0d Has open cursors
#define ERRCODE_NOTABLESUPPORT   14       // 0x0e Op cannot be done on this table
#define ERRCODE_INDEXREADONLY    15       // 0x0f Index is read only
#define ERRCODE_NOUNIQUERECS     16       // 0x10 Records are not unique
#define ERRCODE_NOTCURSESSION    17       // 0x11 Not the current/active session
#define ERRCODE_INVALIDKEYWORD   18       // 0x12 Invalid use of keyword.
#define ERRCODE_CONNECTINUSE     19       // 0x13 Connection in use
#define ERRCODE_CONNECTNOTSHARED 20       // 0x14 Passthru SQL connection not share


#define DBIERR_NOTABLOB           (ERRBASE_IC + ERRCODE_NOTABLOB)
#define DBIERR_BLOBOPENED         (ERRBASE_IC + ERRCODE_BLOBOPENED)
#define DBIERR_BLOBNOTOPENED      (ERRBASE_IC + ERRCODE_BLOBNOTOPENED)
#define DBIERR_NA                 (ERRBASE_IC + ERRCODE_NA)
#define DBIERR_NOTINDEXED         (ERRBASE_IC + ERRCODE_NOTINDEXED)
#define DBIERR_NOTINITIALIZED     (ERRBASE_IC + ERRCODE_NOTINITIALIZED)
#define DBIERR_MULTIPLEINIT       (ERRBASE_IC + ERRCODE_MULTIPLEINIT)
#define DBIERR_NOTSAMESESSION     (ERRBASE_IC + ERRCODE_NOTSAMESESSION)
#define DBIERR_PDXDRIVERNOTACTIVE (ERRBASE_IC + ERRCODE_PDXDRIVERNOTACTIVE)
#define DBIERR_DRIVERNOTLOADED    (ERRBASE_IC + ERRCODE_DRIVERNOTLOADED)
#define DBIERR_TABLEREADONLY      (ERRBASE_IC + ERRCODE_TABLEREADONLY)
#define DBIERR_NOASSOCINDEX       (ERRBASE_IC + ERRCODE_NOASSOCINDEX)
#define DBIERR_HASOPENCURSORS     (ERRBASE_IC + ERRCODE_HASOPENCURSORS)
#define DBIERR_NOTABLESUPPORT     (ERRBASE_IC + ERRCODE_NOTABLESUPPORT)
#define DBIERR_INDEXREADONLY      (ERRBASE_IC + ERRCODE_INDEXREADONLY)
#define DBIERR_NOUNIQUERECS       (ERRBASE_IC + ERRCODE_NOUNIQUERECS)
#define DBIERR_NOTCURSESSION      (ERRBASE_IC + ERRCODE_NOTCURSESSION)
#define DBIERR_INVALIDKEYWORD     (ERRBASE_IC + ERRCODE_INVALIDKEYWORD)
#define DBIERR_CONNECTINUSE       (ERRBASE_IC + ERRCODE_CONNECTINUSE)
#define DBIERR_CONNECTNOTSHARED   (ERRBASE_IC + ERRCODE_CONNECTNOTSHARED)

// ERRCAT_OS
// =========
// DOS extended errors:

#define ERRCODE_OSEINVFNC     1        // Invalid function number
#define ERRCODE_OSENOENT      2        // No such file or directory
#define ERRCODE_OSENOPATH     3        // Path not found
#define ERRCODE_OSEMFILE      4        // Too many open files
#define ERRCODE_OSEACCES      5        // Permission denied
#define ERRCODE_OSEBADF       6        // Bad file number
#define ERRCODE_OSECONTR      7        // Memory blocks destroyed
#define ERRCODE_OSENOMEM      8        // Not enough core
#define ERRCODE_OSEINVMEM     9        // Invalid memory block address
#define ERRCODE_OSEINVENV     10       // 0x0a Invalid environment
#define ERRCODE_OSEINVFMT     11       // 0x0b Invalid format
#define ERRCODE_OSEINVACC     12       // 0x0c Invalid access code
#define ERRCODE_OSEINVDAT     13       // 0x0d Invalid data
#define ERRCODE_OSENODEV      15       // 0x0f No such device
#define ERRCODE_OSECURDIR     16       // 0x10 Attempt to remove curdir
#define ERRCODE_OSENOTSAM     17       // 0x11 Not same device
#define ERRCODE_OSENMFILE     18       // 0x12 No more files
#define ERRCODE_OSEINVAL      19       // 0x13 Invalid argument
#define ERRCODE_OSE2BIG       20       // 0x14 Arg list too long
#define ERRCODE_OSENOEXEC     21       // 0x15 Exec format error
#define ERRCODE_OSEXDEV       22       // 0x16 Cross-device link
#define ERRCODE_OSEDOM        33       // 0x21 Math argument
#define ERRCODE_OSERANGE      34       // 0x22 Result to large
#define ERRCODE_OSEEXIST      35       // 0x23 File already exists
#define ERRCODE_OSUNKNOWN     39       // 0x27 Unkown | illegal error from rtl

#define ERRCODE_OSSHAREVIOL   50       // 0x32 Share viol, ext. err 0x20
#define ERRCODE_OSLOCKVIOL    51       // 0x33 Lock viol, ext. err 0x21
#define ERRCODE_OSINT24FAIL   52       // 0x34 INT24 called
#define ERRCODE_OSDRIVENOTREADY   53   // 0x35 Drive not ready

// OTHER Os errors:
// 1. idapi errors
// 2. errors from non-dos systems ( i.e. NOVELL )

#define ERRCODE_NOTEXACT          100       // 0x64 Not exact read/write
#define ERRCODE_OSNETERR          101       // 0x65 Generic network error
#define ERRCODE_OSUNKNOWNSRVERR   102       // 0x66 Error from file server
#define ERRCODE_SERVERNOMEMORY    103       // 0x67 Server out of memory
#define ERRCODE_OSALREADYLOCKED   104       // 0x68 Record already locked (by you)
#define ERRCODE_OSNOTLOCKED       105       // 0x69 Record not locked
#define ERRCODE_NOSERVERSW        106       // 0x6a Server software not running the workstation/server



#define   DBIERR_OSEINVFNC       ( ERRBASE_OS + ERRCODE_OSEINVFNC )
#define   DBIERR_OSENOENT        ( ERRBASE_OS + ERRCODE_OSENOENT )
#define   DBIERR_OSENOPATH       ( ERRBASE_OS + ERRCODE_OSENOPATH )
#define   DBIERR_OSEMFILE        ( ERRBASE_OS + ERRCODE_OSEMFILE )
#define   DBIERR_OSEACCES        ( ERRBASE_OS + ERRCODE_OSEACCES )
#define   DBIERR_OSEBADF         ( ERRBASE_OS + ERRCODE_OSEBADF )
#define   DBIERR_OSECONTR        ( ERRBASE_OS + ERRCODE_OSECONTR )
#define   DBIERR_OSENOMEM        ( ERRBASE_OS + ERRCODE_OSENOMEM )
#define   DBIERR_OSEINVMEM       ( ERRBASE_OS + ERRCODE_OSEINVMEM )
#define   DBIERR_OSEINVENV       ( ERRBASE_OS + ERRCODE_OSEINVENV )
#define   DBIERR_OSEINVFMT       ( ERRBASE_OS + ERRCODE_OSEINVFMT )
#define   DBIERR_OSEINVACC       ( ERRBASE_OS + ERRCODE_OSEINVACC )
#define   DBIERR_OSEINVDAT       ( ERRBASE_OS + ERRCODE_OSEINVDAT )
#define   DBIERR_OSENODEV        ( ERRBASE_OS + ERRCODE_OSENODEV )
#define   DBIERR_OSECURDIR       ( ERRBASE_OS + ERRCODE_OSECURDIR )
#define   DBIERR_OSENOTSAM       ( ERRBASE_OS + ERRCODE_OSENOTSAM )
#define   DBIERR_OSENMFILE       ( ERRBASE_OS + ERRCODE_OSENMFILE )
#define   DBIERR_OSEINVAL        ( ERRBASE_OS + ERRCODE_OSEINVAL )
#define   DBIERR_OSE2BIG         ( ERRBASE_OS + ERRCODE_OSE2BIG )
#define   DBIERR_OSENOEXEC       ( ERRBASE_OS + ERRCODE_OSENOEXEC )
#define   DBIERR_OSEXDEV         ( ERRBASE_OS + ERRCODE_OSEXDEV )
#define   DBIERR_OSEDOM          ( ERRBASE_OS + ERRCODE_OSEDOM )
#define   DBIERR_OSERANGE        ( ERRBASE_OS + ERRCODE_OSERANGE )
#define   DBIERR_OSEEXIST        ( ERRBASE_OS + ERRCODE_OSEEXIST )
#define   DBIERR_OSUNKNOWN       ( ERRBASE_OS + ERRCODE_OSUNKNOWN )
#define   DBIERR_OSSHAREVIOL     ( ERRBASE_OS + ERRCODE_OSSHAREVIOL )
#define   DBIERR_OSLOCKVIOL      ( ERRBASE_OS + ERRCODE_OSLOCKVIOL )
#define   DBIERR_OSNETERR        ( ERRBASE_OS + ERRCODE_OSNETERR )
#define   DBIERR_OSINT24FAIL     ( ERRBASE_OS + ERRCODE_OSINT24FAIL )
#define   DBIERR_OSDRIVENOTREADY ( ERRBASE_OS + ERRCODE_OSDRIVENOTREADY )


#define   DBIERR_NOTEXACT        ( ERRBASE_OS + ERRCODE_NOTEXACT )
#define   DBIERR_OSUNKNOWNSRVERR ( ERRBASE_OS + ERRCODE_OSUNKNOWNSRVERR )
#define   DBIERR_SERVERNOMEMORY  ( ERRBASE_OS + ERRCODE_SERVERNOMEMORY )
#define   DBIERR_OSALREADYLOCKED ( ERRBASE_OS + ERRCODE_OSALREADYLOCKED )
#define   DBIERR_OSNOTLOCKED     ( ERRBASE_OS + ERRCODE_OSNOTLOCKED )
#define   DBIERR_NOSERVERSW      ( ERRBASE_OS + ERRCODE_NOSERVERSW)

// ERRCAT_NETWORK
// ==============

#define ERRCODE_NETINITERR       1        // Net init failed
#define ERRCODE_NETUSERLIMIT     2        // Net user limit exceeded
#define ERRCODE_NETFILEVERSION   3        // Wrong net file version
#define ERRCODE_NETFILELOCKED    4        // Not able to lock net file
#define ERRCODE_DIRNOTPRIVATE    5        //
#define ERRCODE_NETMULTIPLE      6        // Multiple net files in use
#define ERRCODE_NETUNKNOWN       7        // Unknown net error
#define ERRCODE_SHAREDFILE       8        // Cannot access a shared file
#define ERRCODE_SHARENOTLOADED   9        // Share not loaded
#define ERRCODE_NOTONANETWORK    10       // 0x0a Not an Network
#define ERRCODE_SQLCOMMLOST      11       // 0x0b Lost Communication with SQL server
#define ERRCODE_SERVERCOMMLOST   12       // 0x0c Lost Communication with IDAPI server
#define ERRCODE_SQLSERVERNOTFOUND 13      // 0x0d SQL Server not found
#define ERRCODE_SERVERNOTFOUND   14       // 0x0e SQL Server not found

#define DBIERR_NETINITERR        (ERRBASE_NETWORK + ERRCODE_NETINITERR)
#define DBIERR_NETUSERLIMIT      (ERRBASE_NETWORK + ERRCODE_NETUSERLIMIT)
#define DBIERR_NETFILEVERSION    (ERRBASE_NETWORK + ERRCODE_NETFILEVERSION)
#define DBIERR_NETFILELOCKED     (ERRBASE_NETWORK + ERRCODE_NETFILELOCKED)
#define DBIERR_DIRNOTPRIVATE     (ERRBASE_NETWORK + ERRCODE_DIRNOTPRIVATE)
#define DBIERR_NETMULTIPLE       (ERRBASE_NETWORK + ERRCODE_NETMULTIPLE)
#define DBIERR_NETUNKNOWN        (ERRBASE_NETWORK + ERRCODE_NETUNKNOWN)
#define DBIERR_SHAREDFILE        (ERRBASE_NETWORK + ERRCODE_SHAREDFILE)
#define DBIERR_SHARENOTLOADED    (ERRBASE_NETWORK + ERRCODE_SHARENOTLOADED)
#define DBIERR_NOTONANETWORK     (ERRBASE_NETWORK + ERRCODE_NOTONANETWORK)
#define DBIERR_SQLCOMMLOST       (ERRBASE_NETWORK + ERRCODE_SQLCOMMLOST)
#define DBIERR_SERVERCOMMLOST    (ERRBASE_NETWORK + ERRCODE_SERVERCOMMLOST)
#define DBIERR_SQLSERVERNOTFOUND (ERRBASE_NETWORK + ERRCODE_SQLSERVERNOTFOUND)
#define DBIERR_SERVERNOTFOUND    (ERRBASE_NETWORK + ERRCODE_SERVERNOTFOUND)

// ERRCAT_CAPABILITY
// =================

#define  ERRCODE_NOTSUPPORTED    1        // Capability not supported
#define  ERRCODE_NIY             2        // Not Implemented Yet
#define  ERRCODE_TABLESQL        3        // Cannot access SQL replica
#define  ERRCODE_SEARCHCOLREQD   4        // Searchable (Non-blob column) required
#define  ERRCODE_NOMULTCONNECT   5        // Multiple connections not supported
#define  ERRCODE_NODBASEEXPR     6        // Full dBASE Expressions not supported
#define  ERRCODE_NONESTEDTRAN    7        // Nested transactions not supported

#define  DBIERR_NOTSUPPORTED     (ERRBASE_CAPABILITY + ERRCODE_NOTSUPPORTED)
#define  DBIERR_NIY              (ERRBASE_CAPABILITY + ERRCODE_NIY)
#define  DBIERR_TABLESQL         (ERRBASE_CAPABILITY + ERRCODE_TABLESQL)
#define  DBIERR_SEARCHCOLREQD    (ERRBASE_CAPABILITY + ERRCODE_SEARCHCOLREQD)
#define  DBIERR_NOMULTCONNECT    (ERRBASE_CAPABILITY + ERRCODE_NOMULTCONNECT)
#define  DBIERR_NODBASEEXPR      (ERRBASE_CAPABILITY + ERRCODE_NODBASEEXPR)
#define  DBIERR_NONESTEDTRAN     (ERRBASE_CAPABILITY + ERRCODE_NONESTEDTRAN)

// ERRCAT_QUERY
// ============

#define DBICODE_TYPEMISM      95                              // 0x5f
#define DBIERR_TYPEMISM    (ERRBASE_QUERY+DBICODE_TYPEMISM)

#define  DBICODE_CONSTRAINTFAILED    174
#define  DBIERR_CONSTRAINTFAILED (ERRBASE_QUERY+DBICODE_CONSTRAINTFAILED)


#define fldUNKNOWN      0
#define fldZSTRING      1                 // Null terminated string
#define fldDATE         2                 // Date     (32 bit)
#define fldBLOB         3                 // Blob
#define fldBOOL         4                 // Boolean  (16 bit)
#define fldINT16        5                 // 16 bit signed number
#define fldINT32        6                 // 32 bit signed number
#define fldFLOAT        7                 // 64 bit floating point
#define fldBCD          8                 // BCD
#define fldBYTES        9                 // Fixed number of bytes
#define fldTIME         10                // Time        (32 bit)
#define fldTIMESTAMP    11                // Time-stamp  (64 bit)
#define fldUINT16       12                // Unsigned 16 bit integer
#define fldUINT32       13                // Unsigned 32 bit integer
#define fldFLOATIEEE    14                // 80-bit IEEE float
#define fldVARBYTES     15                // Length prefixed var bytes
#define fldLOCKINFO     16                // Look for LOCKINFO typedef
#define fldCURSOR       17                // For Oracle Cursor type
#define fldINT64        18
#define fldUINT64       19

// Object relational data types 
#define fldADT          20                // ADT (Abstract data type)
#define fldARRAY        21                // VARRAY (Variable length array)
#define fldREF          22                // REF (Reference)
#define fldTABLE        23                // NESTED TABLE
#define fldDATETIME     24                // DATE TIME
#define fldFMTBCD       25                // BCD Variant
#define fldSINGLE       27                // 32 bit floating point
#define fldDATETIMEOFFSET 36              // DATE TIME OFFSET

#define MAXLOGFLDTYPES  26                // Number of logical fieldtypes

// Sub Types (Logical)

// fldFLOAT subtype
#define fldstMONEY      21                // Money

// fldBLOB subtypes
#define fldstMEMO          22             // Text Memo
#define fldstBINARY        23             // Binary data
#define fldstFMTMEMO       24             // Formatted Text
#define fldstOLEOBJ        25             // OLE object (Paradox)
#define fldstGRAPHIC       26             // Graphics object
#define fldstDBSOLEOBJ     27             // dBASE OLE object
#define fldstTYPEDBINARY   28             // Typed Binary data

#define fldstACCOLEOBJ     30             // Access OLE object
#define fldstWIDEMEMO      32             // WideString Memo
#define fldstHMEMO         33             // CLOB
#define fldstHBINARY       34             // BLOB

#define fldstBFILE         36             // BFILE

// fldZSTRING subtype
#define fldstPASSWORD      1              // Password
#define fldstFIXED         31             // CHAR type
#define fldstUNICODE       32             // Unicode

// fldINT32 subtype
#define  fldstAUTOINC      29

// fldADT subtype
#define fldstADTNestedTable  35          // ADT for nested table (has no name!)

// fldDATE subtype
#define fldstADTDATE       37             // DATE (OCIDate ) with in an ADT

#define fldstGUID          38

typedef struct
{
    BYTE    iPrecision;          // 1..64 considered valid
    BYTE    iSignSpecialPlaces;  // sign:1, special:1, places:6
    BYTE    iFraction [32];      // bcd nibbles, 00..99 per byte, high nibble 1st
} FMTBcd;

typedef FMTBcd far * pFMTBcd;

typedef enum                              // Compare BookMark Results
   {
      CMPLess           = -1,             // Bkm1 < Bkm2
      CMPEql            = 0,              // BookMarks are exactly the same
      CMPGtr            = 1,              // Bkm1 > Bkm2
      CMPKeyEql         = 2               // Only Bkm1.key_val = Bkm2.key_val
   } CMPBkMkRslt;
typedef CMPBkMkRslt far *pCMPBkMkRslt;

typedef enum                              // Field Val Check type
   {
      fldvNOCHECKS     = 0,                  // Does not have explicit val checks
      fldvHASCHECKS    = 1,                  // One or more val checks on the field
      fldvUNKNOWN      = 2                   // Dont know at this time
   } FLDVchk;

typedef enum                              // Field Rights
   {
      fldrREADWRITE     = 0,                 // Field can be Read/Written
      fldrREADONLY      = 1,                 // Field is Read only
      fldrNONE          = 2,                 // No Rights on this field
      fldrUNKNOWN       = 3                  // Dont know at this time
   } FLDRights;

typedef struct {                          // Field Descriptor
      UINT16         iFldNum;                // Field number (1..n)
      DBINAME        szName;                 // Field name
      UINT16         iFldType;               // Field type
      UINT16         iSubType;               // Field subtype (if applicable)
      INT16          iUnits1;                // Number of Chars, digits etc
      INT16          iUnits2;                // Decimal places etc.
      UINT16         iOffset;                // Offset in the record (computed)
      UINT16         iLen;                   // Length in bytes (computed)
      UINT16         iNullOffset;            // For Null bits (computed)
      FLDVchk        efldvVchk;              // Field Has vcheck (computed)
      FLDRights      efldrRights;            // Field Rights (computed)
      BOOL16         bCalcField;             // Is Calculated field (computed)
      UINT16         iUnUsed[2];
   } FLDDesc;
typedef FLDDesc far *pFLDDesc;

#ifdef _UNIX
typedef int SHAREDMEMID;
// shared Memory Structure, named SAFEARRAY for compatability with windows.
typedef struct {
      UINT               cElements;
      int                lLbound;
   } SAFEARRAYBOUND;

typedef struct {
      UINT16              cDims;
      UINT16              fFeatures;
      UINT                cbElements;
      UINT                cLocks;
      pVOID               pvData;
      SAFEARRAYBOUND      rgsabound[1];
      SHAREDMEMID         ShmId;
   } SAFEARRAY;
typedef SAFEARRAY *pSAFEARRAY;

#ifndef HRESULT
   #define HRESULT   int
#endif
   #define S_OK                   0
   #define E_OUTOFMEMORY          1
   #define E_INVALIDARG           2
   #define DISP_E_ARRAYISLOCKED   3
   #define DISP_E_BADINDEX        4
   #define E_UNABLETOLOADICU        5
#endif

#ifdef __cplusplus
   }
#endif // __cplusplus
#endif //BDETYPES_H

