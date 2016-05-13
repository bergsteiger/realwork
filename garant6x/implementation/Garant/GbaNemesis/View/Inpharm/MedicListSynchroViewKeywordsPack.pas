unit MedicListSynchroViewKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MedicListSynchroView }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\MedicListSynchroViewKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MedicListSynchroViewKeywordsPack" MUID: (5F5E4EB27C9F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , MedicListSynchroView_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_MedicListSynchroView = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MedicListSynchroView
----
*Пример использования*:
[code]
'aControl' форма::MedicListSynchroView TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MedicListSynchroView

 Tkw_MedicListSynchroView_Control_ztChild = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ztChild
----
*Пример использования*:
[code]
контрол::ztChild TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicListSynchroView_Control_ztChild

 Tkw_MedicListSynchroView_Control_ztChild_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ztChild
----
*Пример использования*:
[code]
контрол::ztChild:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicListSynchroView_Control_ztChild_Push

 TkwEnMedicListSynchroViewZtChild = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicListSynchroView.ztChild }
  private
   function ztChild(const aCtx: TtfwContext;
    aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
    {* Реализация слова скрипта .Ten_MedicListSynchroView.ztChild }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicListSynchroViewZtChild

function Tkw_Form_MedicListSynchroView.GetString: AnsiString;
begin
 Result := 'en_MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetString

class function Tkw_Form_MedicListSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetWordNameForRegister

function Tkw_MedicListSynchroView_Control_ztChild.GetString: AnsiString;
begin
 Result := 'ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetString

class procedure Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine

class function Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister

procedure Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ztChild');
 inherited;
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt

class function Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ztChild:push';
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister

function TkwEnMedicListSynchroViewZtChild.ztChild(const aCtx: TtfwContext;
 aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
 {* Реализация слова скрипта .Ten_MedicListSynchroView.ztChild }
begin
 Result := aen_MedicListSynchroView.ztChild;
end;//TkwEnMedicListSynchroViewZtChild.ztChild

procedure TkwEnMedicListSynchroViewZtChild.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicListSynchroView: Ten_MedicListSynchroView;
begin
 try
  l_aen_MedicListSynchroView := Ten_MedicListSynchroView(aCtx.rEngine.PopObjAs(Ten_MedicListSynchroView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicListSynchroView: Ten_MedicListSynchroView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ztChild(aCtx, l_aen_MedicListSynchroView));
end;//TkwEnMedicListSynchroViewZtChild.DoDoIt

class function TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicListSynchroView.ztChild';
end;//TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister

function TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo

function TkwEnMedicListSynchroViewZtChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicListSynchroViewZtChild.GetAllParamsCount

function TkwEnMedicListSynchroViewZtChild.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicListSynchroView)]);
end;//TkwEnMedicListSynchroViewZtChild.ParamsTypes

procedure TkwEnMedicListSynchroViewZtChild.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ztChild', aCtx);
end;//TkwEnMedicListSynchroViewZtChild.SetValuePrim

initialization
 Tkw_Form_MedicListSynchroView.RegisterInEngine;
 {* Регистрация Tkw_Form_MedicListSynchroView }
 Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
 {* Регистрация Tkw_MedicListSynchroView_Control_ztChild }
 Tkw_MedicListSynchroView_Control_ztChild_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicListSynchroView_Control_ztChild_Push }
 TkwEnMedicListSynchroViewZtChild.RegisterInEngine;
 {* Регистрация en_MedicListSynchroView_ztChild }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicListSynchroView));
 {* Регистрация типа Ten_MedicListSynchroView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
