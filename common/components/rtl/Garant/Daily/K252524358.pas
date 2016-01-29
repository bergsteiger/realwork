unit K252524358;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K252524358.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K252524358
//
// [$252524358]
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
  Translate2TextTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK252524358 = class(TTranslate2TextTest)
  {* [$252524358] }
 protected
 // overridden protected methods
   function SelectTableWholly: Boolean; override;
     {* Вылять таблицу целиком }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
     {* Возвращает параграф с таблицей }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK252524358
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

// start class TK252524358

function TK252524358.SelectTableWholly: Boolean;
//#UC START# *4C34625E021F_4D51578F03E7_var*
//#UC END# *4C34625E021F_4D51578F03E7_var*
begin
//#UC START# *4C34625E021F_4D51578F03E7_impl*
 Result := True;
//#UC END# *4C34625E021F_4D51578F03E7_impl*
end;//TK252524358.SelectTableWholly

function TK252524358.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK252524358.GetFolder

function TK252524358.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4D51578F03E7_var*
//#UC END# *4CC818F4022D_4D51578F03E7_var*
begin
//#UC START# *4CC818F4022D_4D51578F03E7_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D51578F03E7_impl*
end;//TK252524358.GetTablePara

function TK252524358.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D51578F03E7';
end;//TK252524358.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK252524358.Suite);

end.