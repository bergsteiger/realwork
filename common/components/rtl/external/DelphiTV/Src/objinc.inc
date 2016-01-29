{
    $Id: objinc.inc,v 1.1 2004/02/25 13:13:12 law Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team.

    Includefile for objects.pp implementing OS-dependent file routines
    for WIN32

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************
}

CONST
   { REQUIRED TO PUT MANUALLY here, because of name conflicts in win32.inc }
   { flags for CreateFile }
   GENERIC_READ=$80000000;
   GENERIC_WRITE=$40000000;
   CREATE_NEW = 1;
   CREATE_ALWAYS = 2;
   OPEN_EXISTING = 3;
   OPEN_ALWAYS = 4;
   TRUNCATE_EXISTING = 5;

   FILE_ATTRIBUTE_ARCHIVE = 32;
   FILE_ATTRIBUTE_COMPRESSED = 2048;
   FILE_ATTRIBUTE_NORMAL = 128;
   FILE_ATTRIBUTE_DIRECTORY = 16;
   FILE_ATTRIBUTE_HIDDEN = 2;
   FILE_ATTRIBUTE_READONLY = 1;
   FILE_ATTRIBUTE_SYSTEM = 4;
   FILE_ATTRIBUTE_TEMPORARY = 256;

   { flags for SetFilePos }
   FILE_BEGIN = 0;
   FILE_CURRENT = 1;
   FILE_END = 2;

   { misc. functions }
   function GetLastError : Cardinal; stdcall;
     external 'kernel32.dll' name 'GetLastError';

   function WriteFile(fh:longint;buf:pointer;len:Sw_Word;var loaded:Sw_Word;
     overlap:pointer):longint; stdcall;
     external 'kernel32.dll' name 'WriteFile';
   function ReadFile(fh:longint;buf:pointer;len:longint;var loaded:longint;
     overlap:pointer):longint; stdcall;
     external 'kernel32.dll' name 'ReadFile';
   function CloseHandle(h : longint) : longint; stdcall;
     external 'kernel32.dll' name 'CloseHandle';
   function DeleteFile(p : pchar) : longint; stdcall;
     external 'kernel32.dll' name 'DeleteFileA';
   function MoveFile(old,_new : pchar) : longint; stdcall;
     external 'kernel32.dll' name 'MoveFileA';
   function SetFilePointer(l1,l2 : longint;l3 : pointer;l4 : longint) : longint; stdcall;
     external 'kernel32.dll' name 'SetFilePointer';
   function GetFileSize(h:longint;p:pointer) : longint; stdcall;
     external 'kernel32.dll' name 'GetFileSize';
   function CreateFile(name : pointer;access,sharing : longint;
     security : pointer;how,attr,template : longint) : longint; stdcall;
     external 'kernel32.dll' name 'CreateFileA';
   function SetEndOfFile(h : longint) : boolean; stdcall;
     external 'kernel32.dll' name 'SetEndOfFile';
   function GetFileType(Handle:Cardinal): Cardinal; stdcall;
     external 'kernel32.dll' name 'GetFileType';


{---------------------------------------------------------------------------}
{  FileClose -> Platforms WIN32            - Not checked                    }
{---------------------------------------------------------------------------}
FUNCTION FileClose(Handle: THandle): word;
begin
   closehandle(handle);
   FileClose := 0;
end;

{---------------------------------------------------------------------------}
{  FileOpen -> Platforms WIN32            - Tested MVC                      }
{  Returns 0 on failure                                                     }
{---------------------------------------------------------------------------}

FUNCTION FileOpen (Var FileName: AsciiZ; Mode: Word): THandle;
var
 oflags,cd: longint;
 AHandle : longint;
begin
  { On opening reset error code }
  DosStreamError := 0;
  if Mode=stCreate then
    Begin
      cd:=CREATE_ALWAYS;
      oflags:=GENERIC_WRITE or GENERIC_READ;
    End
  else
    Begin
      cd:=OPEN_EXISTING;
      { convert filemode to filerec modes }
      case (Mode and 3) of
        0 : oflags:=GENERIC_READ;
        1 : oflags:=GENERIC_WRITE;
        2 : oflags:=GENERIC_WRITE or GENERIC_READ;
      end;
     end;
   AHandle:=CreateFile(pointer(@FileName),oflags,0,nil,cd,FILE_ATTRIBUTE_NORMAL,0);
   if AHandle = -1 then
     begin
     FileOpen:=0;
     DosStreamError:=word(GetLastError);
     end
   else 
     FileOpen := AHandle;
end;


{***************************************************************************}
{  DosSetFilePtr -> Platforms WIN32        - Tested MVC                     }
{***************************************************************************}
FUNCTION SetFilePos (Handle: THandle; Pos: Cardinal; MoveType: Word;
Var Actual: Cardinal): Word;
BEGIN
  { WARNING WIN32 CURRECTLY HAS THE SAME SEEK MODE AS MSDOS    }
  { if this changes don't forget to change and check the flags }
  { accordingly.                                               }
  Actual:=SetFilePointer(handle,pos,nil,MoveType);
  If Actual=-1 then
    DosStreamError:=word(GetLastError);
  SetFilePos := DosStreamError;                   { Return any error }
END;


{---------------------------------------------------------------------------}
{  FileRead -> Platforms WIN32            - Tested MVC                      }
{---------------------------------------------------------------------------}
FUNCTION FileRead (Handle: THandle; Var Buf; Count: Sw_Word;
Var Actual: Sw_Word): Word;

Var res : longint;

BEGIN
  res:=0;
  if readfile(handle,pointer(@buf),count,res,nil)=0 then
     DosStreamError:=word(GetLastError);
  Actual:=res;    
  FileRead:=DosStreamError;
end;


{---------------------------------------------------------------------------}
{  FileWrite -> Platforms WIN32            - Not Checked                    }
{---------------------------------------------------------------------------}
FUNCTION FileWrite (Handle: THandle; Var Buf; Count: Sw_Word; Var Actual: Sw_Word): Word;
BEGIN
   if writefile(handle,pointer(@buf),count,Actual,nil)=0 then
    Begin
      DosStreamError:=word(GetLasterror);
    end;
   FileWrite:=DosStreamError;
end;


{---------------------------------------------------------------------------}
{  SetFileSize -> Platforms DOS          - Not Checked                      }
{---------------------------------------------------------------------------}
FUNCTION SetFileSize (Handle: THandle; FileSize: LongInt): Word;
VAR 
  Actual: integer; 
  Buf: Cardinal;
BEGIN
   SetFilePos(Handle,FileSize,0,Cardinal(Actual));
   If (Actual = FileSize) Then
    Begin
      Actual := FileWrite(Handle, Buf, 0, Cardinal(Actual));   { Truncate the file }
      If (Actual <> -1) Then
       SetFileSize := 0
      Else
       SetFileSize := 103;                            { File truncate error }
    End
   Else
    SetFileSize := 103;                       { File truncate error }
END;

{
  $Log: objinc.inc,v $
  Revision 1.1  2004/02/25 13:13:12  law
  - добавлен порт Turbo Vision под Delphi.

  Revision 1.1  2000/07/13 06:31:21  michael
  + Initial import

  Revision 1.6  2000/05/29 05:32:51  jonas
    * should compile again

  Revision 1.5  2000/02/09 16:59:34  peter
    * truncated log

  Revision 1.4  2000/01/07 16:41:52  daniel
    * copyright 2000

  Revision 1.3  2000/01/07 16:32:34  daniel
    * copyright 2000 added

  Revision 1.2  1999/08/24 08:44:43  michael
  + Fixed setfilepos and openfile

}

