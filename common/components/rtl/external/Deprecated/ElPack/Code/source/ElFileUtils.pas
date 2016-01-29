{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Parts:                                           }
{   copyright (c) 2001 Akzhan Abdulin                }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*
  Version History:

08/28/2001

  Initiated (c) Akzhan Abdulin

*)

unit ElFileUtils;

interface

{$IFDEF WIN32}

uses
  Windows,
  SysUtils,
  Classes
  {$ifdef VCL_5_USED}
  , Masks
  {$endif}
  ;

{$ifndef BROKEN_UNICODE}

function GetWideCurrentDir: WideString;
function SetWideCurrentDir(const Dir: WideString): Boolean;
function CreateWideDir(const Dir: WideString): Boolean;
function RemoveWideDir(const Dir: WideString): Boolean;

function GetWideModuleName(Module: HMODULE): WideString;

{$endif ifndef BROKEN_UNICODE}

{$ifdef VCL_5_USED}

Type

 TCallbackBuildFileListFromMasks = procedure(const Directory, FileName:String; FileHandle: THandle; var Ignore:Boolean; Data:Pointer; var Abort:Boolean);

function BuildFileListFromMasks(
  FileMasks, RecursiveDirectories, Directories:TStrings;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:Pointer
):TStrings;

function BuildFileListFromMasksThread(
  FileMasks, RecursiveDirectories, Directories:String;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:Pointer
):String;

{$endif ifdef VCL_5_USED}

{$ENDIF IFDEF WIN32}

implementation

uses
  ElStrUtils;

{$IFDEF WIN32}

{$ifdef VCL_5_USED}

function BuildFileListFromMasksThread(
  FileMasks, RecursiveDirectories, Directories:String;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:Pointer
):String;
 var
   LFileMasks, LRecursiveDirectories, LDirectories, LResult:TStrings;
begin
  LFileMasks := TStringList.Create;
  LRecursiveDirectories := TStringList.Create;
  LDirectories := TStringList.Create;
  try
    LFileMasks.Text := FileMasks;
    LRecursiveDirectories.Text := RecursiveDirectories;
    LDirectories.Text := Directories;
    LResult := BuildFileListFromMasks(
      LFileMasks, LRecursiveDirectories, LDirectories,
      IgnoreBadMasks,  CB, Data
    );
    if Assigned(LResult) then
      Result := LResult.Text
    else
      SetLength(Result, 0);
  finally
    LFileMasks.Free;
    LRecursiveDirectories.Free;
    LDirectories.Free;
  end;
end;

function BuildFileListFromMasks(
  FileMasks, RecursiveDirectories, Directories:TStrings;
  IgnoreBadMasks:Boolean;
  CB:TCallbackBuildFileListFromMasks;
  Data:Pointer
):TStrings;
  var
    MaskList:TList;
    i :integer;
  procedure BuilMaskList;
    var
      i :integer;
      Mask:TMask;
      sMask:String;
  begin
    Mask := nil;
    try
    // Buil MaskList
    for i:= 0 to FileMasks.Count-1 do begin
      // check current mask:
      sMask := FileMasks[i];
      if Length(sMask)=0 then
        continue; // skip empty lines
      try
        Mask := TMask.Create(sMask);
      except
        if not IgnoreBadMasks then
          raise
        else
          continue; // ignore bad mask
      end;
      try
      // check syntax mask
        Mask.Matches('test');
      except
        on E:Exception do
        begin
          if not IgnoreBadMasks then
          begin
            E.Message := ('ERROR in Mask "'+FileMasks[i]+'" is syntactically invalid:'+E.Message);
            raise E;
          end
          else
            continue; // ignore bad mask
        end;
      end;
      MaskList.Add(Mask);
      Mask := nil;
    end;
    finally
      Mask.Free;
    end;
  end;//of: procedure BuilMaskList
  procedure LoopFilesCustom(StartDir: String; Recursive:Boolean);
   var
     Search :SysUtils.TSearchRec;
     Ignored, vAbort :Boolean;
     function MatchesByMaskList(Const Value:String):Boolean;
       var i:Integer;
     begin
       for i:=0 to MaskList.Count-1 do
       begin
         if TMask(MaskList[i]).Matches(Value) then
         begin
           Result := True;
            exit;
         end;
       end;
       Result := False;
     end;
  begin
    if Length(StartDir)=0 then
      exit;
    if StartDir[Length(StartDir)] <> '\' then
      StartDir := startdir + '\';
    if (SysUtils.FindFirst(StartDir + '*.*', faAnyFile, Search) = 0) then
    repeat
      if (Search.Name[1] <> '.' ) then
        if ((Search.Attr and faDirectory) > 0) then
        begin // Subdirectories:
          if Recursive then
            LoopFilesCustom(StartDir + Search.Name, Recursive);
        end
        else  // Files:
        begin
          //Ignored := not MatchesByMaskList(StartDir + Search.Name);
          Ignored := not MatchesByMaskList(Search.Name);
          if not Ignored then
          begin
            if Assigned(CB) then
            begin
              Ignored := False;
              vAbort := False;
              {$warnings off}// Symbol 'FindHandle' is specific to a platform
              CB(StartDir, Search.Name, Search.FindHandle, Ignored, Data, vAbort);
              {$warnings on}
              if vAbort then
                SysUtils.Abort;
            end;
            if not Ignored then
              Result.Add(StartDir + Search.Name);
            sleep(0);
          end;
        end;
    until FindNext(Search) <> 0;
    SysUtils.FindClose(Search);
  end;//of: function LoopFilesCustom
begin
  Result := TStringList.Create;
  try
    // check parameters
    if (FileMasks=nil)or(FileMasks.Count=0)or((RecursiveDirectories=nil)and(Directories=nil)) then
      exit;
    if Assigned(RecursiveDirectories) then
      i := RecursiveDirectories.Count
    else
      i:=0;
    if Assigned(Directories) then
      inc(i,Directories.Count);
    if i=0 then
      exit;
    MaskList := TList.Create;
    try
      BuilMaskList;
      if Assigned(RecursiveDirectories) then
      begin
        for i:=0 to RecursiveDirectories.Count-1 do
          LoopFilesCustom(RecursiveDirectories[i], True);
      end;
      if Assigned(Directories) then
      begin
        for i:=0 to Directories.Count-1 do
          LoopFilesCustom(Directories[i], False);
      end;
    finally
      for i:=MaskList.Count-1 downto 0 do
        TMask(MaskList[i]).Free;
      MaskList.Free;
    end;
  except
    on e:EAbort do
    begin
    end
    else
    begin
      Result.Free;
      Result := nil;
      raise;
    end;
  end;
end;

{$endif ifdef VCL_5_USED}

{$ifndef BROKEN_UNICODE}

function GetWideCurrentDir: WideString;
var
  Buffer: array[0..MAX_PATH - 1] of WideChar;
begin
  SetWideString(Result, Buffer, GetCurrentDirectoryW(MAX_PATH, Buffer));
end;

function SetWideCurrentDir(const Dir: WideString): Boolean;
begin
  Result := SetCurrentDirectoryW(PWideChar(Dir));
end;

function CreateWideDir(const Dir: WideString): Boolean;
begin
  Result := CreateDirectoryW(PWideChar(Dir), nil);
end;

function RemoveWideDir(const Dir: WideString): Boolean;
begin
  Result := RemoveDirectoryW(PWideChar(Dir));
end;

function GetWideModuleName(Module: HMODULE): WideString;
var
  ModName: array[0..MAX_PATH] of WideChar;
begin
  SetWideString(Result, ModName, Windows.GetModuleFileNameW(Module, ModName, MAX_PATH));
end;
{$endif ifndef BROKEN_UNICODE}

{$ENDIF IFDEF WIN32}

end.
