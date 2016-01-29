unit CheckingFilesInFolderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/CheckingFilesInFolderTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::CheckFilesInFolderTest::TCheckingFilesInFolderTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TCheckingFilesInFolderTest = {abstract} class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function OutputFolderName: AnsiString; override;
     {* Папка, в которую пишутся выходные файлы. }
    {$IfEnd} //nsTest AND not NotTunedDUnit
 protected
 // protected methods
   procedure DoDoit; virtual; abstract;
 published
 // published methods
   procedure DoIt;
 end;//TCheckingFilesInFolderTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Base,
  l3FileUtils,
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TCheckingFilesInFolderTest

procedure TCheckingFilesInFolderTest.DoIt;
//#UC START# *51B1AEC2015B_51B1ADF20017_var*

 procedure lp_CopyFiles;
 begin
  CopyFilesByMask(FolderFromCurrent(ClassName), GetFullPath2OutputFolderName, '*.script');
 end;

//#UC END# *51B1AEC2015B_51B1ADF20017_var*
begin
//#UC START# *51B1AEC2015B_51B1ADF20017_impl*
 ClearTestFolder;
 lp_CopyFiles;
 CheckEtalonInFolder('%');
//#UC END# *51B1AEC2015B_51B1ADF20017_impl*
end;//TCheckingFilesInFolderTest.DoIt

function TCheckingFilesInFolderTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'CheckFilesInFolderTest';
end;//TCheckingFilesInFolderTest.GetFolder

function TCheckingFilesInFolderTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51B1ADF20017';
end;//TCheckingFilesInFolderTest.GetModelElementGUID

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TCheckingFilesInFolderTest.OutputFolderName: AnsiString;
//#UC START# *51B1A75D0367_51B1ADF20017_var*
//#UC END# *51B1A75D0367_51B1ADF20017_var*
begin
//#UC START# *51B1A75D0367_51B1ADF20017_impl*
 Result := ClassName;
//#UC END# *51B1A75D0367_51B1ADF20017_impl*
end;//TCheckingFilesInFolderTest.OutputFolderName
{$IfEnd} //nsTest AND not NotTunedDUnit

{$IfEnd} //nsTest AND not NoScripts

end.