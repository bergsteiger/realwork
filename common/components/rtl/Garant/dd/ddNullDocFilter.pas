unit ddNullDocFilter;

{ $Id: ddNullDocFilter.pas,v 1.2 2015/11/17 13:47:05 fireton Exp $ }

interface

uses
 l3Variant,

 evdDocumentBufferedFilter,

 k2Interfaces,
 k2TagGen;

type
 TddNullDocFilter = class(TevdDocumentBufferedFilter)
 private
  f_IntHandle: Integer;
 protected
  function CheckNeedFlushBuffer: Boolean;
 public
  procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
  procedure StartChild(TypeID: Tl3VariantDef); override;
 end;

implementation
uses
 l3Base,
 Document_Const,
 LeafPara_Const,
 k2Tags;

{TddNullDocFilter}
procedure TddNullDocFilter.AddAtomEx(AtomIndex: Integer; const Value:
    Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_IntHandle:= Value.AsInteger;
 inherited;
end;

function TddNullDocFilter.CheckNeedFlushBuffer: Boolean;
begin
 Result:= f_IntHandle > 0;
 {$IFDEF Debug}
 if not Result then
  l3System.Msg2Log('%s skipped', [ClassName]);
 {$ENDIF}
end;

procedure TddNullDocFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if TypeID.IsKindOf(k2_typLeafPara) and (SkipLevel = 2) and CheckNeedFlushBuffer then
  StopBufferingAndFlush(False, TopObject[0], false);
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  f_IntHandle:= 0;
end;

end.
