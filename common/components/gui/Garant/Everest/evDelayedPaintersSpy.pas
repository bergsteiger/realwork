unit evDelayedPaintersSpy;

// Модуль: "w:\common\components\gui\Garant\Everest\evDelayedPaintersSpy.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDelayedPaintersSpy" MUID: (4D6F3F42007C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
 , evSelectedParts
 , l3LongintList
;

type
 TevDelayedPaintersSpy = class;

 IevDelayedPainterLogger = interface
  ['{87EBBF2A-E6CC-41AF-A26B-012D8BB879CB}']
  function OpenSelectionLog: AnsiString;
  procedure CloseSelectionLog(const aLogName: AnsiString);
 end;//IevDelayedPainterLogger

 TevDelayedPaintersSpy = class(Tl3ProtoObject)
  private
   f_Logger: IevDelayedPainterLogger;
   f_Filer: Tl3CustomFiler;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure SetLogger(const aLogger: IevDelayedPainterLogger);
   procedure RemoveLogger(const aLogger: IevDelayedPainterLogger);
   class function Exists: Boolean;
   procedure LogSelections(const aSelParts: TevSelectedParts;
    const aRowHeights: Tl3LongintList);
   class function Instance: TevDelayedPaintersSpy;
    {* Метод получения экземпляра синглетона TevDelayedPaintersSpy }
 end;//TevDelayedPaintersSpy
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Base
 //#UC START# *4D6F3F42007Cimpl_uses*
 //#UC END# *4D6F3F42007Cimpl_uses*
;

var g_TevDelayedPaintersSpy: TevDelayedPaintersSpy = nil;
 {* Экземпляр синглетона TevDelayedPaintersSpy }

procedure TevDelayedPaintersSpyFree;
 {* Метод освобождения экземпляра синглетона TevDelayedPaintersSpy }
begin
 l3Free(g_TevDelayedPaintersSpy);
end;//TevDelayedPaintersSpyFree

procedure TevDelayedPaintersSpy.SetLogger(const aLogger: IevDelayedPainterLogger);
//#UC START# *4D6F41880325_4D6F3F42007C_var*
//#UC END# *4D6F41880325_4D6F3F42007C_var*
begin
//#UC START# *4D6F41880325_4D6F3F42007C_impl*
 Assert(f_Logger = nil);
 f_Logger := aLogger;
//#UC END# *4D6F41880325_4D6F3F42007C_impl*
end;//TevDelayedPaintersSpy.SetLogger

procedure TevDelayedPaintersSpy.RemoveLogger(const aLogger: IevDelayedPainterLogger);
//#UC START# *4D6F43CA0257_4D6F3F42007C_var*
//#UC END# *4D6F43CA0257_4D6F3F42007C_var*
begin
//#UC START# *4D6F43CA0257_4D6F3F42007C_impl*
 Assert(f_Logger = aLogger);
 f_Logger := nil;
//#UC END# *4D6F43CA0257_4D6F3F42007C_impl*
end;//TevDelayedPaintersSpy.RemoveLogger

class function TevDelayedPaintersSpy.Exists: Boolean;
begin
 Result := g_TevDelayedPaintersSpy <> nil;
end;//TevDelayedPaintersSpy.Exists

procedure TevDelayedPaintersSpy.LogSelections(const aSelParts: TevSelectedParts;
 const aRowHeights: Tl3LongintList);
//#UC START# *4D6F4C1700DC_4D6F3F42007C_var*

 function LogSelPart(const Data: TevSelectedPart; Index: Integer): Boolean;
 var
  l_SelPart: TevSelectedPart;
 begin
  Result := True;
  f_Filer.WriteLn('-------------------');
  with Data do
  begin
   f_Filer.WriteLn(Format('"Row Height" : %d', [aRowHeights[rRowIndex]]));
   f_Filer.WriteLn(Format('"Width" : %d', [rWidth]));
   f_Filer.WriteLn(Format('"WindowOrg" : %d, %d', [rWindowOrg.X, rWindowOrg.Y]));
  end; // with l_SelPart do
 end;

var
 l_LogName : String;
//#UC END# *4D6F4C1700DC_4D6F3F42007C_var*
begin
//#UC START# *4D6F4C1700DC_4D6F3F42007C_impl*
 if (f_Logger <> nil) then
 begin
  l_LogName := f_Logger.OpenSelectionLog;
  try
   f_Filer := Tl3CustomDOSFiler.Make(l_LogName, l3_fmWrite);
   try
    f_Filer.Open;
    try
     f_Filer.WriteLn('-------------------');
     f_Filer.WriteLn('Данные о выделении:');
     aSelParts.IterateAllF(l3L2IA(@LogSelPart));
    finally
     f_Filer.Close;
    end;//try..finally
   finally
    FreeAndNil(f_Filer);
   end;//try..finally
  finally
   f_Logger.CloseSelectionLog(l_LogName);
  end;//try..finally
 end;//f_Logger <> nil
//#UC END# *4D6F4C1700DC_4D6F3F42007C_impl*
end;//TevDelayedPaintersSpy.LogSelections

class function TevDelayedPaintersSpy.Instance: TevDelayedPaintersSpy;
 {* Метод получения экземпляра синглетона TevDelayedPaintersSpy }
begin
 if (g_TevDelayedPaintersSpy = nil) then
 begin
  l3System.AddExitProc(TevDelayedPaintersSpyFree);
  g_TevDelayedPaintersSpy := Create;
 end;
 Result := g_TevDelayedPaintersSpy;
end;//TevDelayedPaintersSpy.Instance

procedure TevDelayedPaintersSpy.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D6F3F42007C_var*
//#UC END# *479731C50290_4D6F3F42007C_var*
begin
//#UC START# *479731C50290_4D6F3F42007C_impl*
 FreeAndNil(f_Filer);
 inherited Cleanup;
//#UC END# *479731C50290_4D6F3F42007C_impl*
end;//TevDelayedPaintersSpy.Cleanup

procedure TevDelayedPaintersSpy.ClearFields;
begin
 f_Logger := nil;
 inherited;
end;//TevDelayedPaintersSpy.ClearFields
{$IfEnd} // Defined(evNeedPainters)

end.
