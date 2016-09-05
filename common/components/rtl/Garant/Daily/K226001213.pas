unit K226001213;
 {* [$226001213] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K226001213.pas"
// Стереотип: "TestCase"
// Элемент модели: "K226001213" MUID: (4C3C2D63027E)
// Имя типа: "TK226001213"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ColumnAlignHorisontallyTest
;

type
 TK226001213 = class(TColumnAlignHorisontallyTest)
  {* [$226001213] }
  protected
   function SelectColumn(var aColID: Integer): Boolean; override;
    {* Выделить колонку aColID }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK226001213
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
 //#UC START# *4C3C2D63027Eimpl_uses*
 //#UC END# *4C3C2D63027Eimpl_uses*
;

function TK226001213.SelectColumn(var aColID: Integer): Boolean;
 {* Выделить колонку aColID }
//#UC START# *4C9874060367_4C3C2D63027E_var*
//#UC END# *4C9874060367_4C3C2D63027E_var*
begin
//#UC START# *4C9874060367_4C3C2D63027E_impl*
 Result := True;
 aColID := 1;
//#UC END# *4C9874060367_4C3C2D63027E_impl*
end;//TK226001213.SelectColumn

function TK226001213.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK226001213.GetFolder

function TK226001213.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3C2D63027E';
end;//TK226001213.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226001213.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
