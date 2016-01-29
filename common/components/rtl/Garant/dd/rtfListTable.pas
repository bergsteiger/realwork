unit rtfListTable;
{ Таблица списков для чтения из RTF }

interface

uses
 l3Base,
 l3Memory,
 l3LongintList,
 l3ProtoObject,
 l3ProtoObjectRefList,
 
 ddCharacterProperty;

type
 TrtfListLevel = class(Tl3ProtoObject)
 private
  f_CHP: TddCharacterProperty;
  f_CurNumber: Integer;
  f_Follow: Integer;
  f_Justify: Integer;
  f_LevelJC: Integer;
  f_LevelJCN: Integer;
  f_LevelNFC: Integer;
  f_LevelNFCN: Integer;
  f_Numbers: AnsiString;
  f_NumberType: Integer;
  f_StartAt: Integer;
  f_Text: AnsiString;
  f_UnicodeText : Tl3String;
 private
  function pm_GetCurNumber: Integer;
  function pm_GetNextNumber: Integer;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure Restart;
  property CHP: TddCharacterProperty read f_CHP;
  property CurNumber: Integer read pm_GetCurNumber;
  property Follow: Integer read f_Follow write f_Follow;
  property Justify: Integer read f_Justify write f_Justify;
  property LevelJC: Integer read f_LevelJC write f_LevelJC;
  property LevelJCN: Integer read f_LevelJCN write f_LevelJCN;
  property LevelNFC: Integer read f_LevelNFC write f_LevelNFC;
  property LevelNFCN: Integer read f_LevelNFCN write f_LevelNFCN;
  property NextNumber: Integer read pm_GetNextNumber;
  property Numbers: AnsiString read f_Numbers write f_Numbers;
  property NumberType: Integer read f_NumberType write f_NumberType;
  property StartAt: Integer read f_StartAt write f_StartAt;
  property Text: AnsiString read f_Text write f_Text;
  property UnicodeText: Tl3String read f_UnicodeText write f_UnicodeText;
 end;

 TrtfList = class(Tl3ProtoObjectRefList)
 private
  f_ID: Integer;
  f_ListName: AnsiString;
  f_TemplateID: Integer;
 private 
  function pm_GetLevels(Index: Integer): TrtfListLevel;
 public
  procedure RestartAt(const aStartList: Tl3LongintList);
  procedure GetNumberAndNFC(anIndex, aLevel: Integer; out aNumber, aLevelNFC: Integer);
  procedure AddLevel(aLevel: TrtfListLevel);
  property ID: Integer read f_ID write f_ID;
  property Levels[Index: Integer]: TrtfListLevel read pm_GetLevels; default;
  property ListName: AnsiString read f_ListName write f_ListName;
  property TemplateID: Integer read f_TemplateID write f_TemplateID;
 end;

 TrtfListTable = class(Tl3ProtoObjectRefList)
 private
  function pm_GetLists(Index: Integer): TrtfList;
 public
  procedure AddList(aList: TrtfList);
  property Lists[Index: Integer]: TrtfList read pm_GetLists; default;
 end;

 TrtfListOverride = class(Tl3ProtoObject)
 private
  f_ListID: Integer;
  f_ListOverrideCount: Integer;
  f_LS: Integer;
  f_StartAt: Tl3LongintList;
 private
  function GetStartAt(anIndex: Integer): Integer;
 protected
  procedure Cleanup; override;
 public
  procedure Assign(anList: TrtfListOverride);
  procedure Clear;
  constructor Create;
  property ListID: Integer read f_ListID write f_ListID;
  property ListOverrideCount: Integer read f_ListOverrideCount write
      f_ListOverrideCount;
  property LS: Integer read f_LS write f_LS;
  function GetStartAtCount: Integer;
  property StartAtList: Tl3LongintList read f_StartAt;
  procedure AddStartAt(aValue: Integer);
 end;

 TrtfListOverrideTable = class(Tl3ProtoObjectRefList)
 end;    

implementation

uses
  SysUtils;

procedure TrtfList.AddLevel(aLevel: TrtfListLevel);
var
 l_Level: TrtfListLevel;
begin
 l_Level := TrtfListLevel.Create;
 try
  l_Level.CHP.AssignFrom(aLevel.CHP);
  l_Level.Follow := aLevel.Follow;
  l_Level.Justify := aLevel.Justify;
  l_Level.LevelJC := aLevel.LevelJC;
  l_Level.LevelJCN := aLevel.LevelJCN;
  l_Level.LevelNFC := aLevel.LevelNFC;
  l_Level.LevelNFCN := aLevel.LevelNFCN;
  l_Level.Numbers := aLevel.Numbers;
  l_Level.NumberType := aLevel.NumberType;
  l_Level.StartAt := aLevel.StartAt;
  l_Level.Text := aLevel.Text;
  l_Level.UnicodeText.AssignString(aLevel.UnicodeText);
  Add(l_Level);
 finally
  FreeAndNil(l_Level);
 end;
end;

procedure TrtfList.GetNumberAndNFC(anIndex, aLevel: Integer; out aNumber, aLevelNFC: Integer);
const
 cnErrorValue = 256; // Игнорируем значение - какая-то фигня: http://mdp.garant.ru/pages/viewpage.action?pageId=605147298
var
 i             : Integer;
 l_CurrentLevel: Integer;
begin
 l_CurrentLevel := Ord(Levels[aLevel].Numbers[anIndex]);
 if l_CurrentLevel >= Count then
 begin
  aLevelNFC := cnErrorValue;
  aNumber := 0;
  Exit;
 end // if l_CurrentLevel >= Count then
 else
 if l_CurrentLevel <> aLevel then
  aNumber := Levels[l_CurrentLevel].CurNumber
 else
 begin
  aNumber := Levels[l_CurrentLevel].NextNumber;
  for i := l_CurrentLevel + 1 to Count - 1 do
   Levels[i].Restart;
 end;
 aLevelNFC := Levels[l_CurrentLevel].LevelNFC;
end;

function TrtfList.pm_GetLevels(Index: Integer): TrtfListLevel;
begin
 Result := Items[Index] as TrtfListLevel;
end;

procedure TrtfListTable.AddList(aList: TrtfList);
var
 l_List: TrtfList;
 i: Integer;
begin
 l_List := TrtfList.Make;
 try
  l_List.ID := aList.ID;
  l_List.ListName := aList.ListName;
  l_List.TemplateID := aList.TemplateID;
  for i := 0 to aList.Hi do
   l_List.AddLevel(aList.Levels[i]);
  Add(l_List);
 finally
  FreeAndNil(l_List);
 end;
end;

function TrtfListTable.pm_GetLists(Index: Integer): TrtfList;
begin
 Result := Items[Index] as TrtfList;
end;

constructor TrtfListLevel.Create;
begin
 inherited Create;
 f_CHP := TddCharacterProperty.Create;
 f_CurNumber := 0;
 f_StartAt := 1;
 f_UnicodeText := Tl3String.Create;
end;

procedure TrtfListLevel.Cleanup;
begin
 inherited;
 FreeAndNil(f_UnicodeText);
 FreeAndNil(f_CHP);
end;

function TrtfListLevel.pm_GetCurNumber: Integer;
begin
 if f_CurNumber = 0 then
  Result := StartAt
 else
  Result := f_CurNumber;
end;

function TrtfListLevel.pm_GetNextNumber: Integer;
begin
 if f_CurNumber = 0 then
  f_CurNumber := StartAt
 else
  Inc(f_CurNumber);
 Result := f_CurNumber;
end;

procedure TrtfListLevel.Restart;
begin
 f_CurNumber := 0;
end;

{ TrtfListOverride }

procedure TrtfListOverride.AddStartAt(aValue: Integer);
begin
 f_StartAt.Add(aValue);
end;

procedure TrtfListOverride.Assign(anList: TrtfListOverride);
var
 i: Integer;
begin
 ListID := anList.ListID;
 ListOverrideCount := anList.ListOverrideCount;
 LS := anList.LS;
 f_StartAt.Assign(anList.f_StartAt);
end;

procedure TrtfListOverride.Cleanup;
begin
 Clear;
 FreeAndNil(f_StartAt);
 inherited;
end;

procedure TrtfListOverride.Clear;
begin
 f_ListID := -1;
 f_ListOverrideCount := 0;
 f_LS := -1;
 f_StartAt.Clear;
end;

constructor TrtfListOverride.Create;
begin
 inherited Create;
 f_StartAt := Tl3LongintList.Create;
 Clear;
end;

procedure TrtfList.RestartAt(const aStartList: Tl3LongintList);
var
 i      : Integer;
 l_Level: TrtfListLevel;
begin
 for i := 0 to Count - 1 do
 begin
  l_Level := Levels[i];
  if i < aStartList.Count then
  begin
   l_Level.StartAt := aStartList[i];
   l_Level.Restart;
  end // if i < aStartList.Count then
  else
   Break;
 end; // for i := 0 to Count - 1 do
end;

function TrtfListOverride.GetStartAt(anIndex: Integer): Integer;
begin
 Result := f_StartAt[anIndex];
end;

function TrtfListOverride.GetStartAtCount: Integer;
begin
 Result := f_StartAt.Count;
end;

end.
