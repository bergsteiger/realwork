unit K275780190;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TK275780190 = class(TTextViaEditorProcessor)
  {* [RequestLink:275780190]. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TK275780190
 
implementation

uses
 l3ImplUses
 , k2Tags
 , TestFrameWork
;

end.
