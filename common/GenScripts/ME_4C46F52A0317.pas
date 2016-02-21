unit DrawLineTest;
 {* Тест рисования линии в документе }

// Модуль: "w:\common\components\gui\Garant\Daily\DrawLineTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TDrawLineTest = {abstract} class(TTextViaEditorProcessor)
  {* Тест рисования линии в документе }
  protected
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TDrawLineTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evOp
 , nevBase
 , evMsgCode
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TDrawLineTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
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
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TDrawLineTest.GetFolder

function TDrawLineTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C46F52A0317';
end;//TDrawLineTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
