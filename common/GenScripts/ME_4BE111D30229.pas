unit TextViaEditorProcessor;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TTextViaEditorProcessor = class(TTextEditorVisitor)
  {* ���������� ������ ����� �������� }
  function EtalonFileExtension: AnsiString;
   {* ���������� ���������� ����� }
  function HeaderBegin: AnsiChar;
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TTextViaEditorProcessor
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
