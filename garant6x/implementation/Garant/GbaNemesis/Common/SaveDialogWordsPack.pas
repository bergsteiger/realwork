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
 , nsSaveDialogExecutor
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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

initialization
 TkwSaveDialogGetFileName.RegisterInEngine;
 {* Регистрация SaveDialog_GetFileName }
 TkwSaveDialogSetFileFormat.RegisterInEngine;
 {* Регистрация SaveDialog_SetFileFormat }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsFileFormat));
 {* Регистрация типа TnsFileFormat }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
