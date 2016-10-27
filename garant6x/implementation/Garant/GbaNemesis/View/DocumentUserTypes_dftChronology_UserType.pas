unit DocumentUserTypes_dftChronology_UserType;
 {* ���������� ��������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftChronology_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftChronology" MUID: (53BFD2E400A4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACContentsRight_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftChronologyLocalConstants }
 str_dftChronologyCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologyCaption'; rValue : '���������� ��������� ����');
  {* ��������� ����������������� ���� "���������� ��������� ����" }
 str_dftChronologySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologySettingsCaption'; rValue : '��������: ���������� ��������� ����');
  {* ��������� ����������������� ���� "���������� ��������� ����" ��� ��������� ������� ������������ }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftChronology = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftChronology }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftChronology
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftChronology.GetInteger: Integer;
begin
 Result := dftChronology;
end;//Tkw_FormUserType_dftChronology.GetInteger

class function Tkw_FormUserType_dftChronology.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftChronology';
end;//Tkw_FormUserType_dftChronology.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftChronologyCaption.Init;
 {* ������������� str_dftChronologyCaption }
 str_dftChronologySettingsCaption.Init;
 {* ������������� str_dftChronologySettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftChronology.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftChronology }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
