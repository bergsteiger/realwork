unit PrimMedicListSynchroView_mlsfDrugList_UserType;
 {* ���������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfDrugList_UserType.pas"
// ���������: "UserType"
// ������� ������: "mlsfDrugList" MUID: (4BD6C82400DF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ mlsfDrugListLocalConstants }
 str_mlsfDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfDrugListCaption'; rValue : '���������� ��������');
  {* ��������� ����������������� ���� "���������� ��������" }
 {* ��������� ��� ���� ����� mlsfDrugList }
 mlsfDrugListName = 'mlsfDrugList';
  {* ��������� ������������� ����������������� ���� "���������� ��������" }
 mlsfDrugList = TvcmUserType(0);
  {* ���������� �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_mlsfDrugList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� mlsfDrugList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_mlsfDrugList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_mlsfDrugList.GetInteger: Integer;
begin
 Result := mlsfDrugList;
end;//Tkw_FormUserType_mlsfDrugList.GetInteger

class function Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::mlsfDrugList';
end;//Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_mlsfDrugListCaption.Init;
 {* ������������� str_mlsfDrugListCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfDrugList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_mlsfDrugList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
