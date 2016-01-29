unit arHAFPainer;

{ $Id: arHAFPainer.pas,v 1.2 2014/04/07 06:57:02 dinishev Exp $ }

{$Include evDefine.inc }

interface

uses
 l3Chars,
 l3InternalInterfaces,

 k2Interfaces,

 evHAFPainterEx;

type
 TarHAFPainer = class(TevHAFPainterEx)
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

 arPrintMacros,
 arColontitulStr,
 
 evdTypes,

 evTypes,
 evSBSPar,
 evHAFPainterMacros;
 

{ TarHAFPainer }

procedure TarHAFPainer.ReadColontitulSettings;
begin
 f_Colontituls[pcUpLeftFirst] := l3Fmt(csUpLeftFirstTilul,
                                       [SUrgency, SInternalNumber, SDataSize,
                                        SOtherDataSize, SBaseName,
                                        SDocRedactionDate, SCurrentDate]);
 f_Colontituls[pcUpRightFirst] := l3Fmt('%s', [SDocCurrentPage]);
 f_Colontituls[pcUpRight] := l3Fmt('%s', [SDocCurrentPage]);
 f_Colontituls[pcUpLeft] := l3Fmt(csUpLeftTilul,
                                  [SInternalNumber, SDocRedactionDate]);
end;

procedure TarHAFPainer.TuneHeader(const aCanvas: Il3Canvas;
  aHeader: Tl3Variant; aTop: Boolean);
begin
 inherited;
 evSBS_LeftPara(aHeader).cAtom(k2_tiFont).IntA[k2_tiSize] := 12;
 evSBS_RightPara(aHeader).cAtom(k2_tiFont).IntA[k2_tiSize] := 12;
end;

end.
