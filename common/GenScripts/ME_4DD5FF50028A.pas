unit SelectCommentAndDelete;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TSelectCommentAndDelete = class(TTextViaEditorProcessor)
  {* �������� ����������� � �������. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TSelectCommentAndDelete
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evTypes
;

end.
