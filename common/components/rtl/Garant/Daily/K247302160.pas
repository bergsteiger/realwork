unit K247302160;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K247302160.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K247302160
//
// [$247302160]
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
  TextMericsAfterDeleteTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK247302160 = class(TTextMericsAfterDeleteTest)
  {* [$247302160] }
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
 end;//TK247302160
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

// start class TK247302160

function TK247302160.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK247302160.GetFolder

function TK247302160.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4D1B0E6A00CF_var*
//#UC END# *4CC818F4022D_4D1B0E6A00CF_var*
begin
//#UC START# *4CC818F4022D_4D1B0E6A00CF_impl*
 Result := aDocument.Para[6].AsList;
//#UC END# *4CC818F4022D_4D1B0E6A00CF_impl*
end;//TK247302160.GetTablePara

procedure TK247302160.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4D1B0E6A00CF_var*
//#UC END# *4CC81D4101AC_4D1B0E6A00CF_var*
begin
//#UC START# *4CC81D4101AC_4D1B0E6A00CF_impl*
 aStartRow := 7;
 aStartCell := 0;
 aFinishRow := 11;
 aFinishCell := 6;
//#UC END# *4CC81D4101AC_4D1B0E6A00CF_impl*
end;//TK247302160.GetSelectParam

function TK247302160.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D1B0E6A00CF';
end;//TK247302160.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK247302160.Suite);

end.