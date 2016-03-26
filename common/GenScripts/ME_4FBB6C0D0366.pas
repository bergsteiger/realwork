unit ArchiStorageTestWithRename;

// ������: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\ArchiStorageTestWithRename.pas"
// ���������: "TestCase"
// ������� ������: "TArchiStorageTestWithRename" MUID: (4FBB6C0D0366)

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ArchiStorageTest
;

type
 TArchiStorageTestWithRename = {abstract} class(TArchiStorageTest)
  protected
   function NeedTestRenaming: Boolean; override;
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TArchiStorageTestWithRename
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TArchiStorageTestWithRename.NeedTestRenaming: Boolean;
//#UC START# *4FBB73390387_4FBB6C0D0366_var*
//#UC END# *4FBB73390387_4FBB6C0D0366_var*
begin
//#UC START# *4FBB73390387_4FBB6C0D0366_impl*
 Result := true;
//#UC END# *4FBB73390387_4FBB6C0D0366_impl*
end;//TArchiStorageTestWithRename.NeedTestRenaming

function TArchiStorageTestWithRename.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Storage';
end;//TArchiStorageTestWithRename.GetFolder

function TArchiStorageTestWithRename.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FBB6C0D0366';
end;//TArchiStorageTestWithRename.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
