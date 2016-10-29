unit FakeBox_p;

// Модуль: "w:\common\components\gui\Garant\VT\FakeBox_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TFakeBox" MUID: (499A86AA0326)

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , FakeBox
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

function TFakeBox_pm_GetItemIndex(Self: TFakeBox): Integer;
//#UC START# *499A86B50355_499A86AA0326get_var*
//#UC END# *499A86B50355_499A86AA0326get_var*
begin
 with Self do
 begin
//#UC START# *499A86B50355_499A86AA0326get_impl*
 Result := ItemIndex;
//#UC END# *499A86B50355_499A86AA0326get_impl*
 end;//with Self
end;//TFakeBox_pm_GetItemIndex

procedure TFakeBox_pm_SetItemIndex(Self: TFakeBox;
 aValue: Integer);
//#UC START# *499A86B50355_499A86AA0326set_var*
//#UC END# *499A86B50355_499A86AA0326set_var*
begin
 with Self do
 begin
//#UC START# *499A86B50355_499A86AA0326set_impl*
 ItemIndex := aValue;
//#UC END# *499A86B50355_499A86AA0326set_impl*
 end;//with Self
end;//TFakeBox_pm_SetItemIndex

procedure TFakeBox_Get_ItemIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TFakeBox);
 try
  Value := (TFakeBox_Get_ItemIndex(TFakeBox(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TFakeBox_Set_ItemIndex_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TFakeBox);
 try
  TFakeBox_Set_ItemIndex(TFakeBox(Instance), OleVariant(Args^[0]));
 except
  // - гасим исключения
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TFakeBox, tc5OpenAppClasses.mtGet, 'ItemIndex', TypeInfo(Integer), [], [], TFakeBox_Get_ItemIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TFakeBox, tc5OpenAppClasses.mtPut, 'ItemIndex', nil, [], [], TFakeBox_Set_ItemIndex_Pub5);
end;

procedure TFakeBox_Get_ItemIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TFakeBox);
 try
  Value := (TFakeBox_Get_ItemIndex(TFakeBox(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TFakeBox_Set_ItemIndex_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TFakeBox);
 try
  TFakeBox_Set_ItemIndex(TFakeBox(Instance), OleVariant(Args^[0]));
 except
  // - гасим исключения
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TFakeBox, tc6OpenAppClasses.mtGet, 'ItemIndex', TypeInfo(Integer), [], [], TFakeBox_Get_ItemIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TFakeBox, tc6OpenAppClasses.mtPut, 'ItemIndex', nil, [], [], TFakeBox_Set_ItemIndex_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
