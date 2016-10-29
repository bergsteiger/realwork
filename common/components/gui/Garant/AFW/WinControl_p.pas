unit WinControl_p;

// Модуль: "w:\common\components\gui\Garant\AFW\WinControl_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TWinControl" MUID: (53D12ADE0303)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
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
function TWinControl_pm_GetControlCount(Self: TWinControl): Integer;
//#UC START# *53D12BB30380_53D12ADE0303get_var*
//#UC END# *53D12BB30380_53D12ADE0303get_var*
begin
 with Self do
 begin
//#UC START# *53D12BB30380_53D12ADE0303get_impl*
  Result := ControlCount;
//#UC END# *53D12BB30380_53D12ADE0303get_impl*
 end;//with Self
end;//TWinControl_pm_GetControlCount

function TWinControl_pm_GetControls(Self: TWinControl;
 Index: Integer): TControl;
//#UC START# *53D12B6E016C_53D12ADE0303get_var*
//#UC END# *53D12B6E016C_53D12ADE0303get_var*
begin
 with Self do
 begin
//#UC START# *53D12B6E016C_53D12ADE0303get_impl*
  Result := Controls[Index];
//#UC END# *53D12B6E016C_53D12ADE0303get_impl*
 end;//with Self
end;//TWinControl_pm_GetControls

procedure TWinControl_Get_ControlCount_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TWinControl);
 try
  Value := (TWinControl_Get_ControlCount(TWinControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TWinControl_Get_Controls_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TWinControl);
 try
  Value := tc5PublicInfo.VarFromObject(TWinControl_Get_Controls(TWinControl(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TWinControl, tc5OpenAppClasses.mtGet, 'ControlCount', TypeInfo(Integer), [], [], TWinControl_Get_ControlCount_Pub5);
 tc5PublicInfo._RegisterMethod(TWinControl, tc5OpenAppClasses.mtGet, 'Controls', TypeInfo(TControl), [TypeInfo(Integer)], ['Index'], TWinControl_Get_Controls_Pub5);
end;

procedure TWinControl_Get_ControlCount_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TWinControl);
 try
  Value := (TWinControl_Get_ControlCount(TWinControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TWinControl_Get_Controls_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TWinControl);
 try
  Value := tc6PublicInfo.VarFromObject(TWinControl_Get_Controls(TWinControl(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TWinControl, tc6OpenAppClasses.mtGet, 'ControlCount', TypeInfo(Integer), [], [], TWinControl_Get_ControlCount_Pub6);
 tc6PublicInfo._RegisterMethod(TWinControl, tc6OpenAppClasses.mtGet, 'Controls', TypeInfo(TControl), [TypeInfo(Integer)], ['Index'], TWinControl_Get_Controls_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(XE)
end.
