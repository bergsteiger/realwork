unit evCustomChatMemo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomChatMemo.pas"
// Начат: 18.08.2009 14:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Memos::TevCustomChatMemo
//
// Мемо-поле для чатов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomMemo,
  l3Interfaces
  ;

type
 TevCustomChatMemo = class(TevCustomMemo)
  {* Мемо-поле для чатов }
 protected
 // overridden protected methods
   procedure InitFields; override;
   function WantSoftEnter: Boolean; override;
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; override;
 public
 // overridden public methods
   function KeepParaFormattingTag(aTag: Integer): Boolean; override;
     {* Сохранять ли элемент оформления }
 end;//TevCustomChatMemo

implementation

uses
  k2Tags,
  evOp
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomChatMemo

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
{$If not defined(NoScripts)}
// Регистрация TevCustomChatMemo
 TtfwClassRef.Register(TevCustomChatMemo);
{$IfEnd} //not NoScripts

end.