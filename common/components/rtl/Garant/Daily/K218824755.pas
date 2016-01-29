unit K218824755;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/rtl/Garant/Daily/K218824755.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K218824755
//
// {RequestLink:218824755}
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
 TK218824755 = class(TComplexScrollByLines)
  {* [RequestLink:218824755] }
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
 end;//TK218824755
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

// start class TK218824755

{$If defined(nsTest) AND not defined(NoVCM)}
function TK218824755.GetScrollLineCount2Down: Integer;
//#UC START# *4C1B13B6016B_4C1B56120220_var*
//#UC END# *4C1B13B6016B_4C1B56120220_var*
begin
//#UC START# *4C1B13B6016B_4C1B56120220_impl*
 Result := 8;
//#UC END# *4C1B13B6016B_4C1B56120220_impl*
end;//TK218824755.GetScrollLineCount2Down
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK218824755.GetScrollLineCount2Up: Integer;
//#UC START# *4C1B140B002A_4C1B56120220_var*
//#UC END# *4C1B140B002A_4C1B56120220_var*
begin
//#UC START# *4C1B140B002A_4C1B56120220_impl*
 Result := 2;
//#UC END# *4C1B140B002A_4C1B56120220_impl*
end;//TK218824755.GetScrollLineCount2Up
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK218824755.CheckTopAnchor(const aView: InevInputView);
//#UC START# *4C1F0A260192_4C1B56120220_var*
//#UC END# *4C1F0A260192_4C1B56120220_var*
begin
//#UC START# *4C1F0A260192_4C1B56120220_impl*
 
//#UC END# *4C1F0A260192_4C1B56120220_impl*
end;//TK218824755.CheckTopAnchor
{$IfEnd} //nsTest AND not NoVCM

function TK218824755.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK218824755.GetFolder

function TK218824755.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1B56120220';
end;//TK218824755.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK218824755.Suite);

end.