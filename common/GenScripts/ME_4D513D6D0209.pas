unit InsertPictureTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertPictureTest = class(TTextViaEditorProcessor)
  {* ���� ������� �������� � �����. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
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
