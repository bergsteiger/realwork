unit NOT_FINISHED_ddHTMLWriter;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_ddHTMLWriter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddHTMLWriter" MUID: (4B9E545B0118)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocument
 , ddTextParagraph
 , ddParagraphProperty
;

type
 TddParaTag = (
  dd_ptNone
  , dd_ptP
  , dd_ptH1
  , dd_ptH2
  , dd_ptH3
  , dd_ptH4
  , dd_ptA
  , dd_ptPre
 );//TddParaTag

 TddHTMLGenerator = class(TddDocumentGenerator)
  protected
   procedure WriteHTMLStyleTable; virtual;
   function StyleName(StyleID: Integer): AnsiString; virtual;
   procedure OpenPara(const aPara: TddTextParagraph;
    var aParaTag: TddParaTag); virtual;
   function PAP2HTML(aPAP: TddParagraphProperty;
    var aParaTag: TddParaTag;
    var aNeedLI: Boolean): AnsiString; virtual;
 end;//TddHTMLGenerator

implementation

uses
 l3ImplUses
 , ddHTMLWriterRes
;

procedure TddHTMLGenerator.WriteHTMLStyleTable;
//#UC START# *576117CD013D_4B9E54770095_var*
//#UC END# *576117CD013D_4B9E54770095_var*
begin
//#UC START# *576117CD013D_4B9E54770095_impl*
 !!! Needs to be implemented !!!
//#UC END# *576117CD013D_4B9E54770095_impl*
end;//TddHTMLGenerator.WriteHTMLStyleTable

function TddHTMLGenerator.StyleName(StyleID: Integer): AnsiString;
//#UC START# *576117FD021D_4B9E54770095_var*
//#UC END# *576117FD021D_4B9E54770095_var*
begin
//#UC START# *576117FD021D_4B9E54770095_impl*
 !!! Needs to be implemented !!!
//#UC END# *576117FD021D_4B9E54770095_impl*
end;//TddHTMLGenerator.StyleName

procedure TddHTMLGenerator.OpenPara(const aPara: TddTextParagraph;
 var aParaTag: TddParaTag);
//#UC START# *5761184D00CB_4B9E54770095_var*
//#UC END# *5761184D00CB_4B9E54770095_var*
begin
//#UC START# *5761184D00CB_4B9E54770095_impl*
 !!! Needs to be implemented !!!
//#UC END# *5761184D00CB_4B9E54770095_impl*
end;//TddHTMLGenerator.OpenPara

function TddHTMLGenerator.PAP2HTML(aPAP: TddParagraphProperty;
 var aParaTag: TddParaTag;
 var aNeedLI: Boolean): AnsiString;
//#UC START# *5761194803AE_4B9E54770095_var*
//#UC END# *5761194803AE_4B9E54770095_var*
begin
//#UC START# *5761194803AE_4B9E54770095_impl*
 !!! Needs to be implemented !!!
//#UC END# *5761194803AE_4B9E54770095_impl*
end;//TddHTMLGenerator.PAP2HTML

end.
