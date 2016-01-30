unit kwBaseExport;
 {* Экспорт документа из базы }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwBaseExport.pas"
// Стереотип: "ScriptKeyword"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , SewerPipe
;

type
 TkwBaseExport = {final} class(TtfwRegisterableWord)
  {* Экспорт документа из базы }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwBaseExport
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , dt_Types
 , dt_AttrSchema
 , k2TagGen
 , evdNativeWriter
;

type
 TSewerPipeHack = class(TSewerPipe)
 end;//TSewerPipeHack

procedure TkwBaseExport.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50580B6C00E6_var*
var
 l_DocID: Integer;
 l_FileName: string;
 l_EPipe: TSewerPipe;
 l_Gen: Tk2TagGenerator;
//#UC END# *4DAEEDE10285_50580B6C00E6_var*
begin
//#UC START# *4DAEEDE10285_50580B6C00E6_impl*
 Assert(aCtx.rEngine.IsTopString, 'base:export - не задано имя файла');
 l_FileName := aCtx.rEngine.PopDelphiString;
 Assert(aCtx.rEngine.IsTopInt, 'base:export - не задан ID документа');
 l_DocID := aCtx.rEngine.PopInt;
 l_FileName := aCtx.rCaller.ResolveOutputFilePath(l_FileName);
 l_EPipe := TSewerPipe.Create;
 try
  l_EPipe.MakeSingleDocSab(l_DocID, True);
  l_EPipe.ExportDocument := True;
  TSewerPipeHack(l_EPipe).ExportFilter.Attributes := [atDateNums, atHLink, atSub];
  l_Gen := nil;
  TevdNativeWriter.SetTo(l_Gen, l_FileName);
  try
   TevdNativeWriter(l_Gen).Binary := False;
   l_EPipe.Writer := l_Gen;
   l_EPipe.Execute;
  finally
   FreeAndNil(l_Gen);
  end;
 finally
  FreeAndNil(l_EPipe);
 end;
//#UC END# *4DAEEDE10285_50580B6C00E6_impl*
end;//TkwBaseExport.DoDoIt

class function TkwBaseExport.GetWordNameForRegister: AnsiString;
begin
 Result := 'base:export';
end;//TkwBaseExport.GetWordNameForRegister

initialization
 TkwBaseExport.RegisterInEngine;
 {* Регистрация base_export }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
