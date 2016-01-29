unit D_SrcChk;

{ $Id: D_SrcChk.pas,v 1.16 2015/10/02 09:23:33 lukyanets Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask,
  k2Interfaces, k2Tags,
  DT_Types, DT_Const, DT_DictTypes, DT_User, DT_Serv,
  BottomBtnDlg, vtCombo, vtDateEdit,
  
  l3Variant
  ;

type
  TSrcCheckDlg = class(TBottomBtnDlg)
    cbSource: TComboBox;
    cbUser: TComboBox;
    edtDate: TvtDateEdit;
    edtComment: TEdit;
    Bevel3: TBevel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel5: TBevel;
    Label1: TLabel;
    Bevel6: TBevel;
    Label4: TLabel;
    cbType: TComboBox;
    Bevel2: TBevel;
    Label5: TLabel;
  private
    { Private declarations }
    fDocFam : TFamilyID;
  public
    { Public declarations }
    function Execute(aDocFam : TFamilyID; aRec : Tl3Tag;
                     WasEmpty : Boolean) : Boolean; reintroduce;
  end;

implementation

{$R *.DFM}

uses
  l3String,
  l3Date,
  daDataProvider
  , dt_DictConst;


{  TCorrectDictRec = Record
                     ID     : Longint;
                     Date   : TStDate;
                     Sour   : TDictID;
                     Typ    : TCorType;
                     Author : TDictID;
                     Coment : Array[1..70] of Char;
                    end;
}

function TSrcCheckDlg.Execute(aDocFam : TFamilyID;
                              aRec : Tl3Tag; WasEmpty : Boolean) : Boolean;
 begin
  fDocFam := aDocFam;
  UserManager.UserTbl.GetDictList(cbUser.Items, False);
  if WasEmpty then
  begin
   //aRec.ID := cUndefDictID;
   edtDate.Date := Now; //StDatetoDateTime(CurrentDateDate);
   cbType.ItemIndex := 0; //cbType.IndexOfObject(Pointer(Typ));
   //cbSource.ItemIndex := cbSource.Items.IndexOfObject(Pointer(Sour));
   cbUser.ItemIndex := cbUser.Items.IndexOfObject(Pointer(GlobalDataProvider.UserID));
   //edtComment.Text    := ArrayToString(Coment, SizeOf(Coment));
   //fSourID := Sour;
  end
  else
   with aRec do
   begin
    if Date <> BlankDate then edtDate.StDate := IntA[k2_tiStart];
    cbType  .ItemIndex := Pred(IntA[k2_tiType]); //cbType.IndexOfObject(Pointer(Typ));

    cbSource.ItemIndex := cbSource.Items.IndexOfObject(Pointer(IntA[k2_tiSource]));

    with Attr[k2_tiUser] do
     if IsValid and (IntA[k2_tiHandle] <> 0) then
     cbUser.ItemIndex := cbUser.Items.IndexOfObject(Pointer(IntA[k2_tiHandle]));
    edtComment.Text    := StrA[k2_tiComment];
    //fSourID := Sour;
   end;

  Result := ShowModal = mrOk;
  If Result then
   with aRec do
    begin
     AttrW[k2_tiName, nil] := nil;
     IntA[k2_tiStart] := StDateToDemon(edtDate.StDate);
     IntA[k2_tiType] := Succ(cbType.ItemIndex);

     if cbSource.ItemIndex >= 0 then
      IntA[k2_tiSource] := TDictID(cbSource.Items.Objects[cbSource.ItemIndex])
     else
      IntA[k2_tiSource] := 0;

     if cbUser.ItemIndex >= 0 then
      CAtom(k2_tiUser).IntA[k2_tiHandle] := Integer(cbUser.Items.Objects[cbUser.ItemIndex])
     else
      AttrW[k2_tiUser, nil] := nil;

     StrA[k2_tiComment] := edtComment.Text;
     //Sour  := fSourID;
    end;
 end;

end.
