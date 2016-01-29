{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Xml.XMLIniFile;

interface

uses System.IniFiles, Xml.XmlIntf, System.Classes;

type
  TXmlIniFile = class(TCustomIniFile)
  strict private
    FNode: IXmlNode;
    function FindXmlNode(const NodeName: string): IXmlNode;
    function FindXmlNodeOrAdd(const NodeName: string): IXmlNode;
    procedure DeleteChildNode(AParentNode: IXmlNode; AIndex: Integer);
    function ReadXmlString(const Section, Name, Default: string): string;
    procedure WriteXmlString(const Section, Name, Value: string);
    procedure GetSectionValues(const Section: string; Strings: TStrings);
  public
    constructor Create(const ANode: IXmlNode);
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure WriteString(const Section, Ident, Value: string); override;
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; override;
    procedure WriteInteger(const Section, Ident: string; Value: Longint); override;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean; override;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); override;
    procedure DeleteKey(const Section, Ident: string); override;
    procedure ReadSection(const Section: string; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); override;
    procedure EraseSection(const Section: string); override;
    procedure UpdateFile; override;
    function ValueExists(const Section, Ident: string): Boolean; override;
    procedure GetStrings(List: TStrings);
  end;

  TXmlMemIniFile = class(TMemIniFile)
  strict private
    FXmlIniFile: TXmlIniFile;
    procedure LoadValues;
  public
    constructor Create(const ANode: IXmlNode); reintroduce;
    destructor Destroy; override;
    procedure UpdateFile; override;
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean; override;
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint; override;
    function ReadString(const Section, Ident, Default: string): string; override;
    procedure DeleteKey(const Section, Ident: String); override;
    procedure EraseSection(const Section: string); override;
    procedure WriteString(const Section, Ident, Value: String); override;
    procedure WriteBool(const Section, Ident: string; Value: Boolean); override;
  end;

implementation

uses System.SysUtils, System.Variants;

const
  sName = 'Name';

function NormalizeIdent(const Ident: string): string;
//var
//  I: Integer;
begin
//  for I := 1 to Length(Result) do
//    if (Result[I] = ' ') or  (Result[I] = '\') then
//      Result[I] := '_';
  Result := StringReplace( Ident, ' ', '_', [rfReplaceAll]);
  Result := StringReplace( Result, '\', '_', [rfReplaceAll]);
end;

function IsBlankString(const S: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(S) to High(S) do
    if S[I] > #32 then
      Exit;
  Result := True;
end;

constructor TXmlIniFile.Create(const ANode: IXmlNode);
begin
  FNode := ANode;
end;

function TXmlIniFile.ReadString(const Section, Ident, Default: string): string;
begin
  Result := ReadXmlString(Section, Ident, Default);
end;

procedure TXmlIniFile.WriteString(const Section, Ident, Value: String);
begin
  WriteXmlString(Section, Ident, Value);
end;

function TXmlIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
begin
  try
    Result := StrToInt(ReadXmlString(Section, Ident, IntToStr(Default)));
  except
    Result := Default;
  end;
end;

procedure TXmlIniFile.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteXmlString(Section, Ident, IntToStr(Value));
end;

function TXmlIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
var
  S: string;
begin
  S := ReadXmlString(Section, Ident, '');
  if S = '' then
    Result := Default
  else
    Result := SameText(S, 'True');
end;

procedure TXmlIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  if Value then
    WriteXmlString(Section, Ident, 'True') //Do not Internationalize
  else
    WriteXmlString(Section, Ident, 'False'); //Do not Internationalize
end;

procedure TXmlIniFile.DeleteChildNode(AParentNode: IXmlNode; AIndex: Integer);
begin
  if AIndex <> -1 then
  begin
    AParentNode.ChildNodes.Delete(AIndex);

    // delete the indention
    if AIndex - 1 >= 0 then
      if (AParentNode.ChildNodes.Get(AIndex - 1).NodeType = ntText) and
         IsBlankString(AParentNode.ChildNodes.Get(AIndex - 1).Text) then
        AParentNode.ChildNodes.Delete(AIndex - 1);

    // delete the line break and parent indention
    if AIndex - 2 >= 0 then
      if (AParentNode.ChildNodes.Get(AIndex - 2).NodeType = ntText) and
         IsBlankString(AParentNode.ChildNodes.Get(AIndex - 2).Text) then
        AParentNode.ChildNodes.Delete(AIndex - 2);
    // if the section is empty we still have a linebreak + parent indention
    if (AParentNode.ChildNodes.Count = 1) and (AParentNode.ChildNodes.Get(0).NodeType = ntText) and
       IsBlankString(AParentNode.ChildNodes.Get(0).Text) then
      AParentNode.ChildNodes.Clear;
  end;
end;

procedure TXmlIniFile.DeleteKey(const Section, Ident: string);
var
  I, Index: Integer;
  LNode, LChildNode: IXMLNode;
begin
  Index := -1;
  LNode := FindXMLNode(Section);
  if LNode <> nil then
    for I := 0 to LNode.ChildNodes.Count - 1 do
    begin
      LChildNode := LNode.ChildNodes.Get(I);
      if (LChildNode.NodeType = ntElement) and (LChildNode.Attributes[sName] = Ident) then
      begin
        Index := I;
        Break;
      end;
    end;
  if Index <> -1 then
    DeleteChildNode(LNode, Index);
end;

procedure TXmlIniFile.ReadSection(const Section: string; Strings: TStrings);
var
  I: Integer;
  LNode: IXMLNode;
  ChildNode: IXMLNode;
begin
  Strings.Clear;
  LNode := FindXMLNode(Section);
  if LNode <> nil then
  begin
    for I := 0 to LNode.ChildNodes.Count - 1 do
    begin
      ChildNode := LNode.ChildNodes.Get(I);
      if (ChildNode.NodeType = ntElement) and not VarIsNull(ChildNode.Attributes[sName]) then
        Strings.Add(ChildNode.Attributes[sName]);
    end;
  end;
end;

procedure TXmlIniFile.ReadSections(Strings: TStrings);
var
  I: Integer;
  ChildNode: IXMLNode;
begin
  if FNode <> nil then
  begin
    for I := 0 to FNode.ChildNodes.Count - 1 do
    begin
      ChildNode := FNode.ChildNodes.Get(I);
      if ChildNode.NodeType = ntElement then
        Strings.Add(ChildNode.NodeName);
    end;
  end;
end;

procedure TXmlIniFile.ReadSectionValues(const Section: string; Strings: TStrings);
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    GetSectionValues(Section, Strings);
  finally
    Strings.EndUpdate;
  end;
end;

procedure TXmlIniFile.EraseSection(const Section: string);
var
  Node: IXmlNode;
begin
  Node := FindXmlNode(Section);
  if Node <> nil then
    DeleteChildNode(Node.ParentNode, Node.ParentNode.ChildNodes.IndexOf(Node));
end;

procedure TXmlIniFile.UpdateFile;
begin
end;

procedure TXmlIniFile.WriteXmlString(const Section, Name, Value: string);
var
  I: Integer;
  Existing: IXmlNode;
  LocalNode, LocalChildNode: IXmlNode;
  ChildNodes: IXMLNodeList;
begin
  LocalNode := FindXmlNodeOrAdd(Section);

  Existing := nil;
  ChildNodes := LocalNode.ChildNodes;
  for I := 0 to ChildNodes.Count - 1 do
  begin
    LocalChildNode := ChildNodes.Get(I);
    if (LocalChildNode.NodeType = ntElement) and (LocalChildNode.Attributes[sName] = Name) then
    begin
      Existing := LocalChildNode;
      Break;
    end;
  end;
  if not Assigned(Existing) then
  begin
    Existing := LocalNode.AddChild(NormalizeIdent(Section));
    Existing.Attributes[sName] := Name;
  end;
  if Existing <> nil then
    Existing.Text := Value;
end;

function TXmlIniFile.ReadXmlString(const Section, Name, Default: string): string;
var
  I: Integer;
  LocalNode: IXmlNode;
  LocalChildNode: IXmlNode;

  function LocalAttributeIs(const Value: string): Boolean;
  var
    O: OleVariant;
    VarData: PVarData;
    A: string;
  begin
    O := LocalChildNode.Attributes[sName];
    VarData := FindVarData(O);
    if (VarData.VType = varString) or (VarData.VType = varOleStr) then
    begin
      A := O;
      Result := A = Value;
    end
    else
      Result := False;
  end;

begin
  LocalNode := FindXmlNode(Section);
  if LocalNode <> nil then
  begin
    for I := 0 to LocalNode.ChildNodes.Count - 1 do
    begin
      LocalChildNode := LocalNode.ChildNodes.Get(I);
      if (LocalChildNode.NodeType = ntElement) and LocalAttributeIs(Name) then
      begin
        Result := LocalChildNode.Text;
        Exit;
      end;
    end;
  end;
  Result := Default;
end;

function TXmlIniFile.FindXmlNode(const NodeName: string): IXmlNode;
var
  I: Integer;
  LNodeName: string;
  ChildNode: IXmlNode;
begin
  Result := nil;
  if FNode <> nil then
  begin
    LNodeName := NormalizeIdent(NodeName);
    for I := 0 to FNode.ChildNodes.Count - 1 do
    begin
      ChildNode := FNode.ChildNodes.Get(I);
      if (ChildNode.NodeType = ntElement) and (ChildNode.NodeName = LNodeName) then
      begin
        Result := ChildNode;
        Exit;
      end;
    end;
  end;
end;

function TXmlIniFile.FindXmlNodeOrAdd(const NodeName: string): IXmlNode;
begin
  Result := FindXmlNode(NodeName);
  if Result = nil then
    Result := FNode.AddChild(NormalizeIdent(NodeName));
end;

procedure TXmlIniFile.GetSectionValues(const Section: string; Strings: TStrings);
var
  I: Integer;
  SectionNode, ChildNode: IXMLNode;
  NameAttrValue: OleVariant;
begin
  SectionNode := FindXMLNode(Section);
  if SectionNode <> nil then
    for I := 0 to SectionNode.ChildNodes.Count - 1 do
    begin
      ChildNode := SectionNode.ChildNodes.Get(I);
      if ChildNode.NodeType = ntElement then
      begin
        NameAttrValue := ChildNode.Attributes[sName];
        if not VarIsNull(NameAttrValue) then
        begin
          // Variants are not converting properly to a string, so cast it manually.
          Strings.Add(string(NameAttrValue) + '=' + ChildNode.Text);
        end;
      end;
    end;
end;

procedure TXmlIniFile.GetStrings(List: TStrings);
var
  I: Integer;
  Section: string;
  Sections: TStrings;
begin
  List.BeginUpdate;
  try
    Sections := TStringList.Create;
    try
      List.Clear;
      ReadSections(Sections);
      for I := 0 to Sections.Count - 1 do
      begin
        Section := Sections[I];
        List.Add('['+Section+']');
        GetSectionValues(Sections[I], List);
      end;
    finally
      Sections.Free;
    end;

  finally
    List.EndUpdate;
  end;
end;

function TXmlIniFile.ValueExists(const Section, Ident: string): Boolean;
var
  I: Integer;
  LNode: IXMLNode;
  ChildNode: IXMLNode;
begin
  Result := False;
  LNode := FindXMLNode(Section);
  if LNode <> nil then
  begin
    for I := 0 to LNode.ChildNodes.Count - 1 do
    begin
      ChildNode := LNode.ChildNodes.Get(I);
      if ChildNode.IsTextElement and (ChildNode.Attributes[sName] = Ident) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

{ TXmlMemIniFile }

constructor TXmlMemIniFile.Create(const ANode: IXmlNode);
begin
  inherited Create('');
  FXmlIniFile := TXmlIniFile.Create(ANode);
  LoadValues;
end;

procedure TXmlMemIniFile.DeleteKey(const Section, Ident: String);
begin
  inherited;
  FXmlIniFile.DeleteKey(Section, Ident);
end;

destructor TXmlMemIniFile.Destroy;
begin
  inherited;
  FreeAndNil(FXmlIniFile);
end;

procedure TXmlMemIniFile.EraseSection(const Section: string);
begin
  inherited;
  FXmlIniFile.EraseSection(Section);
end;

procedure TXmlMemIniFile.LoadValues;
var
  Values: TStrings;
begin
  Values := TStringList.Create;
  try
    FXmlIniFile.GetStrings(Values);
    SetStrings(Values);
  finally
    Values.Free;
  end;
end;

function TXmlMemIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
var
  S: string;
begin
  // We use the same implementation as TXmlIniFile which handles True and False.
  // TCustomIniFile does not handle strings for booleans
  S := ReadString(Section, Ident, '');
  if S = '' then
    Result := Default
  else
    Result := SameText(S, 'True');
end;

function TXmlMemIniFile.ReadInteger(const Section, Ident: string; Default: Integer): Longint;
begin
  try
    Result := StrToInt(ReadString(Section, Ident, IntToStr(Default)));
  except
    Result := Default;
  end;
end;

function TXmlMemIniFile.ReadString(const Section, Ident, Default: string): string;
begin
  // need to NormalizeIdent the Section before reading the string so that the reads
  // match the writes -- since we use TXmlIniFile for writing and TXmlMemIniFile for
  // reading of Delphi projects.
  Result := inherited ReadString(NormalizeIdent(Section), Ident, Default);
end;

procedure TXmlMemIniFile.UpdateFile;
begin
  // Nop since TxmlIniFile is a Nop
end;

procedure TXmlMemIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  inherited;
  FXmlIniFile.WriteBool(Section, Ident, Value);
end;

procedure TXmlMemIniFile.WriteString(const Section, Ident, Value: String);
begin
  inherited;
  FXmlIniFile.WriteString(Section, Ident, Value);
end;

end.
