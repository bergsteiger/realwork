unit kwIsMyDocumentsEmpty;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwIsMyDocumentsEmpty.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::IsMyDocumentsEmpty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
  RunnerAssert(False, 'Мои документы не найдены.', aCtx);
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
// Регистрация IsMyDocumentsEmpty
 TkwIsMyDocumentsEmpty.RegisterInEngine;
{$IfEnd} //not NoScripts

end.