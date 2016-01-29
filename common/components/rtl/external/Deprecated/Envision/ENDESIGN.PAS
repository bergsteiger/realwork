{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnDesign
|
| Description: Design time registration unit.
|
| History: Sep 13, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnDesign;

{$I Envision.Inc}

interface

procedure Register;

{--------------------------------------------------------------------------}

implementation

uses
    Classes,  { for RegisterComponents }
    ExtDlgs,  { for TOpenPictureDialog }
    Forms,    { for Application }
    Graphics, { for GraphicFilter }
    Dialogs,  { for ofPathMustExist, ... }
    EnDiGrph, { for TDibGraphic }

    { In Delphi 5 this unit is not in the library path by default. The
      $(DELPHI)\source\toolsapi directory must be added to the library
      path, when compiling a package. }
    DsgnIntf, { for TStringProperty, RegisterPropertyEditor }

    EnImgScr, { for TImageScrollBox }

    { include all graphic file format units to register each
      graphic class with TPicture. See Envision.Inc }
    EnBmpGr,
    EnIcoGr,
    EnWmfGr,
    EnTifGr,
    EnPngGr,
    EnJpgGr,
    EnTgaGr,
    EnPcxGr,
    EnDcxGr;

{--------------------------------------------------------------------------}

type

TImageScrollBoxFileNameProperty = class(TStringProperty)
public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
end;

{--------------------------------------------------------------------------}

function TImageScrollBoxFileNameProperty.GetAttributes: TPropertyAttributes;
begin
      Result := [paDialog]
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBoxFileNameProperty.Edit;
var
    OpenDialog : TOpenPictureDialog;
begin
    OpenDialog := TOpenPictureDialog.Create(Application);
    try
        OpenDialog.Title    := GetName + ' property';
        OpenDialog.FileName := GetValue;
        OpenDialog.Filter   := GraphicFilter(TDibGraphic);
        OpenDialog.Options  := OpenDialog.Options +
                               [ofPathMustExist, ofFileMustExist];
        if OpenDialog.Execute then
            SetValue(OpenDialog.Filename);
    finally
        OpenDialog.Free;
    end
end;

{--------------------------------------------------------------------------}

procedure Register;
begin
    RegisterComponents('Envision', [ TImageScrollBox ] );

    RegisterPropertyEditor( TypeInfo(string),
                            TImageScrollBox,
                            'FileName',
                            TImageScrollBoxFileNameProperty);
end;


end.

