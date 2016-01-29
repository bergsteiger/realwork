unit IWCompRectangle;

interface

uses
  Classes, IWHTMLTag,
  IWControl, IWTypes, IWGrids;

type
  TIWCustomRectangle = class(TIWControl)
  private
  protected
    FAlignment: TAlignment;
    FVAlign: TIWGridVAlign;
    //
    procedure SetAlignment(const Value: TAlignment);
    procedure SetVAlign(const Value: TIWGridVAlign);
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;

    property Alignment: TAlignment read FAlignment write SetAlignment;
    property VAlign: TIWGridVAlign read FVAlign write SetVAlign;
  published
    property Text;
    property Font;

  end;

  TIWRectangle = class(TIWCustomRectangle)
  published
    property Color;
    property Alignment;
    property VAlign;
  end;

implementation

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  IWServerControllerBase,
  SysUtils, SWSystem;

{ TIWCustomRectangle }

constructor TIWCustomRectangle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clNone;
  Width := 200;
  Height := 100;
  FRenderSize := true;
end;

function TIWCustomRectangle.RenderHTML: TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('TABLE'); try
    Result.AddColor('BGCOLOR', Color);
    Result.AddIntegerParam('WIDTH', Width);
    Result.AddIntegerParam('HEIGHT', Height);
    Result.AddIntegerParam('BORDER', 0);
    Result.AddIntegerParam('CELLPADDING', 0);
    Result.AddIntegerParam('CELLSPACING', 0);
    with Result.Contents.AddTag('TR') do begin
      // AddIntegerParam('HEIGHT', Height);
      with Contents.AddTag('TD') do begin
        // AddIntegerParam('HEIGHT', Height);
        if Text = '' then
          Contents.AddText('') // &nbsp;')
        else begin
          AddStringParam('ALIGN', IWGridAlignments[Alignment]);
          case FVAlign of
            vaMiddle: AddStringParam('VALIGN', 'MIDDLE');
            vaTop: AddStringParam('VALIGN', 'top');
            vaBottom: AddStringParam('VALIGN', 'bottom');
            vaBaseline: AddStringParam('VALIGN', 'basline');
          end;

          Contents.AddText(Text)
        end;
      end;
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWCustomRectangle.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  Invalidate;
end;

procedure TIWCustomRectangle.SetVAlign(const Value: TIWGridVAlign);
begin
  FVAlign := Value;
  Invalidate;
end;

end.
