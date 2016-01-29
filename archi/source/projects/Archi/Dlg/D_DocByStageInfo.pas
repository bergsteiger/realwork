unit D_DocByStageInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, OvcBase,  vtlister,
  Dt_Types, DT_Const, afwControl, afwInputControl, afwControlPrim,
  afwBaseControl;

type
  TDocByStageInfoDlg = class(TBottomBtnDlg)
    InfoLister: TvtDStringlister;
    procedure FormDestroy(Sender: TObject);
    procedure InfoListerSelectChanged(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
  private
    { Private declarations }
  public
    function Execute(aFamily : TFamilyID) : boolean; reintroduce;
  end;

 const
  dbsStatStageSeq : array [0..5] of TStageType = (stInput, stRead, stEdit, stUrObr, stClass, stFinUrObr{stKW,stORead, stOEdit});


implementation

{$R *.DFM}

Uses
 l3Base,
 l3Types,
 DT_Stage,
 DT_Query,
 DT_SrchQueries;

function TDocByStageInfoDlg.Execute(aFamily : TFamilyID) : boolean;
var
 I                  : Integer;
 l_NonIncludedQuery : TdtQuery;
 l_SumQuery         : TdtIDListQuery;
 l_Q                : TdtQuery;
 l_StageQuery       : TdtQuery;
begin
 //InfoLister.SetTabStops([-350{, -100}]);
 InfoLister.Items.DataSize := 4;
 InfoLister.Items.NeedAllocStr := True;

 l_NonIncludedQuery := TdtAndQuery.Create; // список текстовых неподключенных документов (фильтровать по нему будем)
 try
  l_Q := TdtDocTypeFilterQuery.Create;
  TdtDocTypeFilterQuery(l_Q).DocTypeFilter := [dtText];
  TdtAndQuery(l_NonIncludedQuery).AddQueryF(l_Q);
  l_Q := SQDocOnDoneState(cNotDone);
  TdtAndQuery(l_NonIncludedQuery).AddQueryF(l_Q);

  l_SumQuery := TdtIDListQuery.Create;
  Screen.Cursor:=crHourGlass;
  try
   for I := Pred(SizeOf(dbsStatStageSeq)) downto 1 do
   begin
    l_StageQuery := TdtAndQuery.Create;
    try
     l_Q := TdtStageQuery.Create(BlankDate, BlankDate, dbsStatStageSeq[Pred(I)], stfFinished);
     TdtAndQuery(l_StageQuery).AddQueryF(l_Q);
     TdtAndQuery(l_StageQuery).AddQuery(l_NonIncludedQuery);
     if not l_SumQuery.IsEmpty then
     begin
      l_Q := TdtNOTQuery.Create;
      TdtNOTQuery(l_Q).SubQuery := l_SumQuery;
      TdtAndQuery(l_StageQuery).AddQueryF(l_Q);
     end;
     // превращаем результат запроса в список ID
     SQ2IDList(l_StageQuery);
     l_SumQuery.MergeWith(l_StageQuery, l3_boOr);
     // добавляем в список
     InfoLister.Items.Add(PAnsiChar(Format('%s'#9'%d', [StageNameByID(dbsStatStageSeq[I]),
        l_StageQuery.FoundList.Count])), @l_StageQuery);
    except
     l3Free(l_StageQuery);
     raise;
    end;
   end;
  finally
   Screen.Cursor:=crDefault;
   l3Free(l_SumQuery);
  end;
 finally
  l3Free(l_NonIncludedQuery);
 end;

 Result := ShowModal = mrOk;
end;

procedure TDocByStageInfoDlg.FormDestroy(Sender: TObject);
 var
  I : Integer;
 begin
  For I := 0 to Pred(InfoLister.Items.Count) do
   TdtQuery(InfoLister.Items.DataInt[I]).Free;
 end;

procedure TDocByStageInfoDlg.InfoListerSelectChanged(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
  inherited;
  Ok.Enabled := InfoLister.SelectedCount > 0;
end;

end.




