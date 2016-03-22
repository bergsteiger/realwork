unit evCustomChatMemo;
 {* Мемо-поле для чатов }

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomChatMemo.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevCustomChatMemo" MUID: (4A8A6DD700CC)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemo
 , l3Interfaces
;

type
 TevCustomChatMemo = class(TevCustomMemo)
  {* Мемо-поле для чатов }
  protected
   procedure InitFields; override;
   function WantSoftEnter: Boolean; override;
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; override;
  public
   function KeepParaFormattingTag(aTag: Integer): Boolean; override;
    {* Сохранять ли элемент оформления }
 end;//TevCustomChatMemo

implementation

uses
 l3ImplUses
 , k2Tags
 , evOp
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TevCustomChatMemo.InitFields;
//#UC START# *47A042E100E2_4A8A6DD700CC_var*
//#UC END# *47A042E100E2_4A8A6DD700CC_var*
begin
//#UC START# *47A042E100E2_4A8A6DD700CC_impl*
 inherited;
 WebStyle := true;
 TabStop := true;
 PlainText := false; 
//#UC END# *47A042E100E2_4A8A6DD700CC_impl*
end;//TevCustomChatMemo.InitFields

function TevCustomChatMemo.KeepParaFormattingTag(aTag: Integer): Boolean;
 {* Сохранять ли элемент оформления }
//#UC START# *4A8A6D4701CC_4A8A6DD700CC_var*
//#UC END# *4A8A6D4701CC_4A8A6DD700CC_var*
begin
//#UC START# *4A8A6D4701CC_4A8A6DD700CC_impl*
 Case aTag of
  k2_tiFont,
  k2_tiSegments,
  k2_tiStyle:
   Result := true;
  else
   Result := false;
 end;//Case aTag
//#UC END# *4A8A6D4701CC_4A8A6DD700CC_impl*
end;//TevCustomChatMemo.KeepParaFormattingTag

function TevCustomChatMemo.WantSoftEnter: Boolean;
//#UC START# *4B28D6780001_4A8A6DD700CC_var*
//#UC END# *4B28D6780001_4A8A6DD700CC_var*
begin
//#UC START# *4B28D6780001_4A8A6DD700CC_impl*
 Result := false;
//#UC END# *4B28D6780001_4A8A6DD700CC_impl*
end;//TevCustomChatMemo.WantSoftEnter

function TevCustomChatMemo.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *4B309684022A_4A8A6DD700CC_var*
//#UC END# *4B309684022A_4A8A6DD700CC_var*
begin
//#UC START# *4B309684022A_4A8A6DD700CC_impl*
 Case Cmd of
  ev_ocWordLeft,
  ev_ocWordRight:
   Result := false;
  else
   Result := inherited IsCommandPublished(Cmd);
 end;//Case Cmd
//#UC END# *4B309684022A_4A8A6DD700CC_impl*
end;//TevCustomChatMemo.IsCommandPublished

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomChatMemo);
 {* Регистрация TevCustomChatMemo }
{$IfEnd} // NOT Defined(NoScripts)

end.
