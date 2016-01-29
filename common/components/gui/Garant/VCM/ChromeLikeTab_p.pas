unit ChromeLikeTab_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCMTest"
// Модуль: "w:/common/components/gui/Garant/VCM/ChromeLikeTab_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VCMTest::ChromeLike::TChromeLikeTab
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
uses
  RectWrap
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeTabSetControl
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

// start class TChromeLikeTab

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
function TChromeLikeTab_Get_Text(Self: TChromeLikeTab): AnsiString;
//#UC START# *551D692303AB_551D67AC02C4get_var*
//#UC END# *551D692303AB_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D692303AB_551D67AC02C4get_impl*
  Result := Text;
//#UC END# *551D692303AB_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_Get_Text
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
function TChromeLikeTab_Get_IsSelected(Self: TChromeLikeTab): Boolean;
//#UC START# *551D693400A4_551D67AC02C4get_var*
//#UC END# *551D693400A4_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D693400A4_551D67AC02C4get_impl*
  Result := Selected;
//#UC END# *551D693400A4_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_Get_IsSelected
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
function TChromeLikeTab_Get_Visible(Self: TChromeLikeTab): Boolean;
//#UC START# *551D69B60184_551D67AC02C4get_var*
//#UC END# *551D69B60184_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D69B60184_551D67AC02C4get_impl*
  Result := Visible;
//#UC END# *551D69B60184_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_Get_Visible
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
function TChromeLikeTab_Get_Hint(Self: TChromeLikeTab): AnsiString;
//#UC START# *551D69EA00CA_551D67AC02C4get_var*
//#UC END# *551D69EA00CA_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D69EA00CA_551D67AC02C4get_impl*
  Result := HintText;
//#UC END# *551D69EA00CA_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_Get_Hint
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
function TChromeLikeTab_Get_PositionRect(Self: TChromeLikeTab): TRectWrap;
//#UC START# *551D72CA0359_551D67AC02C4get_var*
//#UC END# *551D72CA0359_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D72CA0359_551D67AC02C4get_impl*
  Result := TRectWrap.Create(PositionRect);
//#UC END# *551D72CA0359_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_Get_PositionRect
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

procedure TChromeLikeTab_Get_Text_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_Text(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_Text_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_Text(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_IsSelected_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_IsSelected(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_IsSelected_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_IsSelected(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_Visible_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_Visible(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_Visible_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_Visible(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_Hint_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_Hint(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_Hint_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := (TChromeLikeTab_Get_Hint(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_PositionRect_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := tc5PublicInfo.VarFromObject(TChromeLikeTab_Get_PositionRect(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTab_Get_PositionRect_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTab);
 try
  Value := tc6PublicInfo.VarFromObject(TChromeLikeTab_Get_PositionRect(TChromeLikeTab(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'Text', TypeInfo(AnsiString), [], [], TChromeLikeTab_Get_Text_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'IsSelected', TypeInfo(Boolean), [], [], TChromeLikeTab_Get_IsSelected_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TChromeLikeTab_Get_Visible_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'Hint', TypeInfo(AnsiString), [], [], TChromeLikeTab_Get_Hint_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'PositionRect', TypeInfo(TRectWrap), [], [], TChromeLikeTab_Get_PositionRect_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TChromeLikeTab, tc6OpenAppClasses.mtGet, 'Text', TypeInfo(AnsiString), [], [], TChromeLikeTab_Get_Text_Pub6);
 tc6PublicInfo._RegisterMethod(TChromeLikeTab, tc6OpenAppClasses.mtGet, 'IsSelected', TypeInfo(Boolean), [], [], TChromeLikeTab_Get_IsSelected_Pub6);
 tc6PublicInfo._RegisterMethod(TChromeLikeTab, tc6OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TChromeLikeTab_Get_Visible_Pub6);
 tc6PublicInfo._RegisterMethod(TChromeLikeTab, tc6OpenAppClasses.mtGet, 'Hint', TypeInfo(AnsiString), [], [], TChromeLikeTab_Get_Hint_Pub6);
 tc6PublicInfo._RegisterMethod(TChromeLikeTab, tc6OpenAppClasses.mtGet, 'PositionRect', TypeInfo(TRectWrap), [], [], TChromeLikeTab_Get_PositionRect_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.