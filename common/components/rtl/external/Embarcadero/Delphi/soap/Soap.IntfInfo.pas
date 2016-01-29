{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{              Interface RTTI Support                   }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


unit Soap.IntfInfo;

interface

{$IFDEF CPUX64}
  {$DEFINE PUREPASCAL}
{$ENDIF CPUX64}

uses
  System.SysUtils, System.TypInfo;

type

  PIntfParamEntry = ^TIntfParamEntry;
  TIntfParamEntry = record
    Flags: TParamFlags;
    Name: string;
    Info: PTypeInfo;
  end;

  TIntfParamEntryArray = array of TIntfParamEntry;

  TCallConv = System.TypInfo.TCallConv;

  PIntfMethEntry = ^TIntfMethEntry;
  TIntfMethEntry = record
    Name: string;
    CC: TCallConv;              { Calling convention }
    Pos: Integer;               { Index (relative to whole interface VMT) }
    ParamCount: Integer;
    ResultInfo: PTypeInfo;
    SelfInfo: PTypeInfo;
    Params: TIntfParamEntryArray;
    HasRTTI: Boolean;
  end;
  TIntfMethEntryArray = array of TIntfMethEntry;
  TPIntfMethEntryArray = array of PIntfMethEntry;

  { Governs how the MDA array is filled }
  TFillMethodArrayOpt = (fmoAllBaseMethods, fmoRTTIBaseMethods, fmoNoBaseMethods);

  PIntfMetaData = ^TIntfMetaData;
  TIntfMetaData = record
    Name: string;
    UnitName: string;
    MDA: TIntfMethEntryArray;
    IID: TGUID;
    Info: PTypeInfo;
    AncInfo: PTypeInfo;
    NumAnc: Integer;      { #Methods in base interfaces }
  end;

  EInterfaceRTTIException = class(Exception);

procedure GetIntfMetaData(Info: PTypeInfo; var IntfMD: TIntfMetaData; MethodArrayOpt: TFillMethodArrayOpt); overload;
procedure GetIntfMetaData(Info: PTypeInfo; var IntfMD: TIntfMetaData; IncludeAllAncMethods: Boolean = False); overload;
function  GetMethNum(const IntfMD: TIntfMetaData; const MethName: string;
          ParamCount: Integer = -1): Integer;

{ Dynamic Array RTTI helpers }
procedure GetDynArrayElTypeInfo(typeInfo: PTypeInfo; var EltInfo: PTypeInfo; var Dims: Integer);
function  GetDynArrayNextInfo(typeInfo: PTypeInfo): PTypeInfo;
function  GetDynArrayNextInfo2(typeInfo: PTypeInfo; var Name: string): PTypeInfo;

function  TypeNamesMatch(const RegName: string; const OtherName: string): boolean;
function  OtherTypeName(const TypeName: string): string;
function  SameTypeInfo(const RegInfo: PTypeInfo; const OtherInfo: PTypeInfo): boolean;

function  GetPropListFlat(TypeInfo: PTypeInfo; out PropList: PPropList): Integer;
function  IsStoredPropConst(Instance: TObject; PropInfo: PPropInfo): Boolean;
function  GetClsMemberTypeInfo(const ObjectTypeInfo: PTypeInfo; const MemberName: string = ''): PTypeInfo;

{ The following routines are used from C++ to validate the compatibility of C++ interface generation}
{$IFDEF DEVELOPERS}
function  ReadString(var P: Pointer): String;
function  ReadByte(var P: Pointer): Byte;
function  ReadWord(var P: Pointer): Word;
function  ReadLong(var P: Pointer): Integer;
procedure FillMethodArray(P: Pointer; IntfMD: PIntfMetaData; Offset, Methods: Integer);
function  GetNumAncMeths(P: Pointer; WithRTTIOnly: Boolean = False): Integer;
function  WalkAncestors(PP: PPTypeInfo; AddMeths: Boolean; IntfMD: PIntfMetaData; WithRTTIOnly: Boolean): Integer;
{$ENDIF}

const
  CallingConventionName:  array[ccReg..ccSafeCall] of string =
     ('REGISTER', 'CDECL', 'PASCAL', 'STDCALL', 'SAFECALL');                    { do not localize }

  TypeInfoNames:  array[0..37] of string = ( 'Boolean',       'bool',             { do not localize }
  {$IFNDEF UNICODE}
                                             'Char',          'char',             { do not localize }
                                             'Char',          'signed char',      { do not localize }
                                             'WideChar',      'wchar_t',          { do not localize }
  {$ELSE}
                                             'AnsiChar',      'char',             { do not localize }
                                             'AnsiChar',      'signed char',      { do not localize }
                                             'Char',          'wchar_t',          { do not localize }
  {$ENDIF}
                                             'Byte',          'unsigned char',    { do not localize }
                                             'SmallInt',      'short',            { do not localize }
                                             'Word',          'unsigned short',   { do not localize }
                                             'Integer',       'int',              { do not localize }
                                             'Cardinal',      'unsigned int',     { do not localize }
                                             'Integer',       'long',             { do not localize }
                                             'Cardinal',      'unsigned long',    { do not localize }
                                             'Int64',         '__int64',          { do not localize }
                                             'Int64',         'unsigned __int64', { do not localize }
                                             'Single',        'float',            { do not localize }
                                             'Double',        'double',           { do not localize }
                                             'Extended',      'long double',      { do not localize }
  {$IFNDEF UNICODE}
                                             'string',        'AnsiString',       { do not localize }
                                             'UnicodeString', 'UnicodeString',    { do not localize }
  {$ELSE}
                                             'string',        'UnicodeString',    { do not localize }
                                             'AnsiString',    'AnsiString',       { do not localize }
  {$ENDIF}
                                             'WideString',    'WideString');      { do not localize }



implementation

uses
  System.Classes, Soap.SOAPConst;

const
  CCMap:  array[0..4] of TCallConv = (ccReg, ccCdecl, ccPascal, ccStdCall, ccSafeCall);


function GetMethNum(const IntfMD: TIntfMetaData; const MethName: string;
         ParamCount: Integer = -1): Integer;

  function CalcParamCount(const Start: Integer; const Entry: TIntfMethEntry): Integer;
  var
    I: Integer;
  begin
    Result := Start;
    { Not needed for C++ Builder }
                                                                                                         
    for I := 0 to Entry.ParamCount do
      if pfOut in Entry.Params[I].Flags then
        Inc(Result);
  end;

var
  I, NumNames, ExpCount: Integer;
begin
  NumNames := 0;
  Result := -1;
  for I := 0 to Length(IntfMD.MDA) - 1 do
  begin
                                                                                    
                    
    if SameText(IntfMD.MDA[I].Name, MethName) then
    begin
      if ParamCount <> -1 then
      begin
        ExpCount := CalcParamCount(ParamCount, IntfMD.MDA[I]);
        if ExpCount <> IntfMD.MDA[I].ParamCount then
          continue;
      end;
      Result := I;
      Inc(NumNames);
    end;
  end;
  if (NumNames = 0) and (ParamCount <> -1) then
    Result := GetMethNum(IntfMD, MethName, -1);
  if NumNames > 1 then
    Result := -1;
end;

function ReadString(var P: Pointer): String;
var
  B: Byte;
{$IFDEF UNICODE}
{$IFDEF NEXTGEN}
  AStr: TBytes;
{$ELSE !NEXTGEN}
  AStr: AnsiString;
{$ENDIF NEXTGEN}
{$ENDIF}
begin
  B := Byte(P^);
{$IFDEF UNICODE}
  SetLength(AStr, B);
  P := Pointer(NativeInt(P)+1);
{$IFDEF NEXTGEN}
  Move(P^, AStr[0], Integer(B));
  Result := Tencoding.UTF8.GetString(AStr);
{$ELSE !NEXTGEN}
  Move(P^, AStr[1], Integer(B));
  Result := UTF8ToString(AStr);
{$ENDIF NEXTGEN}
{$ELSE}
  SetLength(Result, B);
  P := Pointer( NativeInt(P) + 1);
  Move(P^, Result[1], Integer(B));
{$ENDIF}
  P := Pointer( NativeInt(P) + B );
end;

function ReadByte(var P: Pointer): Byte;
begin
  Result := Byte(P^);
  P := Pointer(NativeInt(P) + 1);
end;

function ReadWord(var P: Pointer): Word;
begin
  Result := Word(P^);
  P := Pointer( NativeInt(P) + 2);
end;

function ReadLong(var P: Pointer): Integer;
begin
  Result := Integer(P^);
  P := Pointer( NativeInt(P) + 4);
end;

function ReadPointer(var P: Pointer): Pointer;
begin
  Result := Pointer(P^);
  P := Pointer( NativeInt(P) + SizeOf(Pointer));
end;

procedure FillMethodArray(P: Pointer; IntfMD: PIntfMetaData; Offset, Methods: Integer);
var
  S: string;
  I, J, K: Integer;
  PPInfo: PPTypeInfo;
  ParamCount: Integer;
  Kind, Flags: Byte;
  ParamInfo: PTypeInfo;
  ParamName: string;
  IntfMethod: PIntfMethEntry;
  IntfParam: PIntfParamEntry;
begin
  for I := 0 to Methods -1 do
  begin
    IntfMethod := @IntfMD.MDA[Offset];
    IntfMethod.Name := ReadString(P);
    Kind := ReadByte(P);           { tkKind }
    IntfMethod.CC := CCMap[ReadByte(P)];
    ParamCount := ReadByte(P);     { Param count including self }
    IntfMethod.ParamCount := ParamCount - 1;
    IntfMethod.Pos := Offset;
    IntfMethod.HasRTTI := True;

    SetLength(IntfMethod.Params, ParamCount);
    K := 0;
    for J := 0 to ParamCount - 1 do
    begin
      Flags := ReadByte(P);       { Flags }
      ParamName := ReadString(P); { Param name }
      S := ReadString(P);         { Param type name }
      PPInfo := ReadPointer(P);   { Param Type Info }
      Inc(PByte(P), PWord(P)^);   { skip attributes }
      if PPInfo <> nil then
        ParamInfo := PPInfo^
      else
        raise EInterfaceRTTIException.CreateFmt(SNoRTTIParam, [ParamName, IntfMethod.Name, IntfMD.UnitName + '.' + IntfMd.Name]);
      if J = 0 then
        IntfMethod.SelfInfo := ParamInfo
      else
      begin
        IntfParam := @IntfMethod.Params[K];
        IntfParam.Flags := TParamFlags(Flags);
        IntfParam.Name := ParamName;
        IntfParam.Info := ParamInfo;
        Inc(K);
      end;
    end;
    if Kind = Byte(mkFunction) then
    begin
      S := ReadString(P);
      IntfMethod.ResultInfo := PPTypeInfo(ReadPointer(P))^;
    end;
    Inc(PByte(P), PWord(P)^); // skip attributes
    Inc(Offset);
  end;
end;

function WalkAncestors(PP: PPTypeInfo; AddMeths: Boolean; IntfMD: PIntfMetaData; WithRTTIOnly: Boolean): Integer;
var
  S: string;
  AncTP: Pointer;
  P: Pointer;
  B: Byte;
  NumMethods, NumAncMeths, I: Integer;
  HasRTTI: Boolean;
begin
  P := Pointer(PP^);
  ReadByte(P);                       // Kind
  S := ReadString(P);                // Symbol name
  AncTP := ReadPointer(P);           // Ancestor TypeInfo
  P := Pointer(Integer(P) + 17);     // Intf.flags and GUID
  B := Byte(P^);                     // Length
  P := Pointer(Integer(P) + B + 1);  // Unit name  and count
  NumMethods :=  ReadWord(P);        // # methods
  I := ReadWord(P);                  // $FFFF if no RTTI, # methods again if has RTTI
  HasRTTI := (I <> $FFFF);

  { Compute the number of methods }
  if (AncTP <> nil) and (HasRTTI or (WithRTTIOnly = False)) then
  begin
    NumAncMeths  := WalkAncestors(AncTP, False, nil, WithRTTIOnly);
  end else
    NumAncMeths := 0;
  { Ancestor count }
  Result := NumAncMeths;
  { Plus our own }
  if (HasRTTI or (WithRTTIOnly = False)) then
    Result := Result + NumMethods;
  { Do we need to fill in method information too? }
  if AddMeths then
  begin
    if HasRTTI then
    begin
      FillMethodArray(P, IntfMD, NumAncMeths, NumMethods);
      if NumAncMeths > 0 then
         WalkAncestors(AncTP, AddMeths, IntfMD, WithRTTIOnly);
    end;
  end;
end;

function GetNumAncMeths(P: Pointer; WithRTTIOnly: Boolean = False): Integer;
var
  B: Byte;
  Anc: Pointer;
begin
  Result := 0;
  ReadByte(P);                      // tkKind
  B := Byte(P^);                    // Symbol length
  P := Pointer(Integer(P) + B + 1); // Skip sym name  and count
  Anc := ReadPointer(P);            // Ancestor pointer
  if Anc <> nil then
    Result := WalkAncestors(Anc, False, nil, WithRTTIOnly);
end;

procedure GetIntfMetaData(Info: PTypeInfo; var IntfMD: TIntfMetaData; MethodArrayOpt: TFillMethodArrayOpt);
var
  I, Offset: Integer;
  Methods: Integer;
  BaseRTTIMethods: Integer;
  HasRTTI: Integer;
  PP: PPTypeInfo;
  P: Pointer;
  SelfMethCount: Integer;
begin
  P := Pointer(Info);
  { Get total number of ancestor methods }
  IntfMD.NumAnc := GetNumAncMeths(P);
  { Get base methods we could expose }
  BaseRTTIMethods := GetNumAncMeths(P, True);
  IntfMD.Info := Info;
  { tkKind }
  ReadByte(P);
  IntfMD.Name := ReadString(P);
  PP := PPTypeInfo(ReadPointer(P));
  { Ancestor typeinfo }
  if PP <> nil then
    IntfMD.AncInfo := PP^
  else
    IntfMD.AncInfo := nil;
  { Interface flags }
  ReadByte(P);
  IntfMD.IID.D1 := LongWord(ReadLong(P));
  IntfMD.IID.D2 := ReadWord(P);
  IntfMD.IID.D3 := ReadWord(P);
  for I := 0 to 7 do
    IntfMD.IID.D4[I] := ReadByte(P);
  IntfMD.UnitName := ReadString(P);
  Methods := ReadWord(P);   { # methods }
  HasRTTI := ReadWord(P);   { $FFFF if no RTTI, # methods again if has RTTI }
  if HasRTTI = $FFFF then
    raise EInterfaceRTTIException.CreateFmt(SNoRTTI, [IntfMD.UnitName + '.' + IntfMd.Name]);
  { Save my method count }
  SelfMethCount := Methods;
  { Update count of methods }
  if (MethodArrayOpt = fmoAllBaseMethods) then
  begin
    Methods := Methods + IntfMD.NumAnc;
    Offset := IntfMD.NumAnc;
  end else
  if (MethodArrayOpt = fmoRTTIBaseMethods) then
  begin
    Methods := Methods + BaseRTTIMethods;
    Offset := BaseRTTIMethods;
  end else
    Offset := 0;
  { Size array and fill in information }
  SetLength(IntfMD.MDA, Methods);
  FillMethodArray(P, @IntfMD, Offset, SelfMethCount);
  { Include method info. of base methods too?? }
  if (MethodArrayOpt = fmoAllBaseMethods) or
     (MethodArrayOpt = fmoRTTIBaseMethods)  then
  begin
    if PP <> nil then
      WalkAncestors(PP, True, @IntfMD, (MethodArrayOpt = fmoRTTIBaseMethods));
  end;
end;

procedure GetIntfMetaData(Info: PTypeInfo; var IntfMD: TIntfMetaData; IncludeAllAncMethods: Boolean);
var
  FillMethodArrayOpt: TFillMethodArrayOpt;
begin
  if (IncludeAllAncMethods) then
    FillMethodArrayOpt := fmoAllBaseMethods
  else
    FillMethodArrayOpt := fmoRTTIBaseMethods;
  GetIntfMetaData(Info, IntfMD, FillMethodArrayOpt);
end;

procedure GetDynArrayElTypeInfo(typeInfo: PTypeInfo; var EltInfo: PTypeInfo; var Dims: Integer);
var
  S: string;
  P: Pointer;
  ppInfo: PPTypeInfo;
  Info: PTypeInfo;
  CleanupInfo: Boolean;
begin
  CleanupInfo := False;
  Dims := 0;
  P := Pointer(typeInfo);
  ReadByte(P);            { kind }
  S := ReadString(P);     { symname }
  ReadLong(P);            { elsize }
  ppInfo := ReadPointer(P);

  { Here we rely on Cleanup TypeInfo. However, that's not
    reliable, specially in the case of C++ where the concept
    of cleanup is muddled since the Dynamic Array class
    destructor handles the clean up. Hence, we'll handle both styles
    of RTTI }
  if (ppInfo <> nil) then
  begin
    CleanupInfo := True;
    Info := ppInfo^;
    if Info.Kind = tkDynArray then
    begin
      GetDynArrayElTypeInfo(Info, EltInfo, Dims);
    end;
  end;

  ReadLong(P);      { vartype }
  ppInfo := ReadPointer(P); { elttype, even if not destructable, 0 if type has no RTTI }
  if ppInfo <> nil then
  begin
    EltInfo := ppInfo^;
    if not CleanupInfo then
    begin
      Info := EltInfo;
      if Info.Kind = tkDynArray then
        GetDynArrayElTypeInfo(Info, EltInfo, Dims);
    end;
  end;
  Inc(Dims);
end;

function GetDynArrayNextInfo(typeInfo: PTypeInfo): PTypeInfo;
var
  S: string;
begin
  Result := GetDynArrayNextInfo2(typeInfo, S);
end;

function GetDynArrayNextInfo2(typeInfo: PTypeInfo; var Name: string): PTypeInfo;
var
  P: Pointer;
  ppInfo: PPTypeInfo;
begin
  Result := nil;
  P := Pointer(typeInfo);
  ReadByte(P);            { kind }
  Name := ReadString(P);  { synmame }
  ReadLong(P);            { elsize }
  ppInfo := ReadPointer(P);
  if ppInfo <> nil then
    Result := ppInfo^   { eltype or 0 if not destructable }
  else
  begin
    ReadLong(P);      { vartype }
    ppInfo := ReadPointer(P); { elttype, even if not destructable, 0 if type has no RTTI }
    if ppInfo <> nil then
      Result := ppInfo^;
  end;
end;

function SameTypeInfo(const RegInfo: PTypeInfo; const OtherInfo: PTypeInfo): boolean;
begin
  Result := (RegInfo = OtherInfo) or
            ((RegInfo.Kind=OtherInfo.Kind) and
{$IFDEF UNICODE}
              // Technically we don't need to decode since we're looking for
              // a known set of type names but for completeness we pass the
              // real type  name.
              TypeNamesMatch(UTF8ToString(RegInfo^.Name),
                             UTF8ToString(OtherInfo^.Name)));
{$ELSE}
              TypeNamesMatch(RegInfo^.Name,
                             OtherInfo^.Name));
{$ENDIF}
end;

function TypeNamesMatch(const RegName: string; const OtherName: string): boolean;
var
  I: Integer;
begin
  Result := (RegName = OtherName);
  if (not Result) then
  begin
    I := 1; { Start at one since we check OtherName first }
    while (I < Length(TypeInfoNames)) do
    begin
      if (OtherName = TypeInfoNames[I]) then
      begin
        Result := (RegName = TypeInfoNames[I-1]);
        Exit;
      end;
      I := I+2;
    end;
  end;
end;

function OtherTypeName(const TypeName: string): string;
var
  I: Integer;
begin
  I := 0;
  while (I < (Length(TypeInfoNames)-1)) do
  begin
    if (TypeName = TypeInfoNames[I]) then
    begin
      Result := TypeInfoNames[I+1];
      Exit;
    end;
    I := I+2;
  end;
end;

{$IFNDEF NEXTGEN}
function AfterString(Str: PShortString): Pointer; inline;
begin
  Result := Pointer(PByte(Str) + Length(Str^) + 1);
end;
{$ENDIF !NEXTGEN}

{ Similar to TypInfo's GetPropInfos except that we don't walk up the base classes }
procedure GetPropInfosFlat(TypeInfo: PTypeInfo; PropList: PPropList); assembler;
var
  TypeData: PTypeData;
  PropData: PPropData;
  PropInfo: PPropInfo;
  I: Integer;
begin
  TypeData := GetTypeData(TypeInfo);
  FillChar(PropList^, Sizeof(PPropInfo) * TypeData.PropCount, #0);

  PropData := TypeData.PropData;
  PropInfo := PPropInfo(@PropData^.PropList);
  for I := 1 to PropData^.PropCount do
  begin
    if PropList^[PropInfo.NameIndex] = nil then
      PropList^[PropInfo.NameIndex] := PropInfo;
    PropInfo := PropInfo.Tail;
  end;

end;

function GetPropListFlat(TypeInfo: PTypeInfo; out PropList: PPropList): Integer;
begin
  Result := GetTypeData(TypeInfo)^.PropCount;
  if Result > 0 then
  begin
    GetMem(PropList, Result * SizeOf(Pointer));
    try
      FillChar(PropList^, Result * SizeOf(Pointer), 0);
      GetPropInfosFlat(TypeInfo, PropList);
    except
      FreeMem(PropList);
      PropList := nil;
      raise;
    end;
  end;
end;

{ Similar to TypInfo's IsStoredProp although this version only handles cases
  where the attribute was assigned 'true' or 'false' directly. IOW, this version
  will always assume stored is true unless the value 'false' was assigned directly
  to the property.
  NOTE: the 'Instance' parameter is not used nor required. }
function IsStoredPropConst(Instance: TObject; PropInfo: PPropInfo): Boolean;
type
  TStoredProc = function(Instance: TObject): Boolean;
begin
  Result := True;
  // if is constant
  if (NativeUInt(PropInfo^.StoredProc) and (not NativeUInt($FF))) = 0 then
    Exit(Boolean(NativeUInt(PropInfo^.StoredProc) and $FF));
end;

{ Returns the TypeInfo of a class member }
function GetClsMemberTypeInfo(const ObjectTypeInfo: PTypeInfo; const MemberName: string): PTypeInfo;
var
  PropList: PPropList;
  Size, Props: Integer;
begin
  Result := nil;
  Size := GetPropListFlat(ObjectTypeInfo, PropList);
  if Size > 0 then
  begin
    try
      for Props := 0 to Size -1 do
      begin
        if PropList[Props] <> nil then
        begin
          { Either there's a match or send the only member's TypeInfo back }
{$IFDEF UNICODE}
{$IFDEF NEXTGEN}
          if SameText(UTF8ToString(PropList[Props].Name), MemberName)
{$ELSE !NEXTGEN}
          if SameText(UTF8ToUnicodeString(PropList[Props].Name), MemberName)
{$ENDIF NEXTGEN}
{$ELSE}
          if SameText(PropList[Props].Name, MemberName)
{$ENDIF}
             or ((MemberName = '') and (Size = 1)) then
          begin
            Result := PropList[Props].PropType^;
            Exit;
          end;
        end;
      end;
    finally
      FreeMem(PropList);
    end;
  end;
end;

end.
