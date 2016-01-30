unit bsTypesNew;
 {* Типы бизнес уровня. Кусок от bsTypes. На самом деле БОЛЬШАЯ ПОМОЙКА. Новые типы добавлять сюда нельзя }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\bsTypesNew.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , eeInterfaces
;

type
 TDocumentPositionType = (
  {* Типы позиционирования в документе }
  dptNone
  , dptSub
  , dptMarker
  , dptBookmark
  , dptPara
  , dptMark
  , dptDocumentPlace
 );//TDocumentPositionType

 TbsDocPos = object
  public
   rRefType: TDocumentPositionType;
   rPos: Longword;
   rPara: IeePara;
  public
   function EQ(const anOther: TbsDocPos): Boolean;
 end;//TbsDocPos

function TbsDocPos_C(aType: TDocumentPositionType;
 aPos: Longword): TbsDocPos;
function TbsDocPos_E: TbsDocPos;
 {* Пустая позиция }
function TbsDocPos_S(aPos: Longword): TbsDocPos;
 {* Позиция указывающая на Sub }
function TbsDocPos_P(const aPos: IeePara): TbsDocPos;
function TbsDocPos_PID(aPos: Longword): TbsDocPos;

implementation

uses
 l3ImplUses
 , DocumentUnit
 , l3Bits
;

function TbsDocPos_C(aType: TDocumentPositionType;
 aPos: Longword): TbsDocPos;
//#UC START# *4BA782140193_491B329F0330_var*
//#UC END# *4BA782140193_491B329F0330_var*
begin
//#UC START# *4BA782140193_491B329F0330_impl*
 Result.rRefType := aType;
 Result.rPos := aPos;
 if (Result.rRefType = dptSub) then
 begin
  if (Result.rPos AND POSITION_TYPE_MASK = POSITION_TYPE_PARA_ID) then
   Result.rRefType := dptPara;
  l3ClearMask(Integer(Result.rPos), Integer(POSITION_TYPE_MASK));
 end;//fRefType = dptSub
//#UC END# *4BA782140193_491B329F0330_impl*
end;//TbsDocPos_C

function TbsDocPos_E: TbsDocPos;
 {* Пустая позиция }
//#UC START# *4BA7822703B2_491B329F0330_var*
//#UC END# *4BA7822703B2_491B329F0330_var*
begin
//#UC START# *4BA7822703B2_491B329F0330_impl*
 Result := TbsDocPos_C(dptNone, 0);
//#UC END# *4BA7822703B2_491B329F0330_impl*
end;//TbsDocPos_E

function TbsDocPos_S(aPos: Longword): TbsDocPos;
 {* Позиция указывающая на Sub }
//#UC START# *4BA7823901C7_491B329F0330_var*
//#UC END# *4BA7823901C7_491B329F0330_var*
begin
//#UC START# *4BA7823901C7_491B329F0330_impl*
 Result := TbsDocPos_C(dptSub, aPos);
//#UC END# *4BA7823901C7_491B329F0330_impl*
end;//TbsDocPos_S

function TbsDocPos_P(const aPos: IeePara): TbsDocPos;
//#UC START# *4BA789E200FF_491B329F0330_var*
//#UC END# *4BA789E200FF_491B329F0330_var*
begin
//#UC START# *4BA789E200FF_491B329F0330_impl*
 if (aPos <> nil) then
 begin
  if (aPos.ID = -1) then
   Result := TbsDocPos_PID(0)
  else
   Result := TbsDocPos_PID(aPos.ID);
  Result.rPara := aPos;
 end;//aPos <> nil
//#UC END# *4BA789E200FF_491B329F0330_impl*
end;//TbsDocPos_P

function TbsDocPos_PID(aPos: Longword): TbsDocPos;
//#UC START# *4C064CB90097_491B329F0330_var*
//#UC END# *4C064CB90097_491B329F0330_var*
begin
//#UC START# *4C064CB90097_491B329F0330_impl*
 Result := TbsDocPos_C(dptPara, aPos);
//#UC END# *4C064CB90097_491B329F0330_impl*
end;//TbsDocPos_PID

function TbsDocPos.EQ(const anOther: TbsDocPos): Boolean;
//#UC START# *50103641035D_491B329F0330_var*
//#UC END# *50103641035D_491B329F0330_var*
begin
//#UC START# *50103641035D_491B329F0330_impl*
 Result := (Self.rPos = anOther.rPos) and
           (Self.rRefType = anOther.rRefType);
//#UC END# *50103641035D_491B329F0330_impl*
end;//TbsDocPos.EQ

end.
