unit K210043423;
 {* [RequestLink:210043423] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210043423.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , ScrollBackTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK210043423 = class(TScrollBackTest)
  {* [RequestLink:210043423] }
  protected
   function GetEnabled: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043423
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
function TK210043423.GetEnabled: Boolean;
//#UC START# *4C07996901BE_4C0795E9018D_var*
//#UC END# *4C07996901BE_4C0795E9018D_var*
begin
//#UC START# *4C07996901BE_4C0795E9018D_impl*
 Result := inherited GetEnabled{false};
 // http://mdp.garant.ru/pages/viewpage.action?pageId=217679801
 // - обратно включил Люлин А.В. т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=217679801&focusedCommentId=217681122#comment-217681122
//#UC END# *4C07996901BE_4C0795E9018D_impl*
end;//TK210043423.GetEnabled

function TK210043423.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210043423.GetFolder

function TK210043423.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C0795E9018D';
end;//TK210043423.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043423.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
