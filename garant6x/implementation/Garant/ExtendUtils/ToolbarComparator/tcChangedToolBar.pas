unit tcChangedToolBar;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItem
 ;

type
 TtcChangedToolBar = class(TtcItem,
                           ItcChangedToolBar)
 private
  f_EditableChange: TtcEditableChange;
  f_DeletedChildren: ItcToolBarsList;
  f_AddedChildren: ItcToolBarsList;
  f_DeletedOperations: ItcOperationsList;
  f_AddedOperations: ItcOperationsList;
  f_ToolBar: ItcToolBar;
  f_OldCaption: Il3CString;
 protected
 // ItcChangedToolBar
  function pm_GetOldCaption: Il3CString;
  procedure pm_SetOldCaption(const aValue: Il3CString);
  function pm_GetEditableChange: TtcEditableChange;
  procedure pm_SetEditableChange(aValue: TtcEditableChange);
  function pm_GetDeletedChildren: ItcToolBarsList;
  function pm_GetAddedChildren: ItcToolBarsList;
  function pm_GetDeletedOperations: ItcOperationsList;
  function pm_GetAddedOperations: ItcOperationsList;
  function pm_GetToolBar: ItcToolBar;
  procedure pm_SetToolBar(const aToolBar: ItcToolBar);
 protected
  procedure Cleanup; override;
 public
  class function Make(const anID: Il3CString): ItcChangedToolBar;
 end;

implementation

uses
 SysUtils,
 
 tcOperationsList,
 tcToolBarsList
 ;

{ TtcChangedToolBar }

procedure TtcChangedToolBar.Cleanup;
begin
 f_DeletedChildren := nil;
 f_AddedChildren := nil;
 f_DeletedOperations := nil;
 f_AddedOperations := nil;
 f_ToolBar := nil;
 f_OldCaption := nil;
 inherited Cleanup;
end;

class function TtcChangedToolBar.Make(
  const anID: Il3CString): ItcChangedToolBar;
var
 l_Instance: TtcChangedToolBar;
begin
 l_Instance := Create(anID);
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcChangedToolBar.pm_GetAddedChildren: ItcToolBarsList;
begin
 if f_AddedChildren = nil then
  f_AddedChildren := TtcToolBarsList.Make;
 Result := f_AddedChildren;
end;

function TtcChangedToolBar.pm_GetAddedOperations: ItcOperationsList;
begin
 if f_AddedOperations = nil then
  f_AddedOperations := TtcOperationsList.Make;
 Result := f_AddedOperations;
end;

function TtcChangedToolBar.pm_GetDeletedChildren: ItcToolBarsList;
begin
 if f_DeletedChildren = nil then
  f_DeletedChildren := TtcToolBarsList.Make;
 Result := f_DeletedChildren;
end;

function TtcChangedToolBar.pm_GetDeletedOperations: ItcOperationsList;
begin
 if f_DeletedOperations = nil then
  f_DeletedOperations := TtcOperationsList.Make;
 Result := f_DeletedOperations;
end;

function TtcChangedToolBar.pm_GetEditableChange: TtcEditableChange;
begin
 Result := f_EditableChange;
end;

function TtcChangedToolBar.pm_GetOldCaption: Il3CString;
begin
 Result := f_OldCaption;
end;

function TtcChangedToolBar.pm_GetToolBar: ItcToolBar;
begin
 Result := f_ToolBar;
end;

procedure TtcChangedToolBar.pm_SetEditableChange(
  aValue: TtcEditableChange);
begin
 f_EditableChange := aValue;
end;

procedure TtcChangedToolBar.pm_SetOldCaption(const aValue: Il3CString);
begin
 f_OldCaption := aValue;
end;

procedure TtcChangedToolBar.pm_SetToolBar(const aToolBar: ItcToolBar);
begin
 f_ToolBar := aToolBar;
end;

end.
