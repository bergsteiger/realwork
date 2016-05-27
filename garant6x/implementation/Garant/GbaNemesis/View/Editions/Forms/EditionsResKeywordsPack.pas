unit EditionsResKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы EditionsRes }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\EditionsResKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "EditionsResKeywordsPack" MUID: (4B50828502D7_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , EditionsRes_Form
 , tfwPropertyLike
 , vtPngImgList
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEditionsResFormEditionsStateIcons = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TEditionsResForm.EditionsStateIcons }
  private
   function EditionsStateIcons(const aCtx: TtfwContext;
    aEditionsResForm: TEditionsResForm): TvtPngImageList;
    {* Реализация слова скрипта .TEditionsResForm.EditionsStateIcons }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEditionsResFormEditionsStateIcons

 Tkw_Form_EditionsRes = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы EditionsRes
----
*Пример использования*:
[code]форма::EditionsRes TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_EditionsRes

 Tkw_EditionsRes_Component_EditionsStateIcons = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EditionsStateIcons
----
*Пример использования*:
[code]компонент::EditionsStateIcons TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsRes_Component_EditionsStateIcons

function TkwEditionsResFormEditionsStateIcons.EditionsStateIcons(const aCtx: TtfwContext;
 aEditionsResForm: TEditionsResForm): TvtPngImageList;
 {* Реализация слова скрипта .TEditionsResForm.EditionsStateIcons }
begin
 Result := aEditionsResForm.EditionsStateIcons;
end;//TkwEditionsResFormEditionsStateIcons.EditionsStateIcons

class function TkwEditionsResFormEditionsStateIcons.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsResForm.EditionsStateIcons';
end;//TkwEditionsResFormEditionsStateIcons.GetWordNameForRegister

function TkwEditionsResFormEditionsStateIcons.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPngImageList);
end;//TkwEditionsResFormEditionsStateIcons.GetResultTypeInfo

function TkwEditionsResFormEditionsStateIcons.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsResFormEditionsStateIcons.GetAllParamsCount

function TkwEditionsResFormEditionsStateIcons.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsResForm)]);
end;//TkwEditionsResFormEditionsStateIcons.ParamsTypes

procedure TkwEditionsResFormEditionsStateIcons.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EditionsStateIcons', aCtx);
end;//TkwEditionsResFormEditionsStateIcons.SetValuePrim

procedure TkwEditionsResFormEditionsStateIcons.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsResForm: TEditionsResForm;
begin
 try
  l_aEditionsResForm := TEditionsResForm(aCtx.rEngine.PopObjAs(TEditionsResForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditionsResForm: TEditionsResForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EditionsStateIcons(aCtx, l_aEditionsResForm));
end;//TkwEditionsResFormEditionsStateIcons.DoDoIt

function Tkw_Form_EditionsRes.GetString: AnsiString;
begin
 Result := 'EditionsResForm';
end;//Tkw_Form_EditionsRes.GetString

class procedure Tkw_Form_EditionsRes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TEditionsResForm);
end;//Tkw_Form_EditionsRes.RegisterInEngine

class function Tkw_Form_EditionsRes.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::EditionsRes';
end;//Tkw_Form_EditionsRes.GetWordNameForRegister

function Tkw_EditionsRes_Component_EditionsStateIcons.GetString: AnsiString;
begin
 Result := 'EditionsStateIcons';
end;//Tkw_EditionsRes_Component_EditionsStateIcons.GetString

class procedure Tkw_EditionsRes_Component_EditionsStateIcons.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPngImageList);
end;//Tkw_EditionsRes_Component_EditionsStateIcons.RegisterInEngine

class function Tkw_EditionsRes_Component_EditionsStateIcons.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::EditionsStateIcons';
end;//Tkw_EditionsRes_Component_EditionsStateIcons.GetWordNameForRegister

initialization
 TkwEditionsResFormEditionsStateIcons.RegisterInEngine;
 {* Регистрация EditionsResForm_EditionsStateIcons }
 Tkw_Form_EditionsRes.RegisterInEngine;
 {* Регистрация Tkw_Form_EditionsRes }
 Tkw_EditionsRes_Component_EditionsStateIcons.RegisterInEngine;
 {* Регистрация Tkw_EditionsRes_Component_EditionsStateIcons }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditionsResForm));
 {* Регистрация типа TEditionsResForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPngImageList));
 {* Регистрация типа TvtPngImageList }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
