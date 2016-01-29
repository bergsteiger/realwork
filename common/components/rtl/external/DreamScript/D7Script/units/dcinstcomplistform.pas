{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCInstCompListForm;

interface

{$I DC.inc}

uses
  Windows, Classes, Graphics, Controls, Forms, StdCtrls, Buttons, ExtCtrls,
  {$IFDEF D4}ImgList,{$ENDIF}
  ActiveX,

  DCButtonPanel, DCSystem, DCGen, DCConsts,
  DCImageListBox, DCPalette, DCGraphFunc;

type
  TDCComponentsListForm = class(TForm)
    GroupBox: TGroupBox;
    DCButtonPanel1: TDCButtonPanel;
    OkBtn: TBitBtn;
    UnderlayerPanel: TPanel;
    ImageList: TImageList;
    ComponentsList: TDCBtnImageListBox;
  private
    { Private declarations }
  public
    Constructor Create( AOwner : TComponent ); override;
  end;

{------------------------------------------------------------------}

  TDCLibActiveXListForm = class( TDCComponentsListForm )
  public
    Procedure InitActiveXs( Const ATypeLib : TGUID );
  end;

{------------------------------------------------------------------}

  TDCLibComponentsListForm = class( TDCComponentsListForm )
  public
    Procedure InitComponents( ALibHandle : THandle );
  end;

{------------------------------------------------------------------}

implementation

{$R *.DFM}

{ TDcComponentsListForm }

{------------------------------------------------------------------}

Constructor TDCComponentsListForm.Create( AOwner : TComponent );
begin
  Inherited;
  Caption := sDCComponentsListFormCaption;
  GroupBox.Caption := ' ' + sDCComponentsListPanelCaption + ' ';
end;

{------------------------------------------------------------------}

{ TDCLibActiveXListForm }

procedure TDCLibActiveXListForm.InitActiveXs( Const ATypeLib : TGUID );
Var
  I, J       : Integer;
  HandleList : TStrings;
  _Glyph     : TBitmap;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  Procedure _AddActiveX( Const AGUID : TGUID );
  Var
    PictIndex : Integer;
    PictName  : String;
    Idx       : Integer;
    H         : THandle;
  begin
    With TDCImageListItem( ComponentsList.Items.Add ) Do
    begin
      Caption := DCGetActiveXHint( AGUID );

      DCGetActiveXPictureInfo( AGUID, PictIndex, PictName );
      Idx := HandleList.IndexOf( PictName );
      If Idx < 0 Then
      begin
        H := LoadLibrary( PChar( PictName ) );
        If H <> 0 Then
          HandleList.AddObject( PictName, Pointer( H ) );
      end
      Else
        H := THandle( HandleList.Objects[ Idx ] );

      DCLoadActiveXPicture( _Glyph, H, PictIndex );
      ImageIndex := DCAddImageInList( ImageList, _Glyph );
    end;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  With ComponentsList.Items Do
  begin
    BeginUpdate;
    Clear;
    ImageList.Clear;
    HandleList := CreateSortedStringList;
    _Glyph := TBitmap.Create;
    try
      With DCGetActiveXProvider Do
        For I := 0 To Count - 1 Do
          With TypeLibraries[ I ] Do
{$IFDEF BCB}
            If IsEqualGUID( StringToGUID( GUID ), ATypeLib ) Then
{$ELSE}
            If IsEqualGUID( GUID, ATypeLib ) Then
{$ENDIF}
            begin
              For J := 0 To Count - 1 Do
{$IFDEF BCB}
                _AddActiveX( StringToGUID( ActiveX[ J ] ) );
{$ELSE}
                _AddActiveX( ActiveX[ J ] );
{$ENDIF}
              Exit;
            end;
    finally
      _Glyph.Free;
      For I := 0 To HandleList.Count - 1 Do
        FreeLibrary( Integer( HandleList.Objects[ I ] ) );
      HandleList.Free;
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------}

{ TDCLibComponentsListForm }

procedure TDCLibComponentsListForm.InitComponents( ALibHandle : THandle );
Var
  I      : Integer;
  _Glyph : TBitmap;
begin
  With ComponentsList.Items Do
  begin
    BeginUpdate;
    _Glyph := TBitmap.Create;
    try
      ImageList.Clear;
      Clear;

      With ClassItems Do
        For I := 0 To Count - 1 Do
          With TClassItem( Items[ I ] ) Do
            If ( Categories * [icNoIcon, icShowinPalette] = [icShowInPalette] ) And
               ClassPtr.InheritsFrom( TComponent ) And
               ( PackageHandle = ALibHandle ) Then
              With TDCImageListItem( ComponentsList.Items.Add ) Do
              begin
                Caption := TComponentClass( ClassPtr ).ClassName;
                LoadBitmapForClass( _Glyph, TComponentClass( ClassPtr ) );
                ImageIndex := DCAddImageInList( ImageList, _Glyph );
              end;
    finally
      _Glyph.Free;
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------}

end.
