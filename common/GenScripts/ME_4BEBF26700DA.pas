unit K210438932;
 {* [RequestLink:210438932] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210438932.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK210438932 = class(TScrollTest)
  {* [RequestLink:210438932] }
  protected
   {$If NOT Defined(NoVCM)}
   function ScrollByPage: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210438932
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
function TK210438932.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4BEBF26700DA_var*
//#UC END# *4BEBFE020080_4BEBF26700DA_var*
begin
//#UC START# *4BEBFE020080_4BEBF26700DA_impl*
 Result := false;
//#UC END# *4BEBFE020080_4BEBF26700DA_impl*
end;//TK210438932.ScrollByPage
{$IfEnd} // NOT Defined(NoVCM)

function TK210438932.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210438932.GetFolder

function TK210438932.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BEBF26700DA';
end;//TK210438932.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210438932.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
