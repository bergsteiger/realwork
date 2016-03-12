unit toK;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\toK.pas"
// ���������: "TestResults"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoK = class(TTestResultsPlace)
  protected
   {$If NOT Defined(NotTunedDUnit)}
   class function IsGK: Boolean; override;
    {* ����� �������� �� }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
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
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
//#UC START# *4B7AB0B6016E_4DA3327C0398_var*
//#UC END# *4B7AB0B6016E_4DA3327C0398_var*
begin
//#UC START# *4B7AB0B6016E_4DA3327C0398_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_4DA3327C0398_impl*
end;//TtoK.CommandLineKey

class function TtoK.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_4DA3327C0398_var*
//#UC END# *4B7C0B43005B_4DA3327C0398_var*
begin
//#UC START# *4B7C0B43005B_4DA3327C0398_impl*
 Result := 260447843;
//#UC END# *4B7C0B43005B_4DA3327C0398_impl*
end;//TtoK.TimesPage

class function TtoK.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_4DA3327C0398_var*
//#UC END# *4B7C0B670215_4DA3327C0398_var*
begin
//#UC START# *4B7C0B670215_4DA3327C0398_impl*
 Result := 260447840;
//#UC END# *4B7C0B670215_4DA3327C0398_impl*
end;//TtoK.ResultsPage

class function TtoK.IsGK: Boolean;
 {* ����� �������� �� }
//#UC START# *4BEA9969001B_4DA3327C0398_var*
//#UC END# *4BEA9969001B_4DA3327C0398_var*
begin
//#UC START# *4BEA9969001B_4DA3327C0398_impl*
 Result := true;
//#UC END# *4BEA9969001B_4DA3327C0398_impl*
end;//TtoK.IsGK
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
