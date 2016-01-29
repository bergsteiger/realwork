unit K219120094;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K219120094.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K219120094
//
// [$219120094]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  ComplexScrollByLines
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK219120094 = class(TComplexScrollByLines)
  {* [$219120094] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetScrollLineCount2Down: Integer; override;
     {* количество строк для прокрутки вниз }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetScrollLineCount2Up: Integer; override;
     {* количество строк для прокрутки вверх }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure CheckTopAnchor(const aView: InevInputView); override;
     {* проверить якорь начала отрисовки после окончания прокрутки }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK219120094
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
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

// start class TK219120094

{$If defined(nsTest) AND not defined(NoVCM)}
function TK219120094.GetScrollLineCount2Down: Integer;
//#UC START# *4C1B13B6016B_4C1F00340164_var*
//#UC END# *4C1B13B6016B_4C1F00340164_var*
begin
//#UC START# *4C1B13B6016B_4C1F00340164_impl*
 Result := 9;
//#UC END# *4C1B13B6016B_4C1F00340164_impl*
end;//TK219120094.GetScrollLineCount2Down
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK219120094.GetScrollLineCount2Up: Integer;
//#UC START# *4C1B140B002A_4C1F00340164_var*
//#UC END# *4C1B140B002A_4C1F00340164_var*
begin
//#UC START# *4C1B140B002A_4C1F00340164_impl*
 Result := 0;
//#UC END# *4C1B140B002A_4C1F00340164_impl*
end;//TK219120094.GetScrollLineCount2Up
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK219120094.CheckTopAnchor(const aView: InevInputView);
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
{$IfEnd} //nsTest AND not NoVCM

function TK219120094.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK219120094.GetFolder

function TK219120094.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1F00340164';
end;//TK219120094.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK219120094.Suite);

end.