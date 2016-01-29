unit gtWinCrypt;

{$I jediapilib.inc}

interface

uses
  gtJwaWinCrypt, gtJwaWinType;

const
  advapi32 = 'advapi32.dll';
  crypt32 = 'crypt32.dll';
  
//+=========================================================================
//  PFX (PKCS #12) function defintions and types
//==========================================================================


//+-------------------------------------------------------------------------
//      PFXImportCertStore
//
//  Import the PFX blob and return a store containing certificates
//
//  If the password parameter is incorrect or any other problems decoding
//  the PFX blob are encountered, the function will return NULL and the
//      error code can be found from GetLastError().
//
//  The dwFlags parameter may be set to the following:
//  CRYPT_EXPORTABLE - specify that any imported keys should be marked as
//                     exportable (see documentation on CryptImportKey)
//  CRYPT_USER_PROTECTED - (see documentation on CryptImportKey)
//  CRYPT_MACHINE_KEYSET - used to force the private key to be stored in the
//                        the local machine and not the current user.
//  CRYPT_USER_KEYSET - used to force the private key to be stored in the
//                      the current user and not the local machine, even if
//                      the pfx blob specifies that it should go into local
//                      machine.
//--------------------------------------------------------------------------

function PFXImportCertStore(pPFX :PCRYPT_DATA_BLOB; szPassword: LPCWSTR; dwFlags: DWORD):
  HCERTSTORE; stdcall;
{$EXTERNALSYM PFXImportCertStore}

// dwFlags definitions for PFXImportCertStore
//#define CRYPT_EXPORTABLE        0x00000001  // CryptImportKey dwFlags
//#define CRYPT_USER_PROTECTED    0x00000002  // CryptImportKey dwFlags
//#define CRYPT_MACHINE_KEYSET    0x00000020  // CryptAcquireContext dwFlags

const
CRYPT_USER_KEYSET  = $00001000 ;
PKCS12_IMPORT_RESERVED_MASK = $ffff0000;


//+-------------------------------------------------------------------------
//      PFXIsPFXBlob
//
//  This function will try to decode the outer layer of the blob as a pfx
//  blob, and if that works it will return TRUE, it will return FALSE otherwise
//
//--------------------------------------------------------------------------
function PFXIsPFXBlob(pPFX: PCRYPT_DATA_BLOB): BOOL; stdcall
{$EXTERNALSYM PFXIsPFXBlob}

//+-------------------------------------------------------------------------
//      PFXVerifyPassword
//
//  This function will attempt to decode the outer layer of the blob as a pfx
//  blob and decrypt with the given password. No data from the blob will be
//  imported.
//
//  Return value is TRUE if password appears correct, FALSE otherwise.
//
//--------------------------------------------------------------------------

function PFXVerifyPassword(pPFX: PCRYPT_DATA_BLOB; szPassword: LPCWSTR;
  dwFlags: DWORD): BOOL; stdcall
{$EXTERNALSYM PFXVerifyPassword}

//+-------------------------------------------------------------------------
//      PFXExportCertStoreEx
//
//  Export the certificates and private keys referenced in the passed-in store
//
//  This API encodes the blob under a stronger algorithm. The resulting
//  PKCS12 blobs are incompatible with the earlier PFXExportCertStore API.
//
//  The value passed in the password parameter will be used to encrypt and
//  verify the integrity of the PFX packet. If any problems encoding the store
//  are encountered, the function will return FALSE and the error code can
//  be found from GetLastError().
//
//  The dwFlags parameter may be set to any combination of
//      EXPORT_PRIVATE_KEYS
//      REPORT_NO_PRIVATE_KEY
//      REPORT_NOT_ABLE_TO_EXPORT_PRIVATE_KEY
//
//  The encoded PFX blob is returned in *pPFX. If pPFX->pbData is NULL upon
//  input, this is a length only calculation, whereby, pPFX->cbData is updated
//  with the number of bytes required for the encoded blob. Otherwise,
//  the memory pointed to by pPFX->pbData is updated with the encoded bytes
//  and pPFX->cbData is updated with the encoded byte length.
//--------------------------------------------------------------------------

function PFXExportCertStoreEx(hStore: HCERTSTORE; var pPFX: PCRYPT_DATA_BLOB;
  szPassword: LPCWSTR; pvReserved: LPVOID; dwFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM PFXExportCertStoreEx}

// dwFlags definitions for PFXExportCertStoreEx
const
REPORT_NO_PRIVATE_KEY  = $0001;
REPORT_NOT_ABLE_TO_EXPORT_PRIVATE_KEY = $0002;
EXPORT_PRIVATE_KEYS                   = $0004;
PKCS12_EXPORT_RESERVED_MASK           = $ffff0000;


//+-------------------------------------------------------------------------
//      PFXExportCertStore
//
//  Export the certificates and private keys referenced in the passed-in store
//
//  This is an old API kept for compatibility with IE4 clients. New applications
//  should call the above PfxExportCertStoreEx for enhanced security.
//--------------------------------------------------------------------------

function PFXExportCertStore(hStore: HCERTSTORE; var pPFX: PCRYPT_DATA_BLOB;
    szPassword: LPCWSTR; dwFlags: DWORD): BOOL; stdcall;
{$EXTERNALSYM PFXExportCertStore}




// dwFlags has the following defines
const
  CRYPT_STRING_BASE64HEADER                 = $00000000;
  CRYPT_STRING_BASE64                       = $00000001;
  CRYPT_STRING_BINARY                       = $00000002;
  CRYPT_STRING_BASE64REQUESTHEADER          = $00000003;
  CRYPT_STRING_HEX                          = $00000004;
  CRYPT_STRING_HEXASCII                     = $00000005;
  CRYPT_STRING_BASE64_ANY                   = $00000006;
  CRYPT_STRING_ANY                          = $00000007;
  CRYPT_STRING_HEX_ANY                      = $00000008;
  CRYPT_STRING_BASE64X509CRLHEADER          = $00000009;
  CRYPT_STRING_HEXADDR                      = $0000000a;
  CRYPT_STRING_HEXASCIIADDR                 = $0000000b;

  CRYPT_STRING_NOCR                         = DWORD($80000000);


implementation

{$IFDEF DYNAMIC_LINK}

var
  _PFXImportCertStore: Pointer;

function PFXImportCertStore;
begin
  GetProcedureAddress(_PFXImportCertStore, advapi32, 'PFXImportCertStore');
  asm
        MOV     ESP, EBP
        POP     EBP
        JMP     [_PFXImportCertStore]
  end;
end;

var
  _PFXIsPFXBlob: Pointer;

function PFXIsPFXBlob;
begin
  GetProcedureAddress(_PFXIsPFXBlob, advapi32, 'PFXIsPFXBlob');
  asm
        MOV     ESP, EBP
        POP     EBP
        JMP     [_PFXIsPFXBlob]
  end;
end;

var
  _PFXVerifyPassword: Pointer;

function PFXVerifyPassword;
begin
  GetProcedureAddress(_PFXVerifyPassword, advapi32, 'PFXVerifyPassword');
  asm
        MOV     ESP, EBP
        POP     EBP
        JMP     [_PFXVerifyPassword]
  end;
end;

var
  _PFXExportCertStoreEx: Pointer;

function PFXExportCertStoreEx;
begin
  GetProcedureAddress(_PFXExportCertStoreEx, advapi32, 'PFXExportCertStoreEx');
  asm
        MOV     ESP, EBP
        POP     EBP
        JMP     [_PFXExportCertStoreEx]
  end;
end;

var
  _PFXExportCertStore: Pointer;

function PFXExportCertStore;
begin
  GetProcedureAddress(_PFXExportCertStore, advapi32, 'PFXExportCertStore');
  asm
        MOV     ESP, EBP
        POP     EBP
        JMP     [_PFXExportCertStore]
  end;
end;
{$ENDIF DYNAMIC_LINK}
function PFXImportCertStore; external crypt32 name 'PFXImportCertStore';
function PFXIsPFXBlob; external crypt32 name 'PFXIsPFXBlob';
function PFXVerifyPassword; external crypt32 name 'PFXVerifyPassword';
function PFXExportCertStoreEx; external crypt32 name 'PFXExportCertStoreEx';
function PFXExportCertStore; external crypt32 name 'PFXExportCertStore';

end.
