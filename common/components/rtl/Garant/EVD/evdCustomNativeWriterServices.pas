unit evdCustomNativeWriterServices;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdCustomNativeWriterServices.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Generators::evdCustomNativeWriterServices
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
  k2EVDWriterService,
  k2CustomFileGenerator,
  l3Variant
  ;

type
 TevdEVDWriterService = {final} class(Tl3ProtoObject, Ik2EVDWriterService)
 public
 // realized methods
   function GetWriter: Tk2CustomFileGenerator;
   function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TevdEVDWriterService;
    {- возвращает экземпляр синглетона. }
 end;//TevdEVDWriterService

implementation

uses
  l3Base {a},
  evdCustomNativeWriter,
  SysUtils
  ;


// start class TevdEVDWriterService

var g_TevdEVDWriterService : TevdEVDWriterService = nil;

procedure TevdEVDWriterServiceFree;
begin
 l3Free(g_TevdEVDWriterService);
end;

class function TevdEVDWriterService.Instance: TevdEVDWriterService;
begin
 if (g_TevdEVDWriterService = nil) then
 begin
  l3System.AddExitProc(TevdEVDWriterServiceFree);
  g_TevdEVDWriterService := Create;
 end;
 Result := g_TevdEVDWriterService;
end;


class function TevdEVDWriterService.Exists: Boolean;
 {-}
begin
 Result := g_TevdEVDWriterService <> nil;
end;//TevdEVDWriterService.Exists

function TevdEVDWriterService.GetWriter: Tk2CustomFileGenerator;
//#UC START# *26782C1B9519_555DCF5A0060_var*
var
 l_W : TevdCustomNativeWriter;
//#UC END# *26782C1B9519_555DCF5A0060_var*
begin
//#UC START# *26782C1B9519_555DCF5A0060_impl*
 l_W := TevdCustomNativeWriter.Create;
 {$IFNDEF EverestLite}
 l_W.Binary := true;
 {$ENDIF}
 Result := l_W;
//#UC END# *26782C1B9519_555DCF5A0060_impl*
end;//TevdEVDWriterService.GetWriter

function TevdEVDWriterService.MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
//#UC START# *F7BF6A35E2B1_555DCF5A0060_var*
var
 l_Writer : TevdCustomNativeWriter;
//#UC END# *F7BF6A35E2B1_555DCF5A0060_var*
begin
//#UC START# *F7BF6A35E2B1_555DCF5A0060_impl*
 l_Writer := TevdCustomNativeWriter.Make(aFileName);
 try
  Result := l_Writer;
 finally
  FreeAndNil(l_Writer);
 end;//try..finally
//#UC END# *F7BF6A35E2B1_555DCF5A0060_impl*
end;//TevdEVDWriterService.MakeWriter

initialization
// Регистрация TevdEVDWriterService
 Tk2EVDWriterService.Instance.Alien := TevdEVDWriterService.Instance;

end.