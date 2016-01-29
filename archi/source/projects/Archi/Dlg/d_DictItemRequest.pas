unit d_DictItemRequest;

{ $Id: d_DictItemRequest.pas,v 1.11 2015/07/02 07:34:41 lukyanets Exp $ }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, vtSpin,
  daTypes,
  dt_Types, dt_AttrSchema,
  vtLabel, Mask, vtCombo, vtDateEdit, l3Date;

type
  TDictItemRequest = class(TBottomBtnDlg)
    lblDictID: TLabel;
    edtDictID: TvtSpinEdit;
    lblBanner: TLabel;
    cbxAddBackEq: TCheckBox;
    sbItemList: TSpeedButton;
    labelDeleted: TvtLabel;
    comboDateDeleted: TComboBox;
    procedure sbItemListClick(Sender: TObject);
    procedure edtDictIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
   f_Dictionary : TdaDictionaryType;
  public
    { Public declarations }
  end;

 function DictItemRequest(    aOwner       : TComponent;
                              aDictionary  : TdaDictionaryType;
                          var aDictID      : Longint;
                          var aAddBackEq   : Boolean;
                              aDictIDLabel : String = '';
                              aCaption     : String = '';
                              aBanner      : String = '') : boolean; overload;

 function DictItemRequest(    aOwner       : TComponent;
                              aDictionary  : TdaDictionaryType;
                          var aDictID      : TDictID;
                              aDictIDLabel : String = '';
                              aCaption     : String = '';
                              aBanner      : String = '') : boolean; overload;

 function DictItemRequest(aOwner: TComponent; aDictionary: TdaDictionaryType; var aDictID: TDictID; var aDateDeleted: TstDate;
     aDictIDLabel: String = ''; aCaption: String = ''; aBanner: String = ''): boolean; overload;


implementation

{$R *.dfm}

Uses
 TreeDWin, DictMetaForm,
 l3TreeInterfaces, l3Tree_TLB,
 dt_Const, dt_Dict, IniShop, dt_DictConst;

 function DictItemRequest(aOwner: TComponent; aDictionary: TdaDictionaryType; var aDictID: TDictID; var aDateDeleted: TstDate;
     aDictIDLabel: String = ''; aCaption: String = ''; aBanner: String = ''): boolean;
 begin
  with TDictItemRequest.Create(aOwner) do
   try
    If aCaption <> ''     then Caption := aCaption;
    If aDictIDLabel <> '' then lblDictID.Caption := aDictIDLabel;
    If aBanner <> ''      then lblBanner.Caption := aBanner;
    //edtDictID
    f_Dictionary := aDictionary;
    cbxAddBackEq.Visible := False;
    labelDeleted.Visible:= True;
    comboDateDeleted.Visible:= True;
    Result := Execute;
    aDictID := edtDictID.AsInteger;
    if aDictID < 1 then aDictID := cUndefDictID;
    if comboDateDeleted.ItemIndex = 0 then
     aDateDeleted:= DateTimeTostDate(IniRec.NextVersionDate)
    else
     aDateDeleted:= DateTimeTostDate(IniRec.SecondVersionDate);
    //aAddBackEq := cbxAddBackEq.Checked;
   finally
    Free;
   end;

 end;

 function DictItemRequest(aOwner : TComponent; aDictionary : TdaDictionaryType; var aDictID : TDictID;  aDictIDLabel : String = ''; aCaption : String = ''; aBanner : String = ''): boolean;
 begin
  with TDictItemRequest.Create(aOwner) do
   try
    If aCaption <> ''     then Caption := aCaption;
    If aDictIDLabel <> '' then lblDictID.Caption := aDictIDLabel;
    If aBanner <> ''      then lblBanner.Caption := aBanner;
    //edtDictID
    f_Dictionary := aDictionary;
    cbxAddBackEq.Visible := False;

    Result := Execute;
    aDictID := edtDictID.AsInteger;
    if aDictID < 1 then aDictID := cUndefDictID;
    //aAddBackEq := cbxAddBackEq.Checked;
   finally
    Free;
   end;

 end;


 function DictItemRequest(    aOwner       : TComponent;
                              aDictionary  : TdaDictionaryType;
                          var aDictID      : Longint;
                          var aAddBackEq   : Boolean;
                              aDictIDLabel : String = '';
                              aCaption     : String = '';
                              aBanner      : String = '') : boolean;


 begin
  with TDictItemRequest.Create(aOwner) do
   try
    If aCaption <> ''     then Caption := aCaption;
    If aDictIDLabel <> '' then lblDictID.Caption := aDictIDLabel;
    If aBanner <> ''      then lblBanner.Caption := aBanner;
    f_Dictionary := aDictionary;
    //edtDictID
    Result := Execute;
    aDictID := TDictID(edtDictID.AsInteger);
    aAddBackEq := cbxAddBackEq.Checked;
   finally
    Free;
   end;
 end;

procedure TDictItemRequest.sbItemListClick(Sender: TObject);
begin
 with TTreeDesignerForm.Create(Application, CurrentFamily, f_DIctionary, dmShow) do
 try
  Caption := 'Выберите элемент-приемник';
  if Execute(nil, False, False) then
   edtDictID.AsInteger := (DictOutliner.CurrentCNode as Il3HandleNode).Handle;
 finally
  Free;
 end;  
end;

procedure TDictItemRequest.edtDictIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = VK_DOWN) and (ssAlt in Shift) then
  sbItemListClick(self)
 else
  inherited;
end;

end.
