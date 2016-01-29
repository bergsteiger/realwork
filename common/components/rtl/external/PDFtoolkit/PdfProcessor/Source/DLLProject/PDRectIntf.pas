
unit PDRectIntf;

interface

uses
  gtObjectIntf;

type

  IgtPDRect = Class(IgtObject)
//    function GetArray: TgtPDArray;['{BD28CC48-D63F-4CBE-B13E-405B73BD98BF}']
    procedure Assign(Source: IgtObject); virtual; abstract;
    procedure SetValues(ALeft, ATop, ARight, ABottom: Double); virtual; abstract;

    function GetLeft: Double; virtual; abstract;
    procedure SetLeft(ALeft: Double); virtual; abstract;
    function GetTop: Double; virtual; abstract;
    procedure SetTop(ATop: Double); virtual; abstract;
    function GetRight: Double; virtual; abstract;
    procedure SetRight(ARight: Double); virtual; abstract;
    function GetBottom: Double; virtual; abstract;
    procedure SetBottom(ABottom: Double); virtual; abstract;
  end;

implementation

end.
