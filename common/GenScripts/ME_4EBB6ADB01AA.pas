unit K296095866;
 {* [RequestLink:296095866] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K296095866.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AllChildreCountTest
;

type
 TK296095866 = class(TAllChildreCountTest)
  {* [RequestLink:296095866] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK296095866
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

function TK296095866.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK296095866.GetFolder

function TK296095866.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EBB6ADB01AA';
end;//TK296095866.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK296095866.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
