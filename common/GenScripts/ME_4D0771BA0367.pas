unit TextViaEditorProcessorWithExternalSave;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
 , l3Filer
;

type
 TTextViaEditorProcessorWithExternalSave = class(TTextViaEditorProcessor)
  procedure DoSave(aForm: TPrimTextLoadForm;
   aFiler: Tl3CustomFiler);
 end;//TTextViaEditorProcessorWithExternalSave
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
;

end.
