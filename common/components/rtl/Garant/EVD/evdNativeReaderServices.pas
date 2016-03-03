unit evdNativeReaderServices;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdNativeReaderServices.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2EVDReaderService
 , l3Interfaces
 , k2CustomFileReader
 , l3Variant
;

type
 TevdEVDReaderService = {final} class(Tl3ProtoObject, Ik2EVDReaderService)
  public
   function MakeReader(const aFileName: AnsiString;
    const aFilter: Ik2TagGenerator): Il3Reader;
   function GetReader: Tk2CustomFileReader;
   class function Instance: TevdEVDReaderService;
    {* Метод получения экземпляра синглетона TevdEVDReaderService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TevdEVDReaderService

implementation

uses
 l3ImplUses
 , evdNativeReader
 , SysUtils
 , l3Base
;

var g_TevdEVDReaderService: TevdEVDReaderService = nil;
 {* Экземпляр синглетона TevdEVDReaderService }

procedure TevdEVDReaderServiceFree;
 {* Метод освобождения экземпляра синглетона TevdEVDReaderService }
begin
 l3Free(g_TevdEVDReaderService);
end;//TevdEVDReaderServiceFree

function TevdEVDReaderService.MakeReader(const aFileName: AnsiString;
 const aFilter: Ik2TagGenerator): Il3Reader;
//#UC START# *6A9002DE6C1A_555DB62E036B_var*
var
 l_Reader : TevdNativeReader;
//#UC END# *6A9002DE6C1A_555DB62E036B_var*
begin
//#UC START# *6A9002DE6C1A_555DB62E036B_impl*
 l_Reader := TevdNativeReader.Make(aFileName);
 try
  l_Reader.Generator := aFilter;
  Result := l_Reader.As_Il3Reader;
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *6A9002DE6C1A_555DB62E036B_impl*
end;//TevdEVDReaderService.MakeReader

function TevdEVDReaderService.GetReader: Tk2CustomFileReader;
//#UC START# *9F46A5A9DAF5_555DB62E036B_var*
//#UC END# *9F46A5A9DAF5_555DB62E036B_var*
begin
//#UC START# *9F46A5A9DAF5_555DB62E036B_impl*
 Result := TevdNativeReader.Create;
//#UC END# *9F46A5A9DAF5_555DB62E036B_impl*
end;//TevdEVDReaderService.GetReader

class function TevdEVDReaderService.Instance: TevdEVDReaderService;
 {* Метод получения экземпляра синглетона TevdEVDReaderService }
begin
 if (g_TevdEVDReaderService = nil) then
 begin
  l3System.AddExitProc(TevdEVDReaderServiceFree);
  g_TevdEVDReaderService := Create;
 end;
 Result := g_TevdEVDReaderService;
end;//TevdEVDReaderService.Instance

class function TevdEVDReaderService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TevdEVDReaderService <> nil;
end;//TevdEVDReaderService.Exists

initialization
 Tk2EVDReaderService.Instance.Alien := TevdEVDReaderService.Instance;
 {* Регистрация TevdEVDReaderService }

end.
