unit evdHyperlinkCorrector;

interface

Uses
 l3Types,
 k2Types, k2Interfaces, k2TagGen,
 evdBufferedFilter;

type
 TevdHyperlinkCorrector = class(TevdChildBufferedFilter)
 private
  f_InternalHandle: Integer;
 protected
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner);
  property InternalHandle: Integer
   read f_InternalHandle
   write f_InternalHandle;
 end;

implementation

uses
 l3Base,
 k2Tags,

 Address_Const,
 Document_Const
 ;

constructor TevdHyperlinkCorrector.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(k2_idAddress, aOwner);
end;

procedure TevdHyperlinkCorrector.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_InternalHandle:= Value.AsInteger;
end;

procedure TevdHyperlinkCorrector.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
  //virtual;
  {-}
begin
 if aLeaf.cAtom(k2_tiDocID).AsLong = 0 then
  aLeaf.IntA[k2_tiDocID]:= f_InternalHandle;
 inherited;
end;

end.
