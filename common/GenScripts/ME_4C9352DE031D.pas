unit K234363615;
 {* [RequestLink:234363615]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K234363615.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CopyPasteTest
 , nevTools
 , evCustomEditorWindow
 , l3Variant
;

type
 TK234363615 = class(TCopyPasteTest)
  {* [RequestLink:234363615]. }
  protected
   function DoSelect(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack): InevRange; override;
    {* Выделяет текст в редакторе }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK234363615
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3Base
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TK234363615.DoSelect(aText: TevCustomEditorWindow;
 const anOp: Il3OpPack): InevRange;
 {* Выделяет текст в редакторе }
//#UC START# *4C93538E0218_4C9352DE031D_var*
//#UC END# *4C93538E0218_4C9352DE031D_var*
begin
//#UC START# *4C93538E0218_4C9352DE031D_impl*
 Result := aText.Document.Para[4].Range;
//#UC END# *4C93538E0218_4C9352DE031D_impl*
end;//TK234363615.DoSelect

function TK234363615.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK234363615.GetFolder

function TK234363615.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C9352DE031D';
end;//TK234363615.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK234363615.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
