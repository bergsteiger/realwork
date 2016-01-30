unit K265411837;
 {* [$265411837] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K265411837.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HorzMergeCells
;

type
 TK265411837 = class(THorzMergeCells)
  {* [$265411837] }
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
 end;//TK265411837
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK265411837.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK265411837.GetFolder

procedure TK265411837.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* Получить "координаты" точек выделения. }
//#UC START# *4CC81D4101AC_4DCA1DB203B7_var*
//#UC END# *4CC81D4101AC_4DCA1DB203B7_var*
begin
//#UC START# *4CC81D4101AC_4DCA1DB203B7_impl*
 aStartRow := 0;
 aStartCell := 3;
 aFinishRow := 1;
 aFinishCell := 5;
//#UC END# *4CC81D4101AC_4DCA1DB203B7_impl*
end;//TK265411837.GetSelectParam

function TK265411837.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DCA1DB203B7';
end;//TK265411837.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK265411837.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
