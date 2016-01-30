unit arDBUtils;

// ������: "w:\archi\source\projects\Common\Utils\arDBUtils.pas"
// ���������: "UtilityPack"

{$Include arCommon.inc}

interface

uses
 l3IntfUses
;

const
 csBaseFileName = 'EtalonBase.zip';
 csTestBaseDir = 'C:\Base\testbase';
 csTestDocsDir = 'w:\archi\source\projects\Archi\TestSet\ForBase\';
 csTestPictureDir = 'w:\archi\source\projects\Archi\TestSet\ForBase\Picutre';
 csTestBaseArchive = 'w:\archi\source\projects\Archi\TestSet\testbase.zip';
 csUserConfigDir = 'w:\archi\source\projects\Archi\TestSet\TestUserConfig';
 cnArchiTestUserID = 176;

function arUnackBaseFromArchive(const aFileName: AnsiString;
 const aDirName: AnsiString;
 out aMessage: AnsiString): Boolean;
 {* ����������� ���� ������ � �������� �������. }
function CreateTestBaseArchive: Boolean;
 {* ������� testbase.zip � CVS �� ������ C:\Base\TestBase � ������� ���������� }

implementation

uses
 l3ImplUses
 , SysUtils
 , l3FileUtils
 , JclMiscel
 , Windows
 , ddZipUtils
 , l3Base
;

function arUnackBaseFromArchive(const aFileName: AnsiString;
 const aDirName: AnsiString;
 out aMessage: AnsiString): Boolean;
 {* ����������� ���� ������ � �������� �������. }
//#UC START# *4E4A366801E7_4E4A364200F7_var*
var
 l_ExtractBaseCmd : string;
//#UC END# *4E4A366801E7_4E4A364200F7_var*
begin
//#UC START# *4E4A366801E7_4E4A364200F7_impl*
 aMessage := '';
 if not FileExists(aFileName) then
 begin
  aMessage := Format('�� ������ ����� � ������ ����� "%s"', [aFileName]);
  Result := False;
  Exit;
 end; // if not FileExists('EmptyBase.rar') then
 if DirectoryExists(aDirName) then
 begin
  try
   PureDir(aDirName);
   RmDir(aDirName);
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;
 end;
 if ForceDirectories(aDirName) then
 begin
  Result := UnZipFiles(aFileName, aDirName); 
  if not Result then
   aMessage := '�� ������� ����������� �����.' 
 end // if ForceDirectories(aDirName) then
 else
 begin
  aMessage := Format('�� ������� ������� ����������: %s!', [aDirName]);
  Result:= False;
 end;
//#UC END# *4E4A366801E7_4E4A364200F7_impl*
end;//arUnackBaseFromArchive

function CreateTestBaseArchive: Boolean;
 {* ������� testbase.zip � CVS �� ������ C:\Base\TestBase � ������� ���������� }
//#UC START# *527A05660188_4E4A364200F7_var*
//#UC END# *527A05660188_4E4A364200F7_var*
begin
//#UC START# *527A05660188_4E4A364200F7_impl*
 Result := False;
 if FileExists(csTestBaseArchive) then
  if not DeleteFile(csTestBaseArchive) then Exit;
 Result := ZipFiles(csTestBaseArchive, csTestBaseDir);
//#UC END# *527A05660188_4E4A364200F7_impl*
end;//CreateTestBaseArchive

end.
