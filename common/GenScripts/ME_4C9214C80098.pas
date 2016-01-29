unit TextViaEditorProcessorWithNavigate;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , evCustomEditorWindow
 , l3Variant
 , PrimTextLoad_Form
;

type
 TTextViaEditorProcessorWithNavigate = class(TTextViaEditorProcessor)
  procedure DoProcess(aText: TevCustomEditorWindow;
   const anOp: Il3OpPack);
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TTextViaEditorProcessorWithNavigate
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
