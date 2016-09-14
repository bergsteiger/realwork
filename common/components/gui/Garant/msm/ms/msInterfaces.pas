unit msInterfaces;

interface

uses
 System.Types,
 System.Classes,
 FMX.Graphics,
 System.UITypes,
 msSerializeInterfaces,
 Generics.Collections,
 FMX.Objects,
 Data.DBXJSONReflect,
 msLineF,
 System.Math.Vectors,
 FMX.Types
 ;

type
 Pixel = msLineF.Pixel;

 TTextAlign = FMX.Types.TTextAlign;

 TPathData = FMX.Graphics.TPathData;

 TPolygon = System.Math.Vectors.TPolygon;

 ImsShape = interface;

 TPointF = System.Types.TPointF;

 ImsShapeByPt = interface
  function ShapeByPt(const aPoint: TPointF): ImsShape;
 end;//ImsShapeByPt

 ImsShapesController = interface(ImsShapeByPt)
  procedure RemoveShape(const aShape: ImsShape);
  function AddShape(const aShape: ImsShape): ImsShape;
  procedure Invalidate;
  function ShapeCount: Integer;
 end;//ImsShapesController
 // - ��� �� ����� ������������� ������������ �����������, �� Delphi ��� �� ������������
 // � ��� � UML - �� ��� ����� �����������

 TmsDrawContext  = record
 // [��������� (������ ��������������)|https://ru.wikipedia.org/wiki/%D0%A1%D0%BE%D1%81%D1%82%D0%BE%D1%8F%D0%BD%D0%B8%D0%B5_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)]
 // �������� ���������.
 // "������" - ��� - http://habrahabr.ru/post/170125/
 // �� � "���������" - https://ru.wikipedia.org/wiki/%D0%A1%D1%82%D1%80%D0%B0%D1%82%D0%B5%D0%B3%D0%B8%D1%8F_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
 //
 // ����� �� ��� ����� "��������"?
 //
 // �� - ��������. ����� �� ������� ��������� �������. ����� �������?
  public
   rCanvas : TCanvas;
   rMoving : Boolean; // - ����������, ��� ������� �������� �������� - ���������
   rOpacity: Single;
   rLineOpacity: Single;
   constructor Create(const aCanvas : TCanvas);
 end;//TmsDrawContext

 TAlphaColor = System.UITypes.TAlphaColor;
 TAlphaColorRec = System.UITypes.TAlphaColorRec;
 TStrokeDash = FMX.Graphics.TStrokeDash;

 TmsColorRec = record
  rIsSet : Boolean;
  rValue : TAlphaColor;
  class operator Implicit(aValue: TAlphaColor): TmsColorRec;
 end;//TmsColorRec

 TmsPixelRec = record
  rIsSet : Boolean;
  rValue : Pixel;
  class operator Implicit(aValue: Pixel): TmsPixelRec;
 end;//TmsPixelRec

 TmsRadiusRec = record
  rIsSet : Boolean;
  rValue : Pixel;
  class operator Implicit(aValue: Pixel): TmsRadiusRec;
 end;//TmsRadiusRec

 TmsStrokeDash = record
  rIsSet : Boolean;
  rValue : TStrokeDash;
  class operator Implicit(aValue: TStrokeDash): TmsStrokeDash;
 end;//TmsStrokeDash

 TmsDrawOptionsContext = record
  public
   rFillColor: TAlphaColor;
   rStrokeDash: TStrokeDash;
   rStrokeColor: TAlphaColor;
   rStrokeThickness: Single;
   rOpacity: Single;
   rLineOpacity: Single;
   constructor Create(const aCtx: TmsDrawContext);
 end;//TmsDrawOptionsContext

 ImsDiagrammsHolder = interface;

 TmsMakeShapeContext = record
  public
   rStartPoint: TPointF;
   rShapesController: ImsShapesController;
   rDiagrammsHolder: ImsDiagrammsHolder;
   constructor Create(aStartPoint: TPointF; const aShapesController: ImsShapesController; const aDiagrammsHolder: ImsDiagrammsHolder);
 end;//TmsMakeShapeContext

 TmsEndShapeContext = TmsMakeShapeContext;

 ImsDiagramm = interface;

 TmsDiagrammsEnumerator = TEnumerator<ImsDiagramm>;

 ImsShapesProvider = interface(ImsPersistent)
  procedure ShapesForToolbarToList(aList: TStrings);
 end;//ImsShapesProvider

 ImsDiagrammsList = interface(ImsShapesProvider)
  function GetEnumerator: TmsDiagrammsEnumerator;
  function IndexOf(const anItem: ImsDiagramm): Integer;
  function AddNewDiagramm: ImsDiagramm;
  procedure Add(const aDiagramm: ImsDiagramm);
  function  SelectDiagramm(const aDiagrammName: String): ImsDiagramm;
  function FirstDiagramm: ImsDiagramm;
  procedure DiagrammsForToolbarToList(aList: TStrings);
  function pm_GetCount: Integer;
  property Count: Integer
   read pm_GetCount;
 end;//ImsDiagrammsList

 ImsShapeClass = interface;

 ImsShapeCreator = interface;

 TmsClickContext = record
  public
   rShapeCreator: ImsShapeCreator;
   rClickPoint: TPointF;
   rDiagrammsHolder : ImsDiagrammsHolder;
   rShift: TShiftState;
   constructor Create(const aShapeCreator: ImsShapeCreator; const aClickPoint: TPointF; const aDiagrammsHolder : ImsDiagrammsHolder; const aShift: TShiftState);
 end;//TmsClickContext

 TmsMoveContext = record
  public
   rStartPoint: TPointF;
   rDelta: TPointF;
   rShapesController: ImsShapesController;
   constructor Create(const aStartPoint: TPointF; const aDelta: TPointF; const aShapesController: ImsShapesController);
 end;//TmsMoveContext

 TRectF = System.Types.TRectF;

 // TGUID.NewGUID - ����� �� ������

 TmsUID = record
  public
   rLo: Int64;
   rHi: Int64;
  public
   class operator Add(anUID: TmsUID; aDelta: Int64): TmsUID;
   class operator Subtract(anUID: TmsUID; aDelta: Int64): TmsUID;
   constructor Create(const aGUID: TGUID);
   class function CreateNew: TmsUID; static;
   function IsNull: Boolean;
 end;//TmsUID

 TmsShapeUID = record
  public
   rValue: TmsUID;
  public
   constructor Create(const aGUID: TGUID);
   class function CreateNew: TmsShapeUID; static;
   class operator Add(anUID: TmsShapeUID; aDelta: Int64): TmsShapeUID;
   class operator Subtract(anUID: TmsShapeUID; aDelta: Int64): TmsShapeUID;
   class operator Implicit(aValue: Int64): TmsShapeUID;
   class operator Implicit(const aValue: TmsUID): TmsShapeUID;
   function IsNull: Boolean;
 end;//TmsShapeUID

 ImsShapeView = interface
  procedure DrawShape(const aCtx: TmsDrawContext; const aShape: ImsShape);
  function ShapeContainsPt(const aShape: ImsShape; const aPoint: TPointF): Boolean;
 end;//ImsShapeView

 ImsShape = interface(ImsDiagrammsList)
 ['{70D5F6A0-1025-418B-959B-0CF524D8E394}']
  procedure DrawTo(const aCtx: TmsDrawContext);
  function IsNeedsSecondClick : Boolean;
  function MouseUp(const aClickContext: TmsEndShapeContext): Boolean;
  function EndTo(const aCtx: TmsEndShapeContext): Boolean;
  function HitTest(const aPoint: TPointF; out theShape: ImsShape): Boolean;
  procedure MoveBy(const aCtx: TmsMoveContext);
  function NullClick(const aHolder: ImsDiagrammsHolder): Boolean;
  function ClickInDiagramm: Boolean;
  // - ������ � �������� ������ ���������
  function DrawBounds: TRectF;
  procedure MouseMove(const aClickContext: TmsEndShapeContext);
  // - ��������� �������
  function UID: TmsShapeUID;

  function TransformFinishPoint(anAngle: Single): TPointF;
  // - ��� ��� �� ������ �������
  // - ������� ����

  function Polygon: TPolygon;

  function pm_GetStartPoint: TPointF;
  function pm_GetFinishPoint: TPointF;
  function pm_GetShapeClass: ImsShapeClass;
  property StartPoint: TPointF
   read pm_GetStartPoint;
  property FinishPoint: TPointF
   read pm_GetFinishPoint;
  property ShapeClass: ImsShapeClass
   read pm_GetShapeClass;
  function Name: String;
 end;//ImsShape

 TmsWeakRef<T> = record
 // ������ ������ �� ���������
 private
  type PT = ^T;
 private
  rRef : Pointer;
 public
  function AsRef: T; inline;
  constructor Create(const aT: T);
  class operator Equal(const A: TmsWeakRef<T>; const B: TmsWeakRef<T>): Boolean; inline;
  class operator Equal(const A: TmsWeakRef<T>; const B: T): Boolean; inline;
  class operator Implicit(const aValue: T): TmsWeakRef<T>; inline;
  class operator Implicit(const aValue: TmsWeakRef<T>): T; inline;
 end;//TmsWeakRef

 TmsWeakShapeRef = TmsWeakRef<ImsShape>;

 TmsShapesEnumerator = TEnumerator<ImsShape>;

 ImsShapeCreator = interface
 // [���������_�����_(������_��������������)|https://ru.wikipedia.org/wiki/%D0%A4%D0%B0%D0%B1%D1%80%D0%B8%D1%87%D0%BD%D1%8B%D0%B9_%D0%BC%D0%B5%D1%82%D0%BE%D0%B4_(%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD_%D0%BF%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)]
  function CreateShape(const aContext: TmsMakeShapeContext): ImsShape; overload;
  function CreateShape(const aStartPoint: TPointF): ImsShape; overload;
 end;//ImsShapeCreator

 ImsShapeCreatorFriend = interface
 // - ��� "�������", �� ���� ���. ����� �� ������ ����.
  ['{59C7ED7A-C4C7-4632-A59C-2CBF070FCA19}']
  function ShapeClassForCreate: TClass;
 end;//ImsShapeCreatorFriend

 TmsJSONMarshal = TJSONMarshal;
 TmsJSONUnMarshal = TJSONUnMarshal;

 ImsDiagrammsHolder = interface
  procedure UpToParent;
  // - ������������� � ���, ��� ��� ���� ������� � ������������ ���������
  procedure SwapParents;
  // - ������������� � ���, ��� ���� �������� ������� ������������ ���������
  procedure Scroll(const aDirection: TPointF);
                // ^ - �� ����������� ������� const ����� ��������.
                //  ������ ������� ����������� !!!
  // - ��������� ��������� �� ������
  procedure ResetOrigin;
  // - ��������������� ��������� ������� ���������
  function GenerateUID(const aShape: ImsShape): TmsShapeUID;
  // - ������ UID ��� ��������� aShape
  function pm_GetCurrentDiagramms: ImsDiagrammsList;
  procedure pm_SetCurrentDiagramms(const aValue: ImsDiagrammsList);
  property CurrentDiagramms : ImsDiagrammsList
   read pm_GetCurrentDiagramms
   write pm_SetCurrentDiagramms;
 end;//ImsDiagrammsHolder

 TmsStereotypePlace = (
  None,
  Center,
  Bottom,
  OneThirty
 );//TmsStereotypePlace

 TmsAdditionalLineCoeff = array of Single;

 ImsShapeClassTuner = interface
  function AsMC: ImsShapeClass;
  function SetFillColor(aColor: TAlphaColor): ImsShapeClassTuner;
  function SetStrokeColor(aColor: TAlphaColor): ImsShapeClassTuner;
  function SetInitialHeight(aValue: Pixel): ImsShapeClassTuner;
  function SetInitialHeightScale(aValue: Single): ImsShapeClassTuner;
  function SetCornerRadius(aValue: Single): ImsShapeClassTuner;
  function SetStrokeThickness(aValue: Pixel): ImsShapeClassTuner;
  function SetStrokeDash(aValue: TStrokeDash): ImsShapeClassTuner;
  function SetInitialWidth(aValue: Pixel): ImsShapeClassTuner;
  function SetIsForToolbar(aValue: Boolean): ImsShapeClassTuner;
  function SetStereotypePlace(aValue: TmsStereotypePlace): ImsShapeClassTuner;
  function SetSVGCode(const aValue: String): ImsShapeClassTuner;
  function SetAdditionalLinesH(const aValue: TmsAdditionalLineCoeff): ImsShapeClassTuner;
  function SetShapeView(const aValue: ImsShapeView): ImsShapeClassTuner;
  function SetText(const aValue: String): ImsShapeClassTuner;
  function SetArrowHeadShapeMC(const aValue: ImsShapeClass): ImsShapeClassTuner;
 end;//ImsShapeClassTuner

 TmsShapeClassName = record
  rValue : String;
  class operator Implicit(const aValue: String): TmsShapeClassName;
  class operator Implicit(const aSelf: TmsShapeClassName): String;
  class operator Equal(const A: TmsShapeClassName; const B: TmsShapeClassName): Boolean;
 end;//TmsShapeClassName

 TmsShapeStereotype = TmsShapeClassName;

 ImsShapeClass = interface
  function IsForToolbar: Boolean;
  function IsTool: Boolean;
  function IsLineLike: Boolean;
  function IsConnectorLike: Boolean;
  function Creator: ImsShapeCreator;
  function Name: TmsShapeClassName;
  procedure RegisterInMarshal(aMarshal: TmsJSONMarshal);
  procedure RegisterInUnMarshal(aMarshal: TmsJSONUnMarshal);
  function IsNullClick: Boolean;
  function ButtonShape: ImsShape;
  function IsOurInstance(const aShape: ImsShape): Boolean;
  function NullClick(const aHolder: ImsDiagrammsHolder): Boolean;
  function Stereotype: TmsShapeStereotype;
  procedure TransformDrawOptionsContext(var theCtx: TmsDrawOptionsContext);
  function InitialHeight: Pixel;
  function InitialWidth: Pixel;
  function CornerRadius: Pixel;
  function ParentMC: ImsShapeClass;
  function AsTuner: ImsShapeClassTuner;
  function StereotypePlace: TmsStereotypePlace;
  function SVGCode: String;
  function AdditionalLinesH: TmsAdditionalLineCoeff;
  function Specify(const aName: String): ImsShapeClassTuner;
  function CreateShape(const aStartPoint: TPointF): ImsShape; overload;
  function CreateShape(const aContext: TmsMakeShapeContext): ImsShape; overload;
  function ShapeView: ImsShapeView;
  function Text: String;
  function ArrowHeadShapeMC: ImsShapeClass;
 end;//ImsShapeClass

 ImsDiagramm = interface(ImsShapesProvider)
 ['{59F2D068-F06F-4378-9ED4-888DFE8DFAF2}']
  function Get_Name: String;
  procedure Invalidate;
  procedure MouseDown(const aClickContext: TmsClickContext);
  procedure MouseUp(const aClickContex: TmsClickContext);
  procedure MouseMove(const aClickContex: TmsClickContext);
  procedure Clear;
  procedure DrawTo(const aCanvas: TCanvas);
  procedure SaveToPng(const aFileName: String);
  function AddShape(const aShape: ImsShape): ImsShape;
  procedure RemoveShape(const aShape: ImsShape);
  function GetEnumerator: TmsShapesEnumerator;
  function ItemsCount: Integer;
  function FirstShape: ImsShape;
  function ShapesController: ImsShapesController;
  property Name: String
  read Get_Name;
 end;//ImsDiagramm

 ImsDiagramms = interface(ImsDiagrammsList)
  procedure Serialize;
  procedure DeSerialize;
 end;//ImsDiagramms

 ImsInvalidator = interface
  procedure InvalidateDiagramm(const aDiagramm: ImsDiagramm);
  procedure DiagrammAdded(const aDiagramms: ImsDiagrammsList; const aDiagramm: ImsDiagramm);
 end;//ImsInvalidator

 ImsDiagrammsController = interface
  procedure Clear;
  procedure DrawTo(const aCanvas: TCanvas);
  function As_ImsDiagrammsHolder: ImsDiagrammsHolder;
 end;//ImsDiagrammsController

 TmsWeakInvalidatorRef = TmsWeakRef<ImsInvalidator>;

 TmsWeakShapeClassRef = TmsWeakRef<ImsShapeClass>;

implementation

uses
 Math,
 System.StrUtils,
 System.SysUtils
 ;

// TmsDrawContext

constructor TmsDrawContext.Create(const aCanvas : TCanvas);
begin
 rCanvas := aCanvas;
 rMoving := false;
 rOpacity := 0.5;
 rLineOpacity := 1.0;
end;

// TmsMakeShapeContext

constructor TmsMakeShapeContext.Create(aStartPoint: TPointF; const aShapesController: ImsShapesController; const aDiagrammsHolder: ImsDiagrammsHolder);
begin
 rStartPoint := aStartPoint;
 rShapesController := aShapesController;
 rDiagrammsHolder := aDiagrammsHolder;
end;

// TmsDrawOptionsContext

constructor TmsDrawOptionsContext.Create(const aCtx: TmsDrawContext);
begin
 rFillColor := TAlphaColorRec.Null;
 rOpacity := 0.5;
 rLineOpacity := 1.0;
 if aCtx.rMoving then
 begin
  rStrokeDash := TStrokeDash.DashDot;
  rStrokeColor := TAlphaColors.Darkmagenta;
  rStrokeThickness := 4;
 end//aCtx.rMoving
 else
 begin
  rStrokeDash := TStrokeDash.Solid;
  rStrokeColor := TAlphaColorRec.Black;
  rStrokeThickness := 1;
 end;//aCtx.rMoving
end;

// TmsClickContext

constructor TmsClickContext.Create(const aShapeCreator: ImsShapeCreator; const aClickPoint: TPointF; const aDiagrammsHolder : ImsDiagrammsHolder; const aShift: TShiftState);
begin
 rShapeCreator := aShapeCreator;
 rClickPoint := aClickPoint;
 rDiagrammsHolder := aDiagrammsHolder;
 rShift := aShift;
end;

// TmsMoveContext

constructor TmsMoveContext.Create(const aStartPoint: TPointF; const aDelta: TPointF; const aShapesController: ImsShapesController);
begin
 rStartPoint := aStartPoint;
 rDelta := aDelta;
 rShapesController := aShapesController;
end;

// TmsColorRec

class operator TmsColorRec.Implicit(aValue: TAlphaColor): TmsColorRec;
begin
 Result.rIsSet := true;
 Result.rValue := aValue;
end;

// TmsPixelRec

class operator TmsPixelRec.Implicit(aValue: Pixel): TmsPixelRec;
begin
 if IsZero(aValue) OR (aValue < 0) then
  Result.rIsSet := false
 else
 begin
  Result.rIsSet := true;
  Result.rValue := aValue;
 end;//IsZero(aValue) OR (aValue < 0)
end;

// TmsRadiusRec

class operator TmsRadiusRec.Implicit(aValue: Pixel): TmsRadiusRec;
begin
 if (aValue < 0) then
  Result.rIsSet := false
 else
 begin
  Result.rIsSet := true;
  Result.rValue := aValue;
 end;//(aValue < 0)
end;

// TmsStrokeDash

class operator TmsStrokeDash.Implicit(aValue: TStrokeDash): TmsStrokeDash;
begin
 Result.rIsSet := true;
 Result.rValue := aValue;
end;

// TmsShapeClassName

class operator TmsShapeClassName.Implicit(const aValue: String): TmsShapeClassName;
const
 cPref = 'Tms';
begin
 Result.rValue := aValue;
 if ANSIStartsText(cPref, Result.rValue) then
  Result.rValue := Copy(Result.rValue, Length(cPref) + 1, Length(Result.rValue) - Length(cPref));
end;

class operator TmsShapeClassName.Implicit(const aSelf: TmsShapeClassName): String;
begin
 Result := aSelf.rValue;
end;

class operator TmsShapeClassName.Equal(const A: TmsShapeClassName; const B: TmsShapeClassName): Boolean;
begin
 Result := (A.rValue = B.rValue);
end;

// TmsUID

class function TmsUID.CreateNew: TmsUID;
begin
 Result := TmsUID.Create(TGUID.NewGUID);
end;

constructor TmsUID.Create(const aGUID: TGUID);
begin
 Assert(SizeOf(Self) = SizeOf(aGUID));
 Move(aGUID, Self, SizeOf(Self));
end;

class operator TmsUID.Add(anUID: TmsUID; aDelta: Int64): TmsUID;
begin
 Result := anUID;
 Assert(SizeOf(anUID) = SizeOf(TGUID));
 Assert(aDelta >= 0);
 if (aDelta > 0) then
 begin
  if (anUID.rLo - aDelta < High(anUID.rLo)) then
  begin
   Result.rLo := anUID.rLo + aDelta;
   Result.rHi := 0;
  end//anUID.rLo - aDelta < High(anUID.rLo)
  else
  begin
   Assert(false, '�� �����������');
   Assert(anUID.rHi - aDelta < High(anUID.rHi), '�� �����������');
   Result.rHi := anUID.rHi + 1;
   Result.rLo := 0;
   Result := Result + (aDelta - 1);
  end;//anUID.rLo - aDelta < High(anUID.rLo)
 end;//aDelta > 0
end;

class operator TmsUID.Subtract(anUID: TmsUID; aDelta: Int64): TmsUID;
begin
 Result := anUID;
 Assert(aDelta >= 0);
 if (aDelta > 0) then
 begin
  Assert(false, '�� �����������');
 end;//aDelta > 0
end;

function TmsUID.IsNull: Boolean;
begin
 Result := (rLo = 0) AND (rHi = 0);
end;

// TmsShapeUID

constructor TmsShapeUID.Create(const aGUID: TGUID);
begin
 rValue := TmsUID.Create(aGUID);
end;

class function TmsShapeUID.CreateNew: TmsShapeUID;
begin
 Result.rValue := TmsUID.CreateNew;
end;

class operator TmsShapeUID.Add(anUID: TmsShapeUID; aDelta: Int64): TmsShapeUID;
begin
 Result.rValue := anUID.rValue + aDelta;
end;

class operator TmsShapeUID.Subtract(anUID: TmsShapeUID; aDelta: Int64): TmsShapeUID;
begin
 Result.rValue := anUID.rValue - aDelta;
end;

class operator TmsShapeUID.Implicit(aValue: Int64): TmsShapeUID;
begin
 Result.rValue.rLo := aValue;
 Result.rValue.rHi := 0;
end;

class operator TmsShapeUID.Implicit(const aValue: TmsUID): TmsShapeUID;
begin
 Result.rValue := aValue;
end;

function TmsShapeUID.IsNull: Boolean;
begin
 Result := rValue.IsNull;
end;

// TmsWeakRef<T>

constructor TmsWeakRef<T>.Create(const aT: T);
begin
 Assert(SizeOf(aT) = SizeOf(Self.rRef));
 Self.rRef := PPointer(@aT)^;
end;

function TmsWeakRef<T>.AsRef: T;
begin
 Assert(SizeOf(Self.rRef) = SizeOf(Result));
 Result := PT(@Self.rRef)^;
end;

class operator TmsWeakRef<T>.Implicit(const aValue: TmsWeakRef<T>): T;
begin
 Result := aValue.AsRef;
end;

class operator TmsWeakRef<T>.Equal(const A: TmsWeakRef<T>; const B: TmsWeakRef<T>): Boolean;
begin
 Result := (A.rRef = B.rRef);
end;

class operator TmsWeakRef<T>.Equal(const A: TmsWeakRef<T>; const B: T): Boolean;
begin
 Assert(SizeOf(B) = SizeOf(A));
 Result := (A.rRef = PPointer(@B)^);
end;

class operator TmsWeakRef<T>.Implicit(const aValue: T): TmsWeakRef<T>;
begin
 Result := TmsWeakRef<T>.Create(aValue);
end;

end.
