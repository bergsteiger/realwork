// **********************************************************************
//
// Copyright (c) 2001 - 2002 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit codeutil;

interface

uses
  classes,sysutils,ir_int,orb_int,orbtypes;

type

  TPrintStream = class(TMemoryStream)
  public
    procedure println(str: AnsiString = '');
    procedure print(str: AnsiString);
  end;

  function safe_name(name: AnsiString): AnsiString;

  function coder_method(const method, atype: AnsiString): AnsiString;

  function name_without_prefix(acont : IContained): boolean;

  function already_included(const file_name: AnsiString): boolean;

  function CreateStringGUID(const RepoId: AnsiString): AnsiString;

  function name_with_namespace(const AbsName, AName: AnsiString): AnsiString;

  function OpenFile(const AName: AnsiString): TFileStream;

const
  CR: byte = 13;

var
  ModuleWithoutPrefix: TStringList;
  NoUses: TStringList;
  StoreGUID: Boolean = False;
  NameSpaces: Boolean = False;
  StreamList: TStringList;

implementation

uses ir, IniFiles{$IFDEF MSWINDOWS}, Windows, ComObj{$ENDIF};

var
  IdlToPasIni: TIniFile = nil;

//*********************************************************************
//  TPrintStream
//*********************************************************************
procedure TPrintStream.println;
begin
  if str <> '' then
    write(PAnsiChar(str)^,length(str));
  write(CR,1);
end;

procedure TPrintStream.print(str: AnsiString);
begin
  write(PAnsiChar(str)^,length(str));
end;

function safe_name(name: AnsiString): AnsiString;
begin
  result := name;
  name := AnsiString(lowercase(String(name)));
  if (name = 'and') or (name = 'array') or (name = 'as') or (name = 'asm') or (name = 'assign') or (name = 'automated') or (name = 'at') or
     (name = 'begin') or
     (name = 'case') or (name = 'class') or (name = 'const') or (name = 'constructor') or (name = 'create') or
     (name = 'destructor') or (name = 'dispinterface') or (name = 'div') or (name = 'do') or (name = 'downto') or (name = 'destroy')  or (name = 'date') or
     (name = 'else') or (name = 'end') or (name = 'except') or (name = 'exports') or
     (name = 'file') or (name = 'finalization') or (name = 'finally') or (name = 'for') or (name = 'function') or (name = 'free') or
     (name = 'goto') or
     (name = 'if') or (name = 'implementation') or (name = 'in') or (name = 'inherited') or (name = 'initialization') or (name = 'inline') or (name = 'interface') or (name = 'is') or
     (name = 'label') or (name = 'library') or
     (name = 'mod') or
     (name = 'nil') or (name = 'not') or
     (name = 'object') or (name = 'of') or (name = 'or') or (name = 'out') or (name = 'on') or
     (name = 'packed') or (name = 'procedure') or (name = 'program') or (name = 'property') or (name = 'private') or (name = 'protected') or (name = 'public') or (name = 'published') or
     (name = 'raise') or (name = 'record') or (name = 'repeat') or (name = 'resourcestring') or (name = 'result') or
     (name = 'set') or (name = 'shl') or (name = 'shr') or (name = 'string') or
     (name = 'then') or (name = 'threadvar') or (name = 'to') or (name = 'try') or (name = 'type') or
     (name = 'unit') or (name = 'until') or (name = 'uses') or
     (name = 'var') or
     (name = 'while') or (name = 'with') or
     (name = 'xor') then
    result := '_'+result;   
end;

function coder_method(const method, atype: AnsiString): AnsiString;
var
  ltype : String;
begin
  ltype := String(atype);
  //remove _ prefix in some types
  if (ltype = '_ushort') or (ltype = '_ulong') or (ltype = '_ulonglong') then
    Delete(ltype, 1, 1);
  //WJ: Switch type for Ansi(String/Char)
  if LowerCase(ltype) = 'ansichar' then
    ltype := 'char';
  if LowerCase(ltype) = 'ansistring' then
    ltype := 'string';
  result := method + AnsiString(ltype);
end;

function is_internal_module(const module_name: AnsiString): boolean;
begin
  result := (module_name = 'dynamic') or
            (module_name = 'corba') or
            (module_name = 'messaging') or
            (module_name = 'iop') or
            (module_name = 'policy') or
            (module_name = 'portableinterceptor');
end;

function name_without_prefix(acont : IContained): boolean;
var
  cont: IContainer;
  con : IContained;
begin
  if acont = nil then begin
    result := false;
    Exit;
  end;
  cont := acont.defined_in;
  con := TContained._narrow(cont as IORBObject);
  if (acont.def_kind = dk_Interface) and (cont.def_kind = dk_Module) and
     (acont._name = 'Current') and (con._name = 'CORBA') then begin
    //prevent conflict with "Current" from CORBA module
    result := false;
    Exit;
  end;
  case cont.def_kind of
    dk_Module: begin
      result := is_internal_module(AnsiString(LowerCase(String(con._name)))) or (ModuleWithoutPrefix.IndexOf(String(con._name)) <> -1);
    end
    else begin
      result := name_without_prefix(con);
    end;
  end;
end;

function name_with_namespace(const AbsName, AName: AnsiString): AnsiString;
begin
  //Result := TTextRec(Output).Name + '.' + AName;
end;

function already_included(const file_name: AnsiString): boolean;
var
  fn: string;
begin
  fn := LowerCase(String(file_name));
  result := (fn = 'orb') or
            (fn = 'orbtypes') or
            (fn = 'dynamic') or
            (fn = 'codec') or
            (fn = 'iop') or
            (fn = 'messaging');
  if not result then
    result := NoUses.IndexOf(fn) >= 0;
end;

function CreateStringGUID(const RepoId: AnsiString): AnsiString;

  function Generate: AnsiString;
  {$IFDEF LINUX}
  var
    newGUID: TGUID;
  {$ENDIF}
  begin
  {$IFDEF MSWINDOWS}
    Result := AnsiString(CreateClassID());
  {$ENDIF}
  {$IFDEF LINUX}
    CreateGUID(newGUID);
    Result := GUIDToString(newGUID);
  {$ENDIF}
  end;

begin
  if StoreGUID then begin
    if IdlToPasIni = nil then
      IdlToPasIni := TIniFile.Create(GetCurrentDir + '/idltopas.ini');
    Result := AnsiString(IdlToPasIni.ReadString(String(RepoId), 'GUID', ''));
    if Result = '' then begin
      Result := Generate();
      IdlToPasIni.WriteString(String(RepoId), 'GUID', String(Result));
    end;
  end
  else
    Result := Generate();
end;

function OpenFile(const AName: AnsiString): TFileStream;
var
  name: String;
begin
  name := StringReplace(Trim(String(AName)), '\', '/', [rfReplaceAll]);
  if StreamList.IndexOf(name) <> -1 then begin
    Result := TFileStream(StreamList.Objects[StreamList.IndexOf(name)]);
    Result.Position := 0;
  end
  else begin
    Result := TFileStream.Create(name, fmOpenRead);
    StreamList.AddObject(name, Result)
  end;
end;

initialization
  ModuleWithoutPrefix := TStringList.Create;
  StreamList := TStringList.Create;
  NoUses := TStringList.Create;
  NoUses.CaseSensitive := False;
finalization
  ModuleWithoutPrefix.Free;
  NoUses.Free;
  IdlToPasIni.Free;
  StreamList.Free;
end.
