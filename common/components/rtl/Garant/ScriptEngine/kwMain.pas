unit kwMain;
 {* Поддержка основного кода скрипта. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMain.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwMain" MUID: (4DC90A1E03C2)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptEnginePrim
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
 , tfwStreamFactory
;

type
 TkwMain = class(TtfwScriptEnginePrim)
  {* Поддержка основного кода скрипта. }
  private
   class procedure CompileScriptToAxiomatics(const aContext: TtfwContext;
    const aScriptCode: array of AnsiString);
    {* Компилируем скипт в аксиоматику }
   class procedure CompileScriptToAxiomaticsIfDefined(const aContext: TtfwContext;
    const aDefined: array of AnsiString;
    const aScriptCode: array of AnsiString);
   class procedure CompileResScriptToAxiomatics(const aContext: TtfwContext;
    const aResName: AnsiString);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   procedure BeforeCompile(var theNewContext: TtfwContext); override;
   procedure AfterCompile(var theNewContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim); override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   function AcceptsEOF: Boolean; override;
   class function ReallyNeedRegister: Boolean; override;
  public
   procedure RunCompiled(const aContext: TtfwContext); override;
   procedure Script(aStream: TtfwStreamFactory;
    const aCaller: ItfwScriptCaller); override;
 end;//TkwMain

var g_ScriptEngine: TkwMain;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , l3Base
 , kwSystemIncluded
 , l3Stream
 , l3Types
 , kwCompiledMain
 , seThreadSupport
 , tfwFileStreamFactory
 , tfwCOMStreamFactory
 , tfwStringStreamFactory
 , l3EtalonsService
 , tfwResourceStreamFactory
 , tfwAutoregisteredDiction
 , tfwAxiomaticsResNameGetters
 , tfwCompiledAxiomaticsRes
 , tfwTypesForRegister
 , tfwTypeRegistrator
 , tfwClassesForRegister
 , tfwClassRef
 , l3Memory
 , l3_String
 , l3String
 , l3Chars
 //#UC START# *4DC90A1E03C2impl_uses*
 //#UC END# *4DC90A1E03C2impl_uses*
;

type
 TkwMainResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TkwMainResNameGetter

class function TkwMainResNameGetter.ResName: AnsiString;
begin
 Result := 'kwMain';
end;//TkwMainResNameGetter.ResName

{$R kwMain.res}

class procedure TkwMain.CompileScriptToAxiomatics(const aContext: TtfwContext;
 const aScriptCode: array of AnsiString);
 {* Компилируем скипт в аксиоматику }
//#UC START# *5282326A0233_4DC90A1E03C2_var*
var
 l_String : Tl3_String;
 l_Index : Integer;
 l_Stream : TtfwStringStreamFactory;
 l_SI : TkwSystemIncluded;
//#UC END# *5282326A0233_4DC90A1E03C2_var*
begin
//#UC START# *5282326A0233_4DC90A1E03C2_impl*
 l_String := Tl3_String.Create;
 try
  for l_Index := Low(aScriptCode) to High(aScriptCode) do
  begin
   l_String.Append(l3PCharLen(aScriptCode[l_Index]));
   l_String.Append(cc_EOLStr);
  end;//for l_Index
  l_Stream := TtfwStringStreamFactory.Create(l_String.AsString);
  try
   l_SI := TkwSystemIncluded.Create(l_Stream);
   try
    l_SI.DoIt(aContext);
   finally
    FreeAndNil(l_SI);
   end;//try..finally
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 finally
  FreeAndNil(l_String);
 end;//try..finally
//#UC END# *5282326A0233_4DC90A1E03C2_impl*
end;//TkwMain.CompileScriptToAxiomatics

class procedure TkwMain.CompileScriptToAxiomaticsIfDefined(const aContext: TtfwContext;
 const aDefined: array of AnsiString;
 const aScriptCode: array of AnsiString);
//#UC START# *5293232E0291_4DC90A1E03C2_var*
var
 l_Index : Integer;
//#UC END# *5293232E0291_4DC90A1E03C2_var*
begin
//#UC START# *5293232E0291_4DC90A1E03C2_impl*
 for l_Index := Low(aDefined) to High(aDefined) do
  if not TtfwAutoregisteredDiction.Instance.CheckDictionaryByWordAndUse(TtfwCStringFactory.C(aDefined[l_Index])) then
  //if (aContext.rEngine.KeywordByName(TtfwCStringFactory.C(aDefined[l_Index])) = nil) then
   // - одно из слов не определено - ничего компилировать нельзя
   Exit;
 CompileScriptToAxiomatics(aContext, aScriptCode);
//#UC END# *5293232E0291_4DC90A1E03C2_impl*
end;//TkwMain.CompileScriptToAxiomaticsIfDefined

class procedure TkwMain.CompileResScriptToAxiomatics(const aContext: TtfwContext;
 const aResName: AnsiString);
//#UC START# *55795E7700D1_4DC90A1E03C2_var*
var
 l_Stream : TtfwResourceStreamFactory;
 l_SI : TkwSystemIncluded;
 l_Index : Integer;
//#UC END# *55795E7700D1_4DC90A1E03C2_var*
begin
//#UC START# *55795E7700D1_4DC90A1E03C2_impl*
 with TtfwCompiledAxiomaticsRes.Instance do
 begin
  if FindData(aResName, l_Index) then
   Exit
  else
   Add(aResName); 
 end;//with TtfwCompiledAxiomaticsRes.Instance
 l_Stream := TtfwResourceStreamFactory.Create(aResName);
 try
  l_SI := TkwSystemIncluded.Create(l_Stream);
  try
   l_SI.DoIt(aContext);
  finally
   FreeAndNil(l_SI);
  end;//try..finally
 finally
  FreeAndNil(l_Stream);
 end;//try..finally
//#UC END# *55795E7700D1_4DC90A1E03C2_impl*
end;//TkwMain.CompileResScriptToAxiomatics

procedure TkwMain.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DC90A1E03C2_var*
//#UC END# *479731C50290_4DC90A1E03C2_var*
begin
//#UC START# *479731C50290_4DC90A1E03C2_impl*
 inherited;
//#UC END# *479731C50290_4DC90A1E03C2_impl*
end;//TkwMain.Cleanup

function TkwMain.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DC90A1E03C2_var*
//#UC END# *4DB6C99F026E_4DC90A1E03C2_var*
begin
//#UC START# *4DB6C99F026E_4DC90A1E03C2_impl*
 Result := nil;
//#UC END# *4DB6C99F026E_4DC90A1E03C2_impl*
end;//TkwMain.EndBracket

procedure TkwMain.BeforeCompile(var theNewContext: TtfwContext);
//#UC START# *4DB6CDDA038B_4DC90A1E03C2_var*
var
 l_S  : IStream;
 l_SI : TkwSystemIncluded;
 l_SystemFilename : AnsiString;
 l_NS             : TtfwFileStreamFactory;
 l_Index : Integer;
 l_Name : AnsiString;
//#UC END# *4DB6CDDA038B_4DC90A1E03C2_var*
begin
//#UC START# *4DB6CDDA038B_4DC90A1E03C2_impl*
 inherited;
 if not TtfwAutoregisteredDiction.Instance.AllAxiomaticsDefined then
 try

  for l_Index := 0 to Pred(TtfwTypesForRegister.Instance.Count) do
   tfwTypeRegistrator.TtfwTypeRegistrator.RegisterType(TtfwTypesForRegister.Instance.Items[l_Index]);

  for l_Index := 0 to Pred(TtfwClassesForRegister.Instance.Count) do
   tfwClassRef.TtfwClassRef.Register(TtfwClassesForRegister.Instance.Items[l_Index]);

  CompileResScriptToAxiomatics(theNewContext.rPrev^, 'res:kwMain');

  CompileScriptToAxiomatics(theNewContext.rPrev^, [
   {$IfNDef NoVCM}
   'CONST ANYUSERTYPE 31'
   {$EndIf  NoVCM}

   {$IfDef Nemesis}
   {$IfNDef NoVCM},{$EndIf}
   'PROCEDURE "Задержка имени Жени Кусакина"',
   ' 3 LOOP OnTest',
   ' 200 SLEEP',
   ' 3 LOOP OnTest',
   ' // - это шаманство из-за таймера Жени Кусакина',
   ' // http://mdp.garant.ru/pages/viewpage.action?pageId=296627734',
   ';',

   'WordAlias "Дождаться переключения вкладок" "Задержка имени Жени Кусакина"'
   {$EndIf Nemesis}
  ]);
  
  {$IfNDef NoVCM}
  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['vcm:History:DeleteBackItem'],
  [
   'WordAlias history:DeleteBackItem vcm:History:DeleteBackItem'
  ]);

  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['vcm:History:DeleteForwardItem'],
  [
   'WordAlias history:DeleteForwardItem vcm:History:DeleteForwardItem'
  ]);


  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['mop::mo_Search_opInpharmSearch', 'Ok', 'history:DeleteBackItem'],
  [
   'PROCEDURE RunInpharmSearch OBJECT IN aProc',
   ' // - запускает поиск по КЗ Инфарма',
   ' mop::mo_Search_opInpharmSearch',
   ' aProc DO',
   ' Ok',
   ' OnTest',
   ' history:DeleteBackItem',
   ' // - удаляем предыдущий элемент истории (КЗ)',
   '; // RunInpharmSearch'

  ]);

  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['ППР_Prim'],
  [
   'PROCEDURE ППР',
   ' ППР_Prim',
   ' OnTest',
   '; // ППР'
  ]);

  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['ППС_Стандартная_Prim'],
  [
   'PROCEDURE "ППС Стандартная"',
   ' ППС_Стандартная_Prim',
   ' OnTest',
   '; // "ППС Стандартная"'
  ]);

  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['ППС_Преемственная_Prim'],
  [
   'PROCEDURE "ППС Преемственная"',
   ' ППС_Преемственная_Prim',
   ' OnTest',
   '; // "ППС Преемственная"'
  ]);

  CompileScriptToAxiomaticsIfDefined(theNewContext.rPrev^,
  ['ППР', 'Ok', 'history:DeleteBackItem', 'class::TevQueryCardEditor', 'focused:control:push'],
  [
   'PROCEDURE RunSearch OBJECT IN aProc',
   ' // - запускает поиск по КЗ ППР',
   ' vcm:Dispatcher:Lock',
   ' TRY',
   '  ППР',
   '  OBJECT VAR l_QC',
   '  focused:control:push >>> l_QC',
   '  l_QC IS class::TevQueryCardEditor',
   '   ?ASSURE ''Фокус не в КЗ''',
   '  aProc DO',
   '  Ok',
   '  OnTest',
   '  history:DeleteBackItem',
   '  // - удаляем предыдущий элемент истории (КЗ)',
   ' FINALLY',
   '  vcm:Dispatcher:Unlock',
   ' END',
   '; // RunSearch'
  ]);

  {$EndIf  NoVCM}

  CompileScriptToAxiomatics(theNewContext.rPrev^, [
   {$IfDef Nemesis}

   ' CONST defNemesis 0'

   {$IfDef Admin}
   ,
   ' CONST defAdmin 1'
   {$EndIf Admin}

   {$IfDef Monitorings}
   ,
   ' CONST defPrime 2'
   {$EndIf Monitorings}

   {$IfDef Shell}
   ,
   ' CONST defF1 3'
   {$EndIf Shell}

   {$Else  Nemesis}

   {$IfDef Archi}
   ' CONST defArchi 4'
   {$Else  Archi}
   {$IfDef EverestLite}
   ' CONST defEverestLite 4'
   {$EndIf EverestLite}
   {$EndIf Archi}

   {$EndIf Nemesis}
  ]);

  with TtfwAxiomaticsResNameGetters.Instance do
   for l_Index := 0 to Pred(Count) do
   begin
    l_Name := Items[l_Index].ResName;
    CompileResScriptToAxiomatics(theNewContext.rPrev^, 'res:' + l_Name);
   end;//for l_Index
 finally
  TtfwAutoregisteredDiction.Instance.AllAxiomaticsDefined := true;
 end;//try..finally

 l_SystemFilename := theNewContext.rPrev^.ResolveIncludedFilePath('Exports.script');
 if FileExists(l_SystemFilename) then
 begin
  l_NS := TtfwFileStreamFactory.Create(l_SystemFilename);
  try
   l_SI := TkwSystemIncluded.Create(l_NS);
   try
    l_SI.DoIt(theNewContext.rPrev^);
   finally
    FreeAndNil(l_SI);
   end;//try..finally
  finally
   FreeAndNil(l_NS);
  end;//try..finally
 end;//FileExists(l_SystemFilename);

 l_SystemFilename := theNewContext.rPrev^.ResolveIncludedFilePath('Exports.ms.dict');
 if FileExists(l_SystemFilename) then
 begin
  l_NS := TtfwFileStreamFactory.Create(l_SystemFilename);
  try
   l_SI := TkwSystemIncluded.Create(l_NS);
   try
    l_SI.DoIt(theNewContext.rPrev^);
   finally
    FreeAndNil(l_SI);
   end;//try..finally
  finally
   FreeAndNil(l_NS);
  end;//try..finally
 end;//FileExists(l_SystemFilename);
//#UC END# *4DB6CDDA038B_4DC90A1E03C2_impl*
end;//TkwMain.BeforeCompile

procedure TkwMain.AfterCompile(var theNewContext: TtfwContext;
 aCompiled: TkwCompiledWordPrim);
//#UC START# *4DB6CE2302C9_4DC90A1E03C2_var*
//#UC END# *4DB6CE2302C9_4DC90A1E03C2_var*
begin
//#UC START# *4DB6CE2302C9_4DC90A1E03C2_impl*
 inherited;
//#UC END# *4DB6CE2302C9_4DC90A1E03C2_impl*
end;//TkwMain.AfterCompile

function TkwMain.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4DC90A1E03C2_var*
//#UC END# *4DBAEE0D028D_4DC90A1E03C2_var*
begin
//#UC START# *4DBAEE0D028D_4DC90A1E03C2_impl*
 Result := TkwCompiledMain;
//#UC END# *4DBAEE0D028D_4DC90A1E03C2_impl*
end;//TkwMain.CompiledWordClass

function TkwMain.AcceptsEOF: Boolean;
//#UC START# *4DC2DEE70178_4DC90A1E03C2_var*
//#UC END# *4DC2DEE70178_4DC90A1E03C2_var*
begin
//#UC START# *4DC2DEE70178_4DC90A1E03C2_impl*
 Result := true;
//#UC END# *4DC2DEE70178_4DC90A1E03C2_impl*
end;//TkwMain.AcceptsEOF

class function TkwMain.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_4DC90A1E03C2_var*
//#UC END# *4DC2E05B03DD_4DC90A1E03C2_var*
begin
//#UC START# *4DC2E05B03DD_4DC90A1E03C2_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_4DC90A1E03C2_impl*
end;//TkwMain.ReallyNeedRegister

procedure TkwMain.RunCompiled(const aContext: TtfwContext);
//#UC START# *4DC90A79006D_4DC90A1E03C2_var*
//#UC END# *4DC90A79006D_4DC90A1E03C2_var*
begin
//#UC START# *4DC90A79006D_4DC90A1E03C2_impl*
 Tl3EtalonsService.Instance.EtalonNeedsComputerName := false;
 Tl3EtalonsService.Instance.EtalonNeedsOSName := false;
 {$IfDef XE}
 Tl3EtalonsService.Instance.EtalonNeedsXE := false;
 {$EndIf XE}
 Tl3EtalonsService.Instance.EtalonNeeds64 := false;
 inherited;
//#UC END# *4DC90A79006D_4DC90A1E03C2_impl*
end;//TkwMain.RunCompiled

procedure TkwMain.Script(aStream: TtfwStreamFactory;
 const aCaller: ItfwScriptCaller);
//#UC START# *4F733B9C0064_4DC90A1E03C2_var*
var
 l_PrevScriptEngine : TkwMain;
//#UC END# *4F733B9C0064_4DC90A1E03C2_var*
begin
//#UC START# *4F733B9C0064_4DC90A1E03C2_impl*
 l_PrevScriptEngine := g_ScriptEngine;
 try
  g_ScriptEngine := Self;
  inherited Script(aStream, aCaller);
 finally
  g_ScriptEngine := l_PrevScriptEngine;
 end;//try..finally
//#UC END# *4F733B9C0064_4DC90A1E03C2_impl*
end;//TkwMain.Script

initialization
 TkwMainResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwMain.RegisterInEngine;
 {* Регистрация TkwMain }
{$IfEnd} // NOT Defined(NoScripts)

end.
