unit DailyAutoTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnit Script Support"
// Модуль: "w:/common/components/rtl/Garant/DUnit_Script_Support/DailyAutoTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnit Script Support::DUnitKeyWordsSupport::TDailyAutoTest
//
// Автотест с поддержкой создаваемых форм.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnit_Script_Support\dsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  AutoTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TDailyAutoTest = {abstract} class(TAutoTest)
  {* Автотест с поддержкой создаваемых форм. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
   class function IsScript: Boolean; override;
     {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
 public
 // overridden public methods
   constructor Create(const aMethodName: AnsiString;
    const aFolder: AnsiString); override;
 end;//TDailyAutoTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TDailyAutoTest

function TDailyAutoTest.GetFolder: AnsiString;
//#UC START# *4C937013031D_4E297BC401BE_var*
//#UC END# *4C937013031D_4E297BC401BE_var*
begin
//#UC START# *4C937013031D_4E297BC401BE_impl*
 Result := 'Scripts';
//#UC END# *4C937013031D_4E297BC401BE_impl*
end;//TDailyAutoTest.GetFolder

function TDailyAutoTest.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4E297BC401BE_var*
//#UC END# *4DB03121022B_4E297BC401BE_var*
begin
//#UC START# *4DB03121022B_4E297BC401BE_impl*
 if (ExtractFilePath(aFileName) <> '') then
  Result := aFileName
 else
  Result := FileFromCurrent('Auto') + '\'+ aFileName;
//#UC END# *4DB03121022B_4E297BC401BE_impl*
end;//TDailyAutoTest.ResolveScriptFilePath

class function TDailyAutoTest.IsScript: Boolean;
//#UC START# *4DC395670274_4E297BC401BE_var*
//#UC END# *4DC395670274_4E297BC401BE_var*
begin
//#UC START# *4DC395670274_4E297BC401BE_impl*
 Result := True;
//#UC END# *4DC395670274_4E297BC401BE_impl*
end;//TDailyAutoTest.IsScript

constructor TDailyAutoTest.Create(const aMethodName: AnsiString;
  const aFolder: AnsiString);
//#UC START# *4DC399CA00BC_4E297BC401BE_var*
//#UC END# *4DC399CA00BC_4E297BC401BE_var*
begin
//#UC START# *4DC399CA00BC_4E297BC401BE_impl*
 inherited Create(aMethodName, aFolder);
 FMethod := Self.DoIt;
//#UC END# *4DC399CA00BC_4E297BC401BE_impl*
end;//TDailyAutoTest.Create

{$IfEnd} //nsTest AND not NoScripts

end.