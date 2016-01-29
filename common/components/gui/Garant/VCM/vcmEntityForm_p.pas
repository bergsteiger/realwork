unit vcmEntityForm_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCMTest"
// ������: "w:/common/components/gui/Garant/VCM/vcmEntityForm_p.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VCMTest::Visual::TvcmEntityForm
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\l3Define.inc}

interface

implementation

{$If not defined(XE)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  l3String,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TvcmEntityForm

{$If not defined(XE)}
function TvcmEntityForm_Get_QCTabCaption(Self: TvcmEntityForm): AnsiString;
//#UC START# *540F06320107_540F0616019Bget_var*
//#UC END# *540F06320107_540F0616019Bget_var*
begin
 with Self do
 begin
//#UC START# *540F06320107_540F0616019Bget_impl*
  Result := l3Str(Self.TabCaption.AsWStr);
//#UC END# *540F06320107_540F0616019Bget_impl*
 end;//with Self
end;//TvcmEntityForm_Get_QCTabCaption
{$IfEnd} //not XE

procedure TvcmEntityForm_Get_QCTabCaption_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmEntityForm);
 try
  Value := (TvcmEntityForm_Get_QCTabCaption(TvcmEntityForm(Instance)));
 except
  // - ����� ����������
  Value := Unassigned;
 end;//try..except
end;

procedure TvcmEntityForm_Get_QCTabCaption_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmEntityForm);
 try
  Value := (TvcmEntityForm_Get_QCTabCaption(TvcmEntityForm(Instance)));
 except
  // - ����� ����������
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvcmEntityForm, tc5OpenAppClasses.mtGet, 'QCTabCaption', TypeInfo(AnsiString), [], [], TvcmEntityForm_Get_QCTabCaption_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvcmEntityForm, tc6OpenAppClasses.mtGet, 'QCTabCaption', TypeInfo(AnsiString), [], [], TvcmEntityForm_Get_QCTabCaption_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.