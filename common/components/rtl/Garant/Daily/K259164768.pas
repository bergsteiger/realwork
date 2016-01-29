unit K259164768;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K259164768.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K259164768
//
// [$259164768]
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
  DrawTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK259164768 = class(TDrawTest)
  {* [$259164768] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK259164768
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  nevTools
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

// start class TK259164768

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259164768.FormExtent: TPoint;
//#UC START# *4C08CF700318_4DA2DA5002A6_var*
//#UC END# *4C08CF700318_4DA2DA5002A6_var*
begin
//#UC START# *4C08CF700318_4DA2DA5002A6_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DA2DA5002A6_impl*
end;//TK259164768.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK259164768.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK259164768.GetFolder

function TK259164768.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DA2DA5002A6';
end;//TK259164768.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK259164768.Suite);

end.