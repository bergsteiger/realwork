unit evDocumentPartGeneratorPrim;

// ������: "w:\common\components\gui\Garant\Everest\evDocumentPartGeneratorPrim.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evHighLevelDocumentGenerator
 , evGeneratorsInterfaces
 , nevBase
;

type
 TevDocumentPartGeneratorPrim = class(TevHighLevelDocumentGenerator, IevJoinGenerator)
  private
   f_Flags: TevLoadFlags;
    {* ���� ��� �������� Flags }
  protected
   procedure AtEndChanged; virtual; abstract;
   procedure pm_SetNeedJoin(aValue: Boolean);
   procedure pm_SetAtEnd(aValue: Boolean);
   procedure pm_SetNeedSkipSubDocuments(aValue: Boolean);
   procedure Set_LoadFlags(aValue: TevLoadFlags);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  protected
   property Flags: TevLoadFlags
    read f_Flags;
 end;//TevDocumentPartGeneratorPrim

implementation

uses
 l3ImplUses
;

procedure TevDocumentPartGeneratorPrim.pm_SetNeedJoin(aValue: Boolean);
//#UC START# *4A253D5102D2_4A8BBCB90035set_var*
//#UC END# *4A253D5102D2_4A8BBCB90035set_var*
begin
//#UC START# *4A253D5102D2_4A8BBCB90035set_impl*
 if aValue then
  Include(f_Flags, ev_lfNeedJoin)
 else
  Exclude(f_Flags, ev_lfNeedJoin);
//#UC END# *4A253D5102D2_4A8BBCB90035set_impl*
end;//TevDocumentPartGeneratorPrim.pm_SetNeedJoin

procedure TevDocumentPartGeneratorPrim.pm_SetAtEnd(aValue: Boolean);
//#UC START# *4A253D76025F_4A8BBCB90035set_var*
//#UC END# *4A253D76025F_4A8BBCB90035set_var*
begin
//#UC START# *4A253D76025F_4A8BBCB90035set_impl*
 if aValue then
  Set_LoadFlags(f_Flags + [ev_lfAtEnd])
 else
  Set_LoadFlags(f_Flags - [ev_lfAtEnd]);
//#UC END# *4A253D76025F_4A8BBCB90035set_impl*
end;//TevDocumentPartGeneratorPrim.pm_SetAtEnd

procedure TevDocumentPartGeneratorPrim.pm_SetNeedSkipSubDocuments(aValue: Boolean);
//#UC START# *4A253D8700C8_4A8BBCB90035set_var*
//#UC END# *4A253D8700C8_4A8BBCB90035set_var*
begin
//#UC START# *4A253D8700C8_4A8BBCB90035set_impl*
 if aValue then
  Include(f_Flags, ev_lfSkipSubdocuments)
 else
  Exclude(f_Flags, ev_lfSkipSubdocuments);
//#UC END# *4A253D8700C8_4A8BBCB90035set_impl*
end;//TevDocumentPartGeneratorPrim.pm_SetNeedSkipSubDocuments

procedure TevDocumentPartGeneratorPrim.Set_LoadFlags(aValue: TevLoadFlags);
//#UC START# *4A8BBC390385_4A8BBCB90035set_var*
var
 l_Change : Boolean;
//#UC END# *4A8BBC390385_4A8BBCB90035set_var*
begin
//#UC START# *4A8BBC390385_4A8BBCB90035set_impl*
 l_Change := (ev_lfAtEnd in aValue) <> (ev_lfAtEnd in f_Flags);
 f_Flags := aValue;
 if l_Change then
  AtEndChanged;
//#UC END# *4A8BBC390385_4A8BBCB90035set_impl*
end;//TevDocumentPartGeneratorPrim.Set_LoadFlags

procedure TevDocumentPartGeneratorPrim.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4A8BBCB90035_var*
//#UC END# *479731C50290_4A8BBCB90035_var*
begin
//#UC START# *479731C50290_4A8BBCB90035_impl*
 inherited;
 f_Flags := [];
//#UC END# *479731C50290_4A8BBCB90035_impl*
end;//TevDocumentPartGeneratorPrim.Cleanup

end.
