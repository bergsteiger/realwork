unit K224134476;
 {* [$224134476] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K224134476.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ComplexScrollByLines
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
;

type
 TK224134476 = class(TComplexScrollByLines)
  {* [$224134476] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetScrollLineCount2Down: Integer; override;
    {* количество строк для прокрутки вниз }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetScrollLineCount2Up: Integer; override;
    {* количество строк для прокрутки вверх }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* проверить якорь начала отрисовки после окончания прокрутки }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK224134476
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
function TK224134476.GetScrollLineCount2Down: Integer;
 {* количество строк для прокрутки вниз }
//#UC START# *4C1B13B6016B_4C343176001D_var*
//#UC END# *4C1B13B6016B_4C343176001D_var*
begin
//#UC START# *4C1B13B6016B_4C343176001D_impl*
 Result := 9;
//#UC END# *4C1B13B6016B_4C343176001D_impl*
end;//TK224134476.GetScrollLineCount2Down
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK224134476.GetScrollLineCount2Up: Integer;
 {* количество строк для прокрутки вверх }
//#UC START# *4C1B140B002A_4C343176001D_var*
//#UC END# *4C1B140B002A_4C343176001D_var*
begin
//#UC START# *4C1B140B002A_4C343176001D_impl*
 Result := 0;
//#UC END# *4C1B140B002A_4C343176001D_impl*
end;//TK224134476.GetScrollLineCount2Up
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TK224134476.CheckTopAnchor(const aView: InevInputView);
 {* проверить якорь начала отрисовки после окончания прокрутки }
//#UC START# *4C1F0A260192_4C343176001D_var*
var
 l_Inner: InevBasePoint;
//#UC END# *4C1F0A260192_4C343176001D_var*
begin
//#UC START# *4C1F0A260192_4C343176001D_impl*
 l_Inner := aView.TopAnchor;
 while not l_Inner.HasBaseLine do
 begin
  l_Inner := l_Inner.Inner;
  CheckFalse(l_Inner = nil, 'BaseLine должна быть инициализирована!');
 end; // while not l_Inner.HasBaseLine do
//#UC END# *4C1F0A260192_4C343176001D_impl*
end;//TK224134476.CheckTopAnchor
{$IfEnd} // NOT Defined(NoVCM)

function TK224134476.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK224134476.GetFolder

function TK224134476.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C343176001D';
end;//TK224134476.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224134476.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
