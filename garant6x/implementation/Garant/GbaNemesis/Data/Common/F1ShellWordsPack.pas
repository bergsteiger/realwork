unit F1ShellWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\F1ShellWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "F1ShellWordsPack" MUID: (4DCA54B9020D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3ProtoObject
 , nsShellService
 , l3Interfaces
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , l3TreeInterfaces
 , nsExternalObjectPrim
 , nsUtils
 , bsUtils
 , SysUtils
 , l3Base
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4DCA54B9020Dimpl_uses*
 , nsTypes
 //#UC END# *4DCA54B9020Dimpl_uses*
;

type
 TnsShellServiceImpl = {final} class(Tl3ProtoObject, InsShellService)
  private
   HookShellExecute: Boolean;
   LastShellExecuteFile: Il3CString;
  public
   function ShellExecute(const aFile: Il3CString;
    aSetReadOnlyToFile: Boolean): Boolean;
   class function Instance: TnsShellServiceImpl;
    {* Метод получения экземпляра синглетона TnsShellServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsShellServiceImpl

 TkwBrowse = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта browse }
  private
   procedure browse(const aCtx: TtfwContext;
    const aStr: Il3CString);
    {* Реализация слова скрипта browse }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBrowse

 TkwF1WasBeep = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта f1::WasBeep }
  private
   function f1_WasBeep(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта f1::WasBeep }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1WasBeep

 TkwSetHookShellExecute = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetHookShellExecute }
  private
   procedure SetHookShellExecute(const aCtx: TtfwContext;
    aValue: Boolean);
    {* Реализация слова скрипта SetHookShellExecute }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetHookShellExecute

 TkwGetLastShellExecuteFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLastShellExecuteFile }
  private
   function GetLastShellExecuteFile(const aCtx: TtfwContext): Il3CString;
    {* Реализация слова скрипта GetLastShellExecuteFile }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetLastShellExecuteFile

 TkwF1ImportXML = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта f1::ImportXML }
  private
   procedure f1_ImportXML(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode;
    const aFileName: AnsiString);
    {* Реализация слова скрипта f1::ImportXML }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1ImportXML

var g_TnsShellServiceImpl: TnsShellServiceImpl = nil;
 {* Экземпляр синглетона TnsShellServiceImpl }

procedure TnsShellServiceImplFree;
 {* Метод освобождения экземпляра синглетона TnsShellServiceImpl }
begin
 l3Free(g_TnsShellServiceImpl);
end;//TnsShellServiceImplFree

function TnsShellServiceImpl.ShellExecute(const aFile: Il3CString;
 aSetReadOnlyToFile: Boolean): Boolean;
//#UC START# *F7FE987044FC_57A8712A01C9_var*
//#UC END# *F7FE987044FC_57A8712A01C9_var*
begin
//#UC START# *F7FE987044FC_57A8712A01C9_impl*
 if HookShellExecute then
 begin
  Result := true;
  LastShellExecuteFile := aFile;
 end//HookShellExecute
 else
  Result := TnsShellService.Instance.CallShellExecute(aFile, aSetReadOnlyToFile);
//#UC END# *F7FE987044FC_57A8712A01C9_impl*
end;//TnsShellServiceImpl.ShellExecute

class function TnsShellServiceImpl.Instance: TnsShellServiceImpl;
 {* Метод получения экземпляра синглетона TnsShellServiceImpl }
begin
 if (g_TnsShellServiceImpl = nil) then
 begin
  l3System.AddExitProc(TnsShellServiceImplFree);
  g_TnsShellServiceImpl := Create;
 end;
 Result := g_TnsShellServiceImpl;
end;//TnsShellServiceImpl.Instance

class function TnsShellServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsShellServiceImpl <> nil;
end;//TnsShellServiceImpl.Exists

procedure TkwBrowse.browse(const aCtx: TtfwContext;
 const aStr: Il3CString);
 {* Реализация слова скрипта browse }
//#UC START# *556C08A80212_556C08A80212_Word_var*
//#UC END# *556C08A80212_556C08A80212_Word_var*
begin
//#UC START# *556C08A80212_556C08A80212_Word_impl*
 nsDoShellExecute(aStr, False, nil, True);
//#UC END# *556C08A80212_556C08A80212_Word_impl*
end;//TkwBrowse.browse

class function TkwBrowse.GetWordNameForRegister: AnsiString;
begin
 Result := 'browse';
end;//TkwBrowse.GetWordNameForRegister

function TkwBrowse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwBrowse.GetResultTypeInfo

function TkwBrowse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBrowse.GetAllParamsCount

function TkwBrowse.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwBrowse.ParamsTypes

procedure TkwBrowse.DoDoIt(const aCtx: TtfwContext);
var l_aStr: Il3CString;
begin
 try
  l_aStr := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 browse(aCtx, l_aStr);
end;//TkwBrowse.DoDoIt

function TkwF1WasBeep.f1_WasBeep(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта f1::WasBeep }
//#UC START# *556C08EF0058_556C08EF0058_Word_var*
//#UC END# *556C08EF0058_556C08EF0058_Word_var*
begin
//#UC START# *556C08EF0058_556C08EF0058_Word_impl*
 {$IfDef InsiderTest}
 Result := g_WasBeep;
 g_WasBeep := false;
 {$Else  InsiderTest}
 Result := false;
 {$EndIf InsiderTest}
//#UC END# *556C08EF0058_556C08EF0058_Word_impl*
end;//TkwF1WasBeep.f1_WasBeep

class function TkwF1WasBeep.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1::WasBeep';
end;//TkwF1WasBeep.GetWordNameForRegister

function TkwF1WasBeep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwF1WasBeep.GetResultTypeInfo

function TkwF1WasBeep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwF1WasBeep.GetAllParamsCount

function TkwF1WasBeep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwF1WasBeep.ParamsTypes

procedure TkwF1WasBeep.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(f1_WasBeep(aCtx));
end;//TkwF1WasBeep.DoDoIt

procedure TkwSetHookShellExecute.SetHookShellExecute(const aCtx: TtfwContext;
 aValue: Boolean);
 {* Реализация слова скрипта SetHookShellExecute }
//#UC START# *57A871C2016D_57A871C2016D_Word_var*
//#UC END# *57A871C2016D_57A871C2016D_Word_var*
begin
//#UC START# *57A871C2016D_57A871C2016D_Word_impl*
 TnsShellServiceImpl.Instance.HookShellExecute := aValue;
//#UC END# *57A871C2016D_57A871C2016D_Word_impl*
end;//TkwSetHookShellExecute.SetHookShellExecute

class function TkwSetHookShellExecute.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetHookShellExecute';
end;//TkwSetHookShellExecute.GetWordNameForRegister

function TkwSetHookShellExecute.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetHookShellExecute.GetResultTypeInfo

function TkwSetHookShellExecute.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSetHookShellExecute.GetAllParamsCount

function TkwSetHookShellExecute.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwSetHookShellExecute.ParamsTypes

procedure TkwSetHookShellExecute.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Boolean;
begin
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetHookShellExecute(aCtx, l_aValue);
end;//TkwSetHookShellExecute.DoDoIt

function TkwGetLastShellExecuteFile.GetLastShellExecuteFile(const aCtx: TtfwContext): Il3CString;
 {* Реализация слова скрипта GetLastShellExecuteFile }
//#UC START# *57A8768002CE_57A8768002CE_Word_var*
//#UC END# *57A8768002CE_57A8768002CE_Word_var*
begin
//#UC START# *57A8768002CE_57A8768002CE_Word_impl*
 Result := TnsShellServiceImpl.Instance.LastShellExecuteFile;
//#UC END# *57A8768002CE_57A8768002CE_Word_impl*
end;//TkwGetLastShellExecuteFile.GetLastShellExecuteFile

class function TkwGetLastShellExecuteFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLastShellExecuteFile';
end;//TkwGetLastShellExecuteFile.GetWordNameForRegister

function TkwGetLastShellExecuteFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwGetLastShellExecuteFile.GetResultTypeInfo

function TkwGetLastShellExecuteFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLastShellExecuteFile.GetAllParamsCount

function TkwGetLastShellExecuteFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetLastShellExecuteFile.ParamsTypes

procedure TkwGetLastShellExecuteFile.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(GetLastShellExecuteFile(aCtx));
end;//TkwGetLastShellExecuteFile.DoDoIt

procedure TkwF1ImportXML.f1_ImportXML(const aCtx: TtfwContext;
 const aNode: Il3SimpleNode;
 const aFileName: AnsiString);
 {* Реализация слова скрипта f1::ImportXML }
//#UC START# *57BAFDD80224_57BAFDD80224_Word_var*
var
 S: String;
//#UC END# *57BAFDD80224_57BAFDD80224_Word_var*
begin
//#UC START# *57BAFDD80224_57BAFDD80224_Word_impl*
 S := aCtx.rCaller.ResolveInputFilePath(aFileName);
 RunnerAssert(bsCanImportNodeFromXML(aNode), 'Нельзя импортировать в это место', aCtx);
 bsImportNodeFromXML(aNode, nsWStr(S));
//#UC END# *57BAFDD80224_57BAFDD80224_Word_impl*
end;//TkwF1ImportXML.f1_ImportXML

class function TkwF1ImportXML.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1::ImportXML';
end;//TkwF1ImportXML.GetWordNameForRegister

function TkwF1ImportXML.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwF1ImportXML.GetResultTypeInfo

function TkwF1ImportXML.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwF1ImportXML.GetAllParamsCount

function TkwF1ImportXML.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode), @tfw_tiString]);
end;//TkwF1ImportXML.ParamsTypes

procedure TkwF1ImportXML.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3SimpleNode;
var l_aFileName: AnsiString;
begin
 try
  l_aNode := Il3SimpleNode(aCtx.rEngine.PopIntf(Il3SimpleNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3SimpleNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 f1_ImportXML(aCtx, l_aNode, l_aFileName);
end;//TkwF1ImportXML.DoDoIt

initialization
 TnsShellService.Instance.Alien := TnsShellServiceImpl.Instance;
 {* Регистрация TnsShellServiceImpl }
 TkwBrowse.RegisterInEngine;
 {* Регистрация browse }
 TkwF1WasBeep.RegisterInEngine;
 {* Регистрация f1__WasBeep }
 TkwSetHookShellExecute.RegisterInEngine;
 {* Регистрация SetHookShellExecute }
 TkwGetLastShellExecuteFile.RegisterInEngine;
 {* Регистрация GetLastShellExecuteFile }
 TkwF1ImportXML.RegisterInEngine;
 {* Регистрация f1__ImportXML }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
 {* Регистрация типа Il3SimpleNode }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
