unit nevVScrollerSpy;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevVScrollerSpy.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
;

type
 InevVScrollerPosLogger = interface
  ['{118E1374-07D5-47D3-B4EF-C921BCC2BA51}']
  function OpenLog: AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
 end;//InevVScrollerPosLogger

 TnevVScrollerSpy = class(Tl3ProtoObject)
  private
   f_LogName: AnsiString;
   f_Logger: InevVScrollerPosLogger;
   f_Filer: Tl3CustomFiler;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure SetLogger(const aLogger: InevVScrollerPosLogger);
   procedure RemoveLogger(const aLogger: InevVScrollerPosLogger);
   procedure LogPos(aPos: Integer);
   function StartLog: Boolean;
   procedure FinishLog;
   class function Exists: Boolean;
   class function Instance: TnevVScrollerSpy;
    {* Метод получения экземпляра синглетона TnevVScrollerSpy }
 end;//TnevVScrollerSpy

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

var g_TnevVScrollerSpy: TnevVScrollerSpy = nil;
 {* Экземпляр синглетона TnevVScrollerSpy }

procedure TnevVScrollerSpyFree;
 {* Метод освобождения экземпляра синглетона TnevVScrollerSpy }
begin
 l3Free(g_TnevVScrollerSpy);
end;//TnevVScrollerSpyFree

procedure TnevVScrollerSpy.SetLogger(const aLogger: InevVScrollerPosLogger);
//#UC START# *4DAEBD9D0238_4DAEB03E0034_var*
//#UC END# *4DAEBD9D0238_4DAEB03E0034_var*
begin
//#UC START# *4DAEBD9D0238_4DAEB03E0034_impl*
 Assert(f_Logger = nil);
 f_Logger := aLogger;
//#UC END# *4DAEBD9D0238_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.SetLogger

procedure TnevVScrollerSpy.RemoveLogger(const aLogger: InevVScrollerPosLogger);
//#UC START# *4DAEBDF20386_4DAEB03E0034_var*
//#UC END# *4DAEBDF20386_4DAEB03E0034_var*
begin
//#UC START# *4DAEBDF20386_4DAEB03E0034_impl*
 Assert(f_Logger = aLogger);
 f_Logger := nil;
//#UC END# *4DAEBDF20386_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.RemoveLogger

procedure TnevVScrollerSpy.LogPos(aPos: Integer);
//#UC START# *4DAEBE61037F_4DAEB03E0034_var*
//#UC END# *4DAEBE61037F_4DAEB03E0034_var*
begin
//#UC START# *4DAEBE61037F_4DAEB03E0034_impl*
 if (f_Logger <> nil) then
 begin
  Assert(f_Filer <> nil);
  Assert(f_Filer.Opened);
  f_Filer.WriteLn('Позиция скроллера: ' + IntToStr(aPos));
 end;//f_Logger <> nil
//#UC END# *4DAEBE61037F_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.LogPos

function TnevVScrollerSpy.StartLog: Boolean;
//#UC START# *4DAEBE840395_4DAEB03E0034_var*
//#UC END# *4DAEBE840395_4DAEB03E0034_var*
begin
//#UC START# *4DAEBE840395_4DAEB03E0034_impl*
 Result := f_Logger <> nil;
 f_LogName := f_Logger.OpenLog;
 f_Filer := Tl3CustomDOSFiler.Make(f_LogName, l3_fmWrite);
 try
  f_Filer.Open;
 except
  l3Free(f_Filer);
 end;
//#UC END# *4DAEBE840395_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.StartLog

procedure TnevVScrollerSpy.FinishLog;
//#UC START# *4DAEBEBC016B_4DAEB03E0034_var*
//#UC END# *4DAEBEBC016B_4DAEB03E0034_var*
begin
//#UC START# *4DAEBEBC016B_4DAEB03E0034_impl*
 try
  if f_Filer <> nil then
   f_Filer.Close;
 finally
  try
   FreeAndNil(f_Filer);
  finally
   f_Logger.CloseLog(f_LogName);
   f_LogName := '';
  end; 
 end; 
//#UC END# *4DAEBEBC016B_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.FinishLog

class function TnevVScrollerSpy.Exists: Boolean;
//#UC START# *4DAECA8C027C_4DAEB03E0034_var*
//#UC END# *4DAECA8C027C_4DAEB03E0034_var*
begin
//#UC START# *4DAECA8C027C_4DAEB03E0034_impl*
 Result := g_TnevVScrollerSpy <> nil;
//#UC END# *4DAECA8C027C_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.Exists

class function TnevVScrollerSpy.Instance: TnevVScrollerSpy;
 {* Метод получения экземпляра синглетона TnevVScrollerSpy }
begin
 if (g_TnevVScrollerSpy = nil) then
 begin
  l3System.AddExitProc(TnevVScrollerSpyFree);
  g_TnevVScrollerSpy := Create;
 end;
 Result := g_TnevVScrollerSpy;
end;//TnevVScrollerSpy.Instance

procedure TnevVScrollerSpy.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DAEB03E0034_var*
//#UC END# *479731C50290_4DAEB03E0034_var*
begin
//#UC START# *479731C50290_4DAEB03E0034_impl*
 FreeAndNil(f_Filer);
 inherited;
//#UC END# *479731C50290_4DAEB03E0034_impl*
end;//TnevVScrollerSpy.Cleanup

procedure TnevVScrollerSpy.ClearFields;
begin
 f_Logger := nil;
 inherited;
end;//TnevVScrollerSpy.ClearFields

end.
