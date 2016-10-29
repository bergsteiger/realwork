unit MenuItem_p;

// Модуль: "w:\common\components\gui\Garant\AFW\MenuItem_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TMenuItem" MUID: (499AF24802D2)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
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

{$If NOT Defined(NoVCL)}
function TMenuItem_pm_GetCaption(Self: TMenuItem): AnsiString;
//#UC START# *49A3EA0603D1_499AF24802D2get_var*
//#UC END# *49A3EA0603D1_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EA0603D1_499AF24802D2get_impl*
  Result := Caption;
//#UC END# *49A3EA0603D1_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetCaption

function TMenuItem_pm_GetCount(Self: TMenuItem): Integer;
//#UC START# *49A3EAB701E7_499AF24802D2get_var*
//#UC END# *49A3EAB701E7_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EAB701E7_499AF24802D2get_impl*
  Result := Count;
//#UC END# *49A3EAB701E7_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetCount

function TMenuItem_pm_GetMenuIndex(Self: TMenuItem): Integer;
//#UC START# *49A3EB07006A_499AF24802D2get_var*
//#UC END# *49A3EB07006A_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EB07006A_499AF24802D2get_impl*
  Result := MenuIndex;
//#UC END# *49A3EB07006A_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetMenuIndex

function TMenuItem_pm_GetVisible(Self: TMenuItem): Boolean;
//#UC START# *49A3EB180091_499AF24802D2get_var*
//#UC END# *49A3EB180091_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EB180091_499AF24802D2get_impl*
  Result := Visible;
//#UC END# *49A3EB180091_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetVisible

function TMenuItem_pm_GetEnabled(Self: TMenuItem): Boolean;
//#UC START# *49A3EB1F0087_499AF24802D2get_var*
//#UC END# *49A3EB1F0087_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EB1F0087_499AF24802D2get_impl*
  Result := Enabled;
//#UC END# *49A3EB1F0087_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetEnabled

function TMenuItem_pm_GetChecked(Self: TMenuItem): Boolean;
//#UC START# *49A3EB2702F0_499AF24802D2get_var*
//#UC END# *49A3EB2702F0_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EB2702F0_499AF24802D2get_impl*
  Result := Checked;
//#UC END# *49A3EB2702F0_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetChecked

function TMenuItem_pm_GetItems(Self: TMenuItem;
 Index: Integer): TMenuItem;
//#UC START# *49A3EA8000B8_499AF24802D2get_var*
//#UC END# *49A3EA8000B8_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EA8000B8_499AF24802D2get_impl*
  Result := Items[Index];
//#UC END# *49A3EA8000B8_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetItems

function TMenuItem_pm_GetParent(Self: TMenuItem): TMenuItem;
//#UC START# *49A3EAE00085_499AF24802D2get_var*
//#UC END# *49A3EAE00085_499AF24802D2get_var*
begin
 with Self do
 begin
//#UC START# *49A3EAE00085_499AF24802D2get_impl*
  Result := Parent;
//#UC END# *49A3EAE00085_499AF24802D2get_impl*
 end;//with Self
end;//TMenuItem_pm_GetParent

procedure TMenuItem_Get_Caption_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Caption(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Count_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Count(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_MenuIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_MenuIndex(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Visible_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Visible(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Enabled_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Enabled(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Checked_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Checked(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Items_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := tc5PublicInfo.VarFromObject(TMenuItem_Get_Items(TMenuItem(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Parent_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := tc5PublicInfo.VarFromObject(TMenuItem_Get_Parent(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Caption', TypeInfo(AnsiString), [], [], TMenuItem_Get_Caption_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Count', TypeInfo(Integer), [], [], TMenuItem_Get_Count_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'MenuIndex', TypeInfo(Integer), [], [], TMenuItem_Get_MenuIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TMenuItem_Get_Visible_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Enabled', TypeInfo(Boolean), [], [], TMenuItem_Get_Enabled_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Checked', TypeInfo(Boolean), [], [], TMenuItem_Get_Checked_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Items', TypeInfo(TMenuItem), [TypeInfo(Integer)], ['Index'], TMenuItem_Get_Items_Pub5);
 tc5PublicInfo._RegisterMethod(TMenuItem, tc5OpenAppClasses.mtGet, 'Parent', TypeInfo(TMenuItem), [], [], TMenuItem_Get_Parent_Pub5);
end;

procedure TMenuItem_Get_Caption_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Caption(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Count_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Count(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_MenuIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_MenuIndex(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Visible_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Visible(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Enabled_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Enabled(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Checked_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := (TMenuItem_Get_Checked(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Items_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := tc6PublicInfo.VarFromObject(TMenuItem_Get_Items(TMenuItem(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TMenuItem_Get_Parent_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenuItem);
 try
  Value := tc6PublicInfo.VarFromObject(TMenuItem_Get_Parent(TMenuItem(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Caption', TypeInfo(AnsiString), [], [], TMenuItem_Get_Caption_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Count', TypeInfo(Integer), [], [], TMenuItem_Get_Count_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'MenuIndex', TypeInfo(Integer), [], [], TMenuItem_Get_MenuIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TMenuItem_Get_Visible_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Enabled', TypeInfo(Boolean), [], [], TMenuItem_Get_Enabled_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Checked', TypeInfo(Boolean), [], [], TMenuItem_Get_Checked_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Items', TypeInfo(TMenuItem), [TypeInfo(Integer)], ['Index'], TMenuItem_Get_Items_Pub6);
 tc6PublicInfo._RegisterMethod(TMenuItem, tc6OpenAppClasses.mtGet, 'Parent', TypeInfo(TMenuItem), [], [], TMenuItem_Get_Parent_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(XE)
end.
