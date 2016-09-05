unit K201493907;
 {* [RequestLink:201493907] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K201493907.pas"
// Стереотип: "TestCase"
// Элемент модели: "K201493907" MUID: (4C07A89B0179)
// Имя типа: "TK201493907"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK201493907 = class({$If NOT Defined(NoVCM)}
 TScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:201493907] }
  protected
   {$If NOT Defined(NoVCM)}
   function ScrollByPage: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK201493907
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
 //#UC START# *4C07A89B0179impl_uses*
 //#UC END# *4C07A89B0179impl_uses*
;

{$If NOT Defined(NoVCM)}
function TK201493907.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4C07A89B0179_var*
//#UC END# *4BEBFE020080_4C07A89B0179_var*
begin
//#UC START# *4BEBFE020080_4C07A89B0179_impl*
 Result := false;
//#UC END# *4BEBFE020080_4C07A89B0179_impl*
end;//TK201493907.ScrollByPage

function TK201493907.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C07A89B0179_var*
//#UC END# *4C07AC6F036D_4C07A89B0179_var*
begin
//#UC START# *4C07AC6F036D_4C07A89B0179_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C07A89B0179_impl*
end;//TK201493907.GetNormalFontSize

function TK201493907.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK201493907.GetFolder

function TK201493907.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C07A89B0179';
end;//TK201493907.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK201493907.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
