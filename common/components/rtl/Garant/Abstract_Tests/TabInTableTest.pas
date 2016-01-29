unit TabInTableTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/TabInTableTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TTabInTableTest
//
// Теситрование поведения таблицации в таблице
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevTools
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TTabInTableTest = {abstract} class(_CursorMover_)
  {* Теситрование поведения таблицации в таблице }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure CheckPoint(const aCellPoint: InevBasePoint); virtual;
   function GetDownMoveCount: Integer; virtual;
     {* Количество смещений вниз }
   function GetTabMoveCount: Integer; virtual;
     {* Количество смещений по табуляциии }
 end;//TTabInTableTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

// start class TTabInTableTest

procedure TTabInTableTest.CheckPoint(const aCellPoint: InevBasePoint);
//#UC START# *4D5A4CA602E5_4D5A45CE00ED_var*
//#UC END# *4D5A4CA602E5_4D5A45CE00ED_var*
begin
//#UC START# *4D5A4CA602E5_4D5A45CE00ED_impl*
//#UC END# *4D5A4CA602E5_4D5A45CE00ED_impl*
end;//TTabInTableTest.CheckPoint

function TTabInTableTest.GetDownMoveCount: Integer;
//#UC START# *4D5A4CD801F7_4D5A45CE00ED_var*
//#UC END# *4D5A4CD801F7_4D5A45CE00ED_var*
begin
//#UC START# *4D5A4CD801F7_4D5A45CE00ED_impl*
 Result := 0;
//#UC END# *4D5A4CD801F7_4D5A45CE00ED_impl*
end;//TTabInTableTest.GetDownMoveCount

function TTabInTableTest.GetTabMoveCount: Integer;
//#UC START# *4D5A4CFB029F_4D5A45CE00ED_var*
//#UC END# *4D5A4CFB029F_4D5A45CE00ED_var*
begin
//#UC START# *4D5A4CFB029F_4D5A45CE00ED_impl*
 Result := 0;
//#UC END# *4D5A4CFB029F_4D5A45CE00ED_impl*
end;//TTabInTableTest.GetTabMoveCount

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTabInTableTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D5A45CE00ED_var*
var
 i       : Integer;
 l_Point : InevBasePoint;
//#UC END# *4BE419AF0217_4D5A45CE00ED_var*
begin
//#UC START# *4BE419AF0217_4D5A45CE00ED_impl*
 for i := 0 to GetDownMoveCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 for i := 0 to GetTabMoveCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocColumnRight);
 l_Point := aForm.Text.Selection.Cursor.Inner;
 l_Point := l_Point.Inner;
 l_Point := l_Point.Inner;
 CheckPoint(l_Point);
//#UC END# *4BE419AF0217_4D5A45CE00ED_impl*
end;//TTabInTableTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TTabInTableTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTabInTableTest.GetFolder

function TTabInTableTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D5A45CE00ED';
end;//TTabInTableTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.