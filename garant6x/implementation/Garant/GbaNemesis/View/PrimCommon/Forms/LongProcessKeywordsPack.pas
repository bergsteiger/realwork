unit LongProcessKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы LongProcess }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcessKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "LongProcessKeywordsPack" MUID: (4A93DDCC03E3_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 , LongProcess_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtLabel
 , vtGradientWaitbar
 , ExtCtrls
 , vtButton
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A93DDCC03E3_Packimpl_uses*
 //#UC END# *4A93DDCC03E3_Packimpl_uses*
;

type
 TkwLongProcessFormClientPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.ClientPanel }
  private
   function ClientPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.ClientPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormClientPanel

 TkwLongProcessFormMessageLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.MessageLabel }
  private
   function MessageLabel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtLabel;
    {* Реализация слова скрипта .TLongProcessForm.MessageLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormMessageLabel

 TkwLongProcessFormBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.BottomPanel }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.BottomPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormBottomPanel

 TkwLongProcessFormProgressBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.ProgressBar }
  private
   function ProgressBar(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtGradientWaitbar;
    {* Реализация слова скрипта .TLongProcessForm.ProgressBar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormProgressBar

 TkwLongProcessFormLeftPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.LeftPanel }
  private
   function LeftPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.LeftPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormLeftPanel

 TkwLongProcessFormImage = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.Image }
  private
   function Image(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TImage;
    {* Реализация слова скрипта .TLongProcessForm.Image }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormImage

 TkwLongProcessFormButtonPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.ButtonPanel }
  private
   function ButtonPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.ButtonPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormButtonPanel

 TkwLongProcessFormBtnExit = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.btnExit }
  private
   function btnExit(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtButton;
    {* Реализация слова скрипта .TLongProcessForm.btnExit }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwLongProcessFormBtnExit

 Tkw_Form_LongProcess = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы LongProcess
----
*Пример использования*:
[code]форма::LongProcess TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_LongProcess

 Tkw_LongProcess_Control_ClientPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientPanel
----
*Пример использования*:
[code]контрол::ClientPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ClientPanel

 Tkw_LongProcess_Control_ClientPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientPanel
----
*Пример использования*:
[code]контрол::ClientPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ClientPanel_Push

 Tkw_LongProcess_Control_MessageLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MessageLabel
----
*Пример использования*:
[code]контрол::MessageLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_MessageLabel

 Tkw_LongProcess_Control_MessageLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MessageLabel
----
*Пример использования*:
[code]контрол::MessageLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_MessageLabel_Push

 Tkw_LongProcess_Control_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]контрол::BottomPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_BottomPanel

 Tkw_LongProcess_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]контрол::BottomPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_BottomPanel_Push

 Tkw_LongProcess_Control_ProgressBar = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ProgressBar
----
*Пример использования*:
[code]контрол::ProgressBar TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ProgressBar

 Tkw_LongProcess_Control_ProgressBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ProgressBar
----
*Пример использования*:
[code]контрол::ProgressBar:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ProgressBar_Push

 Tkw_LongProcess_Control_LeftPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftPanel
----
*Пример использования*:
[code]контрол::LeftPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_LeftPanel

 Tkw_LongProcess_Control_LeftPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftPanel
----
*Пример использования*:
[code]контрол::LeftPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_LeftPanel_Push

 Tkw_LongProcess_Control_Image = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Image
----
*Пример использования*:
[code]контрол::Image TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_Image

 Tkw_LongProcess_Control_Image_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Image
----
*Пример использования*:
[code]контрол::Image:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_Image_Push

 Tkw_LongProcess_Control_ButtonPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ButtonPanel
----
*Пример использования*:
[code]контрол::ButtonPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ButtonPanel

 Tkw_LongProcess_Control_ButtonPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ButtonPanel
----
*Пример использования*:
[code]контрол::ButtonPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ButtonPanel_Push

 Tkw_LongProcess_Control_btnExit = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnExit
----
*Пример использования*:
[code]контрол::btnExit TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_btnExit

 Tkw_LongProcess_Control_btnExit_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnExit
----
*Пример использования*:
[code]контрол::btnExit:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_btnExit_Push

function TkwLongProcessFormClientPanel.ClientPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.ClientPanel }
begin
 Result := aLongProcessForm.ClientPanel;
end;//TkwLongProcessFormClientPanel.ClientPanel

class function TkwLongProcessFormClientPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.ClientPanel';
end;//TkwLongProcessFormClientPanel.GetWordNameForRegister

function TkwLongProcessFormClientPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormClientPanel.GetResultTypeInfo

function TkwLongProcessFormClientPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormClientPanel.GetAllParamsCount

function TkwLongProcessFormClientPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormClientPanel.ParamsTypes

procedure TkwLongProcessFormClientPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientPanel', aCtx);
end;//TkwLongProcessFormClientPanel.SetValuePrim

procedure TkwLongProcessFormClientPanel.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ClientPanel(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormClientPanel.DoDoIt

function TkwLongProcessFormMessageLabel.MessageLabel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtLabel;
 {* Реализация слова скрипта .TLongProcessForm.MessageLabel }
begin
 Result := aLongProcessForm.MessageLabel;
end;//TkwLongProcessFormMessageLabel.MessageLabel

class function TkwLongProcessFormMessageLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.MessageLabel';
end;//TkwLongProcessFormMessageLabel.GetWordNameForRegister

function TkwLongProcessFormMessageLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLongProcessFormMessageLabel.GetResultTypeInfo

function TkwLongProcessFormMessageLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormMessageLabel.GetAllParamsCount

function TkwLongProcessFormMessageLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormMessageLabel.ParamsTypes

procedure TkwLongProcessFormMessageLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MessageLabel', aCtx);
end;//TkwLongProcessFormMessageLabel.SetValuePrim

procedure TkwLongProcessFormMessageLabel.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MessageLabel(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormMessageLabel.DoDoIt

function TkwLongProcessFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.BottomPanel }
begin
 Result := aLongProcessForm.BottomPanel;
end;//TkwLongProcessFormBottomPanel.BottomPanel

class function TkwLongProcessFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.BottomPanel';
end;//TkwLongProcessFormBottomPanel.GetWordNameForRegister

function TkwLongProcessFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormBottomPanel.GetResultTypeInfo

function TkwLongProcessFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormBottomPanel.GetAllParamsCount

function TkwLongProcessFormBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormBottomPanel.ParamsTypes

procedure TkwLongProcessFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwLongProcessFormBottomPanel.SetValuePrim

procedure TkwLongProcessFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormBottomPanel.DoDoIt

function TkwLongProcessFormProgressBar.ProgressBar(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtGradientWaitbar;
 {* Реализация слова скрипта .TLongProcessForm.ProgressBar }
begin
 Result := aLongProcessForm.ProgressBar;
end;//TkwLongProcessFormProgressBar.ProgressBar

class function TkwLongProcessFormProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.ProgressBar';
end;//TkwLongProcessFormProgressBar.GetWordNameForRegister

function TkwLongProcessFormProgressBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGradientWaitbar);
end;//TkwLongProcessFormProgressBar.GetResultTypeInfo

function TkwLongProcessFormProgressBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormProgressBar.GetAllParamsCount

function TkwLongProcessFormProgressBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormProgressBar.ParamsTypes

procedure TkwLongProcessFormProgressBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ProgressBar', aCtx);
end;//TkwLongProcessFormProgressBar.SetValuePrim

procedure TkwLongProcessFormProgressBar.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ProgressBar(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormProgressBar.DoDoIt

function TkwLongProcessFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.LeftPanel }
begin
 Result := aLongProcessForm.LeftPanel;
end;//TkwLongProcessFormLeftPanel.LeftPanel

class function TkwLongProcessFormLeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.LeftPanel';
end;//TkwLongProcessFormLeftPanel.GetWordNameForRegister

function TkwLongProcessFormLeftPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormLeftPanel.GetResultTypeInfo

function TkwLongProcessFormLeftPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormLeftPanel.GetAllParamsCount

function TkwLongProcessFormLeftPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormLeftPanel.ParamsTypes

procedure TkwLongProcessFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftPanel', aCtx);
end;//TkwLongProcessFormLeftPanel.SetValuePrim

procedure TkwLongProcessFormLeftPanel.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftPanel(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormLeftPanel.DoDoIt

function TkwLongProcessFormImage.Image(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TImage;
 {* Реализация слова скрипта .TLongProcessForm.Image }
begin
 Result := aLongProcessForm.Image;
end;//TkwLongProcessFormImage.Image

class function TkwLongProcessFormImage.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.Image';
end;//TkwLongProcessFormImage.GetWordNameForRegister

function TkwLongProcessFormImage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImage);
end;//TkwLongProcessFormImage.GetResultTypeInfo

function TkwLongProcessFormImage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormImage.GetAllParamsCount

function TkwLongProcessFormImage.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormImage.ParamsTypes

procedure TkwLongProcessFormImage.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Image', aCtx);
end;//TkwLongProcessFormImage.SetValuePrim

procedure TkwLongProcessFormImage.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Image(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormImage.DoDoIt

function TkwLongProcessFormButtonPanel.ButtonPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.ButtonPanel }
begin
 Result := aLongProcessForm.ButtonPanel;
end;//TkwLongProcessFormButtonPanel.ButtonPanel

class function TkwLongProcessFormButtonPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.ButtonPanel';
end;//TkwLongProcessFormButtonPanel.GetWordNameForRegister

function TkwLongProcessFormButtonPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormButtonPanel.GetResultTypeInfo

function TkwLongProcessFormButtonPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormButtonPanel.GetAllParamsCount

function TkwLongProcessFormButtonPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormButtonPanel.ParamsTypes

procedure TkwLongProcessFormButtonPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ButtonPanel', aCtx);
end;//TkwLongProcessFormButtonPanel.SetValuePrim

procedure TkwLongProcessFormButtonPanel.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ButtonPanel(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormButtonPanel.DoDoIt

function TkwLongProcessFormBtnExit.btnExit(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtButton;
 {* Реализация слова скрипта .TLongProcessForm.btnExit }
begin
 Result := aLongProcessForm.btnExit;
end;//TkwLongProcessFormBtnExit.btnExit

class function TkwLongProcessFormBtnExit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.btnExit';
end;//TkwLongProcessFormBtnExit.GetWordNameForRegister

function TkwLongProcessFormBtnExit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwLongProcessFormBtnExit.GetResultTypeInfo

function TkwLongProcessFormBtnExit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLongProcessFormBtnExit.GetAllParamsCount

function TkwLongProcessFormBtnExit.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormBtnExit.ParamsTypes

procedure TkwLongProcessFormBtnExit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnExit', aCtx);
end;//TkwLongProcessFormBtnExit.SetValuePrim

procedure TkwLongProcessFormBtnExit.DoDoIt(const aCtx: TtfwContext);
var l_aLongProcessForm: TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnExit(aCtx, l_aLongProcessForm));
end;//TkwLongProcessFormBtnExit.DoDoIt

function Tkw_Form_LongProcess.GetString: AnsiString;
begin
 Result := 'LongProcessForm';
end;//Tkw_Form_LongProcess.GetString

class procedure Tkw_Form_LongProcess.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TLongProcessForm);
end;//Tkw_Form_LongProcess.RegisterInEngine

class function Tkw_Form_LongProcess.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::LongProcess';
end;//Tkw_Form_LongProcess.GetWordNameForRegister

function Tkw_LongProcess_Control_ClientPanel.GetString: AnsiString;
begin
 Result := 'ClientPanel';
end;//Tkw_LongProcess_Control_ClientPanel.GetString

class procedure Tkw_LongProcess_Control_ClientPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_ClientPanel.RegisterInEngine

class function Tkw_LongProcess_Control_ClientPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientPanel';
end;//Tkw_LongProcess_Control_ClientPanel.GetWordNameForRegister

procedure Tkw_LongProcess_Control_ClientPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ClientPanel');
 inherited;
end;//Tkw_LongProcess_Control_ClientPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_ClientPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientPanel:push';
end;//Tkw_LongProcess_Control_ClientPanel_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_MessageLabel.GetString: AnsiString;
begin
 Result := 'MessageLabel';
end;//Tkw_LongProcess_Control_MessageLabel.GetString

class procedure Tkw_LongProcess_Control_MessageLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_LongProcess_Control_MessageLabel.RegisterInEngine

class function Tkw_LongProcess_Control_MessageLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MessageLabel';
end;//Tkw_LongProcess_Control_MessageLabel.GetWordNameForRegister

procedure Tkw_LongProcess_Control_MessageLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MessageLabel');
 inherited;
end;//Tkw_LongProcess_Control_MessageLabel_Push.DoDoIt

class function Tkw_LongProcess_Control_MessageLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MessageLabel:push';
end;//Tkw_LongProcess_Control_MessageLabel_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_LongProcess_Control_BottomPanel.GetString

class procedure Tkw_LongProcess_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_BottomPanel.RegisterInEngine

class function Tkw_LongProcess_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_LongProcess_Control_BottomPanel.GetWordNameForRegister

procedure Tkw_LongProcess_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_LongProcess_Control_BottomPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_LongProcess_Control_BottomPanel_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_ProgressBar.GetString: AnsiString;
begin
 Result := 'ProgressBar';
end;//Tkw_LongProcess_Control_ProgressBar.GetString

class procedure Tkw_LongProcess_Control_ProgressBar.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGradientWaitbar);
end;//Tkw_LongProcess_Control_ProgressBar.RegisterInEngine

class function Tkw_LongProcess_Control_ProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ProgressBar';
end;//Tkw_LongProcess_Control_ProgressBar.GetWordNameForRegister

procedure Tkw_LongProcess_Control_ProgressBar_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ProgressBar');
 inherited;
end;//Tkw_LongProcess_Control_ProgressBar_Push.DoDoIt

class function Tkw_LongProcess_Control_ProgressBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ProgressBar:push';
end;//Tkw_LongProcess_Control_ProgressBar_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_LeftPanel.GetString: AnsiString;
begin
 Result := 'LeftPanel';
end;//Tkw_LongProcess_Control_LeftPanel.GetString

class procedure Tkw_LongProcess_Control_LeftPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_LeftPanel.RegisterInEngine

class function Tkw_LongProcess_Control_LeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel';
end;//Tkw_LongProcess_Control_LeftPanel.GetWordNameForRegister

procedure Tkw_LongProcess_Control_LeftPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftPanel');
 inherited;
end;//Tkw_LongProcess_Control_LeftPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_LeftPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel:push';
end;//Tkw_LongProcess_Control_LeftPanel_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_Image.GetString: AnsiString;
begin
 Result := 'Image';
end;//Tkw_LongProcess_Control_Image.GetString

class procedure Tkw_LongProcess_Control_Image.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImage);
end;//Tkw_LongProcess_Control_Image.RegisterInEngine

class function Tkw_LongProcess_Control_Image.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image';
end;//Tkw_LongProcess_Control_Image.GetWordNameForRegister

procedure Tkw_LongProcess_Control_Image_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Image');
 inherited;
end;//Tkw_LongProcess_Control_Image_Push.DoDoIt

class function Tkw_LongProcess_Control_Image_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image:push';
end;//Tkw_LongProcess_Control_Image_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_ButtonPanel.GetString: AnsiString;
begin
 Result := 'ButtonPanel';
end;//Tkw_LongProcess_Control_ButtonPanel.GetString

class procedure Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine

class function Tkw_LongProcess_Control_ButtonPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ButtonPanel';
end;//Tkw_LongProcess_Control_ButtonPanel.GetWordNameForRegister

procedure Tkw_LongProcess_Control_ButtonPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ButtonPanel');
 inherited;
end;//Tkw_LongProcess_Control_ButtonPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_ButtonPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ButtonPanel:push';
end;//Tkw_LongProcess_Control_ButtonPanel_Push.GetWordNameForRegister

function Tkw_LongProcess_Control_btnExit.GetString: AnsiString;
begin
 Result := 'btnExit';
end;//Tkw_LongProcess_Control_btnExit.GetString

class procedure Tkw_LongProcess_Control_btnExit.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_LongProcess_Control_btnExit.RegisterInEngine

class function Tkw_LongProcess_Control_btnExit.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnExit';
end;//Tkw_LongProcess_Control_btnExit.GetWordNameForRegister

procedure Tkw_LongProcess_Control_btnExit_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnExit');
 inherited;
end;//Tkw_LongProcess_Control_btnExit_Push.DoDoIt

class function Tkw_LongProcess_Control_btnExit_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnExit:push';
end;//Tkw_LongProcess_Control_btnExit_Push.GetWordNameForRegister

initialization
 TkwLongProcessFormClientPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_ClientPanel }
 TkwLongProcessFormMessageLabel.RegisterInEngine;
 {* Регистрация LongProcessForm_MessageLabel }
 TkwLongProcessFormBottomPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_BottomPanel }
 TkwLongProcessFormProgressBar.RegisterInEngine;
 {* Регистрация LongProcessForm_ProgressBar }
 TkwLongProcessFormLeftPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_LeftPanel }
 TkwLongProcessFormImage.RegisterInEngine;
 {* Регистрация LongProcessForm_Image }
 TkwLongProcessFormButtonPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_ButtonPanel }
 TkwLongProcessFormBtnExit.RegisterInEngine;
 {* Регистрация LongProcessForm_btnExit }
 Tkw_Form_LongProcess.RegisterInEngine;
 {* Регистрация Tkw_Form_LongProcess }
 Tkw_LongProcess_Control_ClientPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ClientPanel }
 Tkw_LongProcess_Control_ClientPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ClientPanel_Push }
 Tkw_LongProcess_Control_MessageLabel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_MessageLabel }
 Tkw_LongProcess_Control_MessageLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_MessageLabel_Push }
 Tkw_LongProcess_Control_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_BottomPanel }
 Tkw_LongProcess_Control_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_BottomPanel_Push }
 Tkw_LongProcess_Control_ProgressBar.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ProgressBar }
 Tkw_LongProcess_Control_ProgressBar_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ProgressBar_Push }
 Tkw_LongProcess_Control_LeftPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_LeftPanel }
 Tkw_LongProcess_Control_LeftPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_LeftPanel_Push }
 Tkw_LongProcess_Control_Image.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_Image }
 Tkw_LongProcess_Control_Image_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_Image_Push }
 Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ButtonPanel }
 Tkw_LongProcess_Control_ButtonPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ButtonPanel_Push }
 Tkw_LongProcess_Control_btnExit.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_btnExit }
 Tkw_LongProcess_Control_btnExit_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_btnExit_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLongProcessForm));
 {* Регистрация типа TLongProcessForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGradientWaitbar));
 {* Регистрация типа TvtGradientWaitbar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImage));
 {* Регистрация типа TImage }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* Регистрация типа TvtButton }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
