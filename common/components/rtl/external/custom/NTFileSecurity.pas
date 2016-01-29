unit NTFileSecurity;
{
TNTFileSecurity component for Delphi 4 (version 1.0)
----------------------------------------------------
Copyright (c) 1999 by David A. Bussey


Version Info
------------

v1.0
  - Initial release.

There are still a few things that can be improved.  If you have any suggestions
for improvements please let me know your ideas.  If they are possible, I will
try and include them in later versions.

(you can reach me at dbussey@bluegrass.net)

TNTFileSecurity is FREEWARE.  It is supplied as is, without warranty of any kind.
Use it at your own risk.  Any components derived from TNTFileSecurity must also be
FREEWARE.  You may use TNTFileSecurity in both private and commercial applications
without any fees or royalties.  No person/persons may redistribute TNTFileSecurity
as their own or for any profit whatsoever.  If you redistribute TNTFileSecurity
you must supply the files in their original un-altered states.

TNTFileSecurity is designed to run in the Windows NT operating system.  The
necessary funtions will not work under Windows 95/98 however, software
using TNTFileSecurity can be designed in these operating environments and
should work correctly when installed on a Windows NT machine.

These are the most common error codes that can occur, and their
most likely causes (They are returned by the OnGetSecurity and
OnSetSecurity events):

ERROR_ACL_NOT_SUPPORTED : "The file system does not support Access Control Lists."

The drive or partition in question does not support Access
Control Lists and specific access rights cannot be read or
set by inherent Windows NT methods.

ERROR_CALL_NOT_IMPLEMENTED : "This function is only valid in Win32 mode."

This error occurs when you are not running in the Windows NT
operating environment.

ERROR_NO_SECURITY_INFO : "The object has no security information."

The requested file or directory has an empty Access Control List.
No access rights are specified for any user, group or system account.

ERROR_FILE_NOT_FOUND : "The system cannot find the file specified."

The file or directory specified in TNTFileSecurity.FileName cannot be
located.

ERROR_ACCESS_DENIED  : "Access is denied."

Just like it says...


If, by some odd chance, you get this error code...
ERROR_INVALID_NAME  :  "The filename, directory name, or volume label
                           syntax is incorrect."

This error will occur when attempting to read file security
when TNTFileSecurity.FileName is an empty string.  You should
not get this error, but just in case...
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

{BEGIN OPTIONAL DEFINES}
// If you are working with "Windows 2000" (A.k.a. Windows NT 5.0)
// defining WINVER5 allows TNTFileSecurity to work with NT5's Deny Access
// Control Entries which are unsupported under earlier versions of NT.
// Earlier NT versions assume that which is not specifcally allowed is denied.
// TNTFileSecurity can still use Access Denied ACEs on NT 4 however, the
// operating system will be unable to read the security information.

// I have left this undefined to reduce the risk of accidentally making access
// rights unreadable by NT 4.

{$DEFINE WINVER5}

{END OPTIONAL DEFINES}

const
 ACL_REVISION                    =2;
 DNLEN                           =15;  // Domain name length
 CNLEN                           =15;  // Computer name length
 UNLEN                           =256; // Maximum user name length

 SECURITY_DESCRIPTOR_MAX_LENGTH  =65536 + SECURITY_DESCRIPTOR_MIN_LENGTH;

// ACE types
 ACCESS_ALLOWED_ACE_TYPE         =0;
 ACCESS_DENIED_ACE_TYPE          =1;
 SYSTEM_AUDIT_ACE_TYPE           =2;
 SYSTEM_ALARM_ACE_TYPE           =3;

// ACE inherit flags
 OBJECT_INHERIT_ACE              =$1;
 CONTAINER_INHERIT_ACE           =$2;
 NO_PROPAGATE_INHERIT_ACE        =$4;
 INHERIT_ONLY_ACE                =$8;
 VALID_INHERIT_FLAGS             =$F;
 SUCCESSFUL_ACCESS_ACE_FLAG      =$40;
 FAILED_ACCESS_ACE_FLAG          =$80;

// Access Types
 FILE_READ_DATA                  =$0001;     // file & pipe
 FILE_LIST_DIRECTORY             =$0001;     // directory
 FILE_WRITE_DATA                 =$0002;     // file & pipe
 FILE_ADD_FILE                   =$0002;     // directory
 FILE_APPEND_DATA                =$0004;     // file
 FILE_ADD_SUBDIRECTORY           =$0004;     // directory
 FILE_CREATE_PIPE_INSTANCE       =$0004;     // named pipe
 FILE_READ_EA                    =$0008;     // file & directory
 FILE_READ_PROPERTIES            =FILE_READ_EA;
 FILE_WRITE_EA                   =$0010;     // file & directory
 FILE_WRITE_PROPERTIES           =FILE_WRITE_EA;
 FILE_EXECUTE                    =$0020;     // file
 FILE_TRAVERSE                   =$0020;     // directory
 FILE_DELETE_CHILD               =$0040;     // directory
 FILE_READ_ATTRIBUTES            =$0080;     // all
 FILE_WRITE_ATTRIBUTES           =$0100;     // all
 FILE_ALL_ACCESS                 =(STANDARD_RIGHTS_REQUIRED Or SYNCHRONIZE Or $1FF);
 FILE_GENERIC_READ               =(STANDARD_RIGHTS_READ Or FILE_READ_DATA Or FILE_READ_ATTRIBUTES Or FILE_READ_EA Or SYNCHRONIZE);
 FILE_GENERIC_WRITE              =(STANDARD_RIGHTS_WRITE Or FILE_WRITE_DATA Or FILE_WRITE_ATTRIBUTES Or FILE_WRITE_EA Or FILE_APPEND_DATA Or SYNCHRONIZE);
 FILE_GENERIC_EXECUTE            =(STANDARD_RIGHTS_EXECUTE Or FILE_READ_ATTRIBUTES Or FILE_EXECUTE Or SYNCHRONIZE);
 GENERIC_NONE                    =$00000000;

 ERROR_NO_SECURITY_INFO          =MAXDWORD;
 ERROR_ACL_NOT_SUPPORTED         =MAXDWORD - 1;

 ERROR_NONE                      =$0000;
 ERROR_GET_FILE_SECURITY         =$0001;
 ERROR_GET_DACL                  =$0002;
 ERROR_GET_ACE_COUNT             =$0003;
 ERROR_GET_ACE                   =$0004;
 ERROR_GET_ACCOUNT_NAME          =$0005;
 ERROR_INITIALIZE_ACL            =$0006;
 ERROR_GET_ACCOUNT_SID           =$0007;
 ERROR_ADD_ALLOWED_ACE           =$0008;
 ERROR_ADD_DENIED_ACE            =$0009;
 ERROR_INITIALIZE_SD             =$000A;
 ERROR_SET_DACL                  =$000B;
 ERROR_SET_SD                    =$000C;
 ERROR_UNKNOWN_DRIVE_TYPE        =$000D;
 ERROR_INVALID_ROOT              =$000E;
 ERROR_RESERVED_1                =$000F;

// Type Definitions
type
  TFileAccess = (faRead,
                 faWrite,
                 faExecute,
                 faDelete,
                 faChangePermissions,
                 faTakeOwnership,
                 faAll);

  TAccessSet = set of TFileAccess;

type
  SecurityEntry = (seNone,
                   seUser,
                   seGroup,
                   seDomain,
                   seAlias,
                   seWellKnownGroup,
                   seDeletedAcount,
                   seInvalid,
                   seUnknown);

// ACE Types
type
  PACE_HEADER = ^ACE_HEADER;
  ACE_HEADER = record
    AceType  : BYTE;
    AceFlags : BYTE;
    AceSize  : WORD;
  end;

type
  PACCESS_ALLOWED_ACE = ^ACCESS_ALLOWED_ACE;
  ACCESS_ALLOWED_ACE = record
    Header:   ACE_HEADER;
    Mask:     ACCESS_MASK;
    SidStart: DWORD;
  end;

type
  PACCESS_DENIED_ACE = ^ACCESS_DENIED_ACE;
  ACCESS_DENIED_ACE = record
    Header   : ACE_HEADER;
    Mask     : ACCESS_MASK;
    SidStart : DWORD;
  end;

type
  ACL_SIZE_INFORMATION = record
    AceCount: DWORD;
    AclBytesInUse: DWORD;
    AclBytesFree: DWORD;
  end;

type
  EFileSecurityError = class(Exception);

type
  PSecurityListItem = ^TSecurityListItem;
  TSecurityListItem = record
    Name: string;
    ServerName: string;
    EntryType: SecurityEntry;
    FileAllowed : TAccessSet;
    DirectoryAllowed : TAccessSet;
    {$IFDEF WINVER5}
      FileDenied : TAccessSet;
      DirectoryDenied : TAccessSet;
    {$ENDIF}
  end;

type
  TNTFileSecurityEvent = procedure(Sender: TObject; Error, Location: DWORD) of object;

type
  TNTFileSecurity = class(TComponent)
  private
    { Private declarations }
    FACEList: TList;
    FEntries: TStrings;
    FIsFile: Boolean;
    FIsDirectory: Boolean;
    FIsRemoteDrive: Boolean;
    FFileName: string;
    FVolumeName: string;
    FFileSystemName: string;
    FSystemName: string;
    FLocalMachineName: string;
    FSerialNumber: DWORD;
    FEntryCount: integer;
    FOnGetSecurity: TNTFileSecurityEvent;
    FOnSetSecurity: TNTFileSecurityEvent;
    function CalculateACLSize: DWORD;
    procedure ValidateIndex(Index: integer);
    function GetEntryName(Index: Integer): string;
    function GetServerName(Index: Integer): string;
    function GetEntryType(Index: Integer): SecurityEntry;
    function GetFileAllowedRights(Index: Integer): TAccessSet;
    procedure SetFileAllowedRights(Index: Integer; Value: TAccessSet);
    function GetDirAllowedRights(Index: Integer): TAccessSet;
    procedure SetDirAllowedRights(Index: Integer; Value: TAccessSet);
    procedure SetFileName(Value: string);
    {$IFDEF WINVER5}
    function GetFileDeniedRights(Index: Integer): TAccessSet;
    procedure SetFileDeniedRights(Index: Integer; Value: TAccessSet);
    function GetDirDeniedRights(Index: Integer): TAccessSet;
    procedure SetDirDeniedRights(Index: Integer; Value: TAccessSet);
    {$ENDIF}
  protected
    { Protected declarations }
    INFO: ^ACL_SIZE_INFORMATION;
    function GetACECount(AN_ACL: PACL; var Count: DWORD): DWORD;
    function GetACLSize(AN_ACL: PACL; var AclSize: DWORD): DWORD;
    procedure RaiseError(Msg: string);
    procedure DoOnGetSecurity(ErrorCode, Location: DWORD);
    procedure DoOnSetSecurity(ErrorCode, Location: DWORD);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMessageString(ErrorCode, Location: DWORD): string;
    function AddEntry(ServerName, Name: string): Integer;
    procedure RemoveEntry(Index: integer);
    procedure RefreshSecurity;
    procedure SetSecurity;
    procedure ClearAll(Index: integer);
    procedure GrantAll(Index: integer);
    {$IFDEF WINVER5}
    procedure DenyAll(Index: integer);
    property DeniedDirectoryRights[Index: integer] : TAccessSet read GetDirDeniedRights write SetDirDeniedRights;
    property DeniedFileRights[Index: integer] : TAccessSet read GetFileDeniedRights write SetFileDeniedRights;
    {$ENDIF}
    property FileName : string read FFileName write SetFileName;
    property HostName: string read FSystemName;
    property VolumeName: string read FVolumeName;
    property FileSystemName: string read FFileSystemName;
    property LocalMachine: string read FLocalMachineName;
    property VolumeSerialNumber: DWORD read FSerialNumber;
    property Entries : TStrings read FEntries;
    property EntryCount : Integer read FEntryCount;
    property EntryName [Index: integer] : string read GetEntryName;
    property ServerName[Index: integer] : string read GetServerName;
    property EntryType [Index: integer] : SecurityEntry read GetEntryType;
    property FileRights[Index: integer] : TAccessSet read GetFileAllowedRights write SetFileAllowedRights;
    property DirectoryRights[Index: integer] : TAccessSet read GetDirAllowedRights write SetDirAllowedRights;
  published
    { Published declarations }
    property Tag;
    property OnGetSecurity: TNTFileSecurityEvent read FOnGetSecurity write FOnGetSecurity;
    property OnSetSecurity: TNTFileSecurityEvent read FOnSetSecurity write FOnSetSecurity;
  end;

procedure Register;

implementation

uses stNetAPI;

procedure Register;
begin
  RegisterComponents('Custom', [TNTFileSecurity]);
end;

function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

procedure TNTFileSecurity.RaiseError(Msg: string);
begin
  raise EFileSecurityError.Create(Msg);
end;

constructor TNTFileSecurity.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FACEList := TList.Create;
  FACEList.Capacity := 10;
  // Just a general setting... the TList will allocate more as needed

  FEntries := TStringList.Create;
end;

destructor TNTFileSecurity.Destroy;
var
  x: integer;
  NewItem: PSecurityListItem;
begin
  for x := Pred(FACEList.Count) downto 0 do begin
    NewItem := FACEList.Items[x];
    Dispose(NewItem);
    FACEList.Delete(x);
  end;
  FEntries.Free;
  FACEList.Free;
  inherited Destroy;
end;

function TNTFileSecurity.GetMessageString(ErrorCode, Location: DWORD): string;
var
  a: array [0..1023] of Char;
//  LocStr: string;
begin
  if ErrorCode = 0 then begin
    Result := 'Operation was successfull.';
  end else begin

    case ErrorCode of
      ERROR_NO_SECURITY_INFO  : StrPCopy(a,'The object has no security information.');
      ERROR_ACL_NOT_SUPPORTED : StrPCopy(a,'The file system does not support Access Control Lists.');
      ERROR_UNKNOWN_DRIVE_TYPE: StrPCopy(a,'Unable to determine drive type.');
      ERROR_INVALID_ROOT      : StrPCopy(a,'The root directory does not exist.');
    else
      FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,ErrorCode,0,a,1024,nil);
    end;

//    case Location of
//      ERROR_NONE              : LocStr := '';
//      ERROR_GET_FILE_SECURITY : LocStr := 'Retrieving file security information.';
//      ERROR_GET_DACL          : LocStr := 'Retrieving Access Control List.';
//      ERROR_GET_ACE_COUNT     : LocStr := 'Retrieving number of Access Control Entries.';
//      ERROR_GET_ACE           : LocStr := 'Retrieving Access Control Entry.';
//      ERROR_GET_ACCOUNT_NAME  : LocStr := 'Retrieving account name.';
//      ERROR_INITIALIZE_ACL    : LocStr := 'Initializing Access Control List.';
//      ERROR_GET_ACCOUNT_SID   : LocStr := 'Retrieving account Security Identifier.';
//      ERROR_ADD_ALLOWED_ACE   : LocStr := 'Adding Access Allowed ACE.';
//      ERROR_ADD_DENIED_ACE    : LocStr := 'Adding Access Denied ACE.';
//      ERROR_INITIALIZE_SD     : LocStr := 'Initializing Security Descriptor.';
//      ERROR_SET_DACL          : LocStr := 'Setting new Access Control List in Security Descriptor.';
//      ERROR_SET_SD            : LocStr := 'Adding new Security Descriptor to object.';
//      else
//        LocStr := 'Unknown function call!';
//    end;

    Result := StrPas(a){ + '(' + LocStr + ')'};
  end;
end;

procedure TNTFileSecurity.DoOnGetSecurity(ErrorCode, Location: DWORD);
begin
  if Assigned(FOnGetSecurity) then
    FOnGetSecurity(Self, ErrorCode, Location);
end;

procedure TNTFileSecurity.DoOnSetSecurity(ErrorCode, Location: DWORD);
begin
  if Assigned(FOnSetSecurity) then
    FOnSetSecurity(Self, ErrorCode, Location);
end;

procedure TNTFileSecurity.ValidateIndex(Index: integer);
begin
  if (Index < 0) or (Index >= FACEList.Count) then
    RaiseError('Index ['+IntToStr(Index)+'] is out of bounds.');
end;

function TNTFileSecurity.GetEntryName(Index: integer) : string;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.Name;
end;

function TNTFileSecurity.GetServerName(Index: integer) : string;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.ServerName;
end;

function TNTFileSecurity.GetEntryType(Index: integer) : SecurityEntry;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.EntryType;
end;

function TNTFileSecurity.GetFileAllowedRights(Index: Integer): TAccessSet;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.FileAllowed;
end;

procedure TNTFileSecurity.SetFileAllowedRights(Index: Integer; Value: TAccessSet);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  if Value <> LI^.FileAllowed then
    LI^.FileAllowed := Value;
end;

function TNTFileSecurity.GetDirAllowedRights(Index: Integer): TAccessSet;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.DirectoryAllowed;
end;

procedure TNTFileSecurity.SetDirAllowedRights(Index: Integer; Value: TAccessSet);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  if Value <> LI^.DirectoryAllowed then
    LI^.DirectoryAllowed := Value;
end;

{$IFDEF WINVER5}

function TNTFileSecurity.GetFileDeniedRights(Index: Integer): TAccessSet;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.FileDenied;
end;

procedure TNTFileSecurity.SetFileDeniedRights(Index: Integer; Value: TAccessSet);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  if Value <> LI^.FileDenied then
    LI^.FileDenied := Value;
end;

function TNTFileSecurity.GetDirDeniedRights(Index: Integer): TAccessSet;
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  Result := LI^.DirectoryDenied;
end;

procedure TNTFileSecurity.SetDirDeniedRights(Index: Integer; Value: TAccessSet);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  if Value <> LI^.DirectoryDenied then
    LI^.DirectoryDenied := Value;
end;

procedure TNTFileSecurity.DenyAll(Index: integer);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  if FIsDirectory then begin
    LI^.DirectoryAllowed := [];
    LI^.DirectoryDenied := [faAll];
    LI^.FileAllowed := [];
    LI^.FileDenied := [faAll];
  end else begin
    if FIsFile then begin
      LI^.FileAllowed := [];
      LI^.FileDenied := [faAll];
    end;
  end;
end;

{$ENDIF}

function ExtractServerName(RootName: PChar): string;
var
  Temp: string;
  x: integer;
begin
  Result := '';
  Temp := StrPas(RootName);
  for x := 3 to (Length(Temp)-3) do begin
    if Temp[x] = '\' then Break
    else Result := Result + Temp[x];
  end;
end;

procedure TNTFileSecurity.SetFileName(Value: string);
var
 Res: NET_API_STATUS;
 SInfo: Pointer;
 STmp: string;
  RP: string;

  TempName: array [0..CNLEN] of Char;
  VolName, SystemName, RootPath: array [0..255] of Char;

  VolNameLen, SerialNo, CompLen, VolFlags,
  SysNameLen, RemoteNameLen, dwRes, TempNameLen : DWORD;
  DriveType: UINT;
  x: integer;
  
  pRemName: Pointer;
  NewItem: PSecurityListItem;
  RemName: ^REMOTE_NAME_INFO;
begin
  if Value <> FFileName then begin
    TempNameLen := CNLEN + 1;
    GetComputerName(TempName,TempNameLen);
    FLocalMachineName := StrPas(TempName);
    FSystemName := FLocalMachineName;
    FVolumeName := '';
    FFileSystemName := '';
    FSerialNumber := 0;
    FIsFile := False;
    FIsDirectory := False;
    FIsRemoteDrive := False;
    ZeroMemory(@RootPath,SizeOf(RootPath));
    ZeroMemory(@VolName,SizeOf(VolName));
    ZeroMemory(@SystemName,SizeOf(SystemName));
    pRemName := nil;
    VolNameLen := SizeOf(VolName);
    SysNameLen := SizeOf(SystemName);
    RP := ExtractFileDrive(Value);
    if RP = Value then
      Value := Value + '\';
    StrPCopy(RootPath,RP+'\');

    DriveType := GetDriveType(RootPath);
    case DriveType of
      0 : begin
            FFileName := '';
            DoOnGetSecurity(ERROR_UNKNOWN_DRIVE_TYPE,0);
            Exit;
          end;
      1 : begin
            FFileName := '';
            DoOnGetSecurity(ERROR_INVALID_ROOT,0);
            Exit;
          end;
      DRIVE_REMOTE : begin
                       FIsRemoteDrive := True;
                       if Copy(RP,1,2) <> '\\' then
                       begin
                         ReallocMem(pRemName,RemoteNameLen);
                         try
                           WNetGetUniversalName(@RootPath,REMOTE_NAME_INFO_LEVEL,
                                 pRemName,RemoteNameLen);
                           ReallocMem(pRemName,RemoteNameLen);
                           WNetGetUniversalName(@RootPath,REMOTE_NAME_INFO_LEVEL,
                                 pRemName,RemoteNameLen);
                           RemName := pRemName;
                           FSystemName := ExtractServerName(RemName^.lpConnectionName);
                           StrPCopy(RootPath,StrPas(RemName^.lpConnectionName)+
                                             StrPas(RemName^.lpRemainingPath));
                         except
                         end;
                         ReallocMem(pRemName,0);
                       end
                       else
                       begin
                        STmp := '\\'+ExtractServerName(PChar(RP));
                        Res := StNetServerGetInfo(STmp, 100, SInfo);
                        if Res = NO_ERROR then
                        begin
                         FSystemName := WideString(PSERVER_INFO_100(SInfo)^.sv100_name);
                        end;
                       end;
                     end;
    end;

    if not GetVolumeInformation(RootPath,VolName,VolNameLen,@SerialNo,CompLen,
                                             VolFlags,SystemName,SysNameLen) then begin
      dwRes := GetLastError;
      FFileName := '';
      DoOnGetSecurity(dwRes,0);
      Exit;
    end;

    FSerialNumber := SerialNo;
    FVolumeName := StrPas(VolName);
    FFileSystemName := StrPas(SystemName);
    FIsFile := FileExists(Value);
    FIsDirectory := SysUtils.DirectoryExists(Value);

    if (VolFlags and FS_PERSISTENT_ACLS) <= 0 then begin
      // If there are entries in the list, dispose of them.
      if FACEList.Count > 0 then begin
        FEntries.Clear;
        for x := Pred(FACEList.Count) downto 0 do begin
          NewItem := FACEList.Items[x];
          Dispose(NewItem);
          FACEList.Delete(x);
        end;
        FACEList.Clear;
      end;
      FFileName := '';
      DoOnGetSecurity(ERROR_ACL_NOT_SUPPORTED,0);
    end else
      FFileName := Value;

    if FFileName <> '' then
      RefreshSecurity;
  end;
end;

procedure TNTFileSecurity.ClearAll(Index: integer);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  LI^.DirectoryAllowed := [];
  LI^.FileAllowed := [];
  {$IFDEF WINVER5}
  LI^.DirectoryDenied := [];
  LI^.FileDenied := [];
  {$ENDIF}
end;

procedure TNTFileSecurity.GrantAll(Index: integer);
var
  LI: PSecurityListItem;
begin
  ValidateIndex(Index);
  LI := FACEList.Items[Index];
  if FIsDirectory then begin
    LI^.DirectoryAllowed := [faAll];
    LI^.FileAllowed := [faAll];
    {$IFDEF WINVER5}
    LI^.DirectoryDenied := [];
    LI^.FileDenied := [];
    {$ENDIF}
  end else begin
    if FIsFile then begin
      LI^.FileAllowed := [faAll];
     {$IFDEF WINVER5}
      LI^.FileDenied := [];
     {$ENDIF}
    end;
  end;
end;

procedure TNTFileSecurity.RemoveEntry(Index: integer);
var
  LI: PSecurityListItem;
begin
  LI := FACEList.Items[Index];
  Dispose(LI);
  FACEList.Delete(Index);
  FEntries.Delete(Index);
  FEntryCount := FACEList.Count;
end;

function TNTFileSecurity.AddEntry(ServerName, Name: string): Integer;
var
  LI: PSecurityListItem;
  NewSID: PSID;
  NewSIDLen, RefDomLen, dwRes: DWORD;
  RefDomain: array [0..DNLEN] of Char;
  SIDType: SID_NAME_USE;
  a: array [0..1023] of Char;
begin
  NewSIDLen := 0;
  RefDomLen := SizeOf(RefDomain);
  if not LookupAccountName(PChar(ServerName),PChar(Name),nil,NewSIDLen,RefDomain,RefDomLen,SIDType) then begin
    dwRes := GetLastError;
    if dwRes <> ERROR_INSUFFICIENT_BUFFER then begin
      FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
      RaiseError(a);
    end;
  end;

  NewSID := AllocMem(NewSIDLen);

  if not LookupAccountName(PChar(ServerName),PChar(Name),NewSID,NewSIDLen,RefDomain,RefDomLen,SIDType) then begin
    dwRes := GetLastError;
    FreeMem(NewSID);
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    RaiseError(a);
  end;

  New(LI);
  LI^.Name := Name;

  if (UpperCase(StrPas(RefDomain)) = 'BUILTIN') or (UpperCase(StrPas(RefDomain)) = '')
                                        or (UpperCase(StrPas(RefDomain)) = 'NT AUTHORITY') then
    LI^.ServerName := ServerName
  else
    LI^.ServerName := StrPas(RefDomain);

  case SIDType of
    SidTypeUser           : LI^.EntryType := seUser;
    SidTypeGroup          : LI^.EntryType := seGroup;
    SidTypeDomain         : LI^.EntryType := seDomain;
    SidTypeAlias          : LI^.EntryType := seAlias;
    SidTypeWellKnownGroup : LI^.EntryType := seWellKnownGroup;
    SidTypeDeletedAccount : LI^.EntryType := seDeletedAcount;
    SidTypeInvalid        : LI^.EntryType := seInvalid;
    SidTypeUnknown        : LI^.EntryType := seUnknown;
  end;
  LI^.FileAllowed := [];
  LI^.DirectoryAllowed := [];
  {$IFDEF WINVER5}
  LI^.FileDenied := [];
  LI^.DirectoryDenied := [];
  {$ENDIF}
  FreeMem(NewSID);
  FEntries.Add(LI^.Name);
  FEntryCount := FACEList.Count;
  Result := FACEList.Add(LI);
end;

function TNTFileSecurity.GetACECount(AN_ACL: PACL; var Count: DWORD): DWORD;
var
  INFO_SIZE: DWORD;
begin
  New(INFO);
  INFO_SIZE := SizeOf(ACL_SIZE_INFORMATION);
  if not GetAclInformation(AN_ACL^,INFO,INFO_SIZE,AclSizeInformation) then begin
    Count := 0;
    Result := GetLastError;
  end else begin
    Count := INFO^.AceCount;
    Result := ERROR_SUCCESS;
  end;
  Dispose(INFO);
end;

function TNTFileSecurity.GetACLSize(AN_ACL: PACL; var AclSize: DWORD): DWORD;
var
  INFO_SIZE: DWORD;
begin
  New(INFO);
  INFO_SIZE := SizeOf(ACL_SIZE_INFORMATION);
  if not GetAclInformation(AN_ACL^,INFO,INFO_SIZE,AclSizeInformation) then begin
    AclSize := 0;
    Result := GetLastError;
  end else begin
    AclSize := INFO^.AclBytesInUse;
    Result := ERROR_SUCCESS;
  end;
  Dispose(INFO);
end;

function GetFileGenericSecurity(Mask: DWORD): TAccessSet;
begin
  Result := [];
  if Mask = FILE_ALL_ACCESS then
    Result := [faAll]
  else begin
    if (Mask and FILE_GENERIC_READ) = FILE_GENERIC_READ then
      Result := Result + [faRead];
    if (Mask and FILE_GENERIC_WRITE) = FILE_GENERIC_WRITE then
      Result := Result + [faWrite];
    if (Mask and FILE_GENERIC_EXECUTE) = FILE_GENERIC_EXECUTE then
      Result := Result + [faExecute];
    if (Mask and _DELETE) = _DELETE then
      Result := Result + [faDelete];
    if (Mask and WRITE_DAC) = WRITE_DAC then
      Result := Result + [faChangePermissions];
    if (Mask and WRITE_OWNER) = WRITE_OWNER then
      Result := Result + [faTakeOwnership];
  end;
end;

function GetGenericSecurity(Mask: DWORD): TAccessSet;
begin
  Result := [];
  if Mask = GENERIC_ALL then
    Result := [faAll]
  else begin
    if (Mask and GENERIC_READ) = GENERIC_READ then
      Result := Result + [faRead];
    if (Mask and GENERIC_WRITE) = GENERIC_WRITE then
      Result := Result + [faWrite];
    if (Mask and GENERIC_EXECUTE) = GENERIC_EXECUTE then
      Result := Result + [faExecute];
    if (Mask and _DELETE) = _DELETE then
      Result := Result + [faDelete];
    if (Mask and WRITE_DAC) = WRITE_DAC then
      Result := Result + [faChangePermissions];
    if (Mask and WRITE_OWNER) = WRITE_OWNER then
      Result := Result + [faTakeOwnership];
  end;
end;

procedure TNTFileSecurity.RefreshSecurity;
var
  D_ACL: PACL;
  TheSID: PSID;
  pACE: Pointer;
  NewItem: PSecurityListItem;
  TheACE : PACCESS_ALLOWED_ACE;
  FileSD: PSECURITY_DESCRIPTOR;

  x: integer;
  LastGroup: string;
  SIDType: SID_NAME_USE;
  HasDACL,IsDefault: LongBool;

  a: array [0..1023] of Char;
  RefDom: array [0..DNLEN] of Char;
  GroupName: array [0..UNLEN] of Char;
  SrvName, FileName : array [0..255] of Char;

  AFlag, AMask, TempFlag: DWORD;
  dwRes, RefDomLen, GroupLen, ACECount, LenNeeded : DWORD;
begin
  if FFileName = '' then begin
    DoOnGetSecurity(ERROR_FILE_NOT_FOUND,0);
    Exit;
  end;

  // Initialize a few local vars
  D_ACL := nil;
  FileSD := nil;
  NewItem := nil;
  LastGroup := '';

  // Clear the list of ACEs, making sure to free the memory of the entries...
  if FACEList.Count > 0 then begin
    FEntries.Clear;
    for x := Pred(FACEList.Count) downto 0 do begin
      NewItem := FACEList.Items[x];
      Dispose(NewItem);
      FACEList.Delete(x);
    end;
    FACEList.Clear;
  end;

  // Copy the file name to a PChar...
  ZeroMemory(@FileName,SizeOf(FileName));
  StrPCopy(FileName,FFileName);

  // Retrieve the SECURITY_DESCRIPTOR length from the requested file...
  // since the SECURITY_DESCRIPTOR pointer (FileSD) is nil and the
  // SECURITY_DESCRIPTOR length is 0, this will force the "Insufficient Buffer"
  // error and give us the required size of the SECURITY_DESCRIPTOR in LenNeeded.
  if not GetFileSecurity(FileName,DACL_SECURITY_INFORMATION,FileSD,0,LenNeeded) then begin
    dwRes := GetLastError;
    if dwRes <> ERROR_INSUFFICIENT_BUFFER then begin
      DoOnGetSecurity(dwRes,ERROR_GET_FILE_SECURITY);
      Exit;
    end;
  end;

  // Allocate the SECURITY_DESCRIPTOR.
  FileSD := AllocMem(LenNeeded);

  // *Now* retrieve the actual SECURITY_DESCRIPTOR.
  if not GetFileSecurity(FileName,DACL_SECURITY_INFORMATION,FileSD,LenNeeded,LenNeeded) then begin
    dwRes := GetLastError;
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    FreeMem(FileSD);
    DoOnGetSecurity(dwRes,ERROR_GET_FILE_SECURITY);
    Exit;
  end;

  // Get the pointer to the Discretionary Access Control List in the
  // SECURITY_DESCRIPTOR we just got.
  if not GetSecurityDescriptorDACL(FileSD,HasDACL,D_ACL,IsDefault) then begin
    dwRes := GetLastError;
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    FreeMem(FileSD);
    DoOnGetSecurity(dwRes,ERROR_GET_DACL);
    Exit;
  end;

  // Get the number os Access Control Entries in the Access Control List
  dwRes := GetACECount(D_ACL, ACECount);
  if  dwRes <> ERROR_SUCCESS then begin
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    FreeMem(FileSD);
    DoOnGetSecurity(dwRes,ERROR_GET_ACE_COUNT);
    Exit;
  end;

  // If there was no error but the ACE count is still zero the object
  // has no security information set.
  if ACECount = 0 then begin
    FreeMem(FileSD);
    DoOnGetSecurity(ERROR_NO_SECURITY_INFO,ERROR_GET_ACE_COUNT);
    Exit;
  end;

  // Now we loop through the ACL, gathering required information...
  for x := 0 to (ACECount - 1) do begin
    if not GetAce(D_ACL^,x,pACE) then begin
      dwRes := GetLastError;
      FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
      FreeMem(FileSD);
      DoOnGetSecurity(dwRes,ERROR_GET_ACE);
      Exit;
    end else begin

      // This is far easier than typecasting a generic pointer each time
      // you want to use it.
      TheACE := pACE;

      // Set the address of the SECURITY_IDENTIFIER the ACE belongs to.
      TheSID := PSID(@TheACE.SidStart);

      // Initialize a few vars...
      RefDomLen := DNLEN + 1;
      GroupLen := SizeOf(GroupName);
      ZeroMemory(@GroupName,SizeOf(GroupName));
      ZeroMemory(@SrvName,SizeOf(SrvName));
      StrPCopy(SrvName,FSystemName);

      // Lookup the account name that goes with the SECURITY_IDENTIFIER.
      if LookupAccountSid(SrvName,TheSID,GroupName,GroupLen,RefDom,RefDomLen,SidType) then begin
        if LastGroup <> StrPas(GroupName) then begin
          // If the account we just looked up is different than the one
          // before it, add it to our security list.  I had to do it this
          // way because a specific account can have more than one ACE and
          // we need to combine the different ACEs for easy viewing and
          // editing.  This is especially true for directories because they
          // store security information for the directory AND the files it
          // contains for each account in the Access Control List.

          // On the first time through the loop we do not have any security
          // information so don't add garbage to the list.
          if x <> 0 then begin
            FACEList.Add(NewItem);
            FEntries.Add(NewItem^.Name);
            FEntryCount := FACEList.Count;
          end;

          // Initialize a new item to add to our list
          New(NewItem);
          {$IFDEF WINVER5}
          NewItem^.DirectoryDenied := [];
          NewItem^.FileDenied := [];
          {$ENDIF}
          NewItem^.DirectoryAllowed := [];
          NewItem^.FileAllowed := [];

          // Some accounts are built into the OS and therefore they don't
          // report the referenced domain name as the local machine name.
          if (UpperCase(StrPas(RefDom)) = 'BUILTIN') or (UpperCase(StrPas(RefDom)) = '')
                                                or (UpperCase(StrPas(RefDom)) = 'NT AUTHORITY') then
            NewItem^.ServerName := SrvName
          else
            NewItem^.ServerName := StrPas(RefDom);

          // Get the type of account...
          case SidType of
            SidTypeUser           : NewItem^.EntryType := seUser;
            SidTypeGroup          : NewItem^.EntryType := seGroup;
            SidTypeDomain         : NewItem^.EntryType := seDomain;
            SidTypeAlias          : NewItem^.EntryType := seAlias;
            SidTypeWellKnownGroup : NewItem^.EntryType := seWellKnownGroup;
            SidTypeDeletedAccount : NewItem^.EntryType := seDeletedAcount;
            SidTypeInvalid        : NewItem^.EntryType := seInvalid;
            SidTypeUnknown        : NewItem^.EntryType := seUnknown;
          end;
        end;

        // Remember the name of this account for the next time
        // through the loop.
        LastGroup := StrPas(GroupName);

        NewItem^.Name := LastGroup;
      end else begin
        dwRes := GetLastError;
        FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
        FreeMem(FileSD);
        DoOnGetSecurity(dwRes,ERROR_GET_ACCOUNT_NAME);
        Exit;
      end;

      // Ok... time to decipher the security flags...

      // Directories usually have 2 Access Control Entries for an account.
      // The *first* entry specifies rights that apply to *files* within the
      // directory.  The *second* entry specifies rights that apply to the
      // *directory* itself.  The *first* entry uses a *slightly different*
      // set of access flags, thus my use of GetFileGenericSecurity and
      // GetGenericSecurity.
      AFlag := TheACE.Header.AceFlags;
      AMask := TheACE.Mask;
      if FIsFile then begin
        if TheAce.Header.AceType = ACCESS_ALLOWED_ACE_TYPE then
          NewItem^.FileAllowed := GetFileGenericSecurity(AMask);
        {$IFDEF WINVER5}
          if TheAce.Header.AceType = ACCESS_DENIED_ACE_TYPE then
            NewItem^.FileDenied := GetFileGenericSecurity(AMask);
        {$ENDIF}
      end else begin
        if FIsDirectory then begin
          TempFlag := AFlag and CONTAINER_INHERIT_ACE;
          if TempFlag = CONTAINER_INHERIT_ACE then begin
            // This is for the actual directory access and is inherited
            // by new subdirectories.
            if TheAce.Header.AceType = ACCESS_ALLOWED_ACE_TYPE then
              NewItem^.DirectoryAllowed := GetFileGenericSecurity(AMask);

            {$IFDEF WINVER5}
              if TheAce.Header.AceType = ACCESS_DENIED_ACE_TYPE then
                NewItem^.DirectoryDenied := GetFileGenericSecurity(AMask);
            {$ENDIF}
          end else begin
            // This is for file access specified by directory security
            // and inherited for new files added to the directory.
            if TheAce.Header.AceType = ACCESS_ALLOWED_ACE_TYPE then
              NewItem^.FileAllowed := GetGenericSecurity(AMask);

            {$IFDEF WINVER5}
              if TheAce.Header.AceType = ACCESS_DENIED_ACE_TYPE then
                NewItem^.FileDenied := GetGenericSecurity(AMask);
            {$ENDIF}
          end;
        end;
      end;
      pACE := nil;
    end;
  end;

  // Add the last ACE we read to our list of ACEs...
  FACEList.Add(NewItem);
  FEntries.Add(NewItem^.Name);
  FEntryCount := FACEList.Count;

  FreeMem(FileSD);
  DoOnGetSecurity(ERROR_SUCCESS,0);
end;

function SetFileGenericSecurity(SecuritySet: TAccessSet): DWORD;
begin
  Result := 0;
  if SecuritySet = [faAll] then
    Result := FILE_ALL_ACCESS
  else begin
    if (faRead in SecuritySet) then
      Result := Result or FILE_GENERIC_READ;
    if (faWrite in SecuritySet) then
      Result := Result or FILE_GENERIC_WRITE;
    if (faExecute in SecuritySet) then
      Result := Result or FILE_GENERIC_EXECUTE;
    if (faDelete in SecuritySet) then
      Result := Result or _DELETE;
    if (faChangePermissions in SecuritySet) then
      Result := Result or WRITE_DAC;
    if (faTakeOwnership in SecuritySet) then
      Result := Result or WRITE_OWNER;
  end;
end;

function SetGenericSecurity(SecuritySet: TAccessSet): DWORD;
begin
  Result := 0;
  if SecuritySet = [faAll] then
    Result := GENERIC_ALL
  else begin
    if (faRead in SecuritySet) then
      Result := Result or GENERIC_READ;
    if (faWrite in SecuritySet) then
      Result := Result or GENERIC_WRITE;
    if (faExecute in SecuritySet) then
      Result := Result or GENERIC_EXECUTE;
    if (faDelete in SecuritySet) then
      Result := Result or _DELETE;
    if (faChangePermissions in SecuritySet) then
      Result := Result or WRITE_DAC;
    if (faTakeOwnership in SecuritySet) then
      Result := Result or WRITE_OWNER;
  end;
end;

function TNTFileSecurity.CalculateACLSize: DWORD;
var
  x: integer;
  AccountSID: PSID;
  SIDType: SID_NAME_USE;
  LI : PSecurityListItem;
  a: array [0..1023] of Char;
  RefDom: array [0..DNLEN] of Char;
  ServerName: array [0..DNLEN] of Char;
  AccountName: array [0..UNLEN] of Char;
  SIDTotal, DACEC, AACEC, dwRes, SIDLength, RefDomainLen, AclSize: DWORD;
begin
  DACEC := 0;
  AACEC := 0;
  SIDTotal := 0;
  SIDLength := 0;
  AccountSID := nil;
  AclSize := SizeOf(ACL);

  for x := 0 to Pred(FACEList.Count) do begin
     LI := FACEList.Items[x];

     RefDomainLen := 0;
     ZeroMemory(@ServerName,SizeOf(ServerName));
     ZeroMemory(@AccountName,SizeOf(AccountName));
     ZeroMemory(@RefDom,SizeOf(RefDom));
     StrPCopy(AccountName,LI^.Name);
     StrPCopy(ServerName,FSystemName);

     case LI^.EntryType of
       seUser           : SIDType := SidTypeUser;
       seGroup          : SIDType := SidTypeGroup;
       seDomain         : SIDType := SidTypeDomain;
       seAlias          : SIDType := SidTypeAlias;
       seWellKnownGroup : SIDType := SidTypeWellKnownGroup;
       seDeletedAcount  : SIDType := SidTypeDeletedAccount;
       seInvalid        : SIDType := SidTypeInvalid;
       seUnknown        : SIDType := SidTypeUnknown;
     end;

      if not LookupAccountName(ServerName,AccountName,AccountSID,SIDLength,RefDom,RefDomainLen,SIDType) then begin
        dwRes := GetLastError;
        if dwRes <> ERROR_INSUFFICIENT_BUFFER then begin
          FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
          RaiseError(a);
        end;
      end;

     if FIsDirectory then begin

       {$IFDEF WINVER5}
         if LI^.DirectoryDenied <> [] then begin
           Inc(DACEC);
           SIDTotal := SIDTotal + SIDLength;
         end;

         if LI^.FileDenied <> [] then begin
           Inc(DACEC);
           SIDTotal := SIDTotal + SIDLength;
         end;
       {$ENDIF}

       if LI^.DirectoryAllowed <> [] then begin
         Inc(AACEC);
         SIDTotal := SIDTotal + SIDLength;
       end;

       if LI^.FileAllowed <> [] then begin
         Inc(AACEC);
         SIDTotal := SIDTotal + SIDLength;
       end;

     end else begin
       if FIsFile then begin

       {$IFDEF WINVER5}
         if LI^.FileDenied <> [] then begin
           Inc(DACEC);
           SIDTotal := SIDTotal + SIDLength;
         end;
       {$ENDIF}

         if LI^.FileAllowed <> [] then begin
           Inc(AACEC);
           SIDTotal := SIDTotal + SIDLength;
         end;

       end;
     end;
  end;

  Result := AclSize +  (DACEC * ( SizeOf(ACCESS_DENIED_ACE) - SizeOf(DWORD))) +
            (AACEC * ( SizeOf(ACCESS_ALLOWED_ACE) - SizeOf(DWORD))) + SIDTotal;
end;

procedure TNTFileSecurity.SetSecurity;
var
  HasDACL,IsDefault: LongBool;
  UserSID: PSID;
  NEW_ACL: PACL;
  TheACE: PACCESS_ALLOWED_ACE;
  NewFileSD: PSECURITY_DESCRIPTOR;
  CurrentItem : PSecurityListItem;
  SIDType: SID_NAME_USE;
  FileName, a : array [0..255] of Char;
  GroupName: array [0..UNLEN] of Char;
  ServerName: array [0..CNLEN] of Char;
  RefDom: array [0..DNLEN] of Char;
  RefDomLen, SIDLen, ACL_SIZE, SDSize, AMask: DWORD;
  x, ACECount: integer;
  pACE: Pointer;
  dwRes: DWORD;
begin
  SDSize := 128;
  ACECount := 0;
  NEW_ACL := nil;
  UserSID := nil;
  HasDACL := True;
  NewFileSD := nil;
  IsDefault:= False;
  StrPCopy(FileName,FFileName);

  // Set the size of the ACCESS CONTROL LIST
  ACL_SIZE := CalculateACLSize;
  NEW_ACL := AllocMem(ACL_SIZE);
  // Initialize the new ACCESS CONTROL LIST.
  if not InitializeACL(NEW_ACL^,ACL_SIZE,ACL_REVISION) then begin
    dwRes := GetLastError;
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    // Clean up and exit on error...
    ReallocMem(NEW_ACL,0);
    ReallocMem(UserSID,0);
    DoOnSetSecurity(dwRes,ERROR_INITIALIZE_ACL);
    Exit;
  end;

  // Loop through the security list adding ACCESS_DENIED_ACE first as we go.
  // Proper ACCESS CONTROL LISTS place ACCESS_DENIED_ACEs before
  // ACCESS_ALLOWED_ACEs.  This is not a requirement but, it is STRONGLY
  // suggested by Microsoft and more secure if it is done this way.
  for x := 0 to Pred(FACEList.Count) do begin
      // Initialize a few temp variables.
      SIDLen := 0;
      RefDomLen := 0;
      CurrentItem := FACEList.Items[x];
      StrPCopy(GroupName,CurrentItem^.Name);
      StrPCopy(ServerName,FSystemName);

      // Get the entry's SECURITY_IDENTIFIER length.
      if not LookupAccountName(ServerName,GroupName,nil,SIDLen,nil,RefDomLen,SIDType) then begin
        dwRes := GetLastError;
        if dwRes <> ERROR_INSUFFICIENT_BUFFER then begin
          FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
          // Clean up and exit on error...
          DoOnSetSecurity(dwRes,ERROR_GET_ACCOUNT_SID);
          Exit;
        end;
      end;

      // Allocate memory for the entry's SECURITY_IDENTIFIER.
      ReallocMem(UserSID,SIDLen);
      // ReallocMem is the same as AllocMem if the pointer is "nil" and size > 0.

      // Retrieve the entry's SECURITY_IDENTIFIER.
      if not LookupAccountName(ServerName,GroupName,UserSID,SIDLen,RefDom,RefDomLen,SIDType) then begin
        dwRes := GetLastError;
        FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
        // Clean up and exit on error...
        FreeMem(UserSID);
        DoOnSetSecurity(dwRes,ERROR_GET_ACCOUNT_SID);
        Exit;
      end;

    // Directories usually have 2 Access Control Entries for an account.
    // The *first* entry specifies rights that apply to *files* within the
    // directory.  The *second* entry specifies rights that apply to the
    // *directory* itself.  The *first* entry uses a *slightly different*
    // set of access flags, thus my use of SetFileGenericSecurity and
    // SetGenericSecurity.
    if FIsFile then begin

      {$IFDEF WINVER5}
         if CurrentItem^.FileDenied <> [] then begin
           // Determine the file's ACCESS_MASK
             AMask := SetFileGenericSecurity(CurrentItem^.FileDenied);

           // Add the ACE to the ACCESS CONTROL LIST
           if not AddAccessDeniedAce(NEW_ACL^,ACL_REVISION,AMask,UserSID) then begin
             dwRes := GetLastError;
             FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
             // Clean up and exit on error...
             ReallocMem(NEW_ACL,0);
             ReallocMem(UserSID,0);
             DoOnSetSecurity(dwRes,ERROR_ADD_DENIED_ACE);
             Exit;
           end;

           // Increment the ACE counter by one...
           Inc(ACECount);

           // Retrieve the ACE we just added
           if not GetAce(NEW_ACL^,ACECount - 1,pACE) then begin
             dwRes := GetLastError;
             FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
             // Clean up and exit on error...
             ReallocMem(NEW_ACL,0);
             ReallocMem(UserSID,0);
             DoOnSetSecurity(dwRes,ERROR_GET_ACE);
             Exit;
           end;
           // Set security inheritence flags for the ACE.
           // For actual files this is probably not neccessary but just for practice.
           TheACE := pACE;
           TheACE^.Header.AceFlags := OBJECT_INHERIT_ACE;
         end;
      {$ENDIF}

      if CurrentItem^.FileAllowed <> [] then begin
        // Determine the file's ACCESS_MASK
        AMask := SetFileGenericSecurity(CurrentItem^.FileAllowed);

        // Add the ACE to the ACCESS CONTROL LIST
        if not AddAccessAllowedAce(NEW_ACL^,ACL_REVISION,AMask,UserSID) then begin
          dwRes := GetLastError;
          FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
          // Clean up and exit on error...
          ReallocMem(NEW_ACL,0);
          ReallocMem(UserSID,0);
          DoOnSetSecurity(dwRes,ERROR_ADD_ALLOWED_ACE);
          Exit;
        end;

        // Increment the ACE counter by one...
        Inc(ACECount);

        // Retrieve the ACE we just added
        if not GetAce(NEW_ACL^,ACECount - 1,pACE) then begin
          dwRes := GetLastError;
          FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
          // Clean up and exit on error...
          ReallocMem(NEW_ACL,0);
          ReallocMem(UserSID,0);
          DoOnSetSecurity(dwRes,ERROR_GET_ACE);
          Exit;
        end;
        // Set security inheritence flags for the ACE.
        // For actual files this is probably not neccessary but just for practice.
        TheACE := pACE;
        TheACE^.Header.AceFlags := OBJECT_INHERIT_ACE;
      end;
    end else begin
      if FIsDirectory then begin

          // Add *FILE* access rights to the directory *FIRST*.

       {$IFDEF WINVER5}
          if CurrentItem^.FileDenied <> [] then begin
            AMask := SetGenericSecurity(CurrentItem^.FileDenied);

            if not AddAccessDeniedAce(NEW_ACL^,ACL_REVISION,AMask,UserSID) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_ADD_DENIED_ACE);
              Exit;
            end;

            // Increment the ACE counter by one...
            Inc(ACECount);

            // Retrieve the ACE we just added
            if not GetAce(NEW_ACL^,ACECount - 1,pACE) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_GET_ACE);
              Exit;
            end;

            // Set security inheritence flags for the directory's file ACE.
            TheACE := pACE;
            TheACE^.Header.AceFlags := INHERIT_ONLY_ACE or OBJECT_INHERIT_ACE;
          end;
       {$ENDIF}

          if CurrentItem^.FileAllowed <> [] then begin
            AMask := SetGenericSecurity(CurrentItem^.FileAllowed);

            if not AddAccessAllowedAce(NEW_ACL^,ACL_REVISION,AMask,UserSID) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_ADD_ALLOWED_ACE);
              Exit;
            end;

            // Increment the ACE counter by one...
            Inc(ACECount);

            // Retrieve the ACE we just added
            if not GetAce(NEW_ACL^,ACECount - 1,pACE) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_GET_ACE);
              Exit;
            end;

            // Set security inheritence flags for the directory's file ACE.
            TheACE := pACE;
            TheACE^.Header.AceFlags := INHERIT_ONLY_ACE or OBJECT_INHERIT_ACE;
          end;

        // Add *DIRECTORY* access rights to the directory itself *NEXT*.

       {$IFDEF WINVER5}
          if CurrentItem^.DirectoryDenied <> [] then begin
            AMask := SetFileGenericSecurity(CurrentItem^.DirectoryDenied);

            if not AddAccessDeniedAce(NEW_ACL^,ACL_REVISION,AMask,UserSID) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_ADD_DENIED_ACE);
              Exit;
            end;

            // Increment the ACE counter by one...
            Inc(ACECount);

            // Retrieve the ACE we just added
            if not GetAce(NEW_ACL^,ACECount - 1,pACE) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_GET_ACE);
              Exit;
            end;

            // Set security inheritence flags for the directory's own ACE.
            TheACE := pACE;
            TheACE^.Header.AceFlags := CONTAINER_INHERIT_ACE;
            // Means this security setting is inherited by NEW subdirectories.
            // This does NOT set existing subdirectory security.
          end;
       {$ENDIF}

          if CurrentItem^.DirectoryAllowed <> [] then begin
            AMask := SetFileGenericSecurity(CurrentItem^.DirectoryAllowed);

            if not AddAccessAllowedAce(NEW_ACL^,ACL_REVISION,AMask,UserSID) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_ADD_ALLOWED_ACE);
              Exit;
            end;

            // Increment the ACE counter by one...
            Inc(ACECount);

            // Retrieve the ACE we just added
            if not GetAce(NEW_ACL^,ACECount - 1,pACE) then begin
              dwRes := GetLastError;
              FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
              // Clean up and exit on error...
              ReallocMem(NEW_ACL,0);
              ReallocMem(UserSID,0);
              DoOnSetSecurity(dwRes,ERROR_GET_ACE);
              Exit;
            end;

            // Set security inheritence flags for the directory's own ACE.
            TheACE := pACE;
            TheACE^.Header.AceFlags := CONTAINER_INHERIT_ACE;
            // Means this security setting is inherited by NEW subdirectories.
            // This does NOT set existing subdirectory security.
          end;

      end;
    end;

    // Get ready for the next security list entry.
    // Dispose of the current entry's SECURITY_IDENTIFIER...
    ReallocMem(UserSID,0);
    // ReallocMem is the same as FreeMem if the pointer is pointer is not "nil"
    // and the size = 0.
  end;

  // Allocate and Initialize a *NEW* SECURITY_DESCRIPTOR
  ReallocMem(NewFileSD,SDSize);
  if not InitializeSecurityDescriptor(NewFileSD,SECURITY_DESCRIPTOR_REVISION) then begin
    dwRes := GetLastError;
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    // Clean up and exit on error...
    ReallocMem(NEW_ACL,0);
    ReallocMem(UserSID,0);
    ReallocMem(NewFileSD,0);
    DoOnSetSecurity(dwRes,ERROR_INITIALIZE_SD);
    Exit;
  end;

  // Place the NEW ACCESS CONTROL LIST into the NEW SECURITY_DESCRIPTOR
  if not SetSecurityDescriptorDACL(NewFileSD,HasDACL,NEW_ACL,IsDefault) then begin
    dwRes := GetLastError;
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    // Clean up and exit on error...
    ReallocMem(NEW_ACL,0);
    ReallocMem(UserSID,0);
    ReallocMem(NewFileSD,0);
    DoOnSetSecurity(dwRes,ERROR_SET_DACL);
    Exit;
  end;

  // Set the NEW SECURITY_DESCRIPTOR to the file or directory
  if not SetFileSecurity(FileName,DACL_SECURITY_INFORMATION,NewFileSD) then begin
    dwRes := GetLastError;
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,dwRes,0,a,1024,nil);
    // Clean up and exit on error...
    ReallocMem(NEW_ACL,0);
    ReallocMem(UserSID,0);
    ReallocMem(NewFileSD,0);
    DoOnSetSecurity(dwRes,ERROR_SET_SD);
    Exit;
  end;

  // Clean up the mess...
  ReallocMem(NEW_ACL,0);
  ReallocMem(UserSID,0);
  ReallocMem(NewFileSD,0);
  DoOnSetSecurity(ERROR_SUCCESS,0);
end;

end.
