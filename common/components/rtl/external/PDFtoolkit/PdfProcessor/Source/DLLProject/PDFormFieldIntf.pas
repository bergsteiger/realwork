unit PDFormFieldIntf;

interface

uses
  PDAnnotIntf;

//constants for enum TgtPDColorSpaceType
const
  Transparent = $00000000;
  DeviceGray = $00000001;
  DeviceRGB = $00000002;
  DeviceCMYK = $00000003;

//constants for enum TgtFormHighlightMode
  fmNone = $00000000;
  fmInvert = $00000001;
  fmOutline = $00000002;
  fmPush = $00000003;
  fmToggle= $00000004;

type

  TPDColorValue = packed record
    ColorSpace: Integer;
    Value: array[0..3] of Double;
  end;


  IgtPDFormField = Interface(IgtPDAnnot)
    function GetRotationAngle: Integer;
    function GetBorderColor: TPDColorValue;
    function GetBackGroundColor: TPDColorValue;
    //function GetNormalCaption: WideString;
    function GetHighlightMode: Integer;

    procedure SetRotationAngle(Value: Integer);
    procedure SetBorderColor(Value: TPDColorValue);
    procedure SetBackGroundColor(Value: TPDColorValue);
    //procedure SetNormalCaption(Value: WideString);
    procedure SetHighlightMode(Value: Integer);
  End;

implementation

end.
