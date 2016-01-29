unit K239894899;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K239894899.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K239894899
//
// [$239894899]
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
 TK239894899 = class(TPreviewTestBefore235875079WithRowCmp)
  {* [$239894899] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetHAFFontSize: Integer; override;
     {* Размер колонтитулов. 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
 end;//TK239894899
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

// start class TK239894899

{$If defined(nsTest) AND not defined(NoVCM)}
function TK239894899.GetHAFFontSize: Integer;
//#UC START# *4C2224D00159_4CDBC300002E_var*
//#UC END# *4C2224D00159_4CDBC300002E_var*
begin
//#UC START# *4C2224D00159_4CDBC300002E_impl*
 Result := 12;
//#UC END# *4C2224D00159_4CDBC300002E_impl*
end;//TK239894899.GetHAFFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK239894899.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK239894899.GetFolder

function TK239894899.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CDBC300002E';
end;//TK239894899.GetModelElementGUID

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TK239894899.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4CDBC300002E_var*
//#UC END# *51AF49E5001B_4CDBC300002E_var*
begin
//#UC START# *51AF49E5001B_4CDBC300002E_impl*
 Result := true;
//#UC END# *51AF49E5001B_4CDBC300002E_impl*
end;//TK239894899.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK239894899.Suite);

end.