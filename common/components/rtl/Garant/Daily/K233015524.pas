unit K233015524;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K233015524.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K233015524
//
// [$233015524]
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
  SplitTableTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK233015524 = class(TSplitTableTest)
  {* [$233015524] }
 protected
 // overridden protected methods
   function GetLineCount: Integer; override;
     {* Количество строчек (текста), на которое нужно сдинуть курсор перед разбиванием табилцы на две. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK233015524
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

// start class TK233015524

function TK233015524.GetLineCount: Integer;
//#UC START# *4C6CFAE20264_4C6CF445008D_var*
//#UC END# *4C6CFAE20264_4C6CF445008D_var*
begin
//#UC START# *4C6CFAE20264_4C6CF445008D_impl*
 Result := 7;
//#UC END# *4C6CFAE20264_4C6CF445008D_impl*
end;//TK233015524.GetLineCount

function TK233015524.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK233015524.GetFolder

function TK233015524.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C6CF445008D';
end;//TK233015524.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK233015524.Suite);

end.