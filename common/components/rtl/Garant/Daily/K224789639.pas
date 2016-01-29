unit K224789639;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K224789639.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224789639
//
// [$224789639]
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
  PreviewTestBefore235875079WithRowCmp
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK224789639 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$224789639] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK224789639
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  PrintRowHeightsSpy
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

// start class TK224789639

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224789639.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4CBC1CA70020_var*
//#UC END# *4C07AC6F036D_4CBC1CA70020_var*
begin
//#UC START# *4C07AC6F036D_4CBC1CA70020_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4CBC1CA70020_impl*
end;//TK224789639.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK224789639.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224789639.GetFolder

function TK224789639.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CBC1CA70020';
end;//TK224789639.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224789639.Suite);

end.