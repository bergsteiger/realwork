unit Menu_p;

// Модуль: "w:\common\components\gui\Garant\AFW\Menu_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TMenu" MUID: (49A3ECCB0366)

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
function TMenu_Get_Items(Self: TMenu): TMenuItem;
//#UC START# *49A3ED2A0248_49A3ECCB0366get_var*
//#UC END# *49A3ED2A0248_49A3ECCB0366get_var*
begin
 with Self do
 begin
//#UC START# *49A3ED2A0248_49A3ECCB0366get_impl*
  Result := Items;
//#UC END# *49A3ED2A0248_49A3ECCB0366get_impl*
 end;//with Self
end;//TMenu_Get_Items

procedure TMenu_Get_Items_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenu);
 try
  Value := tc5PublicInfo.VarFromObject(TMenu_Get_Items(TMenu(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TMenu, tc5OpenAppClasses.mtGet, 'Items', TypeInfo(TMenuItem), [], [], TMenu_Get_Items_Pub5);
end;

procedure TMenu_Get_Items_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TMenu);
 try
  Value := tc6PublicInfo.VarFromObject(TMenu_Get_Items(TMenu(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TMenu, tc6OpenAppClasses.mtGet, 'Items', TypeInfo(TMenuItem), [], [], TMenu_Get_Items_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(XE)
end.
