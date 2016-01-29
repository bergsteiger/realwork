unit DShowEQI;

{ $Id: DSHOWEQI.pas,v 1.15 2015/07/02 11:41:02 lukyanets Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RightBtnDlg, OvcBase, vtlister, StdCtrls, Buttons, ExtCtrls,
  RBtnDlg,  ComCtrls, vtStatusBar, afwControlPrim, afwBaseControl,
  afwControl, afwInputControl;

type
  TDShowEq = class(TRightBtnDlg)
    ItemList: TvtDStringlister;
    ListFooter: TvtStatusBar;
    procedure ItemListCurrentChanged(Sender: TObject; aNewCurrent: Integer ;
        aOldCurrent: Integer);
    procedure ItemListActionElement(Sender: TObject; Index: Longint);
    procedure OKClick(Sender: TObject);
    function ItemListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
    //procedure OKBtnClick(Sender: TObject);
  private
    fSelectIndex : Longint;
  public
    constructor Create(aOwner: TComponent); reintroduce;
    function Execute(var aSelectIndex : Longint) : Boolean;
  end;

implementation

{$R *.DFM}
Uses
 DT_Types,
 dt_AttrSchema, DictMetaForm, DictsSup, ResShop;

function TDShowEq.Execute(var aSelectIndex : Longint) : Boolean;
 begin
  fSelectIndex := -1;
  Result := (ShowModal = mrOk) and (fSelectIndex >= 0);
  aSelectIndex := fSelectIndex;
 end;

procedure TDShowEq.ItemListCurrentChanged(Sender: TObject; aNewCurrent: Integer ; aOldCurrent: Integer);
 begin
  ListFooter.Panels[0].Text := Format('%d из %d', [Succ(aNewCurrent),ItemList.Total]);
 end;

procedure TDShowEq.ItemListActionElement(Sender: TObject; Index: Longint);
 begin
  ModalResult := mrOk;
  fSelectIndex := ItemList.Items.DataInt[Index];
 end;

procedure TDShowEq.OKClick(Sender: TObject);
 begin
  Try
   fSelectIndex := ItemList.Items.DataInt[ItemList.Current];
  except
   fSelectIndex := -1;
  end;
 end;

function TDShowEq.ItemListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
 begin
  If (Index < 0) or ((ItemList.Items.Flags[Index] and $8000) = 0)
   then Result := picOneWay
   else Result := picTwoWay;
 end;
constructor TDShowEq.Create(aOwner: TComponent);
begin
 inherited;
 if aOwner is TDictMetaForm then

  //Caption := 'Ёквивалентные ' + AnsiLowerCase(GetAttrName(DLType2AttrID(TdaDictionaryType((aOwner as TDictMetaForm).DictID))));
  Caption := 'Ёквивалентные ' + AnsiLowerCase(GetDictName((aOwner as TDictMetaForm).DictID));
end;

end.
