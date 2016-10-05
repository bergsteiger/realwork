{ This _module is realization Boyer-Moore-Horspool search algorithm}
Unit l3TextSearch;

{ $Id: l3TextSearch.pas,v 1.3 2016/09/29 22:05:32 lulin Exp $ }

// $Log: l3TextSearch.pas,v $
// Revision 1.3  2016/09/29 22:05:32  lulin
// - подтачиваем.
//
// Revision 1.2  2016/09/23 15:10:00  lulin
// - подтачиваем.
//
// Revision 1.1  2016/09/23 13:00:04  lulin
// - подтачиваем.
//
// Revision 1.9  2009/02/20 10:08:38  lulin
// - чистка комментариев.
//
// Revision 1.8  2007/08/14 19:45:48  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.7  2007/08/14 19:31:40  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.6  2001/10/17 08:08:33  law
// - new lib: начинаем использовать m2.
//
// Revision 1.5  2001/09/04 14:40:07  law
// - delete unit: Language.
//
// Revision 1.4  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.3  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

{$I+,V-}

{$I l3Define.inc }

interface

Uses
  SysUtils,
  Windows,
  Messages,
  Classes
  {, Graphics, Controls,
  Forms, Dialogs}
  , l3CProtoObject
  ;

Const
  MaxBufferSize = 1024 * 63;  { Maximum size of buffer }

type
  TBMHTable = array[0..255] of byte;
  TSearchBufferArray = array[1..MaxBufferSize] of char;

 Tl3BMHFileSearch = class(Tl3CProtoObject)
  private
   BMHTable     : TBMHTable;
   BufSize      : Word;
   Buffer       : Pointer;
   FOEMText     : Boolean;
   FIgnoreCase  : boolean;
   FStrToFind   : String;
   FSrchString  : String;

   FFileName    : TFileName;
   FFindOnOffset : Longint;

   FOnFound: TNotifyEvent;

   Procedure SetStrToFind(Value : String);
   Procedure SetOEMText(Value : Boolean);
   Procedure SetIgnoreCase(Value : Boolean);
  protected
   procedure MakeBMHTable;

   {function  DoBMHSearch: Longint;}
   {function  GetStringOffset (StrToFind: string; const FileName: TFileName; const IgnoreCase: boolean): longint;}

  public
   Procedure CreateBuffer;
   procedure DestroyBuffer;
   procedure Cleanup; override;
   Procedure ExecuteSearch;
   {Procedure ExecuteSearchNext;}
   Property  FindOnOffset : Longint read FFindOnOffset;
   class function FindInFile(const aFile: String; const aString: String): Boolean;
  published
   Property  SearchString : String Read FSrchString Write SetStrToFind;
   Property  FileName    : TFileName Read FFileName Write FFileName;
   Property  IgnoreCase  : Boolean Read FIgnoreCase Write SetIgnoreCase;
   property  OEMText    : Boolean Read  FOEMText Write SetOEMText;

   property  OnFound     : TNotifyEvent read FOnFound Write FOnFound;
  end;//Tl3BMHFileSearch

(*procedure Register;*)

implementation

uses
{$IfDef l3Requires_m0}
 m2XLtLib,
{$EndIf l3Requires_m0}
 l3Base
 ;

(*procedure Register;
 begin
  RegisterComponents('Super', [Tl3BMHFileSearch]);
 end;*)

function GetError (const ErrorCode: integer): string;
{ Returns a string pertaining to the type of error.  ErrorCode can be
  taken from IOResult if IO-checking is off, or from an exception handler.
  The strings listed below are taken from Borland's 'Object Pascal
  Language Guide' for Delphi Version 1.0, pages 273-275.
}
begin
  case ErrorCode of
     2: Result := 'File not found';
     3: Result := 'Path not found';
     4: Result := 'Too many open files';
     5: Result := 'File access denied';
     6: Result := 'Invalid file handle';
    12: Result := 'Invalid file access code';
    15: Result := 'Invalid drive';
   100: Result := 'Disk read error';
   101: Result := 'Disk write error';
   102: Result := 'File not assigned';
   103: Result := 'File not open';
  else
    Result := ''
  end
end;

procedure Tl3BMHFileSearch.Cleanup;
Begin
 DestroyBuffer;
 inherited;
end;

Procedure Tl3BMHFileSearch.CreateBuffer;
 Begin
 {$IfDef Win32}
  BufSize := MaxBufferSize;
 {$Else}
  If MaxAvail >= MaxBufferSize
   then BufSize := MaxBufferSize
   else BufSize := (MaxAvail div 1024) * 1024;
 {$EndIf}
  try
    GetMem(Buffer, BufSize)
  except
    Begin
     Buffer:=Nil;
     BufSize:=0;
    end;
  end;
 end;

procedure Tl3BMHFileSearch.DestroyBuffer;
 Begin
  If Assigned(Buffer)
   then
    Begin
     FreeMem(Buffer,BufSize);
     Buffer := nil;
     BufSize:=0;
    end;
 end;

procedure Tl3BMHFileSearch.MakeBMHTable;
  Var
   K: integer;
  Begin
    l3FillChar(BMHTable,sizeof(BMHTable),Length(FStrToFind));
    for K := 1 to (Length(FStrToFind) - 1) do
      BMHTable[Byte(FStrToFind[K])] := Length(FStrToFind) - K;
  end;

Procedure Tl3BMHFileSearch.SetStrToFind(Value : String);
 Begin
  FSrchString:=Value;
  FStrToFind:=Value;
  If FIgnoreCase then FStrToFind:=AnsiUpperCase(FStrToFind);
  If FOEMText
   then AnsiToOEMBuff(@FStrToFind[1],@FStrToFind[1],Length(FStrToFind));
  MakeBMHTable;
 end;

Procedure Tl3BMHFileSearch.SetOEMText(Value : Boolean);
 Begin
  If FOEMText=Value then Exit;
  FOEMText:=Value;
  If FOEMText
   then AnsiToOEMBuff(@FStrToFind[1],@FStrToFind[1],Length(FStrToFind))
   else OEMtoAnsiBuff(@FStrToFind[1],@FStrToFind[1],Length(FStrToFind));
  MakeBMHTable;
 end;

Procedure Tl3BMHFileSearch.SetIgnoreCase(Value : Boolean);
 Begin
  If FIgnoreCase=Value then Exit;
  FIgnoreCase:=Value;
  FStrToFind:=FSrchString;
  If FIgnoreCase then FStrToFind:=AnsiUpperCase(FStrToFind);
  If FOEMText
   then AnsiToOEMBuff(@FStrToFind[1],@FStrToFind[1],Length(FStrToFind));
  MakeBMHTable;
 end;

Procedure Tl3BMHFileSearch.ExecuteSearch;
 Var
  FileToSearch : File;

  OldFileMode  : byte;
  I,J,
 {$IfDef Win32}
  BytesRead    : Integer;
 {$Else}
  BytesRead    : Word;
 {$EndIf}

 Function DoBMHSearch: longint; {assembler;}
 { Returning the offset in buffer where the string was found
   or -1 if not found }
  Label
   NotFound;
  Var
   K : Byte;
  Begin
   Result := -1;
   J := Length(FStrToFind);
   While (J <= BytesRead) do
    Begin
     I := J;
     For K := Length(FStrToFind) downto 1 do
      Begin
       If TSearchBufferArray(Buffer^)[I] <> FStrToFind[K] then goto NotFound;
       Dec(I);
      end;
     Result := (BytesRead - I);
     exit;
NotFound : Inc(J,BMHTable[ord(TSearchBufferArray(Buffer^)[J])])
    end; { while }
{
  asm
       MOV DX, $FFFF
       MOV AX, $FFFF
       LES DI, DWORD PTR SS:[Self]
       XOR CH, CH
       MOV CL, BYTE PTR ES:[DI+FStrToFind][0]

  @@02:CMP CX, WORD PTR SS:[BytesRead]
       JA  @@01



       JMP @@02

  @@01:

  }
  end;

 Procedure UpCaseBuffer;
  Begin
   {$IfDef l3Requires_m0}
   if FOEMText then
    m2xltConvertBuff(Buffer, BytesRead, Cm2XLTOEM2Upper)
   else
    m2xltConvertBuff(Buffer, BytesRead, Cm2XLTANSI2Upper);
   {$Else  l3Requires_m0}
   if FOEMText then
    ANSIUpperBuff(Buffer, BytesRead);
   {$EndIf l3Requires_m0}
  end;

 var
  l_FilePos : Integer;
 Begin
  If Not Assigned(Buffer) then CreateBuffer;
  Assert(BufSize > 0);
  FFindOnOffset := -1;
  OldFileMode:=System.Filemode;
  System.Filemode := fmOpenRead;

  Assignfile (FileToSearch,FFileName);
  try
    Reset(FileToSearch,1);
    try
      repeat
        BlockRead(FileToSearch,Buffer^,BufSize,BytesRead);
        if IgnoreCase then UpCaseBuffer;
        FFindOnOffset := DoBMHSearch;
        If FFindOnOffset <> -1 then
          Begin
            FFindOnOffset := filepos(FileToSearch) - FFindOnOffset;
            If Assigned(FOnFound) then FOnFound(Self);
            break;
          end;
        If (BytesRead = BufSize) then
        begin
         l_FilePos := FilePos(FileToSearch);
         Assert(l_FilePos > Length(FStrToFind));
         Seek(FileToSearch,l_FilePos-Length(FStrToFind)+1);
        end;//BytesRead = BufSize
      until (BytesRead = 0);
    finally
      CloseFile(FileToSearch);
    end;
  except
    on E: EInOutError do
      begin
        //MessageDlg('Cannot scan ' + uppercase(FFileName) + '.'#13 + GetError(E.ErrorCode)+'.',mterror,[mbOK],0);
        raise Exception.Create('Cannot scan ' + uppercase(FFileName) + '.'#13 + GetError(E.ErrorCode)+'.');
        FFindOnOffset := -1
      end
  end; { opening file to search }
  System.Filemode := OldFileMode;
 end;

class function Tl3BMHFileSearch.FindInFile(const aFile: String; const aString: String): Boolean;
var
 l_S : Tl3BMHFileSearch;
begin
 l_S := Tl3BMHFileSearch.Create;
 try
  l_S.IgnoreCase := false;
  l_S.FileName := aFile;
  l_S.SearchString := aString;
  l_S.ExecuteSearch;
  Result := (l_S.FindOnOffset >= 0);
 finally
  FreeAndNil(l_S);
 end;//try..finally
end;

end.


