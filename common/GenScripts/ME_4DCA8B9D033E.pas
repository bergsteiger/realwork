unit kwStyleTableSaveToFile;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStyleTableSaveToFile.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwStyleTableSaveToFile = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStyleTableSaveToFile
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evStyleInterfaceEx
 , l3Stream
 , l3Types
 , SysUtils
;

procedure TkwStyleTableSaveToFile.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DCA8B9D033E_var*
var
 l_S : Tl3NamedTextStream;
//#UC END# *4DAEEDE10285_4DCA8B9D033E_var*
begin
//#UC START# *4DAEEDE10285_4DCA8B9D033E_impl*
 l_S := Tl3NamedTextStream.Create(aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString),
                                  l3_fmWrite);
 try
  with TevStyleInterfaceEx.Make do
   try
    Save(l_S);
   finally
    Free;
   end;//try..finally
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *4DAEEDE10285_4DCA8B9D033E_impl*
end;//TkwStyleTableSaveToFile.DoDoIt

class function TkwStyleTableSaveToFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'StyleTable:SaveToFile';
end;//TkwStyleTableSaveToFile.GetWordNameForRegister

initialization
 TkwStyleTableSaveToFile.RegisterInEngine;
 {* Регистрация StyleTable_SaveToFile }
{$IfEnd} // NOT Defined(NoScripts)

end.
