unit tcItem;

interface

uses
 l3Interfaces,
 l3CacheableBase,

 tcInterfaces;

type
 TtcItem = class(Tl3CacheableBase,
                 ItcItem)
 private
  f_ID: Il3CString;
  f_Caption: Il3CString;
 protected
  // ItcItem
  function pm_GetID: Il3CString;
  function pm_GetCaption: Il3CString;
  procedure pm_SetCaption(const aValue: Il3CString);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const anID: Il3CString); reintroduce;
 end;

implementation

{ TtcItem }

procedure TtcItem.Cleanup;
begin
 f_ID := nil;
 f_Caption := nil;
 inherited Cleanup;
end;

constructor TtcItem.Create(const anID: Il3CString);
begin
 inherited Create;
 f_ID := anID;
end;

function TtcItem.pm_GetCaption: Il3CString;
begin
 Result := f_Caption;
end;

function TtcItem.pm_GetID: Il3CString;
begin
 Result := f_ID;
end;

procedure TtcItem.pm_SetCaption(const aValue: Il3CString);
begin
 f_Caption := aValue;
end;

end.
