unit PrimFolders_Form;
 {* Мои документы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFolders_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Folders_Result_Controls
 , Folders_Strange_Controls
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
 , nsTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3StringIDEx
;

type
 // ParentZone

 // ChildZone

 TPrimFoldersForm = class
  {* Мои документы }
  private
   f_IsInfoShown: Boolean;
   f_BackgroundPanel: TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel }
   f_ParentZone: TvtPanel;
    {* Поле для свойства ParentZone }
   f_ChildZone: TvtSizeablePanel;
    {* Поле для свойства ChildZone }
  protected
   procedure utFoldersQueryClose(aSender: TObject);
    {* Обработчик события utFolders.OnQueryClose }
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure SetParent(AParent: TWinControl); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure EditElement; override;
    {* Начать редактирование элемента }
   function DeleteElement: TnsDeleteResult; override;
    {* Удалить элемент }
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Append; override;
    {* Добавить }
   procedure Show; override;
   procedure Hide; override;
   procedure SetCaption; override;
   procedure BecomeActive; override;
   procedure Close; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
 end;//TPrimFoldersForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utFoldersLocalConstants }
 str_utFoldersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersCaption'; rValue : 'Мои документы');
  {* Заголовок пользовательского типа "Мои документы" }

procedure TPrimFoldersForm.utFoldersQueryClose(aSender: TObject);
 {* Обработчик события utFolders.OnQueryClose }
//#UC START# *1BA52F720139_4A96B6AE0071_var*
//#UC END# *1BA52F720139_4A96B6AE0071_var*
begin
//#UC START# *1BA52F720139_4A96B6AE0071_impl*
 SafeClose;
//#UC END# *1BA52F720139_4A96B6AE0071_impl*
end;//TPrimFoldersForm.utFoldersQueryClose

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.Cancel;
 {* Отмена }
//#UC START# *4A8AD46D0226_4A96B6AE0071_var*
//#UC END# *4A8AD46D0226_4A96B6AE0071_var*
begin
//#UC START# *4A8AD46D0226_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersForm.EditElement;
 {* Начать редактирование элемента }
//#UC START# *4A96A9BE011C_4A96B6AE0071_var*
//#UC END# *4A96A9BE011C_4A96B6AE0071_var*
begin
//#UC START# *4A96A9BE011C_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A96A9BE011C_4A96B6AE0071_impl*
end;//TPrimFoldersForm.EditElement

function TPrimFoldersForm.DeleteElement: TnsDeleteResult;
 {* Удалить элемент }
//#UC START# *4A96A9D10023_4A96B6AE0071_var*
//#UC END# *4A96A9D10023_4A96B6AE0071_var*
begin
//#UC START# *4A96A9D10023_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A96A9D10023_4A96B6AE0071_impl*
end;//TPrimFoldersForm.DeleteElement

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4A96B6AE0071_var*
//#UC END# *4A97EBE702F8_4A96B6AE0071_var*
begin
//#UC START# *4A97EBE702F8_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersForm.Append;
 {* Добавить }
//#UC START# *4A98000500BA_4A96B6AE0071_var*
//#UC END# *4A98000500BA_4A96B6AE0071_var*
begin
//#UC START# *4A98000500BA_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A98000500BA_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Append

procedure TPrimFoldersForm.Show;
//#UC START# *4A980672034B_4A96B6AE0071_var*
//#UC END# *4A980672034B_4A96B6AE0071_var*
begin
//#UC START# *4A980672034B_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A980672034B_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Show

procedure TPrimFoldersForm.Hide;
//#UC START# *4A9806B600E8_4A96B6AE0071_var*
//#UC END# *4A9806B600E8_4A96B6AE0071_var*
begin
//#UC START# *4A9806B600E8_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9806B600E8_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Hide

procedure TPrimFoldersForm.SetCaption;
//#UC START# *4A9806D7038D_4A96B6AE0071_var*
//#UC END# *4A9806D7038D_4A96B6AE0071_var*
begin
//#UC START# *4A9806D7038D_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9806D7038D_4A96B6AE0071_impl*
end;//TPrimFoldersForm.SetCaption

procedure TPrimFoldersForm.BecomeActive;
//#UC START# *4A9807F801F9_4A96B6AE0071_var*
//#UC END# *4A9807F801F9_4A96B6AE0071_var*
begin
//#UC START# *4A9807F801F9_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9807F801F9_4A96B6AE0071_impl*
end;//TPrimFoldersForm.BecomeActive

procedure TPrimFoldersForm.Close;
//#UC START# *4AE9BF890271_4A96B6AE0071_var*
//#UC END# *4AE9BF890271_4A96B6AE0071_var*
begin
//#UC START# *4AE9BF890271_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9BF890271_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Close

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4A96B6AE0071_var*
//#UC END# *4C762A1501FC_4A96B6AE0071_var*
begin
//#UC START# *4C762A1501FC_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4A96B6AE0071_var*
//#UC END# *4C762AB601E1_4A96B6AE0071_var*
begin
//#UC START# *4C762AB601E1_4A96B6AE0071_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4A96B6AE0071_impl*
end;//TPrimFoldersForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4A96B6AE0071_var*
//#UC END# *47EA4E9002C6_4A96B6AE0071_var*
begin
//#UC START# *47EA4E9002C6_4A96B6AE0071_impl*
 inherited;
 ModalResult := mrCancel; // http://mdp.garant.ru/pages/viewpage.action?pageId=316506551 
//#UC END# *47EA4E9002C6_4A96B6AE0071_impl*
end;//TPrimFoldersForm.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A96B6AE0071_var*
//#UC END# *49803F5503AA_4A96B6AE0071_var*
begin
//#UC START# *49803F5503AA_4A96B6AE0071_impl*
 inherited;
 ChildZone.Hide;
 f_IsInfoShown := False;
//#UC END# *49803F5503AA_4A96B6AE0071_impl*
end;//TPrimFoldersForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A96B6AE0071_var*
//#UC END# *4A8E8F2E0195_4A96B6AE0071_var*
begin
//#UC START# *4A8E8F2E0195_4A96B6AE0071_impl*
 Height := 531;
 ActiveControl := ParentZone;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ParentZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ChildZone do
 begin
  Height := 233;
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_4A96B6AE0071_impl*
end;//TPrimFoldersForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCL)}
procedure TPrimFoldersForm.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_4A96B6AE0071_var*
//#UC END# *4A97E78202FC_4A96B6AE0071_var*
begin
//#UC START# *4A97E78202FC_4A96B6AE0071_impl*
 inherited;
 // При отстыковки закладки по DblClick-у или из настроек, форма в childzone
 // могла занимать все пространство, т.к. Align = alBottom поделим место если
 // это так
 if Assigned(aParent) and (Parent.ClientHeight > 0) and
   (ChildZone.Height > Parent.ClientHeight) then
  ChildZone.Height := Parent.ClientHeight div 2;
//#UC END# *4A97E78202FC_4A96B6AE0071_impl*
end;//TPrimFoldersForm.SetParent
{$IfEnd} // NOT Defined(NoVCL)

initialization
 str_utFoldersCaption.Init;
 {* Инициализация str_utFoldersCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersForm);
 {* Регистрация PrimFolders }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
