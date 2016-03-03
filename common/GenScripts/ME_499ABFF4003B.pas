unit nscNavigatorPageControl_p;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscNavigatorPageControl_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
 , nscNavigator
 , ElPgCtl
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

function TnscNavigatorPageControl_Get_TabIndex(Self: TnscNavigatorPageControl): Integer;
//#UC START# *499AC00E001F_499ABFF4003Bget_var*
//#UC END# *499AC00E001F_499ABFF4003Bget_var*
begin
 with Self do
 begin
//#UC START# *499AC00E001F_499ABFF4003Bget_impl*
 Result := TabIndex;
//#UC END# *499AC00E001F_499ABFF4003Bget_impl*
 end;//with Self
end;//TnscNavigatorPageControl_Get_TabIndex

procedure TnscNavigatorPageControl_Set_TabIndex(Self: TnscNavigatorPageControl;
 aValue: Integer);
//#UC START# *499AC00E001F_499ABFF4003Bset_var*
//#UC END# *499AC00E001F_499ABFF4003Bset_var*
begin
 with Self do
 begin
//#UC START# *499AC00E001F_499ABFF4003Bset_impl*
 TabIndex := aValue;
//#UC END# *499AC00E001F_499ABFF4003Bset_impl*
 end;//with Self
end;//TnscNavigatorPageControl_Set_TabIndex

function TnscNavigatorPageControl_Get_TabPosition(Self: TnscNavigatorPageControl): TElTabPosition;
//#UC START# *499AC95002D7_499ABFF4003Bget_var*
//#UC END# *499AC95002D7_499ABFF4003Bget_var*
begin
 with Self do
 begin
//#UC START# *499AC95002D7_499ABFF4003Bget_impl*
 Result := TabPosition;
//#UC END# *499AC95002D7_499ABFF4003Bget_impl*
 end;//with Self
end;//TnscNavigatorPageControl_Get_TabPosition

function TnscNavigatorPageControl_Get_ActivePage(Self: TnscNavigatorPageControl): TElTabSheet;
//#UC START# *499AC95A016A_499ABFF4003Bget_var*
//#UC END# *499AC95A016A_499ABFF4003Bget_var*
begin
 with Self do
 begin
//#UC START# *499AC95A016A_499ABFF4003Bget_impl*
 Result := ActivePage;
//#UC END# *499AC95A016A_499ABFF4003Bget_impl*
 end;//with Self
end;//TnscNavigatorPageControl_Get_ActivePage

procedure TnscNavigatorPageControl_Get_TabIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  Value := (TnscNavigatorPageControl_Get_TabIndex(TnscNavigatorPageControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnscNavigatorPageControl_Set_TabIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  TnscNavigatorPageControl_Set_TabIndex(TnscNavigatorPageControl(Instance), OleVariant(Args^[0]));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TnscNavigatorPageControl_Get_TabPosition_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  Value := (TnscNavigatorPageControl_Get_TabPosition(TnscNavigatorPageControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnscNavigatorPageControl_Get_ActivePage_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  Value := tc5PublicInfo.VarFromObject(TnscNavigatorPageControl_Get_ActivePage(TnscNavigatorPageControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc5OpenAppClasses.mtGet, 'TabIndex', TypeInfo(Integer), [], [], TnscNavigatorPageControl_Get_TabIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc5OpenAppClasses.mtPut, 'TabIndex', nil, [], [], TnscNavigatorPageControl_Set_TabIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc5OpenAppClasses.mtGet, 'TabPosition', TypeInfo(TElTabPosition), [], [], TnscNavigatorPageControl_Get_TabPosition_Pub5);
 tc5PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc5OpenAppClasses.mtGet, 'ActivePage', TypeInfo(TElTabSheet), [], [], TnscNavigatorPageControl_Get_ActivePage_Pub5);
end;

procedure TnscNavigatorPageControl_Get_TabIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  Value := (TnscNavigatorPageControl_Get_TabIndex(TnscNavigatorPageControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnscNavigatorPageControl_Set_TabIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  TnscNavigatorPageControl_Set_TabIndex(TnscNavigatorPageControl(Instance), OleVariant(Args^[0]));
 except
  // - гасим исключения
 end;//try..except
end;

procedure TnscNavigatorPageControl_Get_TabPosition_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  Value := (TnscNavigatorPageControl_Get_TabPosition(TnscNavigatorPageControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TnscNavigatorPageControl_Get_ActivePage_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TnscNavigatorPageControl);
 try
  Value := tc6PublicInfo.VarFromObject(TnscNavigatorPageControl_Get_ActivePage(TnscNavigatorPageControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc6OpenAppClasses.mtGet, 'TabIndex', TypeInfo(Integer), [], [], TnscNavigatorPageControl_Get_TabIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc6OpenAppClasses.mtPut, 'TabIndex', nil, [], [], TnscNavigatorPageControl_Set_TabIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc6OpenAppClasses.mtGet, 'TabPosition', TypeInfo(TElTabPosition), [], [], TnscNavigatorPageControl_Get_TabPosition_Pub6);
 tc6PublicInfo._RegisterMethod(TnscNavigatorPageControl, tc6OpenAppClasses.mtGet, 'ActivePage', TypeInfo(TElTabSheet), [], [], TnscNavigatorPageControl_Get_ActivePage_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
