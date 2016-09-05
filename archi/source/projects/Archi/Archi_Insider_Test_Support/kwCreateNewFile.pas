unit kwCreateNewFile;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwCreateNewFile.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCreateNewFile" MUID: (52BD79050326)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCreateNewFile = {abstract} class(TtfwRegisterableWord)
  protected
   function DoWithFileName(const aCtx: TtfwContext): AnsiString; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCreateNewFile
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
 , dt_Types
 , SysUtils
 //#UC START# *52BD79050326impl_uses*
 //#UC END# *52BD79050326impl_uses*
;

procedure TkwCreateNewFile.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52BD79050326_var*
var
 l_FileName: TFileName;
//#UC END# *4DAEEDE10285_52BD79050326_var*
begin
//#UC START# *4DAEEDE10285_52BD79050326_impl*
 l_FileName := DoWithFileName(aCtx);
 Assert((l_FileName = '') or FileExists(l_FileName), Format('Файл не существует: %s', [l_FileName]));
 ArCreateNewDocumentByFileName(l_FileName, dtText);
//#UC END# *4DAEEDE10285_52BD79050326_impl*
end;//TkwCreateNewFile.DoDoIt

initialization
 TkwCreateNewFile.RegisterClass;
 {* Регистрация TkwCreateNewFile }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
