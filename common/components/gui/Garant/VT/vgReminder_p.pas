unit vgReminder_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VTTest"
// Модуль: "w:/common/components/gui/Garant/VT/vgReminder_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VTTest::NewReminders::TvgReminder
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
  vg_objects
  {$IfEnd} //not NoVGScene
  
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

// start class TvgReminder

{$If not defined(XE)}
function TvgReminder_Get_Caption(Self: TvgReminder): AnsiString;
//#UC START# *536B5D8B01C6_536B5D600367get_var*
//#UC END# *536B5D8B01C6_536B5D600367get_var*
begin
 with Self do
 begin
//#UC START# *536B5D8B01C6_536B5D600367get_impl*
   SetString(Result, Caption.AsWStr.S, Caption.AsWStr.SLen);
//#UC END# *536B5D8B01C6_536B5D600367get_impl*
 end;//with Self
end;//TvgReminder_Get_Caption
{$IfEnd} //not XE

{$If not defined(XE)}
function TvgReminder_Get_Flash(Self: TvgReminder): Boolean;
//#UC START# *536B5D980340_536B5D600367get_var*
//#UC END# *536B5D980340_536B5D600367get_var*
begin
 with Self do
 begin
//#UC START# *536B5D980340_536B5D600367get_impl*
  Result := Flash;
//#UC END# *536B5D980340_536B5D600367get_impl*
 end;//with Self
end;//TvgReminder_Get_Flash
{$IfEnd} //not XE

{$If not defined(XE)}
function TvgReminder_Get_Visible(Self: TvgReminder): Boolean;
//#UC START# *53712731020C_536B5D600367get_var*
//#UC END# *53712731020C_536B5D600367get_var*
begin
 with Self do
 begin
//#UC START# *53712731020C_536B5D600367get_impl*
  Result := Visible;
//#UC END# *53712731020C_536B5D600367get_impl*
 end;//with Self
end;//TvgReminder_Get_Visible
{$IfEnd} //not XE

{$If not defined(XE)}
function TvgReminder_Get_VgImage(Self: TvgReminder): TvgImage;
//#UC START# *536B5E2E033B_536B5D600367get_var*
//#UC END# *536B5E2E033B_536B5D600367get_var*
begin
 with Self do
 begin
//#UC START# *536B5E2E033B_536B5D600367get_impl*
  Result := vgImage;
//#UC END# *536B5E2E033B_536B5D600367get_impl*
 end;//with Self
end;//TvgReminder_Get_VgImage
{$IfEnd} //not XE

procedure TvgReminder_Get_Caption_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := (TvgReminder_Get_Caption(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_Caption_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := (TvgReminder_Get_Caption(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_Flash_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := (TvgReminder_Get_Flash(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_Flash_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := (TvgReminder_Get_Flash(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_Visible_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := (TvgReminder_Get_Visible(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_Visible_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := (TvgReminder_Get_Visible(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_VgImage_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := tc5PublicInfo.VarFromObject(TvgReminder_Get_VgImage(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgReminder_Get_VgImage_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgReminder);
 try
  Value := tc6PublicInfo.VarFromObject(TvgReminder_Get_VgImage(TvgReminder(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvgReminder, tc5OpenAppClasses.mtGet, 'Caption', TypeInfo(AnsiString), [], [], TvgReminder_Get_Caption_Pub5);
 tc5PublicInfo._RegisterMethod(TvgReminder, tc5OpenAppClasses.mtGet, 'Flash', TypeInfo(Boolean), [], [], TvgReminder_Get_Flash_Pub5);
 tc5PublicInfo._RegisterMethod(TvgReminder, tc5OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TvgReminder_Get_Visible_Pub5);
 tc5PublicInfo._RegisterMethod(TvgReminder, tc5OpenAppClasses.mtGet, 'vgImage', TypeInfo(TvgImage), [], [], TvgReminder_Get_VgImage_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvgReminder, tc6OpenAppClasses.mtGet, 'Caption', TypeInfo(AnsiString), [], [], TvgReminder_Get_Caption_Pub6);
 tc6PublicInfo._RegisterMethod(TvgReminder, tc6OpenAppClasses.mtGet, 'Flash', TypeInfo(Boolean), [], [], TvgReminder_Get_Flash_Pub6);
 tc6PublicInfo._RegisterMethod(TvgReminder, tc6OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TvgReminder_Get_Visible_Pub6);
 tc6PublicInfo._RegisterMethod(TvgReminder, tc6OpenAppClasses.mtGet, 'vgImage', TypeInfo(TvgImage), [], [], TvgReminder_Get_VgImage_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.