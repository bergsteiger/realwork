unit toK;

// ������: "w:\archi\source\projects\PipeInAuto\toK.pas"
// ���������: "TestResults"
// ������� ������: "toK" MUID: (52F250640165)
// ��� ����: "TtoK"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TtoK = class({$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 TTestResultsPlace
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 )
  public
   {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
    {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
   {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
   {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
    {* �������� ��� ������ ������� ������� }
   {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
   {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
    {* �������� ��� ������ ����������� ������ }
   {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 end;//TtoK
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-toK';
end;//TtoK.CommandLineKey

class function TtoK.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_52F250640165_var*
//#UC END# *4B7C0B43005B_52F250640165_var*
begin
//#UC START# *4B7C0B43005B_52F250640165_impl*
 Result := 516170212;
//#UC END# *4B7C0B43005B_52F250640165_impl*
end;//TtoK.TimesPage

class function TtoK.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_52F250640165_var*
//#UC END# *4B7C0B670215_52F250640165_var*
begin
//#UC START# *4B7C0B670215_52F250640165_impl*
 Result := 516170210;
//#UC END# *4B7C0B670215_52F250640165_impl*
end;//TtoK.ResultsPage
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(AppServerSide)
end.
