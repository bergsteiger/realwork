unit evdParaStylePainter;

// ������: "w:\common\components\rtl\Garant\EVD\evdParaStylePainter.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2TagGen
 , l3Variant
;

type
 TevdParaStylePainter = class(TevdLeafParaFilter)
  private
   f_TargetStyle: Integer;
    {* ���� ��� �������� TargetStyle }
  protected
   function pm_GetTargetStyle: Integer;
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
  public
   class function SetTo(var theGenerator: Tk2TagGenerator;
    aTargetStyle: Integer): Pointer;
  public
   property TargetStyle: Integer
    read pm_GetTargetStyle;
    {* �����, ������� ����� ������� ��� ��������� }
 end;//TevdParaStylePainter

implementation

uses
 l3ImplUses
 , k2Tags
 , k2OperationContainer
 , SysUtils
;

function TevdParaStylePainter.pm_GetTargetStyle: Integer;
//#UC START# *535E2B6A00F6_535E29A5027Bget_var*
//#UC END# *535E2B6A00F6_535E29A5027Bget_var*
begin
//#UC START# *535E2B6A00F6_535E29A5027Bget_impl*
 Result := f_TargetStyle;
//#UC END# *535E2B6A00F6_535E29A5027Bget_impl*
end;//TevdParaStylePainter.pm_GetTargetStyle

class function TevdParaStylePainter.SetTo(var theGenerator: Tk2TagGenerator;
 aTargetStyle: Integer): Pointer;
//#UC START# *535E2BDC0026_535E29A5027B_var*
//#UC END# *535E2BDC0026_535E29A5027B_var*
begin
//#UC START# *535E2BDC0026_535E29A5027B_impl*
 Result := inherited SetTo(theGenerator);
 (theGenerator as TevdParaStylePainter).f_TargetStyle := aTargetStyle;
//#UC END# *535E2BDC0026_535E29A5027B_impl*
end;//TevdParaStylePainter.SetTo

procedure TevdParaStylePainter.DoWritePara(aLeaf: Tl3Variant);
 {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
//#UC START# *49E4883E0176_535E29A5027B_var*
var
 l_C : Tk2OperationContainer;
//#UC END# *49E4883E0176_535E29A5027B_var*
begin
//#UC START# *49E4883E0176_535E29A5027B_impl*
 l_C := Tk2OperationContainer.Create(nil);
 try
  aLeaf.IntW[k2_tiStyle, l_C] := f_TargetStyle;
 finally
  FreeAndNil(l_C);
 end;//try..finally
 inherited;
//#UC END# *49E4883E0176_535E29A5027B_impl*
end;//TevdParaStylePainter.DoWritePara

end.
