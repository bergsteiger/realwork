unit K347636412;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K347636412.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K347636412
//
// {Requestlink:347636412}
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
  MergeCellsTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK347636412 = class(TMergeCellsTest)
  {* [Requestlink:347636412] }
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
 end;//TK347636412
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
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

// start class TK347636412

function TK347636412.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK347636412.GetFolder

function TK347636412.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4F6C568000A6_var*
//#UC END# *4CC818F4022D_4F6C568000A6_var*
begin
//#UC START# *4CC818F4022D_4F6C568000A6_impl*
 Result := aDocument.Para[0].AsList;
//#UC END# *4CC818F4022D_4F6C568000A6_impl*
end;//TK347636412.GetTablePara

procedure TK347636412.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4F6C568000A6_var*
//#UC END# *4CC81D4101AC_4F6C568000A6_var*
begin
//#UC START# *4CC81D4101AC_4F6C568000A6_impl*
 aStartRow := 3;
 aStartCell := 5;
 aFinishRow := 12;
 aFinishCell := 5;
//#UC END# *4CC81D4101AC_4F6C568000A6_impl*
end;//TK347636412.GetSelectParam

function TK347636412.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4F6C568000A6';
end;//TK347636412.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK347636412.Suite);

end.