unit lukRelIDGenerator;

interface

uses ddHeaderFilter, k2Interfaces, k2TagGen, k2TagFilter, k2Prim;

type
 TlukRelIDGenertor = class(tk2TagFilter)
 private
  f_DocID: Integer;
 protected
  procedure DoStartChild(aChildID: Integer); override;
 public
    {public methods}
  class function SetTo(var theGenerator: Tk2TagGenerator; aDocID: Integer): Tk2TagGenerator; overload;
  property DocID: Integer read f_DocID write f_DocID;
 end;

implementation

uses k2Tags, Document_Const, DT_Types;

procedure TlukRelIDGenertor.DoStartChild(aChildID: Integer);
begin
 inherited;
 if CurrentType.InheritsFrom(k2_idDocument) then
 begin
  Generator.AddIntegerAtom(k2_tiExternalHandle, DocID);
  Generator.AddIntegerAtom(k2_tiType, Ord(dtRelText));
 end;
end;

class function TlukRelIDGenertor.SetTo(var theGenerator: Tk2TagGenerator; aDocID: Integer):
    Tk2TagGenerator;
begin
 Result := SetTo(theGenerator);
 (theGenerator As TlukRelIDGenertor).DocID := aDocID;
end;

end.
