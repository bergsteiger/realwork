unit nsLogEventData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEventData.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsLogEventData" MUID: (55B760CE036A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , LoggingWrapperInterfaces
 , LoggingUnit
 , BaseTypesUnit
;

type
 TnsLogEventData = class(Tl3SimpleObject, InsLogEventData)
  private
   f_LogEventData: ILogEventData;
   f_AsString: AnsiString;
  private
   procedure ToLog(const aData: AnsiString);
  protected
   procedure AddDate(const aData: TDate);
   procedure AddObject(const aData: IUnknown);
   procedure AddString(aData: PAnsiChar);
   procedure AddULong(aData: Longword);
   function AsLogEventData: ILogEventData;
   function AsString: AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Make: InsLogEventData; reintroduce;
 end;//TnsLogEventData

implementation

uses
 l3ImplUses
 , DataAdapter
 , bsConvert
 , DateUtils
 , SysUtils
 //#UC START# *55B760CE036Aimpl_uses*
 //#UC END# *55B760CE036Aimpl_uses*
;

class function TnsLogEventData.Make: InsLogEventData;
var
 l_Inst : TnsLogEventData;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsLogEventData.Make

procedure TnsLogEventData.ToLog(const aData: AnsiString);
//#UC START# *55BA419F0230_55B760CE036A_var*
//#UC END# *55BA419F0230_55B760CE036A_var*
begin
//#UC START# *55BA419F0230_55B760CE036A_impl*
 f_AsString := f_AsString + '[' + aData + ']';
//#UC END# *55BA419F0230_55B760CE036A_impl*
end;//TnsLogEventData.ToLog

procedure TnsLogEventData.AddDate(const aData: TDate);
//#UC START# *55B75F7202BE_55B760CE036A_var*
//#UC END# *55B75F7202BE_55B760CE036A_var*
begin
//#UC START# *55B75F7202BE_55B760CE036A_impl*
 ToLog(DateToStr(bsAdapterToBusiness(aData)));
 f_LogEventData.AddDate(aData);
//#UC END# *55B75F7202BE_55B760CE036A_impl*
end;//TnsLogEventData.AddDate

procedure TnsLogEventData.AddObject(const aData: IUnknown);
//#UC START# *55B75FA00176_55B760CE036A_var*
//#UC END# *55B75FA00176_55B760CE036A_var*
begin
//#UC START# *55B75FA00176_55B760CE036A_impl*
 ToLog('obj');
 f_LogEventData.AddObject(aData);
//#UC END# *55B75FA00176_55B760CE036A_impl*
end;//TnsLogEventData.AddObject

procedure TnsLogEventData.AddString(aData: PAnsiChar);
//#UC START# *55B75FBE02BE_55B760CE036A_var*
//#UC END# *55B75FBE02BE_55B760CE036A_var*
begin
//#UC START# *55B75FBE02BE_55B760CE036A_impl*
 ToLog(aData);
 f_LogEventData.AddString(aData);
//#UC END# *55B75FBE02BE_55B760CE036A_impl*
end;//TnsLogEventData.AddString

procedure TnsLogEventData.AddULong(aData: Longword);
//#UC START# *55B75FD7031E_55B760CE036A_var*
//#UC END# *55B75FD7031E_55B760CE036A_var*
begin
//#UC START# *55B75FD7031E_55B760CE036A_impl*
 ToLog(IntToStr(aData));
 f_LogEventData.AddULong(aData);
//#UC END# *55B75FD7031E_55B760CE036A_impl*
end;//TnsLogEventData.AddULong

function TnsLogEventData.AsLogEventData: ILogEventData;
//#UC START# *55B76037036D_55B760CE036A_var*
//#UC END# *55B76037036D_55B760CE036A_var*
begin
//#UC START# *55B76037036D_55B760CE036A_impl*
 Result := f_LogEventData;
//#UC END# *55B76037036D_55B760CE036A_impl*
end;//TnsLogEventData.AsLogEventData

function TnsLogEventData.AsString: AnsiString;
//#UC START# *55BA030300BA_55B760CE036A_var*
//#UC END# *55BA030300BA_55B760CE036A_var*
begin
//#UC START# *55BA030300BA_55B760CE036A_impl*
 Result := f_AsString;
//#UC END# *55BA030300BA_55B760CE036A_impl*
end;//TnsLogEventData.AsString

procedure TnsLogEventData.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55B760CE036A_var*
//#UC END# *479731C50290_55B760CE036A_var*
begin
//#UC START# *479731C50290_55B760CE036A_impl*
 f_LogEventData := nil;
 inherited;
//#UC END# *479731C50290_55B760CE036A_impl*
end;//TnsLogEventData.Cleanup

procedure TnsLogEventData.InitFields;
//#UC START# *47A042E100E2_55B760CE036A_var*
//#UC END# *47A042E100E2_55B760CE036A_var*
begin
//#UC START# *47A042E100E2_55B760CE036A_impl*
 inherited;
 f_LogEventData := DefDataAdapter.NativeAdapter.MakeLogEventData;
 f_AsString := '';
//#UC END# *47A042E100E2_55B760CE036A_impl*
end;//TnsLogEventData.InitFields

end.
