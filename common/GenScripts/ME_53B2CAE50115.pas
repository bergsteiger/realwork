unit kwIsMyDocumentsEmpty;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIsMyDocumentsEmpty.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwIsMyDocumentsEmpty = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsMyDocumentsEmpty
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , FoldersUnit
 , DataAdapter
 , BaseTreeSupportUnit
;

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
begin
 Result := 'IsMyDocumentsEmpty';
end;//TkwIsMyDocumentsEmpty.GetWordNameForRegister

initialization
 TkwIsMyDocumentsEmpty.RegisterInEngine;
 {* Регистрация IsMyDocumentsEmpty }
{$IfEnd} // NOT Defined(NoScripts)

end.
