unit MedicFirmListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MedicFirmList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicFirmListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MedicFirmListKeywordsPack" MUID: (4AB9E69C0243_Pack)

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
 , MedicFirmList_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AB9E69C0243_Packimpl_uses*
 //#UC END# *4AB9E69C0243_Packimpl_uses*
;

type
 TkwEnMedicFirmListBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicFirmList.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
    {* Реализация слова скрипта .Ten_MedicFirmList.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicFirmListBackgroundPanel

 TkwEnMedicFirmListContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicFirmList.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
    {* Реализация слова скрипта .Ten_MedicFirmList.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicFirmListContextFilter

 TkwEnMedicFirmListListTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicFirmList.ListTree }
  private
   function ListTree(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicFirmList.ListTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicFirmListListTree

 Tkw_Form_MedicFirmList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MedicFirmList
----
*Пример использования*:
[code]форма::MedicFirmList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MedicFirmList

 Tkw_MedicFirmList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_BackgroundPanel

 Tkw_MedicFirmList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push

 Tkw_MedicFirmList_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ContextFilter

 Tkw_MedicFirmList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ContextFilter_Push

 Tkw_MedicFirmList_Control_ListTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ListTree
----
*Пример использования*:
[code]контрол::ListTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ListTree

 Tkw_MedicFirmList_Control_ListTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ListTree
----
*Пример использования*:
[code]контрол::ListTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ListTree_Push

function TkwEnMedicFirmListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
 {* Реализация слова скрипта .Ten_MedicFirmList.BackgroundPanel }
begin
 Result := aen_MedicFirmList.BackgroundPanel;
end;//TkwEnMedicFirmListBackgroundPanel.BackgroundPanel

class function TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.BackgroundPanel';
end;//TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister

function TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo

function TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount

function TkwEnMedicFirmListBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListBackgroundPanel.ParamsTypes

procedure TkwEnMedicFirmListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnMedicFirmListBackgroundPanel.SetValuePrim

procedure TkwEnMedicFirmListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicFirmList: Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aen_MedicFirmList));
end;//TkwEnMedicFirmListBackgroundPanel.DoDoIt

function TkwEnMedicFirmListContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
 {* Реализация слова скрипта .Ten_MedicFirmList.ContextFilter }
begin
 Result := aen_MedicFirmList.ContextFilter;
end;//TkwEnMedicFirmListContextFilter.ContextFilter

class function TkwEnMedicFirmListContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.ContextFilter';
end;//TkwEnMedicFirmListContextFilter.GetWordNameForRegister

function TkwEnMedicFirmListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnMedicFirmListContextFilter.GetResultTypeInfo

function TkwEnMedicFirmListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListContextFilter.GetAllParamsCount

function TkwEnMedicFirmListContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListContextFilter.ParamsTypes

procedure TkwEnMedicFirmListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnMedicFirmListContextFilter.SetValuePrim

procedure TkwEnMedicFirmListContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicFirmList: Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aen_MedicFirmList));
end;//TkwEnMedicFirmListContextFilter.DoDoIt

function TkwEnMedicFirmListListTree.ListTree(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicFirmList.ListTree }
begin
 Result := aen_MedicFirmList.ListTree;
end;//TkwEnMedicFirmListListTree.ListTree

class function TkwEnMedicFirmListListTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.ListTree';
end;//TkwEnMedicFirmListListTree.GetWordNameForRegister

function TkwEnMedicFirmListListTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicFirmListListTree.GetResultTypeInfo

function TkwEnMedicFirmListListTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListListTree.GetAllParamsCount

function TkwEnMedicFirmListListTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListListTree.ParamsTypes

procedure TkwEnMedicFirmListListTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ListTree', aCtx);
end;//TkwEnMedicFirmListListTree.SetValuePrim

procedure TkwEnMedicFirmListListTree.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicFirmList: Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ListTree(aCtx, l_aen_MedicFirmList));
end;//TkwEnMedicFirmListListTree.DoDoIt

function Tkw_Form_MedicFirmList.GetString: AnsiString;
begin
 Result := 'en_MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetString

class procedure Tkw_Form_MedicFirmList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_MedicFirmList);
end;//Tkw_Form_MedicFirmList.RegisterInEngine

class function Tkw_Form_MedicFirmList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetWordNameForRegister

function Tkw_MedicFirmList_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetString

class procedure Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine

class function Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetString

class procedure Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine

class function Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ListTree.GetString: AnsiString;
begin
 Result := 'ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetString

class procedure Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicFirmList_Control_ListTree.RegisterInEngine

class function Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister

procedure Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ListTree');
 inherited;
end;//Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListTree:push';
end;//Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister

initialization
 TkwEnMedicFirmListBackgroundPanel.RegisterInEngine;
 {* Регистрация en_MedicFirmList_BackgroundPanel }
 TkwEnMedicFirmListContextFilter.RegisterInEngine;
 {* Регистрация en_MedicFirmList_ContextFilter }
 TkwEnMedicFirmListListTree.RegisterInEngine;
 {* Регистрация en_MedicFirmList_ListTree }
 Tkw_Form_MedicFirmList.RegisterInEngine;
 {* Регистрация Tkw_Form_MedicFirmList }
 Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_BackgroundPanel }
 Tkw_MedicFirmList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_BackgroundPanel_Push }
 Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ContextFilter }
 Tkw_MedicFirmList_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ContextFilter_Push }
 Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ListTree }
 Tkw_MedicFirmList_Control_ListTree_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ListTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicFirmList));
 {* Регистрация типа Ten_MedicFirmList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
