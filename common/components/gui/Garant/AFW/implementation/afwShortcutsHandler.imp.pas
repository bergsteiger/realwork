{$IfNDef afwShortcutsHandler_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwShortcutsHandler.imp.pas"
// Стереотип: "Impurity"

{$Define afwShortcutsHandler_imp}

{$If NOT Defined(DesignTimeLibrary)}
 _afwShortcutsHandler_ = class(_afwShortcutsHandler_Parent_)
  {* Обработчик ShortCut'ов }
  protected
   function IsHandledShortcut(var Msg: TMessage): Boolean;
    {* Обработчик ShortCut'ов }
   function IsSomePopupWasClosed: Boolean; virtual;
   procedure WndProc(var Message: TMessage); override;
    {* Оконная процедура }
 end;//_afwShortcutsHandler_

{$Else NOT Defined(DesignTimeLibrary)}

_afwShortcutsHandler_ = _afwShortcutsHandler_Parent_;

{$IfEnd} // NOT Defined(DesignTimeLibrary)
{$Else afwShortcutsHandler_imp}

{$IfNDef afwShortcutsHandler_imp_impl}

{$Define afwShortcutsHandler_imp_impl}

{$If NOT Defined(DesignTimeLibrary)}
function _afwShortcutsHandler_.IsHandledShortcut(var Msg: TMessage): Boolean;
 {* Обработчик ShortCut'ов }
var l_Controller: TOvcController;
//#UC START# *49EF3805033D_49EF346400A4_var*
//#UC END# *49EF3805033D_49EF346400A4_var*
begin
//#UC START# *49EF3805033D_49EF346400A4_impl*
 Result := false;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if (TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut) then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;//TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut
//#UC END# *49EF3805033D_49EF346400A4_impl*
end;//_afwShortcutsHandler_.IsHandledShortcut

function _afwShortcutsHandler_.IsSomePopupWasClosed: Boolean;
//#UC START# *4EBD2EE8031A_49EF346400A4_var*
//#UC END# *4EBD2EE8031A_49EF346400A4_var*
begin
//#UC START# *4EBD2EE8031A_49EF346400A4_impl*
 Result := false;
//#UC END# *4EBD2EE8031A_49EF346400A4_impl*
end;//_afwShortcutsHandler_.IsSomePopupWasClosed

procedure _afwShortcutsHandler_.WndProc(var Message: TMessage);
 {* Оконная процедура }
//#UC START# *49EF38CC0345_49EF346400A4_var*
var
 Msg : TMessage;
//#UC END# *49EF38CC0345_49EF346400A4_var*
begin
//#UC START# *49EF38CC0345_49EF346400A4_impl*
 if (Message.Msg = CN_KEYDOWN) or (Message.Msg = CN_SYSKEYDOWN) then
 begin
  Msg := Message;
  Msg.Msg := Message.Msg - CN_BASE;

  // Обрабатываем клавиши
  if (TWMKeyDown(Message).CharCode = VK_ESCAPE) then
  begin
   if IsSomePopupWasClosed then
   begin
    Message.Result := 1;
    Exit;
   end;
  end;//TWMKeyDown(Message).Key = VK_ESCAPE

  // Для клавиши Enter не обрабатываем шоткаты OVC, была ошибка:
  //  http://mdp.garant.ru/pages/viewpage.action?pageId=269061880
  if not ( (TWMKeyDown(Message).CharCode = VK_RETURN) and
           (KeyDataToShiftState(TWMKeyDown(Message).KeyData) = []) ) 
     and IsHandledShortcut(Msg) then
  begin
   Message.Result := 1;
   Exit;
  end;//...TWMKeyDown(Message).CharCode = VK_RETURN..
 end;//Message.Msg = CN_KEYDOWN
 inherited;
//#UC END# *49EF38CC0345_49EF346400A4_impl*
end;//_afwShortcutsHandler_.WndProc
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$EndIf afwShortcutsHandler_imp_impl}

{$EndIf afwShortcutsHandler_imp}

