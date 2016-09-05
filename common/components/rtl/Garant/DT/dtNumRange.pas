unit dtNumRange;
 {* вспомогательный тип для TNumSet }

// Модуль: "w:\common\components\rtl\Garant\DT\dtNumRange.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdtNumRange" MUID: (537F6DA00036)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TdtNumRange = class(Tl3ProtoObject)
  {* вспомогательный тип для TNumSet }
  public
   LowNum: LongWord;
   HiNum: LongWord;
  public
   constructor Create(aLowNum: LongWord;
    aHiNum: LongWord); reintroduce;
   function HasIntersectionWith(aRange: TdtNumRange): Boolean;
   procedure JoinWith(aRange: TdtNumRange);
   function Amount: Integer;
 end;//TdtNumRange
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3MinMax
 //#UC START# *537F6DA00036impl_uses*
 //#UC END# *537F6DA00036impl_uses*
;

constructor TdtNumRange.Create(aLowNum: LongWord;
 aHiNum: LongWord);
//#UC START# *537F6E030167_537F6DA00036_var*
//#UC END# *537F6E030167_537F6DA00036_var*
begin
//#UC START# *537F6E030167_537F6DA00036_impl*
 inherited Create;
 if aLowNum <= aHiNum then
 begin
  LowNum := aLowNum;
  HiNum  := aHiNum;
 end
 else
 begin
  LowNum := aHiNum;
  HiNum  := aLowNum;
 end;
//#UC END# *537F6E030167_537F6DA00036_impl*
end;//TdtNumRange.Create

function TdtNumRange.HasIntersectionWith(aRange: TdtNumRange): Boolean;
//#UC START# *537F6E2A0377_537F6DA00036_var*
//#UC END# *537F6E2A0377_537F6DA00036_var*
begin
//#UC START# *537F6E2A0377_537F6DA00036_impl*
 Result := (Self.HiNum  >= aRange.LowNum) and
           (Self.LowNum <= aRange.HiNum);
//#UC END# *537F6E2A0377_537F6DA00036_impl*
end;//TdtNumRange.HasIntersectionWith

procedure TdtNumRange.JoinWith(aRange: TdtNumRange);
//#UC START# *537F6E4E0207_537F6DA00036_var*
//#UC END# *537F6E4E0207_537F6DA00036_var*
begin
//#UC START# *537F6E4E0207_537F6DA00036_impl*
 if not HasIntersectionWith(aRange) then
  raise Exception.Create('Попытка объединения непересекающихся диапазонов.');

 Self.LowNum := Min(Self.LowNum, aRange.LowNum);
 Self.HiNum  := Max(Self.HiNum,  aRange.HiNum);
//#UC END# *537F6E4E0207_537F6DA00036_impl*
end;//TdtNumRange.JoinWith

function TdtNumRange.Amount: Integer;
//#UC START# *537F6ED601AE_537F6DA00036_var*
//#UC END# *537F6ED601AE_537F6DA00036_var*
begin
//#UC START# *537F6ED601AE_537F6DA00036_impl*
 Result := HiNum - LowNum + 1;
//#UC END# *537F6ED601AE_537F6DA00036_impl*
end;//TdtNumRange.Amount
{$IfEnd} // NOT Defined(Nemesis)

end.
