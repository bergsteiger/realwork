unit SaveDialogWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\SaveDialogWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SaveDialogWordsPack" MUID: (574480200219)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , nsTypes
 , PresentationInterfaces
 , nsSaveDialogExecutor
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *574480200219impl_uses*
 //#UC END# *574480200219impl_uses*
;

type
 TkwSaveDialogGetFileName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SaveDialog:GetFileName }
  private
   function SaveDialog_GetFileName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта SaveDialog:GetFileName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSaveDialogGetFileName

 TkwSaveDialogSetFileFormat = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SaveDialog:SetFileFormat }
  private
   procedure SaveDialog_SetFileFormat(const aCtx: TtfwContext;
    aFileFormat: TnsFileFormat);
    {* Реализация слова скрипта SaveDialog:SetFileFormat }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSaveDialogSetFileFormat

 TkwSaveDialogSetSaveObjects = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SaveDialog:SetSaveObjects }
  private
   procedure SaveDialog_SetSaveObjects(const aCtx: TtfwContext;
    aValue: TnsSaveDialogListTarget);
    {* Реализация слова скрипта SaveDialog:SetSaveObjects }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSaveDialogSetSaveObjects

 TkwSaveDialogSetMergeFiles = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SaveDialog:SetMergeFiles }
  private
   procedure SaveDialog_SetMergeFiles(const aCtx: TtfwContext;
    aValue: Boolean);
    {* Реализация слова скрипта SaveDialog:SetMergeFiles }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSaveDialogSetMergeFiles

 TkwSaveDialogSetSelectedOnly = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SaveDialog:SetSelectedOnly }
  private
   procedure SaveDialog_SetSelectedOnly(const aCtx: TtfwContext;
    aValue: Boolean);
    {* Реализация слова скрипта SaveDialog:SetSelectedOnly }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSaveDialogSetSelectedOnly

function TkwSaveDialogGetFileName.SaveDialog_GetFileName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта SaveDialog:GetFileName }
//#UC START# *5744803103A2_5744803103A2_Word_var*
//#UC END# *5744803103A2_5744803103A2_Word_var*
begin
//#UC START# *5744803103A2_5744803103A2_Word_impl*
 Result := TnsSaveDialogExecutor.Instance.GetFileName;
//#UC END# *5744803103A2_5744803103A2_Word_impl*
end;//TkwSaveDialogGetFileName.SaveDialog_GetFileName

class function TkwSaveDialogGetFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveDialog:GetFileName';
end;//TkwSaveDialogGetFileName.GetWordNameForRegister

function TkwSaveDialogGetFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSaveDialogGetFileName.GetResultTypeInfo

function TkwSaveDialogGetFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSaveDialogGetFileName.GetAllParamsCount

function TkwSaveDialogGetFileName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSaveDialogGetFileName.ParamsTypes

procedure TkwSaveDialogGetFileName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(SaveDialog_GetFileName(aCtx));
end;//TkwSaveDialogGetFileName.DoDoIt

procedure TkwSaveDialogSetFileFormat.SaveDialog_SetFileFormat(const aCtx: TtfwContext;
 aFileFormat: TnsFileFormat);
 {* Реализация слова скрипта SaveDialog:SetFileFormat }
//#UC START# *574480410161_574480410161_Word_var*
//#UC END# *574480410161_574480410161_Word_var*
begin
//#UC START# *574480410161_574480410161_Word_impl*
 TnsSaveDialogExecutor.Instance.SetFileFormat(aFileFormat);
//#UC END# *574480410161_574480410161_Word_impl*
end;//TkwSaveDialogSetFileFormat.SaveDialog_SetFileFormat

class function TkwSaveDialogSetFileFormat.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveDialog:SetFileFormat';
end;//TkwSaveDialogSetFileFormat.GetWordNameForRegister

function TkwSaveDialogSetFileFormat.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSaveDialogSetFileFormat.GetResultTypeInfo

function TkwSaveDialogSetFileFormat.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSaveDialogSetFileFormat.GetAllParamsCount

function TkwSaveDialogSetFileFormat.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsFileFormat)]);
end;//TkwSaveDialogSetFileFormat.ParamsTypes

procedure TkwSaveDialogSetFileFormat.DoDoIt(const aCtx: TtfwContext);
var l_aFileFormat: TnsFileFormat;
begin
 try
  l_aFileFormat := TnsFileFormat(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileFormat: TnsFileFormat : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SaveDialog_SetFileFormat(aCtx, l_aFileFormat);
end;//TkwSaveDialogSetFileFormat.DoDoIt

procedure TkwSaveDialogSetSaveObjects.SaveDialog_SetSaveObjects(const aCtx: TtfwContext;
 aValue: TnsSaveDialogListTarget);
 {* Реализация слова скрипта SaveDialog:SetSaveObjects }
//#UC START# *57FCE34603AA_57FCE34603AA_Word_var*
//#UC END# *57FCE34603AA_57FCE34603AA_Word_var*
begin
//#UC START# *57FCE34603AA_57FCE34603AA_Word_impl*
 TnsSaveDialogExecutor.Instance.SetSaveObjects(aValue);
//#UC END# *57FCE34603AA_57FCE34603AA_Word_impl*
end;//TkwSaveDialogSetSaveObjects.SaveDialog_SetSaveObjects

class function TkwSaveDialogSetSaveObjects.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveDialog:SetSaveObjects';
end;//TkwSaveDialogSetSaveObjects.GetWordNameForRegister

function TkwSaveDialogSetSaveObjects.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSaveDialogSetSaveObjects.GetResultTypeInfo

function TkwSaveDialogSetSaveObjects.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSaveDialogSetSaveObjects.GetAllParamsCount

function TkwSaveDialogSetSaveObjects.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnsSaveDialogListTarget)]);
end;//TkwSaveDialogSetSaveObjects.ParamsTypes

procedure TkwSaveDialogSetSaveObjects.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TnsSaveDialogListTarget;
begin
 try
  l_aValue := TnsSaveDialogListTarget(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TnsSaveDialogListTarget : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SaveDialog_SetSaveObjects(aCtx, l_aValue);
end;//TkwSaveDialogSetSaveObjects.DoDoIt

procedure TkwSaveDialogSetMergeFiles.SaveDialog_SetMergeFiles(const aCtx: TtfwContext;
 aValue: Boolean);
 {* Реализация слова скрипта SaveDialog:SetMergeFiles }
//#UC START# *57FCE37F01BC_57FCE37F01BC_Word_var*
//#UC END# *57FCE37F01BC_57FCE37F01BC_Word_var*
begin
//#UC START# *57FCE37F01BC_57FCE37F01BC_Word_impl*
 TnsSaveDialogExecutor.Instance.SetMergeFiles(aValue);
//#UC END# *57FCE37F01BC_57FCE37F01BC_Word_impl*
end;//TkwSaveDialogSetMergeFiles.SaveDialog_SetMergeFiles

class function TkwSaveDialogSetMergeFiles.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveDialog:SetMergeFiles';
end;//TkwSaveDialogSetMergeFiles.GetWordNameForRegister

function TkwSaveDialogSetMergeFiles.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSaveDialogSetMergeFiles.GetResultTypeInfo

function TkwSaveDialogSetMergeFiles.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSaveDialogSetMergeFiles.GetAllParamsCount

function TkwSaveDialogSetMergeFiles.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwSaveDialogSetMergeFiles.ParamsTypes

procedure TkwSaveDialogSetMergeFiles.DoDoIt(const aCtx: TtfwContext);
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
 SaveDialog_SetMergeFiles(aCtx, l_aValue);
end;//TkwSaveDialogSetMergeFiles.DoDoIt

procedure TkwSaveDialogSetSelectedOnly.SaveDialog_SetSelectedOnly(const aCtx: TtfwContext;
 aValue: Boolean);
 {* Реализация слова скрипта SaveDialog:SetSelectedOnly }
//#UC START# *57FCE9AC0123_57FCE9AC0123_Word_var*
//#UC END# *57FCE9AC0123_57FCE9AC0123_Word_var*
begin
//#UC START# *57FCE9AC0123_57FCE9AC0123_Word_impl*
 TnsSaveDialogExecutor.Instance.SetSelectedOnly(aValue);
//#UC END# *57FCE9AC0123_57FCE9AC0123_Word_impl*
end;//TkwSaveDialogSetSelectedOnly.SaveDialog_SetSelectedOnly

class function TkwSaveDialogSetSelectedOnly.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveDialog:SetSelectedOnly';
end;//TkwSaveDialogSetSelectedOnly.GetWordNameForRegister

function TkwSaveDialogSetSelectedOnly.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSaveDialogSetSelectedOnly.GetResultTypeInfo

function TkwSaveDialogSetSelectedOnly.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSaveDialogSetSelectedOnly.GetAllParamsCount

function TkwSaveDialogSetSelectedOnly.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwSaveDialogSetSelectedOnly.ParamsTypes

procedure TkwSaveDialogSetSelectedOnly.DoDoIt(const aCtx: TtfwContext);
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
 SaveDialog_SetSelectedOnly(aCtx, l_aValue);
end;//TkwSaveDialogSetSelectedOnly.DoDoIt

initialization
 TkwSaveDialogGetFileName.RegisterInEngine;
 {* Регистрация SaveDialog_GetFileName }
 TkwSaveDialogSetFileFormat.RegisterInEngine;
 {* Регистрация SaveDialog_SetFileFormat }
 TkwSaveDialogSetSaveObjects.RegisterInEngine;
 {* Регистрация SaveDialog_SetSaveObjects }
 TkwSaveDialogSetMergeFiles.RegisterInEngine;
 {* Регистрация SaveDialog_SetMergeFiles }
 TkwSaveDialogSetSelectedOnly.RegisterInEngine;
 {* Регистрация SaveDialog_SetSelectedOnly }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsFileFormat));
 {* Регистрация типа TnsFileFormat }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsSaveDialogListTarget));
 {* Регистрация типа TnsSaveDialogListTarget }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
