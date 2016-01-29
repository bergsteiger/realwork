unit DrawTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/DrawTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TDrawTest
//
// Тест вида: нарисовали и сравнили с эталоном.
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
  DrawTestPrim
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TDrawTest = {abstract} class(TDrawTestPrim)
  {* Тест вида: нарисовали и сравнили с эталоном. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
     {* Произвести какие-нибудь операции перед отрисовкой. }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$If defined(nsTest) AND not defined(NoVCM)}
   function UseFormExtentAsClientSize: Boolean; override;
     {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
   {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TDrawTest
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

// start class TDrawTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TDrawTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
//#UC START# *4CAC45AE011E_4CC7F3170362_var*
//#UC END# *4CAC45AE011E_4CC7F3170362_var*
begin
//#UC START# *4CAC45AE011E_4CC7F3170362_impl*
 // Это тест просто для проверки отрисовки, поэтому ничего не делаем. 
//#UC END# *4CAC45AE011E_4CC7F3170362_impl*
end;//TDrawTest.DoBeforeDrawing
{$IfEnd} //nsTest AND not NoVCM

function TDrawTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TDrawTest.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
function TDrawTest.UseFormExtentAsClientSize: Boolean;
//#UC START# *4DA2F7900393_4CC7F3170362_var*
//#UC END# *4DA2F7900393_4CC7F3170362_var*
begin
//#UC START# *4DA2F7900393_4CC7F3170362_impl*
 Result := True;
//#UC END# *4DA2F7900393_4CC7F3170362_impl*
end;//TDrawTest.UseFormExtentAsClientSize
{$IfEnd} //nsTest AND not NoVCM

function TDrawTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CC7F3170362';
end;//TDrawTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.