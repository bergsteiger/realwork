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
  {* Базовый тест для отрисовки и сравнения. }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* Произвести какие-нибудь операции перед отрисовкой. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
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
