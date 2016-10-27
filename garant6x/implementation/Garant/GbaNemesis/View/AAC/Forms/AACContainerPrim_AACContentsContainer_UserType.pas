unit AACContainerPrim_AACContentsContainer_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContentsContainer_UserType.pas"
// ���������: "UserType"
// ������� ������: "AACContentsContainer" MUID: (504879B60226)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACContainerPrim_AACContainer_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ AACContentsContainerLocalConstants }
 str_AACContentsContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AACContentsContainerCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� AACContentsContainer }
 AACContentsContainerName = 'AACContentsContainer';
  {* ��������� ������������� ����������������� ���� "" }
 AACContentsContainer = TvcmUserType(AACContainer + 1);
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
 Tkw_FormUserType_AACContentsContainer = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� AACContentsContainer }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_AACContentsContainer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_AACContentsContainer.GetInteger: Integer;
begin
 Result := AACContentsContainer;
end;//Tkw_FormUserType_AACContentsContainer.GetInteger

class function Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::AACContentsContainer';
end;//Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_AACContentsContainerCaption.Init;
 {* ������������� str_AACContentsContainerCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContentsContainer.RegisterInEngine;
 {* ����������� Tkw_FormUserType_AACContentsContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
