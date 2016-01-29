unit K224134476;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K224134476.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224134476
//
// [$224134476]
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
 TK224134476 = class(TComplexScrollByLines)
  {* [$224134476] }
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
 end;//TK224134476
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

// start class TK224134476

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224134476.GetScrollLineCount2Down: Integer;
//#UC START# *4C1B13B6016B_4C343176001D_var*
//#UC END# *4C1B13B6016B_4C343176001D_var*
begin
//#UC START# *4C1B13B6016B_4C343176001D_impl*
 Result := 9;
//#UC END# *4C1B13B6016B_4C343176001D_impl*
end;//TK224134476.GetScrollLineCount2Down
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224134476.GetScrollLineCount2Up: Integer;
//#UC START# *4C1B140B002A_4C343176001D_var*
//#UC END# *4C1B140B002A_4C343176001D_var*
begin
//#UC START# *4C1B140B002A_4C343176001D_impl*
 Result := 0;
//#UC END# *4C1B140B002A_4C343176001D_impl*
end;//TK224134476.GetScrollLineCount2Up
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK224134476.CheckTopAnchor(const aView: InevInputView);
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
{$IfEnd} //nsTest AND not NoVCM

function TK224134476.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224134476.GetFolder

function TK224134476.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C343176001D';
end;//TK224134476.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224134476.Suite);

end.