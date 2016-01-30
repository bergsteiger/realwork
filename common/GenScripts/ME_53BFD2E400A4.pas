unit DocumentUserTypes_dftChronology_UserType;
 {* ���������� ��������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftChronology_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACContentsRight_UserType
 , DocumentUserTypes_dftRelatedDoc_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� dftChronology }
 dftChronologyName = 'dftChronology';
  {* ��������� ������������� ����������������� ���� "���������� ��������� ����" }
 dftChronology = TvcmUserType(dftAACContentsRight + 1);
  {* ���������� ��������� ���� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftChronology = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftChronology }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftChronology
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftChronology.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftChronology';
end;//Tkw_FormUserType_dftChronology.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftChronology.GetInteger: Integer;
begin
 Result := dftChronology;
end;//Tkw_FormUserType_dftChronology.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftChronology.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftChronology }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
