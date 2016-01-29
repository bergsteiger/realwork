unit vcmProfilersCollection_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCMTest"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmProfilersCollection_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VCMTest::Profilers::TvcmProfilersCollection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

implementation

{$If not defined(NoVCM) AND not defined(XE)}
uses
  vcmProfilersCollection,
  vcmProfiler,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not NoVCM AND not XE

// start class TvcmProfilersCollection

{$If not defined(NoVCM) AND not defined(XE)}
function TvcmProfilersCollection_Get_Profiler(Self: TvcmProfilersCollection; ProfilerID: Integer): TvcmProfiler;
//#UC START# *499AA4C50300_499AA4880244get_var*
//#UC END# *499AA4C50300_499AA4880244get_var*
begin
 with Self do
 begin
//#UC START# *499AA4C50300_499AA4880244get_impl*
  Result := FindProfilerById(ProfilerID);
//#UC END# *499AA4C50300_499AA4880244get_impl*
 end;//with Self
end;//TvcmProfilersCollection_Get_Profiler
{$IfEnd} //not NoVCM AND not XE

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvcmProfilersCollection, tc5OpenAppClasses.mtGet, 'Profiler', TypeInfo(TvcmProfiler), [TypeInfo(Integer)], ['ProfilerID'], TvcmProfilersCollection_Get_Profiler_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvcmProfilersCollection, tc6OpenAppClasses.mtGet, 'Profiler', TypeInfo(TvcmProfiler), [TypeInfo(Integer)], ['ProfilerID'], TvcmProfilersCollection_Get_Profiler_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.