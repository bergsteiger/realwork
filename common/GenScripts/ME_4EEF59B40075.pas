unit FormulaRender;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , eeRenderFormula
 , PrimTextLoad_Form
;

type
 TFormulaRender = class(TTextEditorVisitor)
  function GetZoom: Integer;
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TFormulaRender
 
implementation

uses
 l3ImplUses
 , l3Memory
 , l3Stream
 , nevTools
 , evTypes
 , SysUtils
 , l3Interfaces
 , l3Filer
 , evdInterfaces
 , Formula_Const
 , k2Tags
 , evdTypes
 , ObjectSegment_Const
 , l3Variant
 , evOp
 , KTestRunner
 , l3ImageUtils
 , TestFrameWork
;

end.
