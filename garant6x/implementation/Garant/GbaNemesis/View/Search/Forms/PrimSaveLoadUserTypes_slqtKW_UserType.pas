unit PrimSaveLoadUserTypes_slqtKW_UserType;
 {* �����: �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtKW_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtKW" MUID: (4BD5BB8D0207)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtAttribute_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ slqtKWLocalConstants }
 str_slqtKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtKWCaption'; rValue : '�����: �� ��������');
  {* ��������� ����������������� ���� "�����: �� ��������" }
 {* ��������� ��� ���� ����� slqtKW }
 slqtKWName = 'slqtKW';
  {* ��������� ������������� ����������������� ���� "�����: �� ��������" }
 slqtKW = TvcmUserType(slqtAttribute + 1);
  {* �����: �� �������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtKW = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtKW }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtKW
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtKW.GetInteger: Integer;
begin
 Result := slqtKW;
end;//Tkw_FormUserType_slqtKW.GetInteger

class function Tkw_FormUserType_slqtKW.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtKW';
end;//Tkw_FormUserType_slqtKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtKWCaption.Init;
 {* ������������� str_slqtKWCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtKW.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
