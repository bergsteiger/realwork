unit PrimChild_cutUsual_UserType;

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutUsual_UserType.pas"
// ���������: "UserType"
// ������� ������: "cutUsual" MUID: (4D9AE77A0246)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ cutUsualLocalConstants }
 str_cutUsualCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutUsualCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� cutUsual }
 cutUsualName = 'cutUsual';
  {* ��������� ������������� ����������������� ���� "" }
 cutUsual = TvcmUserType(0);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_cutUsual = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cutUsual }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cutUsual
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cutUsual.GetInteger: Integer;
begin
 Result := cutUsual;
end;//Tkw_FormUserType_cutUsual.GetInteger

class function Tkw_FormUserType_cutUsual.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cutUsual';
end;//Tkw_FormUserType_cutUsual.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cutUsualCaption.Init;
 {* ������������� str_cutUsualCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutUsual.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cutUsual }
{$IfEnd} // NOT Defined(NoScripts)

end.
