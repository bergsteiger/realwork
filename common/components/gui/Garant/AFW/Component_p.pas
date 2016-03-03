unit Component_p;

// ������: "w:\common\components\gui\Garant\AFW\Component_p.pas"
// ���������: "TestClass"

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , Classes
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

function TComponent_Get_OwnerName(Self: TComponent): AnsiString;
//#UC START# *53723DFA005B_53723A470044get_var*
//#UC END# *53723DFA005B_53723A470044get_var*
begin
 with Self do
 begin
//#UC START# *53723DFA005B_53723A470044get_impl*
  if Owner <> nil then
    Result := Owner.Name
  else
    Result := '';
//#UC END# *53723DFA005B_53723A470044get_impl*
 end;//with Self
end;//TComponent_Get_OwnerName

function TComponent_Get_Owner(Self: TComponent): TComponent;
//#UC START# *53723A65014D_53723A470044get_var*
//#UC END# *53723A65014D_53723A470044get_var*
begin
 with Self do
 begin
//#UC START# *53723A65014D_53723A470044get_impl*
  Result := Owner;
//#UC END# *53723A65014D_53723A470044get_impl*
 end;//with Self
end;//TComponent_Get_Owner

procedure TComponent_Get_OwnerName_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TComponent);
 try
  Value := (TComponent_Get_OwnerName(TComponent(Instance)));
 except
  // - ����� ����������
  Value := Unassigned;
 end;//try..except
end;

procedure TComponent_Get_Owner_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TComponent);
 try
  Value := tc5PublicInfo.VarFromObject(TComponent_Get_Owner(TComponent(Instance)));
 except
  // - ����� ����������
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TComponent, tc5OpenAppClasses.mtGet, 'OwnerName', TypeInfo(AnsiString), [], [], TComponent_Get_OwnerName_Pub5);
 tc5PublicInfo._RegisterMethod(TComponent, tc5OpenAppClasses.mtGet, 'Owner', TypeInfo(TComponent), [], [], TComponent_Get_Owner_Pub5);
end;

procedure TComponent_Get_OwnerName_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TComponent);
 try
  Value := (TComponent_Get_OwnerName(TComponent(Instance)));
 except
  // - ����� ����������
  Value := Unassigned;
 end;//try..except
end;

procedure TComponent_Get_Owner_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TComponent);
 try
  Value := tc6PublicInfo.VarFromObject(TComponent_Get_Owner(TComponent(Instance)));
 except
  // - ����� ����������
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TComponent, tc6OpenAppClasses.mtGet, 'OwnerName', TypeInfo(AnsiString), [], [], TComponent_Get_OwnerName_Pub6);
 tc6PublicInfo._RegisterMethod(TComponent, tc6OpenAppClasses.mtGet, 'Owner', TypeInfo(TComponent), [], [], TComponent_Get_Owner_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
