unit ChromeLikeTabSetControl_p;

// Модуль: "w:\common\components\gui\Garant\VCM\ChromeLikeTabSetControl_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , ChromeLikeTabSetControl
 {$IfEnd} // NOT Defined(NoVGScene)
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
function TChromeLikeTabSetControl_Get_TabCount(Self: TChromeLikeTabSetControl): Integer;
//#UC START# *551D543A00E5_551D53DB0049get_var*
//#UC END# *551D543A00E5_551D53DB0049get_var*
begin
 with Self do
 begin
//#UC START# *551D543A00E5_551D53DB0049get_impl*
  Result := TabCount;
//#UC END# *551D543A00E5_551D53DB0049get_impl*
 end;//with Self
end;//TChromeLikeTabSetControl_Get_TabCount

function TChromeLikeTabSetControl_Get_Tabs(Self: TChromeLikeTabSetControl;
 Index: Integer): TChromeLikeTab;
//#UC START# *551D5407013B_551D53DB0049get_var*
//#UC END# *551D5407013B_551D53DB0049get_var*
begin
 with Self do
 begin
//#UC START# *551D5407013B_551D53DB0049get_impl*
  Result := Tabs[Index];
//#UC END# *551D5407013B_551D53DB0049get_impl*
 end;//with Self
end;//TChromeLikeTabSetControl_Get_Tabs

procedure TChromeLikeTabSetControl_Get_TabCount_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTabSetControl);
 try
  Value := (TChromeLikeTabSetControl_Get_TabCount(TChromeLikeTabSetControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTabSetControl_Get_Tabs_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTabSetControl);
 try
  Value := tc5PublicInfo.VarFromObject(TChromeLikeTabSetControl_Get_Tabs(TChromeLikeTabSetControl(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TChromeLikeTabSetControl, tc5OpenAppClasses.mtGet, 'TabCount', TypeInfo(Integer), [], [], TChromeLikeTabSetControl_Get_TabCount_Pub5);
 tc5PublicInfo._RegisterMethod(TChromeLikeTabSetControl, tc5OpenAppClasses.mtGet, 'Tabs', TypeInfo(TChromeLikeTab), [TypeInfo(Integer)], ['Index'], TChromeLikeTabSetControl_Get_Tabs_Pub5);
end;

procedure TChromeLikeTabSetControl_Get_TabCount_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTabSetControl);
 try
  Value := (TChromeLikeTabSetControl_Get_TabCount(TChromeLikeTabSetControl(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TChromeLikeTabSetControl_Get_Tabs_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TChromeLikeTabSetControl);
 try
  Value := tc6PublicInfo.VarFromObject(TChromeLikeTabSetControl_Get_Tabs(TChromeLikeTabSetControl(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TChromeLikeTabSetControl, tc6OpenAppClasses.mtGet, 'TabCount', TypeInfo(Integer), [], [], TChromeLikeTabSetControl_Get_TabCount_Pub6);
 tc6PublicInfo._RegisterMethod(TChromeLikeTabSetControl, tc6OpenAppClasses.mtGet, 'Tabs', TypeInfo(TChromeLikeTab), [TypeInfo(Integer)], ['Index'], TChromeLikeTabSetControl_Get_Tabs_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(NoVGScene)

{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
end.
