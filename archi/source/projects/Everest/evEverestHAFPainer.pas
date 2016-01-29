unit evEverestHAFPainer;

{ $Id: evEverestHAFPainer.pas,v 1.4 2014/04/07 06:54:42 dinishev Exp $ }

{$Include evDefine.inc }

interface

uses
 l3Chars,
 l3InternalInterfaces,

 k2Interfaces,

 evHAFPainterEx;

type
 TevEverestHAFPainer = class(TevHAFPainterEx)
 public
  procedure TuneHeader(const aCanvas : Il3Canvas;
                       aHeader : Tl3Variant;
                       aTop          : Boolean);
    override;
    {-}
  procedure ReadColontitulSettings;
    override;
    {-}
 end;

implementation

uses
 l3String,

 k2Tags,

 evColontitulStr,
 
 evdTypes,

 evTypes,
 evSBSPar,
 evHAFPainterMacros;
 

{ TevEverestHAFPainer }

procedure TevEverestHAFPainer.ReadColontitulSettings;
begin
 f_Colontituls[pcUpLeftFirst] := l3Fmt(csUpLeftFirstTitul,
                                       [SDocName, SDataSize, SOtherDataSize,
                                       SCurrentDate]);
 f_Colontituls[pcUpRightFirst] := l3Fmt('%s', [SDocCurrentPage]);
 f_Colontituls[pcUpRight] := l3Fmt('%s', [SDocCurrentPage]);
 f_Colontituls[pcUpLeft] := l3Fmt(csUpLeftTitul, [SDocName]);
end;

procedure TevEverestHAFPainer.TuneHeader(const aCanvas: Il3Canvas;
  aHeader: Tl3Variant; aTop: Boolean);
begin
 evSBS_LeftPara(aHeader).cAtom(k2_tiFont).IntA[k2_tiSize] := 12;
 evSBS_RightPara(aHeader).cAtom(k2_tiFont).IntA[k2_tiSize] := 12;
 evSBS_LeftColumn(aHeader).IntA[k2_tiVerticalAligment] := Ord(ev_valBottom);
 evSBS_RightColumn(aHeader).IntA[k2_tiVerticalAligment] := Ord(ev_valBottom);
 inherited;
end;

end.
