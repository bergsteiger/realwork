unit vcmProfilersCollection_p;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmProfilersCollection_p.pas"
// Стереотип: "TestClass"
// Элемент модели: "TvcmProfilersCollection" MUID: (499AA4880244)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmProfilersCollection
 , vcmProfiler
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

function TvcmProfilersCollection_pm_GetProfiler(Self: TvcmProfilersCollection;
 ProfilerID: Integer): TvcmProfiler;
//#UC START# *499AA4C50300_499AA4880244get_var*
//#UC END# *499AA4C50300_499AA4880244get_var*
begin
 with Self do
 begin
//#UC START# *499AA4C50300_499AA4880244get_impl*
  Result := FindProfilerById(ProfilerID);
//#UC END# *499AA4C50300_499AA4880244get_impl*
 end;//with Self
end;//TvcmProfilersCollection_pm_GetProfiler

procedure TvcmProfilersCollection_Get_Profiler_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmProfilersCollection);
 try
  Value := tc5PublicInfo.VarFromObject(TvcmProfilersCollection_Get_Profiler(TvcmProfilersCollection(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvcmProfilersCollection, tc5OpenAppClasses.mtGet, 'Profiler', TypeInfo(TvcmProfiler), [TypeInfo(Integer)], ['ProfilerID'], TvcmProfilersCollection_Get_Profiler_Pub5);
end;

procedure TvcmProfilersCollection_Get_Profiler_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmProfilersCollection);
 try
  Value := tc6PublicInfo.VarFromObject(TvcmProfilersCollection_Get_Profiler(TvcmProfilersCollection(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvcmProfilersCollection, tc6OpenAppClasses.mtGet, 'Profiler', TypeInfo(TvcmProfiler), [TypeInfo(Integer)], ['ProfilerID'], TvcmProfilersCollection_Get_Profiler_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

end.
