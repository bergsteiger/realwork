unit evTableSearch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// ������: "w:/common/components/gui/Garant/EverestCommon/evTableSearch.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::Searchers::evTableSearch
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  nevBase,
  nevTools,
  evTypes,
  evSearch,
  l3CustomString,
  l3Variant
  ;

type
 TevTableTextSearcher = class(TevAnyParagraphSearcher)
 public
 // overridden public methods
   function DoCheckText(aPara: Tl3Variant;
     aText: Tl3CustomString;
     const aSel: TevPair;
     out theSel: TevPair): Boolean; override;
 protected
 // protected methods
   function CheckCellType(aCell: Tl3Variant): Boolean; virtual;
 end;//TevTableTextSearcher

 TevFirstTableCellSearcher = class(TevTableTextSearcher)
 public
 // overridden public methods
   function DoCheckText(aPara: Tl3Variant;
     aText: Tl3CustomString;
     const aSel: TevPair;
     out theSel: TevPair): Boolean; override;
 end;//TevFirstTableCellSearcher

 TevOldNSRCFlagReplacer = class(TevBaseReplacer)
 private
 // private fields
   f_FlagInit : Boolean;
   f_FlagValue : Boolean;
 protected
 // realized methods
   function ReplaceFunc(const aView: InevView;
     const Container: InevOp;
     const aBlock: InevRange): Boolean; override;
     {* ����������� ������� ��� ������ ����� Block �� ���-�� ���.
             ���������� - ������ ����������� ������ ������� }
 public
 // public methods
   class function Make(anOptions: TevSearchOptionSet = []): IevReplacer;
 end;//TevOldNSRCFlagReplacer

 TevTableCellFrameReplacer = class(TevBaseReplacer)
 private
 // private fields
   f_Frame : Integer;
 protected
 // realized methods
   function ReplaceFunc(const aView: InevView;
     const Container: InevOp;
     const aBlock: InevRange): Boolean; override;
     {* ����������� ������� ��� ������ ����� Block �� ���-�� ���.
             ���������� - ������ ����������� ������ ������� }
 public
 // public methods
   class function Make(aFrame: Integer;
     anOptions: TevSearchOptionSet = []): IevReplacer;
 end;//TevTableCellFrameReplacer

 TevTextInContinueCellSearcher = class(TevTableTextSearcher)
 protected
 // overridden protected methods
   function CheckCellType(aCell: Tl3Variant): Boolean; override;
 end;//TevTextInContinueCellSearcher

implementation

uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  TableCell_Const,
  SBSCell_Const,
  SysUtils,
  SBS_Const,
  Table_Const,
  k2Tags,
  evdTypes
  ;

// start class TevTableTextSearcher

function TevTableTextSearcher.CheckCellType(aCell: Tl3Variant): Boolean;
//#UC START# *5075300802E0_50751AB90061_var*
//#UC END# *5075300802E0_50751AB90061_var*
begin
//#UC START# *5075300802E0_50751AB90061_impl*
 Result := True;
//#UC END# *5075300802E0_50751AB90061_impl*
end;//TevTableTextSearcher.CheckCellType

function TevTableTextSearcher.DoCheckText(aPara: Tl3Variant;
  aText: Tl3CustomString;
  const aSel: TevPair;
  out theSel: TevPair): Boolean;
//#UC START# *50751B680376_50751AB90061_var*
var
 l_Cell : Tl3Variant;
//#UC END# *50751B680376_50751AB90061_var*
begin
//#UC START# *50751B680376_50751AB90061_impl*
 Result := inherited DoCheckText(aPara, aText, aSel, theSel);
 if Result then
  if evInPara(aPara.AsObject, k2_typTableCell, [k2_typSBSCell], l_Cell) then
   Result := CheckCellType(l_Cell)
  else
   Result := false;
//#UC END# *50751B680376_50751AB90061_impl*
end;//TevTableTextSearcher.DoCheckText
// start class TevFirstTableCellSearcher

function TevFirstTableCellSearcher.DoCheckText(aPara: Tl3Variant;
  aText: Tl3CustomString;
  const aSel: TevPair;
  out theSel: TevPair): Boolean;
//#UC START# *50751B680376_50751AEF02A9_var*
var
 l_P : InevPara;
//#UC END# *50751B680376_50751AEF02A9_var*
begin
//#UC START# *50751B680376_50751AEF02A9_impl*
 Result := inherited DoCheckText(aPara, aText, aSel, theSel);
 if Result then
 begin
  if not aPara.QT(InevPara, l_P) then
   Assert(false);
  if (l_P.PID > 0) then
  begin
   Result := false;
   Exit;
  end;//l_P.PID > 0
  if (l_P.OwnerPara.PID > 0) then
  begin
   Result := false;
   Exit;
  end;//l_P.OwnerPara.PID > 0
  if (l_P.OwnerPara.OwnerPara.PID > 0) then
  begin
   Result := false;
   Exit;
  end;//l_P.OwnerPara.OwnerPara.PID > 0
 end;//Result
//#UC END# *50751B680376_50751AEF02A9_impl*
end;//TevFirstTableCellSearcher.DoCheckText
// start class TevOldNSRCFlagReplacer

class function TevOldNSRCFlagReplacer.Make(anOptions: TevSearchOptionSet = []): IevReplacer;
//#UC START# *507530F8022A_50751B080168_var*
var
 l_Replacer : TevOldNSRCFlagReplacer;
//#UC END# *507530F8022A_50751B080168_var*
begin
//#UC START# *507530F8022A_50751B080168_impl*
 l_Replacer := Create;
 try
  l_Replacer.f_FlagInit := False;
  l_Replacer.f_FlagValue := False;
  l_Replacer.Options := anOptions;
  l_Replacer.Text := '';
  Result := l_Replacer;
 finally
  FreeAndNil(l_Replacer);
 end;//try..finally
//#UC END# *507530F8022A_50751B080168_impl*
end;//TevOldNSRCFlagReplacer.Make

function TevOldNSRCFlagReplacer.ReplaceFunc(const aView: InevView;
  const Container: InevOp;
  const aBlock: InevRange): Boolean;
//#UC START# *4D553AC103A3_50751B080168_var*
var
 l_Table: Tl3Variant;
//#UC END# *4D553AC103A3_50751B080168_var*
begin
//#UC START# *4D553AC103A3_50751B080168_impl*
 if evInPara(aBlock.BottomChildBlock(aView).Obj^.AsObject, k2_typTable, [k2_typSBS], l_Table) then
 begin
  if not f_FlagInit then
  begin
   f_FlagValue := not l_Table.BoolA[k2_tiOldNSRC];
   f_FlagInit := True;
  end; // if not f_FlagInit then
  l_Table.BoolW[k2_tiOldNSRC, Container] := f_FlagValue;
 end; 
//#UC END# *4D553AC103A3_50751B080168_impl*
end;//TevOldNSRCFlagReplacer.ReplaceFunc
// start class TevTableCellFrameReplacer

class function TevTableCellFrameReplacer.Make(aFrame: Integer;
  anOptions: TevSearchOptionSet = []): IevReplacer;
//#UC START# *507531E0006E_50751B12004F_var*
var
 l_Replacer : TevTableCellFrameReplacer;
//#UC END# *507531E0006E_50751B12004F_var*
begin
//#UC START# *507531E0006E_50751B12004F_impl*
 l_Replacer := Create;
 try
  l_Replacer.Options := anOptions;
  l_Replacer.Text := '';
  l_Replacer.f_Frame := aFrame;
  Result := l_Replacer;
 finally
  FreeAndNil(l_Replacer);
 end;//try..finally
//#UC END# *507531E0006E_50751B12004F_impl*
end;//TevTableCellFrameReplacer.Make

function TevTableCellFrameReplacer.ReplaceFunc(const aView: InevView;
  const Container: InevOp;
  const aBlock: InevRange): Boolean;
//#UC START# *4D553AC103A3_50751B12004F_var*
var
 l_Cell : Tl3Variant;
//#UC END# *4D553AC103A3_50751B12004F_var*
begin
//#UC START# *4D553AC103A3_50751B12004F_impl*
 if evInPara(aBlock.BottomChildBlock(aView).Obj^.AsObject, k2_typTableCell, [k2_typSBSCell], l_Cell) then
 begin
  Result := true;
  l_Cell.IntW[k2_tiFrame, Container] := f_Frame;
 end//evInPara(aPara, k2_idTableCell, l_Cell)
 else
  Result := false;
//#UC END# *4D553AC103A3_50751B12004F_impl*
end;//TevTableCellFrameReplacer.ReplaceFunc
// start class TevTextInContinueCellSearcher

function TevTextInContinueCellSearcher.CheckCellType(aCell: Tl3Variant): Boolean;
//#UC START# *5075300802E0_50751F2001E9_var*
//#UC END# *5075300802E0_50751F2001E9_var*
begin
//#UC START# *5075300802E0_50751F2001E9_impl*
 Result := aCell.Attr[k2_tiMergeStatus].IsValid and (TevMergeStatus(aCell.IntA[k2_tiMergeStatus]) = ev_msContinue);
//#UC END# *5075300802E0_50751F2001E9_impl*
end;//TevTextInContinueCellSearcher.CheckCellType

end.