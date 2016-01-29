unit evDelayedPaintersSpy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evDelayedPaintersSpy.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevDelayedPaintersSpy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters)}
uses
  l3Filer,
  l3LongintList,
  evSelectedParts,
  l3ProtoObject
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 IevDelayedPainterLogger = interface(IUnknown)
   ['{87EBBF2A-E6CC-41AF-A26B-012D8BB879CB}']
   function OpenSelectionLog: AnsiString;
   procedure CloseSelectionLog(const aLogName: AnsiString);
 end;//IevDelayedPainterLogger

 TevDelayedPaintersSpy = class(Tl3ProtoObject)
 private
 // private fields
   f_Logger : IevDelayedPainterLogger;
   f_Filer : Tl3CustomFiler;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   procedure SetLogger(const aLogger: IevDelayedPainterLogger);
   procedure RemoveLogger(const aLogger: IevDelayedPainterLogger);
   class function Exists: Boolean;
   procedure LogSelections(const aSelParts: TevSelectedParts;
     const aRowHeights: Tl3LongintList);
 public
 // singleton factory method
   class function Instance: TevDelayedPaintersSpy;
    {- возвращает экземпляр синглетона. }
 end;//TevDelayedPaintersSpy
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  l3Base {a},
  SysUtils,
  l3Types
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}


// start class TevDelayedPaintersSpy

var g_TevDelayedPaintersSpy : TevDelayedPaintersSpy = nil;

procedure TevDelayedPaintersSpyFree;
begin
 l3Free(g_TevDelayedPaintersSpy);
end;

class function TevDelayedPaintersSpy.Instance: TevDelayedPaintersSpy;
begin
 if (g_TevDelayedPaintersSpy = nil) then
 begin
  l3System.AddExitProc(TevDelayedPaintersSpyFree);
  g_TevDelayedPaintersSpy := Create;
 end;
 Result := g_TevDelayedPaintersSpy;
end;


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
//#UC START# *4D6F440500EE_4D6F3F42007C_var*
//#UC END# *4D6F440500EE_4D6F3F42007C_var*
begin
//#UC START# *4D6F440500EE_4D6F3F42007C_impl*
 Result := g_TevDelayedPaintersSpy <> nil;
//#UC END# *4D6F440500EE_4D6F3F42007C_impl*
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

procedure TevDelayedPaintersSpy.Cleanup;
//#UC START# *479731C50290_4D6F3F42007C_var*
//#UC END# *479731C50290_4D6F3F42007C_var*
begin
//#UC START# *479731C50290_4D6F3F42007C_impl*
 FreeAndNil(f_Filer);
 inherited Cleanup;
//#UC END# *479731C50290_4D6F3F42007C_impl*
end;//TevDelayedPaintersSpy.Cleanup

procedure TevDelayedPaintersSpy.ClearFields;
 {-}
begin
 {$If defined(evNeedPainters)}
 f_Logger := nil;
 {$IfEnd} //evNeedPainters
 inherited;
end;//TevDelayedPaintersSpy.ClearFields

{$IfEnd} //evNeedPainters

end.