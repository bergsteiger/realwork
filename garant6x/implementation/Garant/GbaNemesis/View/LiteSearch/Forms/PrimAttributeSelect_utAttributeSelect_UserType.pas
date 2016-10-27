unit PrimAttributeSelect_utAttributeSelect_UserType;
 {* ����� �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas"
// ���������: "UserType"
// ������� ������: "utAttributeSelect" MUID: (4BD6F81D015C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utAttributeSelectLocalConstants }
 str_utAttributeSelectCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAttributeSelectCaption'; rValue : '����� �������� ��������');
  {* ��������� ����������������� ���� "����� �������� ��������" }
 {* ��������� ��� ���� ����� utAttributeSelect }
 utAttributeSelectName = 'utAttributeSelect';
  {* ��������� ������������� ����������������� ���� "����� �������� ��������" }
 utAttributeSelect = TvcmUserType(0);
  {* ����� �������� �������� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utAttributeSelect = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utAttributeSelect }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utAttributeSelect
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utAttributeSelect.GetInteger: Integer;
begin
 Result := utAttributeSelect;
end;//Tkw_FormUserType_utAttributeSelect.GetInteger

class function Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utAttributeSelect';
end;//Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utAttributeSelectCaption.Init;
 {* ������������� str_utAttributeSelectCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAttributeSelect.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)

end.
