unit PrimChild_cutForDiction_UserType;

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutForDiction_UserType.pas"
// ���������: "UserType"
// ������� ������: "cutForDiction" MUID: (4D9AE78D0196)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , PrimChild_cutUsual_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ cutForDictionLocalConstants }
 str_cutForDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutForDictionCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� cutForDiction }
 cutForDictionName = 'cutForDiction';
  {* ��������� ������������� ����������������� ���� "" }
 cutForDiction = TvcmUserType(cutUsual + 1);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_cutForDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cutForDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cutForDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cutForDiction.GetInteger: Integer;
begin
 Result := cutForDiction;
end;//Tkw_FormUserType_cutForDiction.GetInteger

class function Tkw_FormUserType_cutForDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cutForDiction';
end;//Tkw_FormUserType_cutForDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cutForDictionCaption.Init;
 {* ������������� str_cutForDictionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutForDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cutForDiction }
{$IfEnd} // NOT Defined(NoScripts)

end.
