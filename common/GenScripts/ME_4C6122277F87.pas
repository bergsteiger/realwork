unit DocumentWithFlashKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� DocumentWithFlash }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\DocumentWithFlashKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "DocumentWithFlashKeywordsPack" MUID: (4C6122277F87)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DocumentWithFlash_Form
 , tfwControlString
 , SysUtils
 , tfwTypeRegistrator
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_DocumentWithFlash

function Tkw_Form_DocumentWithFlash.GetString: AnsiString;
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash.GetString

class function Tkw_Form_DocumentWithFlash.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash.GetWordNameForRegister

initialization
 Tkw_Form_DocumentWithFlash.RegisterInEngine;
 {* ����������� Tkw_Form_DocumentWithFlash }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
