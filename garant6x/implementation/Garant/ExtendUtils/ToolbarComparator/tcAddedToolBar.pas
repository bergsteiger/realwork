unit tcAddedToolBar;

interface

uses
 l3Interfaces,

 tcInterfaces,
 tcItem
 ;

type
 TtcAddedToolBar = class(TtcItem,
                         ItcAddedToolBar)
 private
  f_ToolBar: ItcToolBar;
 protected
 // ItcAddedToolBar
  function pm_GetToolBar: ItcToolBar;
  procedure pm_SetToolBar(const aToolBar: ItcToolBar);
 protected
  procedure Cleanup; override;
 public
  class function Make(const anID: Il3CString): ItcAddedToolBar;
 end;

implementation

uses
 SysUtils
 ;

{ TtcAddedToolBar }

procedure TtcAddedToolBar.Cleanup;
begin
 f_ToolBar := nil;
 inherited Cleanup;
end;

class function TtcAddedToolBar.Make(
  const anID: Il3CString): ItcAddedToolBar;
var
 l_Instance: TtcAddedToolBar;
begin
 l_Instance := Create(anID);
 try
  Result := l_Instance;
 finally
  FreeAndNil(l_Instance);
 end;
end;

function TtcAddedToolBar.pm_GetToolBar: ItcToolBar;
begin
 Result := f_ToolBar;
end;

procedure TtcAddedToolBar.pm_SetToolBar(const aToolBar: ItcToolBar);
begin
 f_ToolBar := aToolBar;
end;

end.
