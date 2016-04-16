unit K235868845;
 {* [RequestLink:235868845] }

// ������: "w:\common\components\rtl\Garant\TestForTFW\K235868845.pas"
// ���������: "TestCase"
// ������� ������: "K235868845" MUID: (4CAC95AC011D)
// ��� ����: "TK235868845"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TK235868845 = class({$If NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {* [RequestLink:235868845] }
  protected
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
  published
   procedure DoIt;
 end;//TK235868845
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
procedure TK235868845.DoIt;
//#UC START# *4CAC95F60396_4CAC95AC011D_var*
var
 l_N : String;
 l_F : Text;
//#UC END# *4CAC95F60396_4CAC95AC011D_var*
begin
//#UC START# *4CAC95F60396_4CAC95AC011D_impl*
 l_N := FileForOutput;
 AssignFile(l_F, l_N);
 Rewrite(l_F);
 try
  System.WriteLn(l_F, '����������, ����� ��������� �� ������');
 finally
  CloseFile(l_F);
 end;//try..finally
 CheckOutputWithInput(KPage + EtalonSuffix + '.fake');
//#UC END# *4CAC95F60396_4CAC95AC011D_impl*
end;//TK235868845.DoIt

function TK235868845.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TFWTests';
end;//TK235868845.GetFolder

function TK235868845.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CAC95AC011D';
end;//TK235868845.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235868845.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
