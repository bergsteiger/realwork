unit tcBuilder;

interface

uses
 SysUtils,

 tcInterfaces;

type
 EEmptyToolBar = class(Exception); 

function tcBuildToolbarList(const aFileName: String; OldMode: Boolean): ItcToolBarsList;

implementation

uses
 XMLDoc,
 XMLIntf,

 l3Base,
 l3Interfaces,
 l3VCLStrings,

 vcmExportConst,

 tcOperationsList,
 tcToolBarsList
 ;

type
 TtcBuilder = class(Tl3Base)
 private
  f_Toolbars: ItcToolBarsList;
  f_Operations: ItcOperationsList;
  f_MainToolBars: ItcToolBarsList;
  f_Document: IXMLDocument;
  f_OldMode: Boolean;
 private
  procedure ParseModules(const aNode: IXMLNode; FirstPass: Boolean);
  procedure ParseModule(const aNode: IXMLNode; FirstPass: Boolean);
  procedure ParseForms(const aNode: IXMLNode);
  procedure ParseForm(const aNode: IXMLNode);
  function ParseToolBars(const aNode, aFormNode: IXMLNode): ItcToolBarsList;
  procedure ParseToolBar(const aNode: IXMLNode; const aToolBars: ItcToolBarsList;
   IsMain: Boolean; const aFormID: WideString);
  procedure ParseEntities(const aNode: IXMLNode; const aToolBars: ItcToolBarsList;
   const aToolBarPrefix: WideString);
  procedure ParseEntity(const aNode: IXMLNode; const aToolBars: ItcToolBarsList;
   const aToolBarPrefix: WideString);
  procedure ParseOperations(const aNode: IXMLNode; const aPrefix: WideString;
   const aToolBars: ItcToolBarsList; const aCaptionPrefix: WideString;
   const aToolBarPrefix: WideString);
  procedure ParseOperation(const aNode: IXMLNode; const aPrefix: WideString;
   const aToolBars: ItcToolBarsList; const aCaptionPrefix: WideString;
   const aToolBarPrefix: WideString);
  function ParseExcludeUserTypes(const aNode: IXMLNode; const aToolBarPrefix: WideString): Il3StringsEx;
  procedure AddToolBarToLists(const aToolBar: ItcToolBar; isMain: Boolean);
  function FindModulesNode: IXMLNode;
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aFileName: String; OldMode: Boolean); reintroduce;
  function BuildToolBarsList: ItcToolBarsList;
 end;

function tcBuildToolbarList(const aFileName: String; OldMode: Boolean): ItcToolBarsList;
var
 l_Builder: TtcBuilder;
begin
 l_Builder := TtcBuilder.Create(aFileName, OldMode);
 try
  Result := l_Builder.BuildToolBarsList;
 finally
  FreeAndNil(l_Builder);
 end;
end;                                  

function tcVarToStr(const aVar: OLEVariant): WideString;
begin
 try
  Result := aVar;
 except
  Result := '';
 end;
end;

{ TtcBuilder }

function TtcBuilder.BuildToolBarsList: ItcToolBarsList;
var
 l_ModulesNode: IXMLNode;
begin
 l_ModulesNode := FindModulesNode;
 if Assigned(l_ModulesNode) then
 begin
  ParseModules(l_ModulesNode, True);
  ParseModules(l_ModulesNode, False);
  Result := f_ToolBars;
 end
 else
 begin
  Result := nil;
  raise Exception.Create('Cant found modules definition');
 end;
end;

procedure TtcBuilder.Cleanup;
begin
 f_Toolbars := nil;
 f_Operations := nil;
 f_Document := nil;
 inherited Cleanup;
end;

constructor TtcBuilder.Create(const aFileName: String; OldMode: Boolean);
begin
 inherited Create;
 f_ToolBars := TtcToolBarsList.Make;
 f_MainToolBars := TtcToolBarsList.Make;
 f_Operations := TtcOperationsList.Make;
 f_Document := LoadXMLDocument(aFileName);
 f_OldMode := OldMode;
end;

function TtcBuilder.FindModulesNode: IXMLNode;
var
 l_Parent: IXMLNode;
begin
 Result := nil;
 l_Parent := f_Document.ChildNodes.FindNode('application');
 if Assigned(l_Parent) then
  Result := l_Parent.ChildNodes.FindNode(c_vcmModule+'s');
end;

procedure TtcBuilder.ParseEntities(const aNode: IXMLNode;
  const aToolBars: ItcToolBarsList;
  const aToolBarPrefix: WideString);
var
 l_IDX: Integer;
begin
 if Assigned(aNode) then
  for l_IDX := 0 to aNode.ChildNodes.Count - 1 do
   if aNode.ChildNodes.Get(l_IDX).NodeName = c_vcmEntity then
    ParseEntity(aNode.ChildNodes.Get(l_IDX), aToolBars, aToolBarPrefix);
end;

procedure TtcBuilder.ParseForm(const aNode: IXMLNode);
var
 l_IDNode: IXMLNode;
 l_Entities: IXMLNode;
 l_ToolBarList: ItcToolBarsList;
begin
 l_IDNode := aNode.AttributeNodes.FindNode(c_vcmID);
 if Assigned(l_IDNode) then
 begin
  l_ToolBarList := ParseToolBars(aNode.ChildNodes.FindNode(c_vcmUserType+'s'), aNode);
  l_Entities := aNode.ChildNodes.FindNode(c_vcmEntities);
  if Assigned(l_Entities) then
   ParseEntities(l_Entities, l_ToolBarList, tcVarToStr(l_IDNode.NodeValue));
 end
 else
  raise Exception.Create('Cant found modules definition');
end;

procedure TtcBuilder.ParseForms(const aNode: IXMLNode);
var
 l_IDX: Integer;
begin
 if Assigned(aNode) then
  for l_IDX := 0 to aNode.ChildNodes.Count - 1 do
   if aNode.ChildNodes.Get(l_IDX).NodeName = c_vcmForm then
    ParseForm(aNode.ChildNodes.Get(l_IDX));
end;

procedure TtcBuilder.ParseModule(const aNode: IXMLNode; FirstPass: Boolean);
var
 l_IDNode: IXMLNode;
 l_Operations: IXMLNode;
 l_Forms: IXMLNode;
begin
 l_IDNode := aNode.AttributeNodes.FindNode(c_vcmID);
 if Assigned(l_IDNode) then
 begin
  if FirstPass then
  begin
   l_Forms := aNode.ChildNodes.FindNode(c_vcmForm+'s');
   if Assigned(l_Forms) then
    ParseForms(l_Forms);
  end
  else
  begin
   l_Operations := aNode.ChildNodes.FindNode(c_vcmOperation+'s');
   if Assigned(l_Operations) then
    ParseOperations(l_Operations, 'mop_'+tcVarToStr(l_IDNode.NodeValue)+'_',
     f_MainToolBars, tcVarToStr(aNode.Attributes[c_vcmTitle]), '');
  end;
 end
 else
  raise Exception.Create('Cant found modules definition');
end;

procedure TtcBuilder.ParseModules(const aNode: IXMLNode; FirstPass: Boolean);
var
 l_IDX: Integer;
begin
 if Assigned(aNode) then
  for l_IDX := 0 to aNode.ChildNodes.Count - 1 do
   if aNode.ChildNodes.Get(l_IDX).NodeName = c_vcmModule then
    ParseModule(aNode.ChildNodes.Get(l_IDX), FirstPass);
end;

procedure TtcBuilder.ParseOperations(const aNode: IXMLNode;
  const aPrefix: WideString; const aToolBars: ItcToolBarsList;
  const aCaptionPrefix: WideString;
  const aToolBarPrefix: WideString);
var
 l_IDX: Integer;
begin
 if aToolBars.Count = 0 then
  raise EEmptyToolBar.Create('');
 if Assigned(aNode) then
  for l_IDX := 0 to aNode.ChildNodes.Count - 1 do
   if aNode.ChildNodes.Get(l_IDX).NodeName = c_vcmOperation then
    ParseOperation(aNode.ChildNodes.Get(l_IDX), aPrefix, aToolBars, aCaptionPrefix, aToolBarPrefix);
end;

function TtcBuilder.ParseToolBars(const aNode,
  aFormNode: IXMLNode): ItcToolBarsList;
var
 l_IDX: Integer;
 l_ID: WideString;
 l_Title: WideString;
 l_MainNode: IXMLNode;
 l_IsMain: Boolean;
begin
 l_ID := aFormNode.Attributes[c_vcmID];
 Result := TtcToolBarsList.Make;
 l_MainNode := aFormNode.AttributeNodes.FindNode(c_vcmMainForm);
 l_IsMain := Assigned(l_MainNode) and (tcVarToStr(l_MainNode.NodeValue) = '1');
 if Assigned(aNode) then
 begin
  for l_IDX := 0 to aNode.ChildNodes.Count - 1 do
   if aNode.ChildNodes.Get(l_IDX).NodeName = c_vcmUserType then
    ParseToolBar(aNode.ChildNodes.Get(l_IDX), Result, l_IsMain, l_ID)
 end   
 else
 begin
  with Result.Add(l3CStr(l_ID+'_ToolBar')) do
  begin
   l_Title := 'Òףכבאנ פמנלû '+aFormNode.Attributes[c_vcmTitle];
   Caption := l3CStr(l_Title);
  end;
  AddToolBarToLists(Result.ToolBar[0], l_isMain);
 end;
end;

const
 cToolBarTitleFormat = '%s_%s';

procedure TtcBuilder.ParseToolBar(const aNode: IXMLNode;
  const aToolBars: ItcToolBarsList; IsMain: Boolean; const aFormID: WideString);
var
 l_ToolBar: ItcToolBar;
 l_ID: WideString;
 l_TitleNode: IXMLNode;
 l_EditableNode: IXMLNode;
 l_ParentToolBarNode: IXMLNode;
begin
 l_ID := WideFormat(cToolBarTitleFormat, [aFormID, tcVarToStr(aNode.Attributes[c_vcmID])]);
 l_ToolBar := aToolBars.Add(l3CStr(l_ID));
 l_TitleNode := aNode.AttributeNodes.FindNode(c_vcmLongCaption);
 if l_TitleNode = nil then
  l_TitleNode := aNode.AttributeNodes.FindNode(c_vcmTitle);
 l_ToolBar.Caption := l3CStr(tcVarToStr(l_TitleNode.NodeValue));
 l_EditableNode := aNode.AttributeNodes.FindNode(c_vcmEditableUserType);
 l_ToolBar.Editable := Assigned(l_EditableNode) and (tcVarToStr(l_EditableNode.NodeValue) = '1');
 l_ParentToolBarNode := aNode.AttributeNodes.FindNode(c_vcmParentUserType);
 if Assigned(l_ParentToolBarNode) then
 begin
  with aToolBars.Add(l3CStr(WideFormat(cToolBarTitleFormat, [aFormID, tcVarToStr(l_ParentToolBarNode.NodeValue)]))) do
   ChildToolBars.AddExisting(l_ToolBar);
 end;
 AddToolBarToLists(l_ToolBar, IsMain);
end;

procedure TtcBuilder.AddToolBarToLists(const aToolBar: ItcToolBar;
  isMain: Boolean);
begin
 f_Toolbars.AddExisting(aToolBar);
 if f_OldMode then
 begin
  if f_MainToolBars.Count = 0 then
   f_MainToolBars.AddExisting(aToolBar);
 end
 else
  if isMain then
  begin
   Assert(f_MainToolBars.Count = 0);
   f_MainToolBars.AddExisting(aToolBar);
  end;
end;

procedure TtcBuilder.ParseOperation(const aNode: IXMLNode;
  const aPrefix: WideString; const aToolBars: ItcToolBarsList;
  const aCaptionPrefix: WideString;
  const aToolBarPrefix: WideString);
var
 l_Operation: ItcOperation;
 l_ExcludeTypes: Il3StringsEx;
 l_IDX: Integer;
const
 c_OperationFmt = '%s (%s)';
begin
 l_Operation := f_Operations.Add(l3CStr(aPrefix + aNode.Attributes[c_vcmID]));
 l_Operation.Caption := l3CStr(WideFormat(c_OperationFmt,[tcVarToStr(aNode.Attributes[c_vcmTitle]), aCaptionPrefix]));
 l_ExcludeTypes := ParseExcludeUserTypes(aNode.ChildNodes.FindNode(c_vcmExcludeUserTypes), aToolBarPrefix);
 Assert((l_ExcludeTypes.Count = 0) or (aToolBarPrefix <> ''));
 for l_IDX := 0 to aToolBars.Count - 1 do
  if l_ExcludeTypes.IndexOf(aToolBars.ToolBar[l_IDX].ID) = -1 then
   aToolBars.ToolBar[l_IDX].Operations.AddExisting(l_Operation);
end;

function TtcBuilder.ParseExcludeUserTypes(const aNode: IXMLNode;
  const aToolBarPrefix: WideString): Il3StringsEx;
var
 l_Strings: Tl3Strings;
 l_IDX: Integer;
begin
 l_Strings := Tl3Strings.MakeSorted;
 try
  Result := l_Strings;
 finally
  FreeAndNil(l_Strings);
 end;
 if Assigned(aNode) then
  for l_IDX := 0 to aNode.ChildNodes.Count - 1 do
   if aNode.ChildNodes.Get(l_IDX).NodeName = c_vcmUserType then
    Result.Add(l3CStr(WideFormat(cToolBarTitleFormat,[aToolBarPrefix, tcVarToStr(aNode.ChildNodes.Get(l_IDX).Attributes[c_vcmID])])))
end;

procedure TtcBuilder.ParseEntity(const aNode: IXMLNode;
  const aToolBars: ItcToolBarsList; const aToolBarPrefix: WideString);
var
 l_Prefix: WideString;
begin
 l_Prefix := 'op_'+tcVarToStr(aNode.Attributes[c_vcmID])+'_';
 ParseOperations(aNode.ChildNodes.FindNode(c_vcmOperation+'s'), l_Prefix, aToolBars,
  tcVarToStr(aNode.Attributes[c_vcmTitle]), aToolBarPrefix);
end;

end.
