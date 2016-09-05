unit K219120094;
 {* [$219120094] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K219120094.pas"
// Стереотип: "TestCase"
// Элемент модели: "K219120094" MUID: (4C1F00340164)
// Имя типа: "TK219120094"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
 TK219120094 = class({$If NOT Defined(NoVCM)}
 TComplexScrollByLines
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$219120094] }
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
 end;//TK219120094
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
 //#UC START# *4C1F00340164impl_uses*
 //#UC END# *4C1F00340164impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK219120094.GetScrollLineCount2Down: Integer;
 {* количество строк для прокрутки вниз }
//#UC START# *4C1B13B6016B_4C1F00340164_var*
//#UC END# *4C1B13B6016B_4C1F00340164_var*
begin
//#UC START# *4C1B13B6016B_4C1F00340164_impl*
 Result := 9;
//#UC END# *4C1B13B6016B_4C1F00340164_impl*
end;//TK219120094.GetScrollLineCount2Down

function TK219120094.GetScrollLineCount2Up: Integer;
 {* количество строк для прокрутки вверх }
//#UC START# *4C1B140B002A_4C1F00340164_var*
//#UC END# *4C1B140B002A_4C1F00340164_var*
begin
//#UC START# *4C1B140B002A_4C1F00340164_impl*
 Result := 0;
//#UC END# *4C1B140B002A_4C1F00340164_impl*
end;//TK219120094.GetScrollLineCount2Up

procedure TK219120094.CheckTopAnchor(const aView: InevInputView);
 {* проверить якорь начала отрисовки после окончания прокрутки }
//#UC START# *4C1F0A260192_4C1F00340164_var*
var
 l_Inner: InevBasePoint;
//#UC END# *4C1F0A260192_4C1F00340164_var*
begin
//#UC START# *4C1F0A260192_4C1F00340164_impl*
 l_Inner := aView.TopAnchor;
 while (l_Inner <> nil) and not l_Inner.HasBaseLine do
  l_Inner := l_Inner.Inner;
 CheckFalse((l_Inner.Obj.PID = 7) and l_Inner.AtStart, 'TopAnchor должен быть еще в предыдующей строке');
//#UC END# *4C1F0A260192_4C1F00340164_impl*
end;//TK219120094.CheckTopAnchor

function TK219120094.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK219120094.GetFolder

function TK219120094.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C1F00340164';
end;//TK219120094.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK219120094.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
