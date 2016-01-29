unit ScrollerParamsTestPrim;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorWithExternalSave
 , PrimTextLoad_Form
 , l3Filer
;

type
 TScrollerParamsTestPrim = class(TTextViaEditorProcessorWithExternalSave)
  {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }
  procedure DoSave(aForm: TPrimTextLoadForm;
   aFiler: Tl3CustomFiler);
 end;//TScrollerParamsTestPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
;

end.
