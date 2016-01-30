unit CompareEditions_FormDefinitions_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\CompareEditions_FormDefinitions_Controls.pas"
// ���������: "VCMControls"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 fm_LeftEditionForm: TvcmFormDescriptor = (rFormID : (rName : 'LeftEditionForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TLeftEditionForm }

const
 fm_RightEditionForm: TvcmFormDescriptor = (rFormID : (rName : 'RightEditionForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TRightEditionForm }

const
 fm_EditionsContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'EditionsContainerForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TEditionsContainerForm }

type
 LeftEditionFormDef = interface
  ['{A9A78553-D6D6-41FE-8759-46E9B97592B8}']
 end;//LeftEditionFormDef

 RightEditionFormDef = interface
  ['{8C64309E-56E0-427B-B77E-E76372E73FA7}']
 end;//RightEditionFormDef

 EditionsContainerFormDef = interface
  ['{9E38EC35-34E1-49E2-B2C9-6D12062610C7}']
 end;//EditionsContainerFormDef
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_Form_LeftEdition_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� LeftEdition
----
*������ �������������*:
[code]
'aControl' �����::LeftEdition TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_LeftEdition_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_RightEdition_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� RightEdition
----
*������ �������������*:
[code]
'aControl' �����::RightEdition TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_RightEdition_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_EditionsContainer_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� EditionsContainer
----
*������ �������������*:
[code]
'aControl' �����::EditionsContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EditionsContainer_ID
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_LeftEdition_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::LeftEdition';
end;//Tkw_Form_LeftEdition_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_LeftEdition_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BB00F0241328_var*
//#UC END# *4DDFD2EA0116_BB00F0241328_var*
begin
//#UC START# *4DDFD2EA0116_BB00F0241328_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BB00F0241328_impl*
end;//Tkw_Form_LeftEdition_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_RightEdition_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::RightEdition';
end;//Tkw_Form_RightEdition_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_RightEdition_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_41833232BDCF_var*
//#UC END# *4DDFD2EA0116_41833232BDCF_var*
begin
//#UC START# *4DDFD2EA0116_41833232BDCF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_41833232BDCF_impl*
end;//Tkw_Form_RightEdition_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_EditionsContainer_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::EditionsContainer';
end;//Tkw_Form_EditionsContainer_ID.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_Form_EditionsContainer_ID.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F5E275A94BC4_var*
//#UC END# *4DDFD2EA0116_F5E275A94BC4_var*
begin
//#UC START# *4DDFD2EA0116_F5E275A94BC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F5E275A94BC4_impl*
end;//Tkw_Form_EditionsContainer_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_LeftEdition_ID.RegisterInEngine;
 {* ����������� Tkw_Form_LeftEdition_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_RightEdition_ID.RegisterInEngine;
 {* ����������� Tkw_Form_RightEdition_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_EditionsContainer_ID.RegisterInEngine;
 {* ����������� Tkw_Form_EditionsContainer_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
