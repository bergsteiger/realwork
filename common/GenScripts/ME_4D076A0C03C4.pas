unit TextMetricsTest;

interface

uses
 l3IntfUses
 , TextMetricsPrimTest
 , PrimTextLoad_Form
;

type
 TTextMetricsTest = class(TTextMetricsPrimTest)
  {* Тест проверяющий метрики текста. Такие как AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TTextMetricsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
