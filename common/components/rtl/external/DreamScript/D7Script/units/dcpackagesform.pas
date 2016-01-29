{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCPackagesForm;

interface

{$I DC.inc}

uses
  Messages, SysUtils, Classes, Dialogs, Buttons, StdCtrls, ExtCtrls, Controls, Forms,

  DCButtonPanel, DCPLoad, DCConsts, DCSystem, DCdreamLib,
  DCImageListBox, DCInstCompListForm;

type
  TDCPackagesEditor = class(TForm)
    DesignControlsPanel: TGroupBox;
    MainPanel: TPanel;
    BtnPanel: TDCButtonPanel;
    ComponentsBtn: TBitBtn;
    AddBtn: TBitBtn;
    RemoveBtn: TBitBtn;
    EditBtn: TBitBtn;
    StatusPanel: TPanel;
    DividerPanel: TPanel;
    PackagesList: TDCCheckImageListBox;
    OpenDialog: TOpenDialog;
    procedure AddBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure ComponentsBtnClick(Sender: TObject);
    procedure PackagesListCheckStateChanged(AObject: TObject;
      ASender: TDCCustomCheckListItem);
    procedure PackagesListSelectionChanged(Sender: TObject);
  private
    FOriginalState : TStrings;

    Procedure FillPackageList( ANeedRefresh : Boolean );

    Procedure CMApplyOptions( Var Msg : TMessage ); message CM_ApplyOptions;
    Procedure CMCancelOptions( Var Msg : TMessage ); message CM_CancelOptions;
  protected
    Procedure InitUndoStructure;
  public
    Constructor Create( AOwner : TComponent ); override;
    Destructor Destroy; override;
  end;

Const
{$IFDEF CPB3}
  sDCPackageExt = '.BPL'; //don't resource
{$ELSE}
  sDCPackageExt = '.DPL'; //don't resource
{$ENDIF}

implementation

{$R *.DFM}

{------------------------------------------------------------------}

{ TDCPackagesEditor }

Constructor TDCPackagesEditor.Create( AOwner : TComponent );
begin
  Inherited;
  Caption := sDCPackagesEditorCaption;
  DesignControlsPanel.Caption := ' ' + sDCPackagesPanelCaption + ' ';
  AddBtn.Caption := sDCAddBtnCaption;
  RemoveBtn.Caption := sDCRemoveBtnCaption;
  EditBtn.Caption := sDCEditBtnCaption;
  ComponentsBtn.Caption := sDCComponentsBtnCaption;

  FOriginalState := CreateSortedStringList;
  InitUndoStructure;

  FillPackageList( True );
  With OpenDialog Do
    Filter := SPackagesFilter + '|' + Filter;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.AddBtnClick(Sender: TObject);
Var
  I : Integer;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _LoadPackage( Const AFileName : String );
  Var
    NewPackage : Integer;
  begin
    With GetPackageLoader Do
    begin
      NewPackage := RegisterPackage( AFileName, True );
      If NewPackage >= 0 Then
        With Self.PackagesList Do
        begin
          With TDCCheckListItem( Items.Add ) Do
          begin
            Caption := PackageDesc[ NewPackage ];
            Checked := PackageLoaded[ NewPackage ];
            UserData := Pointer( NewPackage );
            ItemIndex := Index;
          end;
        end;
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  Inherited;
  If GetPackageLoader = Nil Then
    Exit;
  With OpenDialog Do
    If Execute Then
      For I := 0 To Files.Count - 1 Do
        If CompareText( ExtractFileExt( Files[ I ] ), sDCPackageExt ) = 0 Then
          _LoadPackage( Files[ I ] )
        Else
          RegisterOCX( Files[ I ] );
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.RemoveBtnClick(Sender: TObject);
Var
  Idx : Integer;
  I   : Integer;
begin
  Inherited;
  If GetPackageLoader = Nil Then
    Exit;
  try
    With PackagesList Do
    begin
      Idx := Integer( TDCCheckListItem( Items[ ItemIndex ] ).UserData );
      For I := 0 To Items.Count - 1 Do
        With TDCCheckListItem( Items[ ItemIndex ] ) Do
          If Integer( UserData ) > Idx Then
            UserData := Pointer( Integer( UserData ) - 1 );
      GetPackageLoader.UnregisterPackage( Idx );
    end;
  finally
    FillPackageList( True );
  end;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.ComponentsBtnClick(Sender: TObject);
begin
  Inherited;
  If ( GetPackageLoader = Nil ) Or ( PackagesList.ItemIndex < 0 ) Then
    Exit;
  With TDCLibComponentsListForm.Create( Nil ) Do
    try
      With PackagesList Do
        InitComponents( GetPackageLoader.PackageHandle[ Integer( TDCCheckListItem( Items[ ItemIndex ] ).UserData ) ] );
      ShowModal;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.FillPackageList(ANeedRefresh: Boolean);
Var
  I : Integer;
begin
  If GetPackageLoader = Nil Then
    Exit;
  With PackagesList.Items, GetPackageLoader Do
  begin
    BeginUpdate;
    try
      Clear;
      For I := 0 To PackageCount - 1 Do
        With TDCCheckListItem( Add ) Do
        begin
          Caption := PackageDesc[ I ];
          Checked := PackageLoaded[ I ];
          UserData := Pointer( I );
        end;
    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.PackagesListCheckStateChanged(AObject: TObject;
  ASender: TDCCustomCheckListItem);
begin
  Inherited;
  If GetPackageLoader = Nil Then
    Exit;
  try
    GetPackageLoader.PackageLoaded[ Integer( ASender.UserData ) ] := ASender.Checked;
  finally
    FillPackageList( False );
  end;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.CMCancelOptions( Var Msg : TMessage );
Var
  I, Idx : Integer;
{------------------------------------------------------------------}
  Function GetPackageIndex( Const APath : String ) : Integer;
  begin
    With GetPackageLoader Do
      For Result := 0 To PackageCount - 1 Do
        If PackagePath[ Result ] = APath Then
        Exit;
    Result := -1;
  end;
{------------------------------------------------------------------}
begin
  With PackagesList, GetPackageLoader Do
  begin
    I := 0;
    While I < PackageCount Do
    begin
      Idx := FOriginalState.IndexOf( PackagePath[ I ] );
      If Idx < 0 Then
        UnregisterPackage( I )
      Else
      begin
        PackageLoaded[ I ] := Boolean( FOriginalState.Objects[ Idx ] );
        FOriginalState.Delete( Idx );
        Inc( I );
      end;
    end;
    For I := 0 To FOriginalState.Count - 1 Do
      RegisterPackage( FOriginalState[ I ], Boolean( FOriginalState.Objects[ I ] ) );
  end;
end;

{------------------------------------------------------------------}

Destructor TDCPackagesEditor.Destroy;
begin
  FreeObject( FOriginalState ,FOriginalState );
  Inherited;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.InitUndoStructure;
Var
  I : Integer;
begin
  FOriginalState.Clear;
  With GetPackageLoader Do
    For I := 0 To PackageCount - 1 Do
      FOriginalState.AddObject( GetPackageLoader.PackagePath[ I ], Pointer( PackageLoaded[ I ] ) );
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.CMApplyOptions( Var Msg : TMessage );
begin
  InitUndoStructure;
end;

{------------------------------------------------------------------}

procedure TDCPackagesEditor.PackagesListSelectionChanged(Sender: TObject);
Var
  I : Integer;
begin
  Inherited;
  I := PackagesList.ItemIndex;
  With StatusPanel Do
    If I < 0 Then
      Caption := ''
    Else
      Caption := ' ' + GetPackageLoader.PackagePath[ I ];
  With PackagesList Do
  begin
    RemoveBtn.Enabled := ItemIndex >= 0;
    ComponentsBtn.Enabled := ( GetPackageLoader <> Nil ) And ( ItemIndex >= 0 ) And
                             ( GetPackageLoader.PackageHandle[ Integer( TDCCheckListItem( Items[ ItemIndex ] ).UserData ) ] <> 0 );
  end;
end;

{------------------------------------------------------------------}

end.
