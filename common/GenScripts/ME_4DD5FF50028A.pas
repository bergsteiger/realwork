unit SelectCommentAndDelete;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TSelectCommentAndDelete = class(TTextViaEditorProcessor)
  {* Выделить комментарий и удалить. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TSelectCommentAndDelete
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evTypes
;

end.
