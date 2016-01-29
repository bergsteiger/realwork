unit DocumentWithFlashKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/DocumentWithFlashKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::DocumentWithFlashKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� DocumentWithFlash
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  DocumentWithFlash_Form,
  tfwControlString
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;

type
  Tkw_Form_DocumentWithFlash = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� DocumentWithFlash
----
*������ �������������*:
[code]
'aControl' �����::DocumentWithFlash TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_DocumentWithFlash

// start class Tkw_Form_DocumentWithFlash

class function Tkw_Form_DocumentWithFlash.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::DocumentWithFlash';
end;//Tkw_Form_DocumentWithFlash.GetWordNameForRegister

function Tkw_Form_DocumentWithFlash.GetString: AnsiString;
 {-}
begin
 Result := 'DocumentWithFlashForm';
end;//Tkw_Form_DocumentWithFlash.GetString
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_DocumentWithFlash
 Tkw_Form_DocumentWithFlash.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.