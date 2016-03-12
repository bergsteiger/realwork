unit Control_p;

// Модуль: "w:\common\components\gui\Garant\AFW\Control_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
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
type
 TControlFriend = {abstract} class(TControl)
  {* Друг к классу TControl }
 end;//TControlFriend

function TControl_Get_QCPopupMenu(Self: TControlFriend): TPopupMenu;
//#UC START# *49A575600252_49A572510280get_var*
//#UC END# *49A575600252_49A572510280get_var*
begin
 with Self do
 begin
//#UC START# *49A575600252_49A572510280get_impl*
  Result := PopupMenu;
//#UC END# *49A575600252_49A572510280get_impl*
 end;//with Self
end;//TControl_Get_QCPopupMenu

procedure TControl_Get_QCPopupMenu_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TControl);
 try
  Value := tc5PublicInfo.VarFromObject(TControl_Get_QCPopupMenu(TControlFriend(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TControl, tc5OpenAppClasses.mtGet, 'QCPopupMenu', TypeInfo(TPopupMenu), [], [], TControl_Get_QCPopupMenu_Pub5);
end;

procedure TControl_Get_QCPopupMenu_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TControl);
 try
  Value := tc6PublicInfo.VarFromObject(TControl_Get_QCPopupMenu(TControlFriend(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TControl, tc6OpenAppClasses.mtGet, 'QCPopupMenu', TypeInfo(TPopupMenu), [], [], TControl_Get_QCPopupMenu_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(XE)
end.
