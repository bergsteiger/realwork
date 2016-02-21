unit F1Like_FormDefinitions_Controls;

// ������: "w:\common\components\gui\Garant\VCM\View\F1Like_FormDefinitions_Controls.pas"
// ���������: "VCMControls"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ChildForm: TvcmFormDescriptor = (rFormID : (rName : 'ChildForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TChildForm }

const
 fm_ParentForm: TvcmFormDescriptor = (rFormID : (rName : 'ParentForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TParentForm }

type
 ChildFormDef = interface
  ['{CFF21CFB-D277-44C2-940B-C1A99F33511F}']
 end;//ChildFormDef

 ParentFormDef = interface
  ['{DEC20464-3FB2-4ABC-921C-08A93E75DAD5}']
 end;//ParentFormDef

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_Form_Child_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Child
----
*������ �������������*:
[code]
'aControl' �����::Child TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Child_ID
 {$IfEnd} // NOT Defined(NoScripts)

 {$If NOT Defined(NoScripts)}
 Tkw_Form_Parent_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� Parent
----
*������ �������������*:
[code]
'aControl' �����::Parent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Parent_ID
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Child_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Child';
end;//Tkw_Form_Child_ID.GetWordNameForRegister

function Tkw_Form_Child_ID.GetString: AnsiString;
begin
 Result := 'ChildForm';
end;//Tkw_Form_Child_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_Parent_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Parent';
end;//Tkw_Form_Parent_ID.GetWordNameForRegister

function Tkw_Form_Parent_ID.GetString: AnsiString;
begin
 Result := 'ParentForm';
end;//Tkw_Form_Parent_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_Child_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Child_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 Tkw_Form_Parent_ID.RegisterInEngine;
 {* ����������� Tkw_Form_Parent_ID }
{$IfEnd} // NOT Defined(NoScripts)

end.
