unit NOT_FINISHED_ddLowLevelRTF;

// ������: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_ddLowLevelRTF.pas"
// ���������: "UtilityPack"
// ������� ������: "ddLowLevelRTF" MUID: (51E7BEA10022)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileParser
;

type
 TddRTFParser = class(Tk2CustomFileParser)
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure Read; override;
 end;//TddRTFParser

implementation

uses
 l3ImplUses
 //#UC START# *51E7BEA10022impl_uses*
 //#UC END# *51E7BEA10022impl_uses*
;

procedure TddRTFParser.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_51E7BEC302DB_var*
//#UC END# *479731C50290_51E7BEC302DB_var*
begin
//#UC START# *479731C50290_51E7BEC302DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_51E7BEC302DB_impl*
end;//TddRTFParser.Cleanup

procedure TddRTFParser.Read;
//#UC START# *4F68343D038D_51E7BEC302DB_var*
//#UC END# *4F68343D038D_51E7BEC302DB_var*
begin
//#UC START# *4F68343D038D_51E7BEC302DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F68343D038D_51E7BEC302DB_impl*
end;//TddRTFParser.Read

end.
