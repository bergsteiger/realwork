unit NOT_FINISHED_ddRTFProperties;

// ������: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_ddRTFProperties.pas"
// ���������: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3NCString
 , RTFtypes
 , l3Base
 , Classes
;

type
 TddCustomStyleEntry = class
 end;//TddCustomStyleEntry

 TddStyleEntry = class(TddCustomStyleEntry)
 end;//TddStyleEntry

 TddFontEntry = class(Tl3NCString)
  private
   f_FontType: TFontType;
    {* ���� ��� �������� FontType }
   f_Family: TFontFamily;
    {* ���� ��� �������� Family }
   f_Alternate: Tl3String;
    {* ���� ��� �������� Alternate }
   f_Panose: Tl3String;
    {* ���� ��� �������� Panose }
   f_Pitch: Byte;
    {* ���� ��� �������� Pitch }
   f_Number: Integer;
    {* ���� ��� �������� Number }
   f_CharSet: Integer;
    {* ���� ��� �������� CharSet }
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure BeforeAddToCache; override;
    {* �������, ���������� ����� ����������� ������� � ��� ���������� �������������. }
   procedure InitFields; override;
  public
   procedure Assign(Source: TPersistent); override;
  public
   property FontType: TFontType
    read f_FontType
    write f_FontType;
   property Family: TFontFamily
    read f_Family
    write f_Family;
   property Alternate: Tl3String
    read f_Alternate;
   property Panose: Tl3String
    read f_Panose;
   property Pitch: Byte
    read f_Pitch
    write f_Pitch;
   property Number: Integer
    read f_Number
    write f_Number;
   property CharSet: Integer
    read f_CharSet
    write f_CharSet;
 end;//TddFontEntry

 TddRTFInfo = class
 end;//TddRTFInfo

implementation

uses
 l3ImplUses
;

procedure TddFontEntry.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_54E19074022B_var*
//#UC END# *478CF34E02CE_54E19074022B_var*
begin
//#UC START# *478CF34E02CE_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *478CF34E02CE_54E19074022B_impl*
end;//TddFontEntry.Assign

procedure TddFontEntry.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_54E19074022B_var*
//#UC END# *479731C50290_54E19074022B_var*
begin
//#UC START# *479731C50290_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_54E19074022B_impl*
end;//TddFontEntry.Cleanup

procedure TddFontEntry.BeforeAddToCache;
 {* �������, ���������� ����� ����������� ������� � ��� ���������� �������������. }
//#UC START# *479F2B3302C1_54E19074022B_var*
//#UC END# *479F2B3302C1_54E19074022B_var*
begin
//#UC START# *479F2B3302C1_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *479F2B3302C1_54E19074022B_impl*
end;//TddFontEntry.BeforeAddToCache

procedure TddFontEntry.InitFields;
//#UC START# *47A042E100E2_54E19074022B_var*
//#UC END# *47A042E100E2_54E19074022B_var*
begin
//#UC START# *47A042E100E2_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_54E19074022B_impl*
end;//TddFontEntry.InitFields

end.
