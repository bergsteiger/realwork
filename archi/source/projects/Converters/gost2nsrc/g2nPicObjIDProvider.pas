unit g2nPicObjIDProvider;

{ $Id: g2nPicObjIDProvider.pas,v 1.1 2015/02/04 12:18:31 fireton Exp $ }

interface

uses
 l3Variant,
 evdBufferedFilter,

 g2nTypes;

type
 Tg2nPicObjIDProvider = class(TevdBufferedFilter)
 {*- реализует выдачу внешнего номера для всех объектов в доке}
 private
  f_OnGetDocID: Tg2nGetDocIDEvent;
 protected
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
 public
  property OnGetDocID: Tg2nGetDocIDEvent read f_OnGetDocID write f_OnGetDocID;
 end;

implementation
uses
 k2Tags,
 BitmapPara_Const,
 ExtDataPara_Const;

{Tg2nPicObjIDProvider}
function Tg2nPicObjIDProvider.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
begin
 Result := (aTagID = -k2_idExtDataPara) or (aTagID = -k2_idBitmapPara);
end;

function Tg2nPicObjIDProvider.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := (aID = -k2_idExtDataPara) or (aID = -k2_idBitmapPara);
end;

procedure Tg2nPicObjIDProvider.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 l_DocID: LongInt;
begin
 if (aLeaf.IntA[k2_tiExternalHandle] = 0) and Assigned(f_OnGetDocID) then
 begin
  f_OnGetDocID(l_DocID);
  aLeaf.IntA[k2_tiExternalHandle] := l_DocID;
 end;
 inherited;
end;

end.