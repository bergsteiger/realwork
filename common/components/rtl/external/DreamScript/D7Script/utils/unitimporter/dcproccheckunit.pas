{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCProcCheckUnit;

{$I DC.inc}

interface

uses
  StdCtrls, Buttons, Classes, Controls, ExtCtrls, Forms, Dialogs, Menus,

  DCButtonPanel, DCImageListBox, DCConsts, UnitPars,
  DCImportConsts, ComCtrls;

type
  TDCTopicsCheckForm = class(TForm)
    DCButtonPanel1: TDCButtonPanel;
    CancelBtn: TBitBtn;
    ResumeBtn: TBitBtn;
    ContextPopup: TPopupMenu;
    SelectAllItem: TMenuItem;
    UnselectAllItem: TMenuItem;
    TopicsPages: TPageControl;
    ProceduresSheet: TTabSheet;
    ProcHeaderPanel: TPanel;
    ProceduresList: TDCCheckImageListBox;
    TypesSheet: TTabSheet;
    ClassesSheet: TTabSheet;
    TypeHeaderPanel: TPanel;
    TypesList: TDCCheckImageListBox;
    ClassHeaderPanel: TPanel;
    ClassesList: TDCCheckImageListBox;
    VariablesSheet: TTabSheet;
    VarHeaderPanel: TPanel;
    VariablesList: TDCCheckImageListBox;
    ConstsSheet: TTabSheet;
    Splitter: TSplitter;
    PropsPages: TPageControl;
    PropertiesSheet: TTabSheet;
    MethodsSheet: TTabSheet;
    PropertiesHeaderPanel: TPanel;
    PropertiesList: TDCCheckImageListBox;
    MethodsHeaderPanel: TPanel;
    MethodsList: TDCCheckImageListBox;
    ConstsHeaderPanel: TPanel;
    ConstantsList: TDCCheckImageListBox;
    N1: TMenuItem;
    Selectallallpages1: TMenuItem;
    Unselectallallpages1: TMenuItem;
    procedure CancelBtnClick(Sender: TObject);
    procedure SelectAllItemClick(Sender: TObject);
    procedure UnselectAllItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClassesListSelectionChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TopicsPagesChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ResumeBtnClick(Sender: TObject);
    procedure Selectallallpages1Click(Sender: TObject);
    procedure Unselectallallpages1Click(Sender: TObject);
  private
    FOldSelection : Integer;

    Procedure SaveSelection( ASavingItem : Integer );
    function GetActiveItems:TDCCheckImageListBox;
  public
    Constructor Create( AOwner : TComponent ); override;
  end;

{------------------------------------------------------------------}

  pDCArrayOfByte = ^TDCArrayOfByte;
  TDCArrayOfByte = Array[ 0 .. 1 ] Of Byte;

  pDCClassPropsInfo = ^TDCClassPropsInfo;
  TDCClassPropsInfo = Record
    ClassInfo   : pTypeDeclInfo;
    TopicChecks : TDCArrayOfByte;
  End;

{------------------------------------------------------------------}

implementation

{$R *.DFM}

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.CancelBtnClick( Sender : TObject );
begin
  Close;
end;

{------------------------------------------------------------------}

Constructor TDCTopicsCheckForm.Create(AOwner: TComponent);
begin
  Inherited;
  FOldSelection := -1;
  TopicsPages.ActivePage := ProceduresSheet;
  PropsPages.ActivePage  := PropertiesSheet; 

  Caption := sDCTopicsCheckFormCaption;
  ProcHeaderPanel.Caption   := '   ' + sDCProcCheckHeader;
  TypeHeaderPanel.Caption   := '   ' + sDCTypeCheckHeader;
  ClassHeaderPanel.Caption  := '   ' + sDCClassCheckHeader;
  VarHeaderPanel.Caption    := '   ' + sDCVarCheckHeader;
  ConstsHeaderPanel.Caption := '   ' + sDCConstsCheckHeader;
  PropertiesHeaderPanel.Caption := '   ' + sDCPropertiesCheckHeader;
  MethodsHeaderPanel.Caption    := '   ' + sDCMethodsCheckHeader;
{
  SelectAllItem.Caption   := sDCSelectAllItemCaption;
  UnselectAllItem.Caption := sDCUnselectAllItemCaption;
}
  CancelBtn.Caption := sCancelButton;
  ResumeBtn.Caption := sDCResumeButton;

  ProceduresSheet.Caption := sDCProcedures;
  ClassesSheet.Caption    := sDCClasses;
  TypesSheet.Caption      := sDCTypes;
  VariablesSheet.Caption  := sDCVariales;
  ConstsSheet.Caption     := sDCConstants;
  PropertiesSheet.Caption := sDCProperties;
  MethodsSheet.Caption    := sDCMethods;
end;

{------------------------------------------------------------------}

function TDCTopicsCheckForm.GetActiveItems:TDCCheckImageListBox;
begin
  If ActiveControl is TDCCheckImageListBox then
    Result:=(ActiveControl as TDCCheckImageListBox)
  else
    Result:=ProceduresList;
end;

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.SelectAllItemClick( Sender : TObject );
begin
  GetActiveItems.CheckAllItems;
end;

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.UnselectAllItemClick( Sender : TObject );
begin
  GetActiveItems.UnCheckAllItems;
end;

{------------------------------------------------------------------}

procedure TDCTopicsCheckForm.FormShow(Sender: TObject);
begin
  ProceduresSheet.TabVisible := ProceduresList.Items.Count > 0;
  ClassesSheet.TabVisible    := ClassesList.Items.Count > 0;
  TypesSheet.TabVisible      := TypesList.Items.Count > 0;
  VariablesSheet.TabVisible  := VariablesList.Items.Count > 0;
  ConstsSheet.TabVisible     := ConstantsList.Items.Count > 0;
end;

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.ClassesListSelectionChanged( Sender : TObject );
Var
  CheckList : pDCArrayOfByte;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _AddTopic( AList : TDCCheckImageListBox; Const ATopicName : String; AStart, AIndex : Integer );
  begin
    With TDCCheckListItem( AList.Items.Add ) Do
    begin
      Caption := ATopicName;
      Checked := CheckList[ AStart + AIndex Div 8 ] And ( 1 Shl ( AIndex Mod 8 ) ) = 0;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  I, Start   : Integer;
  SaveCursor : TCursor;
  Info       : pTypeDeclInfo;
begin
  SaveSelection( FOldSelection );
  FOldSelection := ClassesList.ItemIndex;

  PropertiesList.Items.BeginUpdate;
  MethodsList.Items.BeginUpdate;
  try
    PropertiesList.Items.Clear;
    MethodsList.Items.Clear;

    If ClassesList.ItemIndex < 0 Then
      Exit;

    With pDCClassPropsInfo( TDCCheckListItem( ClassesList.Items[ ClassesList.ItemIndex ] ).UserData )^ Do
    begin
      If ClassInfo = Nil Then
        Exit;
      Info := ClassInfo;
      CheckList := @TopicChecks;
    end;

    SaveCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      With Info^ Do
      begin
        For I := MethodIndex To MethodIndex + MethodCount - 1 Do
          _AddTopic( MethodsList, MInfo.GetGlobalString( pMethodInfo( MInfo.ProcList[I] )^.MName ), 0, I - MethodIndex );

        If MethodCount Mod 8 <> 0 Then
          Start := 1
        Else
          Start := 0;
        Start := Start + MethodCount Div 8;
        For I := PropIndex To PropIndex + PropCount - 1 Do
          _AddTopic( PropertiesList, MInfo.GetGlobalString( pPropertyInfo( MInfo.PropList[I] )^.PropName ), Start, I - PropIndex );
      end;

      PropertiesSheet.TabVisible := PropertiesList.Items.Count > 0;
      MethodsSheet.Enabled := MethodsList.Items.Count > 0;
      MethodsSheet.TabVisible := Not PropertiesSheet.TabVisible Or MethodsSheet.Enabled;
    finally
      Screen.Cursor := SaveCursor;
    end;
  finally
    PropertiesList.Items.EndUpdate;
    MethodsList.Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.SaveSelection( ASavingItem : Integer );
Var
  CheckList : pDCArrayOfByte;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _CheckItem( AChecked : Boolean; AStart, AIndex : Integer );
  Var
    Value, Mask : Byte;
  begin
    AStart := AStart + AIndex Div 8;
    Value  := CheckList^[ AStart ];
    Mask   := 1 Shl ( AIndex Mod 8 );
    If Not AChecked Then
      Value := Value Or Mask
    Else
      Value := Value And Not Mask;
    CheckList^[ AStart ] := Value;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  I, Start : Integer;
begin
  If ASavingItem = -1 Then
    Exit;

  CheckList := @(pDCClassPropsInfo( TDCCheckListItem( ClassesList.Items[ ASavingItem ] ).UserData )^.TopicChecks);
  With MethodsList.Items Do
    For I := 0 To Count - 1 Do
      _CheckItem( TDCCheckListItem( Items[ I ] ).Checked, 0, I );

  I := MethodsList.Items.Count;
  If I Mod 8 <> 0 Then
    Start := 1
  Else
    Start := 0;
  Start := Start + I Div 8;
  With PropertiesList.Items Do
    For I := 0 To Count - 1 Do
      _CheckItem( TDCCheckListItem( Items[ I ] ).Checked, Start, I );
end;

{------------------------------------------------------------------}

procedure TDCTopicsCheckForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If ( ModalResult <> mrOk ) And
     ( MessageDlg( sDCImportTerminateQuery, mtConfirmation, [mbYes, mbNo], 0 ) <> mrYes ) Then
      ModalResult := mrNone;
end;

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.TopicsPagesChanging( Sender : TObject; Var AllowChange : Boolean );
begin
  ResumeBtnClick( ResumeBtn );
end;

{------------------------------------------------------------------}

Procedure TDCTopicsCheckForm.ResumeBtnClick( Sender : TObject );
begin
  If TopicsPages.ActivePage = ClassesSheet Then
    SaveSelection( FOldSelection );
end;

{------------------------------------------------------------------}

procedure TDCTopicsCheckForm.Selectallallpages1Click(Sender: TObject);
begin
  ProceduresList.CheckAllItems;
  TypesList.CheckAllItems;
  ClassesList.CheckAllItems;
  VariablesList.CheckAllItems;
  ConstantsList.CheckAllItems;
end;

{------------------------------------------------------------------}

procedure TDCTopicsCheckForm.Unselectallallpages1Click(Sender: TObject);
begin
  ProceduresList.UnCheckAllItems;
  TypesList.UnCheckAllItems;
  ClassesList.UnCheckAllItems;
  VariablesList.UnCheckAllItems;
  ConstantsList.UnCheckAllItems;
end;

{------------------------------------------------------------------}

end.
