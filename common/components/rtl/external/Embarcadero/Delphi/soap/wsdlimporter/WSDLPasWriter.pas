{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WSDLPasWriter;

interface

uses
  TypInfo, xmldom, WSDLImpWriter, WSDLModelIntf;

type

  TWSDLPasWriter = class(TWSDLWriter)
  private
    function GetPartFlagList(const Part: IWSDLPart; SkipFlags: TPartFlag = []): string;

  protected
    function  IsDynArrayType(ArrayType: string): Boolean;

    { Overriden for Pascal Codegeneration }
    function  IsReservedWord(const Name: DOMString; var NewName: DOMString): Boolean; override;
    procedure ValidatePortTypes(const WSDLPortTypeArray: IWSDLPortTypeArray); override;
    function  TypeNameFromTypeInfo(TypeInfo: pTypeInfo): DOMString; override;
    procedure WriteInterfaceBegin(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); override;
    procedure WriteInterfaceEnd(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); override;
    procedure WriteMethod(const WSDLOperation: IWSDLOperation; const Parent: IWSDLPortType; PassType: TPassWriterType); override;
    procedure WriteEnum(const WSDLType: IWSDLType); override;
    procedure WriteAliasDef(const WSDLType: IWSDLType); override;
    procedure WriteArray(const WSDLType: IWSDLType); override;
    procedure WriteComplexTypeClass(const WSDLType: IWSDLType; PassType: TPassWriterType); override;
    procedure WriteTypeIntro(const WSDLType: IWSDLType);
    function  GetTypeInfoPad: DOMString; override;
    function  IsCaseSensitive: Boolean; override;
    function  GetTypeInfo(const WSDLType: IWSDLType): DOMString; override;
    function  Escape(const S: DOMString): DOMString; override;
    procedure WriteEnumPrologue; override;
    procedure WriteEnumEpilogue; override;

  public
    constructor Create(const WSDLImporter: IWSDLImporter); override;
    constructor CreateFilename(const WSDLImporter: IWSDLImporter; OutFileName : string); override;

    destructor  Destroy; override;

    procedure WriteIntfHeader; override;
    procedure WriteIntfFooter; override;
    procedure WriteImplHeader; override;
    function  WriteSettingsFile: Boolean; override;
    procedure SetOutFile(const outFile: string; CheckProject: Boolean); override;

    function  SourceExt: DOMString; override;
    procedure WriteRegCalls; override;
  end;

  TWSDLPasWriterClass = class of TWSDLPasWriter;

implementation

uses
  WSDLImpConst, SOAPConst,
{$IFNDEF STANDALONE}
  GenWizard,
{$ENDIF}
  Types, HTTPUtil, XMLSchemaHelper, XSBuiltIns, SysUtils, WSDLIntf,
  InvokeRegistry, Character;

const
                                          { Unknown, in,     out,    inOut,  ret }
  PreParamMod: array[PartType] of string = ('',   'const ', 'out ',  'var ', '', '', '');  { Do not localize }

{ TWSDLPasWriter }

constructor TWSDLPasWriter.Create(const WSDLImporter: IWSDLImporter);
begin
  inherited Create(WSDLImporter);
end;

destructor TWSDLPasWriter.Destroy;
begin
  inherited Destroy;
end;

function TWSDLPasWriter.IsReservedWord(const Name: DOMString; var NewName: DOMString): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(ReservedWords) to High(ReservedWords) do
    if SameText(Name, ReservedWords[I]) then
    begin
      Result := True;
      Exit;
    end;
  for I := Low(Directives) to High(Directives) do
    if SameText(Name, Directives[I]) then
    begin
      Result := True;
      Exit;
    end;
  for I := Low(OtherReservedWords) to High(OtherReservedWords) do
    if SameText(Name, OtherReservedWords[I]) then
    begin
      Result := True;
      Exit;
    end;
  for I := Low(ScalarArrayTypes) to High(ScalarArrayTypes) do
    if SameText(Name, ScalarArrayTypes[I]) then
    begin
      Result := True;
      Exit;
    end;

  // Check for overrides in WSDLImp.sym file
  if not Result then
  begin
    Result := WSDLImpWriter.IsReservedNameInSymFile(Name, False, NewName);
  end;
end;

function TWSDLPasWriter.IsDynArrayType(ArrayType: string): Boolean;
var
  Index: Integer;
begin
  Result := False;
  for Index := 0 to Length(DynArrayTypes) -1 do
  begin
    if DynArrayTypes[Index] = ArrayType then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TWSDLPasWriter.TypeNameFromTypeInfo(TypeInfo: pTypeInfo): DOMString;
begin
  Result := DOMString(TypeInfo.Name);
end;

procedure TWSDLPasWriter.ValidatePortTypes(const WSDLPortTypeArray: IWSDLPortTypeArray);
begin
  inherited ValidatePortTypes(WSDLPortTypeArray);
  { Here we could do extra validation for Pascal }
end;

procedure TWSDLPasWriter.WriteIntfHeader;
const
  UseMIDAS: array[Boolean] of string = ('', sSOAPMidas);
  sMacros: array[WSDLImporterOpts] of string = (
                  '',           // woHasSOAPDM,          // SOAP Data module in the WSDL
                  '',           // woHasDocumentStyle,   // Document style services
                  '',           // woHasLiteralUse,      // Literal service
                  sPasIsOptn,   // woHasOptionalElem,    // Types with optional elements
                  sPasIsUnbd,   // woHasUnboundedElem,   // Types with unbounded elements
                  sPasIsNlbl,   // woHasNillableElem,    // Types with nillable elements
                  sPasIsUnql,   // woHasUnqualifiedElem, // Types with unqualified elements
                  sPasIsAttr,   // woHasAttribute,       // Complex types with attributes
                  sPasIsText,   // woHasText,             // Properties that map to 'text' nodes - not ntElement
                  sPasIsAny,    // woHasAny
                  sPasIsRef,    // woHasRef
                  sPasIsQual,   // woHasQualifiedAttr
                  ''            // woHasOut
       );
var
  Opt: WSDLImporterOpts;
  ImpOpts: TWSDLImporterOpts;
begin
  WriteWSDLInfo;
  { Unit declaration, uses... }
  WriteFmt(sUnitBeg, [OutFile, UseMidas[woHasSOAPDM in FWSDLImporter.Options]]);

  { 'const' section }
  if EmitIndexMacros(ImpOpts)
{$IFDEF REGISTER_UDDI_INFO}
     or (FWSDLImporter.UDDIImportInfo <> nil)
{$ENDIF}
     then
    WriteStr(sConstBeg);

  { Flags for Index of properties }
  if EmitIndexMacros(ImpOpts) then
  begin
    for Opt := Low(WSDLImporterOpts) to High(WSDLImporterOpts) do
      if (Opt in ImpOpts) and (sMacros[Opt] <> '') then
        WriteStr(sMacros[Opt]);
    WriteLn('');
  end;

  { Do we have UDDI Import information? }
{$IFDEF REGISTER_UDDI_INFO}
  if (FWSDLImporter.UDDIImportInfo <> nil) then
    WriteFmt(sUDDIConst, [FWSDLImporter.UDDIImportInfo.UDDIOperator,
                          FWSDLImporter.UDDIImportInfo.BindingKey]);
{$ENDIF}

  { 'type' section - Do we have types or interfaces }
  if (Length(FWSDLImporter.GetTypes) > 0) or
     (Length(FWSDLImporter.GetPortTypes) > 0) then
    WriteStr(sTypeBeg)
  else
    WriteStr(Format(sLineBreak + sPasComment, [sNoBindingsFound]));
end;

procedure TWSDLPasWriter.WriteImplHeader;
begin
  { Write 'implementation' }
  WriteStr(sUnitImpl);
  { If we're in client mode, add uses }
  if not (wfServer in Global_WSDLGenFlags) then
    WriteStr(sUnitUses)
  else
    WriteLn('');

  { Write 'types' in we're about to implement }
  if (wfServer in Global_WSDLGenFlags) and
     (Length(FWSDLImporter.GetPortTypes) > 0) then
    WriteStr(sUnitType);
end;

procedure TWSDLPasWriter.WriteIntfFooter;
begin
  WriteFmt(sUnitEnd, [OutFile]);
end;

function  TWSDLPasWriter.SourceExt: DOMString;
begin
  Result := '.pas';                                                     { Do not localize }
end;

procedure TWSDLPasWriter.WriteTypeIntro(const WSDLType: IWSDLType);
begin
  if Verbose then
    WriteLn(GetTypeInfo(WSDLType));
end;

function TWSDLPasWriter.GetTypeInfoPad: DOMString;
begin
  Result := '  ';
end;

function TWSDLPasWriter.IsCaseSensitive: Boolean;
begin
  Result := False;
end;

{ Pascal does not allow the unit name to collide with a type name, so
  we override here to handle this issue }
procedure TWSDLPasWriter.SetOutFile(const outFile: string; CheckProject: Boolean);

  { Returns true of specified name matches that of a type }
  function IsTypeName(const Name: string): boolean;
  var
    WSDLType: IWSDLType;
  begin
    Result := False;
    for WSDLType in FWSDLImporter.GetTypes do
    begin
      if SameText(WSDLType.LangName, Name) Then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  { Returns true if the specified name is that of a PortType }
  function IsPortTypeName(const Name: string): boolean;
  var
    PortTypes: IWSDLPortTypeArray;
    PortType: IWSDLPortType;
    I: integer;
  begin
    Result := False;
    PortTypes := FWSDLImporter.GetPortTypes;
    for I := 0 to Length(PortTypes)-1 do
    begin
      PortType := PortTypes[I];
      if SameText(PortType.LangName, Name) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

var
  I: integer;
begin
  I := 0;
  FOutFile := outFile;
  { Unit name can't start with number }
  if CharInSet(FOutFile[1], ['0'..'9']) then
    FOutFile := '_' + FOutFile;
  { Unit name can't conflict with porttype name or typename }
  while IsPortTypeName(FOutFile)
     or IsTypeName(FOutFile)
{$IFNDEF STANDALONE}
     or (CheckProject and FileExistInActiveProject(FOutFile+SourceExt))
{$ENDIF}
     do
  begin
    Inc(I);
    FOutFile := outFile + IntToStr(I);
  end;
end;

function TWSDLPasWriter.GetPartFlagList(const Part: IWSDLPart;
                                        SkipFlags: TPartFlag): string;
const
  PartStr: array[PartFlag] of string = (sIS_OPTN, sIS_UNBD, sIS_NLBL, sIS_UNQL,
                                        sIS_TEXT, sIS_ANY, sIS_REF, sIS_QUAL);
  Delimiter = ' or ';
var
  pf: PartFlag;
  Flags: TPartFlag;
  IsAttr: Boolean;
begin
  Result := '';

  if HasIndexDecl(Part, Flags, IsAttr) then
  begin
    if IsAttr then
      Result := sIS_ATTR;
    for pf := Low(PartFlag) to High(PartFlag) do
    begin
      if (pf in Flags) and (not (pf in SkipFlags)) then
      begin
        if Length(Result) > 0 then
          Result := Result + Delimiter;
        Result := Result + PartStr[pf];
      end;
    end;
  end;
end;

function TWSDLPasWriter.GetTypeInfo(const WSDLType: IWSDLType): DOMString;
begin
  if Verbose then
  begin
    Result := Format('  '+sPasComment, [inherited GetTypeInfo(WSDLType)])
  end
  else
    Result := '';
end;

procedure TWSDLPasWriter.WriteEnum(const WSDLType: IWSDLType);
const
  Indent: array[Boolean] of string = ('', '      ');
  SmlIndent: array[Boolean] of string = ('', '  ');
  NuLine: array[Boolean] of string = ('', sLineBreak);
var
  Len, Count: Integer;
  Wrap: Boolean;
begin
  Len := Length(WSDLType.EnumValues);
  Wrap := Len > 10;
  WriteTypeIntro(WSDLType);
  WriteFmt('  %s = (%s', [WSDLType.LangName, NuLine[Wrap]]);
  if Len > 0 then
  begin
    for Count:= 0 to (Len-1) do
    begin
      WriteFmt('%s%s%s%s', [Indent[Wrap],
                            WSDLType.EnumValues[Count].LangName,                       { Do not localize }
                            Commas[Count < (Len-1)],
                            NuLine[Wrap]]);
    end;
  end;
  WriteFmt('%s);' + sLineBreak+sLineBreak, [SmlIndent[Wrap]]);
end;

procedure TWSDLPasWriter.WriteAliasDef(const WSDLType: IWSDLType);

  function UseStrongAlias(const WSDLType: IWSDLType): Boolean;
  var
    ATypeInfo: PTypeInfo;
    BaseType: IWSDLType;
  begin
    if not (woHasLiteralUse in FWSDLImporter.Options) then
    begin
      Result := False;
      Exit;
    end;

    Result := True;
    BaseType := UnwindType(WSDLType.BaseType);
    ATypeInfo :=  RemTypeRegistry.XSDToTypeInfo(BaseType.Namespace, BaseType.Name);
    if (ATypeInfo <> nil) and (ATypeInfo.Kind = tkClass) then
    begin
      Result := False;
    end;
  end;

  function UseDerivation(const WSDLType: IWSDLType): Boolean;
  var
    ATypeInfo: PTypeInfo;
    BaseType: IWSDLType;
    AClass: TClass;
  begin
    Result := False;
    if not (woHasLiteralUse in FWSDLImporter.Options) then
    begin
      Exit;
    end;

    BaseType := UnwindType(WSDLType.BaseType);
    ATypeInfo :=  RemTypeRegistry.XSDToTypeInfo(BaseType.Namespace, BaseType.Name);
    Result := (ATypeInfo <> nil) and (ATypeInfo.Kind = tkClass);

                                                                                                
                                                                                                       
                           
    if Result then
    begin
      AClass := GetTypeData(ATypeInfo).ClassType;
      Result := (AClass.InheritsFrom(TXMLData) = False) and
                (AClass.InheritsFrom(TSOAPAttachment) = False);
    end;
  end;

const
  sTypeStr: array[Boolean] of string = ('', ' type ');
var
  HasAttribute: Boolean;
  I: Integer;
  WSDLPart: IWSDLPart;
  S: String;
  TypedAlias: Boolean;
  DerivedAlias: Boolean;
begin
  { The reader makes sure we don't define a type with itself - however, it compares in a case-sensitive fashion }
  { Since Pascal is case insensitive - we'll skip redefining types that are equivalent }
  if SameText(WSDLType.LangName, WSDLType.BaseType.LangName) then
    Exit;

  HasAttribute := Length(WSDLType.Members) > 0;
  if HasAttribute then
  begin
    WriteLn('');
    WriteLn(sWarningHeader);
    for I := 0 to Length(WSDLType.Members)-1 do
    begin
      WSDLPart := WSDLType.Members[I];
      WriteLn(sWarningAttribute, [WSDLPart.LangName,
                                  WSDLPart.DataType.LangName]);
    end;
  end;

  { A Typed alias - i.e use strong type or derivation ?? }
  TypedAlias := UseStrongAlias(WSDLType);
  DerivedAlias := (not TypedAlias) and (UseDerivation(WSDLType));
  if DerivedAlias then
    S := Format('  %-15s = class(%s) end;', [WSDLType.LangName, WSDLType.BaseType.LangName])
  else
    S := Format('  %-15s = %s%s;', [WSDLType.LangName, sTypeStr[TypedAlias], WSDLType.BaseType.LangName]);
  WriteLn('%-30s    %s', [S, GetTypeInfo(WSDLType)]);

  if HasAttribute then
    WriteLn('');
end;

procedure TWSDLPasWriter.WriteArray(const WSDLType: IWSDLType);
var
  ArrayOf: DOMString;
  I: Integer;
  WSDLPart: IWSDLPart;
  HasAttribute: Boolean;
  S: string;
begin
  ArrayOf := '';
  { Check whether the schema described this type with attributes }
  HasAttribute := Length(WSDLType.Members) > 0;
  if HasAttribute then
  begin
    WriteLn('');
    WriteLn(sWarningHeader);
    for I := 0 to Length(WSDLType.Members)-1 do
    begin
      WSDLPart := WSDLType.Members[I];
      WriteLn(sWarningAttribute, [WSDLPart.LangName,
                                  WSDLPart.DataType.LangName]);
    end;
  end;
  for I := 0 to (WSDLType.Dimensions-1) do
    ArrayOf := ArrayOf + ' array of';                { Do not localize }
  S := Format('  %-10s =%s %s;', [WSDLType.LangName, { Do not localize }
                                  ArrayOf,
                                  WSDLType.BaseType.LangName]);
  WriteLn('%-45s %s', [S, GetTypeInfo(WSDLType)]);
  if HasAttribute then
    WriteLn('');
end;

procedure TWSDLPasWriter.WriteComplexTypeClass(const WSDLType: IWSDLType; PassType: TPassWriterType);

  function GetIndexDecl(const Member: IWSDLPart): string;
  begin
    Result := GetPartFlagList(Member);
    if Length(Result) > 0 then
      Result := Format('Index (%s) ', [Result]);
  end;

  function GetStoredDecl(const Member: IWSDLPart): string;
  begin
    Result := '';
    if GenSpecifiedSupport(Member) then
    begin
      if HasIndexDecl(Member) then
        Result := Format(sSpecifiedStoredProcPasI, [Member.LangName])
      else
        Result := Format(sSpecifiedStoredProcPasF, [Member.LangName]);
    end;
  end;

const
  ReadPrefix: array[Boolean] of  string = ('F', 'Get');
  WritePrefix: array[Boolean] of  string = ('F', 'Set');
  GetterDecl: array[Boolean] of string = (sRemoteClassGetterPas, sRemoteClassGetterPasIdx);
  GetterImpl: array[Boolean] of string = (sRemoteClassGetterImplPas, sRemoteClassGetterImplPasIdx);
  SetterDecl: array[Boolean] of string = (sRemoteClassSetterPas, sRemoteClassSetterPasIdx);
  SetterImpl1:array[Boolean] of string = (sRemoteClassSetterImplPas, sRemoteClassSetterImplPasIdx);
  SetterImpl2:array[Boolean] of string = (sRemoteClassSetterImplPas2, sRemoteClassSetterImplPasIdx2);
var
  I: Integer;
  Members: IWSDLPartArray;
  ComplexNames, ComplexTypes: TDOMStrings;
  ArrayNames: TDOMStrings;
  ComplexMember, ComplexArray: Boolean;
  Reader, Writer, StoredDecl, IndexDecl: string;
  HasWriter: Boolean;
  BaseName: DOMString;
  HasCtr, HasDtr, SetGet, UseSetGets, GenSpcCode: Boolean;
  DefMember, Member: IWSDLPart;
  DefMemberType: IWSDLType;
  SerialOptStr: string;
  SerialOpts: TSerializationOptions;
  ArrayAsClass: Boolean;
  S: string;
  PropLen, TypeLen: Integer;
begin
  Members := nil; { To shut up compiler warning ?? }

  { Just forward ref?? }
  if (PassType >= [ptForwardDecl]) then
  begin
    S := Format('  %-20s = class;', [WSDLType.LangName]); { Do not localize }
    WriteLn('%-45s %s', [S, GetTypeInfo(WSDLType)]);
    Exit;
  end;

  DefMember := nil;
  ArrayAsClass := (xoInlineArrays in WSDLType.SerializationOpt) or
                  (IsPureCollection(WSDLType) and
                   (wfMapArraysToClasses in Global_WSDLGenFlags));
  ComplexNames := TDOMStrings.Create;
  ComplexTypes := TDOMStrings.Create;
  ArrayNames   := TDOMStrings.Create;
  try
    Members := WSDLType.Members;
    { Name of base class }
    if (WSDLType.BaseType <> nil) and
       (WSDLType.BaseType.DataKind = wtClass) then
      BaseName := WSDLType.BaseType.LangName
    else
      BaseName := GetBaseClassName(WSDLType);

    { Collect Member Information }
    PropLen := 0;
    TypeLen := 0;
    for Member in Members do
    begin
      if Member.PartKind = pDefaultArray then
      begin
        DefMember := Member;
        DefMemberType := DefMember.DataType;
        DefMemberType := UnwindType(DefMemberType);
        if (DefMemberType.DataKind = wtArray) then
        begin
          DefMemberType := DefMemberType.BaseType;
          DefMemberType := UnwindType(DefMemberType, True);
        end;
      end;

      { Collect complex members }
      ComplexMember := IsComplex(Member.DataType);
      if ComplexMember then
      begin
        ComplexNames.Add('F'+Member.LangName);
        ComplexTypes.Add(Member.DataType.LangName);
      end;

      { Collect complex arrays }
      ComplexArray := IsComplexArray(Member.DataType);
      if ComplexArray then
      begin
        ArrayNames.Add('F'+Member.LangName);
      end;

      { Length of symbols for formatting }
      { Experimental!! }
      if Length(Member.LangName) > PropLen then
        PropLen := Length(Member.LangName);
      if Length(Member.DataType.LangName) > TypeLen then
        TypeLen := Length(Member.DataType.LangName);
    end;


    HasCtr := (wfAutoInitMembers in Global_WSDLGenFlags) or WriteOutSerialOpts(WSDLType);
    HasDtr := (wfAutoDestroyMembers in Global_WSDLGenFlags) and
              ((wfServer in Global_WSDLGenFlags) = False) and
              ((ComplexNames.Count > 0) or (ArrayNames.Count > 0));
    UseSetGets:= wfUseSettersAndGetters in Global_WSDLGenFlags;
    GenSpcCode:= wfProcessOptionalNillable in Global_WSDLGenFlags;
    HasWriter := True;

    { We're declaring the class }
    if (PassType >= [ptTypeDecl]) then
    begin
      if Verbose then
        WriteComplexClassInfo(WSDLType)
      else
        WriteLn('');
        
      WriteFmt(sRemoteClassDeclPas, [WSDLType.LangName, BaseName]);

      { Emit fields }
      for Member in Members do
      begin
        WriteLn('    F%s: %s;', [Member.LangName, Member.DataType.LangName]);  { Do not localize }
        if GenSpecifiedSupport(Member) then
        begin
          WriteLn(sSpecifiedFieldPas, [Member.LangName]);
        end;
      end;

      { Emit setter/getter methods }
      if UseSetGets or GenSpcCode then
      begin
        for Member in Members do
        begin
          if UseSetGets or GenSpecifiedSupport(Member) then
          begin
            if UseSetGets then
              WriteFmt(GetterDecl[HasIndexDecl(Member)], [Member.LangName, Member.DataType.LangName]);
            if UseSetGets or GenSpecifiedSupport(Member) then
              WriteFmt(SetterDecl[HasIndexDecl(Member)], [Member.LangName, Member.DataType.LangName]);
            if GenIndexedSpecifiedSupport(Member) then
              WriteFmt(sSpecifiedStoredProcDeclPasIdx, [Member.LangName]);
          end;
        end;
      end;

      if ArrayAsClass then
      begin
        { Something went wrong ?? }
        Assert(DefMember <> nil, 'Array_As_Class must have a default member');
      end;

      { Switch to public visibility }
      if HasCtr or HasDtr or ArrayAsClass then
      begin
        WriteStr(sRemoteClassPublicPas);
      end;

                                                                           
      { Public & Constructor }
      if HasCtr then
      begin
        WriteFmt(sRemoteClassCtrPas, [WSDLType.LangName]);
      end;

      if HasDtr then
      begin
        WriteFmt(sRemoteClassDtrPas, [WSDLType.LangName]);
      end;

      if ArrayAsClass then
      begin
        WriteFmt(sDefaultArrayDeclPas, [DefMemberType.LangName]);
      end;

      { Published section }
      Inc(PropLen);
      Inc(TypeLen);
      WriteStr(sRemoteClassPublishPas);
      for Member in Members do
      begin
        SetGet := UseSetGets or GenSpecifiedSupport(Member);

        { Read }
        Reader := Format('read %s%s', [ReadPrefix[UseSetGets],      { Do not localize }
                                       Member.LangName]);
        { Write }
        Writer := '';
        if HasWriter then
          Writer := Format(' write %s%s', [WritePrefix[SetGet],  { Do not localize }
                                           Member.LangName]);
        { Index }
        IndexDecl := GetIndexDecl(Member);

        { Stored }
        StoredDecl := GetStoredDecl(Member);

        { Write out property }
        WriteLn('    property %-' + IntToStr(PropLen) + 's ' +
                             '%-' + IntToStr(TypeLen) + 's ' +
                             '%s%s%s%s;',       [Member.LangName+':',   { Do not localize }
                                                 Member.DataType.LangName,
                                                 IndexDecl,
                                                 Reader,
                                                 Writer,
                                                 StoredDecl]);
      end;
      WriteLn(sRemoteClassDeclEndPas);
      Exit;
    end;

    { We're implementing the type }
    if (PassType >= [ptTypeImpl]) then
    begin
      if HasCtr then
      begin
        WriteFmt(sRemoteClsCtrImplPas1, [WSDLType.LangName]);
        if WriteOutSerialOpts(WSDLType) then
        begin
          SerialOpts := WSDLType.SerializationOpt;
          SerialOptStr := SetToStr(TypeInfo(SerializationOptions),
                                   Integer(SerialOpts), False);
          WriteFmt(sRemoteClsCtrImplPas2, [SerialOptStr]);
        end;
        WriteLn (sRemoteClsCtrImplPas3);
      end;
      if HasDtr then
      begin
        if (ArrayNames.Count > 0) then
          WriteFmt(sRemoteClsDtrImplPas2, [WSDLType.LangName])
        else
          WriteFmt(sRemoteClsDtrImplPas1, [WSDLType.LangName]);
        for I := 0 to (ArrayNames.Count-1) do
          WriteFmt(sRemoteClsDtrImplPas3, [ArrayNames[I]]);
        for I := 0 to (ComplexNames.Count-1) do
          WriteFmt(sRemoteClsDtrImplPas4, [ComplexNames[I]]);
        WriteLn(sRemoteClsDtrImplPas5);
      end;
      if ArrayAsClass then
      begin
        Assert(DefMemberType <> nil, 'Array_As_Class type must have a DefMemberType');
        WriteFmt(sDefaultArrayImplPas, [WSDLType.LangName,
                                        DefMemberType.LangName,
                                        DefMember.LangName]);
      end;

      { Implement Setters Getters }
      if UseSetGets or GenSpcCode then
      begin
        for Member in Members do
        begin
          SetGet := UseSetGets or GenSpecifiedSupport(Member);
          if SetGet then
          begin
            { Getter }
            if UseSetGets then
            begin
              WriteFmt(GetterImpl[HasIndexDecl(Member)], [WSDLType.LangName,
                                                          Member.LangName,
                                                          Member.DataType.LangName]);
              WriteLn('');
            end;

            { Setter }
            if UseSetGets or GenSpecifiedSupport(Member) then
            begin
              if GenSpecifiedSupport(Member) then
              begin
                WriteFmt(SetterImpl2[HasIndexDecl(Member)],[WSDLType.LangName,
                                                      Member.LangName,
                                                      Member.DataType.LangName]);
              end
              else
              begin
                WriteFmt(SetterImpl1[HasIndexDecl(Member)],[WSDLType.LangName,
                                                      Member.LangName,
                                                      Member.DataType.LangName]);
              end;
              WriteLn('');
            end;

            { Stored Proc }
            if GenIndexedSpecifiedSupport(Member) then
            begin
              WriteFmt(sSpecifiedStoredProcImplPasIdx, [WSDLType.LangName, Member.LangName]);
              WriteLn('');
            end;
          end;
        end;
      end;
    end;
  finally
    ComplexNames.Free;
    ComplexTypes.Free;
    ArrayNames.Free;
  end;
end;

procedure TWSDLPasWriter.WriteInterfaceBegin(const WSDLPortType: IWSDLPortType;
                                             PassType: TPassWriterType);
begin
  if (ptTypeDecl in PassType) then
    WriteFmt(sInterfaceDeclPas, [WSDLPortType.LangName,
                                 WSDLPortType.BaseInterfaceName,
                                 GUIDToString(WSDLPortType.GUID) ])
  else if (ptTypeImpl in PassType) then
    WriteFmt(sImplDeclPas, [WSDLPortType.LangName])
  else if (ptTypeFactoryImpl in PassType) then
  begin
    case WriteFactory(WSDLPortType) of
      ftWSDLURL:
        WriteLn(sFactoryImplPas1, [WSDLPortType.LangName,
                                   Self.FileName,
                                   WSDLPortType.URL,
                                   WSDLPortType.Service,
                                   WSDLPortType.Port]);
      ftURL:
        WriteLn(sFactoryImplPas2, [WSDLPortType.LangName,
                                   WSDLPortType.URL]);
    end;
  end;
end;

procedure TWSDLPasWriter.WriteMethod(const WSDLOperation: IWSDLOperation; const Parent: IWSDLPortType; PassType: TPassWriterType);
const
  WRAP_PARAM_INDEX = 5;
var
  RetIndex, I, J, Params: Integer;
  OverLoadStr: DOMString;
  RetType: DOMString;
  FuncProc: DOMString;
  ImplClass: DOMString;
  WSDLPart: IWSDLPart;
  CallConv: DOMString;
  Temp: string;
begin
  { Nothing to do... when writing out factory method }
  if (ptTypeFactoryDecl in PassType) or
     (ptTypeFactoryImpl in PassType) then
    Exit;

  { Map return type to a string }
  RetIndex := WSDLOperation.ReturnIndex;
  if (RetIndex <> -1) then
  begin
    RetType := ': ' + WSDLOperation.Parts[RetIndex].DataType.LangName;        { Do not localize }
    FuncProc:= 'function';                                                    { Do not localize }
  end
  else
  begin
    RetType := '';
    FuncProc:= 'procedure';                                                   { Do not localize }
  end;

  { Implementation ?? }
  if (ptMethImpl in PassType) then
  begin
    ImplClass := Parent.LangName + sImplSuffix;
    Temp := Format('%s %s.%s', [FuncProc, ImplClass, WSDLOperation.LangName]);
  end
  else
  begin
    Temp := Format('    %-9s %s', [FuncProc, WSDLOperation.LangName]);
    // Here we can emit information about the method
    if Verbose and HasInfoAboutMethod(WSDLOperation) then
      WriteStr(GetMethodInfo(WSDLOperation));
  end;
  WriteStr(Temp);

  { How many parameters ?? }
  Params := Length(WSDLOperation.Parts);
  if (RetIndex <> -1) then
    Dec(Params);

  if (Params > 0) then
  begin
    WriteStr('(');
    for I := 0 to Length(WSDLOperation.Parts)-1 do
    begin
      WSDLPart := WSDLOperation.Parts[I];
      if (I <> RetIndex) then
      begin
        Dec(Params);
        WriteFmt('%s%s: %s%s', [PreParamMod[WSDLPart.PartKind],
                                WSDLPart.LangName,
                                WSDLPart.DataType.LangName,
                                SemiStr[Params > 0]]);
        { The IDE does not handle long lines gracefully!! }
        if (I > 0) and ((I mod WRAP_PARAM_INDEX) = 0) then
        begin
          if I = WRAP_PARAM_INDEX then
          begin
            SetLength(Temp, Length(Temp)+1);
            for J := 1 to Length(Temp) do
              Temp[J] := ' ';
          end;
          WriteStr(#13#10+Temp);
        end;
      end;
    end;
    WriteStr(')');
  end;

  { overloaded function? }
  if WSDLOperation.Overloaded then
    OverLoadStr := ' overload; '
  else
    OverLoadStr := '';

  { Calling convention }
  if (ptMethImpl in PassType) then
    CallConv := ''
  else
    CallConv := ' stdcall;';                                                  { Do not localize }

  { Return & calling convention }
  WriteLn('%s;%s%s', [RetType, OverLoadStr, CallConv]);

  { Implementation }
  if (ptMethImpl in PassType) then
  begin
    WriteFmt(sDummyImplPas, [WSDLOperation.LangName]);
  end
end;


procedure TWSDLPasWriter.WriteInterfaceEnd(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType);
begin
  if (ptTypeDecl in PassType) then
    WriteStr(sInterfaceDeclEndPas)
  else if (ptTypeImpl in PassType) then
    WriteStr(sImplDeclEndPas)
  else if (ptTypeFactoryDecl in PassType) then
  begin
    case WriteFactory(WSDLPortType) of
      ftWSDLURL:
        WriteFmt(sIntfFactoryDeclPas1, [WSDLPortType.LangName]);
      ftURL:
        WriteFmt(sIntfFactoryDeclPas2, [WSDLPortType.LangName]);
    end;
  end;
end;

function TWSDLPasWriter.Escape(const S: DOMString): DOMString;
var
  I: Integer;
  UniStr: string;
begin
  Result := S;
  for I := Length(Result) downto 1 do
  begin
    if Result[I] = '''' then
      Insert('''', Result, I);
    if Result[I] > WideChar(255) then
    begin
      UniStr := Format('''#%s''', [IntToStr(Word(Result[I]))]);
      Delete(Result, I, 1);
      Insert(UniStr, Result, I);
    end;
  end;
end;

procedure TWSDLPasWriter.WriteEnumPrologue;
begin
  if (wfUseScopedEnumeration in Global_WSDLGenFlags) then
    WriteLn('  {$SCOPEDENUMS ON}');
end;

procedure TWSDLPasWriter.WriteEnumEpilogue;
begin
  if (wfUseScopedEnumeration in Global_WSDLGenFlags) then
  begin
    WriteLn('  {$SCOPEDENUMS OFF}');
    WriteLn('');
  end;
end;

{ Registration Calls }
procedure TWSDLPasWriter.WriteRegCalls;

var
  ExtName: DOMString;

  procedure WriteTypeRegistration(const WSDLType: IWSDLType);
  var
    I: Integer;
    EnumMember: IWSDLItem;
    WSDLPart: IWSDLPart;
    SerialOpts: TSerializationOptions;
    FormatString: DOMString;
    ARegInfo: TRegInfoAttribute;
  begin
    if WSDLType.LangName <> WSDLType.Name then
      ExtName := Escape(WSDLType.Name)
    else
      ExtName := '';

    if WSDLType.DataKind = wtClass then
    begin
      if WSDLType.Name <> WSDLType.LangName then
        FormatString := SRegClassPas2
      else
        FormatString := SRegClassPas1;
    end
    else
    begin
      if WSDLType.Name <> WSDLType.LangName then
        FormatString := SRegTypePas2
      else
        FormatString := SRegTypePas1;
    end;

    WriteFmt(FormatString, [WSDLType.LangName, WSDLType.Namespace, WSDLType.LangName, ExtName]);

    { Renamed members }
    if (WSDLType.DataKind = wtClass) then
    begin
      for I := 0 to Length(WSDLType.Members)-1 do
      begin
        WSDLPart := WSDLType.Members[I];
        ARegInfo.Reset;
{$IFDEF _DEBUG}  // For debugging Assertion      
        if not ((WSDLPart.RegInfo = '') or (WSDLPart.DataType.RegInfo = '')) then
        begin
          System.WriteLn(Format('%s=%s,   %s=%s', [WSDLPart.LangName, WSDLPart.RegInfo,
                                     WSDLPart.DataType.LangName,
                                     WSDLPart.DataType.RegInfo]));                                     
        end;
{$ENDIF}        
        //Assert((WSDLPart.RegInfo = '') or (WSDLPart.DataType.RegInfo = ''));
        if WSDLPart.DataType.RegInfo <> '' then
          ARegInfo.Load(WSDLPart.DataType.RegInfo);
        if WSDLPart.RegInfo <> '' then
          ARegInfo.Load(WSDLPart.RegInfo);

        if WSDLPart.Name <> WSDLPart.LangName then
          ARegInfo.SetAttr(InfoAttribute.iaExternalName, WSDLPart.Name);

        if ARegInfo.HasAttr then
          WriteFmt(sRegMemberRenamedPas, [WSDLType.LangName,
                                          WSDLPart.LangName,
                                          ARegInfo.AsString(False)]);
      end;
    end;

    if (WSDLType.DataKind = wtEnumeration) then
    begin
      for I := 0 to Length(WSDLType.EnumValues)-1 do
      begin
        EnumMember := WSDLType.EnumValues[I];
        if EnumMember.Name <> EnumMember.LangName then
          WriteFmt(sRegMemberRenamedPas, [WSDLType.LangName,
                                          EnumMember.LangName,
                                          Escape(EnumMember.Name)]);
      end;
    end;

    { Serialization Options }
    if WSDLType.DataKind = wtClass then
    begin
      if (WSDLType.SerializationOpt <> []) then
      begin
        SerialOpts := WSDLType.SerializationOpt;
        WriteFmt(sRegClassSerialOptsPas, [WSDLType.LangName, SetToStr(TypeInfo(SerializationOptions), Integer(SerialOpts), True)]);
      end;
    end;

    if WSDLType.DataKind = wtArray then
    begin
      if (WSDLType.SerializationOpt <> []) then
      begin
        SerialOpts := WSDLType.SerializationOpt;
        WriteFmt(sRegInfoSerialOptsPas, [WSDLType.LangName, SetToStr(TypeInfo(SerializationOptions), Integer(SerialOpts), True)]);
      end;
    end;
  end;

  function GetSafeLiteral(const S: string; Indent: Integer; Delim: WideChar): string;
  var
    StrArray: TStringDynArray;
    I: Integer;
    IndentStr: string;
  begin
    if Length(S) < 255 then
      Result := '''' + S + ''''
    else
    begin
      { Create indent string }
      SetLength(IndentStr, Indent);
      for I := 1 to Length(IndentStr) do
        IndentStr[I] := ' ';
      { Break string up }
      SetLength(StrArray, 0);
      StrArray := StringToStringArray(S, Delim);
      for I := 0 to Length(StrArray)-1 do
      begin
        if I <> 0 then
          Result := Result + '+';
        Result := Result + '''' + Delim + StrArray[I] + '''';
        Result := Result + sLineBreak + IndentStr;
      end;
    end;
  end;

  {
    With the .pas file generated by the importer from eBay's current WSDL (v475),
    DCC32 is unhappy at the amount of constant strings in the initialization section:

      Borland Delphi for Win32 compiler version 19.0
      Copyright (c) 1983,2006 Borland Software Corporation
      Confidential pre-release version built Sep 10 2006 02:33:00
      eBaySvc.pas(22093) Error: E2283 Too many local constants.  Use shorter procedures

    So we have to either break up the initialization section as I'm told that there's
    a limit of 64K of constant string per procedure (initialization counts as a procedure).
  }
{$DEFINE WORKAROUND_E2283}
const
  MAX_TYPES_IN_INITIALIZATION: Integer = 400;
  NUM_TYPES_PER_REGISTERPROC: Integer = 100;
  REGISTER_TYPES_ALL: Integer = -1;


  //////////////////////////////////////////////////////////////
  // Emits calls to register types of WebService
  //////////////////////////////////////////////////////////////
  function RegisterTypes(WSDLTypes: IWSDLTypeArray; var Start: Integer; const ProcIndex, Max: Integer): Boolean;
  var
    Len, Count: Integer;
    WSDLType: IWSDLType;
    EmitAll: Boolean;
  begin
    Count := 0;
    EmitAll := Max = REGISTER_TYPES_ALL;
    if not EmitAll then
    begin
      WriteFmt(sRegProcStart, [ProcIndex]);
    end;

    Len := Length(WSDLTypes);
    While (Start < Len) and (EmitAll or (Count < Max)) do
    begin
      WSDLType := WSDLTypes[Start];
      Inc(Start);

      { Skip types we don't declare }
      if SkipType(WSDLType, True) then
        continue;

      WriteTypeRegistration(WSDLType);
      Inc(Count);
    end;

    if not EmitAll then
    begin
      WriteStr(sRegProcEnd);
    end;

    Result := (Count > 0);
  end;

  function RegReturnParamNames(const WSDLPortType: IWSDLPortType): Boolean;
  var
    Operation: IWSDLOperation;
    Part: IWSDLPart;
    OutCount: Integer;
  begin
    Result := False;
    for Operation in WSDLPortType.Operations do
    begin
      if Operation.ReturnIndex <> -1 then
      begin
        OutCount := 0;
        for Part in Operation.Parts do
        begin
          if (Part.PartKind = pOut) or
             (Part.PartKind = pInOut) or
             (Part.PartKind = pReturn) then
          begin
            Inc(OutCount);
            if (OutCount > 1) then
            begin
              Result := True;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;

  function GetReturnParamNames(const WSDLPortType: IWSDLPortType; Indent: Integer): DOMString;
  const
    Semi: array[boolean] of  string = ('', ';');
    WRAP_INDEX = 3;
  var
    Operation: IWSDLOperation;
    Count, I: Integer;
    RetName: DOMString;
  begin
    Count := 0;
    Result := '';
    for Operation in WSDLPortType.Operations do
    begin
      if ((Count mod WRAP_INDEX) = 0) then
      begin
        if (Result <> '') then
        begin
          Result := Result + ''' +' + sLineBreak;
          for I := 0 to Indent-1 do
            Result := Result + ' ';
        end;
        Result := Result + '''';
      end;

      RetName := '';
      if Operation.ReturnIndex <> -1 then
        RetName := Operation.Parts[Operation.ReturnIndex].Name;
      if RetName <> '' then
      begin
        Result := Format('%s%s%s', [Result,
                                    Semi[Count>0],
                                    RetName]);
      end
      else
        Result := Result + ';';
      Inc(Count);
    end;
    if Result <> '' then
      Result := Result + '''';
  end;

var
  WSDLPortTypeArray: IWSDLPortTypeArray;
  I, J, K, TypeStartIndex, RegProcCount: Integer;
  WSDLPortType: IWSDLPortTYpe;
  WSDLOperations: IWSDLOperationArray;
  WSDLOperation: IWSDLOperation;
  WSDLParts: IWSDLPartArray;
  WSDLPart, ReturnPart: IWSDLPart;
  MethodHeading: Boolean;
  WSDLTypes: IWSDLTypeArray;
  HeaderTracker, FaultTracker: TRegTracker;
  RegTypesInProcs, UseTrackers: Boolean;
  HeaderList: TDOMStrings;
  HeaderSig: DOMString;
  DelimChar: WideChar;
  PartFlagList, ParamNamespace, InternalName, ExternalName, ReturnName: string;
  InputNamespace, OutputNamespace: string;
  ARegInfo: TRegInfoAttribute;
  RegInfoStr: string;
begin
  WSDLParts := nil;
  WSDLOperations := nil;
  HeaderList := nil;
  HeaderTracker := nil;
  FaultTracker := nil;
  TypeStartIndex := 0;
  RegProcCount := 0;

  { Check if types go first because there are too many for initialization section }
  WSDLTypes := FWSDLImporter.GetTypes;
{$IFDEF WORKAROUND_E2283}
  RegTypesInProcs := (Length(WSDLTypes) > MAX_TYPES_IN_INITIALIZATION);
{$ELSE}
  RegTypesInProcs := False;
{$ENDIF}

  { If yes break type registration into multiple registration procedure. This is necessary
    because there's a 64K limit per procedure for constants currently. With eBay the compiler
    cannot handle it all in the initialization section }

  if RegTypesInProcs then
  begin
    while RegisterTypes(WSDLTypes, TypeStartIndex, RegProcCount, NUM_TYPES_PER_REGISTERPROC) do
      Inc(RegProcCount);
  end;

  { Write initialization }
  WriteStr(sUnitInit);

  { Register PortTypes }
  WSDLPortTypeArray := FWSDLImporter.GetPortTypes;
  for I := 0 to Length(WSDLPortTypeArray)-1 do
  begin
    WSDLPortType := WSDLPortTypeArray[I];

    if Verbose then
      WriteLn(sPasCommentIdent, [WSDLPortType.Name]);

    if (WSDLPortType.Name <> WSDLPortType.LangName) then
      ExtName := Escape(WSDLPortType.Name)
    else
      ExtName := '';

    { Pick the optimal output }
    if WSDLPortType.LangName <> WSDLPortType.Name then
      WriteFmt(sRegInterfacePas2, [WSDLPortType.LangName,
                                   WSDLPortType.Namespace,
                                   FWSDLImporter.Encoding,
                                   ExtName])
    else
      WriteFmt(sRegInterfacePas1, [WSDLPortType.LangName,
                                   WSDLPortType.Namespace,
                                   FWSDLImporter.Encoding]);

    { Register PortTypes - for server implementation }
    if (wfServer in Global_WSDLGenFlags) then
    begin
      if Verbose then
        WriteLn(sPasCommentIdent, [Format(sServerImpl, [WSDLPortType.LangName])]);
      WriteFmt(sRegInvokableClass, [WSDLPortType.LangName + sImplSuffix]);
    end;

    { SOAPAction[s] }
    if WSDLPortType.HasDefaultSOAPAction then
    begin
      { If we're in server mode, avoid tricky SOAPActions that will make
        dispatching fail }
      if (not (wfServer in Global_WSDLGenFlags)) or
         (Pos(DOMString(SOperationNameSpecifier), WSDLPortType.SOAPAction)=0) then
        WriteFmt(sRegSOAPActionPas, [WSDLPortType.LangName, WSDLPortType.SOAPAction]);
    end
    else if WSDLPortType.HasAllSOAPActions then
    begin
      if not (wfServer in Global_WSDLGenFlags) and (WSDLPortType.OperationCount > 0) then
      begin
      { Here we write out the SOAP action for each operation }
        If WSDLPortType.SOAPAction <> '' then
          DelimChar := WSDLPortType.SOAPAction[1]
        else
          DelimChar := '|';
        WriteFmt(sRegAllSOAPActionPas, [WSDLPortType.LangName,
                                        GetSafeLiteral(WSDLPortType.SOAPAction, 48+Length(WSDLPortType.LangName),
                                                       DelimChar)]);
      end;
    end;

    { Return Return Param Names }
{$IFDEF _DEBUG}
    if RegReturnParamNames(WSDLPortType) then
    begin
      WriteFmt(sRegParamNamesPasBeg, [WSDLPortType.LangName]);
      {NOTE: -2 is for the %s in the format specifier}
      WriteStr(GetReturnParamNames(WSDLPortType, Length(sRegParamNamesPasBeg)+Length(WSDLPortType.LangName)-2));
      WriteLn(');');
    end;
{$ENDIF}

    { Flag the registry if this interface is 'encoded' vs. 'literal'
      However, only do this if we're generating client code - for servers
      we're always rpc|encoded }
    if not (wfServer in Global_WSDLGenFlags) then
    begin
      if (ioDocument in WSDLPortType.InvokeOptions) then
        WriteFmt(sRegInvokeOptDocPas, [WSDLPortType.LangName]);
      if (ioLiteral in WSDLPortType.InvokeOptions) then
        WriteFmt(sRegInvokeOptLitPas, [WSDLPortType.LangName]);
      if (ioSOAP12 in WSDLPortType.InvokeOptions) then
        WriteFmt(sRegInvokeOptSOAP12Pas, [WSDLPortType.LangName]);
    end;

{$IFDEF REGISTER_UDDI_INFO}
    { if we have UDDI information flag it }
    if (ioHasUDDIInfo in WSDLPortType.InvokeOptions) then
      WriteFmt(sRegUDDIInfoPas, [WSDLPortType.LangName,
                                 FWSDLImporter.UDDIImportInfo.UDDIOperator,
                                 FWSDLImporter.UDDIImportInfo.BindingKey]);
{$ENDIF}

    { Use trackers for headers/faults }
    UseTrackers := wfServer in Global_WSDLGenFlags;

    if (UseTrackers) then
    begin
      HeaderTracker := TRegTracker.Create(WSDLPortType.LangName,
                       SRegHeaderPas1, SRegHeaderMethPas, rtHeader);
      FaultTracker := TRegTracker.Create(WSDLPortType.LangName,
                       SRegFaultPas, SRegFaultMethPas, rtFault);
    end
    else
    begin
      HeaderList := TDOMStrings.Create;
    end;

    { Check operations }
    try
      WSDLOperations := WSDLPortType.Operations;
      for J := 0 to Length(WSDLOperations)-1 do
      begin
        WSDLOperation := WSDLOperations[J];
        MethodHeading := False;
        ARegInfo.Reset;

        { Register information lost when we unwrapped}
        ReturnPart := nil;
        InputNamespace := '';
        OutputNamespace := '';
        ReturnName := '';
        PartFlagList := '';
        RegInfoStr := '';

        if (WSDLPortType.InvokeOptions * [ioLiteral, ioDocument]) = [ioDocument] then
        begin
          if (WSDLOperation.InputWrapper <> nil) then
            InputNamespace := WSDLOperation.InputWrapper.DataType.Namespace;
          if (WSDLOperation.OutputWrapper <> nil) then
            OutputNamespace := WSDLOperation.OutputWrapper.DataType.Namespace;

          if OutputNamespace = WSDLPortType.Namespace then
            OutputNamespace := '';

          WSDLParts := WSDLOperation.Parts;
          for K := 0 to Length(WSDLParts)-1 do
          begin
            WSDLPart := WSDLParts[K];
            if WSDLPart.PartKind = pReturn then
            begin
              ReturnPart := WSDLPart;
              PartFlagList := GetPartFlagList(ReturnPart);
              ReturnName := Escape(ReturnPart.Name);
              Break;
            end;
          end;
        end;

        if (ReturnName <> '') or
           ((InputNamespace <> '') and (InputNamespace <> WSDLPortType.Namespace)) or
           ((OutputNamespace <> '') and (OutputNamespace <> WSDLPortType.Namespace)) or
           (PartFlagList <> '') or
           (WSDLOperation.Name <> WSDLOperation.LangName) then
        begin
          InternalName := Escape(WSDLOperation.LangName);
          ExternalName := Escape(WSDLOperation.Name);
          if ExternalName = InternalName then
            ExternalName := '';

          if ReturnName <> '' then
            ARegInfo.SetAttr(InfoAttribute.iaMethReturnName, ReturnName);

          if ((InputNamespace <> '') and (InputNamespace <> WSDLPortType.Namespace)) then
            ARegInfo.SetAttr(InfoAttribute.iaMethRequestNamespace, InputNamespace);

          if ((OutputNamespace <> '') and (OutputNamespace <> WSDLPortType.Namespace)) then
            ARegInfo.SetAttr(InfoAttribute.iaMethResponseNamespace, OutputNamespace);

          if ARegInfo.HasAttr then
            RegInfoStr := ARegInfo.AsString(False);

          if (ExternalName <> '') or
             (RegInfoStr <> '') or
             (PartFlagList <> '') then
          begin
            if Verbose then
            begin
              WriteLn(sPasCommentIdent, [Format('%s.%s', [WSDLPortType.Name, InternalName])]);
              MethodHeading := True;
            end;
            if PartFlagList <> '' then
              WriteFmt(sRegMethodInfoPas, [WSDLPortType.LangName,
                                           InternalName,
                                           ExternalName,
                                           RegInfoStr,
                                           PartFlagList])
            else if RegInfoStr <> '' then
              WriteFmt(sRegMethodInfoPasNoOpts, [WSDLPortType.LangName,
                                                 InternalName,
                                                 ExternalName,
                                                 RegInfoStr])
            else
              WriteFmt(sRegMethodInfoPasNoInfo, [WSDLPortType.LangName,
                                                 InternalName,
                                                 ExternalName]);
          end;
        end;

        { Are trackers keeping track of headers }
        if (UseTrackers) then
        begin
          AddHeadersForOperation(WSDLOperation, HeaderTracker);
          AddFaultsForOperation(WSDLOperation, FaultTracker);
        end
        else
        begin
          for WSDLPart in WSDLOperation.Headers do
          begin
            HeaderSig := WSDLPart.DataType.LangName + ':' +
                         WSDLPart.Name + ':' +
                         WSDLPart.DataType.NameSpace;
            if HeaderList.IndexOf(HeaderSig) = -1 then
            begin
              WriteFmt(sRegHeaderPas2, [WSDLPortType.LangName,
                                        WSDLPart.DataType.LangName,
                                        Escape(WSDLPart.Name),
                                        WSDLPart.DataType.Namespace]);
              HeaderList.Add(HeaderSig);
            end;
          end;
        end;

        { Check parameter renames }
        WSDLParts := WSDLOperation.Parts;
        for K := 0 to Length(WSDLParts)-1 do
        begin
          WSDLPart := WSDLParts[K];

          PartFlagList := '';
          ParamNamespace := '';
          RegInfoStr := '';
          ARegInfo.Reset;

          if (WSDLPortType.InvokeOptions * [ioLiteral, ioDocument]) = [ioDocument] then
          begin
            // Don't bother with optional since parameters
            // are not really optional in Pascal/C++
            PartFlagList := GetPartFlagList(WSDLPart, [pfOptional]);
            ParamNamespace := WSDLPart.DataType.Namespace;
            if ((InputNamespace <> '') and (ParamNamespace = InputNamespace)) or
               ((InputNamespace = '') and (ParamNamespace = WSDLPortType.Namespace)) then
              ParamNamespace := '';
          end
          else
          begin
            // Rpc|lit
            if (WSDLPortType.InvokeOptions * [ioLiteral, ioDocument]) = [ioLiteral] then            // Rpc|lit
               ParamNamespace := WSDLPart.DataType.Namespace;
          end;

          if ParamNamespace = XMLSchemaNamespace then
            ParamNamespace := '';

          if ParamNamespace <> '' then
            ARegInfo.SetAttr(InfoAttribute.iaNamespace, ParamNamespace);
          if WSDLPart.DataType.RegInfo <> '' then
            ARegInfo.Load(WSDLPart.DataType.RegInfo);
          if ARegInfo.HasAttr then
            RegInfoStr := ARegInfo.AsString(False);

          InternalName := Escape(WSDLPart.LangName);
          ExternalName := Escape(WSDLPart.Name);
          if ExternalName = InternalName then
            ExternalName := '';

          if (ExternalName <> '') or
             (RegInfoStr <> '') or
             (PartFlagList <> '' ) then
          begin
            if Verbose and (MethodHeading = False) then
            begin
              WriteLn(sPasCommentIdent, [Format('%s.%s', [WSDLPortType.Name, WSDLOperation.LangName])]);
              MethodHeading := True;
            end;
            if PartFlagList <> '' then
              WriteFmt(sRegParamInfoPas, [WSDLPortType.LangName,
                                          WSDLOperation.LangName,
                                          InternalName,
                                          ExternalName,
                                          RegInfoStr,
                                          PartFlagList])
            else if RegInfoStr <> '' then
              WriteFmt(sRegParamInfoPasNoOpts, [WSDLPortType.LangName,
                                                WSDLOperation.LangName,
                                                InternalName,
                                                ExternalName,
                                                RegInfoStr])
            else
              WriteFmt(sRegParamInfoPasNoInfo, [WSDLPortType.LangName,
                                                WSDLOperation.LangName,
                                                InternalName,
                                                ExternalName]);
          end;
        end;
      end;

      if (UseTrackers) then
      begin
        HeaderTracker.WriteRegistration(WSDLPortType.LangName, WSDLOperations, Self);
        FaultTracker.WriteRegistration(WSDLPortType.LangName, WSDLOperations, Self);
      end;
    finally
      if (UseTrackers) then
      begin
        HeaderTracker.Free;
        FaultTracker.Free;
      end
      else
      begin
        HeaderList.Free;
      end;
    end;
  end;

  { Handle Types, if they weren't handled above }
  if not RegTypesInProcs then
    RegisterTypes(WSDLTypes, TypeStartIndex, 0, REGISTER_TYPES_ALL)
  else
  begin
    { Otherwise invoke the register procs from here }
    I := 0;
    while (RegProcCount > 0) do
    begin
      WriteFmt(sRegProcCall, [I]);
      Inc(I);
      Dec(RegProcCount);
    end;
  end;
end;

function CamelToUpper(const S: string): string;
var
  sb: TStringBuilder;
  I: Integer;
  LastUpper, NowUpper: Boolean;
begin
  sb := TStringBuilder.Create;
  try
    NowUpper := False;
    for I := 1 to Length(S) do
    begin
      LastUpper := NowUpper;
      NowUpper := S[I].IsUpper;
      if (I > 1) and NowUpper and (not LastUpper) then
        sb.Append('_');   { Do not localize }
      sb.Append(S[I].ToUpper);
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

function TWSDLPasWriter.WriteSettingsFile: Boolean;
const
  BoolStr: array[Boolean] of string = ('_OFF', '_ON');  { Do not localize }
var
  Flag: WSDLGenFlags;
  FlagStr: string;
  SortedWSDLGenFlags: TArray<WSDLGenFlags>;
begin
  WriteFmt(sLineComment, [Format('WSDLImp settings generated %s', [DateTimeToStr(Now)])]); { Do not localize }
  WriteStr(sLineBreak);
  SortedWSDLGenFlags := GetSortedWSDLGenFlags;
  for Flag in SortedWSDLGenFlags do
  begin
    FlagStr := OptStrings[Flag];
    if (Length(FlagStr) > 0) and (Length(OptCommandLineFlags[Flag]) > 0) then
    begin
      FlagStr := CamelToUpper(FlagStr);
      WriteFmt('{$DEFINE %s%s}', [FlagStr, BoolStr[Flag in Global_WSDLGenFlags]]); { Do not localize }
      WriteStr(sLineBreak);
    end;
  end;
  WriteStr(sLineBreak);
  WriteFmt('{$DEFINE WSDLIMP_VER_%d_%d}', [WSDLImpMajVer, WSDLImpMinVer]); { Do not localize }
  WriteStr(sLineBreak);
  Result := True;
end;

constructor TWSDLPasWriter.CreateFilename(const WSDLImporter: IWSDLImporter;
  OutFileName: string);
begin
    inherited CreateFilename(WSDLImporter, OutFileName);
end;

end.
