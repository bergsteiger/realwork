unit PictureInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы PictureInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\PictureInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , eeMemoWithEditOperations
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_PictureInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы PictureInfo
----
*Пример использования*:
[code]
'aControl' форма::PictureInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_PictureInfo

 Tkw_PictureInfo_Control_Info = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Info
----
*Пример использования*:
[code]
контрол::Info TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PictureInfo_Control_Info

 Tkw_PictureInfo_Control_Info_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Info
----
*Пример использования*:
[code]
контрол::Info:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PictureInfo_Control_Info_Push

 TkwEnPictureInfoInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_PictureInfo.Info
[panel]Контрол Info формы Ten_PictureInfo[panel]
*Тип результата:* TeeMemoWithEditOperations
*Пример:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aen_PictureInfo .Ten_PictureInfo.Info >>> l_TeeMemoWithEditOperations
[code]  }
  private
   function Info(const aCtx: TtfwContext;
    aen_PictureInfo: Ten_PictureInfo): TeeMemoWithEditOperations;
    {* Реализация слова скрипта .Ten_PictureInfo.Info }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPictureInfoInfo

class function Tkw_Form_PictureInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::PictureInfo';
end;//Tkw_Form_PictureInfo.GetWordNameForRegister

function Tkw_Form_PictureInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D75DB6A2BDA5_var*
//#UC END# *4DDFD2EA0116_D75DB6A2BDA5_var*
begin
//#UC START# *4DDFD2EA0116_D75DB6A2BDA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D75DB6A2BDA5_impl*
end;//Tkw_Form_PictureInfo.GetString

class function Tkw_PictureInfo_Control_Info.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Info';
end;//Tkw_PictureInfo_Control_Info.GetWordNameForRegister

function Tkw_PictureInfo_Control_Info.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D49FEF176C47_var*
//#UC END# *4DDFD2EA0116_D49FEF176C47_var*
begin
//#UC START# *4DDFD2EA0116_D49FEF176C47_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D49FEF176C47_impl*
end;//Tkw_PictureInfo_Control_Info.GetString

class procedure Tkw_PictureInfo_Control_Info.RegisterInEngine;
//#UC START# *52A086150180_D49FEF176C47_var*
//#UC END# *52A086150180_D49FEF176C47_var*
begin
//#UC START# *52A086150180_D49FEF176C47_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D49FEF176C47_impl*
end;//Tkw_PictureInfo_Control_Info.RegisterInEngine

procedure Tkw_PictureInfo_Control_Info_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1AE4BCF9ACB6_var*
//#UC END# *4DAEEDE10285_1AE4BCF9ACB6_var*
begin
//#UC START# *4DAEEDE10285_1AE4BCF9ACB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1AE4BCF9ACB6_impl*
end;//Tkw_PictureInfo_Control_Info_Push.DoDoIt

class function Tkw_PictureInfo_Control_Info_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Info:push';
end;//Tkw_PictureInfo_Control_Info_Push.GetWordNameForRegister

function TkwEnPictureInfoInfo.Info(const aCtx: TtfwContext;
 aen_PictureInfo: Ten_PictureInfo): TeeMemoWithEditOperations;
 {* Реализация слова скрипта .Ten_PictureInfo.Info }
//#UC START# *97873E0A4C48_9B1531781ADE_var*
//#UC END# *97873E0A4C48_9B1531781ADE_var*
begin
//#UC START# *97873E0A4C48_9B1531781ADE_impl*
 !!! Needs to be implemented !!!
//#UC END# *97873E0A4C48_9B1531781ADE_impl*
end;//TkwEnPictureInfoInfo.Info

procedure TkwEnPictureInfoInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9B1531781ADE_var*
//#UC END# *4DAEEDE10285_9B1531781ADE_var*
begin
//#UC START# *4DAEEDE10285_9B1531781ADE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9B1531781ADE_impl*
end;//TkwEnPictureInfoInfo.DoDoIt

class function TkwEnPictureInfoInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PictureInfo.Info';
end;//TkwEnPictureInfoInfo.GetWordNameForRegister

procedure TkwEnPictureInfoInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9B1531781ADE_var*
//#UC END# *52D00B00031A_9B1531781ADE_var*
begin
//#UC START# *52D00B00031A_9B1531781ADE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9B1531781ADE_impl*
end;//TkwEnPictureInfoInfo.SetValuePrim

function TkwEnPictureInfoInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9B1531781ADE_var*
//#UC END# *551544E2001A_9B1531781ADE_var*
begin
//#UC START# *551544E2001A_9B1531781ADE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9B1531781ADE_impl*
end;//TkwEnPictureInfoInfo.GetResultTypeInfo

function TkwEnPictureInfoInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_9B1531781ADE_var*
//#UC END# *559687E6025A_9B1531781ADE_var*
begin
//#UC START# *559687E6025A_9B1531781ADE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_9B1531781ADE_impl*
end;//TkwEnPictureInfoInfo.GetAllParamsCount

function TkwEnPictureInfoInfo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9B1531781ADE_var*
//#UC END# *5617F4D00243_9B1531781ADE_var*
begin
//#UC START# *5617F4D00243_9B1531781ADE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9B1531781ADE_impl*
end;//TkwEnPictureInfoInfo.ParamsTypes

initialization
 Tkw_Form_PictureInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_PictureInfo }
 Tkw_PictureInfo_Control_Info.RegisterInEngine;
 {* Регистрация Tkw_PictureInfo_Control_Info }
 Tkw_PictureInfo_Control_Info_Push.RegisterInEngine;
 {* Регистрация Tkw_PictureInfo_Control_Info_Push }
 TkwEnPictureInfoInfo.RegisterInEngine;
 {* Регистрация en_PictureInfo_Info }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PictureInfo));
 {* Регистрация типа PictureInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* Регистрация типа TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
