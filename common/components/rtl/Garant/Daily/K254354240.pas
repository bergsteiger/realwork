unit K254354240;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K254354240.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K254354240
//
// [$254354240]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  DrawSelectionInTableTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK254354240 = class(TDrawSelectionInTableTest)
  {* [$254354240] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
     {* Возвращает параграф с таблицей }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
     {* Получить "координаты" точек выделения. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK254354240
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK254354240

function TK254354240.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK254354240.GetFolder

function TK254354240.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4D6F51C602F5_var*
//#UC END# *4CC818F4022D_4D6F51C602F5_var*
begin
//#UC START# *4CC818F4022D_4D6F51C602F5_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D6F51C602F5_impl*
end;//TK254354240.GetTablePara

procedure TK254354240.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4D6F51C602F5_var*
//#UC END# *4CC81D4101AC_4D6F51C602F5_var*
begin
//#UC START# *4CC81D4101AC_4D6F51C602F5_impl*
 aStartRow := 0;
 aStartCell := 1;
 aFinishRow := 0;
 aFinishCell := 1;
//#UC END# *4CC81D4101AC_4D6F51C602F5_impl*
end;//TK254354240.GetSelectParam

function TK254354240.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D6F51C602F5';
end;//TK254354240.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK254354240.Suite);

end.