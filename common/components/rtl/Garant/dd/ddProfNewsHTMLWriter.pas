unit ddProfNewsHTMLWriter;
 {* Специальный класс генератора для Грунева. [Requestlink:624690924] }

// Модуль: "w:\common\components\rtl\Garant\dd\ddProfNewsHTMLWriter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddProfNewsHTMLWriter" MUID: (576119AE00C1)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddHTMLWriter
 , ddTextParagraph
 , ddParagraphProperty
;

const
 csH1StyleName = 'dates';
 csColorSelectionStyleName = 'date';
 csFormulaStyleName = 'title';

type
 TddProfNewsHTMLWriter = class(TddHTMLGenerator)
  {* Специальный класс генератора для Грунева. [Requestlink:624690924] }
  protected
   procedure WriteHTMLStyleTable; override;
   function StyleName(StyleID: Integer): AnsiString; override;
   procedure OpenPara(const aPara: TddTextParagraph;
    var aParaTag: TddParaTag); override;
   function PAP2HTML(aPAP: TddParagraphProperty;
    var aParaTag: TddParaTag;
    var aNeedLI: Boolean): AnsiString; override;
 end;//TddProfNewsHTMLWriter

implementation

uses
 l3ImplUses
 , ddStyleSegment
 , ddTextSegment
 , evdStyles
 , ddUtils
 //#UC START# *576119AE00C1impl_uses*
 //#UC END# *576119AE00C1impl_uses*
;

procedure TddProfNewsHTMLWriter.WriteHTMLStyleTable;
//#UC START# *576117CD013D_576119AE00C1_var*
const
 csGarantCSSLink = '<link rel="stylesheet" type="text/css" href="garantdoc.css">';
//#UC END# *576117CD013D_576119AE00C1_var*
begin
//#UC START# *576117CD013D_576119AE00C1_impl*
 OutStringLn(csGarantCSSLink);
//#UC END# *576117CD013D_576119AE00C1_impl*
end;//TddProfNewsHTMLWriter.WriteHTMLStyleTable

function TddProfNewsHTMLWriter.StyleName(StyleID: Integer): AnsiString;
//#UC START# *576117FD021D_576119AE00C1_var*
//#UC END# *576117FD021D_576119AE00C1_var*
begin
//#UC START# *576117FD021D_576119AE00C1_impl*
 Result := inherited StyleName(StyleID);
 case StyleID of
  ev_saFormulaInAAC: Result := csFormulaStyleName;
  ev_saColorSelection: Result := csColorSelectionStyleName;
 end;
//#UC END# *576117FD021D_576119AE00C1_impl*
end;//TddProfNewsHTMLWriter.StyleName

procedure TddProfNewsHTMLWriter.OpenPara(const aPara: TddTextParagraph;
 var aParaTag: TddParaTag);
//#UC START# *5761184D00CB_576119AE00C1_var*

 procedure lp_Try2ConvertSingleStyleSegment;
 var
  l_Segment        : TddTextSegment;
  l_StyledWholePara: Boolean;
 begin
  if aPara.SegmentCount = 1 then
  begin
   l_Segment := aPara.Segments[0];
   l_StyledWholePara := (l_Segment is TddStyleSegment) and (l_Segment.Stop = (aPara.Text.Len - 1)) and (l_Segment.Start = 0) and
      not ddStyleUndefined(l_Segment.CHP.Style);
   if l_StyledWholePara then
   begin
    if IgnoreStyle(aPara.PAP.Style) then
     aPara.PAP.Style := l_Segment.CHP.Style;
    aPara.RemoveSegment(l_Segment);
   end; // if l_StyledWholePara then
  end // if aPara.SegmentCount = 1 then
 end; 

//#UC END# *5761184D00CB_576119AE00C1_var*
begin
//#UC START# *5761184D00CB_576119AE00C1_impl*
 lp_Try2ConvertSingleStyleSegment;
 inherited;
//#UC END# *5761184D00CB_576119AE00C1_impl*
end;//TddProfNewsHTMLWriter.OpenPara

function TddProfNewsHTMLWriter.PAP2HTML(aPAP: TddParagraphProperty;
 var aParaTag: TddParaTag;
 var aNeedLI: Boolean): AnsiString;
//#UC START# *5761194803AE_576119AE00C1_var*
//#UC END# *5761194803AE_576119AE00C1_var*
begin
//#UC START# *5761194803AE_576119AE00C1_impl*
 Result := inherited PAP2HTML(aPAP, aParaTag, aNeedLI);
 if aParaTag = dd_ptH1 then
  Result := GetClassLink(csH1StyleName);
//#UC END# *5761194803AE_576119AE00C1_impl*
end;//TddProfNewsHTMLWriter.PAP2HTML

end.
