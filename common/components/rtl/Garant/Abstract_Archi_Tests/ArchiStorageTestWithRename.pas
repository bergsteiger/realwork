unit ArchiStorageTestWithRename;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Archi Tests"
// ������: "w:/common/components/rtl/Garant/Abstract_Archi_Tests/ArchiStorageTestWithRename.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Archi Tests::Storage::TArchiStorageTestWithRename
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ArchiStorageTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TArchiStorageTestWithRename = {abstract} class(TArchiStorageTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   function NeedTestRenaming: Boolean; override;
 end;//TArchiStorageTestWithRename
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TArchiStorageTestWithRename

function TArchiStorageTestWithRename.GetFolder: AnsiString;
 {-}
begin
 Result := 'Storage';
end;//TArchiStorageTestWithRename.GetFolder

function TArchiStorageTestWithRename.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4FBB6C0D0366';
end;//TArchiStorageTestWithRename.GetModelElementGUID

function TArchiStorageTestWithRename.NeedTestRenaming: Boolean;
//#UC START# *4FBB73390387_4FBB6C0D0366_var*
//#UC END# *4FBB73390387_4FBB6C0D0366_var*
begin
//#UC START# *4FBB73390387_4FBB6C0D0366_impl*
 Result := true;
//#UC END# *4FBB73390387_4FBB6C0D0366_impl*
end;//TArchiStorageTestWithRename.NeedTestRenaming

{$IfEnd} //nsTest AND not NoScripts

end.