unit K226001213;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K226001213.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K226001213
//
// [$226001213]
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
  ColumnAlignHorisontallyTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK226001213 = class(TColumnAlignHorisontallyTest)
  {* [$226001213] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function SelectColumn(var aColID: Integer): Boolean; override;
     {* Выделить колонку aColID }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK226001213
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

// start class TK226001213

function TK226001213.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK226001213.GetFolder

function TK226001213.SelectColumn(var aColID: Integer): Boolean;
//#UC START# *4C9874060367_4C3C2D63027E_var*
//#UC END# *4C9874060367_4C3C2D63027E_var*
begin
//#UC START# *4C9874060367_4C3C2D63027E_impl*
 Result := True;
 aColID := 1;
//#UC END# *4C9874060367_4C3C2D63027E_impl*
end;//TK226001213.SelectColumn

function TK226001213.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3C2D63027E';
end;//TK226001213.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK226001213.Suite);

end.