unit nevShapesPaintedSpy;
 {* Следилка за отрисованными объектами. [RequestLink:235864309] }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevShapesPaintedSpy.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
 , nevTools
 , nevShapesPainted
;

type
 InevShapesLogger = interface
  {* Лог отрисованных объектов }
  ['{D33CDAF3-2F4B-422C-879E-56B02F0686F9}']
  function OpenLog(const aView: InevView): AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
  function LogScreen(const aView: InevView): Boolean;
 end;//InevShapesLogger

 TnevShapesPaintedSpy = class(Tl3ProtoObject)
  {* Следилка за отрисованными объектами. [RequestLink:235864309] }
  private
   f_Logger: InevShapesLogger;
   f_Filer: Tl3CustomFiler;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure LogShapes(const aView: InevView;
    aShapes: TnevBaseTopShape);
    {* Логирует отрисованные объекты }
   procedure SetLogger(const aLogger: InevShapesLogger);
   procedure RemoveLogger(const aLogger: InevShapesLogger);
   class function Exists: Boolean;
   function LogScreen(const aView: InevView): Boolean;
   class function Instance: TnevShapesPaintedSpy;
    {* Метод получения экземпляра синглетона TnevShapesPaintedSpy }
 end;//TnevShapesPaintedSpy

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , k2Tags
 , l3String
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , nevBase
 , l3MinMax
 , l3Base
;

var g_TnevShapesPaintedSpy: TnevShapesPaintedSpy = nil;
 {* Экземпляр синглетона TnevShapesPaintedSpy }

procedure TnevShapesPaintedSpyFree;
 {* Метод освобождения экземпляра синглетона TnevShapesPaintedSpy }
begin
 l3Free(g_TnevShapesPaintedSpy);
end;//TnevShapesPaintedSpyFree

procedure TnevShapesPaintedSpy.LogShapes(const aView: InevView;
 aShapes: TnevBaseTopShape);
 {* Логирует отрисованные объекты }
//#UC START# *4CA5CCF900D5_4CA5CC2C03CF_var*

 procedure LogShape(aShape : TnevShape);

  function MangleCoord(aValue : Integer): Integer;

   function EpsilonIt(aValue : Integer): Integer;
   begin//EpsilonIt
    if (aValue > 0) then
     Result := Max(0, aValue - 20)
    else
    if (aValue < 0) then
     Result := Min(0, aValue + 20)
    else
     Result := aValue;
   end;//EpsilonIt

  begin//MangleCoord
   Result := (EpsilonIt(aValue) div 100) * 100;
  end;//MangleCoord

 var
  l_Index     : Integer;
  l_ImageInfo : PnevControlImageInfo;
 begin//LogShape
  if (aShape <> nil) then
  begin
   f_Filer.WriteLn('----');

   with aShape.__Obj do
   begin
    f_Filer.WriteLn(Format('Obj type = %s', [AsObject.TagType.AsString]));
    if AsObject.HasSubAtom(k2_tiText) then
     f_Filer.WriteLn(Format('Text = ''%s''', [l3ReplaceNonReadable(AsObject.StrA[k2_tiText])]));
   end;//with aShape.__Obj
   if (aShape.Count <> 0) then
    f_Filer.WriteLn(Format('Count = %d', [aShape.Count]));
   with aShape.Bounds do
    f_Filer.WriteLn(Format('Rect = (%d, %d, %d, %d)', [MangleCoord(Top),
                                                       MangleCoord(Left),
                                                       MangleCoord(Bottom),
                                                       MangleCoord(Right)]));
   Assert(aShape.__FI <> nil);
   with aShape.__FI do
   begin
    if (Width <> 0) OR (Height <> 0) then
     f_Filer.WriteLn(Format('Dim = (%d, %d)', [MangleCoord(Width),
                                               MangleCoord(Height)]));
    if Hidden then
     f_Filer.WriteLn(Format('Hidden = %d', [Ord(Hidden)]));
    if (MaxLinesCount <> 0) then
     f_Filer.WriteLn(Format('MaxLinesCount = %d', [MaxLinesCount]));
    if (DeltaHeight <> 0) then
     f_Filer.WriteLn(Format('DeltaHeight = %d', [MangleCoord(DeltaHeight)]));
    if (Zoom <> 100) then
     f_Filer.WriteLn(Format('Zoom = %d', [Zoom]));
    if (Lines <> nil) then
     if (Lines.Count <> 1) then
      f_Filer.WriteLn(Format('LinesCount = %d', [Lines.Count]));
   end;//with aShape.__FI
   if LogScreen(aView) and evHasOwnStyle(aShape.__Obj) then
   begin
    l_ImageInfo := aShape.__FI.ImageInfo;
    if (l_ImageInfo.rFirstIndex > -1) or (l_ImageInfo.rLastIndex > -1) then
    begin
     f_Filer.WriteLn('----');
     f_Filer.WriteLn(Format('ImageInfo FirstIndex = %d, LastIndex = %d', [l_ImageInfo.rFirstIndex, l_ImageInfo.rLastIndex]));
    end; // if EvHasOwnStyle(aShape.__Obj) then
   end; // if EvHasOwnStyle(aShape.__Obj) then
   for l_Index := 0 to Pred(aShape.Count) do
    LogShape(aShape.Items[l_Index]);
  end;//aShape <> nil
 end;//LogShape

var
 l_LogName : String;
//#UC END# *4CA5CCF900D5_4CA5CC2C03CF_var*
begin
//#UC START# *4CA5CCF900D5_4CA5CC2C03CF_impl*
 if (f_Logger <> nil) then
 begin
  l_LogName := f_Logger.OpenLog(aView);
  try
   f_Filer := Tl3CustomDOSFiler.Make(l_LogName, l3_fmWrite);
   try
    f_Filer.Open;
    try
     LogShape(aShapes);
    finally
     f_Filer.Close;
    end;//try..finally
   finally
    FreeAndNil(f_Filer);
   end;//try..finally
  finally
   f_Logger.CloseLog(l_LogName);
  end;//try..finally
 end;//f_Logger <> nil
//#UC END# *4CA5CCF900D5_4CA5CC2C03CF_impl*
end;//TnevShapesPaintedSpy.LogShapes

procedure TnevShapesPaintedSpy.SetLogger(const aLogger: InevShapesLogger);
//#UC START# *4CA5CD6801F6_4CA5CC2C03CF_var*
//#UC END# *4CA5CD6801F6_4CA5CC2C03CF_var*
begin
//#UC START# *4CA5CD6801F6_4CA5CC2C03CF_impl*
 Assert(f_Logger = nil);
 f_Logger := aLogger;
//#UC END# *4CA5CD6801F6_4CA5CC2C03CF_impl*
end;//TnevShapesPaintedSpy.SetLogger

procedure TnevShapesPaintedSpy.RemoveLogger(const aLogger: InevShapesLogger);
//#UC START# *4CA5CD92028D_4CA5CC2C03CF_var*
//#UC END# *4CA5CD92028D_4CA5CC2C03CF_var*
begin
//#UC START# *4CA5CD92028D_4CA5CC2C03CF_impl*
 Assert(f_Logger = aLogger);
 f_Logger := nil;
//#UC END# *4CA5CD92028D_4CA5CC2C03CF_impl*
end;//TnevShapesPaintedSpy.RemoveLogger

class function TnevShapesPaintedSpy.Exists: Boolean;
//#UC START# *4CA5D01A0152_4CA5CC2C03CF_var*
//#UC END# *4CA5D01A0152_4CA5CC2C03CF_var*
begin
//#UC START# *4CA5D01A0152_4CA5CC2C03CF_impl*
 Result := (g_TnevShapesPaintedSpy <> nil);
//#UC END# *4CA5D01A0152_4CA5CC2C03CF_impl*
end;//TnevShapesPaintedSpy.Exists

function TnevShapesPaintedSpy.LogScreen(const aView: InevView): Boolean;
//#UC START# *4CACAF8A0297_4CA5CC2C03CF_var*
//#UC END# *4CACAF8A0297_4CA5CC2C03CF_var*
begin
//#UC START# *4CACAF8A0297_4CA5CC2C03CF_impl*
 Result := (f_Logger <> nil) AND f_Logger.LogScreen(aView);
//#UC END# *4CACAF8A0297_4CA5CC2C03CF_impl*
end;//TnevShapesPaintedSpy.LogScreen

class function TnevShapesPaintedSpy.Instance: TnevShapesPaintedSpy;
 {* Метод получения экземпляра синглетона TnevShapesPaintedSpy }
begin
 if (g_TnevShapesPaintedSpy = nil) then
 begin
  l3System.AddExitProc(TnevShapesPaintedSpyFree);
  g_TnevShapesPaintedSpy := Create;
 end;
 Result := g_TnevShapesPaintedSpy;
end;//TnevShapesPaintedSpy.Instance

procedure TnevShapesPaintedSpy.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CA5CC2C03CF_var*
//#UC END# *479731C50290_4CA5CC2C03CF_var*
begin
//#UC START# *479731C50290_4CA5CC2C03CF_impl*
 FreeAndNil(f_Filer);
 inherited;
//#UC END# *479731C50290_4CA5CC2C03CF_impl*
end;//TnevShapesPaintedSpy.Cleanup

procedure TnevShapesPaintedSpy.ClearFields;
begin
 f_Logger := nil;
 inherited;
end;//TnevShapesPaintedSpy.ClearFields

end.
