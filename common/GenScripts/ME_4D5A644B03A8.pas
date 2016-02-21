unit K253668263;
 {* [$253668263] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K253668263.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SplitCellTest
;

type
 TK253668263 = class(TSplitCellTest)
  {* [$253668263] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetLineCount: Integer; override;
   function GetTabCount: Integer; override;
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK253668263
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK253668263.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK253668263.GetFolder

function TK253668263.GetLineCount: Integer;
//#UC START# *4D5A6EE600D3_4D5A644B03A8_var*
//#UC END# *4D5A6EE600D3_4D5A644B03A8_var*
begin
//#UC START# *4D5A6EE600D3_4D5A644B03A8_impl*
 Result := 1;
//#UC END# *4D5A6EE600D3_4D5A644B03A8_impl*
end;//TK253668263.GetLineCount

function TK253668263.GetTabCount: Integer;
//#UC START# *4D5A6F4802CB_4D5A644B03A8_var*
//#UC END# *4D5A6F4802CB_4D5A644B03A8_var*
begin
//#UC START# *4D5A6F4802CB_4D5A644B03A8_impl*
 Result := 1;
//#UC END# *4D5A6F4802CB_4D5A644B03A8_impl*
end;//TK253668263.GetTabCount

function TK253668263.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D5A644B03A8';
end;//TK253668263.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253668263.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
