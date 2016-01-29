unit PDMatrixIntf;

interface

uses
  gtObjectIntf, PDBaseObjectIntf;

type

  IgtPDMatrix = Class(IgtObject)
    function GetArray: IgtPDBaseObject; virtual; abstract;
    function Copy: IgtPDMatrix; virtual; abstract;
    function PreMultiply(AMatrix: IgtPDMatrix): IgtPDMatrix; virtual; abstract;
    function GetInverse: IgtPDMatrix; virtual; abstract;
    procedure SetVAlues(AM11: Double; AM12: Double; AM21: Double; AM22: Double;
      ADx: Double; ADy: Double); virtual; abstract;
    procedure Inverse; virtual; abstract;
    procedure Assign(Value: IgtPDMatrix); virtual; abstract;

    function GetM11: Double; virtual; abstract;
    procedure SetM11(AM11: Double); virtual; abstract;
    function GetM12: Double; virtual; abstract;
    procedure SetM12(AM12: Double); virtual; abstract;
    function GetM21: Double; virtual; abstract;
    procedure SetM21(AM21: Double); virtual; abstract;
    function GetM22: Double; virtual; abstract;
    procedure SetM22(AM22: Double); virtual; abstract;
    function GetDx: Double; virtual; abstract;
    procedure SetDx(ADx: Double); virtual; abstract;
    function GetDy: Double; virtual; abstract;
    procedure SetDy(ADy: Double); virtual; abstract;
  End;

implementation

end.
