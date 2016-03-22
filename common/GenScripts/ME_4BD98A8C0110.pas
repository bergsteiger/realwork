unit PostingOrder_FormDefinitions_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PostingOrder_FormDefinitions_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "FormDefinitions" MUID: (4BD98A8C0110)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_enPostingsList: TvcmFormDescriptor = (rFormID : (rName : 'enPostingsList'; rID : 0); rFactory : nil);
  {* ������������� ����� TenPostingsList }

type
 PostingsListFormDef = interface
  ['{69D1C6BF-ECE3-4BB1-8DA5-998AB45694C7}']
 end;//PostingsListFormDef
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwString
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_Form_PostingsList_ID = {final} class(TtfwString)
  {* ����� ������� ��� �������������� ����� PostingsList
----
*������ �������������*:
[code]
'aControl' �����::PostingsList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_PostingsList_ID
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_Form_PostingsList_ID.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::PostingsList';
end;//Tkw_Form_PostingsList_ID.GetWordNameForRegister

function Tkw_Form_PostingsList_ID.GetString: AnsiString;
begin
 Result := 'enPostingsList';
end;//Tkw_Form_PostingsList_ID.GetString
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_Form_PostingsList_ID.RegisterInEngine;
 {* ����������� Tkw_Form_PostingsList_ID }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
