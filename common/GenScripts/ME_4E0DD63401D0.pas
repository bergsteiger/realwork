unit K271754584;
 {* [RequestLink:271754584] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K271754584.pas"
// Стереотип: "TestCase"
// Элемент модели: "K271754584" MUID: (4E0DD63401D0)
// Имя типа: "TK271754584"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HorzMergeCells
;

type
 TK271754584 = class(THorzMergeCells)
  {* [RequestLink:271754584] }
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
 end;//TK271754584
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

function TK271754584.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK271754584.GetFolder

procedure TK271754584.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* Получить "координаты" точек выделения. }
//#UC START# *4CC81D4101AC_4E0DD63401D0_var*
//#UC END# *4CC81D4101AC_4E0DD63401D0_var*
begin
//#UC START# *4CC81D4101AC_4E0DD63401D0_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 2;
 aFinishCell := 1;
//#UC END# *4CC81D4101AC_4E0DD63401D0_impl*
end;//TK271754584.GetSelectParam

function TK271754584.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E0DD63401D0';
end;//TK271754584.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK271754584.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
