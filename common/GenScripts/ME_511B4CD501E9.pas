unit ToK;

// ������: "w:\common\components\SearchTest\ToK.pas"
// ���������: "TestResults"
// ������� ������: "ToK" MUID: (511B4CD501E9)
// ��� ����: "TToK"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TToK = class(TTestResultsPlace)
  public
   {$If NOT Defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
    {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
    {* �������� ��� ������ ������� ������� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
    {* �������� ��� ������ ����������� ������ }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
 end;//TToK
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TToK.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_511B4CD501E9_var*
//#UC END# *4B7AB0B6016E_511B4CD501E9_var*
begin
//#UC START# *4B7AB0B6016E_511B4CD501E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_511B4CD501E9_impl*
end;//TToK.CommandLineKey

class function TToK.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_511B4CD501E9_var*
//#UC END# *4B7C0B43005B_511B4CD501E9_var*
begin
//#UC START# *4B7C0B43005B_511B4CD501E9_impl*
 Result := 430737727;
//#UC END# *4B7C0B43005B_511B4CD501E9_impl*
end;//TToK.TimesPage

class function TToK.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_511B4CD501E9_var*
//#UC END# *4B7C0B670215_511B4CD501E9_var*
begin
//#UC START# *4B7C0B670215_511B4CD501E9_impl*
 Result := 430737722;
//#UC END# *4B7C0B670215_511B4CD501E9_impl*
end;//TToK.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
