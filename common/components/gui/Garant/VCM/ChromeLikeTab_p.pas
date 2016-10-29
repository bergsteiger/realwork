unit ChromeLikeTab_p;

// Модуль: "w:\common\components\gui\Garant\VCM\ChromeLikeTab_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TChromeLikeTab" MUID: (551D67AC02C4)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , ChromeLikeTabSetControl
 {$IfEnd} // NOT Defined(NoVGScene)
 , RectWrap
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

{$If NOT Defined(NoVGScene)}
function TChromeLikeTab_pm_GetText(Self: TChromeLikeTab): AnsiString;
//#UC START# *551D692303AB_551D67AC02C4get_var*
//#UC END# *551D692303AB_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D692303AB_551D67AC02C4get_impl*
  Result := Text;
//#UC END# *551D692303AB_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_pm_GetText

function TChromeLikeTab_pm_GetIsSelected(Self: TChromeLikeTab): Boolean;
//#UC START# *551D693400A4_551D67AC02C4get_var*
//#UC END# *551D693400A4_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D693400A4_551D67AC02C4get_impl*
  Result := Selected;
//#UC END# *551D693400A4_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_pm_GetIsSelected

function TChromeLikeTab_pm_GetVisible(Self: TChromeLikeTab): Boolean;
//#UC START# *551D69B60184_551D67AC02C4get_var*
//#UC END# *551D69B60184_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D69B60184_551D67AC02C4get_impl*
  Result := Visible;
//#UC END# *551D69B60184_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_pm_GetVisible

function TChromeLikeTab_pm_GetHint(Self: TChromeLikeTab): AnsiString;
//#UC START# *551D69EA00CA_551D67AC02C4get_var*
//#UC END# *551D69EA00CA_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D69EA00CA_551D67AC02C4get_impl*
  Result := HintText;
//#UC END# *551D69EA00CA_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_pm_GetHint

function TChromeLikeTab_pm_GetPositionRect(Self: TChromeLikeTab): TRectWrap;
//#UC START# *551D72CA0359_551D67AC02C4get_var*
//#UC END# *551D72CA0359_551D67AC02C4get_var*
begin
 with Self do
 begin
//#UC START# *551D72CA0359_551D67AC02C4get_impl*
  Result := TRectWrap.Create(PositionRect);
//#UC END# *551D72CA0359_551D67AC02C4get_impl*
 end;//with Self
end;//TChromeLikeTab_pm_GetPositionRect

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'Text', TypeInfo(AnsiString), [], [], TChromeLikeTab_Get_Text_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'IsSelected', TypeInfo(Boolean), [], [], TChromeLikeTab_Get_IsSelected_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'Visible', TypeInfo(Boolean), [], [], TChromeLikeTab_Get_Visible_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'Hint', TypeInfo(AnsiString), [], [], TChromeLikeTab_Get_Hint_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTab, tc5OpenAppClasses.mtGet, 'PositionRect', TypeInfo(TRectWrap), [], [], TChromeLikeTab_Get_PositionRect_Pub5);
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
{$IfEnd} // NOT Defined(NoVGScene)

{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
end.
