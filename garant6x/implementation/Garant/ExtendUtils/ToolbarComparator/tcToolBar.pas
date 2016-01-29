unit tcToolBar;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItem
 ;

type
 TtcToolBar = class(TtcItem,
                    ItcToolBar)
 private
  f_Operations: ItcOperationsList;
  f_ChildToolBars: ItcToolBarsList;
  f_Editable: Boolean;
 protected
 // ItcToolBar
  function pm_GetChildToolBars: ItcToolBarsList;
  function pm_GetOperations: ItcOperationsList;
  function pm_GetEditable: Boolean;
  procedure pm_SetEditable(aValue: Boolean);
 protected
  procedure Cleanup; override;
 public
  class function Make(const anID: Il3CString): ItcToolBar;
 end;

implementation

uses
 SysUtils,
 
 tcOperationsList,
 tcToolBarsList
 ;

{ TtcToolBar }

procedure TtcToolBar.Cleanup;
begin
 f_Operations := nil;
 f_ChildToolBars := nil;
 inherited Cleanup;
end;

class function TtcToolBar.Make(const anID: Il3CString): ItcToolBar;
var
 l_Instance: TtcToolBar;
begin
 l_Instance := Create(anID);
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcToolBar.pm_GetChildToolBars: ItcToolBarsList;
begin
 if f_ChildToolBars = nil then
  f_ChildToolBars := TtcToolBarsList.Make;
 Result := f_ChildToolBars;
end;

function TtcToolBar.pm_GetEditable: Boolean;
begin
 Result := f_Editable;
end;

function TtcToolBar.pm_GetOperations: ItcOperationsList;
begin
 if f_Operations = nil then
  f_Operations := TtcOperationsList.Make;
 Result := f_Operations;
end;

procedure TtcToolBar.pm_SetEditable(aValue: Boolean);
begin
 f_Editable := aValue;
end;

end.
