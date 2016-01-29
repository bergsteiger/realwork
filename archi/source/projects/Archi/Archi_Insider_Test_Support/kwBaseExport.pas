unit kwBaseExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwBaseExport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::base_export
//
// Экспорт документа из базы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  SewerPipe,
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwBaseExport = {final scriptword} class(TtfwRegisterableWord)
  {* Экспорт документа из базы }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwBaseExport
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  dt_Types,
  dt_AttrSchema,
  k2TagGen,
  evdNativeWriter
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

type
  TSewerPipeHack = class(TSewerPipe)
  end;//TSewerPipeHack

// start class TkwBaseExport

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
 {-}
begin
 Result := 'base:export';
end;//TkwBaseExport.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация base_export
 TkwBaseExport.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.