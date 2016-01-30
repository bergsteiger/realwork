unit l3Diff;

// Модуль: "w:\common\components\rtl\Garant\L3\l3Diff.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tl3DiffCompareFunc = function(I: Integer;
  J: Integer): Boolean;

 Tl3DiffOperation = (
  l3diffSame
  , l3diffDeleted
  , l3diffAdded
 );//Tl3DiffOperation

 Tl3DiffReportRec = record
  rOp: Tl3DiffOperation;
  rLeftIdx: Integer;
  rRightIdx: Integer;
 end;//Tl3DiffReportRec

 Tl3DiffReportProc = procedure(const aRR: Tl3DiffReportRec);

procedure l3DoDiff(aCountLeft: Integer;
 aCountRight: Integer;
 aCompareFunc: Tl3DiffCompareFunc;
 aReportProc: Tl3DiffReportProc);

implementation

uses
 l3ImplUses
 , Math
 , l3Base
;

procedure l3DoDiff(aCountLeft: Integer;
 aCountRight: Integer;
 aCompareFunc: Tl3DiffCompareFunc;
 aReportProc: Tl3DiffReportProc);
//#UC START# *56447A0802A9_5644774902C8_var*
var
 l_LCSMatrix: PIntegerArray;
 l_Size: Integer;
 I, J: Integer;

 procedure PutAt(aLeft, aRight: Integer; aValue: Integer);
 var
  l_Idx: Integer;
 begin
  // Assert((aLeft >= 0) and (aLeft < aCountLeft) and (aRight >= 0) and (aRight < aCountRight));
  l_Idx := aRight * aCountLeft + aLeft;
  // Assert(l_Idx < aCountLeft*aCountRight);
  l_LCSMatrix^[l_Idx] := aValue;
 end;

 function GetAt(aLeft, aRight: Integer): Integer;
 begin
  if (aLeft < 0) or (aRight < 0) then
   Result := 0
  else
   Result := l_LCSMatrix^[aRight * aCountLeft + aLeft];
 end;

 function RR(const aOp: Tl3DiffOperation; const aLI, aRI: Integer): Tl3DiffReportRec;
 begin
  Result.rOp := aOp;
  Result.rLeftIdx := aLI;
  Result.rRightIdx := aRI;
 end;

 procedure DoDiff(aL, aR: Integer);
 begin
  if (aL >= 0) and (aR >= 0) and aCompareFunc(aL, aR) then
  begin
   DoDiff(aL-1, aR-1);
   aReportProc(RR(l3diffSame, aL, aR));
  end
  else
   if (aR >= 0) and ((aL < 0) or (GetAt(aL, aR-1) >= GetAt(aL-1, aR))) then
   begin
    DoDiff(aL, aR-1);
    aReportProc(RR(l3diffAdded, aL, aR));
   end
   else
    if (aL >= 0) and ((aR < 0) or (GetAt(aL, aR-1) < GetAt(aL-1, aR))) then
    begin
     DoDiff(aL-1, aR);
     aReportProc(RR(l3diffDeleted, aL, aR));
    end;
 end;

//#UC END# *56447A0802A9_5644774902C8_var*
begin
//#UC START# *56447A0802A9_5644774902C8_impl*
 l_Size := aCountLeft * aCountRight * SizeOf(Integer);
 l3System.GetLocalMem(l_LCSMatrix, l_Size);
 try
  l3FillChar(l_LCSMatrix^, l_Size);
  // строим матрицу
  for I := 0 to aCountLeft-1 do
  begin
   for J := 0 to aCountRight-1 do
   begin
    if aCompareFunc(I,J) then
     PutAt(I,J, GetAt(I-1, J-1) + 1)
    else
     PutAt(I,J, Max(GetAt(I, J-1), GetAt(I-1, J)));
   end;
  end;
  
  // пробегаем по матрице и строим дифф
  DoDiff(aCountLeft-1, aCountRight-1);
 finally
  l3System.FreeLocalMem(l_LCSMatrix);
 end;
//#UC END# *56447A0802A9_5644774902C8_impl*
end;//l3DoDiff

end.
