unit Admin_FormDefinitions_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin_FormDefinitions_Controls.pas"
// ���������: "VCMControls"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 fm_cfAdminForm: TvcmFormDescriptor = (rFormID : (rName : 'cfAdminForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TcfAdminForm }

const
 fm_efGroupList: TvcmFormDescriptor = (rFormID : (rName : 'efGroupList'; rID : 0); rFactory : nil);
  {* ������������� ����� TefGroupList }

const
 fm_efUserList: TvcmFormDescriptor = (rFormID : (rName : 'efUserList'; rID : 0); rFactory : nil);
  {* ������������� ����� TefUserList }

const
 fm_efUserProperty: TvcmFormDescriptor = (rFormID : (rName : 'efUserProperty'; rID : 0); rFactory : nil);
  {* ������������� ����� TefUserProperty }

type
 AdminFormFormDef = interface
  ['{7E787B8C-F566-443C-9C95-6711D628B038}']
 end;//AdminFormFormDef

 GroupListFormDef = interface
  ['{427E23A9-B9FD-4256-8312-ED9653D862C6}']
 end;//GroupListFormDef

 UserListFormDef = interface
  ['{CCC79038-4B92-428C-ADD7-D68C5BCE408C}']
 end;//UserListFormDef

 UserPropertyFormDef = interface
  ['{5FCF4F0A-B828-487D-9E35-8D8643E02C6C}']
 end;//UserPropertyFormDef
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_Form_AdminForm_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� AdminForm
----
*������ �������������*:
[code]
'aControl' �����::AdminForm TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AdminForm_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_GroupList_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� GroupList
----
*������ �������������*:
[code]
'aControl' �����::GroupList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_GroupList_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_UserList_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� UserList
----
*������ �������������*:
[code]
'aControl' �����::UserList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserList_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_UserProperty_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� UserProperty
----
*������ �������������*:
[code]
'aControl' �����::UserProperty TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserProperty_ID
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_AdminForm_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::AdminForm';
end;//Tkw_Form_AdminForm_ID.GetWordNameForRegister

function Tkw_Form_AdminForm_ID.GetString: AnsiString;
begin
 Result := 'cfAdminForm';
end;//Tkw_Form_AdminForm_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_GroupList_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::GroupList';
end;//Tkw_Form_GroupList_ID.GetWordNameForRegister

function Tkw_Form_GroupList_ID.GetString: AnsiString;
begin
 Result := 'efGroupList';
end;//Tkw_Form_GroupList_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_UserList_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserList';
end;//Tkw_Form_UserList_ID.GetWordNameForRegister

function Tkw_Form_UserList_ID.GetString: AnsiString;
begin
 Result := 'efUserList';
end;//Tkw_Form_UserList_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_UserProperty_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserProperty';
end;//Tkw_Form_UserProperty_ID.GetWordNameForRegister

function Tkw_Form_UserProperty_ID.GetString: AnsiString;
begin
 Result := 'efUserProperty';
end;//Tkw_Form_UserProperty_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_AdminForm_ID.RegisterInEngine;
 {* ����������� Tkw_Form_AdminForm_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_GroupList_ID.RegisterInEngine;
 {* ����������� Tkw_Form_GroupList_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_UserList_ID.RegisterInEngine;
 {* ����������� Tkw_Form_UserList_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_UserProperty_ID.RegisterInEngine;
 {* ����������� Tkw_Form_UserProperty_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
