unit K365838449;
 {* [RequestLink:365838449] }

// ������: "w:\common\components\rtl\Garant\Archi_Tests\K365838449.pas"
// ���������: "TestCase"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ArchiStorageTestWithRename
;

type
 TK365838449 = class(TArchiStorageTestWithRename)
  {* [RequestLink:365838449] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK365838449
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK365838449.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Storage';
end;//TK365838449.GetFolder

function TK365838449.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4FBB6C4D032B';
end;//TK365838449.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK365838449.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
