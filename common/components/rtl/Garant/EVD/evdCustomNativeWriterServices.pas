unit evdCustomNativeWriterServices;

// ������: "w:\common\components\rtl\Garant\EVD\evdCustomNativeWriterServices.pas"
// ���������: "UtilityPack"
// ������� ������: "evdCustomNativeWriterServices" MUID: (555DCF340385)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2EVDWriterService
 , k2CustomFileGenerator
 , l3Variant
;

type
 TevdEVDWriterService = {final} class(Tl3ProtoObject, Ik2EVDWriterService)
  public
   function GetWriter: Tk2CustomFileGenerator;
   function MakeWriter(const aFileName: AnsiString): Ik2TagGenerator;
   class function Instance: TevdEVDWriterService;
    {* ����� ��������� ���������� ���������� TevdEVDWriterService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TevdEVDWriterService

implementation

uses
 l3ImplUses
 , evdCustomNativeWriter
 , SysUtils
 , l3Base
 //#UC START# *555DCF340385impl_uses*
 //#UC END# *555DCF340385impl_uses*
;

var g_TevdEVDWriterService: TevdEVDWriterService = nil;
 {* ��������� ���������� TevdEVDWriterService }

procedure TevdEVDWriterServiceFree;
 {* ����� ������������ ���������� ���������� TevdEVDWriterService }
begin
 l3Free(g_TevdEVDWriterService);
end;//TevdEVDWriterServiceFree

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

class function TevdEVDWriterService.Instance: TevdEVDWriterService;
 {* ����� ��������� ���������� ���������� TevdEVDWriterService }
begin
 if (g_TevdEVDWriterService = nil) then
 begin
  l3System.AddExitProc(TevdEVDWriterServiceFree);
  g_TevdEVDWriterService := Create;
 end;
 Result := g_TevdEVDWriterService;
end;//TevdEVDWriterService.Instance

class function TevdEVDWriterService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TevdEVDWriterService <> nil;
end;//TevdEVDWriterService.Exists

initialization
 Tk2EVDWriterService.Instance.Alien := TevdEVDWriterService.Instance;
 {* ����������� TevdEVDWriterService }

end.
