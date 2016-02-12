unit DocumentWithFlashKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� DocumentWithFlash }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\DocumentWithFlashKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , tfwControlString
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
;

type
 Tkw_Form_DocumentWithFlash = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� DocumentWithFlash
----
*������ �������������*:
[code]
'aControl' �����::DocumentWithFlash TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DocumentWithFlash

class function Tkw_Form_DocumentWithFlash.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash.GetWordNameForRegister

function Tkw_Form_DocumentWithFlash.GetString: AnsiString;
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash.GetString

initialization
 Tkw_Form_DocumentWithFlash.RegisterInEngine;
 {* ����������� Tkw_Form_DocumentWithFlash }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
