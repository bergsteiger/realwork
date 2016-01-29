unit K224133899;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K224133899.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224133899
//
// [$224133899]
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
 TK224133899 = class(TTranslate2TextTest)
  {* [$224133899] }
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
 end;//TK224133899
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

// start class TK224133899

function TK224133899.SelectTableWholly: Boolean;
//#UC START# *4C34625E021F_4C346A9C0180_var*
//#UC END# *4C34625E021F_4C346A9C0180_var*
begin
//#UC START# *4C34625E021F_4C346A9C0180_impl*
 Result := True;
//#UC END# *4C34625E021F_4C346A9C0180_impl*
end;//TK224133899.SelectTableWholly

function TK224133899.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224133899.GetFolder

function TK224133899.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4C346A9C0180_var*
//#UC END# *4CC818F4022D_4C346A9C0180_var*
begin
//#UC START# *4CC818F4022D_4C346A9C0180_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4C346A9C0180_impl*
end;//TK224133899.GetTablePara

function TK224133899.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C346A9C0180';
end;//TK224133899.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224133899.Suite);

end.