unit vtComboBoxQS;

// Модуль: "w:\common\components\gui\Garant\VT\vtComboBoxQS.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , vtComboTree
 , Classes
;

type
 TCustomComboTree = class(TvtComboTree)
  private
   f_OnEndTextPrint: TNotifyEvent;
    {* Поле для свойства OnEndTextPrint }
  private
   procedure EndTextPrint;
  protected
   procedure Change; override;
   procedure ProcessTreeSelect(ChooseFromTree: Boolean;
    aTriggerSelect: Boolean); override;
  public
   property OnEndTextPrint: TNotifyEvent
    read f_OnEndTextPrint
    write f_OnEndTextPrint;
 end;//TCustomComboTree

 //#UC START# *4A83EE2702B6ci*
 //#UC END# *4A83EE2702B6ci*
 //#UC START# *4A83EE2702B6cit*
 //#UC END# *4A83EE2702B6cit*
 TvtComboBoxQS = class(TCustomComboTree)
 //#UC START# *4A83EE2702B6publ*
  published
    property Items;
    property Anchors;
    property Font;
    property Ctl3D;
    property ParentColor;
    property ParentCtl3D;
    property ParentShowHint;
    property ParentFont; 
    property ShowHint;
    property TabOrder;
    property ComboStyle;
    property Enabled;
    property MaxLength;
    property EmptyHint;
    property ItemIndex;
    property Text;
    property OnKeyPress;
    property OnExit;
    property UseSystemMenu;
    property OnResize;
    property OnEndTextPrint;
 //#UC END# *4A83EE2702B6publ*
 end;//TvtComboBoxQS

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TCustomComboTree.EndTextPrint;
//#UC START# *5538D2D2035B_5538D1CB00A7_var*
//#UC END# *5538D2D2035B_5538D1CB00A7_var*
begin
//#UC START# *5538D2D2035B_5538D1CB00A7_impl*
 if Assigned(f_OnEndTextPrint) then
  f_OnEndTextPrint(Self);
//#UC END# *5538D2D2035B_5538D1CB00A7_impl*
end;//TCustomComboTree.EndTextPrint

procedure TCustomComboTree.Change;
//#UC START# *482AE42802AE_5538D1CB00A7_var*
//#UC END# *482AE42802AE_5538D1CB00A7_var*
begin
//#UC START# *482AE42802AE_5538D1CB00A7_impl*
 inherited;
 if IsValid then
  EndTextPrint;
//#UC END# *482AE42802AE_5538D1CB00A7_impl*
end;//TCustomComboTree.Change

procedure TCustomComboTree.ProcessTreeSelect(ChooseFromTree: Boolean;
 aTriggerSelect: Boolean);
//#UC START# *53EE0A730393_5538D1CB00A7_var*
//#UC END# *53EE0A730393_5538D1CB00A7_var*
begin
//#UC START# *53EE0A730393_5538D1CB00A7_impl*
 inherited;
 if ChooseFromTree then
  EndTextPrint;
//#UC END# *53EE0A730393_5538D1CB00A7_impl*
end;//TCustomComboTree.ProcessTreeSelect

//#UC START# *4A83EE2702B6impl*
//#UC END# *4A83EE2702B6impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomComboTree);
 {* Регистрация TCustomComboTree }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtComboBoxQS);
 {* Регистрация TvtComboBoxQS }
{$IfEnd} // NOT Defined(NoScripts)

end.
