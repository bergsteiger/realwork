{$IfNDef StatusBarItems_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas"
// Стереотип: "VCMForm"

{$Define StatusBarItems_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _StatusBarItems_ = {abstract} class(_StatusBarItems_Parent_{$If Defined(Nemesis)}
 , InscStatusBarItemsProvider
 {$IfEnd} // Defined(Nemesis)
 )
  {* Базовая форма, публикующая свои операции в статусной строке }
  private
   f_StatusBarItems: InscStatusBarItemDefsList;
   f_StatusBarPublished: Boolean;
  private
   procedure RegisterOps;
    {* Реристрирует операции }
   procedure UnregisterOps;
    {* Отрегистрирует операции }
  protected
   function NeedsStatusBarItems: Boolean; virtual;
    {* Определяет, что операции в статусной строке таки надо публиковать }
   procedure FillList(const aList: InscStatusBarItemDefsList); virtual; abstract;
    {* Заполняет список операций. Для перекрытия в потомках }
   {$If Defined(Nemesis)}
   function Get_Items: InscStatusBarItemDefsList;
   {$IfEnd} // Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_StatusBarItems_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_StatusBarItems_ = _StatusBarItems_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else StatusBarItems_imp}

{$IfNDef StatusBarItems_imp_impl}

{$Define StatusBarItems_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _StatusBarItems_.RegisterOps;
 {* Реристрирует операции }
var l_Form: IafwMainForm;
var l_Visualizer: InscStatusBarItemsVisualizer;
//#UC START# *4A8E5C6702D1_4A8E5BBF0391_var*
//#UC END# *4A8E5C6702D1_4A8E5BBF0391_var*
begin
//#UC START# *4A8E5C6702D1_4A8E5BBF0391_impl*
 if not f_StatusBarPublished then
 begin
  f_StatusBarPublished := true;
  if Supports(NativeMainForm, IafwMainForm, l_Form) then
  begin
   if Assigned(l_Form) and Supports(l_Form.StatusBar,
    InscStatusBarItemsVisualizer, l_Visualizer) then
   begin
    f_StatusBarItems := TnscStatusBarOperationDefsList.MakeI;
    FillList(f_StatusBarItems);
    if (f_StatusBarItems.Count <= 0) then
     f_StatusBarItems := nil
    else
     l_Visualizer.RegisterProvider(Self);
   end;//Assigned(l_Form)..
  end;//Supports(NativeMainForm, IafwMainForm, l_Form)
 end;//not f_StatusBarPublished
//#UC END# *4A8E5C6702D1_4A8E5BBF0391_impl*
end;//_StatusBarItems_.RegisterOps

procedure _StatusBarItems_.UnregisterOps;
 {* Отрегистрирует операции }
var l_Form: IafwMainForm;
var l_Visualizer: InscStatusBarItemsVisualizer;
//#UC START# *4A8E5C7903DE_4A8E5BBF0391_var*
//#UC END# *4A8E5C7903DE_4A8E5BBF0391_var*
begin
//#UC START# *4A8E5C7903DE_4A8E5BBF0391_impl*
 if f_StatusBarPublished then
 begin
  f_StatusBarPublished := false;
  if (f_StatusBarItems = nil) then
   Exit;
  f_StatusBarItems := nil;
  if Supports(NativeMainForm, IafwMainForm, l_Form) and
   (l_Form <> nil) and
   Supports(l_Form.StatusBar,
            InscStatusBarItemsVisualizer,
            l_Visualizer) then
    l_Visualizer.UnregisterProvider(Self);
 end;//f_StatusBarPublished
//#UC END# *4A8E5C7903DE_4A8E5BBF0391_impl*
end;//_StatusBarItems_.UnregisterOps

function _StatusBarItems_.NeedsStatusBarItems: Boolean;
 {* Определяет, что операции в статусной строке таки надо публиковать }
//#UC START# *4A8E5CEC021F_4A8E5BBF0391_var*
//#UC END# *4A8E5CEC021F_4A8E5BBF0391_var*
begin
//#UC START# *4A8E5CEC021F_4A8E5BBF0391_impl*
 Result := true;
//#UC END# *4A8E5CEC021F_4A8E5BBF0391_impl*
end;//_StatusBarItems_.NeedsStatusBarItems

{$If Defined(Nemesis)}
function _StatusBarItems_.Get_Items: InscStatusBarItemDefsList;
//#UC START# *498036B8002E_4A8E5BBF0391get_var*
//#UC END# *498036B8002E_4A8E5BBF0391get_var*
begin
//#UC START# *498036B8002E_4A8E5BBF0391get_impl*
 Result := f_StatusBarItems;
//#UC END# *498036B8002E_4A8E5BBF0391get_impl*
end;//_StatusBarItems_.Get_Items
{$IfEnd} // Defined(Nemesis)

procedure _StatusBarItems_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A8E5BBF0391_var*
//#UC END# *479731C50290_4A8E5BBF0391_var*
begin
//#UC START# *479731C50290_4A8E5BBF0391_impl*
 inherited; // inherited в начале!
 // Защита от прохода мимо CloseQuery (http://mdp.garant.ru/pages/viewpage.action?pageId=136258182) :
 ReleaseResources;
//#UC END# *479731C50290_4A8E5BBF0391_impl*
end;//_StatusBarItems_.Cleanup

{$If NOT Defined(NoVCM)}
procedure _StatusBarItems_.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4A8E5BBF0391_var*
//#UC END# *497469C90140_4A8E5BBF0391_var*
begin
//#UC START# *497469C90140_4A8E5BBF0391_impl*
 inherited;
 if NeedsStatusBarItems then
 begin
  UnRegisterOps;
  if Assigned(aNew) then
   RegisterOps;
 end;//NeedsStatusBarItems
//#UC END# *497469C90140_4A8E5BBF0391_impl*
end;//_StatusBarItems_.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _StatusBarItems_.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A8E5BBF0391_var*
//#UC END# *49803F5503AA_4A8E5BBF0391_var*
begin
//#UC START# *49803F5503AA_4A8E5BBF0391_impl*
 inherited;
 if NeedsStatusBarItems then
  RegisterOps;
//#UC END# *49803F5503AA_4A8E5BBF0391_impl*
end;//_StatusBarItems_.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _StatusBarItems_.ReleaseResources;
//#UC START# *538C374A00B7_4A8E5BBF0391_var*
//#UC END# *538C374A00B7_4A8E5BBF0391_var*
begin
//#UC START# *538C374A00B7_4A8E5BBF0391_impl*
 if NeedsStatusBarItems then
  UnregisterOps;
 f_StatusBarItems := nil;
//#UC END# *538C374A00B7_4A8E5BBF0391_impl*
end;//_StatusBarItems_.ReleaseResources
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf StatusBarItems_imp_impl}

{$EndIf StatusBarItems_imp}

