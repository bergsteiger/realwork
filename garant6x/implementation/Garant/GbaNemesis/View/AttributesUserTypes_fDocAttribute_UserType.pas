unit AttributesUserTypes_fDocAttribute_UserType;
 {* ���������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fDocAttribute_UserType.pas"
// ���������: "UserType"
// ������� ������: "fDocAttribute" MUID: (4BD6BA11008E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ fDocAttributeLocalConstants }
 str_fDocAttributeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fDocAttributeCaption'; rValue : '���������� � ���������');
  {* ��������� ����������������� ���� "���������� � ���������" }
 {* ��������� ��� ���� ����� fDocAttribute }
 fDocAttributeName = 'fDocAttribute';
  {* ��������� ������������� ����������������� ���� "���������� � ���������" }
 fDocAttribute = TvcmUserType(0);
  {* ���������� � ��������� }
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
 Tkw_FormUserType_fDocAttribute = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� fDocAttribute }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_fDocAttribute
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_fDocAttribute.GetInteger: Integer;
begin
 Result := fDocAttribute;
end;//Tkw_FormUserType_fDocAttribute.GetInteger

class function Tkw_FormUserType_fDocAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::fDocAttribute';
end;//Tkw_FormUserType_fDocAttribute.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_fDocAttributeCaption.Init;
 {* ������������� str_fDocAttributeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fDocAttribute.RegisterInEngine;
 {* ����������� Tkw_FormUserType_fDocAttribute }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
