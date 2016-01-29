unit IWDBExtCtrls;
{PUBDIST}

interface

uses
  {$IFDEF Linux} QGraphics, {$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux} IWJpeg, {$ELSE}Jpeg,{$ENDIF}
  Classes, DB,
  IWExtCtrls, IWHTMLTag;

type
  TIWDBImage = class(TIWDynamicImage)
  protected
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
  end;

implementation

uses
  IWDBStdCtrls, IWControl, SysUtils;

{ TIWDBImage }

procedure TIWDBImage.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited;
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBImage.RenderHTML: TIWHTMLTag;
var
  LField: TField;
  S: TMemoryStream;
  Ljpg: TJPEGImage;
  LHeader: array [0..1] of byte;
begin
  // Clear first in case the datafield is empty so we dont display the last image
  FPicture.Graphic := nil;
  if CheckDataSource(DataSource, DataField, LField) then begin
    if LField.IsBlob then begin
      S := TMemoryStream.Create;
      try
        TBlobField(LField).SaveToStream(S);
        // Find file type
        S.Position := 0;
        S.Read(LHeader, 2);
        S.Position := 0;
        if (LHeader[0] = $FF) and (LHeader[1] = $D8) then begin
          LJPg := TJPEGImage.Create;
          try
            LJpg.LoadFromStream(S);
            FPicture.Assign(LJPG);
          finally
            FreeAndNil(LJpg);
          end;
        end else begin
          FPicture.Assign(LField);
        end;
      finally
        FreeAndNil(S);
      end;
    end;
  end;
  Result := inherited RenderHTML;
end;

end.
