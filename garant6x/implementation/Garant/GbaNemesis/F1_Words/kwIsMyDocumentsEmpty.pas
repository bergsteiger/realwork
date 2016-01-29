unit kwIsMyDocumentsEmpty;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwIsMyDocumentsEmpty.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::IsMyDocumentsEmpty
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
 TkwIsMyDocumentsEmpty = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsMyDocumentsEmpty
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  FoldersUnit,
  DataAdapter,
  BaseTreeSupportUnit
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwIsMyDocumentsEmpty

procedure TkwIsMyDocumentsEmpty.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B2CAE50115_var*
var
 l_Child,
 l_FoldersRoot: INode;
 I: Integer;
//#UC END# *4DAEEDE10285_53B2CAE50115_var*
begin
//#UC START# *4DAEEDE10285_53B2CAE50115_impl*
 l_FoldersRoot := DefDataAdapter.FoldersRoot;
 try
  for I := 0 to l_FoldersRoot.GetChildCount - 1 do
  begin
   l_FoldersRoot.GetChild(I, l_Child);
   if l_Child.GetFlags and NF_MY_DOCUMENTS = NF_MY_DOCUMENTS then
   begin
    aCtx.rEngine.PushBool(l_Child.GetChildCount = 0);
    Exit;
   end;
  end;
  RunnerAssert(False, '��� ��������� �� �������.', aCtx);
 finally
  l_FoldersRoot := nil;
 end;
//#UC END# *4DAEEDE10285_53B2CAE50115_impl*
end;//TkwIsMyDocumentsEmpty.DoDoIt

class function TkwIsMyDocumentsEmpty.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsMyDocumentsEmpty';
end;//TkwIsMyDocumentsEmpty.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� IsMyDocumentsEmpty
 TkwIsMyDocumentsEmpty.RegisterInEngine;
{$IfEnd} //not NoScripts

end.