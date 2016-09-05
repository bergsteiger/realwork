unit ListAnalizerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ListAnalizer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ListAnalizerKeywordsPack" MUID: (4AA0CE0E02C4_Pack)

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
 , ListAnalizer_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , eeTreeView
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AA0CE0E02C4_Packimpl_uses*
 //#UC END# *4AA0CE0E02C4_Packimpl_uses*
;

type
 TkwListAnalizerFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TListAnalizerForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aListAnalizerForm: TListAnalizerForm): TvtPanel;
    {* Реализация слова скрипта .TListAnalizerForm.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwListAnalizerFormBackgroundPanel

 TkwListAnalizerFormListTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TListAnalizerForm.ListTree }
  private
   function ListTree(const aCtx: TtfwContext;
    aListAnalizerForm: TListAnalizerForm): TeeTreeView;
    {* Реализация слова скрипта .TListAnalizerForm.ListTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwListAnalizerFormListTree

 Tkw_Form_ListAnalizer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ListAnalizer
----
*Пример использования*:
[code]форма::ListAnalizer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ListAnalizer

 Tkw_ListAnalizer_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListAnalizer_Control_BackgroundPanel

 Tkw_ListAnalizer_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListAnalizer_Control_BackgroundPanel_Push

 Tkw_ListAnalizer_Control_ListTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ListTree
----
*Пример использования*:
[code]контрол::ListTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListAnalizer_Control_ListTree

 Tkw_ListAnalizer_Control_ListTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ListTree
----
*Пример использования*:
[code]контрол::ListTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListAnalizer_Control_ListTree_Push

function TkwListAnalizerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aListAnalizerForm: TListAnalizerForm): TvtPanel;
 {* Реализация слова скрипта .TListAnalizerForm.BackgroundPanel }
begin
 Result := aListAnalizerForm.BackgroundPanel;
end;//TkwListAnalizerFormBackgroundPanel.BackgroundPanel

class function TkwListAnalizerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TListAnalizerForm.BackgroundPanel';
end;//TkwListAnalizerFormBackgroundPanel.GetWordNameForRegister

function TkwListAnalizerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwListAnalizerFormBackgroundPanel.GetResultTypeInfo

function TkwListAnalizerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwListAnalizerFormBackgroundPanel.GetAllParamsCount

function TkwListAnalizerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TListAnalizerForm)]);
end;//TkwListAnalizerFormBackgroundPanel.ParamsTypes

procedure TkwListAnalizerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwListAnalizerFormBackgroundPanel.SetValuePrim

procedure TkwListAnalizerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aListAnalizerForm: TListAnalizerForm;
begin
 try
  l_aListAnalizerForm := TListAnalizerForm(aCtx.rEngine.PopObjAs(TListAnalizerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aListAnalizerForm: TListAnalizerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aListAnalizerForm));
end;//TkwListAnalizerFormBackgroundPanel.DoDoIt

function TkwListAnalizerFormListTree.ListTree(const aCtx: TtfwContext;
 aListAnalizerForm: TListAnalizerForm): TeeTreeView;
 {* Реализация слова скрипта .TListAnalizerForm.ListTree }
begin
 Result := aListAnalizerForm.ListTree;
end;//TkwListAnalizerFormListTree.ListTree

class function TkwListAnalizerFormListTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TListAnalizerForm.ListTree';
end;//TkwListAnalizerFormListTree.GetWordNameForRegister

function TkwListAnalizerFormListTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwListAnalizerFormListTree.GetResultTypeInfo

function TkwListAnalizerFormListTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwListAnalizerFormListTree.GetAllParamsCount

function TkwListAnalizerFormListTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TListAnalizerForm)]);
end;//TkwListAnalizerFormListTree.ParamsTypes

procedure TkwListAnalizerFormListTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ListTree', aCtx);
end;//TkwListAnalizerFormListTree.SetValuePrim

procedure TkwListAnalizerFormListTree.DoDoIt(const aCtx: TtfwContext);
var l_aListAnalizerForm: TListAnalizerForm;
begin
 try
  l_aListAnalizerForm := TListAnalizerForm(aCtx.rEngine.PopObjAs(TListAnalizerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aListAnalizerForm: TListAnalizerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ListTree(aCtx, l_aListAnalizerForm));
end;//TkwListAnalizerFormListTree.DoDoIt

function Tkw_Form_ListAnalizer.GetString: AnsiString;
begin
 Result := 'ListAnalizerForm';
end;//Tkw_Form_ListAnalizer.GetString

class procedure Tkw_Form_ListAnalizer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TListAnalizerForm);
end;//Tkw_Form_ListAnalizer.RegisterInEngine

class function Tkw_Form_ListAnalizer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ListAnalizer';
end;//Tkw_Form_ListAnalizer.GetWordNameForRegister

function Tkw_ListAnalizer_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_ListAnalizer_Control_BackgroundPanel.GetString

class procedure Tkw_ListAnalizer_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ListAnalizer_Control_BackgroundPanel.RegisterInEngine

class function Tkw_ListAnalizer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_ListAnalizer_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_ListAnalizer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ListAnalizer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ListAnalizer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_ListAnalizer_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_ListAnalizer_Control_ListTree.GetString: AnsiString;
begin
 Result := 'ListTree';
end;//Tkw_ListAnalizer_Control_ListTree.GetString

class procedure Tkw_ListAnalizer_Control_ListTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_ListAnalizer_Control_ListTree.RegisterInEngine

class function Tkw_ListAnalizer_Control_ListTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListTree';
end;//Tkw_ListAnalizer_Control_ListTree.GetWordNameForRegister

procedure Tkw_ListAnalizer_Control_ListTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ListTree');
 inherited;
end;//Tkw_ListAnalizer_Control_ListTree_Push.DoDoIt

class function Tkw_ListAnalizer_Control_ListTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListTree:push';
end;//Tkw_ListAnalizer_Control_ListTree_Push.GetWordNameForRegister

initialization
 TkwListAnalizerFormBackgroundPanel.RegisterInEngine;
 {* Регистрация ListAnalizerForm_BackgroundPanel }
 TkwListAnalizerFormListTree.RegisterInEngine;
 {* Регистрация ListAnalizerForm_ListTree }
 Tkw_Form_ListAnalizer.RegisterInEngine;
 {* Регистрация Tkw_Form_ListAnalizer }
 Tkw_ListAnalizer_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_ListAnalizer_Control_BackgroundPanel }
 Tkw_ListAnalizer_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ListAnalizer_Control_BackgroundPanel_Push }
 Tkw_ListAnalizer_Control_ListTree.RegisterInEngine;
 {* Регистрация Tkw_ListAnalizer_Control_ListTree }
 Tkw_ListAnalizer_Control_ListTree_Push.RegisterInEngine;
 {* Регистрация Tkw_ListAnalizer_Control_ListTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListAnalizerForm));
 {* Регистрация типа TListAnalizerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
