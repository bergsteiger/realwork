unit TextMetricsTest;

interface

uses
 l3IntfUses
 , TextMetricsPrimTest
 , PrimTextLoad_Form
;

type
 TTextMetricsTest = class(TTextMetricsPrimTest)
  {* ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TTextMetricsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
