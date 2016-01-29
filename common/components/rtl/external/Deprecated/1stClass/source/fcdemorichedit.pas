unit fcDemoRichEdit;
{
//
// Components : TfcDemoRichEdit
//
// Copyright (c) 1999 by Woll2Woll Software
//
}

interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfcDemoRichEdit = class(TCustomRichEdit)
  private
     ReloadStream: TStream;
     UseReloadStream: boolean;
  protected
    procedure GetLines(Stream: TStream); virtual;
    procedure SetLines(Stream: TStream); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
  public
    destructor Destroy; override;
  published
    property Align;
    property Alignment;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
//    property Lines;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property OnChange;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResizeRequest;
    property OnSelectionChange;
    property OnStartDrag;
    property OnProtectChange;
    property OnSaveClipboard;
  end;

implementation

procedure TfcDemoRichEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('RichEditLines', GetLines, SetLines, True);
end;

procedure TfcDemoRichEdit.GetLines(Stream: TStream);
begin
  Lines.LoadFromStream(Stream);
end;

procedure TfcDemoRichEdit.SetLines(Stream: TStream);
begin
  Lines.SaveToStream(Stream);
end;

procedure TfcDemoRichEdit.CreateWnd;
begin
  inherited CreateWnd;

  { Stream in after setting ole callback routines }
  if (useReloadStream) and (ReloadStream<>nil) then begin
     ReloadStream.position:= 0;
     Lines.LoadFromStream(ReloadStream);
  end;
end;

procedure TfcDemoRichEdit.DestroyWnd;
begin
   useReloadStream:= False;
   if not (csDestroying in ComponentState) then
   begin
      if ReloadStream=Nil then ReloadStream:= TMemoryStream.create
      else ReloadStream.position:= 0;
      Lines.SaveToStream(ReloadStream);
      useReloadStream:= True;
   end;

   inherited DestroyWnd;
end;

destructor TfcDemoRichEdit.Destroy;
begin
   ReloadStream.Free;
   inherited Destroy;
end;

end.

