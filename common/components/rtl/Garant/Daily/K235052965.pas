unit K235052965;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K235052965.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K235052965
//
// [$235052965]
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
  SelectColumnAndDelete
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK235052965 = class(TSelectColumnAndDelete)
  {* [$235052965] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function SelectColumn(var aColID: Integer): Boolean; override;
     {* Выделить колонку aColID }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK235052965
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

// start class TK235052965

function TK235052965.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK235052965.GetFolder

function TK235052965.SelectColumn(var aColID: Integer): Boolean;
//#UC START# *4C9874060367_4C99A80900C4_var*
//#UC END# *4C9874060367_4C99A80900C4_var*
begin
//#UC START# *4C9874060367_4C99A80900C4_impl*
 Result := True;
 aColID := 2;
//#UC END# *4C9874060367_4C99A80900C4_impl*
end;//TK235052965.SelectColumn

function TK235052965.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C99A80900C4';
end;//TK235052965.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK235052965.Suite);

end.