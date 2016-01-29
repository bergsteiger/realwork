unit EverestLiteAdapter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestTestSupport"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/EverestLiteAdapter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteTestUnit::EverestLiteAdapter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
procedure CreateNewDocument;
procedure OpenDocument(const aFileName: AnsiString);
procedure CloseDocument;
procedure SaveDocumentAs(const aFileName: AnsiString);
function IsPreviewInProcess: Boolean;
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  MainEditor
  ;

// unit methods

procedure CreateNewDocument;
//#UC START# *512DBB8A00BE_512DBB5502E6_var*
//#UC END# *512DBB8A00BE_512DBB5502E6_var*
begin
//#UC START# *512DBB8A00BE_512DBB5502E6_impl*
 MainForm.LoadManager.FileName := '';
 MainForm.CreateMDIChild(nil);
//#UC END# *512DBB8A00BE_512DBB5502E6_impl*
end;//CreateNewDocument

procedure OpenDocument(const aFileName: AnsiString);
//#UC START# *512DBBB003CE_512DBB5502E6_var*
//#UC END# *512DBBB003CE_512DBB5502E6_var*
begin
//#UC START# *512DBBB003CE_512DBB5502E6_impl*
 MainForm.LoadManager.FileName := aFileName;
 MainForm.CreateMDIChild(nil, aFileName);
//#UC END# *512DBBB003CE_512DBB5502E6_impl*
end;//OpenDocument

procedure CloseDocument;
//#UC START# *512DD17201EC_512DBB5502E6_var*
//#UC END# *512DD17201EC_512DBB5502E6_var*
begin
//#UC START# *512DD17201EC_512DBB5502E6_impl*
 Assert(MainForm.ActiveMDIChild <> nil, '��� �������� �������� ����.');
 MainForm.ActiveMDIChild.Close;
//#UC END# *512DD17201EC_512DBB5502E6_impl*
end;//CloseDocument

procedure SaveDocumentAs(const aFileName: AnsiString);
//#UC START# *512DD27F0187_512DBB5502E6_var*
//#UC END# *512DD27F0187_512DBB5502E6_var*
begin
//#UC START# *512DD27F0187_512DBB5502E6_impl*
 with MainForm do
 begin
  if (ActiveEditor = nil) then Exit;
  with ActiveEditor do
   TextSource.FileName := aFileName;
  SaveToFile;
 end; // with MainForm do
//#UC END# *512DD27F0187_512DBB5502E6_impl*
end;//SaveDocumentAs

function IsPreviewInProcess: Boolean;
//#UC START# *532171DE00C1_512DBB5502E6_var*
//#UC END# *532171DE00C1_512DBB5502E6_var*
begin
//#UC START# *532171DE00C1_512DBB5502E6_impl*
 Result := False;
 with MainForm do
  if CheckActiveEditor then
   Result := ActiveEditor.IsPreviewInProgress;
//#UC END# *532171DE00C1_512DBB5502E6_impl*
end;//IsPreviewInProcess
{$IfEnd} //InsiderTest AND nsTest

end.