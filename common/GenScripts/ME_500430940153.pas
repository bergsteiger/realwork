unit BaseUC;
 {* ����� ��� ������� ����� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\BaseUC.pas"
// ���������: "TestResults"
// ������� ������: "BaseUC" MUID: (500430940153)
// ��� ����: "TBaseUC"

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
 TBaseUC = class(TTestResultsPlace)
  {* ����� ��� ������� ����� ��������� }
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
 end;//TBaseUC
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TBaseUC.CommandLineKey: AnsiString;
 {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
begin
 Result := '-BaseUC';
end;//TBaseUC.CommandLineKey

class function TBaseUC.TimesPage: Integer;
 {* �������� ��� ������ ������� ������� }
//#UC START# *4B7C0B43005B_500430940153_var*
//#UC END# *4B7C0B43005B_500430940153_var*
begin
//#UC START# *4B7C0B43005B_500430940153_impl*
 Result := 378543494;
//#UC END# *4B7C0B43005B_500430940153_impl*
end;//TBaseUC.TimesPage

class function TBaseUC.ResultsPage: Integer;
 {* �������� ��� ������ ����������� ������ }
//#UC START# *4B7C0B670215_500430940153_var*
//#UC END# *4B7C0B670215_500430940153_var*
begin
//#UC START# *4B7C0B670215_500430940153_impl*
 Result := 378543492;
//#UC END# *4B7C0B670215_500430940153_impl*
end;//TBaseUC.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
