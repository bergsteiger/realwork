{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WSDLCppWriter;

interface

uses
  TypInfo, xmldom, WSDLImpWriter, WSDLItems, WSDLModelIntf;

type

  TWSDLCppWriter = class(TWSDLWriter)
  private
    FNamespace: DOMString;
    function GetPartFlagList(const Part: IWSDLPart; SkipFlags: TPartFlag = []): string;

  protected
    function  IsDynArrayType(ArrayType: string): Boolean;

    { Overriden for C++ Codegeneration }
    function  IsReservedWord(const Name: DOMString; var NewName: DOMString): Boolean; override;
    function  TypeNameFromTypeInfo(TypeInfo: pTypeInfo): DOMString; override;
    procedure WriteInterfaceBegin(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); override;
    procedure WriteInterfaceEnd(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType); override;
    procedure WriteMethod(const WSDLOperation: IWSDLOperation; const Parent: IWSDLPortType; PassType: TPassWriterType); override;
    procedure WriteEnum(const WSDLType: IWSDLType); override;
    procedure WriteAliasDef(const WSDLType: IWSDLType); override;
    procedure WriteArray(const WSDLType: IWSDLType); override;
    procedure WriteComplexTypeClass(const WSDLType: IWSDLType; PassType: TPassWriterType); override;
    function  GetTypeInfo(const WSDLType: IWSDLType): DOMString; override;
    function  RemapMembersOfTypeName: boolean; override;

    procedure WriteTypeNamespace(const TypeNamespace: DOMString; Using: Boolean = False);
    function  Escape(const W: DOMString): DOMString; override;
  public
    constructor Create(const WSDLImporter: IWSDLImporter); override;
    constructor CreateFilename(const WSDLImporter: IWSDLImporter; OutFileName: string); override;

    destructor  Destroy; override;


    procedure WriteIntfHeader; override;
    procedure WriteIntfFooter; override;
    function  WriteSettingsFile: Boolean; override;
    procedure SetOutFile(const outFile: string; CheckProject: Boolean); override;

    function  IntfExt: DOMString; override;
    function  HasSource: Boolean; override;
    function  SourceExt: DOMString; override;
    procedure WriteSource; override;
    procedure WriteRegCalls; override;
    procedure WriteSourceHeader;
    procedure WriteSourceFooter;

    property Namespace: DOMString read FNamespace write FNamespace;
  end;

  TWSDLCppWriterClass = class of TWSDLCppWriter;

implementation

uses
  IntfInfo, SysUtils, WSDLImpConst, XMLSchemaHelper,
{$IFNDEF STANDALONE}
  GenWizard,
{$ENDIF}
  SOAPConst, WSDLIntf, InvokeRegistry;

const
                                            { Unknown, in, out, inOut, ret }
   PreParamMod: array[PartType] of string = ('', 'const ', '',  '',   '', '', '');  { Do not localize }
   PosParamMod: array[PartType] of string = ('', '',       '&', '&',  '', '', '');  { Do not localize }
   RefOp:       array[Boolean] of string  = ('', '*');                              { Do not localize }
   PadStr:      array[Boolean] of string  = ('', '  ');                             { Do not localize }
   VirtualStr:  array[Boolean] of string  = ('', 'virtual ');                       { Do not localize }
   PureVirtStr: array[Boolean] of string  = ('', ' = 0');                           { Do not localize }

   CppReservedWords: array[0..105] of string =(
                        '__asm',
                        '_asm',
                        'asm',
                        'auto',
                        '__automated',
                        'break',
                        'case',
                        'catch',
                        '__cdecl',
                        '_cdecl',
                        'cdecl',
                        'char',
                        'class',
                        '__classid',
                        '__closure',
                        'const',
                        'const_cast',
                        'continue',
                        '__cs',
                        '_cs',
                        '__declspec',
                        'default',
                        'delete',
                        'dispid',
                        '__dispid',
                        'do',
                        'double',
                        '__ds',
                        '_ds',
                        'dynamic_cast',
                        'else',
                        'enum',
                        '__es',
                        '_es',
                        '__except',
                        'far',
                        '__far',
                        '_far',
                        '__fastcall',
                        '_fastcall',
                        '__finally',
                        'float',
                        'for',
                        'friend',
                        'goto',
                        'huge',
                        '__huge',
                        '_huge',
                        'if',
                        '__import',
                        '_import',
                        'inline',
                        'int',
                        '__int8',
                        '__int16',
                        '__int32',
                        '__int64',
                        'interrupt',
                        '__interrupt',
                        '_interrupt',
                        '__loadds',
                        '_loadds',
                        'long',
                        'near',
                        '_near',
                        '__near',
                        'new',
                        'operator',
                        'pascal',
                        'private',
                        '__property',
                        'protected',
                        'public',
                        '__published',
                        'register',
                        'reinterpret_cast',
                        'return',
                        '__rtti',
                        '__saveregs',
                        '_saveregs',
                        '__seg',
                        '_seg',
                        'short',
                        'signed',
                        'sizeof',
                        '__ss',
                        '_ss',
                        'static',
                        'static_cast',
                        '__stdcall',
                        '_stdcall',
                        'struct',
                        'switch',
                        'template',
                        'this',
                        '__thread',
                        'throw',
                        '__try',
                        'try',
                        'typeid',
                        'unsigned',
                        'virtual',
                        'void',
                        'volatile',
                        'wchar_t',
                        'while'
                        );

{ TWSDLCppWriter }

constructor TWSDLCppWriter.Create(const WSDLImporter: IWSDLImporter);
begin
  inherited Create(WSDLImporter);
end;

constructor TWSDLCppWriter.CreateFilename(const WSDLImporter: IWSDLImporter;
  OutFileName: string);
begin
    inherited CreateFilename(WSDLImporter, OutFileName);
end;

destructor TWSDLCppWriter.Destroy;
begin
  inherited Destroy;
end;

function TWSDLCppWriter.IsReservedWord(const Name: DOMString; var NewName: DOMString): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(CppReservedWords) to High(CppReservedWords) do
  begin
    if Name = CppReservedWords[I] then
    begin
      Result := True;
      Exit;
    end;
  end;

  if not Result then
  begin
    Result := WSDLImpWriter.IsReservedNameInSymFile(Name, True, NewName);
  end;
end;

function TWSDLCppWriter.IsDynArrayType(ArrayType: string): Boolean;
begin
  Result := False;
end;

function TWSDLCppWriter.TypeNameFromTypeInfo(TypeInfo: pTypeInfo): DOMString;
begin
  Result := OtherTypeName(string(TypeInfo.Name));
  if (Result = '') then
    Result := DOMString(TypeInfo.Name);
end;

procedure TWSDLCppWriter.WriteIntfHeader;
const
  sMacros: array[WSDLImporterOpts] of string = (
                  '',           // woHasSOAPDM,          // SOAP Data module in the WSDL
                  '',           // woHasDocStyle,        // Document style services
                  '',           // woHasLiteralUse,      // Literal service
                  sCppIsOptn,   // woHasOptionalElem,    // Types with optional elements
                  sCppIsUnbd,   // woHasUnboundedElem,   // Types with unbounded elements
                  sCppIsNlbl,   // woHasNillableElem,    // Types with nillable elements
                  sCppIsUnql,   // woHasUnqualifiedElem, // Types with unqualified elements
                  sCppIsAttr,   // woHasAttribute,       // Complex types with attributes
                  sCppIsText,   // woHasText,            // Properties that map to 'text' nodes - not ntElement
                  sCppIsAny,    // woHasAny
                  sCppIsRef,    // woHasRef
                  sCppIsQual,   // woHasQualifiedAttr
                  sCppIsOut     // woHasOut
       );
var
  Opt: WSDLImporterOpts;
  ImpOpts: TWSDLImporterOpts;
begin
  WriteWSDLInfo;
  WriteFmt(sHdrGuardBegin, [OutFile]);
  { Some headers are specific to clients }
  if not (wfServer in Global_WSDLGenFlags) then
    WriteStr(sClientHeaders)
  else
    WriteLn('');

  { Macros used in declaration }
  WriteStr(sCppRemoteClass);
  if EmitIndexMacros(ImpOpts, True) then
  begin
    for Opt := Low(WSDLImporterOpts) to High(WSDLImporterOpts) do
      if (Opt in ImpOpts) and (sMacros[Opt] <> '') then
        WriteStr(sMacros[Opt]);
    WriteLn('');
  end;

  if (wfTypesInNamespace in Global_WSDLGenFlags) then
    WriteTypeNamespace(OutFile);
end;

procedure TWSDLCppWriter.WriteIntfFooter;
begin
  if (wfTypesInNamespace in Global_WSDLGenFlags) then
    WriteTypeNamespace('', True);
  WriteFmt(sLineBreak + sHdrGuardEnd, [OutFile]);
end;
{ NOTE: This routine must be overriden by a TWSDLWriter-derived class -
        The default implementation is strictly for testing purposes }
function  TWSDLCppWriter.HasSource: Boolean;
begin
  Result := True;
end;

function  TWSDLCppWriter.IntfExt: DOMString;
begin
  Result := '.h';               { Do not localize }
end;

function  TWSDLCppWriter.SourceExt: DOMString;
begin
  Result := '.cpp';             { Do not localize }
end;

procedure TWSDLCppWriter.SetOutFile(const outFile: string; CheckProject: Boolean);
{$IFNDEF STANDALONE}
var
  I: integer;
{$ENDIF}
begin
  FOutFile := outFile;
{$IFNDEF STANDALONE}
  I := 0;
  { Unit name can't conflict with existing file name }
  if CheckProject then
  begin
    while FileExistInActiveProject(FOutFile+SourceExt) do
    begin
      Inc(I);
      FOutFile := outFile + IntToStr(I);
    end;
  end;
{$ENDIF}  
end;

function TWSDLCppWriter.RemapMembersOfTypeName: boolean;
begin
  Result := True;
end;

procedure TWSDLCppWriter.WriteTypeNamespace(const TypeNamespace: DOMString; Using: Boolean);
begin
  { We're already in that namespace: shortcircuit! }
  if (Namespace = TypeNamespace) then
    Exit;
  if (Namespace <> '') then
  begin
    WriteFmt(sNamespaceHdrEnd, [Namespace]);
    if Using then
      WriteFmt(sNamespaceUsing, [Namespace]);
  end;
  Namespace := TypeNamespace;
  if (Namespace <> '') then
    WriteFmt(sNamespaceHdrBegin, [Namespace]);
end;

function TWSDLCppWriter.GetPartFlagList(const Part: IWSDLPart;
                                        SkipFlags: TPartFlag): string;
const
  PartStr: array[PartFlag] of string = (sIS_OPTN, sIS_UNBD, sIS_NLBL, sIS_UNQL,
                                        sIS_TEXT, sIS_ANY, sIS_REF, sIS_QUAL);
  Delimiter = ' | ';
var
  pf: PartFlag;
  Flags: TPartFlag;
  IsAttr: Boolean;
begin
  Result := '';

  if Assigned(Part) then
  begin
    if HasIndexDecl(Part, Flags, IsAttr, True) then
    begin
      if IsAttr then
        Result := sIS_ATTR;
      if Part.PartKind = pOut then
      begin
        if Length(Result) > 0 then
          Result := Result + Delimiter;
        Result := Result + sIS_OUT;
      end;
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
end;

function TWSDLCppWriter.GetTypeInfo(const WSDLType: IWSDLType): DOMString;
begin
  if Verbose then
    Result := Format(sCppComment, [inherited GetTypeInfo(WSDLType)])
  else
    Result := '';
end;

procedure TWSDLCppWriter.WriteEnum(const WSDLType: IWSDLType);
const
  sClass: array[boolean] of string = ('', 'class '); { Do not localize }
var
  Len, Count: Integer;
begin
  { We can email either scoped or non-scoped enumeration }
  WriteLn('enum %s%s   %s' + sLineBreak + '{', [sClass[wfUseScopedEnumeration in Global_WSDLGenFlags], { Do not localize }
                                                WSDLType.LangName,
                                                GetTypeInfo(WSDLType)]);   { Do not localize }
  Len := Length(WSDLType.EnumValues);
  if Len > 0 then
  begin
    for Count:= 0 to (Len-1) do
    begin
      WriteFmt('  %s%s' + sLineBreak, [WSDLType.EnumValues[Count].LangName,
                                       Commas[Count < (Len-1)]]);
    end;
  end;
  WriteLn('};' + sLineBreak);

  { Write a TypeInfo container for the enum }
  WriteLn(sTypeInfoHolder, [WSDLType.LangName]);
end;

procedure TWSDLCppWriter.WriteAliasDef(const WSDLType: IWSDLType);
begin
  WriteLn('typedef %s %s; %s', [WSDLType.BaseType.LangName, WSDLType.LangName,
                                GetTypeInfo(WSDLType)]);  { Do not localize }

  { Here the typedef could be that of an enum }
  { So we create a TypeInfo container         }

end;

procedure TWSDLCppWriter.WriteArray(const WSDLType: IWSDLType);
const
  ComplexOp: array[Boolean] of string = ('', '*');
var
  TypeDef: DOMString;
  TypeName: DOMString;
  ArrayDef: DOMString;
  I: Integer;
begin
  ArrayDef := '%s';
  if WSDLType.Dimensions > 1 then
  begin
    for I := 0 to (WSDLType.Dimensions-2) do
      ArrayDef := Format('DynamicArray< %s >', [ArrayDef]);
  end;
  TypeDef := Format('DynamicArray<%s%s>', [WSDLType.BaseType.LangName,      { Do not localize }
                                           ComplexOp[IsComplex(WSDLType.BaseType)]]);
  Typedef := Format(ArrayDef, [TypeDef]);
  TypeName:= WSDLType.LangName+';';
  WriteLn('typedef %-25s %-15s %s', [TypeDef, TypeName, GetTypeInfo(WSDLType)]); { Do not localize }
end;

procedure TWSDLCppWriter.WriteComplexTypeClass(const WSDLType: IWSDLType; PassType: TPassWriterType);

  function GetIndexDecl(const Member: IWSDLPart): string;
  begin
    Result := GetPartFlagList(Member);
    if Length(Result) > 0 then
      Result := Format('index=(%s), ', [Result]);
  end;

  function GetStoredDecl(const Member: IWSDLPart): string;
  begin
    Result := '';
    if GenSpecifiedSupport(Member) then
    begin
      if HasIndexDecl(Member, True) then
        Result := Format(sSpecifiedStoredProcI, [Member.LangName])
      else
        Result := Format(sSpecifiedStoredProcF, [Member.LangName]);
    end;
  end;

const
  ReadPrefix: array[Boolean] of  string = ('F', 'Get');
  WritePrefix: array[Boolean] of  string = ('F', 'Set');
  GetterDecl: array[Boolean] of string = (sRemoteClassGetter, sRemoteClassGetterIdx);
  SetterDecl1: array[Boolean] of string = (sRemoteClassSetter, sRemoteClassSetterIdx);
  SetterDecl2: array[Boolean] of string = (sRemoteClassSetter2, sRemoteClassSetterIdx2);
  DefArrayLen: array[Boolean] of string = (sDefaultArrayImpl, sDefaultArrayImplIdx);
  DefArrayOp : array[Boolean] of string = (sDefaultArrayImplOp, sDefaultArrayImplOpIdx);

var
  I: Integer;
  Members: IWSDLPartArray;
  ComplexNames: TDOMStrings;
  ComplexTypes: TDOMStrings;
  ArrayNames: TDOMStrings;
  ComplexMember, ComplexArray: Boolean;
  Reader, Writer, StoredDecl, IndexDecl: string;
  HasWriter: Boolean;
  HasCtr, HasDtr, SetGet, UseSetGets, GenSpcCode: Boolean;
  DefMember, Member: IWSDLPart;
  DefMemberType: IWSDLType;
  DtrImpl: Widestring;
  BaseName: DOMString;
  ArrayAsClass: Boolean;
  DataTypeName: string;
begin
  Members := nil; { To shut up compiler warning ?? }

  { Just forward ref?? }
  if (PassType >= [ptForwardDecl]) then
  begin
    WriteLn('class SOAP_REMOTABLE_CLASS %s;', [WSDLType.LangName]);    { Do not localize }
    Exit;
  end;

  ArrayAsClass := (xoInlineArrays in WSDLType.SerializationOpt) or
                  (IsPureCollection(WSDLType) and
                   (WSDLType.Members[0].PartKind = pDefaultArray));
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

      WriteFmt(sRemoteClassDecl, [WSDLType.LangName, BaseName]);

      { Member properties }
      for Member in Members do
      begin
        { Is this member itself represented as a class }
        ComplexMember := IsComplex(Member.DataType);
        WriteLn(sMemberField, [Member.DataType.LangName + RefOp[ComplexMember],
                               Member.LangName]);
        if GenSpecifiedSupport(Member) then
        begin
          WriteLn(sSpecifiedField, ['bool', Member.LangName]);
        end;
      end;

      { Emit setter/getter methods }
      if UseSetGets or GenSpcCode then
      begin
        for Member in Members do
        begin
          if UseSetGets or GenSpecifiedSupport(Member) then
          begin
            DataTypeName := Member.DataType.LangName + RefOp[IsComplex(Member.DataType)];
            if UseSetGets then
              WriteFmt(GetterDecl[HasIndexDecl(Member, True)], [Member.LangName, DataTypeName]);
            if UseSetGets or GenSpecifiedSupport(Member) then
            begin
              if GenSpecifiedSupport(Member) then
              WriteFmt(SetterDecl2[HasIndexDecl(Member, True)], [Member.LangName, DataTypeName])
            else
              WriteFmt(SetterDecl1[HasIndexDecl(Member, True)], [Member.LangName, DataTypeName]);
            end;
            if GenIndexedSpecifiedSupport(Member) then
              WriteFmt(sSpecifiedStoredProcIdx, [Member.LangName]);
          end;
        end;
      end;

      { Array as class }
      if ArrayAsClass then
      begin
        WriteLn('');
        WriteFmt(DefArrayLen[GenSpecifiedSupport(DefMember)], [DefMember.LangName]);
      end;

      { Public section }
      if HasCtr or HasDtr or ArrayAsClass then
      begin
        WriteLn('');
        WriteStr(sRemoteClassPublic);
      end;

      { Public Constructor & Destructor }
      if (HasCtr or HasDtr) then
      begin
        if HasCtr then
          WriteFmt(sRemoteClassCtr, [WSDLType.LangName]);
        if HasDtr then
          WriteFmt(sRemoteClassDtr, [WSDLType.LangName]);
      end;

      if ArrayAsClass then
      begin
        if (HasCtr or HasDtr) then
          WriteLn('');
        DataTypeName := DefMemberType.LangName + RefOp[IsComplex(DefMemberType)];
        WriteLn(DefArrayOp[GenSpecifiedSupport(DefMember)], [DefMember.LangName, DataTypeName]);
      end;

      { Published section }
      WriteStr(sRemoteClassPublish);
      for Member in Members do
      begin
        DataTypeName := Member.DataType.LangName + RefOp[IsComplex(Member.DataType)];
        SetGet := UseSetGets or GenSpecifiedSupport(Member);

        { Reader }
        Reader := Format('read=F%0:s', [Member.LangName]);

        Writer := '';
        if HasWriter then
          Writer := Format(', write=%s%s', [WritePrefix[SetGet], Member.LangName]);

        { Index }
        IndexDecl := GetIndexDecl(Member);

        { Stored }
        StoredDecl := GetStoredDecl(Member);

        WriteLn('  __property %-10s %10s = { %s%s%s%s };', [DataTypeName,  { Do not localize }
                                                            Member.LangName,
                                                            IndexDecl,
                                                            Reader,
                                                            Writer,
                                                            StoredDecl]);
      end;
      WriteLn(sRemoteClassDeclEnd + sLineBreak);
    end;

    { We're implementing the type }
    if (PassType >= [ptTypeImpl]) then
    begin
      if (HasCtr) then
      begin
                                                             
        WriteLn(sRemoteClsCtrImpl, [WSDLType.LangName, '']);
      end;

      if (HasDtr) then
      begin
        { Collect cleanup code }
        for I := 0 to ComplexNames.Count-1 do
        begin
          DtrImpl := Format(sDtrClsLine, [DtrImpl, ComplexNames[I]]);
        end;
        for I := 0 to ArrayNames.Count-1 do
        begin
          DtrImpl := Format(sDtrArrayLine, [DtrImpl, ArrayNames[I]]);
        end;
        WriteLn(sRemoteClsDtrImpl, [WSDLType.LangName, DtrImpl]);
      end;
    end;

  finally
    ComplexNames.Free;
    ComplexTypes.Free;
    ArrayNames.Free;
  end;
end;

{$IFNDEF UNICODE}
function TWSDLCppWriter.Escape(const W: DOMString): DOMString;
const
  cBackslash = '\';
var
  I: Integer;
  UniStr: string;
begin
  Result := W;
  for I := Length(Result) downto 1 do
  begin
    if Result[I] = cBackslash then
      Insert(cBackslash, Result, I);
    if Result[I] > WideChar(255) then
    begin
      UniStr := Format('\u%s', [IntToHex(Word(Result[I]), 4)]);
      Delete(Result, I, 1);
      Insert(UniStr, Result, I);
    end;
  end;
end;
{$ELSE}
function TWSDLCppWriter.Escape(const W: DOMString): DOMString;
const
  cBackslash = '\';
var
  I: Integer;
begin
  Result := W;
  for I := Length(Result) downto 1 do
  begin
    if Result[I] = cBackslash then
      Insert(cBackslash, Result, I);
  end;
end;
{$ENDIF}

procedure TWSDLCppWriter.WriteInterfaceBegin(const WSDLPortType: IWSDLPortType;
                                             PassType: TPassWriterType);
begin
  if (ptTypeDecl in PassType) then
    WriteFmt(sInterfaceDecl, [GUIDToString(WSDLPortType.GUID),
                              WSDLPortType.LangName,
                              WSDLPortType.BaseInterfaceName])
  else if (ptTypeImpl in PassType) then

    WriteFmt(sImplDecl, [WsdlPortType.LangName])
  else if (ptTypeFactoryImpl in PassType) then
  begin
    case WriteFactory(WSDLPortType) of
      ftWSDLURL:
      begin
        WriteLn(sFactoryImpl, [WSDLPortType.LangName,
                               Escape(Self.FileName),
                               Escape(WSDLPortType.URL),
                               Escape(WSDLPortType.Service),
                               Escape(WSDLPortType.Port)]);
      end;
    end;
  end;
end;

procedure TWSDLCppWriter.WriteMethod(const WSDLOperation: IWSDLOperation;
                                     const Parent: IWSDLPortType;
                                     PassType: TPassWriterType);
  function UseRef(const WSDLPart: IWSDLPart): Boolean;
  begin
    Result := IsComplex(WSDLPart.DataType);
  end;

  { Try to fabricate some dummy data - could use a lot of improvement }
  function DummyReturn(const WSDLType: IWSDLType): DOMString;
  begin
    if not Assigned(WSDLType) then
      Result := ''
    else
    begin
      case WSDLType.DataKind of
        wtClass:
          Result := Format(sReturnNewTempl, [WSDLType.LangName]);

        wtEnumeration:
          { Should check that we do have values?? }
          Result := Format(sReturnTempl, [WSDLType.EnumValues[0].LangName]);

        wtArray:
          Result := Format(sReturnDecl, [WSDLType.LangName, '_out']) +      { Do not localize }
                    Format(sReturnTempl, ['_out']);                         { Do not localize }
        else
        begin
          if WSDLType.TypeInfo <> nil then
          begin
            case WSDLType.TypeInfo.Kind of
              tkClass:    Result := Format(sReturnNewTempl, [WSDLType.LangName]);
              tkInteger:  Result := Format(sReturnTempl, ['123456789']);
              tkFloat:    Result := Format(sReturnTempl, ['9.87654321']);
              tkInt64:    Result := Format(sReturnTempl, ['918273645']);
              tkString, tkLString :
                          Result := Format(sReturnTempl, ['"abcdefghij"']);
              tkWString:  Result := Format(sReturnTempl, ['"xyz"']);
              tkDynArray:
                          Result := Format(sReturnDecl, [WSDLType.LangName, '_out']) +
                                    Format(sReturnTempl, ['_out']);
              tkEnumeration:
                          if SameTypeInfo(TypeInfo(System.boolean), WSDLType.TypeInfo) then
                            Result := Format(sReturnTempl, ['true']);

            end;
          end
          else
          begin
            Result := Format(sReturnTempl, ['0']);
          end;
        end;
      end;
    end;
  end;
var
  RetIndex, I, Params: Integer;
  RetDataType: IWSDLType;
  RetType: DOMString;
  WSDLPart: IWSDLPart;
  PostOp: DOMString;
  ClassName: DOMString;
  FormatStr: DOMString;
begin
  if (ptTypeFactoryDecl in PassType) or
     (ptTypeFactoryImpl in PassType) then
    Exit;     

  { Map return type to a string }
  RetIndex := WSDLOperation.ReturnIndex;
  if (RetIndex <> -1) then
  begin
    WSDLPart := WSDLOperation.Parts[RetIndex];
    RetDataType := WSDLPart.DataType;
    RetType := WSDLPart.DataType.LangName + RefOp[UseRef(WSDLPart)];
  end
  else
  begin
    RetType := 'void';
    RetDataType := nil;
  end;

  { Include classname in method implementation }
  if ptMethImpl in PassType then
    ClassName := Format('T%sImpl::', [Parent.LangName])
  else
    ClassName :='';

  if ptMethImpl in PassType then
    FormatStr := '%s%s%s %s%s('   { ' ', 'virtual', 'ret', 'className::' 'funcName' ('}
  else
    FormatStr := '%s%s%-15s %s%s(';

    // Here we can emit information about the method
  if Verbose and (not (ptMethImpl in PassType)) and HasInfoAboutMethod(WSDLOperation) then
    WriteStr(GetMethodInfo(WSDLOperation));

  { NOTE: Only put virtual on interface - not required in implementation }
  WriteFmt(FormatStr, [PadStr[(ptTypeDecl in PassType) or (ptTypeImpl in PassType)],
                       VirtualStr[ptTypeDecl in PassType],
                       RetType,
                       ClassName,
                       WSDLOperation.LangName]);

  { How many parameters ?? }
  Params := Length(WSDLOperation.Parts);
  if (RetIndex <> -1) then
    Dec(Params);

  if (Params > 0) then
  begin
    for I := 0 to Length(WSDLOperation.Parts)-1 do
    begin
      WSDLPart := WSDLOperation.Parts[I];
      if (I <> RetIndex) then
      begin
        Dec(Params);
        { Get modifier }
        PostOp := '';
        if UseRef(WSDLPart) then
          PostOp := RefOp[True];
        PostOp := PostOp + PosParamMod[WSDLPart.PartKind];

        WriteFmt('%s%s%s %s%s', [PreParamMod[WSDLPart.PartKind],
                                 WSDLPart.DataType.LangName,
                                 PostOp,
                                 WSDLPart.LangName,
                                 Commas[Params > 0]]);
      end;
    end;
  end;
  WriteLn(')%s%s', [PureVirtStr[ptTypeDecl in PassType],
                    SemiStr[(ptTypeDecl in PassType) or (ptTypeImpl in PassType)]]);

  { Provide a dummy implementation - if we're implementing }
  if ptMethImpl in PassType then
  begin
    WriteFmt(sMethImpl, [WSDLOperation.LangName, DummyReturn(RetDataType)]);
  end;
end;

procedure TWSDLCppWriter.WriteInterfaceEnd(const WSDLPortType: IWSDLPortType; PassType: TPassWriterType);
begin
  if (ptTypeDecl in PassType) then
  begin
    WriteFmt(sInterfaceDeclEnd, [WSDLPortType.LangName]);
  end
  else if (ptTypeImpl in PassType) then
  begin
    WriteStr(sImplOther);
    WriteFmt(sImplEnd, [WSDLPortType.LangName]);
  end
  else if (ptTypeFactoryDecl in PassType) then
  begin
    case WriteFactory(WSDLPortType) of
      ftWSDLURL:
      begin
        WriteFmt(sIntfFactoryDecl, [WSDLPortType.LangName]);
      end;
    end;      
  end;
end;

function TWSDLCppWriter.WriteSettingsFile: Boolean;
begin
  Result := False;
end;

procedure TWSDLCppWriter.WriteSource;
begin
  WriteSourceHeader;
  WriteImplementations;
  WriteRegCalls;
  WriteSourceFooter;
end;

                                                             
procedure TWSDLCppWriter.WriteSourceHeader;
begin
  WriteWSDLInfo;
  WriteLn(sStandardSourceIncludeSystem, [OutFile]);
  if (wfTypesInNamespace in Global_WSDLGenFlags) then
    WriteTypeNamespace(OutFile);
end;

{ Registration Calls }
procedure TWSDLCppWriter.WriteRegCalls;

  procedure WriteTypeRegistration(const WSDLType: IWSDLType);
  var
    EnumMember: IWSDLItem;
    WSDLPart: IWSDLPart;
    SerialOpts: TSerializationOptions;
    ARegInfo: TRegInfoAttribute;
  begin
    case WSDLType.DataKind of
      { Classes }
      wtClass:
      begin
        if Verbose then
          WriteLn(sCppCommentIdent, [WSDLType.Name]);

        if WSDLType.Name <> WSDLType.LangName then
          WriteFmt(sRegClass2, [WSDLType.LangName,
                                Escape(WSDLType.Namespace),
                                WSDLType.LangName,
                                Escape(WSDLType.Name)])
        else
          WriteFmt(sRegClass1, [WSDLType.LangName,
                                Escape(WSDLType.Namespace),
                                Escape(WSDLType.LangName)]);

        for WSDLPart in WSDLType.Members do
        begin
          ARegInfo.Reset;
          //Assert((WSDLPart.RegInfo = '') or (WSDLPart.DataType.RegInfo = ''));
          if WSDLPart.DataType.RegInfo <> '' then
            ARegInfo.Load(WSDLPart.DataType.RegInfo);
          if WSDLPart.RegInfo <> '' then
            ARegInfo.Load(WSDLPart.RegInfo);

          if WSDLPart.Name <> WSDLPart.LangName then
            ARegInfo.SetAttr(InfoAttribute.iaExternalName, WSDLPart.Name);

          if ARegInfo.HasAttr then
            WriteFmt(sRegMemberRenamed, [WSDLType.LangName,
                                         WSDLPart.LangName,
                                         ARegInfo.AsString(True)]);
        end;

        { Class Serialization options }
        if (WSDLType.SerializationOpt <> []) then
        begin
          SerialOpts := WSDLType.SerializationOpt;
          WriteFmt(sRegClassSerOptsCpp, [WSDLType.LangName, SetToStr(TypeInfo(SerializationOptions),
                                                                     Integer(SerialOpts),
                                                                     [stsInsertion])]);
        end;
      end;

      { Enumerations }
      wtEnumeration:
      begin
        if Verbose then
          WriteLn(sCppCommentIdent, [WSDLType.Name]);
        if WSDLType.Name <> WSDLType.LangName then
          WriteFmt(sRegHolderTypeInfo2, [WSDLType.LangName,
                                         Escape(WSDLType.Namespace),
                                         Escape(WSDLType.Name)])
        else
          WriteFmt(sRegHolderTypeInfo1, [WSDLType.LangName,
                                         Escape(WSDLType.Namespace)]);
        for EnumMember in WSDLType.EnumValues do
          if EnumMember.Name <> EnumMember.LangName then
            WriteFmt(sRegMemberRenamedE, [WSDLType.LangName,
                                          EnumMember.LangName,
                                          Escape(EnumMember.Name)]);
      end;

      { Arrays }
      wtArray:
      begin
        if Verbose then
          WriteLn(sCppCommentIdent, [WSDLType.Name]);
        if WSDLType.Name <> WSDLType.LangName then
          WriteFmt(sRegArrayTypeInfo2, [WSDLType.LangName,
                                        Escape(WSDLType.Namespace),
                                        Escape(WSDLType.LangName),
                                        Escape(WSDLType.Name)])
        else
          WriteFmt(sRegArrayTypeInfo1, [WSDLType.LangName,
                                        Escape(WSDLType.Namespace),
                                        Escape(WSDLType.LangName)]);
        { Array serialization options }
        if (WSDLType.SerializationOpt <> []) then
        begin
          SerialOpts := WSDLType.SerializationOpt;
          WriteFmt(sRegInfoSerOptsCpp, [WSDLType.LangName, SetToStr(TypeInfo(SerializationOptions),
                                                                  Integer(SerialOpts),
                                                                  [stsInsertion])]);
        end;
      end;
    end;
  end;

{$IFDEF _DEBUG}
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
{$ENDIF}

var
  WSDLPortTypeArray: IWSDLPortTypeArray;
  I, J, K: Integer;
  WSDLTypeArray: IWSDLTypeArray;
  WSDLType: IWSDLType;
  WSDLPortType: IWSDLPortTYpe;
  WSDLOperations: IWSDLOperationArray;
  WSDLOperation: IWSDLOperation;
  WSDLParts: IWSDLPartArray;
  WSDLPart, ReturnPart: IWSDLPart;
  MethodHeading: Boolean;
  PartFlagList, ParamNamespace, InternalName, ExternalName, ReturnName: string;
  InputNamespace, OutputNamespace: string;
  ARegInfo: TRegInfoAttribute;
  RegInfoStr: string;
begin
  SetLength(WSDLParts, 0);
  SetLength(WSDLOperations, 0);

  WriteStr(sRegProcInfo);
  WriteStr(sInfoEnd);
  WriteStr(sInitRoutineBeg);

  { Register PortTypes }
  WSDLPortTypeArray := FWSDLImporter.GetPortTypes;
  for I := 0 to Length(WSDLPortTypeArray)-1 do
  begin
    WSDLPortType := WSDLPortTypeArray[I];

    if Verbose then
      WriteLn(sCppCommentIdent, [WSDLPortType.Name]);

    { Pick the optimal output }
    if (WSDLPortType.LangName <> WSDLPortType.Name) then
      WriteFmt(sRegInterface2, [WSDLPortType.LangName,
                                Escape(WSDLPortType.Namespace),
                                Escape(FWSDLImporter.Encoding),
                                Escape(WSDLPortType.Name)])
    else
      WriteFmt(sRegInterface1, [WSDLPortType.LangName,
                                Escape(WSDLPortType.Namespace),
                                Escape(FWSDLImporter.Encoding)]);


    { Register PortTypes - for server implementation }
    if wfServer in Global_WSDLGenFlags then
    begin
      if Verbose then
        WriteLn(sCppCommentIdent, [Format(sServerImpl, [WSDLPortType.LangName])]);
      WriteFmt(sRegImpl, [WSDLPortType.LangName]);
    end;

    { SOAPAction[s] }
    if (WSDLPortType.HasDefaultSOAPAction) then
    begin
      { If we're in server mode, avoid tricky SOAPActions that will make
        dispatching fail;
        Of course, this means that upfront we're not able to roundrip a WSDL }
      if (not (wfServer in Global_WSDLGenFlags)) or
         (Pos(DOMString(SOperationNameSpecifier), WSDLPortType.SOAPAction)=0) then
        WriteFmt(sRegSOAPAction, [WSDLPortType.LangName, Escape(WSDLPortType.SOAPAction)]);
    end
    else if WSDLPortType.HasAllSOAPActions then
    begin
      { Here we write out the SOAP action for each operation }
      if (not (wfServer in Global_WSDLGenFlags)) then
      begin
        WriteFmt(sRegAllSOAPAction, [WSDLPortType.LangName, Escape(WSDLPortType.SOAPAction)]);
      end;
    end;

    { Return Return Param Names }
{$IFDEF _DEBUG}
    if DefaultReturnParamNames <> SDefaultReturnParamNames then
      WriteFmt(sRegParamNames, [WSDLPortType.LangName, Escape(DefaultReturnParamNames)]);
{$ENDIF}

    { Flag the registry if this interface is 'encoded' vs. 'literal'
      However, only do this if we're generating client code - for servers
      we're always rpc|encoded }
    if not (wfServer in Global_WSDLGenFlags) then
    begin
      if (ioDocument in WSDLPortType.InvokeOptions) then
        WriteFmt(sRegInvokeOptDoc, [WSDLPortType.LangName]);
      if (ioLiteral in WSDLPortType.InvokeOptions) then
        WriteFmt(sRegInvokeOptLit, [WSDLPortType.LangName]);
      if (ioSOAP12 in WSDLPortType.InvokeOptions) then
        WriteFmt(sRegInvokeOptSOAP12, [WSDLPortType.LangName]);
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
            RegInfoStr := ARegInfo.AsString(True);

          if (ExternalName <> '') or
             (RegInfoStr <> '') or
             (PartFlagList <> '') then
          begin
            if Verbose then
            begin
              WriteLn(sCppCommentIdent, [Format('%s.%s', [WSDLPortType.Name, InternalName])]);
              MethodHeading := True;
            end;
            if PartFlagList <> '' then
              WriteFmt(sRegMethodInfoCpp, [WSDLPortType.LangName,
                                           InternalName,
                                           ExternalName,
                                           RegInfoStr,
                                           PartFlagList])
            else if RegInfoStr <> '' then
              WriteFmt(sRegMethodInfoCppNoOpts, [WSDLPortType.LangName,
                                                 InternalName,
                                                 ExternalName,
                                                 RegInfoStr])
            else
              WriteFmt(sRegMethodInfoCppNoInfo, [WSDLPortType.LangName,
                                                 InternalName,
                                                 ExternalName]);
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
            if (WSDLPortType.InvokeOptions * [ioLiteral, ioDocument]) = [ioLiteral] then            
               ParamNamespace := WSDLPart.DataType.Namespace;
            if WSDLPart.PartKind = pOut then
              PartFlagList := sIS_OUT;
          end;

          if ParamNamespace = XMLSchemaNamespace then
            ParamNamespace := '';

          if ParamNamespace <> '' then
            ARegInfo.SetAttr(InfoAttribute.iaNamespace, ParamNamespace);
          if WSDLPart.DataType.RegInfo <> '' then
            ARegInfo.Load(WSDLPart.DataType.RegInfo);
          if ARegInfo.HasAttr then
            RegInfoStr := ARegInfo.AsString(True);

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
              WriteLn(sCppCommentIdent, [Format('%s->%s', [WSDLPortType.Name, WSDLOperation.LangName])]);
              MethodHeading := True;
            end;
            if PartFlagList <> '' then
              WriteFmt(sRegParamInfoCpp, [WSDLPortType.LangName,
                                          WSDLOperation.LangName,
                                          InternalName,
                                          ExternalName,
                                          RegInfoStr,
                                          PartFlagList])
            else if RegInfoStr <> '' then
              WriteFmt(sRegParamInfoCppNoOpts, [WSDLPortType.LangName,
                                                WSDLOperation.LangName,
                                                InternalName,
                                                ExternalName,
                                                RegInfoStr])
            else
              WriteFmt(sRegParamInfoCppNoInfo, [WSDLPortType.LangName,
                                                WSDLOperation.LangName,
                                                InternalName,
                                                ExternalName]);
          end;
        end;
      end;
    finally
      {To keep formatting similar to PasWriter}
    end;
  end;

  { Register Types }
  WSDLTypeArray := FWSDLImporter.GetTypes;
  for I := 0 to Length(WSDLTypeArray)-1 do
  begin
    WSDLType := WSDLTypeArray[I];
    WSDLType := UnwindType(WSDLType);

    { Skip unused types }
    if SkipType(WSDLType, True) then
      continue;

    WriteTypeRegistration(WSDLType);
  end;

  { Register PortTypes - for server implementation }
  if wfServer in Global_WSDLGenFlags then
  begin
    WSDLPortTypeArray := FWSDLImporter.GetPortTypes;
    for I := 0 to Length(WSDLPortTypeArray)-1 do
    begin
      WSDLPortType := WSDLPortTypeArray[I];
      if Verbose then
        WriteLn(sCppCommentIdent, [Format(sServerImpl, [WSDLPortType.LangName])]);
      WriteFmt(sRegImpl, [WSDLPortType.LangName]);
    end;
  end;

  WriteStr(sInitRoutineEnd);
end;

procedure TWSDLCppWriter.WriteSourceFooter;
begin
  if (wfTypesInNamespace in Global_WSDLGenFlags) then
    WriteTypeNamespace('');
end;

end.
