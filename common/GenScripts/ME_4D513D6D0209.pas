unit InsertPictureTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertPictureTest = class(TTextViaEditorProcessor)
  {* Тест вставки картинки в текст. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TInsertPictureTest
 
implementation

uses
 l3ImplUses
 , nevPersistentDocumentContainer
 , nevInternalInterfaces
 , l3Interfaces
 , evExtFormat
 , l3Base
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
