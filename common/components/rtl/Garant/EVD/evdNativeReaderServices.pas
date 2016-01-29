unit evdNativeReaderServices;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdNativeReaderServices.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Readers::evdNativeReaderServices
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  l3ProtoObject,
  k2EVDReaderService,
  l3Interfaces,
  l3Variant,
  k2CustomFileReader
  ;

type
 TevdEVDReaderService = {final} class(Tl3ProtoObject, Ik2EVDReaderService)
 public
 // realized methods
   function MakeReader(const aFileName: AnsiString;
     const aFilter: Ik2TagGenerator): Il3Reader;
   function GetReader: Tk2CustomFileReader;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TevdEVDReaderService;
    {- возвращает экземпляр синглетона. }
 end;//TevdEVDReaderService

implementation

uses
  l3Base {a},
  evdNativeReader,
  SysUtils
  ;


// start class TevdEVDReaderService

var g_TevdEVDReaderService : TevdEVDReaderService = nil;

procedure TevdEVDReaderServiceFree;
begin
 l3Free(g_TevdEVDReaderService);
end;

class function TevdEVDReaderService.Instance: TevdEVDReaderService;
begin
 if (g_TevdEVDReaderService = nil) then
 begin
  l3System.AddExitProc(TevdEVDReaderServiceFree);
  g_TevdEVDReaderService := Create;
 end;
 Result := g_TevdEVDReaderService;
end;


class function TevdEVDReaderService.Exists: Boolean;
 {-}
begin
 Result := g_TevdEVDReaderService <> nil;
end;//TevdEVDReaderService.Exists

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

initialization
// Регистрация TevdEVDReaderService
 Tk2EVDReaderService.Instance.Alien := TevdEVDReaderService.Instance;

end.