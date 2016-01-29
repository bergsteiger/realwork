unit tcDifference;

interface

uses
 tcInterfaces
 ;

procedure tcBuildDifference(const aSource, aNew: ItcToolBarsList; OldMode: Boolean;
  out anAddedToolbars: ItcAddedToolBarsList; out aChangedToolBars: ItcChangedToolBarsList);

implementation

uses
 SysUtils,

 l3Base,
 l3Types,
 l3String,

 tcAddedToolBarsList,
 tcChangedToolBarsList
 ;

type
 TtcChange = procedure(const anItem, aParent: ItcItem) of Object;

 TtcComparer = class(Tl3Base)
 private
  f_SourceDesc: ItcToolBarsList;
  f_NewDesc: ItcToolBarsList;
  f_Added: ItcAddedToolBarsList;
  f_Changed: ItcChangedToolBarsList;
  f_ComparingToolBar: ItcChangedToolBar;
  f_OldMode: Boolean;
 private
  procedure ToolBarAdded(const anItem, aParent: ItcItem);
  procedure ToolbarEqual(const anItem, aParent: ItcItem);
  procedure ChildToolBarDeleted(const anItem, aParent: ItcItem);
  procedure ChildToolBarAdded(const anItem, aParent: ItcItem);
  procedure OperationDeleted(const anItem, aParent: ItcItem);
  procedure OperationAdded(const anItem, aParent: ItcItem);
  function ComparingToolBar(const anItem: ItcItem): ItcChangedToolBar;
 private
  property AddedToolBars: ItcAddedToolBarsList
    read f_Added;
  property ChangedToolBars: ItcChangedToolBarsList
    read f_Changed;
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aSource, aNew: ItcToolBarsList; OldMode: Boolean); reintroduce;
 end;

procedure tcBuildDifference(const aSource, aNew: ItcToolBarsList; OldMode: Boolean;
  out anAddedToolbars: ItcAddedToolBarsList; out aChangedToolBars: ItcChangedToolBarsList);
var
 l_Comparer: TtcComparer;
begin
 l_Comparer := TtcComparer.Create(aSource, aNew, OldMode);
 try
  anAddedToolbars := l_Comparer.AddedToolBars;
  aChangedToolBars := l_Comparer.ChangedToolBars;
 finally
  FreeAndNil(l_Comparer);
 end;
end;

procedure DoCompare(const aSource, aTarget: ItcItemList; onDelete, onEqual, onAdd: TtcChange;
  aParent: ItcItem);
var
 l_SourceIDX: Integer;
 l_TargetIDX: Integer;
 l_IDX: Integer;
 l_Comp: Long;
begin
 l_SourceIDX := 0;
 l_TargetIDX := 0;
 repeat
  if l_SourceIDX >= aSource.Count then
  begin
   if Assigned(onAdd) then
    for l_IDX := l_TargetIDX to aTarget.Count - 1 do
     onAdd(aTarget.Item[l_IDX], aParent);
   exit;
  end;
  if l_TargetIDX >= aTarget.Count then
  begin
   if Assigned(onDelete) then
    for l_IDX := l_SourceIDX to aSource.Count - 1 do
     onDelete(aSource.Item[l_IDX], aParent);
   exit;
  end;
  l_Comp := l3Compare(aSource.Item[l_SourceIDX].ID.AsWStr,  aTarget.Item[l_TargetIDX].ID.AsWStr);
  if l_Comp = 0 then
  begin
   if Assigned(onEqual) then
    onEqual(aTarget.Item[l_TargetIDX], aParent);
   Inc(l_SourceIDX);
   Inc(l_TargetIDX);
  end
  else
   if l_Comp < 0 then
   begin
    if Assigned(onDelete) then
     onDelete(aSource.Item[l_SourceIDX], aParent);
    inc(l_SourceIDX);
   end
   else
   begin
    if Assigned(onAdd) then
     onAdd(aTarget.Item[l_TargetIDX], aParent);
    inc(l_TargetIDX);
   end;
 until False;
end;

{ TtcComparer }

procedure TtcComparer.ChildToolBarAdded(const anItem, aParent: ItcItem);
begin
 ComparingToolBar(aParent).AddedChildren.AddExisting(f_NewDesc.Add(anItem.ID));
end;

procedure TtcComparer.ChildToolBarDeleted(const anItem, aParent: ItcItem);
begin
 ComparingToolBar(aParent).DeletedChildren.AddExisting(f_SourceDesc.Add(anItem.ID));
end;

procedure TtcComparer.Cleanup;
begin
 f_SourceDesc := nil;
 f_NewDesc := nil;
 f_Added := nil;
 f_Changed := nil;
 f_ComparingToolBar := nil;
 inherited Cleanup;
end;

function TtcComparer.ComparingToolBar(const anItem: ItcItem): ItcChangedToolBar;
begin
 if f_ComparingToolBar = nil then
 begin
  f_ComparingToolBar := f_Changed.Add(l3Cat([anItem.Caption, anItem.ID]));
  f_ComparingToolBar.ToolBar := f_NewDesc.Add(anItem.ID);
 end;
 Result := f_ComparingToolBar;
end;

constructor TtcComparer.Create(const aSource, aNew: ItcToolBarsList; OldMode: Boolean);
begin
 inherited Create;
 f_SourceDesc := aSource;
 f_NewDesc := aNew;
 f_Added := TtcAddedToolBarsList.Make;
 f_Changed := TtcChangedToolBarsList.Make;
 f_OldMode := OldMode;
 DoCompare(f_SourceDesc as ItcItemList, f_NewDesc as ItcItemList, nil, ToolbarEqual, ToolBarAdded, nil);
end;

procedure TtcComparer.OperationAdded(const anItem, aParent: ItcItem);
begin
 ComparingToolBar(aParent).AddedOperations.AddExisting(f_NewDesc.Add(aParent.ID).Operations.Add(anItem.ID));
end;

procedure TtcComparer.OperationDeleted(const anItem, aParent: ItcItem);
begin
 ComparingToolBar(aParent).DeletedOperations.AddExisting(f_SourceDesc.Add(aParent.ID).Operations.Add(anItem.ID));
end;

procedure TtcComparer.ToolBarAdded(const anItem, aParent: ItcItem);
begin
 with f_Added.Add(l3Cat([anItem.Caption, anItem.ID])) do
  ToolBar := f_NewDesc.Add(anItem.ID);
end;

procedure TtcComparer.ToolbarEqual(const anItem, aParent: ItcItem);
const
 c_Map: array [Boolean] of TtcEditableChange = (ecRevokeEditable, ecBecomeEditable);
begin
 f_ComparingToolBar := nil;
 if not f_OldMode then
  if f_SourceDesc.Add(anItem.ID).Editable xor f_NewDesc.Add(anItem.ID).Editable then
   ComparingToolBar(anItem).EditableChange := c_Map[f_NewDesc.Add(anItem.ID).Editable];
 if l3Compare(f_SourceDesc.Add(anItem.ID).Caption.AsWStr, f_NewDesc.Add(anItem.ID).Caption.AsWStr) <> 0 then
  ComparingToolBar(anItem).OldCaption := f_SourceDesc.Add(anItem.ID).Caption;
 if not f_OldMode then
  DoCompare(f_SourceDesc.Add(anItem.ID).ChildToolBars as ItcItemList, f_NewDesc.Add(anItem.ID).ChildToolBars as ItcItemList,
    ChildToolBarDeleted, nil, ChildToolBarAdded, anItem);
 DoCompare(f_SourceDesc.Add(anItem.ID).Operations as ItcItemList, f_NewDesc.Add(anItem.ID).Operations as ItcItemList,
   OperationDeleted, nil, OperationAdded, anItem);
end;

end.
