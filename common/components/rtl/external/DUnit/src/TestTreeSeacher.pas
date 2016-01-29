unit TestTreeSeacher;
 {* - поиск в дереве тестов. }

interface

uses
 ComCtrls,

 l3Base,
 l3Types,
 l3Interfaces;

type
 TFindStatus = (fsNotStart, fsFound, fsNotFound);

 TTestTreeSeacher = class
 private
  f_FindStr    : Tl3WString;
   {* - строка для поиска. }
  f_FoundNode  : TTreeNode;
   {* - найденный узел. }
  f_TreeItems  : TTreeNodes;
   {* - массив узлов дерева. }
  f_Table      : Tl3BMTable;
   {* - таблица для поиска. }
  f_FindDown   : Boolean;
   {* - искать вниз. }
  f_FindStatus : TFindStatus;
   {* - состояние поиска. }
  f_FolderMode : Boolean;
   {* - режим поиска по папкам. }
 private
  procedure pm_SetFolderNode(const Value: Boolean);
   {-}
  procedure pm_SetFindDown(const Value: Boolean);
   {-}
  procedure pm_SetFindStr(const Value: Tl3WString);
   {-}
  function GetNextNode(const aNode: TTreeNode): TTreeNode;
   {* - получение следующего узла. }
  procedure pm_SetFoundNode(const Value: TTreeNode);
   {* - результат последнего поиска. }
  procedure ClearFind;
   {-}
 public
  constructor Create(aTreeItems : TTreeNodes);
   {-}
  function Find: Boolean;
   {* - Процедура поиска. }
  function GetStartNode: TTreeNode;
   {* - получения начального узла поиска. }
  destructor Destroy; override;
   {-}
 public
  property aFindStr: Tl3WString read f_FindStr write pm_SetFindStr;
   {-}
  property aFindDown: Boolean read f_FindDown write pm_SetFindDown;
   {-}
  property aFoundNode: TTreeNode read f_FoundNode write pm_SetFoundNode;
   {-}
  property aFindStatus : TFindStatus read f_FindStatus;
   {-}
  property aFolderMode: Boolean read f_FolderMode write pm_SetFolderNode;
   {-}
 end;

implementation

uses
 SysUtils,

 FolderSupport,

 l3String,
 l3BMSearch;

{ TTestTreeSeacher }

procedure TTestTreeSeacher.ClearFind;
begin
 if f_FindStr.S <> nil then
  l3StrDispose(f_FindStr.S);
end;

constructor TTestTreeSeacher.Create(aTreeItems : TTreeNodes);
begin
 f_FindDown := True;
 f_TreeItems := aTreeItems;
 f_FindStatus := fsNotStart;
 f_FolderMode := False;
end;

destructor TTestTreeSeacher.Destroy;
begin
 ClearFind;
 inherited;
end;

function TTestTreeSeacher.Find: Boolean;
var
 l_Node : TTreeNode;

 function lp_CheckNode: Boolean;
 var
  l_Str  : string;
  l_PStr : Tl3PCharLen;
  l_Pos  : Cardinal;
 begin
  l_Str := l_Node.Text;
  l_PStr := l3PCharLen(PChar(@l_Str[1]), Length(l_Str));
  l3MakeUpperCase(l_PStr.S, l_PStr.SLen, l_PStr.SCodePage);
  Result := l3SearchStr(l_PStr, f_Table, f_FindStr, l_Pos);
  if Result then
  begin
   Find := True;
   f_FoundNode := l_Node;
  end; // if Result then
 end; // function lp_CheckNode: Boolean;

begin
 l_Node := GetStartNode;
 Result := False;
 f_FindStatus := fsNotFound;
 while l_Node <> nil do
 begin
  if IsNodeFolder(l_Node) then
  begin
   if aFolderMode then
    if lp_CheckNode then Break;
  end // if IsNodeFolder(aNode) then
  else
   if lp_CheckNode then Break;
  l_Node := GetNextNode(l_Node);
 end; // while l_Node <> nil do
 if Result then
  f_FindStatus := fsFound;
end;

function TTestTreeSeacher.GetNextNode(const aNode: TTreeNode): TTreeNode;
begin
 if f_FindDown then
  Result := aNode.GetNext
 else
  Result := aNode.GetPrev;
end;

function TTestTreeSeacher.GetStartNode: TTreeNode;

 procedure lp_CheckLevel;
 begin
  if Result.Level = 0 then
   Result := Result.GetNext; // Пропускаем начальный узел.
 end;

begin
 Result := f_FoundNode;
 if Result = nil then
 begin
  if f_FindDown then
   Result := f_TreeItems.GetFirstNode
  else
   Result := f_TreeItems[f_TreeItems.Count - 1];
  lp_CheckLevel; 
 end
 else
 begin
  lp_CheckLevel;
  Result := GetNextNode(Result); // Ищем со следующего...
 end;
end;

procedure TTestTreeSeacher.pm_SetFindDown(const Value: Boolean);
begin
 f_FindDown := Value;
 f_FindStatus := fsNotStart;
end;

procedure TTestTreeSeacher.pm_SetFindStr(const Value: Tl3WString);
begin
 ClearFind;
 f_FindStr := l3PCharLen(l3StrNew(Value.S));
 l3MakeUpperCase(f_FindStr.S, f_FindStr.SLen, f_FindStr.SCodePage);
 BMMakeTable(f_FindStr.S, f_Table, f_FindStr.SLen);
 f_FoundNode := nil;
 f_FindStatus := fsNotStart;
end;

procedure TTestTreeSeacher.pm_SetFolderNode(const Value: Boolean);
begin
 f_FolderMode := Value;
 f_FoundNode := nil;
 f_FindStatus := fsNotStart;
end;

procedure TTestTreeSeacher.pm_SetFoundNode(const Value: TTreeNode);
begin
 f_FoundNode := Value;
 f_FindStatus := fsNotStart;
end;

end.
