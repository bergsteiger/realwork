unit DailyAutoTest;
 {* Автотест с поддержкой создаваемых форм. }

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\DailyAutoTest.pas"
// Стереотип: "SimpleClass"

{$Include dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TDailyAutoTest = {abstract} class(TAutoTest)
  {* Автотест с поддержкой создаваемых форм. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
   class function IsScript: Boolean; override;
    {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
  public
   constructor Create(const aMethodName: AnsiString;
    const aFolder: AnsiString); override;
 end;//TDailyAutoTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

function TDailyAutoTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
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
 {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
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
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
