unit TextMetricsPrimTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithExternalSave
 , PrimTextLoad_Form
 , l3Filer
;

type
 TTextMetricsPrimTest = class(TTextViaEditorProcessorWithExternalSave)
  {* ���� ����������� ������� ������. ����� ��� AllChildrenCount, NettoCharCount, BruttoCharCount, TextParaCount, BitmapParaCount }
  procedure DoSave(aForm: TPrimTextLoadForm;
   aFiler: Tl3CustomFiler);
 end;//TTextMetricsPrimTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , TestFrameWork
;

end.
