unit CheckingFilesInFolderTest;

// ������: "w:\common\components\rtl\Garant\Abstract_Tests\CheckingFilesInFolderTest.pas"
// ���������: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TCheckingFilesInFolderTest = {abstract} class(TBaseTest)
  protected
   procedure DoDoit; virtual; abstract;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$If NOT Defined(NotTunedDUnit)}
   function OutputFolderName: AnsiString; override;
    {* �����, � ������� ������� �������� �����. }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
  public
   procedure DoIt;
 end;//TCheckingFilesInFolderTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , l3FileUtils
 , SysUtils
;

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
 {* ����� � ������� ������ ���� }
begin
 Result := 'CheckFilesInFolderTest';
end;//TCheckingFilesInFolderTest.GetFolder

function TCheckingFilesInFolderTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '51B1ADF20017';
end;//TCheckingFilesInFolderTest.GetModelElementGUID

{$If NOT Defined(NotTunedDUnit)}
function TCheckingFilesInFolderTest.OutputFolderName: AnsiString;
 {* �����, � ������� ������� �������� �����. }
//#UC START# *51B1A75D0367_51B1ADF20017_var*
//#UC END# *51B1A75D0367_51B1ADF20017_var*
begin
//#UC START# *51B1A75D0367_51B1ADF20017_impl*
 Result := ClassName;
//#UC END# *51B1A75D0367_51B1ADF20017_impl*
end;//TCheckingFilesInFolderTest.OutputFolderName
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
