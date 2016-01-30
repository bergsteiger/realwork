unit K293280527;
 {* [RequestLink:293280527] }

// ������: "w:\common\components\rtl\Garant\Daily\K293280527.pas"
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
 TK293280527 = class(TBaseTest)
  {* [RequestLink:293280527] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  public
   procedure DoIt;
 end;//TK293280527
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3InterfaceList
 , l3Base
 , l3String
 , SysUtils
 , l3Interfaces
;

procedure TK293280527.DoIt;
//#UC START# *4E982F43023D_4E982F1802E7_var*
var
 l_S1 : Tl3CDelphiString;
 l_S3 : Tl3CDelphiString;
 l_List : Tl3InterfaceList;
//#UC END# *4E982F43023D_4E982F1802E7_var*
begin
//#UC START# *4E982F43023D_4E982F1802E7_impl*
 l_List := Tl3InterfaceList.Make;
 try
  l_S1 := Tl3CDelphiString.Create('���');
  try
   l_S3 := Tl3CDelphiString.Create('���');
   try
    l_List.Add(Il3CString(l_S1));
    l_List.Add(l3CStr('���'));
    l_List.Add(Il3CString(l_S3));
    l_List.Move(0, 2);
    Check(l_S1.RefCount = 2);
    Check(l_S3.RefCount = 2);
    Check(l3Same(Il3CString(l_List[0]), '���'));
    Check(l3Same(Il3CString(l_List[1]), '���'));
    Check(l3Same(Il3CString(l_List[2]), '���'));
    l_List.Move(2, 0);
    Check(l3Same(Il3CString(l_List[0]), '���'));
    Check(l3Same(Il3CString(l_List[1]), '���'));
    Check(l3Same(Il3CString(l_List[2]), '���'));
   finally
    FreeAndNil(l_S3);
   end;//try..finally
  finally
   FreeAndNil(l_S1);
  end;//try..finally
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *4E982F43023D_4E982F1802E7_impl*
end;//TK293280527.DoIt

function TK293280527.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.7 Lulin';
end;//TK293280527.GetFolder

function TK293280527.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E982F1802E7';
end;//TK293280527.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK293280527.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
