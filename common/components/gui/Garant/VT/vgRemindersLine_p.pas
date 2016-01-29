unit vgRemindersLine_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VTTest"
// Модуль: "w:/common/components/gui/Garant/VT/vgRemindersLine_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VTTest::NewReminders::TvgRemindersLine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\l3Define.inc}

interface

implementation

{$If not defined(XE)}
uses
  Classes
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLine
  {$IfEnd} //not NoVGScene
  ,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TvgRemindersLine

{$If not defined(XE)}
function TvgRemindersLine_Get_Count(Self: TvgRemindersLine): Integer;
//#UC START# *536B5DA30257_536A57190399get_var*
//#UC END# *536B5DA30257_536A57190399get_var*
begin
 with Self do
 begin
//#UC START# *536B5DA30257_536A57190399get_impl*
  Result := Count;
//#UC END# *536B5DA30257_536A57190399get_impl*
 end;//with Self
end;//TvgRemindersLine_Get_Count
{$IfEnd} //not XE

{$If not defined(XE)}
function TvgRemindersLine_Get_Reminder(Self: TvgRemindersLine; Index: Integer): TvgReminder;
//#UC START# *536AC39500C3_536A57190399get_var*
//#UC END# *536AC39500C3_536A57190399get_var*
begin
 with Self do
 begin
//#UC START# *536AC39500C3_536A57190399get_impl*
  Result := Reminder[Index];
//#UC END# *536AC39500C3_536A57190399get_impl*
 end;//with Self
end;//TvgRemindersLine_Get_Reminder
{$IfEnd} //not XE

procedure TvgRemindersLine_Get_Count_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgRemindersLine);
 try
  Value := (TvgRemindersLine_Get_Count(TvgRemindersLine(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgRemindersLine_Get_Count_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgRemindersLine);
 try
  Value := (TvgRemindersLine_Get_Count(TvgRemindersLine(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgRemindersLine_Get_Reminder_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgRemindersLine);
 try
  Value := tc5PublicInfo.VarFromObject(TvgRemindersLine_Get_Reminder(TvgRemindersLine(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgRemindersLine_Get_Reminder_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgRemindersLine);
 try
  Value := tc6PublicInfo.VarFromObject(TvgRemindersLine_Get_Reminder(TvgRemindersLine(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvgRemindersLine, tc5OpenAppClasses.mtGet, 'Count', TypeInfo(Integer), [], [], TvgRemindersLine_Get_Count_Pub5);
 tc5PublicInfo._RegisterMethod(TvgRemindersLine, tc5OpenAppClasses.mtGet, 'Reminder', TypeInfo(TvgReminder), [TypeInfo(Integer)], ['Index'], TvgRemindersLine_Get_Reminder_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvgRemindersLine, tc6OpenAppClasses.mtGet, 'Count', TypeInfo(Integer), [], [], TvgRemindersLine_Get_Count_Pub6);
 tc6PublicInfo._RegisterMethod(TvgRemindersLine, tc6OpenAppClasses.mtGet, 'Reminder', TypeInfo(TvgReminder), [TypeInfo(Integer)], ['Index'], TvgRemindersLine_Get_Reminder_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.