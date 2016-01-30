unit PrimEULA_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimEULA_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , vtLabel
 , vtButton
 , eeMemoWithEditOperations
 , l3StringIDEx
;

type
 TPrimEULAForm = class(TvcmEntityForm)
  private
   f_ShellCaptionLabel: TvtLabel;
    {* Поле для свойства ShellCaptionLabel }
   f_OkButton: TvtButton;
    {* Поле для свойства OkButton }
   f_eeMemoWithEditOperations1: TeeMemoWithEditOperations;
    {* Поле для свойства eeMemoWithEditOperations1 }
  private
   procedure OkButtonClick(Sender: TObject);
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ShellCaptionLabel: TvtLabel
    read f_ShellCaptionLabel;
    {* Прочтите внимательно }
   property OkButton: TvtButton
    read f_OkButton;
    {* Ок }
   property eeMemoWithEditOperations1: TeeMemoWithEditOperations
    read f_eeMemoWithEditOperations1;
 end;//TPrimEULAForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки EULA Local Const }
 str_EULAText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EULAText'; rValue : 'Правомерное владение экземпляром версии Электронного периодического справочника ' +
'"Система ГАРАНТ" возможно только на основании и на условиях договора с лицами, ' +
'указанными на сайте www.garant.ru'#13#10#13#10'ВНИМАНИЕ! НЕСОБЛЮДЕНИЕ ' +
'УКАЗАННОГО ВЫШЕ УСЛОВИЯ ЯВЛЯЕТСЯ НАРУШЕНИЕМ ЗАКОНОДАТЕЛЬСТВА РОССИЙСКОЙ ' +
'ФЕДЕРАЦИИ И ПРЕСЛЕДУЕТСЯ ПО ЗАКОНУ.');
  {* 'Правомерное владение экземпляром версии Электронного периодического справочника ' +
'"Система ГАРАНТ" возможно только на основании и на условиях договора с лицами, ' +
'указанными на сайте www.garant.ru'#13#10#13#10'ВНИМАНИЕ! НЕСОБЛЮДЕНИЕ ' +
'УКАЗАННОГО ВЫШЕ УСЛОВИЯ ЯВЛЯЕТСЯ НАРУШЕНИЕМ ЗАКОНОДАТЕЛЬСТВА РОССИЙСКОЙ ' +
'ФЕДЕРАЦИИ И ПРЕСЛЕДУЕТСЯ ПО ЗАКОНУ.' }

procedure TPrimEULAForm.OkButtonClick(Sender: TObject);
//#UC START# *51BAD500014C_4A93FB6B018F_var*
//#UC END# *51BAD500014C_4A93FB6B018F_var*
begin
//#UC START# *51BAD500014C_4A93FB6B018F_impl*
 ModalResult := mrOk;
//#UC END# *51BAD500014C_4A93FB6B018F_impl*
end;//TPrimEULAForm.OkButtonClick

{$If NOT Defined(NoVCM)}
procedure TPrimEULAForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A93FB6B018F_var*
//#UC END# *49803F5503AA_4A93FB6B018F_var*
begin
//#UC START# *49803F5503AA_4A93FB6B018F_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *49803F5503AA_4A93FB6B018F_impl*
end;//TPrimEULAForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimEULAForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A93FB6B018F_var*
//#UC END# *4A8E8F2E0195_4A93FB6B018F_var*
begin
//#UC START# *4A8E8F2E0195_4A93FB6B018F_impl*
 inherited;
 BorderStyle := bsSingle;
 BorderIcons := [biSystemMenu];
 ClientHeight := 250;
 ClientWidth := 386;

 with ShellCaptionLabel do
 begin
  Left := 10;
  Top := 8;
  Caption := 'Прочтите внимательно';
  Transparent := True;
 end;

 with OkButton do
 begin
  Left := 161;
  Top := 216;
  Width := 75;
  Height := 25;
  Cancel := True;
  Caption := 'Ок';
  Default := True;
  OnClick := OkButtonClick;
 end;

 with eeMemoWithEditOperations1 do
 begin
  Left := 12;
  Top := 28;
  Width := 361;
  Height := 175;
  Text := str_EULAText.AsStr;
  TextSource.ReadOnly := True;
  BevelInner := bvLowered;
  BorderStyle := bsSingle;
  ParentColor := True;
  ReadOnly := True;
  TabStop := True;
 end;
//#UC END# *4A8E8F2E0195_4A93FB6B018F_impl*
end;//TPrimEULAForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_EULAText.Init;
 {* Инициализация str_EULAText }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimEULAForm);
 {* Регистрация PrimEULA }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
