unit K224133855;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K224133855.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224133855
//
// [$224133855]
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
  ScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK224133855 = class(TScrollTest)
  {* [$224133855] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK224133855
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

// start class TK224133855

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK224133855.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C6537870206_var*
//#UC END# *4BE419AF0217_4C6537870206_var*
begin
//#UC START# *4BE419AF0217_4C6537870206_impl*
 inherited DoVisit(aForm);
 Check(Self.ScrollCount > 2);
//#UC END# *4BE419AF0217_4C6537870206_impl*
end;//TK224133855.DoVisit
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224133855.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C6537870206_var*
//#UC END# *4C08CF700318_4C6537870206_var*
begin
//#UC START# *4C08CF700318_4C6537870206_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C6537870206_impl*
end;//TK224133855.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK224133855.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224133855.GetFolder

function TK224133855.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C6537870206';
end;//TK224133855.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224133855.Suite);

end.