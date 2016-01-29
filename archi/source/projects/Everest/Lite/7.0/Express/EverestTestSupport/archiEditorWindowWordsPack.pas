unit archiEditorWindowWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestTestSupport"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/archiEditorWindowWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::archiEditorWindowWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  ,
  EdWin
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord
  {$IfEnd} //not NoScripts
  
  ;

{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  
  ;

type
 TkwIsNeedSaveDocument = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� IsNeedSaveDocument
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor IsNeedSaveDocument >>> l_Boolean
[code]  }
 private
 // private methods
   function IsNeedSaveDocument(const aCtx: TtfwContext;
    aEditor: TEditorWindow): Boolean;
     {* ���������� ����� ������� IsNeedSaveDocument }
 protected
 // realized methods
    {$If not defined(NoScripts)}
   procedure DoDoIt(const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 public
 // overridden public methods
    {$If not defined(NoScripts)}
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
    {$IfEnd} //not NoScripts
 end;//TkwIsNeedSaveDocument

// start class TkwIsNeedSaveDocument

function TkwIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
  aEditor: TEditorWindow): Boolean;
//#UC START# *5BBB7C35D3A8_BB6D8477DC61_var*
//#UC END# *5BBB7C35D3A8_BB6D8477DC61_var*
begin
//#UC START# *5BBB7C35D3A8_BB6D8477DC61_impl*
 Result := aEditor.IsNeedSaveDocument;
//#UC END# *5BBB7C35D3A8_BB6D8477DC61_impl*
end;//TkwIsNeedSaveDocument.IsNeedSaveDocument

{$If not defined(NoScripts)}
procedure TkwIsNeedSaveDocument.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TEditorWindow;
begin
 try
  l_aEditor := TEditorWindow(aCtx.rEngine.PopObjAs(TEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsNeedSaveDocument(aCtx, l_aEditor)));
end;//TkwIsNeedSaveDocument.DoDoIt
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwIsNeedSaveDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsNeedSaveDocument';
end;//TkwIsNeedSaveDocument.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
function TkwIsNeedSaveDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwIsNeedSaveDocument.GetResultTypeInfo
{$IfEnd} //not NoScripts
{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� IsNeedSaveDocument
 TkwIsNeedSaveDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //InsiderTest AND nsTest
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� ���� TEditorWindow
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditorWindow));
{$IfEnd} //InsiderTest AND nsTest
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //InsiderTest AND nsTest

end.