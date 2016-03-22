unit l3Logger;

// Модуль: "w:\common\components\rtl\Garant\L3\l3Logger.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3Logger" MUID: (540EE3000176)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ExceptionsLogEx
;

type
 Tl3Logger = class(Tl3ProtoObject)
  private
   f_Log: Tl3ExceptionsLogEx;
   f_EXEName: AnsiString;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Release; override;
   procedure BeforeAddToCache; override;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(const aFileName: AnsiString); reintroduce;
   procedure ToLog(const aString: AnsiString);
 end;//Tl3Logger

implementation

uses
 l3ImplUses
 , SysUtils
 , l3ExceptionsLog
;

constructor Tl3Logger.Create(const aFileName: AnsiString);
//#UC START# *540EE374018F_540EE3000176_var*
//#UC END# *540EE374018F_540EE3000176_var*
begin
//#UC START# *540EE374018F_540EE3000176_impl*
 inherited Create;
 if (f_Log = nil) then
  f_Log := Tl3ExceptionsLogEx.Create(aFileName, false)
 else
  f_Log.LogFileName := aFileName; 
 f_EXEName := ParamStr(0);
 {$If Declared(Gm0EXCLibDefSrv)}
 if (Gm0EXCLibDefSrv <> nil) AND (Gm0EXCLibDefSrv.LogMachineName <> '') then
  f_Log.LogMachineName := Gm0EXCLibDefSrv.LogMachineName;
 {$IfEnd}
//#UC END# *540EE374018F_540EE3000176_impl*
end;//Tl3Logger.Create

procedure Tl3Logger.ToLog(const aString: AnsiString);
//#UC START# *540EF28B00BE_540EE3000176_var*
//#UC END# *540EF28B00BE_540EE3000176_var*
begin
//#UC START# *540EF28B00BE_540EE3000176_impl*
 Assert(Self <> nil);
 Assert(f_Log <> nil);
 f_Log.SaveMessage(Cm0EXCLibINF, aString + ' Application: ' + f_EXEName);
//#UC END# *540EF28B00BE_540EE3000176_impl*
end;//Tl3Logger.ToLog

procedure Tl3Logger.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_540EE3000176_var*
//#UC END# *479731C50290_540EE3000176_var*
begin
//#UC START# *479731C50290_540EE3000176_impl*
 if (f_Log <> nil) then
  f_Log.CloseLogFile;
 inherited;
//#UC END# *479731C50290_540EE3000176_impl*
end;//Tl3Logger.Cleanup

procedure Tl3Logger.Release;
//#UC START# *479F2AFB0397_540EE3000176_var*
//#UC END# *479F2AFB0397_540EE3000176_var*
begin
//#UC START# *479F2AFB0397_540EE3000176_impl*
 FreeAndNil(f_Log);
 inherited;
//#UC END# *479F2AFB0397_540EE3000176_impl*
end;//Tl3Logger.Release

procedure Tl3Logger.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_540EE3000176_var*
//#UC END# *479F2B3302C1_540EE3000176_var*
begin
//#UC START# *479F2B3302C1_540EE3000176_impl*
 if (f_Log <> nil) then
  f_Log.CloseLogFile;
 inherited;
//#UC END# *479F2B3302C1_540EE3000176_impl*
end;//Tl3Logger.BeforeAddToCache

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3Logger.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_540EE3000176_var*
//#UC END# *47A6FEE600FC_540EE3000176_var*
begin
//#UC START# *47A6FEE600FC_540EE3000176_impl*
 Result := true;
//#UC END# *47A6FEE600FC_540EE3000176_impl*
end;//Tl3Logger.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
