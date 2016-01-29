unit dtNumRange;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/dtNumRange.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::Containers::TdtNumRange
//
// вспомогательный тип для TNumSet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TdtNumRange = class(Tl3ProtoObject)
  {* вспомогательный тип для TNumSet }
 public
 // public fields
   LowNum : LongWord;
   HiNum : LongWord;
 public
 // public methods
   constructor Create(aLowNum: LongWord;
     aHiNum: LongWord); reintroduce;
   function HasIntersectionWith(aRange: TdtNumRange): Boolean;
   procedure JoinWith(aRange: TdtNumRange);
   function Amount: Integer;
 end;//TdtNumRange
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils,
  l3MinMax
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TdtNumRange

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

{$IfEnd} //not Nemesis

end.