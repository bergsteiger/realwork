unit afwTextControlPrim;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwTextControlPrim.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwControl
 , afwInterfaces
 , l3Interfaces
 , Messages
;

type
 TafwTextControlPrim = class(TafwControl)
  private
   f_CCaption: IafwCString;
    {* Поле для свойства CCaption }
  private
   procedure WMGetText(var Msg: TMessage); message WM_GetText;
   procedure WMGetTextLength(var Msg: TMessage); message WM_GetTextLength;
   procedure WMSetText(var Msg: TMessage); message WM_SetText;
  protected
   procedure pm_SetCCaption(const aValue: IafwCString); virtual;
   function pm_GetCaption: Tl3DString;
   procedure pm_SetCaption(aValue: Tl3DString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   property CCaption: IafwCString
    read f_CCaption
    write pm_SetCCaption;
   property Caption: Tl3DString
    read pm_GetCaption
    write pm_SetCaption;
 end;//TafwTextControlPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TafwTextControlPrim.pm_SetCCaption(const aValue: IafwCString);
//#UC START# *48BBF0D70131_48BBD30803C5set_var*
//#UC END# *48BBF0D70131_48BBD30803C5set_var*
begin
//#UC START# *48BBF0D70131_48BBD30803C5set_impl*
 if not l3Same(f_CCaption, aValue) then
 begin
  f_CCaption := aValue;
  Perform(afw_CM_TEXTCHANGED, 0, 0);
  SendDockNotification(afw_CM_TEXTCHANGED, 0, Integer(aValue));
 end;//not l3Same(f_CCaption, aValue)
//#UC END# *48BBF0D70131_48BBD30803C5set_impl*
end;//TafwTextControlPrim.pm_SetCCaption

function TafwTextControlPrim.pm_GetCaption: Tl3DString;
//#UC START# *48BBF34A018A_48BBD30803C5get_var*
//#UC END# *48BBF34A018A_48BBD30803C5get_var*
begin
//#UC START# *48BBF34A018A_48BBD30803C5get_impl*
 Result := l3DStr(CCaption);
//#UC END# *48BBF34A018A_48BBD30803C5get_impl*
end;//TafwTextControlPrim.pm_GetCaption

procedure TafwTextControlPrim.pm_SetCaption(aValue: Tl3DString);
//#UC START# *48BBF34A018A_48BBD30803C5set_var*
//#UC END# *48BBF34A018A_48BBD30803C5set_var*
begin
//#UC START# *48BBF34A018A_48BBD30803C5set_impl*
 CCaption := l3CStr(aValue);
//#UC END# *48BBF34A018A_48BBD30803C5set_impl*
end;//TafwTextControlPrim.pm_SetCaption

procedure TafwTextControlPrim.WMGetText(var Msg: TMessage);
//#UC START# *48BBE8CB00B3_48BBD30803C5_var*
//#UC END# *48BBE8CB00B3_48BBD30803C5_var*
begin
//#UC START# *48BBE8CB00B3_48BBD30803C5_impl*
 with Msg do
  Result := StrLen(StrLCopy(PChar(LParam), PChar(l3Str(CCaption)), WParam - 1));
//#UC END# *48BBE8CB00B3_48BBD30803C5_impl*
end;//TafwTextControlPrim.WMGetText

procedure TafwTextControlPrim.WMGetTextLength(var Msg: TMessage);
//#UC START# *48BBE8DD0385_48BBD30803C5_var*
//#UC END# *48BBE8DD0385_48BBD30803C5_var*
begin
//#UC START# *48BBE8DD0385_48BBD30803C5_impl*
 Msg.Result := l3Len(CCaption);
//#UC END# *48BBE8DD0385_48BBD30803C5_impl*
end;//TafwTextControlPrim.WMGetTextLength

procedure TafwTextControlPrim.WMSetText(var Msg: TMessage);
//#UC START# *48BBE90600CF_48BBD30803C5_var*
//#UC END# *48BBE90600CF_48BBD30803C5_var*
begin
//#UC START# *48BBE90600CF_48BBD30803C5_impl*
 if (Msg.lParam <> 0) then
 begin
  Msg.Result := Ord(true);
  CCaption := l3CStr(l3PCharLen(PChar(Msg.lParam)));
 end//Msg.lParam <> 0
 else
  Msg.Result := Ord(false);
//#UC END# *48BBE90600CF_48BBD30803C5_impl*
end;//TafwTextControlPrim.WMSetText

procedure TafwTextControlPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48BBD30803C5_var*
//#UC END# *479731C50290_48BBD30803C5_var*
begin
//#UC START# *479731C50290_48BBD30803C5_impl*
 f_CCaption := nil;
 inherited;
//#UC END# *479731C50290_48BBD30803C5_impl*
end;//TafwTextControlPrim.Cleanup

procedure TafwTextControlPrim.ClearFields;
begin
 CCaption := nil;
 inherited;
end;//TafwTextControlPrim.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TafwTextControlPrim);
 {* Регистрация TafwTextControlPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
