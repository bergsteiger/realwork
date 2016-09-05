unit K233015524;
 {* [$233015524] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K233015524.pas"
// Стереотип: "TestCase"
// Элемент модели: "K233015524" MUID: (4C6CF445008D)
// Имя типа: "TK233015524"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SplitTableTest
;

type
 TK233015524 = class(TSplitTableTest)
  {* [$233015524] }
  protected
   function GetLineCount: Integer; override;
    {* Количество строчек (текста), на которое нужно сдинуть курсор перед разбиванием табилцы на две. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK233015524
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
 //#UC START# *4C6CF445008Dimpl_uses*
 //#UC END# *4C6CF445008Dimpl_uses*
;

function TK233015524.GetLineCount: Integer;
 {* Количество строчек (текста), на которое нужно сдинуть курсор перед разбиванием табилцы на две. }
//#UC START# *4C6CFAE20264_4C6CF445008D_var*
//#UC END# *4C6CFAE20264_4C6CF445008D_var*
begin
//#UC START# *4C6CFAE20264_4C6CF445008D_impl*
 Result := 7;
//#UC END# *4C6CFAE20264_4C6CF445008D_impl*
end;//TK233015524.GetLineCount

function TK233015524.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK233015524.GetFolder

function TK233015524.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C6CF445008D';
end;//TK233015524.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233015524.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
