unit kwDocumentsCacheClear;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwDocumentsCacheClear.pas"
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
 TkwDocumentsCacheClear = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDocumentsCacheClear
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evDocumentsCache
;

procedure TkwDocumentsCacheClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB82E4D0197_var*
//#UC END# *4DAEEDE10285_4DB82E4D0197_var*
begin
//#UC START# *4DAEEDE10285_4DB82E4D0197_impl*
 TevDocumentsCache.Clear;
//#UC END# *4DAEEDE10285_4DB82E4D0197_impl*
end;//TkwDocumentsCacheClear.DoDoIt

class function TkwDocumentsCacheClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'documentscache:Clear';
end;//TkwDocumentsCacheClear.GetWordNameForRegister

initialization
 TkwDocumentsCacheClear.RegisterInEngine;
 {* Регистрация TkwDocumentsCacheClear }
{$IfEnd} // NOT Defined(NoScripts)

end.
