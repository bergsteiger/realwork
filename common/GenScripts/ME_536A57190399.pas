unit vgRemindersLine_p;

// Модуль: "w:\common\components\gui\Garant\VT\vgRemindersLine_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLine
 {$IfEnd} // NOT Defined(NoVGScene)
;
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

{$If NOT Defined(NoVGScene)}
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

function TvgRemindersLine_Get_Reminder(Self: TvgRemindersLine;
 Index: Integer): TvgReminder;
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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvgRemindersLine, tc5OpenAppClasses.mtGet, 'Count', TypeInfo(Integer), [], [], TvgRemindersLine_Get_Count_Pub5);
 tc5PublicInfo._RegisterMethod(TvgRemindersLine, tc5OpenAppClasses.mtGet, 'Reminder', TypeInfo(TvgReminder), [TypeInfo(Integer)], ['Index'], TvgRemindersLine_Get_Reminder_Pub5);
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

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvgRemindersLine, tc6OpenAppClasses.mtGet, 'Count', TypeInfo(Integer), [], [], TvgRemindersLine_Get_Count_Pub6);
 tc6PublicInfo._RegisterMethod(TvgRemindersLine, tc6OpenAppClasses.mtGet, 'Reminder', TypeInfo(TvgReminder), [TypeInfo(Integer)], ['Index'], TvgRemindersLine_Get_Reminder_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(NoVGScene)

{$IfEnd} // NOT Defined(XE)
end.
