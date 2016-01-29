unit DrawLineTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/DrawLineTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TDrawLineTest
//
// Тест рисования линии в документе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TextViaEditorProcessor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TDrawLineTest = {abstract} class(TTextViaEditorProcessor)
  {* Тест рисования линии в документе }
 protected
 // realized methods
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TDrawLineTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evOp,
  nevBase,
  evMsgCode,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TDrawLineTest

procedure TDrawLineTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C46F52A0317_var*
var
 i    : Integer;
 l_Op : InevOp;
//#UC END# *4BE13147032C_4C46F52A0317_var*
begin
//#UC START# *4BE13147032C_4C46F52A0317_impl*
 GotoDocumentBottom(aForm);
 for i := 1 to 69 do
  aForm.Text.Selection.ProcessCommand(ev_msgMove, ev_ocLineUp, l_Op, 1);
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineHome);
 l_Op := aForm.Text.StartOp;
 aForm.Text.Selection.DrawLines := True;
 for i := 1 to 50 do
  aForm.Text.Selection.ProcessCommand(ev_msgMove, ev_ocExtLineUp, l_Op, 1);
//#UC END# *4BE13147032C_4C46F52A0317_impl*
end;//TDrawLineTest.Process

function TDrawLineTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TDrawLineTest.GetFolder

function TDrawLineTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C46F52A0317';
end;//TDrawLineTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.