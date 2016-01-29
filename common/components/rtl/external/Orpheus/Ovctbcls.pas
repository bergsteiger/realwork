{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCTBCLS.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTBCls;
  {-Table column, column array classes}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages, DIALOGS,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcMisc, OvcData, OvcConst, OvcBase, OvcCmd,
  OvcTCmmn, OvcSpAry, OvcTCell

  ,
  l3ProtoObject
  ;

type
  TOvcTableColumnClass = class of TOvcTableColumn;
  TOvcTableColumn = class(TPersistent)
    protected {private}
      {.Z+}
      {property fields-even size}
      FDefCell  : TOvcBaseTableCell;
      FNumber   : TColNum;
      FOnColumnChanged : TColChangeNotifyEvent;
      FTable    : TOvcTableAncestor;
      FWidth    : Integer;
      {property fields-odd size}
      FHidden   : boolean;
      Filler    : byte;
      {.Z-}

    protected
      {.Z+}
      {property access}
      procedure SetDefCell(BTC : TOvcBaseTableCell);
      procedure SetHidden(H : boolean);
      procedure SetWidth(W : Integer);

      {miscellaneous}
      procedure tcDoColumnChanged;
      procedure tcNotifyCellDeletion(Cell : TOvcBaseTableCell);

    public {protected}
      {internal only usage}
      property Number : TColNum
         read FNumber write FNumber;
      property OnColumnChanged : TColChangeNotifyEvent
         write FOnColumnChanged;

    public
      procedure Assign(Source : TPersistent); override;
      constructor Create(ATable : TOvcTableAncestor); virtual;
      destructor Destroy; override;
      {.Z-}

      {properties}
      property Table : TOvcTableAncestor
         read FTable;

    published
      {properties for streaming}
      property DefaultCell: TOvcBaseTableCell
         read FDefCell write SetDefCell;

      property Hidden : boolean
        read FHidden write SetHidden
        default False;

      property Width  : Integer
         read FWidth write SetWidth
         default tbDefColWidth;
  end;

  TOvcTableColumns = class(Tl3ProtoObject)
    protected {private}
      {.Z+}
      {property fields}
      FList   : TList;
      FOnColumnChanged: TColChangeNotifyEvent;
      FFixups : TStringList;
      FTable  : TOvcTableAncestor;

      {other fields}
      tcColumnClass : TOvcTableColumnClass;
      {.Z-}

    protected
      {.Z+}
      {property access}
      function GetCol(ColNum : TColNum) : TOvcTableColumn;
      function GetCount : Integer;
      function GetDefaultCell(ColNum : TColNum) : TOvcBaseTableCell;
      function GetHidden(ColNum : TColNum) : boolean;
      function GetWidth(ColNum : TColNum) : Integer;

      procedure SetCol(ColNum : TColNum; C : TOvcTableColumn);
      procedure SetCount(C : Integer);
      procedure SetDefaultCell(ColNum : TColNum; C : TOvcBaseTableCell);
      procedure SetHidden(ColNum : TColNum; H : boolean);
      procedure SetWidth(ColNum : TColNum; W : Integer);

      {event access}
      procedure SetOnColumnChanged(OC : TColChangeNotifyEvent);

      {other}
      procedure tcDoColumnChanged(ColNum1, ColNum2 : TColNum;
                                  Action : TOvcTblActions);
      {.Z-}

    public {protected}
      {.Z+}
      {internal only usage}
      procedure tcNotifyCellDeletion(Cell : TOvcBaseTableCell);
      function tcStartLoading : TStringList;
      procedure tcStopLoading;

      property OnColumnChanged : TColChangeNotifyEvent
         write SetOnColumnChanged;
      {.Z-}

    public
      constructor Create(ATable : TOvcTableAncestor; ANumber : Integer;
                         AColumnClass : TOvcTableColumnClass);
      procedure Cleanup; override;

      procedure Append(C : TOvcTableColumn);
      procedure Clear;
      procedure Delete(ColNum : TColNum);
      procedure Exchange(ColNum1, ColNum2 : TColNum);
      procedure Insert(const ColNum : TColNum; C : TOvcTableColumn);

      property Count : Integer
         read GetCount write SetCount;

      property DefaultCell [ColNum : TColNum] : TOvcBaseTableCell
         read GetDefaultCell write SetDefaultCell;

      property Hidden [ColNum : TColNum] : boolean
         read GetHidden write SetHidden;

      property List [ColNum : TColNum] : TOvcTableColumn
         read GetCol write SetCol;
         default;

      property Table : TOvcTableAncestor
         read FTable write FTable;

      property Width [ColNum : TColNum] : Integer
         read GetWidth write SetWidth;
  end;

implementation


{===TOvcTableColumn=====================================================}
constructor TOvcTableColumn.Create(ATable : TOvcTableAncestor);
  begin
    inherited Create;
    FWidth := tbDefColWidth;
    FDefCell := nil;
    FTable := ATable;
  end;
{--------}
destructor TOvcTableColumn.Destroy;
  begin
    DefaultCell := nil;
    inherited Destroy;
  end;
{--------}
procedure TOvcTableColumn.Assign(Source : TPersistent);
  var
    Src : TOvcTableColumn absolute Source;
  begin
    if not (Source is TOvcTableColumn) then
      Exit;
    FWidth := Src.Width;
    FHidden := Src.Hidden;
    DefaultCell := Src.DefaultCell;
  end;
{--------}
procedure TOvcTableColumn.tcDoColumnChanged;
  begin
    if Assigned(FOnColumnChanged) then
      FOnColumnChanged(Self, FNumber, 0, taSingle);
  end;
{--------}
procedure TOvcTableColumn.tcNotifyCellDeletion(Cell : TOvcBaseTableCell);
  begin
    if (Cell = FDefCell) then
      DefaultCell := nil;
  end;
{--------}
procedure TOvcTableColumn.SetDefCell(BTC : TOvcBaseTableCell);
  var
    DoIt : boolean;
  begin
    DoIt := false;
    if (BTC <> FDefCell) then
      if Assigned(BTC) then
        begin
          if (BTC.References = 0) or
             ((BTC.References > 0) and (BTC.Table = FTable)) then
            DoIt := true;
        end
      else
        DoIt := true;

    if DoIt then
      begin
        if Assigned(FDefCell) then
          FDefCell.DecRefs;
        FDefCell := BTC;
        if Assigned(FDefCell) then
          begin
            if (FDefCell.References = 0) then
              FDefCell.Table := FTable;
            FDefCell.IncRefs;
          end;
        tcDoColumnChanged;
      end;
  end;
{--------}
procedure TOvcTableColumn.SetHidden(H : boolean);
  begin
    if (H <> FHidden) then
      begin
        FHidden := H;
        tcDoColumnChanged;
      end;
  end;
{--------}
procedure TOvcTableColumn.SetWidth(W : Integer);
  begin
    if (W <> FWidth) then
      begin
        FWidth := W;
        tcDoColumnChanged;
      end;
  end;
{====================================================================}



{===TOvcTableColumns=======================================================}
constructor TOvcTableColumns.Create(ATable : TOvcTableAncestor;
                                    ANumber : Integer;
                                    AColumnClass : TOvcTableColumnClass);
  var
    i : Integer;
    Col : TOvcTableColumn;
  begin
    inherited Create;
    FTable := ATable;
    FList := TList.Create;
    tcColumnClass := AColumnClass;
    for i := 0 to pred(ANumber) do
      begin
        Col := AColumnClass.Create(FTable);
        Col.Number := i;
        Append(Col);
      end;
  end;
{--------}
procedure TOvcTableColumns.Cleanup;
  begin
    if Assigned(FList) then
      begin
        OnColumnChanged := nil;                                 {!!.11}
        Clear;
        FreeAndNil(FList);
      end;
    FreeAndNil(FFixups);
    inherited;
  end;
{--------}
procedure TOvcTableColumns.Append(C : TOvcTableColumn);
  begin
    if (FList.Count = Classes.MaxListSize) then
      TableErrorRes(SCTableMaxColumns);
    if (C.Table <> FTable) or (not (C is tcColumnClass)) then
      Exit;
    C.Number := FList.Count;
    FList.Add(C);
    C.OnColumnChanged := FOnColumnChanged;
    tcDoColumnChanged(C.Number, 0, taInsert);
  end;
{--------}
procedure TOvcTableColumns.Clear;
  var
    i : Integer;
  begin
    for i := 0 to pred(FList.Count) do
      TOvcTableColumn(FList[i]).Free;
    FList.Clear;
    tcDoColumnChanged(0, 0, taAll);
  end;
{--------}
procedure TOvcTableColumns.Delete(ColNum : TColNum);
  var
    i : integer;
  begin
    if (0 <= ColNum) and (ColNum < FList.Count) then
      begin
        TOvcTableColumn(FList[ColNum]).Free;
        FList.Delete(ColNum);
        for i := 0 to pred(FList.Count) do
          TOvcTableColumn(FList[i]).Number := i;
        tcDoColumnChanged(ColNum, 0, taDelete);
        if Assigned(FFixups) then                              {!!.16}
          if (ColNum < FFixups.Count) then                     {!!.16}
            FFixups.Delete(ColNum);                            {!!.16}
      end;
  end;
{--------}
procedure TOvcTableColumns.Exchange(ColNum1, ColNum2 : TColNum);
  var
    Temp1, Temp2 : pointer;
  begin
    if (ColNum1 <> ColNum2) and
       (0 <= ColNum1) and (ColNum1 < FList.Count) and
       (0 <= ColNum2) and (ColNum2 < FList.Count) then
      begin
        Temp1 := FList[ColNum1];
        Temp2 := FList[ColNum2];
        TOvcTableColumn(Temp1).Number := ColNum2;
        TOvcTableColumn(Temp2).Number := ColNum1;
        FList[ColNum1] := Temp2;
        FList[ColNum2] := Temp1;
        tcDoColumnChanged(ColNum1, ColNum2, taExchange);
      end;
  end;
{--------}
function TOvcTableColumns.GetCol(ColNum : TColNum) : TOvcTableColumn;
  begin
    if (0 <= ColNum) and (ColNum < FList.Count) then
      Result := TOvcTableColumn(FList[ColNum])
    else
      Result := nil;
  end;
{--------}
function TOvcTableColumns.GetCount : Integer;
  begin
    Result := FList.Count;
  end;
{--------}
function TOvcTableColumns.GetDefaultCell(ColNum : TColNum) : TOvcBaseTableCell;
  begin
    Result := nil;
    if (0 <= ColNum) and (ColNum < FList.Count) then
      Result := TOvcTableColumn(FList[ColNum]).DefaultCell;
  end;
{--------}
function TOvcTableColumns.GetHidden(ColNum : TColNum) : boolean;
  begin
    Result := True;
    if (0 <= ColNum) and (ColNum < FList.Count) then
      Result := TOvcTableColumn(FList[ColNum]).Hidden;
  end;
{--------}
function TOvcTableColumns.GetWidth(ColNum : TColNum) : Integer;
  begin
    Result := 0;
    if (0 <= ColNum) and (ColNum < FList.Count) then
      Result := TOvcTableColumn(FList[ColNum]).Width;
  end;
{--------}
procedure TOvcTableColumns.Insert(const ColNum : TColNum;
                                  C : TOvcTableColumn);
  var
    i : integer;
  begin
    if (FList.Count = Classes.MaxListSize) then
      TableErrorRes(SCTableMaxColumns);
    if (C.Table <> FTable) or (not (C is tcColumnClass)) then
      Exit;
    if (0 <= ColNum) and (ColNum < FList.Count) then
      begin
        FList.Insert(ColNum, C);
        for i := 0 to pred(FList.Count) do
          TOvcTableColumn(FList[i]).Number := i;
        C.OnColumnChanged := FOnColumnChanged;
        tcDoColumnChanged(ColNum, 0, taInsert);
        if Assigned(FFixups) then begin                        {!!.16}
          FFixups.Insert(ColNum, 'unknown');                   {!!.16}
          FFixups.Objects[ColNum] := C;                        {!!.16}
        end;                                                   {!!.16}
      end;
  end;
{--------}
procedure TOvcTableColumns.tcDoColumnChanged(ColNum1, ColNum2 : TColNum;
                                             Action : TOvcTblActions);
  begin
    if Assigned(FOnColumnChanged) then
      FOnColumnChanged(Self, ColNum1, ColNum2, Action);
  end;
{--------}
procedure TOvcTableColumns.tcNotifyCellDeletion(Cell : TOvcBaseTableCell);
  var
    ColNum : TColNum;
  begin
    for ColNum := 0 to pred(FList.Count) do
      TOvcTableColumn(FList[ColNum]).tcNotifyCellDeletion(Cell);
  end;
{--------}
procedure TOvcTableColumns.SetCol(ColNum : TColNum; C : TOvcTableColumn);
  var
    PC : TOvcTableColumn;
  begin
    if (C.Table <> FTable) or (not (C is tcColumnClass)) then
      Exit;
    if (0 <= ColNum) and (ColNum < FList.Count) then
      begin
        PC := GetCol(ColNum);
        PC.Assign(C);
      end;
  end;
{--------}
procedure TOvcTableColumns.SetCount(C : Integer);
  var
    ColNum : TColNum;
    Col : TOvcTableColumn;
  begin
    if (C > 0) and (C <> Count) then
      if (C < Count) then
        begin
          {must destroy the end set of columns}
          for ColNum := pred(Count) downto C do
            Delete(ColNum);
        end
      else {C > Count}
        begin
          {must add some new columns on the end}
          for ColNum := Count to pred(C) do
            begin
              Col := tcColumnClass.Create(FTable);
              Col.Number := ColNum;
              Append(Col);
            end;
        end;
  end;
{--------}
procedure TOvcTableColumns.SetDefaultCell(ColNum : TColNum; C : TOvcBaseTableCell);
  begin
    if (0 <= ColNum) and (ColNum < FList.Count) then
      TOvcTableColumn(FList[ColNum]).DefaultCell := C;
  end;
{--------}
procedure TOvcTableColumns.SetHidden(ColNum : TColNum; H : boolean);
  begin
    if (0 <= ColNum) and (ColNum < FList.Count) then
      TOvcTableColumn(FList[ColNum]).Hidden := H;
  end;
{--------}
procedure TOvcTableColumns.SetOnColumnChanged(OC : TColChangeNotifyEvent);
  var
    i : Integer;
  begin
    FOnColumnChanged := OC;
    for i := 0 to pred(FList.Count) do
      TOvcTableColumn(FList[i]).OnColumnChanged := OC;
  end;
{--------}
procedure TOvcTableColumns.SetWidth(ColNum : TColNum; W : Integer);
  begin
    if (0 <= ColNum) and (ColNum < FList.Count) then
      TOvcTableColumn(FList[ColNum]).Width := W;
  end;
{--------}
function TOvcTableColumns.tcStartLoading : TStringList;
  begin
    if Assigned(FFixups) then
      FFixups.Clear
    else
      FFixups := TStringList.Create;
    Result := FFixups;
  end;
{--------}
procedure TOvcTableColumns.tcStopLoading;
  {------}
  function GetImmediateParentForm(Control : TControl) : TForm;
    var
      ParentCtrl : TControl;
    begin
      ParentCtrl := Control.Parent;
      while Assigned(ParentCtrl) and (not (ParentCtrl is TForm)) do
        ParentCtrl := ParentCtrl.Parent;
      Result := TForm(ParentCtrl);
    end;
  {------}
  function GetFormName(const S, FormName : string) : string;
    var
      PosDot : integer;
    begin
      PosDot := Pos('.', S);
      if (PosDot <> 0) then
        Result := Copy(S, 1, pred(PosDot))
      else
        Result := FormName;
    end;
  {------}
  function FormNamesEqual(CmptFormName, FormName : string) : boolean;{!!.01}
    var
      PosUL : integer;
    begin
      Result := true;
      if (FormName = '') or (CmptFormName = FormName) then
        Exit;
      PosUL := length(FormName);
      while (PosUL > 0) and (FormName[PosUL] <> '_') do
        dec(PosUL);
      if (PosUL > 0) then
        if (CmptFormName = Copy(FormName, 1, pred(PosUL))) then
          Exit;
      Result := false;
    end;
  {------}
  function GetComponentName(const S : string) : string;
    var
      PosDot : integer;
    begin
      PosDot := Pos('.', S);
      if (PosDot <> 0) then
        Result := Copy(S, succ(PosDot), length(S))
      else
        Result := S;
    end;
  {------}
  var
    i      : integer;
    Form   : TForm;
    Compnt : TComponent;
    {$IFDEF Win32}
    DM     : integer;
    DataMod: TDataModule;
    DMCount: integer;
    {$ENDIF}
  begin
    {if there's nothing to fix up, exit now}
    if not Assigned(FFixups) then
      Exit;
    {fixup references to cell components on the table's form}
    try
      Form := GetImmediateParentForm(FTable);
      for i := pred(FFixups.Count) downto 0 do
        if FormNamesEqual(GetFormName(FFixups[i], Form.Name),
                          Form.Name) then                       {!!.01}
          begin
            Compnt := Form.FindComponent(GetComponentName(FFixups[i]));
            if Assigned(Compnt) and (Compnt is TOvcBaseTableCell) then
              begin
                TOvcTableColumn(FFixups.Objects[i]).DefaultCell := TOvcBaseTableCell(Compnt);
                FFixups.Delete(i);
              end;
          end;
    {$IFDEF Win32}
    {fixup references to cell components on any data modules}
    if (FFixups.Count <> 0) then
      begin
        DM := 0;
        DMCount := Screen.DataModuleCount;
        while (FFixups.Count > 0) and (DM < DMCount) do
          begin
            DataMod := Screen.DataModules[DM];
            for i := pred(FFixups.Count) downto 0 do
              if (GetFormName(FFixups[i], Form.Name) = DataMod.Name) then
                begin
                  Compnt := DataMod.FindComponent(GetComponentName(FFixups[i]));
                  if Assigned(Compnt) and (Compnt is TOvcBaseTableCell) then
                    begin
                      TOvcTableColumn(FFixups.Objects[i]).DefaultCell := TOvcBaseTableCell(Compnt);
                      FFixups.Delete(i);
                    end;
                end;
            inc(DM);
          end;
      end;
    {$ENDIF}
    finally
      FreeAndNil(FFixups);
    end;
  end;
{====================================================================}

end.