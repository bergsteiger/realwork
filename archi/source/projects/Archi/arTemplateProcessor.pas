unit arTemplateProcessor;

{ $Id: arTemplateProcessor.pas,v 1.24 2015/04/07 09:08:05 lukyanets Exp $ }

interface
uses
 l3Types,
 l3Stream,
 l3ProtoObject,
 l3Except,
 l3ValLst,
 k2Interfaces,

 DT_Types, Classes;

const
 c_TemplatesFN = 'templates.xml';
type
 EarAbortTemplate = class(El3Abort);
 TarOnGetInteractiveValue = function(const aName: AnsiString; out theResult: AnsiString): Boolean of object;

 TarTemplateDataRec = packed record
  rDocID   : TDocID;
  rRelID   : TDocID;
  rSubNum  : Integer;
  rSubName : AnsiString;
 end;

 TarTemplateProcessor = class(Tl3ProtoObject)
 private
  f_CurrentSubName: AnsiString;
  f_CurrentSubNum: Integer;
  f_CurrentTag: Tl3Variant;
  f_FromDocRec: TarTemplateDataRec;
  f_OnGetInteractiveValue: TarOnGetInteractiveValue;
  function ApplyModifier(const aStr: AnsiString; aModifier: AnsiString): AnsiString;
  function GetFirstWord(const aSubName: AnsiString): AnsiString;
  function GetInteractiveValue(const aElementName: AnsiString): AnsiString;
  function GetValue(const aElementName: AnsiString): AnsiString;
  function pm_GetCurrentFSubName: AnsiString;
  function pm_GetCurrentSubName: AnsiString;
  function pm_GetCurrentSubNum: Integer;
  procedure RetrieveSubData;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aCurrentTag: Tl3Variant; const aFromRec: TarTemplateDataRec);
  function Process(const aTemplate: AnsiString): AnsiString;
  property CurrentFSubName: AnsiString read pm_GetCurrentFSubName;
  property CurrentSubName: AnsiString read pm_GetCurrentSubName;
  property CurrentSubNum: Integer read pm_GetCurrentSubNum;
  property OnGetInteractiveValue: TarOnGetInteractiveValue read f_OnGetInteractiveValue write f_OnGetInteractiveValue;
 end;

 TarTemplateStorage = class(Tl3ProtoObject)
 private
  f_Template: AnsiString;
  f_TemplateData: TarTemplateDataRec;
  f_SavedTemplates: Tl3ValueList;
  function CreateFileStream(aMode: Tl3FileMode): Tl3FileStream;
  procedure Save;
  procedure Load;
  function pm_GetSavedTemplate(aName: AnsiString): AnsiString;
  procedure pm_SetSavedTemplate(aName: AnsiString; const Value: AnsiString);
  procedure pm_SetTemplate(const Value: AnsiString);
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  function GetFileName: AnsiString;
  {$IFDEF nsTest}
  procedure ClearStorate;
  {$ENDIF nsTest}
  procedure FillListWithSavedTemplateNames(const aList: TStrings);
  procedure DeleteSavedTemplate(const aName: AnsiString);
  property SavedTemplate[aName: AnsiString]: AnsiString read pm_GetSavedTemplate write pm_SetSavedTemplate;
  property Template: AnsiString read f_Template write pm_SetTemplate;
  property TemplateData: TarTemplateDataRec read f_TemplateData write f_TemplateData;
 end;

 procedure RetrieveCurrentSubData(aCurrentTag: Tl3Variant; out theCurrentSubNum: Integer; out theCurrentSubName: AnsiString);

 function GetTemplateStorage: TarTemplateStorage;

implementation
uses
 SysUtils,
 l3String,
 l3RegEx,
 l3DictionaryPrim,
 l3LingLib,
 l3Chars,

 JclSimpleXml,

 k2Tags,
 k2Const,
 evdTypes,
 nevTools,

 LeafPara_Const,
 Block_Const,

 daDataProvider
 , l3Variant;
 

var
 g_TemplateStorage: TarTemplateStorage = nil;

function GetTemplateStorage: TarTemplateStorage;
begin
 if g_TemplateStorage = nil then
  g_TemplateStorage := TarTemplateStorage.Create;
 Result := g_TemplateStorage;
end;


constructor TarTemplateProcessor.Create(aCurrentTag: Tl3Variant; const aFromRec: TarTemplateDataRec);
begin
 inherited Create;
 aCurrentTag.Setref(f_CurrentTag);
 f_FromDocRec := aFromRec;
end;

function TarTemplateProcessor.ApplyModifier(const aStr: AnsiString; aModifier: AnsiString): AnsiString;
begin
 aModifier := AnsiLowerCase(aModifier);

 if aModifier = 'род' then
  Result := mlmaRusDeclensionStr(aStr, rdRodit)
 else
 if aModifier = 'дат' then
  Result := mlmaRusDeclensionStr(aStr, rdDatel)
 else
 if aModifier = 'вин' then
  Result := mlmaRusDeclensionStr(aStr, rdVinit)
 else
 if aModifier = 'твор' then
  Result := mlmaRusDeclensionStr(aStr, rdTvorit)
 else
 if aModifier = 'пред' then
  Result := mlmaRusDeclensionStr(aStr, rdPredl)
 else
  Result := aStr;
end;

function TarTemplateProcessor.GetInteractiveValue(const aElementName: AnsiString): AnsiString;
begin
 if Assigned(f_OnGetInteractiveValue) then
 begin
  if not f_OnGetInteractiveValue(aElementName, Result) then
   raise EarAbortTemplate.Create('Вставка шаблона прервана пользователем!');
 end
 else
  Result := '';
end;

function TarTemplateProcessor.GetValue(const aElementName: AnsiString): AnsiString;
begin
 if AnsiSameText(aElementName, 'subname') then
  Result := CurrentSubName
 else

 if AnsiSameText(aElementName, 'subfname') then
  Result := CurrentFSubName
 else

 if AnsiSameText(aElementName, 'subnum') then
  Result := IntToStr(CurrentSubNum)
 else

 if AnsiSameText(aElementName, 'fromdoc') then
 begin
  if f_FromDocRec.rDocID <= 0 then
   Result := GetInteractiveValue('Номер ссылающегося топика')
  else
   Result := IntToStr(f_FromDocRec.rDocID);
 end
 else

 if AnsiSameText(aElementName, 'fromreldoc') then
 begin
  if f_FromDocRec.rRelID <= 0 then
   Result := GetInteractiveValue('Номер справки ссылающегося топика')
  else
   Result := IntToStr(f_FromDocRec.rRelID);
 end
 else

 if AnsiSameText(aElementName, 'fromsubnum') then
 begin
  if f_FromDocRec.rSubNum <= 0 then
   Result := GetInteractiveValue('Номер саба ссылающегося топика')
  else
   Result := IntToStr(f_FromDocRec.rSubNum);
 end
 else

 if AnsiSameText(aElementName, 'fromsubname') then
 begin
  if f_FromDocRec.rSubName = '' then
   Result := GetInteractiveValue('Имя саба ссылающегося топика')
  else
   Result := f_FromDocRec.rSubName;
 end
 else

 if AnsiSameText(aElementName, 'fromsubfname') then
 begin
  if f_FromDocRec.rSubName = '' then
   Result := GetInteractiveValue('Первое слово из имени саба ссылающегося топика')
  else
   Result := GetFirstWord(f_FromDocRec.rSubName);
 end

 else
  Result := '';
end;

function TarTemplateProcessor.pm_GetCurrentSubName: AnsiString;
begin
 if f_CurrentSubName = '' then
  RetrieveSubData;
 if f_CurrentSubName <> '~' then
  Result := f_CurrentSubName
 else
  Result := '';
end;

function TarTemplateProcessor.pm_GetCurrentSubNum: Integer;
begin
 if f_CurrentSubNum = 0 then
  RetrieveSubData;
 if f_CurrentSubNum > 0 then
  Result := f_CurrentSubNum
 else
  Result := 0;
end;

function TarTemplateProcessor.Process(const aTemplate: AnsiString): AnsiString;
var
 I: Integer;
 l_Element: AnsiString;
 l_ElementName: AnsiString;
 l_MP: Tl3MatchPosition;
 l_ReplaceStr: AnsiString;
 l_RS: Tl3RegularSearch;
begin
 l_RS := Tl3RegularSearch.Create;
 try
  l_RS.SearchPattern := '\%\%?{\c+}(:{\c+})*\%';
  l_RS.IgnoreCase := True;
  Result := aTemplate;
  while l_RS.SearchInString(Result, l_MP) do
  begin
   l_Element := Copy(Result, l_MP.StartPos+1, 2);
   l_ElementName := l3Str(l_RS.TagParts.ItemW[0]);
   if l_Element = '%%' then
    l_ReplaceStr := GetInteractiveValue(l_ElementName)
   else
    l_ReplaceStr := GetValue(l_ElementName);
   if l_RS.TagParts.Count > 1 then
   begin
    for I := 1 to l_RS.TagParts.Count-1 do
     l_ReplaceStr := ApplyModifier(l_ReplaceStr, l3Str(l_RS.TagParts.ItemW[I]));
   end;

   Delete(Result, l_MP.StartPos + 1, l_MP.Length);
   Insert(l_ReplaceStr, Result, l_MP.StartPos + 1);
  end;
 finally
  FreeAndNil(l_RS);
 end;
end;

procedure TarTemplateProcessor.Cleanup;
begin
 FreeAndNil(f_CurrentTag);
 inherited;
end;

function TarTemplateProcessor.GetFirstWord(const aSubName: AnsiString): AnsiString;
var
 l_Pos: Integer;
begin
 Result := aSubName;
 l_Pos := l3GetPosCharSet(PAnsiChar(Result), cc_WordDelimANSISet);
 if l_Pos > 0 then
  Delete(Result, l_Pos + 1, Maxint);
end;

function TarTemplateProcessor.pm_GetCurrentFSubName: AnsiString;
begin
 Result := GetFirstWord(CurrentSubName);
end;

procedure TarTemplateProcessor.RetrieveSubData;
begin
 RetrieveCurrentSubData(f_CurrentTag, f_CurrentSubNum, f_CurrentSubName);
 if (f_CurrentSubNum = 0) and (f_CurrentSubName = '') then
 begin
  f_CurrentSubName := '~';
  f_CurrentSubNum  := -1;
 end;
end;


// Переводит имя саба в нижний регистр, не трогая римские цифры
function LowerCaseSubName(const aName: AnsiString): AnsiString;
var
 I: Integer;
begin
 Result := AnsiLowerCase(aName);
 for I := 1 to Length(aName) do
  if aName[I] in ['I','V','M','X','L','C','D'] then
   Result[I] := aName[I];
end;

procedure RetrieveCurrentSubData(aCurrentTag      : Tl3Variant;
                                   out theCurrentSubNum : Integer;
                                   out theCurrentSubName: AnsiString);
var
 l_Sub: Tl3Variant;
 l_Tag: Tl3Variant;

 procedure GotoPrevParaOrBlock;
 var
  l_Parent: Tl3Variant;
  l_Idx   : Integer;
 begin
  l_Parent := l_Tag.Owner;
  if l_Parent <> nil then
  begin
   l_Idx := l_Parent.AsObject.IndexOfChild(l_Tag.AsObject);
   if l_Idx > 0 then
    l_Tag := l_Parent.Child[l_Idx - 1]
   else
    l_Tag := l_Parent;
  end
  else
   l_Tag := nil;
 end;

begin
 l_Tag := aCurrentTag;
 theCurrentSubName := '';
 theCurrentSubNum  := 0;
 while l_Tag <> nil do
 begin
  if l_Tag.IsKindOf(k2_typLeafPara) then
  begin
   l_Sub := l_Tag.rAtomEx([k2_tiSubs, k2_tiChildren, k2_tiHandle, Ord(ev_sbtSub), k2_tiChildren, k2_tiByIndex, 0]);
   if l_Sub.IsValid then
   begin
    theCurrentSubNum  := l_Sub.IntA[k2_tiHandle];
    theCurrentSubName := LowerCaseSubName(l_Sub.StrA[k2_tiShortName]);
    Break;
   end // if l_Sub.IsValid then
   else
    GotoPrevParaOrBlock;
  end
  else
   if l_Tag.IsKindOf(k2_typBlock) then
   begin
    theCurrentSubNum := l_Tag.IntA[k2_tiHandle];
    theCurrentSubName := LowerCaseSubName(l_Tag.StrA[k2_tiShortName]);
    Break;
   end
   else
    GotoPrevParaOrBlock;
 end;
end;

constructor TarTemplateStorage.Create;
begin
 inherited;
 f_SavedTemplates := Tl3ValueList.Create;
 Load;
end;

procedure TarTemplateStorage.Cleanup;
begin
 FreeAndNil(f_SavedTemplates);
 inherited;
end;

function TarTemplateStorage.CreateFileStream(aMode: Tl3FileMode): Tl3FileStream;
var
 l_FileName: AnsiString;
begin
 Result := nil;
 l_FileName := GetFileName;
 if not FileExists(l_Filename) and (aMode = l3_fmRead) then
  Exit;
 Result := Tl3FileStream.Create(l_Filename, aMode); 
end;

procedure TarTemplateStorage.FillListWithSavedTemplateNames(const aList: TStrings);
var
 I: Integer;
 l_NS: Tl3NamedString;
begin
 Assert(aList <> nil);
 aList.Clear;
 for I := 0 to f_SavedTemplates.Count-1 do
 begin
  l_NS := Tl3NamedString(f_SavedTemplates.Items[I]);
  aList.Add(l_NS.AsString);
 end;
end;

procedure TarTemplateStorage.Load;
var
 l_CT : TJclSimpleXMLElem;
 l_XML: TJclSimpleXML;
 l_FS : Tl3FileStream;
 I    : Integer;
 l_Name: AnsiString;
 l_SavedRoot, l_Item: TJclSimpleXMLElem;
begin
 l_FS := CreateFileStream(l3_fmRead);
 try
  if l_FS <> nil then
  begin
   l_XML := TJclSimpleXML.Create;
   try
    l_XML.LoadFromStream(l_FS);
    l_CT := l_XML.Root.Items.ItemNamed['current'];
    if l_CT <> nil then
    begin
     l_CT := l_CT.Items[0];
     if l_CT <> nil then
      f_Template := l_CT.AnsiValue;
    end;
    l_SavedRoot := l_XML.Root.Items.ItemNamed['saved'];
    if (l_SavedRoot <> nil) and (l_SavedRoot.Items.Count > 0) then
    begin
     for I := 0 to l_SavedRoot.Items.Count-1 do
     begin
      l_Item := l_SavedRoot.Items[I];
      l_Name := l_Item.Properties.Value('name');
      if l_Name <> '' then
      begin
       l_CT := l_Item.Items[0];
       if l_CT <> nil then
        f_SavedTemplates.Values[l_Name] := l_CT.AnsiValue;
      end;
     end;
    end;
   finally
    FreeAndNil(l_XML);
   end;
  end;
 finally
  FreeAndNil(l_FS);
 end;
end;

function TarTemplateStorage.pm_GetSavedTemplate(aName: AnsiString): AnsiString;
begin
 Result := f_SavedTemplates.Values[aName];
end;

procedure TarTemplateStorage.pm_SetSavedTemplate(aName: AnsiString; const Value: AnsiString);
begin
 f_SavedTemplates.Values[aName] := Value;
 Save;
end;

procedure TarTemplateStorage.pm_SetTemplate(const Value: AnsiString);
begin
 f_Template := Value;
 Save;
end;

procedure TarTemplateStorage.Save;
var
 I: Integer;
 l_CT: TJclSimpleXMLElem;
 l_SavedRoot: TJclSimpleXMLElem;
 l_XML : TJclSimpleXML;
 l_FS: Tl3FileStream;
 l_NS: Tl3NamedString;
begin
 l_XML := TJclSimpleXml.Create;
 try
  l_XML.Prolog.Encoding := 'utf-8';
  l_XML.Root.Name := 'root';
  l_CT := l_XML.Root.Items.Add('current');
  l_CT.Items.AddCData('', f_Template);

  l_SavedRoot := l_XML.Root.Items.Add('saved');
  for I := 0 to f_SavedTemplates.Count - 1 do
  begin
   l_NS := Tl3NamedString(f_SavedTemplates.Items[I]);
   l_CT := l_SavedRoot.Items.Add('item');
   l_CT.Properties.Add('name', l_NS.AsString);
   l_CT.Items.AddCData('', l_NS.Value);
  end;

  l_FS := CreateFileStream(l3_fmWrite);
  try
   l_XML.SaveToStream(l_FS);
  finally
   FreeAndNil(l_FS);
  end;
 finally
  FreeAndNil(l_XML);
 end;
end;

procedure TarTemplateStorage.DeleteSavedTemplate(const aName: AnsiString);
var
 l_Idx: Integer;
begin
 if f_SavedTemplates.FindData(aName, l_Idx) then
 begin
  f_SavedTemplates.Delete(l_Idx);
  Save;
 end;
end;

{$IFDEF nsTest}
procedure TarTemplateStorage.ClearStorate;
begin
 f_Template := '';
 f_SavedTemplates.Clear;
 Load;
end;
{$ENDIF nsTest}

function TarTemplateStorage.GetFileName: AnsiString;
begin
 Result := GlobalDataProvider.CurHomePath + c_TemplatesFN;
end;


initialization

finalization
 FreeAndNil(g_TemplateStorage);
end.
