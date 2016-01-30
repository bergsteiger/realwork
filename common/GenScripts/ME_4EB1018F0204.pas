unit K271188165;
 {* [RequestLink:271188165]
[RequestLink:296625527] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K271188165.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollByArrowAndCheckShapesTest
 , Types
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
;

type
 TK271188165 = class(TScrollByArrowAndCheckShapesTest)
  {* [RequestLink:271188165]
[RequestLink:296625527] }
  protected
   function GetScrollCount: Integer; override;
   {$If NOT Defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   function QFLike: Boolean; override;
    {* Создать форму-редактор для работы с КЗ. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* Произвести какие-нибудь операции перед отрисовкой. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   procedure DoRepaint(aText: TevCustomEditorWindow); override;
 end;//TK271188165
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 , l3InternalInterfaces
 , Windows
 , Messages
 , TestFrameWork
;

function TK271188165.GetScrollCount: Integer;
//#UC START# *4D80BB670151_4EB1018F0204_var*
//#UC END# *4D80BB670151_4EB1018F0204_var*
begin
//#UC START# *4D80BB670151_4EB1018F0204_impl*
 Result := 9;
//#UC END# *4D80BB670151_4EB1018F0204_impl*
end;//TK271188165.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK271188165.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4EB1018F0204_var*
//#UC END# *4C08CF4300BE_4EB1018F0204_var*
begin
//#UC START# *4C08CF4300BE_4EB1018F0204_impl*
 Result := true;
//#UC END# *4C08CF4300BE_4EB1018F0204_impl*
end;//TK271188165.WebStyle
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK271188165.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4EB1018F0204_var*
//#UC END# *4C08CF700318_4EB1018F0204_var*
begin
//#UC START# *4C08CF700318_4EB1018F0204_impl*
 Result.X := 421;
 Result.Y := 213;
 //Result.X := 597;
 //Result.Y := 150{338};
//#UC END# *4C08CF700318_4EB1018F0204_impl*
end;//TK271188165.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK271188165.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7 Lulin';
end;//TK271188165.GetFolder

{$If NOT Defined(NoVCM)}
function TK271188165.QFLike: Boolean;
 {* Создать форму-редактор для работы с КЗ. }
//#UC START# *4CA0947C03CE_4EB1018F0204_var*
//#UC END# *4CA0947C03CE_4EB1018F0204_var*
begin
//#UC START# *4CA0947C03CE_4EB1018F0204_impl*
 Result := true;
//#UC END# *4CA0947C03CE_4EB1018F0204_impl*
end;//TK271188165.QFLike
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TK271188165.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* Произвести какие-нибудь операции перед отрисовкой. }
//#UC START# *4CAC45AE011E_4EB1018F0204_var*
var
 l_Index : Integer;
//#UC END# *4CAC45AE011E_4EB1018F0204_var*
begin
//#UC START# *4CAC45AE011E_4EB1018F0204_impl*
 inherited;
 if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocCharLeft, True, 1) then
  Assert(false);
 if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocCharLeft, True, 1) then
  Assert(false);
 if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocCharLeft, True, 1) then
  Assert(false);
 if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocCharRight, True, 1) then
  Assert(false);
 for l_Index := 0 to 12 do
  aForm.Text.Perform(WM_VScroll, SB_LINEDOWN, 0);
 aForm.Text.Repaint;
//#UC END# *4CAC45AE011E_4EB1018F0204_impl*
end;//TK271188165.DoBeforeDrawing
{$IfEnd} // NOT Defined(NoVCM)

function TK271188165.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EB1018F0204';
end;//TK271188165.GetModelElementGUID

procedure TK271188165.DoRepaint(aText: TevCustomEditorWindow);
//#UC START# *4EB100CE0160_4EB1018F0204_var*
const
 cDelta = 30;
var
 R : TRect;
//#UC END# *4EB100CE0160_4EB1018F0204_var*
begin
//#UC START# *4EB100CE0160_4EB1018F0204_impl*
 R.Left := 0;
 R.Right := cDelta * 2 {FormExtent.X div 2};
 R.Top := FormExtent.Y div 2 - cDelta;
 R.Bottom := R.Top + cDelta * 2 + cDelta;
 InvalidateRect(aText.Handle, @R, false);
 aText.Update;
//#UC END# *4EB100CE0160_4EB1018F0204_impl*
end;//TK271188165.DoRepaint

initialization
 TestFramework.RegisterTest(TK271188165.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
