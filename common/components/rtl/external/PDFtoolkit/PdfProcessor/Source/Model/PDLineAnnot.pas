{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDLineAnnot;

interface

uses
  PDArray, PDBaseObject, PDDictionary, gtObject, PDElement, PDAnnot, PDTypes,
  PDString, gtConstants, PDReal, gtMethods, PDInteger, PDName;

type

  // enum for line annontation ending and begining styles

  TgtPDLineAnnot = class(TgtPDAnnot)
  private
//    FCap: Boolean;
//    FBS: TgtPDDictionary;
    FCO: TgtPDArray;
    FInteriorColor: TgtPDColorValue;
    FIT: TgtPDString;
    FLineCord: TgtPDArray; // To store Line Coordinates
    FX1: Double;
    FY1: Double;
    FX2: Double;
    FY2: Double;
    FLineBeginningStyle: TgtLineStyle;
    FLineEndingStyle: TgtLineStyle;
    FLeaderLines: Real;
    procedure GetLineCord;
//    function GetBS: TgtPDDictionary;
//    function GetCap: Boolean;
//    function GetCO: TgtPDArray;
//    function GetIT: AnsiString;
    function GetLeaderLines: Real;
    function GetMeasure: TgtPDDictionary;
//    procedure SetCap(const Value: Boolean);
    procedure SetCP(const Value: AnsiString);
//    procedure SetIT(const Value: AnsiString);
    procedure SetLeaderLines(const Value: Real);
//    procedure SetLLF(const Value: Real);
//    procedure SetLLO(const Value: Real);
    function GetX1: Double;
    function GetX2: Double;
    function GetY1: Double;
    function GetY2: Double;
    procedure SetX1(const Value: Double);
    procedure SetX2(const Value: Double);
    procedure SetY1(const Value: Double);
    procedure SetY2(const Value: Double);
//    function GetLLF: Real;
//    function GetLLO: Real;
    function GetLineBeginningStyle: TgtLineStyle;
    function GetLineEndingStyle: TgtLineStyle;
    procedure SetLineBeginningStyle(const Value: TgtLineStyle);
    procedure SetLineEndingStyle(const Value: TgtLineStyle);
    function GetInteriorColor: TgtPDColorValue;
    procedure SetInteriorColor(const Value: TgtPDColorValue);

  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;

    destructor Destroy; override;

    property X1: Double read GetX1 write SetX1;
    property X2: Double read GetX2 write SetX2;
    property Y1: Double read GetY1 write SetY1;
    property Y2: Double read GetY2 write SetY2;
//    property BS: TgtPDDictionary read GetBS;
    property LineBeginningStyle: TgtLineStyle read GetLineBeginningStyle write SetLineBeginningStyle;
    property LineEndingStyle: TgtLineStyle read GetLineEndingStyle write SetLineEndingStyle;
    property InteriorColor: TgtPDColorValue read GetInteriorColor write SetInteriorColor;
    property LeaderLines: Real read GetLeaderLines write SetLeaderLines;
//    property LLF: Real read GetLLF write SetLLF;
//    property Cap: Boolean read GetCap write SetCap;
//    property IT: AnsiString read GetIT write SetIT;
//    property LLO: Real read GetLLO write SetLLO;
//    property CP: AnsiString read GetIT write SetCP;
    property Measure: TgtPDDictionary read GetMeasure;
//    property CO: TgtPDArray read GetCO;

  end;

implementation

{ TgtPDLineAnnot }

uses
  PDDocument, PDPage;

constructor TgtPDLineAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FLeaderLines := -1;
end;

constructor TgtPDLineAnnot.Create;
begin
  inherited;
  AnnotType := annotLine;
  BorderStyle := absSolid;
  FLineBeginningStyle := laNone;
  FLineEndingStyle := laNone;
  //default border width 1
  FInteriorColor.Value[0] := 1;
  FInteriorColor.Value[1] := 1;
  FInteriorColor.Value[2] := 1;
end;

destructor TgtPDLineAnnot.Destroy;
begin
  if Assigned(FLineCord) then FreeObject(FLineCord);
//  if Assigned(FBS) then FreeObject(FBS);
  if Assigned(FCO) then FreeObject(FCO);
  if Assigned(FIT) then FreeObject(FIT);

  inherited;
end;

//function TgtPDLineAnnot.GetBS: TgtPDDictionary;
//var
//  LObj: TgtPDBaseObject;
//begin
//  if not Assigned(FBS) then
//  begin
//    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BS);
//    if LObj.IsDict then
//      FBS := TgtPDDictionary(LObj);
//  end;
//  Result := FBS;
//end;

(*
function TgtPDLineAnnot.GetCap: Boolean;
begin

end;
*)

(*

function TgtPDLineAnnot.GetCO: TgtPDArray;
begin

end;
*)

function TgtPDLineAnnot.GetInteriorColor: TgtPDColorValue;
var
  LObj: TgtPDBaseObject;
  LColor: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_IC);
    if Assigned(LObj) and LObj.IsArray then
    begin
      FInteriorColor.ColorSpace := DeviceRGB;
      LColor := TgtPDArray(LObj).Get(0);
      if LColor.IsReal then
        FInteriorColor.Value[0] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FInteriorColor.Value[0] := TgtPDInteger(LColor).Value;

      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
        FInteriorColor.Value[1] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FInteriorColor.Value[1] := TgtPDInteger(LColor).Value;

      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
        FInteriorColor.Value[2] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FInteriorColor.Value[2] := TgtPDInteger(LColor).Value;
    end;
  end;
  Result := FInteriorColor;
end;

(*
function TgtPDLineAnnot.GetIT: AnsiString;
begin

end;
*)

function TgtPDLineAnnot.GetLeaderLines: Real;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if FLeaderLines = -1 then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LL);
      if Assigned(LObj) and LObj.IsReal then
      begin
        FLeaderLines := TgtPDReal(LObj).Value;
      end;
      FreeObject(LObj);
    end;
  end;
  Result := FLeaderLines;
end;

function TgtPDLineAnnot.GetLineBeginningStyle: TgtLineStyle;
var
  LObj: TgtPDBaseObject;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    if FLineBeginningStyle <> laNone then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
      if Assigned(LObj) and LObj.IsArray then
      begin
        if Assigned(TgtPDArray(LObj).Get(1)) and TgtPDArray(LObj).Get(1).IsName then
        begin
          LStyle := TgtPDName(TgtPDArray(LObj).Get(1)).Value;
          if LStyle = 'PDF_SQUARE' then
            FLineBeginningStyle := laSquare
          else if LStyle = 'PDF_CIRCLE' then
            FLineBeginningStyle := laCircle
          else if LStyle = 'PDF_DIAMOND' then
            FLineBeginningStyle := laDiamond
          else if LStyle = 'PDF_OPENARROW' then
            FLineBeginningStyle := laOpenArrow
          else if LStyle = 'PDF_CLOSEDARROW' then
            FLineBeginningStyle := laClosedArrow
          else if LStyle = 'PDF_NONE' then
            FLineBeginningStyle := laNone
          else if LStyle = 'PDF_BUTT' then
            FLineBeginningStyle := laButt
          else if LStyle = 'PDF_ROPENARROW' then
            FLineBeginningStyle := laOpenArrow
          else if LStyle = 'PDF_RCLOSEDARROW' then
            FLineBeginningStyle := laRClosedArrow
          else if LStyle = 'PDF_SLASH' then
            FLineBeginningStyle := laSlash;
        end;
      end;
    end;
  end;
  Result := FLineBeginningStyle;
end;

procedure TgtPDLineAnnot.GetLineCord;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FLineCord) then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_L);
      if Assigned(LObj) and LObj.Isarray then
      begin
        FLineCord := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        FLineCord.Add(TgtPDArray(LObj).Get(0));
        FLineCord.Add(TgtPDArray(LObj).Get(1));
        FLineCord.Add(TgtPDArray(LObj).Get(2));
        FLineCord.Add(TgtPDArray(LObj).Get(3));
      end;
//      FreeObject(LObj);
    end;
  end;
end;


function TgtPDLineAnnot.GetLineEndingStyle: TgtLineStyle;
var
  LObj: TgtPDBaseObject;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    if FLineEndingStyle <> laNone then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
      if Assigned(LObj) and LObj.IsArray then
      begin
        if Assigned(TgtPDArray(LObj).Get(1)) and TgtPDArray(LObj).Get(1).IsName then
        begin
          LStyle := TgtPDName(TgtPDArray(LObj).Get(1)).Value;
          if LStyle = 'PDF_SQUARE' then
            FLineEndingStyle := laSquare
          else if LStyle = 'PDF_CIRCLE' then
            FLineEndingStyle := laCircle
          else if LStyle = 'PDF_DIAMOND' then
            FLineEndingStyle := laDiamond
          else if LStyle = 'PDF_OPENARROW' then
            FLineEndingStyle := laOpenArrow
          else if LStyle = 'PDF_CLOSEDARROW' then
            FLineEndingStyle := laClosedArrow
          else if LStyle = 'PDF_NONE' then
            FLineEndingStyle := laNone
          else if LStyle = 'PDF_BUTT' then
            FLineEndingStyle := laButt
          else if LStyle = 'PDF_ROPENARROW' then
            FLineEndingStyle := laOpenArrow
          else if LStyle = 'PDF_RCLOSEDARROW' then
            FLineEndingStyle := laRClosedArrow
          else if LStyle = 'PDF_SLASH' then
            FLineEndingStyle := laSlash;
        end;
      end;
    end;
  end;
  Result := FLineEndingStyle;
end;

(*
function TgtPDLineAnnot.GetLLF: Real;
begin

end;
*)

(*
function TgtPDLineAnnot.GetLLO: Real;
begin

end;
*)

function TgtPDLineAnnot.GetMeasure: TgtPDDictionary;
begin
  Result := nil;
end;

function TgtPDLineAnnot.GetX1: Double;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FLineCord) then
    begin
      GetLineCord;
    end;
    if FLineCord.Get(0) is TgtPDReal then
      FX1 := TgtPDReal(FLineCord.Get(0)).Value
    else
      FX1 := TgtPDInteger(FLineCord.Get(0)).Value;
  end;
  Result := FX1;
end;

function TgtPDLineAnnot.GetX2: Double;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FLineCord) then
    begin
      GetLineCord;
    end;
    if FLineCord.Get(1) is TgtPDReal then
      FX2 := TgtPDReal(FLineCord.Get(1)).Value
    else
      FX2 := TgtPDInteger(FLineCord.Get(1)).Value;
  end;
  Result := FX2;
end;

function TgtPDLineAnnot.GetY1: Double;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FLineCord) then
    begin
      GetLineCord;
    end;
    if FLineCord.Get(2) is TgtPDReal then
      FY1 := TgtPDReal(FLineCord.Get(2)).Value
    else
      FY1 := TgtPDInteger(FLineCord.Get(2)).Value;
  end;
  Result := FY1;
end;

function TgtPDLineAnnot.GetY2: Double;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FLineCord) then
    begin
      GetLineCord;
    end;
    if FLineCord.Get(3) is TgtPDReal then
      FY2 := TgtPDReal(FLineCord.Get(3)).Value
    else
      FY2 := TgtPDInteger(FLineCord.Get(3)).Value;
  end;
  Result := FY2;
end;

(*
procedure TgtPDLineAnnot.SetCap(const Value: Boolean);
begin
  if Assigned(FBaseObject) then
  begin

  end;
  FCap := Value;
end;
*)

procedure TgtPDLineAnnot.SetCP(const Value: AnsiString);
begin

end;

procedure TgtPDLineAnnot.SetInteriorColor(const Value: TgtPDColorValue);
var
  LObj: TgtPDBaseObject;
  LColor: TgtPDBaseObject;
  LRealObj: TgtPDReal;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_IC);
    if Assigned(LObj) then
    begin
      LColor := TgtPDArray(LObj).Get(0);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Value.Value[0];
      end
      else
      begin
        TgtPDArray(LObj).Remove(0);
        LColor := TgtPDReal.Create(Value.Value[0]);
        TgtPDArray(LObj).Insert(LColor, 0);
      end;
      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Value.Value[1];
      end
      else
      begin
        TgtPDArray(LObj).Remove(1);
        LColor := TgtPDReal.Create(Value.Value[1]);
        TgtPDArray(LObj).Insert(LColor, 1);
      end;
      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Value.Value[2];
      end
      else
      begin
        TgtPDArray(LObj).Remove(2);
        LColor := TgtPDReal.Create(Value.Value[2]);
        TgtPDArray(LObj).Add(LColor);
      end;
    end
    else
    begin
      LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LRealObj := TgtPDReal.Create(Value.Value[0]);
      TgtPDArray(LObj).Add(LRealObj);
      LRealObj := TgtPDReal.Create(Value.Value[1]);
      TgtPDArray(LObj).Add(LRealObj);
      LRealObj := TgtPDReal.Create(Value.Value[2]);
      TgtPDArray(LObj).Add(LRealObj);
      TgtPDDictionary(FBaseObject).Add(PDF_IC, LObj);
    end;
  end;
  FInteriorColor := Value;
end;

(*
procedure TgtPDLineAnnot.SetIT(const Value: AnsiString);
begin

end;
*)


procedure TgtPDLineAnnot.SetLeaderLines(const Value: Real);
begin

end;


procedure TgtPDLineAnnot.SetLineBeginningStyle(const Value: TgtLineStyle);
var
  LObj: TgtPDBaseObject;
  LArrayObj: TgtPDArray;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    case Value of
      laSquare:
        LStyle := PDF_SQUARE;
      laCircle:
        LStyle := PDF_CIRCLE;
      laDiamond:
        LStyle := PDF_DIAMOND;
      laOpenArrow:
        LStyle := PDF_OPENARROW;
      laClosedArrow:
        LStyle := PDF_CLOSEDARROW;
      laNone:
        LStyle := PDF_NONE;
      laButt:
        LStyle := PDF_BUTT;
      laROpenArrow:
        LStyle := PDF_ROPENARROW;
      laRClosedArrow:
        LStyle := PDF_RCLOSEDARROW;
      laSlash:
        LStyle := PDF_SLASH;
    end;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
    if Assigned(LObj) then
    begin
      TgtPDName(TgtPDArray(LObj).Get(0)).Value := LStyle;
    end
    else
    begin
      LArrayObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LObj := TgtPDName.Create(LStyle);
      LArrayObj.Add(LObj);
      LObj := TgtPDName.Create(PDF_None); // setting 2nd value to default value
      LArrayObj.Add(LObj);
      TgtPDDictionary(FBaseObject).Add(PDF_LE, LArrayObj);
    end;
  end;
  FLineBeginningStyle := Value;
end;

procedure TgtPDLineAnnot.SetLineEndingStyle(const Value: TgtLineStyle);
var
  LObj: TgtPDBaseObject;
  LArrayObj: TgtPDArray;
  LStyle: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    case Value of
      laSquare:
        LStyle := PDF_SQUARE;
      laCircle:
        LStyle := PDF_CIRCLE;
      laDiamond:
        LStyle := PDF_DIAMOND;
      laOpenArrow:
        LStyle := PDF_OPENARROW;
      laClosedArrow:
        LStyle := PDF_CLOSEDARROW;
      laNone:
        LStyle := PDF_NONE;
      laButt:
        LStyle := PDF_BUTT;
      laROpenArrow:
        LStyle := PDF_ROPENARROW;
      laRClosedArrow:
        LStyle := PDF_RCLOSEDARROW;
      laSlash:
        LStyle := PDF_SLASH;
    end;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_LE);
    if Assigned(LObj) then
    begin
      TgtPDName(TgtPDArray(LObj).Get(1)).Value := LStyle;
    end
    else
    begin
      LArrayObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LObj := TgtPDName.Create(LStyle);
      LArrayObj.Add(LObj);
      LObj := TgtPDName.Create(PDF_None); // setting 2nd value to default value
      LArrayObj.Add(LObj);
      TgtPDDictionary(FBaseObject).Add(PDF_LE, LArrayObj);
    end;
  end;
  FLineEndingStyle := Value;
end;

(*
procedure TgtPDLineAnnot.SetLLF(const Value: Real);
begin

end;
*)

(*
procedure TgtPDLineAnnot.SetLLO(const Value: Real);
begin

end;
*)

procedure TgtPDLineAnnot.SetX1(const Value: Double);
var
  LObj: TgtPDBaseObject;
  LX1: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_L);
    if Assigned(LObj) then
    begin
      LX1 := TgtPDArray(LObj).Get(0);
      if LX1.IsReal then
        TgtPDReal(LX1).Value := Value
      else if LX1.IsInteger then
      begin
        TgtPDArray(LObj).Remove(0);
        LX1 := TgtPDReal.Create(Value);
        TgtPDArray(LObj).Insert(LX1, 0);
      end;
    end;
  end;
  FX1 := Value;
end;

procedure TgtPDLineAnnot.SetX2(const Value: Double);
var
  LObj: TgtPDBaseObject;
  LX2: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_L);
    if Assigned(LObj) then
    begin
      LX2 := TgtPDArray(LObj).Get(1);
      if LX2.IsReal then
        TgtPDReal(LX2).Value := Value
      else if LX2.IsInteger then
      begin
        TgtPDArray(LObj).Remove(1);
        LX2 := TgtPDReal.Create(Value);
        TgtPDArray(LObj).Insert(LX2, 1);
      end;
    end;
  end;
  FX2 := Value;
end;

procedure TgtPDLineAnnot.SetY1(const Value: Double);
var
  LObj: TgtPDBaseObject;
  LY1: TgtPDBaseObject;
  LPageHt: Double;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_L);
    if Assigned(LObj) then
    begin
      LPageHt := 0;
      if Assigned(Page) then
        LPageHt := TgtPDPage(Page).GetPageHeight;
      LY1 := TgtPDArray(LObj).Get(2);
      if LY1.IsReal then
        TgtPDReal(LY1).Value := LPageHt - Value
      else if LY1.IsInteger then
      begin
        TgtPDArray(LObj).Remove(2);
        LY1 := TgtPDReal.Create(LPageHt - Value);
        TgtPDArray(LObj).Insert(LY1, 2);
      end;
    end;
  end;
  FY1 := Value;
end;

procedure TgtPDLineAnnot.SetY2(const Value: Double);
var
  LObj: TgtPDBaseObject;
  LY2: TgtPDBaseObject;
  LPageHt: Double;
begin
  if Assigned(FBaseObject) then
  begin
//    Value := TgtPDPage(Page).GetPageHeight - Value;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_L);
    if Assigned(LObj) then
    begin
      LPageHt := 0;
      if Assigned(Page) then
        LPageHt := TgtPDPage(Page).GetPageHeight;
      LY2 := TgtPDArray(LObj).Get(3);
      if LY2.IsReal then
        TgtPDReal(LY2).Value := LPageHt - Value
      else if LY2.IsInteger then
      begin
        TgtPDArray(LObj).Remove(3);
        LY2 := TgtPDReal.Create(LPageHt - Value);
        TgtPDArray(LObj).Add(LY2);
      end;
    end;
  end;
  FY2 := Value;
end;

end.
