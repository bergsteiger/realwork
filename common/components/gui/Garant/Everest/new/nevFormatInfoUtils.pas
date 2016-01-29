unit nevFormatInfoUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFormatInfoUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Rendering::nevFormatInfoUtils
//
// Модуль, появившийся в результате оптимизации - см. {Requestlink:377753634}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevBase,
  nevTools
  ;

function EvGetContinueCell(const aTableFI: TnevFormatInfoPrim;
  const anCellObj: InevPara;
  anUp: Boolean): InevPara;
function EvGetHeadCell(const aTableFI: TnevFormatInfoPrim;
  const anCellObj: InevPara;
  aUseCellFI: Boolean): InevPara;
function EvHasContinueCell(const aCellInfo: TnevFormatInfoPrim;
  const anCellObj: InevPara;
  anUp: Boolean;
  out aCell: InevPara): Boolean;
function EvNeedIncludeHeight(const aPara: InevPara;
  aFI: TnevFormatInfoPrim): Boolean;

implementation

uses
  nevTableCellFormatInfo
  ;

// unit methods

function EvGetContinueCell(const aTableFI: TnevFormatInfoPrim;
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
end;//EvGetContinueCell

function EvGetHeadCell(const aTableFI: TnevFormatInfoPrim;
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
end;//EvGetHeadCell

function EvHasContinueCell(const aCellInfo: TnevFormatInfoPrim;
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
end;//EvHasContinueCell

function EvNeedIncludeHeight(const aPara: InevPara;
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
end;//EvNeedIncludeHeight

end.