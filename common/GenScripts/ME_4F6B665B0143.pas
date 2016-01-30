unit PrimParent_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_Form.pas"
// Стереотип: "VCMContainer"

{$Include f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

type
 // ParentZone

 TPrimParentForm = class(TvcmContainerForm)
  private
   f_ParentZone: TvtPanel;
    {* Поле для свойства ParentZone }
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
   procedure FocusIsSetToUs; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure AfterInsertForm(const aForm: IvcmEntityForm); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetNeedSetFocusToMainObjectFormOnRefresh: Boolean; override;
    {* Надо ли передвигать фокус в главную форму при изменении сборки }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ParentZone: TvtPanel
    read f_ParentZone;
 end;//TPrimParentForm

implementation

uses
 l3ImplUses
 , Windows
 , Graphics
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utHistoryLocalConstants }
 str_utHistoryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utHistoryCaption'; rValue : 'История навигации');
  {* Заголовок пользовательского типа "История навигации" }

{$If NOT Defined(NoVCM)}
procedure TPrimParentForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4F6B665B0143_var*
//#UC END# *49803F5503AA_4F6B665B0143_var*
begin
//#UC START# *49803F5503AA_4F6B665B0143_impl*
 inherited;
//#UC END# *49803F5503AA_4F6B665B0143_impl*
end;//TPrimParentForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimParentForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4F6B665B0143_var*
//#UC END# *4A8E8F2E0195_4F6B665B0143_var*
begin
//#UC START# *4A8E8F2E0195_4F6B665B0143_impl*
 inherited;
 ActiveControl := ParentZone;
 with ParentZone do
 begin
   Left := 0;
   Top := 0;
   Width := 483;
   Height := 253;
   Align := alClient;
   BevelOuter := bvNone;
   Color := clWhite;
   TabOrder := 0;
 end;//with ParentZone
//#UC END# *4A8E8F2E0195_4F6B665B0143_impl*
end;//TPrimParentForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimParentForm.FocusIsSetToUs;
//#UC START# *4F7C6D6801F4_4F6B665B0143_var*
//#UC END# *4F7C6D6801F4_4F6B665B0143_var*
begin
//#UC START# *4F7C6D6801F4_4F6B665B0143_impl*
 inherited;
//#UC END# *4F7C6D6801F4_4F6B665B0143_impl*
end;//TPrimParentForm.FocusIsSetToUs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimParentForm.AfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F7C6DFE00DE_4F6B665B0143_var*
//#UC END# *4F7C6DFE00DE_4F6B665B0143_var*
begin
//#UC START# *4F7C6DFE00DE_4F6B665B0143_impl*
 inherited;
//#UC END# *4F7C6DFE00DE_4F6B665B0143_impl*
end;//TPrimParentForm.AfterInsertForm
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimParentForm.GetNeedSetFocusToMainObjectFormOnRefresh: Boolean;
 {* Надо ли передвигать фокус в главную форму при изменении сборки }
//#UC START# *541011910033_4F6B665B0143_var*
//#UC END# *541011910033_4F6B665B0143_var*
begin
//#UC START# *541011910033_4F6B665B0143_impl*
 Result := True;
//#UC END# *541011910033_4F6B665B0143_impl*
end;//TPrimParentForm.GetNeedSetFocusToMainObjectFormOnRefresh
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utHistoryCaption.Init;
 {* Инициализация str_utHistoryCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimParentForm);
 {* Регистрация PrimParent }
{$IfEnd} // NOT Defined(NoScripts)

end.
