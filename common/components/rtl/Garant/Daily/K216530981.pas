unit K216530981;
 {* [$216530981] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K216530981.pas"
// Стереотип: "TestCase"
// Элемент модели: "K216530981" MUID: (4C123FA0030D)
// Имя типа: "TK216530981"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
;

type
 TK216530981 = class(TMergeCellsTest)
  {* [$216530981] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* Получить "координаты" точек выделения. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK216530981
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
 //#UC START# *4C123FA0030Dimpl_uses*
 //#UC END# *4C123FA0030Dimpl_uses*
;

function TK216530981.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK216530981.GetFolder

procedure TK216530981.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* Получить "координаты" точек выделения. }
//#UC START# *4CC81D4101AC_4C123FA0030D_var*
//#UC END# *4CC81D4101AC_4C123FA0030D_var*
begin
//#UC START# *4CC81D4101AC_4C123FA0030D_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 2;
 aFinishCell := 1;
//#UC END# *4CC81D4101AC_4C123FA0030D_impl*
end;//TK216530981.GetSelectParam

function TK216530981.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C123FA0030D';
end;//TK216530981.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK216530981.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
