unit vtDblClickDateEdit;

// Модуль: "w:\common\components\gui\Garant\VT\vtDblClickDateEdit.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , vtDateEdit
;

type
 TvtDblClickDateEdit = class(TvtDateEdit)
  protected
   procedure MakeCalendar; override;
 end;//TvtDblClickDateEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvtDblClickDateEdit.MakeCalendar;
//#UC START# *554CA3BF011D_4AC5DAE50246_var*
//#UC END# *554CA3BF011D_4AC5DAE50246_var*
begin
//#UC START# *554CA3BF011D_4AC5DAE50246_impl*
 if f_CalendarPanel <> nil then
  Exit;
 f_CalendarPanel := TDblClickPopupCalendar.Create(Self);
//#UC END# *554CA3BF011D_4AC5DAE50246_impl*
end;//TvtDblClickDateEdit.MakeCalendar

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtDblClickDateEdit);
 {* Регистрация TvtDblClickDateEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
