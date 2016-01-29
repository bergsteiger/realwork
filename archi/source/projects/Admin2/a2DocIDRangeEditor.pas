unit a2DocIDRangeEditor;

{ $Id: a2DocIDRangeEditor.pas,v 1.11 2015/03/16 10:08:38 voba Exp $ }

// $Log: a2DocIDRangeEditor.pas,v $
// Revision 1.11  2015/03/16 10:08:38  voba
// - ��������� �������������� ����������
//
// Revision 1.10  2014/04/29 09:58:30  fireton
// - �� ����������
//
// Revision 1.9  2012/02/28 07:29:33  narry
// ���������� ��� ��������� � ���� (342330845)
//
// Revision 1.8  2012/02/28 07:00:58  narry
// ���������� ��� ��������� � ���� (342330845)
//
// Revision 1.7  2012/02/27 10:27:45  fireton
// - �������� ��� ID ��������
//
// Revision 1.6  2011/09/15 14:09:57  fireton
// - ��������� ��������� ����������
//
// Revision 1.5  2011/06/06 10:36:39  fireton
// - ��������� ��������� DocID �� "���������"
//
// Revision 1.4  2010/10/19 08:52:59  fireton
// - �� ������ ���� ������
//
// Revision 1.3  2008/11/10 14:27:31  fireton
// - ����� ������ VCM
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OvcBase,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmBase,
  vcmEntityForm,
  vcmEntities,
  vcmComponent,
  vcmBaseEntities,

  afwControl, afwInputControl, vtLister, afwControlPrim, afwBaseControl,
  DT_Types;

type
  TDocIDRangeEditor = class(TvcmEntityForm)
    lstRanges: TvtDStringLister;
    Label1: TLabel;
    btnAdd: TButton;
    btnDel: TButton;
    btnClose: TButton;
    cbIntervals: TComboBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure cbIntervalsSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    f_ResourceID: TTblNameStr;
    procedure LoadIntervalNames;
    procedure OnSelect;
    procedure ReloadRanges;
    { Private declarations }
  public
  end;

var
  DocIDRangeEditor: TDocIDRangeEditor;

implementation
uses
 l3Types,
 l3Base,
 l3RecList,
 l3String,

 dtIntf,
 dt_Const,
 dt_Err,
 dt_Serv,
 dt_Free,
 dt_Sab,
 dt_LinkServ,
 dt_Renum,
 
 a2RangeEditDlg;

{$R *.dfm}

const
 sErrorNoExclusiveAccess = '�� ������� �������� ������������ ������ � ����.';

type
 TDescRec = record
  rName: TTblNameStr;
  rDesc: string;
 end;

const
 {$IFDEF NB_FAS}
 cIntervalHi = 15;
 {$ELSE}
 cIntervalHi = 2;
 {$ENDIF}
 cNamedDocIDIntervals: array[0..cIntervalHi] of TDescRec = (
  (rName: ftnDocIDExternal; rDesc: '���������� �������� ��� ����� ����������'),
  //(rName: ftnObjIDExternal; rDesc: '��� ��������� �������'),
  (rName: ftnDocIDForLists; rDesc: '��� ��������� DocID ��� ��������� �������'),
  (rName: ftnImgHandle;     rDesc: '��� ID �������� � ������ ����������')
  {$IFDEF NB_FAS}
  ,
  (rName: ftnDocIDLawCase ; rDesc: '�������� ������� ��� ������������� ��'),
  (rName: ftnDocIDVAS;      rDesc: '�������� ������� ��� ������������� ���'),
  (rName: ftnDocID1st;      rDesc: '��������� ����� ������ ���������'),
  (rName: ftnDocIDFAS1;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS2;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS3;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS4;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS5;     rDesc: '��� ��'),
  (rName: ftnDocIDFAS6;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS7;     rDesc: '��� ��'),
  (rName: ftnDocIDFAS8;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS9;     rDesc: '��� ���'),
  (rName: ftnDocIDFAS10;    rDesc: '��� ��')
  {$ENDIF}
 );

procedure TDocIDRangeEditor.btnAddClick(Sender: TObject);
var
 l_Free: TFreeTbl;
 l_Sab : ISab;
begin
 with TRangeEditDlg.Create(Self) do
 try
  if ShowModal = mrOK then
  begin
   l_Free := GlobalHtServer.FreeTbl[CurrentFamily];
   l_Free.AddInterval(f_ResourceID, ValueFrom, ValueTo);
   // "������" �������� �� �������, ��� ������� �����������
   l_Sab := MakeAllRecords(LinkServer(CurrentFamily).Renum);
   l_Sab.ValuesOfKey(rnImportID_fld);
   l_Free.ExcludeFreeNumsFromTable(f_ResourceID, l_Sab);
   ReloadRanges;
  end;
 finally
  Free;
 end;
end;

procedure TDocIDRangeEditor.btnDelClick(Sender: TObject);
var
 l_Free: TFreeTbl;
begin
 with TRangeEditDlg.Create(Self) do
 try
  if ShowModal = mrOK then
  begin
   l_Free := GlobalHtServer.FreeTbl[CurrentFamily];
   l_Free.ExclusiveUse := True;
   try
    try
     l_Free.ExcludeFreeNumsFromTable(f_ResourceID, ValueFrom, ValueTo);
    finally
     l_Free.ExclusiveUse := False;
    end;
    ReloadRanges;
   except
    on E: EHtErrors_LockTblError do
    begin
     l3System.Stack2Log('������ ��� �������� ��������� ID-�������!');
     MessageDlg(l3CStr(sErrorNoExclusiveAccess), mtError);
    end
    else
     raise;
   end;
  end;
 finally
  Free;
 end;
end;

procedure TDocIDRangeEditor.cbIntervalsSelect(Sender: TObject);
begin
 OnSelect;
end;

procedure TDocIDRangeEditor.ReloadRanges;
var
 l_RList: Tl3RecList;

 function Iterator(Data: Pointer; Index: Long): Bool; register;
 var
  l_Data: PFreeRangeRec;
 begin
  Result := True;
  l_Data := PFreeRangeRec(Data^);
  if l_Data.rTo <> 0 then
   lstRanges.Items.AddStr(Format('%d - %d', [l_Data.rFrom, l_Data.rTo]))
  else
   lstRanges.Items.AddStr(Format('%d', [l_Data.rFrom]))
 end;

begin
 lstRanges.Items.Clear;
 Screen.Cursor := crHourGlass;
 try
  l_RList := GlobalHtServer.FreeTbl[CurrentFamily].GetIntervalList(f_ResourceID);
  if Assigned(l_RList) then
  try
   l_RList.IterateAllF(l3L2IA(@Iterator))
  finally
   l3Free(l_RList);
  end;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocIDRangeEditor.FormCreate(Sender: TObject);
begin
 LoadIntervalNames;
end;

procedure TDocIDRangeEditor.LoadIntervalNames;
var
 I: Integer;
begin
 cbIntervals.Items.Clear;
 for I := 0 to High(cNamedDocIDIntervals) do
  cbIntervals.Items.Add(cNamedDocIDIntervals[I].rDesc);
 cbIntervals.ItemIndex := 0;
 OnSelect;
end;

procedure TDocIDRangeEditor.OnSelect;
begin
 f_ResourceID := cNamedDocIDIntervals[cbIntervals.ItemIndex].rName;
 ReloadRanges;
end;

end.
