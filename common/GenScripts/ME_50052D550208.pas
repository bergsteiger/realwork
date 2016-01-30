unit nevFormatInfoUtils;
 {* Модуль, появившийся в результате оптимизации - см. [Requestlink:377753634] }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevFormatInfoUtils.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

function evGetContinueCell(const aTableFI: TnevFormatInfoPrim;
 const anCellObj: InevPara;
 anUp: Boolean): InevPara;
function evGetHeadCell(const aTableFI: TnevFormatInfoPrim;
 const anCellObj: InevPara;
 aUseCellFI: Boolean): InevPara;
function evHasContinueCell(const aCellInfo: TnevFormatInfoPrim;
 const anCellObj: InevPara;
 anUp: Boolean;
 out aCell: InevPara): Boolean;
function evNeedIncludeHeight(const aPara: InevPara;
 aFI: TnevFormatInfoPrim): Boolean;

implementation

uses
 l3ImplUses
 , nevTableCellFormatInfo
;

function evGetContinueCell(const aTableFI: TnevFormatInfoPrim;
 const anCellObj: InevPara;
 anUp: Boolean): InevPara;
//#UC START# *5005218F0347_50052D550208_var*
var
 l_FI   : TnevFormatInfoPrim;
 l_Cell : InevPara;
//#UC END# *5005218F0347_50052D550208_var*
begin
//#UC START# *5005218F0347_50052D550208_impl*
 Result := nil;
 l_FI := aTableFI.InfoForChild(anCellObj.OwnerObj);
 l_FI := l_FI.InfoForChild(anCellObj);
 with TnevTableCellFormatInfo(l_FI) do
  if anUp then
   l_Cell := GetContinueCellAtTheTop
  else
   l_Cell := GetContinueCellBoottom;
 if (l_Cell <> nil) and l_Cell.AsObject.IsValid then
  Result := l_Cell;
//#UC END# *5005218F0347_50052D550208_impl*
end;//evGetContinueCell

function evGetHeadCell(const aTableFI: TnevFormatInfoPrim;
 const anCellObj: InevPara;
 aUseCellFI: Boolean): InevPara;
//#UC START# *5005221A0152_50052D550208_var*
var
 l_FI   : TnevFormatInfoPrim;
 l_Cell : InevPara;
//#UC END# *5005221A0152_50052D550208_var*
begin
//#UC START# *5005221A0152_50052D550208_impl*
 Result := nil;
 if aUseCellFI then
  l_FI := aTableFI
 else
 begin
  l_FI := aTableFI.InfoForChild(anCellObj.OwnerObj);
  l_FI := l_FI.InfoForChild(anCellObj);
 end;
 with TnevTableCellFormatInfo(l_FI) do
  l_Cell := GetHeadCell;
 if (l_Cell <> nil) and l_Cell.AsObject.IsValid then
  Result := l_Cell;
//#UC END# *5005221A0152_50052D550208_impl*
end;//evGetHeadCell

function evHasContinueCell(const aCellInfo: TnevFormatInfoPrim;
 const anCellObj: InevPara;
 anUp: Boolean;
 out aCell: InevPara): Boolean;
//#UC START# *5005794B03CD_50052D550208_var*
var
 l_Cell : InevPara;
//#UC END# *5005794B03CD_50052D550208_var*
begin
//#UC START# *5005794B03CD_50052D550208_impl*
 aCell := nil;
 with TnevTableCellFormatInfo(aCellInfo) do
  if anUp then
   l_Cell := GetContinueCellAtTheTop
  else
   l_Cell := GetContinueCellBoottom;
 Result := (l_Cell <> nil) and l_Cell.AsObject.IsValid;
 if Result then
  aCell := l_Cell;
//#UC END# *5005794B03CD_50052D550208_impl*
end;//evHasContinueCell

function evNeedIncludeHeight(const aPara: InevPara;
 aFI: TnevFormatInfoPrim): Boolean;
//#UC START# *5006A0AE03C2_50052D550208_var*
var
 l_MS : TOverlapType;
//#UC END# *5006A0AE03C2_50052D550208_var*
begin
//#UC START# *5006A0AE03C2_50052D550208_impl*
 Assert(False);
 l_MS := aPara.OverlapType;
 // Result := (l_MS = otNone) or ((l_MS = otUpper) and not EvHasContinueCell(aFI, aPara, False));
//#UC END# *5006A0AE03C2_50052D550208_impl*
end;//evNeedIncludeHeight

end.
