unit PrimWorkJournal_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , WorkJournal_Strange_Controls
 , nscTreeViewWithAdapterDragDrop
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3StringIDEx
;

type
 TPrimWorkJournalForm = class(TvcmEntityForm)
  private
   f_JournalTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства JournalTree }
  private
   procedure JournalTreeMakeTreeSource(out theTree: Il3SimpleTree);
   function JournalTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure JournalTreeActionElement(Sender: TObject;
    Index: LongInt);
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* Тут можно настроить внешний вид формы }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure OpenQuery; override;
   procedure ExecuteQuery; override;
   procedure Clear; override;
   {$If NOT Defined(NoVCM)}
   procedure SetActiveControl; override;
    {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property JournalTree: TnscTreeViewWithAdapterDragDrop
    read f_JournalTree;
 end;//TPrimWorkJournalForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , FoldersRes
 , DynamicTreeUnit
 , SysUtils
 , UserJournalUnit
 , eeInterfaces
 , BaseTypesUnit
 , nsOpenUtils
 , nsQueryUtils
 , SearchUnit
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , evdTextStyle_Const
 , l3Interfaces
 , nsConst
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utWorkJournalLocalConstants }
 str_utWorkJournalCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utWorkJournalCaption'; rValue : 'Журнал работы');
  {* Заголовок пользовательского типа "Журнал работы" }

procedure TPrimWorkJournalForm.JournalTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *527D09DB0041_4BD6D6EA0075_var*
//#UC END# *527D09DB0041_4BD6D6EA0075_var*
begin
//#UC START# *527D09DB0041_4BD6D6EA0075_impl*
 theTree := TdmStdRes.MakeWorkJournal.MakeTree;
//#UC END# *527D09DB0041_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.JournalTreeMakeTreeSource

function TPrimWorkJournalForm.JournalTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *527D09E502F1_4BD6D6EA0075_var*
var
 l_eeNode: IeeNode;
 l_AdapterNode: INodeBase;
//#UC END# *527D09E502F1_4BD6D6EA0075_var*
begin
//#UC START# *527D09E502F1_4BD6D6EA0075_impl*
 if Index >= 0 then
 begin
  l_eeNode := JournalTree.TreeView.GetNode(Index);
  try
   if Supports(l_eeNode, INodeBase, l_AdapterNode) then
   begin
    case TJournalObjectType(l_AdapterNode.GetType) of
     JOT_BOOKMARK: Result := BookmarkIcon;
     JOT_QUERY: Result := QueryIcon;
     JOT_FOLDER: Result := FolderIcon;
     else
      Result := 0;
    end;//case TJournalObjectType(l_AdapterNode.GetType) of
   end//if Supports(l_eeNode, INodeBase, l_AdapterNode) then
   else
    Result := FolderIcon;
  finally
   l_eeNode := nil;
  end;{try..finally}
 end//if Index >= 0 then
 else
  Result := 0;
//#UC END# *527D09E502F1_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.JournalTreeGetItemImage

procedure TPrimWorkJournalForm.JournalTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *527D09F100BA_4BD6D6EA0075_var*
var
 //l_Params: IvcmExecuteParams;
 l_ItemType: TJournalObjectType;
 l_AdapterNode: INodeBase;
 l_eeNode: Il3SimpleNode;
//#UC END# *527D09F100BA_4BD6D6EA0075_var*
begin
//#UC START# *527D09F100BA_4BD6D6EA0075_impl*
 if (Container.AsForm.ZoneType <> vcm_ztManualModal) then
 begin
  l_eeNode := JournalTree.GetNode(Index);
  try
   if Supports(l_eeNode, INodeBase, l_AdapterNode) then
   try
    l_ItemType := TJournalObjectType(l_AdapterNode.GetType);
    if l_ItemType <> JOT_FOLDER then
     OpenJournalElement(self.as_IvcmEntityForm, l_eeNode, vcm_okInCurrentTab)
    else
    if l_eeNode.HasChild then
     JournalTree.TreeStruct.ChangeExpand(l_eeNode, sbInvert);
   finally
    l_AdapterNode := nil;
   end;
  finally
   l_eeNode := nil;
  end;//try..finally
 end//(Container.AsForm.ZoneType <> vcm_ztManualModal
//#UC END# *527D09F100BA_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.JournalTreeActionElement

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_4BD6D6EA0075_var*
//#UC END# *494F89C30197_4BD6D6EA0075_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4BD6D6EA0075_var*
//#UC END# *4BDAF7880236_4BD6D6EA0075_var*
begin
//#UC START# *4BDAF7880236_4BD6D6EA0075_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4BD6D6EA0075_var*
//#UC END# *4BDAF7A2005C_4BD6D6EA0075_var*
begin
//#UC START# *4BDAF7A2005C_4BD6D6EA0075_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimWorkJournalForm.OpenQuery;
//#UC START# *4C3F3421036A_4BD6D6EA0075_var*
//#UC END# *4C3F3421036A_4BD6D6EA0075_var*
begin
//#UC START# *4C3F3421036A_4BD6D6EA0075_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F3421036A_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.OpenQuery

procedure TPrimWorkJournalForm.ExecuteQuery;
//#UC START# *4C3F342E02AF_4BD6D6EA0075_var*
//#UC END# *4C3F342E02AF_4BD6D6EA0075_var*
begin
//#UC START# *4C3F342E02AF_4BD6D6EA0075_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F342E02AF_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.ExecuteQuery

procedure TPrimWorkJournalForm.Clear;
//#UC START# *4C3F348402AC_4BD6D6EA0075_var*
//#UC END# *4C3F348402AC_4BD6D6EA0075_var*
begin
//#UC START# *4C3F348402AC_4BD6D6EA0075_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3F348402AC_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.Clear

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4BD6D6EA0075_var*
//#UC END# *49803F5503AA_4BD6D6EA0075_var*
begin
//#UC START# *49803F5503AA_4BD6D6EA0075_impl*
 inherited;
 JournalTree.Images := nsFoldersRes.FoldersItemImages;
//#UC END# *49803F5503AA_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4BD6D6EA0075_var*
//#UC END# *4A8E8F2E0195_4BD6D6EA0075_var*
begin
//#UC START# *4A8E8F2E0195_4BD6D6EA0075_impl*
 inherited;
 ActiveControl := JournalTree;
 with JournalTree do
 begin
  BorderStyle := bsNone;
  Align := alClient;
  ShowHeader := False;
  PickedList := False;
  MultiSelect := False;
  MultiStrokeItem := False;
  ActionElementMode := l3_amSecondSingleClick;
  AllowWithoutCurrent := False;
  OnMakeTreeSource := JournalTreeMakeTreeSource;
  OnGetItemImage := JournalTreeGetItemImage;
  OnActionElement := JournalTreeActionElement;
  DragAndDropSupported := True;
  FooterVisible := False;

  StyleId := evd_saInterface;
  FooterStyleID := evd_saHyperLink;
  FooterActiveStyleID := evd_saActiveHyperLink;
  SettingId := 'stidJournalTree';
 end;
//#UC END# *4A8E8F2E0195_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.SetActiveControl;
 {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
//#UC START# *4AC3803A03CD_4BD6D6EA0075_var*
//#UC END# *4AC3803A03CD_4BD6D6EA0075_var*
begin
//#UC START# *4AC3803A03CD_4BD6D6EA0075_impl*
 Windows.SetFocus(JournalTree.Handle);
//#UC END# *4AC3803A03CD_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetActiveControl
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.SetupFormLayout;
 {* Тут можно настроить внешний вид формы }
//#UC START# *529332B40230_4BD6D6EA0075_var*
//#UC END# *529332B40230_4BD6D6EA0075_var*
begin
//#UC START# *529332B40230_4BD6D6EA0075_impl*
 inherited;
 Width := 286;
 Height := 478;
//#UC END# *529332B40230_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetupFormLayout
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utWorkJournalCaption.Init;
 {* Инициализация str_utWorkJournalCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWorkJournalForm);
 {* Регистрация PrimWorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
