unit FakeBox_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VTTest"
// Модуль: "w:/common/components/gui/Garant/VT/FakeBox_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VTTest::ComboTree::TFakeBox
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
  FakeBox,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TFakeBox

{$If not defined(XE)}
function TFakeBox_Get_ItemIndex(Self: TFakeBox): Integer;
//#UC START# *499A86B50355_499A86AA0326get_var*
//#UC END# *499A86B50355_499A86AA0326get_var*
begin
 with Self do
 begin
//#UC START# *499A86B50355_499A86AA0326get_impl*
 Result := ItemIndex;
//#UC END# *499A86B50355_499A86AA0326get_impl*
 end;//with Self
end;//TFakeBox_Get_ItemIndex
{$IfEnd} //not XE

{$If not defined(XE)}
procedure TFakeBox_Set_ItemIndex(Self: TFakeBox; aValue: Integer);
//#UC START# *499A86B50355_499A86AA0326set_var*
//#UC END# *499A86B50355_499A86AA0326set_var*
begin
 with Self do
 begin
//#UC START# *499A86B50355_499A86AA0326set_impl*
 ItemIndex := aValue;
//#UC END# *499A86B50355_499A86AA0326set_impl*
 end;//with Self
end;//TFakeBox_Set_ItemIndex
{$IfEnd} //not XE

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TFakeBox, tc5OpenAppClasses.mtGet, 'ItemIndex', TypeInfo(Integer), [], [], TFakeBox_Get_ItemIndex_Pub5);
 tc5PublicInfo._RegisterMethod(TFakeBox, tc5OpenAppClasses.mtPut, 'ItemIndex', nil, [], [], TFakeBox_Set_ItemIndex_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TFakeBox, tc6OpenAppClasses.mtGet, 'ItemIndex', TypeInfo(Integer), [], [], TFakeBox_Get_ItemIndex_Pub6);
 tc6PublicInfo._RegisterMethod(TFakeBox, tc6OpenAppClasses.mtPut, 'ItemIndex', nil, [], [], TFakeBox_Set_ItemIndex_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.