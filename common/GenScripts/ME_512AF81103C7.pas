unit toK;

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\toK.pas"
// ���������: "TestResults"

{$Include w:\archi\source\projects\Everest\Lite\7.0\Express\EverestLite.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoK = class(TTestResultsPlace)
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
 end;//TtoK
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_512AF81103C7_var*
//#UC END# *4B7AB0B6016E_512AF81103C7_var*
begin
//#UC START# *4B7AB0B6016E_512AF81103C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_512AF81103C7_impl*
end;//TtoK.CommandLineKey
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoK.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_512AF81103C7_var*
//#UC END# *4B7C0B43005B_512AF81103C7_var*
begin
//#UC START# *4B7C0B43005B_512AF81103C7_impl*
 Result := 433561379;
//#UC END# *4B7C0B43005B_512AF81103C7_impl*
end;//TtoK.TimesPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$If NOT Defined(NotTunedDUnit)}
class function TtoK.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_512AF81103C7_var*
//#UC END# *4B7C0B670215_512AF81103C7_var*
begin
//#UC START# *4B7C0B670215_512AF81103C7_impl*
 Result := 433561370;
//#UC END# *4B7C0B670215_512AF81103C7_impl*
end;//TtoK.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
