unit toKT;

// ������: "w:\archi\source\projects\Archi\toKT.pas"
// ���������: "TestResults"
// ������� ������: "toKT" MUID: (525FC3B4005D)
// ��� ����: "TtoKT"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoKT = class(TTestResultsPlace)
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
 end;//TtoKT
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKT.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_525FC3B4005D_var*
//#UC END# *4B7AB0B6016E_525FC3B4005D_var*
begin
//#UC START# *4B7AB0B6016E_525FC3B4005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_525FC3B4005D_impl*
end;//TtoKT.CommandLineKey

class function TtoKT.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_525FC3B4005D_var*
//#UC END# *4B7C0B43005B_525FC3B4005D_var*
begin
//#UC START# *4B7C0B43005B_525FC3B4005D_impl*
 Result := 493857845;
//#UC END# *4B7C0B43005B_525FC3B4005D_impl*
end;//TtoKT.TimesPage

class function TtoKT.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_525FC3B4005D_var*
//#UC END# *4B7C0B670215_525FC3B4005D_var*
begin
//#UC START# *4B7C0B670215_525FC3B4005D_impl*
 Result := 493857780;
//#UC END# *4B7C0B670215_525FC3B4005D_impl*
end;//TtoKT.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
