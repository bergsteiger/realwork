unit PreviewWithRowCompare;

interface

uses
 l3IntfUses
 , PreviewTestBefore278833302
 , PrimTextLoad_Form
;

type
 TPreviewWithRowCompare = class(TPreviewTestBefore278833302)
  {* Тест печати со сравнением строк. }
 end;//TPreviewWithRowCompare
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 , PrintRowHeightsSpy
;

end.
