unit ArchiAutoTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/ArchiAutoTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$TestSupport::Archi Insider Test Support::ArchiScriptSupport::TArchiAutoTest
//
// Поддержка автоскриптов в Арчи.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  ArchiInsiderTest
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TArchiAutoTest = class(TArchiInsiderTest)
  {* Поддержка автоскриптов в Арчи. }
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
 end;//TArchiAutoTest
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  StrUtils
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TArchiAutoTest

function TArchiAutoTest.GetFolder: AnsiString;
//#UC START# *4C937013031D_4DE482A503AB_var*
//#UC END# *4C937013031D_4DE482A503AB_var*
begin
//#UC START# *4C937013031D_4DE482A503AB_impl*
 Result := 'Scripts';
//#UC END# *4C937013031D_4DE482A503AB_impl*
end;//TArchiAutoTest.GetFolder

function TArchiAutoTest.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4DE482A503AB_var*
//#UC END# *4DB03121022B_4DE482A503AB_var*
begin
//#UC START# *4DB03121022B_4DE482A503AB_impl*
 if ANSIStartsText('@\', aFileName) then
  Result := FileFromCurrent('Common\' + Copy(aFileName, 3, Length(aFileName) - 2))
 else
  if (ExtractFilePath(aFileName) <> '') then
   Result := aFileName
  else
   Result := FileFromCurrent('Auto') + '\'+ aFileName;
//#UC END# *4DB03121022B_4DE482A503AB_impl*
end;//TArchiAutoTest.ResolveScriptFilePath

class function TArchiAutoTest.IsScript: Boolean;
//#UC START# *4DC395670274_4DE482A503AB_var*
//#UC END# *4DC395670274_4DE482A503AB_var*
begin
//#UC START# *4DC395670274_4DE482A503AB_impl*
 Result := True;
//#UC END# *4DC395670274_4DE482A503AB_impl*
end;//TArchiAutoTest.IsScript

constructor TArchiAutoTest.Create(const aMethodName: AnsiString;
  const aFolder: AnsiString);
//#UC START# *4DC399CA00BC_4DE482A503AB_var*
//#UC END# *4DC399CA00BC_4DE482A503AB_var*
begin
//#UC START# *4DC399CA00BC_4DE482A503AB_impl*
 inherited Create(aMethodName, aFolder);
 FMethod := Self.DoIt;
//#UC END# *4DC399CA00BC_4DE482A503AB_impl*
end;//TArchiAutoTest.Create

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.