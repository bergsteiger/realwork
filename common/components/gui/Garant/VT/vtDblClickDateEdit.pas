unit vtDblClickDateEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/vtDblClickDateEdit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::DateEdit::TvtDblClickDateEdit
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  vtDateEdit
  ;

type
 TvtDblClickDateEdit = class(TvtDateEdit)
 protected
 // overridden protected methods
   procedure MakeCalendar; override;
     {* ��������� ������ MakeCalendar }
 end;//TvtDblClickDateEdit

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TvtDblClickDateEdit

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
{$If not defined(NoScripts)}
// ����������� TvtDblClickDateEdit
 TtfwClassRef.Register(TvtDblClickDateEdit);
{$IfEnd} //not NoScripts

end.