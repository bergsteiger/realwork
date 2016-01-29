unit kwDocumentsCacheClear;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwDocumentsCacheClear.pas"
// �����: 27.04.2011 18:55
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::TkwDocumentsCacheClear
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDocumentsCacheClear = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocumentsCacheClear
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  evDocumentsCache
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwDocumentsCacheClear

procedure TkwDocumentsCacheClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB82E4D0197_var*
//#UC END# *4DAEEDE10285_4DB82E4D0197_var*
begin
//#UC START# *4DAEEDE10285_4DB82E4D0197_impl*
 TevDocumentsCache.Clear;
//#UC END# *4DAEEDE10285_4DB82E4D0197_impl*
end;//TkwDocumentsCacheClear.DoDoIt

class function TkwDocumentsCacheClear.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'documentscache:Clear';
end;//TkwDocumentsCacheClear.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwDocumentsCacheClear
 TkwDocumentsCacheClear.RegisterInEngine;
{$IfEnd} //not NoScripts

end.