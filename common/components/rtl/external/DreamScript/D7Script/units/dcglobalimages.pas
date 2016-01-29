{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCGlobalImages;

{$I DC.inc}

interface

Uses
  Windows, Graphics, CommCtrl, {$IFDEF D4}ImgList,{$ELSE} Controls,{$ENDIF} Consts,

  {$IFDEF D6}
  RTLConsts,
  {$ENDIF}

  DCCommon, DCdreamLib, DCConsts;

Procedure DCAddGlobalImages( Const AResourceName : String; AMaskColor : TColor;
                             Var AStartIndex, ACount : Integer );
Procedure DCRemoveGlobalImages( ACount : Integer );

Procedure DCSetGlobalImageList( Const AImageList : TCustomImageList );

Function DCGlobalImageList : TCustomImageList;

Function  DCAddResourceToImageList( AImageList : TCustomImageList; AInstance : THandle;
                                    Const AResourceName : String; MaskColor : TColor ) : Boolean;
Function DCGetImageInstance( Const AResName : String ) : THandle;

{------------------------------------------------------------------}

Const
  cDCTrasparentColor : TColor = -1;

implementation

{------------------------------------------------------------------}

Var
  _DCGlobalImageList    : TCustomImageList = Nil;
  _tmpGlobalImageList : TCustomImageList = Nil;

{------------------------------------------------------------------}

function tmpGlobalImageList : TCustomImageList;
begin
  If _tmpGlobalImageList = Nil Then
    _tmpGlobalImageList := TCustomImageList.Create( Nil );
  Result := _tmpGlobalImageList;
end;

{------------------------------------------------------------------}

Function DCGlobalImageList : TCustomImageList;
begin
  Result := _DCGlobalImageList;
  If Result = Nil Then
    result := tmpGlobalImageList;
end;

{------------------------------------------------------------------}

Procedure DCAddGlobalImages( Const AResourceName : String; AMaskColor : TColor;
  Var AStartIndex, ACount : Integer );
Var
  ImgList : TCustomImageList;
Begin
  ImgList := DCGlobalImageList;
  AStartIndex := ImgList.Count;
  If DCAddResourceToImageList( ImgList, DCGetImageInstance( AResourceName ), AResourceName, AMaskColor ) Then
    ACount := ImgList.Count - AStartIndex
  Else
    ErrorFmt( SResNotFound, [AResourceName] );
End;

{------------------------------------------------------------------}

Procedure DCRemoveGlobalImages( ACount : Integer );
Var
  I : Integer;
Begin
  For I := ACount DownTo 1 Do
    DCGlobalImageList.Delete( DCGlobalImageList.Count - 1 );
End;

{------------------------------------------------------------------}

Procedure DCSetGlobalImageList( Const AImageList : TCustomImageList );
Begin
  If AImageList = _DCGlobalImageList Then
    Exit;

  If Assigned( AImageList ) Then
    AImageList.AddImages( DCGlobalImageList )
  Else
    _tmpGlobalImageList.Assign( _DCGlobalImageList );

  _DCGlobalImageList := AImageList;
End;

{------------------------------------------------------------------}

Function  DCAddResourceToImageList( AImageList : TCustomImageList; AInstance : THandle;
  Const AResourceName : String; MaskColor : TColor ) : Boolean;
Var
  Bitmap  : TBitmap;
  Handle  : THandle;
  iHandle : THandle;
Begin
  Handle := FindResource( AInstance, PChar( AResourceName ), RT_BITMAP );
  If Handle = 0 Then
  Begin
    Handle := FindResource( AInstance, PChar( AResourceName ), RT_GROUP_ICON );
    If Handle = 0 Then
      Handle := FindResource( AInstance, PChar( AResourceName ), RT_ICON );
    If Handle = 0 Then
      Result := False
    Else
    Begin
      iHandle := LoadIcon( AInstance, PChar( AResourceName ) );
      If Handle = 0 Then
        Result := False
      Else
      Begin
        ImageList_AddIcon( AImageList.Handle, iHandle );
        Result := True;
        DestroyIcon( iHandle );
      End;
    End
  End
  Else
  Begin
    Bitmap := TBitmap.Create;
    Try
      Bitmap.LoadFromResourceName( AInstance, AResourceName );
      If MaskColor = cDCTrasparentColor Then
        AImageList.AddMasked( Bitmap, Bitmap.TransparentColor )
      Else
        AImageList.AddMasked( Bitmap, MaskColor );
    Finally
      Bitmap.Free;
    End;
    Result := True;
  End;
End;

{------------------------------------------------------------------}

Function DCGetImageInstance( Const AResName : String ) : THandle;
begin
  Result := FindResourceInstance( AResName, RT_BITMAP );
  If result = 0 Then
    begin
      Result := FindResourceInstance( AResName, RT_ICON );
      If result = 0 Then
        Result := FindResourceInstance( AResName, RT_GROUP_ICON );
    end;
end;

{------------------------------------------------------------------}

initialization
finalization
  FreeObject( _tmpGlobalImageList,_tmpGlobalImageList);
end.
