unit afwCaretPair;
 {* ���� ������� (��� ������� � ������). }

// ������: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwCaretPair.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSingleCaret
 , afwInsCaretType
 , afwOvrCaretType
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 DefInsMode = True;

type
 TafwCaretPair = class(TafwSingleCaret)
  {* ���� ������� (��� ������� � ������). }
  private
   f_InsertMode: Boolean;
    {* ���� ��� �������� InsertMode }
   f_InsCaretType: TafwInsCaretType;
    {* ���� ��� �������� InsCaretType }
   f_OvrCaretType: TafwOvrCaretType;
    {* ���� ��� �������� OvrCaretType }
  protected
   procedure pm_SetInsertMode(aValue: Boolean);
   procedure pm_SetInsCaretType(aValue: TafwInsCaretType);
   procedure pm_SetOvrCaretType(aValue: TafwOvrCaretType);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(anOwner: TWinControl); override;
  public
   property InsertMode: Boolean
    read f_InsertMode
    write pm_SetInsertMode;
    {* ����� �������? }
   property InsCaretType: TafwInsCaretType
    read f_InsCaretType
    write pm_SetInsCaretType;
    {* ��� ������� ��� ������ �������. }
   property OvrCaretType: TafwOvrCaretType
    read f_OvrCaretType
    write pm_SetOvrCaretType;
    {* ��� ������� ��� ������ ������. }
 end;//TafwCaretPair

implementation

uses
 l3ImplUses
 , l3Base
;

procedure TafwCaretPair.pm_SetInsertMode(aValue: Boolean);
//#UC START# *480DDA5902F7_480DD9F600F6set_var*
//#UC END# *480DDA5902F7_480DD9F600F6set_var*
begin
//#UC START# *480DDA5902F7_480DD9F600F6set_impl*
 if (aValue <> f_InsertMode) then
 begin
  f_InsertMode := aValue;
  if f_InsertMode then
   CaretType := f_InsCaretType
  else
   CaretType := f_OvrCaretType;
 end;//aValue <> f_InsertMode
//#UC END# *480DDA5902F7_480DD9F600F6set_impl*
end;//TafwCaretPair.pm_SetInsertMode

procedure TafwCaretPair.pm_SetInsCaretType(aValue: TafwInsCaretType);
//#UC START# *480DDA71036A_480DD9F600F6set_var*
//#UC END# *480DDA71036A_480DD9F600F6set_var*
begin
//#UC START# *480DDA71036A_480DD9F600F6set_impl*
 if l3Set(f_InsCaretType, aValue) AND InsertMode then
  CaretType := f_InsCaretType;
//#UC END# *480DDA71036A_480DD9F600F6set_impl*
end;//TafwCaretPair.pm_SetInsCaretType

procedure TafwCaretPair.pm_SetOvrCaretType(aValue: TafwOvrCaretType);
//#UC START# *480DDAA60276_480DD9F600F6set_var*
//#UC END# *480DDAA60276_480DD9F600F6set_var*
begin
//#UC START# *480DDAA60276_480DD9F600F6set_impl*
 if l3Set(f_OvrCaretType, aValue) AND not InsertMode then
  CaretType := f_OvrCaretType;
//#UC END# *480DDAA60276_480DD9F600F6set_impl*
end;//TafwCaretPair.pm_SetOvrCaretType

procedure TafwCaretPair.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_480DD9F600F6_var*
//#UC END# *479731C50290_480DD9F600F6_var*
begin
//#UC START# *479731C50290_480DD9F600F6_impl*
 l3Free(f_InsCaretType);
 l3Free(f_OvrCaretType);
 inherited;
//#UC END# *479731C50290_480DD9F600F6_impl*
end;//TafwCaretPair.Cleanup

constructor TafwCaretPair.Create(anOwner: TWinControl);
//#UC START# *52FCEEE902D1_480DD9F600F6_var*
//#UC END# *52FCEEE902D1_480DD9F600F6_var*
begin
//#UC START# *52FCEEE902D1_480DD9F600F6_impl*
 inherited Create(anOwner);
 f_InsCaretType := TafwInsCaretType.Create;
 f_OvrCaretType := TafwOvrCaretType.Create;
 f_InsertMode := DefInsMode;
 if f_InsertMode then
  CaretType := f_InsCaretType
 else
  CaretType := f_OvrCaretType;
//#UC END# *52FCEEE902D1_480DD9F600F6_impl*
end;//TafwCaretPair.Create

end.
