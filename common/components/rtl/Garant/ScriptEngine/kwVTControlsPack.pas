unit kwVTControlsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwVTControlsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwVTControlsPack" MUID: (4F6096D500C3)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , DragData
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwDDSupportGetState = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DDSupport:GetState }
  private
   function DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
    {* Реализация слова скрипта DDSupport:GetState }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDDSupportGetState

function TkwDDSupportGetState.DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
 {* Реализация слова скрипта DDSupport:GetState }
//#UC START# *552E449000E2_552E449000E2_Word_var*
//#UC END# *552E449000E2_552E449000E2_Word_var*
begin
//#UC START# *552E449000E2_552E449000E2_Word_impl*
 Result := TDragDataSupport.Instance.DragState; 
//#UC END# *552E449000E2_552E449000E2_Word_impl*
end;//TkwDDSupportGetState.DDSupport_GetState

class function TkwDDSupportGetState.GetWordNameForRegister: AnsiString;
begin
 Result := 'DDSupport:GetState';
end;//TkwDDSupportGetState.GetWordNameForRegister

function TkwDDSupportGetState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TDragDataState);
end;//TkwDDSupportGetState.GetResultTypeInfo

function TkwDDSupportGetState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDDSupportGetState.GetAllParamsCount

function TkwDDSupportGetState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDDSupportGetState.ParamsTypes

procedure TkwDDSupportGetState.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(Ord(DDSupport_GetState(aCtx)));
end;//TkwDDSupportGetState.DoDoIt

initialization
 TkwDDSupportGetState.RegisterInEngine;
 {* Регистрация DDSupport_GetState }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDragDataState));
 {* Регистрация типа TDragDataState }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
