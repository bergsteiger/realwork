unit l3StringToStringMapTest;

// ������: "w:\common\components\rtl\Garant\Daily\l3StringToStringMapTest.pas"
// ���������: "TestCase"
// ������� ������: "Tl3StringToStringMapTest" MUID: (569F67CE017B)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 Tl3StringToStringMapTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//Tl3StringToStringMapTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3StringToStringMap
 , TestFrameWork
 , SysUtils
 , l3Base
 , l3Interfaces
 , l3String
;

{$If NOT Defined(NotTunedDUnit)}
procedure Tl3StringToStringMapTest.DoIt;
//#UC START# *569F68230027_569F67CE017B_var*
var
 l_M: Tl3StringToStringMap;
//#UC END# *569F68230027_569F67CE017B_var*
begin
//#UC START# *569F68230027_569F67CE017B_impl*
 l_M := Tl3StringToStringMap.Create;
 try
  l_M.Add(l3CStr('�������'), l3CStr('����'));
  l_M.Add(l3CStr('������'), l3CStr('�����'));
  l_M.Add(l3CStr('�������'), l3CStr('������� ������'));

  CheckTrue(l_M.Has(l3CStr('�������')));
  CheckTrue(l_M.Has(l3CStr('������')));
  CheckTrue(l_M.Has(l3CStr('�������')));
  CheckFalse(l_M.Has(l3CStr('������ ��� ���')));

  CheckTrue(l_M.IndexByKey(l3CStr('�������')) = 1);
  CheckTrue(l_M.IndexByKey(l3CStr('������'))  = 2);
  CheckTrue(l_M.IndexByKey(l3CStr('�������')) = 0);
  CheckTrue(l_M.IndexByKey(l3CStr('������ ��� ���')) = -1);

  CheckTrue(l3Same(l_M.ValueByKey(l3CStr('�������')), l3CStr('����')));
  CheckTrue(l3Same(l_M.ValueByKey(l3CStr('������')), l3CStr('�����')));
  CheckTrue(l3Same(l_M.ValueByKey(l3CStr('�������')), l3CStr('������� ������')));
 finally
  FreeAndNil(l_M);
 end;
//#UC END# *569F68230027_569F67CE017B_impl*
end;//Tl3StringToStringMapTest.DoIt

function Tl3StringToStringMapTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := '7.11';
end;//Tl3StringToStringMapTest.GetFolder

function Tl3StringToStringMapTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '569F67CE017B';
end;//Tl3StringToStringMapTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(Tl3StringToStringMapTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
