unit K460262716;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K460262716.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::SandBoxTests::K460262716
//
// {RequestLink:460262716}
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
  CheckingFilesInFolderTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK460262716 = class(TCheckingFilesInFolderTest)
  {* [RequestLink:460262716] }
 protected
 // realized methods
   procedure DoDoit; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK460262716
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK460262716

procedure TK460262716.DoDoit;
//#UC START# *51B1C57B014C_51B1AE6001BB_var*
//#UC END# *51B1C57B014C_51B1AE6001BB_var*
begin
//#UC START# *51B1C57B014C_51B1AE6001BB_impl*
 
//#UC END# *51B1C57B014C_51B1AE6001BB_impl*
end;//TK460262716.DoDoit

function TK460262716.GetFolder: AnsiString;
 {-}
begin
 Result := 'SandBoxTests';
end;//TK460262716.GetFolder

function TK460262716.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51B1AE6001BB';
end;//TK460262716.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK460262716.Suite);

end.