unit MedicListSynchroViewKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/MedicListSynchroViewKeywordsPack.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::MedicListSynchroViewKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы MedicListSynchroView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  vtPanel,
  MedicListSynchroView_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_MedicListSynchroView = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы MedicListSynchroView
----
*Пример использования*:
[code]
'aControl' форма::MedicListSynchroView TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_MedicListSynchroView

// start class Tkw_Form_MedicListSynchroView

class function Tkw_Form_MedicListSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetWordNameForRegister

function Tkw_Form_MedicListSynchroView.GetString: AnsiString;
 {-}
begin
 Result := 'en_MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetString

type
  Tkw_MedicListSynchroView_Control_ztChild = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ztChild
----
*Пример использования*:
[code]
контрол::ztChild TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicListSynchroView_Control_ztChild

// start class Tkw_MedicListSynchroView_Control_ztChild

class function Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister

function Tkw_MedicListSynchroView_Control_ztChild.GetString: AnsiString;
 {-}
begin
 Result := 'ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetString

class procedure Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine

type
  Tkw_MedicListSynchroView_Control_ztChild_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ztChild
----
*Пример использования*:
[code]
контрол::ztChild:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicListSynchroView_Control_ztChild_Push

// start class Tkw_MedicListSynchroView_Control_ztChild_Push

procedure Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ztChild');
 inherited;
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt

class function Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ztChild:push';
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister

type
  TkwEnMedicListSynchroViewZtChild = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_MedicListSynchroView.ztChild
[panel]Контрол ztChild формы Ten_MedicListSynchroView[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicListSynchroView .Ten_MedicListSynchroView.ztChild >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ZtChild(const aCtx: TtfwContext;
     aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
     {* Реализация слова скрипта .Ten_MedicListSynchroView.ztChild }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnMedicListSynchroViewZtChild

// start class TkwEnMedicListSynchroViewZtChild

function TkwEnMedicListSynchroViewZtChild.ZtChild(const aCtx: TtfwContext;
  aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
 {-}
begin
 Result := aen_MedicListSynchroView.ztChild;
end;//TkwEnMedicListSynchroViewZtChild.ZtChild

procedure TkwEnMedicListSynchroViewZtChild.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicListSynchroView : Ten_MedicListSynchroView;
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
 aCtx.rEngine.PushObj((ZtChild(aCtx, l_aen_MedicListSynchroView)));
end;//TkwEnMedicListSynchroViewZtChild.DoDoIt

class function TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicListSynchroView.ztChild';
end;//TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister

procedure TkwEnMedicListSynchroViewZtChild.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ztChild', aCtx);
end;//TkwEnMedicListSynchroViewZtChild.SetValuePrim

function TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo

function TkwEnMedicListSynchroViewZtChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicListSynchroViewZtChild.GetAllParamsCount

function TkwEnMedicListSynchroViewZtChild.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicListSynchroView)]);
end;//TkwEnMedicListSynchroViewZtChild.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_MedicListSynchroView
 Tkw_Form_MedicListSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicListSynchroView_Control_ztChild
 Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MedicListSynchroView_Control_ztChild_Push
 Tkw_MedicListSynchroView_Control_ztChild_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_MedicListSynchroView_ztChild
 TkwEnMedicListSynchroViewZtChild.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа MedicListSynchroView
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicListSynchroView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.