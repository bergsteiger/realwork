unit PrimFoldersTree_utFoldersTree_UserType;
 {* ��� ��������� (�������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas"
// ���������: "UserType"
// ������� ������: "utFoldersTree" MUID: (4BD6EB140266)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utFoldersTreeLocalConstants }
 str_utFoldersTreeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersTreeCaption'; rValue : '��� ��������� (�������)');
  {* ��������� ����������������� ���� "��� ��������� (�������)" }
 {* ��������� ��� ���� ����� utFoldersTree }
 utFoldersTreeName = 'utFoldersTree';
  {* ��������� ������������� ����������������� ���� "��� ��������� (�������)" }
 utFoldersTree = TvcmUserType(0);
  {* ��� ��������� (�������) }
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
 Tkw_FormUserType_utFoldersTree = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFoldersTree }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utFoldersTree
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utFoldersTree.GetInteger: Integer;
begin
 Result := utFoldersTree;
end;//Tkw_FormUserType_utFoldersTree.GetInteger

class function Tkw_FormUserType_utFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFoldersTree';
end;//Tkw_FormUserType_utFoldersTree.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utFoldersTreeCaption.Init;
 {* ������������� str_utFoldersTreeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersTree.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFoldersTree }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
