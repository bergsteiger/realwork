unit PrimPostingsList_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , PostingOrder_Strange_Controls
 , eeTreeView
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_PrimeFilter: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimeFilter'; rValue : 'Ленты новостей|*.xml');
  {* 'Ленты новостей|*.xml' }
 str_ExportPrimeTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ExportPrimeTitle'; rValue : 'Экспорт выделенных лент');
  {* 'Экспорт выделенных лент' }

type
 TPrimPostingsListForm = class(TvcmEntityForm)
  private
   f_OnUpdate: Boolean;
   f_tvPostings: TeeTreeView;
    {* Поле для свойства tvPostings }
  private
   function Save: Boolean;
    {* Функция проверяет необходимость сохранения запроса программы.
Возвращает False, если пользователь нажал "Нет" в предложении сохранить запрос. }
   function tvPostingsGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure tvPostingsActionElement(Sender: TObject;
    Index: LongInt);
   procedure OnAddNode(aIndex: Integer);
   procedure OnDeleteNode(aIndex: Integer);
   procedure OnCaptionChange(aIndex: Integer;
    const aNewCaption: Il3CString);
  protected
   function pm_GetIsNeedSave: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ptNewTheme; override;
   procedure ptEditPosting; override;
   procedure ptDeletePosting; override;
   procedure SavePostList; override;
   procedure ExportSelected; override;
  private
   property IsNeedSave: Boolean
    read pm_GetIsNeedSave;
    {* определяет нужно ли сохранять текущие результаты работы при смене тематики или закрытии приложения. }
  public
   property tvPostings: TeeTreeView
    read f_tvPostings;
 end;//TPrimPostingsListForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , vtSaveDialog
 , PrimeDomainInterfaces
 , SearchUnit
 , SysUtils
 , eeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , PrimeUnit
 , evdTextStyle_Const
 , l3ControlsTypes
 , nsPostingsTreeSingle
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , SearchRes
 , OldTreeInterfaces
 , nsQueryInterfaces
 , l3TreeInterfaces
 , DataAdapter
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки MyPostingListLocalConstants }
 str_MyPostingListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MyPostingListCaption'; rValue : 'ПРАЙМ. Моя новостная лента');
  {* Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" }

function TPrimPostingsListForm.pm_GetIsNeedSave: Boolean;
//#UC START# *52826BBE03A6_4AAFA13C01B0get_var*
//#UC END# *52826BBE03A6_4AAFA13C01B0get_var*
begin
//#UC START# *52826BBE03A6_4AAFA13C01B0get_impl*
 with TnsPostingsTreeSingle.Instance do
  Result := not f_OnUpdate and (MgrSearch <> nil) and MgrSearch.Modified and Ask(qr_SavePosting);
//#UC END# *52826BBE03A6_4AAFA13C01B0get_impl*
end;//TPrimPostingsListForm.pm_GetIsNeedSave

function TPrimPostingsListForm.Save: Boolean;
 {* Функция проверяет необходимость сохранения запроса программы.
Возвращает False, если пользователь нажал "Нет" в предложении сохранить запрос. }
//#UC START# *4C84F272012A_4AAFA13C01B0_var*
//#UC END# *4C84F272012A_4AAFA13C01B0_var*
begin
//#UC START# *4C84F272012A_4AAFA13C01B0_impl*
 TdmStdRes.CheckHistory;
 Result := True;
 if IsNeedSave then
  Result := TnsPostingsTreeSingle.Instance.SaveOrCreateQuery;
//#UC END# *4C84F272012A_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.Save

function TPrimPostingsListForm.tvPostingsGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *528262650131_4AAFA13C01B0_var*
//#UC END# *528262650131_4AAFA13C01B0_var*
begin
//#UC START# *528262650131_4AAFA13C01B0_impl*
 aImages := nsSearchRes.SearchItemsImageList; 
 Result := siilNewsLineThemeForCreate;
//#UC END# *528262650131_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.tvPostingsGetItemImage

procedure TPrimPostingsListForm.tvPostingsActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *5282636A000F_4AAFA13C01B0_var*
//#UC END# *5282636A000F_4AAFA13C01B0_var*
begin
//#UC START# *5282636A000F_4AAFA13C01B0_impl*
 PostingToolBar_ptEditPosting_Execute(vcmParams);
//#UC END# *5282636A000F_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.tvPostingsActionElement

procedure TPrimPostingsListForm.OnAddNode(aIndex: Integer);
//#UC START# *5282655D0103_4AAFA13C01B0_var*
//#UC END# *5282655D0103_4AAFA13C01B0_var*
begin
//#UC START# *5282655D0103_4AAFA13C01B0_impl*
 tvPostings.Current := aIndex;
 TnsPostingsTreeSingle.Instance.EditNodeIndex := aIndex;
//#UC END# *5282655D0103_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.OnAddNode

procedure TPrimPostingsListForm.OnDeleteNode(aIndex: Integer);
//#UC START# *528265720097_4AAFA13C01B0_var*
//#UC END# *528265720097_4AAFA13C01B0_var*
begin
//#UC START# *528265720097_4AAFA13C01B0_impl*
 {$IfNDef Monitorings}
 defDataAdapter.PrimeManager.SaveAndSendToOnlineServer;
 // Потому что иначе "Серверу никто не говорит что в лентах что-то поменялось"
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=570532654
 {$EndIf Monitorings}
 // Если из списка рассылок удаляется текущая редактируемая рассылка, то очищаем
 // карточку:
 if (TnsPostingsTreeSingle.Instance.EditNodeIndex = aIndex) then
  TdmStdRes.OpenPostingOrder(nil);
//#UC END# *528265720097_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.OnDeleteNode

procedure TPrimPostingsListForm.OnCaptionChange(aIndex: Integer;
 const aNewCaption: Il3CString);
//#UC START# *52826586022D_4AAFA13C01B0_var*
var
 l_Node: InsWrapperNode;
//#UC END# *52826586022D_4AAFA13C01B0_var*
begin
//#UC START# *52826586022D_4AAFA13C01B0_impl*
 if Supports(tvPostings.GetNode(aIndex), InsWrapperNode, l_Node) then
 try
  tvPostings.Changing;
  l_Node.Name := aNewCaption.AsWStr;
  tvPostings.Changed;
 finally
  l_Node := nil;
 end//try..finally
 else
  Assert(False);
//#UC END# *52826586022D_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.OnCaptionChange

procedure TPrimPostingsListForm.ptNewTheme;
//#UC START# *4C84EE020054_4AAFA13C01B0_var*
//#UC END# *4C84EE020054_4AAFA13C01B0_var*
begin
//#UC START# *4C84EE020054_4AAFA13C01B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84EE020054_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.ptNewTheme

procedure TPrimPostingsListForm.ptEditPosting;
//#UC START# *4C84EE1D0024_4AAFA13C01B0_var*
//#UC END# *4C84EE1D0024_4AAFA13C01B0_var*
begin
//#UC START# *4C84EE1D0024_4AAFA13C01B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84EE1D0024_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.ptEditPosting

procedure TPrimPostingsListForm.ptDeletePosting;
//#UC START# *4C84EE3801EB_4AAFA13C01B0_var*
//#UC END# *4C84EE3801EB_4AAFA13C01B0_var*
begin
//#UC START# *4C84EE3801EB_4AAFA13C01B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84EE3801EB_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.ptDeletePosting

procedure TPrimPostingsListForm.SavePostList;
//#UC START# *4C84EE590206_4AAFA13C01B0_var*
//#UC END# *4C84EE590206_4AAFA13C01B0_var*
begin
//#UC START# *4C84EE590206_4AAFA13C01B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84EE590206_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.SavePostList

procedure TPrimPostingsListForm.ExportSelected;
//#UC START# *4C84EE750308_4AAFA13C01B0_var*
//#UC END# *4C84EE750308_4AAFA13C01B0_var*
begin
//#UC START# *4C84EE750308_4AAFA13C01B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84EE750308_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.ExportSelected

procedure TPrimPostingsListForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AAFA13C01B0_var*
//#UC END# *479731C50290_4AAFA13C01B0_var*
begin
//#UC START# *479731C50290_4AAFA13C01B0_impl*
 //defDataAdapter.PrimeManager.Update;
 inherited;
//#UC END# *479731C50290_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.Cleanup

procedure TPrimPostingsListForm.InitFields;
//#UC START# *47A042E100E2_4AAFA13C01B0_var*
//#UC END# *47A042E100E2_4AAFA13C01B0_var*
begin
//#UC START# *47A042E100E2_4AAFA13C01B0_impl*
 inherited;
 
 TnsPostingsTreeSingle.Instance.OnAddNode := OnAddNode;
 TnsPostingsTreeSingle.Instance.OnDelNode := OnDeleteNode;
 TnsPostingsTreeSingle.Instance.OnEditNode := OnCaptionChange;

 Font.Height := -10;
//#UC END# *47A042E100E2_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.InitFields

procedure TPrimPostingsListForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AAFA13C01B0_var*
 function IsQueryNew: Boolean;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294589844
 var
  l_Mgr : IqaMgrSearch;
  l_IsQueryNew : Boolean;
 begin//IsQueryNew
  l_Mgr := TnsPostingsTreeSingle.Instance.MgrSearch;
  try
   if (l_Mgr = nil) then
    l_IsQueryNew := true
   else
    l_IsQueryNew := TnsPostingsTreeSingle.Instance.MgrSearch.IsQueryNew;
  finally
   l_Mgr := nil;
  end;//try..finally
  Result := l_IsQueryNew;
 end;//IsQueryNew
//#UC END# *47EA4E9002C6_4AAFA13C01B0_var*
begin
//#UC START# *47EA4E9002C6_4AAFA13C01B0_impl*
 inherited;
 f_OnUpdate := True;
 try
  if IsQueryNew then
   PostingToolBar_ptNewTheme_Execute(vcmParams)
  else
   PostingToolBar_ptEditPosting_Execute(vcmParams);
 finally
  f_OnUpdate := False;
 end;//try..finally
//#UC END# *47EA4E9002C6_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TPrimPostingsListForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AAFA13C01B0_var*
var
 l_Root: Il3SimpleRootNode;
//#UC END# *49803F5503AA_4AAFA13C01B0_var*
begin
//#UC START# *49803F5503AA_4AAFA13C01B0_impl*
 if Supports(TnsPostingsTreeSingle.Instance.Root, Il3SimpleRootNode, l_Root) then
  tvPostings.TreeStruct.RootNode := l_Root
 else
  Assert(False);
//#UC END# *49803F5503AA_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimPostingsListForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_4AAFA13C01B0_var*
//#UC END# *4980407F0076_4AAFA13C01B0_var*
begin
//#UC START# *4980407F0076_4AAFA13C01B0_impl*
 Result := True;
 {$if defined(Monitorings)}
 //После выключения сервера сохранять, собственно, нечего.
 if TnsPostingsTreeSingle.Instance.ServerDown then
  Exit;

 TnsPostingsTreeSingle.Instance.SaveXMLForServer;
 {$ifend}
//#UC END# *4980407F0076_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.CallCloseQuery
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPostingsListForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AAFA13C01B0_var*
//#UC END# *4A8E8F2E0195_4AAFA13C01B0_var*
begin
//#UC START# *4A8E8F2E0195_4AAFA13C01B0_impl*
 inherited;
 with tvPostings do
 begin
  Align := alClient;
  ShowHeader := False;
  PickedList := False;
  MultiSelect := True;
  MultiStrokeItem := True;
  ActionElementMode := l3_amSecondSingleClick;
  AllowWithoutCurrent := False;
  OnGetItemImage := tvPostingsGetItemImage;
  OnActionElement := tvPostingsActionElement;
  FooterVisible := False;
  BorderStyle := bsNone;

  StyleId := evd_saInterface;
  FooterStyleID := evd_saHyperLink;
  FooterActiveStyleID := evd_saActiveHyperLink;
 end;
//#UC END# *4A8E8F2E0195_4AAFA13C01B0_impl*
end;//TPrimPostingsListForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_MyPostingListCaption.Init;
 {* Инициализация str_MyPostingListCaption }
 str_PrimeFilter.Init;
 {* Инициализация str_PrimeFilter }
 str_ExportPrimeTitle.Init;
 {* Инициализация str_ExportPrimeTitle }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPostingsListForm);
 {* Регистрация PrimPostingsList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
