unit ReleaseToK;
 {*  (�������� �������) }

// ������: "w:\common\components\SearchTest\ReleaseToK.pas"
// ���������: "TestResults"
// ������� ������: "ReleaseToK" MUID: (BA6E3EC73E04)
// ��� ����: "TReleaseToK"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TReleaseToK = class({$If NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 )
  {*  (�������� �������) }
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
 end;//TReleaseToK
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TReleaseToK.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-ToK';
end;//TReleaseToK.CommandLineKey

class function TReleaseToK.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_BA6E3EC73E04_var*
//#UC END# *4B7C0B43005B_BA6E3EC73E04_var*
begin
//#UC START# *4B7C0B43005B_BA6E3EC73E04_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B43005B_BA6E3EC73E04_impl*
end;//TReleaseToK.TimesPage

class function TReleaseToK.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_BA6E3EC73E04_var*
//#UC END# *4B7C0B670215_BA6E3EC73E04_var*
begin
//#UC START# *4B7C0B670215_BA6E3EC73E04_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7C0B670215_BA6E3EC73E04_impl*
end;//TReleaseToK.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
