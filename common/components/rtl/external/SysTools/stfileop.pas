{*********************************************************}
{*                  STFILEOP.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StFileOp;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  SysUtils, Windows, Forms, Classes, Controls, ShellApi,
  {$IFDEF VERSION3} ActiveX, {$ELSE} Ole2, {$ENDIF}
  StShBase, StBase, StConst;

{$Z+}
type
  TStFileOp = (fopCopy, fopDelete, fopMove, fopRename);

  TStFileOpOptions  = (foAllowUndo, foFilesOnly, foNoConfirmation,
                       foNoConfirmMkDir, foNoErrorUI, foRenameCollision,
                       foSilent, foSimpleProgress);

  TStFileOpOptionsSet = set of TStFileOpOptions;

type
  TStCustomFileOperation = class(TStShellComponent)
  protected {private}
    FAnyOpAborted : Boolean;
    FConfirmFiles : Boolean;
    FDestination  : string;
    FOperation    : TStFileOp;
    FOptions      : TStFileOpOptionsSet;
    FSimpleText   : string;
    FSourceFiles  : TStrings;

    UsingMappings : Boolean;

    procedure SetSourceFiles(Value : TStrings);
    procedure SetDestination(const Value : string);

    function BuildFileList(var Dest : PChar; Source : TStrings) : Boolean;
    function CheckFile(const FileName : string) : Boolean;

  protected

{$Z-}
    {properties}
    property AnyOpAborted : Boolean
      read FAnyOpAborted;

    property ConfirmFiles : Boolean
      read FConfirmFiles
      write FConfirmFiles
      default True;

    property Destination : string
      read FDestination
      write SetDestination;

    property Operation : TStFileOp
      read FOperation
      write FOperation
      default fopCopy;

    property Options : TStFileOpOptionsSet
      read FOptions
      write FOptions
      default [foAllowUndo, foFilesOnly, foRenameCollision];

    property SimpleText : string
      read FSimpleText
      write FSimpleText;

    property SourceFiles : TStrings
      read FSourceFiles
      write SetSourceFiles;

    {events}

  public
    { Public declarations }
{$Z+}
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
{$Z-}
    function Execute : Boolean;
  published
    { Published declarations }
  end;

  TStFileOperation = class(TStCustomFileOperation)
  public
    {properties}
    property AnyOpAborted;
    property Error;
    property ErrorString;

  published
    {properties}
    property ConfirmFiles;
    property Destination;
    property Operation;
    property Options;
    property SimpleText;
    property SourceFiles;

    {events}
    property OnError;
  end;

implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

function TStCustomFileOperation.Execute : Boolean;
var
  Flags        : Word;
  ParentHandle : HWND;
  FileOpStruct : TSHFileOpStruct;
  Op           : Byte;
  From         : PChar;
  FTo          : PChar;
  Res          : Integer;
  FileCount    : Integer;                                              

  procedure BuildFileMappingList;
  var
    SrcList : TStringList;
    DstList : TStringList;
    I       : Integer;
    S1, S2  : string;
  begin
    { No mappings? Then just build the file list. }
    if Pos('=', FSourceFiles.Text) = 0 then begin
      if not BuildFileList(From, FSourceFiles) then
        RaiseStError(EStFileOpError, stscShellFileNotFound);
      UsingMappings := False;
      Exit;
    end else
      if Op = FO_DELETE then
        RaiseStError(EStFileOpError, stscShellFileOpDelete);

    UsingMappings := True;
    SrcList := TStringList.Create;
    DstList := TStringList.Create;
    {$IFDEF VERSION3}
    SrcList.Capacity := FSourceFiles.Capacity;
    DstList.Capacity := FSourceFiles.Capacity;
    {$ENDIF}
    FileCount := FSourceFiles.Count;
    try
      for I := 0 to Pred(FSourceFiles.Count) do begin
        { If a particular line doesn't have a mapping then }
        { create one with Destination as the directory.    }
        S1 := FSourceFiles[I];
        if S1 = '' then begin                                          
          { Blank line, decrement the file count. }                    
          Dec(FileCount);                                              
          Continue;
        end;                                                           
        if (Pos('=', S1) = 0) then begin
          S2 := FSourceFiles[I]
            + '=' + FDestination + '\' + ExtractFileName(S1);
          FSourceFiles[I] := S2;
        end;

        SrcList.Add(FSourceFiles.Names[I]);
        DstList.Add(FSourceFiles.Values[FSourceFiles.Names[I]]);
      end;
      Result := BuildFileList(From, SrcList);
      BuildFileList(FTo, DstList);
    finally
      SrcList.Free;
      DstList.Free;
    end;
  end;

begin

  { Get a handle to the owning window. }
  if Owner is TWinControl then
    ParentHandle := (Owner as TWinControl).Handle
  else if Owner is TApplication then
    ParentHandle := (Owner as TApplication).Handle
  else
    ParentHandle := 0;

  Flags := 0;
  if foAllowUndo in FOptions then
    Flags := Flags or FOF_ALLOWUNDO;
  if foFilesOnly in FOptions then
    Flags := Flags or FOF_FILESONLY;
  if foNoConfirmation in FOptions then
    Flags := Flags or FOF_NOCONFIRMATION;
  if foNoConfirmMkDir in FOptions then
    Flags := Flags or FOF_NOCONFIRMMKDIR;
  if foNoErrorUI in FOptions then
    Flags := Flags or FOF_NOERRORUI;
  if foRenameCollision in FOptions then
    Flags := Flags or FOF_RENAMEONCOLLISION;
  if foSilent in FOptions then
    Flags := Flags or FOF_SILENT;
  if foSimpleProgress in FOptions then
    Flags := Flags or FOF_SIMPLEPROGRESS;

  case Ord(FOperation) of
    0 : Op := FO_COPY;
    1 : Op := FO_DELETE;
    2 : Op := FO_MOVE;
    3 : Op := FO_RENAME;
  else
    Op := FO_COPY;
  end;

  if (FSourceFiles.Count = 0) then
    RaiseStError(EStFileOpError, stscShellFileOpSrcError);

  From := nil;
  FTo  := nil;
  try
    if Length(FSourceFiles.Text) > 2 then begin
      BuildFileMappingList;
      if (FDestination = '') and (Op <> FO_DELETE)
          and not UsingMappings then
        RaiseStError(EStFileOpError, stscShellFileOpDstError);
      if not UsingMappings then begin
        GetMem(FTo, Length(FDestination) + 2);
        FillChar(FTo^, Length(FDestination) + 2, 0);
        StrCopy(FTo, PChar(FDestination));
      end;
    end;
    if UsingMappings and (Op <> FO_DELETE) and (FileCount > 1) then
      Flags := Flags or FOF_MULTIDESTFILES;

    with FileOpStruct do begin
      Wnd                   := ParentHandle;
      wFunc                 := Op;
      pFrom                 := From;
      pTo                   := FTo;
      fFlags                := Flags;
      hNameMappings         := nil;
      lpszProgressTitle     := PChar(FSimpleText);
    end;
    SetLastError(0);
    Res := SHFileOperation(FileOpStruct);
    FAnyOpAborted := FileOpStruct.fAnyOperationsAborted;
    { For some reason SHFileOperation returns 0 even when the }
    { operation fails. }
    
    // не проверяем ошибки, если Res = 0, ибо нефиг
    if Res <> 0 then
     CheckSystemError(Res)
    else
    begin
     FError := 0;
     FErrorString := '';
    end;

    { If the user pressed the Cancel button then GetLastError will }
    { report ERROR_INVALID_CATEGORY which results in a confusing   }
    { error message. We'll return ERROR_CANCELLED instead.         }
    if FError = ERROR_INVALID_CATEGORY then
      CheckSystemError(ERROR_CANCELLED);
    { Windows will generate an ERROR_NO_MORE_FILES error when      }
    { renaming or moving files even when the operation is          }
    { successful. We'll just supress the error if that's the case. }
    if (FError = ERROR_NO_MORE_FILES) then begin
      FError := 0;
      FErrorString := '';
    end;
    if FError <> 0 then
      DoError;
    Result := (FError = 0);
  finally
    FreeMem(From);
    FreeMem(FTo);
  end;
end;

constructor TStCustomFileOperation.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FOptions      := [foAllowUndo, foFilesOnly, foRenameCollision];
  FOperation    := fopCopy;
  FSourceFiles  := TStringList.Create;
  FConfirmFiles := True;
end;

destructor TStCustomFileOperation.Destroy;
begin
  FSourceFiles.Free;
  inherited Destroy;
end;

procedure TStCustomFileOperation.SetSourceFiles(Value : TStrings);
begin
  FSourceFiles.Assign(Value);
end;

function TStCustomFileOperation.BuildFileList(var Dest : PChar;
                                              Source : TStrings) : Boolean;
var
  Index : Integer;
  I     : Integer;
  Temp  : PChar;
begin
  Result := True;
  { The source file must be double null-terminated. Allocate  }
  { a buffer for the files and add 1 characters for the double}
  { null. Fill the buffer with zeros and then copy the files  }
  { to the buffer one at a time. }
  I := Length(Source.Text) + Source.Count + 1;
  GetMem(Dest, I);
  FillChar(Dest^, I, 0);
  if Source.Count = 1 then begin
    StrCopy(Dest, PChar(Source[0]));
    if FConfirmFiles then
      if not CheckFile(Dest) then
        Result := False;
  end else begin
    Index := 0;
    for I := 0 to Pred(Source.Count) do begin
      Temp := PChar(Source[i]);
      { If any of the source files doesn't exists then return     }
      { False so we can RaiseStError(an exception in the Execute method. }
      if FConfirmFiles then
        if not CheckFile(Temp) then
          Result := False;
      Move(Temp^, Dest[Index], Length(Temp));
      Inc(Index, Length(Temp) + 1);
    end;
  end;
end;

function TStCustomFileOperation.CheckFile(const FileName : string): Boolean;
var
  Pos1, Pos2 : Integer;
begin
  Result := True;
  if (FileGetAttr(FileName) and faDirectory) = faDirectory then        
    Exit;
  Pos1 := Pos('*', FileName);
  Pos2 := Pos('?', FileName);
  if (Pos1 = 0) and (Pos2 = 0) then
    Result := FileExists(FileName);
end;

procedure TStCustomFileOperation.SetDestination(const Value: string);
var
  Done : Boolean;
begin
  FDestination := Value;
  Done := False;
  while not Done do begin
    if FDestination[Length(FDestination)] = '\' then
      FDestination := Copy(FDestination, 1, Length(FDestination) - 1)
    else
      Done := True;
  end;
end;


end.