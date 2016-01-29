unit vcmFormSetFactoryPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFactoryPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFactoryPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  l3ProtoObject
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormSetFactoryPrim = class(Tl3ProtoObject)
 private
 // private fields
   f_Caption : Il3CString;
    {* ���� ��� �������� Caption}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 protected
 // protected methods
   class function GetInstance: TvcmFormSetFactoryPrim; virtual;
 public
 // public properties
   property Caption: Il3CString
     read f_Caption
     write f_Caption;
 end;//TvcmFormSetFactoryPrim
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmFormSetFactoryPrim

class function TvcmFormSetFactoryPrim.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4FFE84F00388_var*
//#UC END# *4FFE854A009B_4FFE84F00388_var*
begin
//#UC START# *4FFE854A009B_4FFE84F00388_impl*
 Result := nil;
 Assert(false, Format('��������� ������ %s �� ��������', [ClassName]));
//#UC END# *4FFE854A009B_4FFE84F00388_impl*
end;//TvcmFormSetFactoryPrim.GetInstance

procedure TvcmFormSetFactoryPrim.Cleanup;
//#UC START# *479731C50290_4FFE84F00388_var*
//#UC END# *479731C50290_4FFE84F00388_var*
begin
//#UC START# *479731C50290_4FFE84F00388_impl*
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_4FFE84F00388_impl*
end;//TvcmFormSetFactoryPrim.Cleanup

procedure TvcmFormSetFactoryPrim.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 Caption := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmFormSetFactoryPrim.ClearFields

{$IfEnd} //not NoVCM

end.