unit DrawTestPrim;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , evCustomEditorWindow
 , PrimTextLoad_Form
 , nevTools
;

type
 TDrawTestPrim = class(TTextEditorVisitor)
  {* ������� ���� ��� ��������� � ���������. }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* ���������� �����-������ �������� ����� ����������. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
  function DoOpenLog(const aView: InevView): AnsiString;
  procedure DoCloseLog(const aLogName: AnsiString);
 end;//TDrawTestPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
;

end.
