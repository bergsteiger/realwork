unit alcuMdpProtoSyncronizer;

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpProtoSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpProtoSyncronizer" MUID: (574C0E84031E)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csMdpSyncPrim
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 //#UC START# *574C0E84031Eintf_uses*
 //#UC END# *574C0E84031Eintf_uses*
;

type
 //#UC START# *574C0E84031Eci*
 //#UC END# *574C0E84031Eci*
 //#UC START# *574C0E84031Ecit*
 //#UC END# *574C0E84031Ecit*
 TalcuMdpProtoSyncronizer = {abstract} class(Tl3ProtoObject)
  private
   f_Sync: TcsMdpSyncPrim;
  private
   procedure PostToGardoc(aStream: TStream);
  protected
   function PrepareData(aStream: TStream): Boolean; virtual; abstract;
   procedure BeforeSync; virtual; abstract;
   procedure AfterSuccessfulSync; virtual; abstract;
   function GetTitle: AnsiString; virtual; abstract;
  public
   constructor Create(aSync: TcsMdpSyncPrim); reintroduce;
   procedure Execute;
 //#UC START# *574C0E84031Epubl*
 //#UC END# *574C0E84031Epubl*
 end;//TalcuMdpProtoSyncronizer

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Memory
 , l3Stream
 , l3Types
 //#UC START# *574C0E84031Eimpl_uses*
 , IdHTTP
 //#UC END# *574C0E84031Eimpl_uses*
;

constructor TalcuMdpProtoSyncronizer.Create(aSync: TcsMdpSyncPrim);
//#UC START# *574C37390202_574C0E84031E_var*
//#UC END# *574C37390202_574C0E84031E_var*
begin
//#UC START# *574C37390202_574C0E84031E_impl*
 inherited Create;
 Assert(Assigned(aSync));
 f_Sync := aSync;
//#UC END# *574C37390202_574C0E84031E_impl*
end;//TalcuMdpProtoSyncronizer.Create

procedure TalcuMdpProtoSyncronizer.Execute;
//#UC START# *574C38C2015A_574C0E84031E_var*
var
 l_Stream: TStream;
//#UC END# *574C38C2015A_574C0E84031E_var*
begin
//#UC START# *574C38C2015A_574C0E84031E_impl*
 try
  BeforeSync;
  l_Stream := Tl3MemoryStream.Create;
  try
   PrepareData(l_Stream);
   PostToGardoc(l_Stream);
   AfterSuccessfulSync;
  finally
   FreeAndNil(l_Stream);
  end;
 except
  on E: Exception do
  begin
   l3System.Msg2Log('ОШИБКА '+GetTitle+': '+E.Message);
   l3System.Exception2Log(E);
  end;
 end;
//#UC END# *574C38C2015A_574C0E84031E_impl*
end;//TalcuMdpProtoSyncronizer.Execute

procedure TalcuMdpProtoSyncronizer.PostToGardoc(aStream: TStream);
//#UC START# *574C39080008_574C0E84031E_var*
{$IFDEF MDPSYNCTEST}
var
 l_FS: Tl3FileStream;
{$ELSE}
var
 l_HTTP: TIdHTTP;
{$ENDIF}
//#UC END# *574C39080008_574C0E84031E_var*
begin
//#UC START# *574C39080008_574C0E84031E_impl*
 {$IFDEF MDPSYNCTEST}
 l_FS := Tl3FileStream.Create('c:\temp\'+ClassName+'.dat', l3_fmWrite);
 try
  aStream.Seek(0, soBeginning);
  l_FS.CopyFrom(aStream, aStream.Size);
 finally
  FreeAndNil(l_FS);
 end;
 {$ELSE}
 l_HTTP := TIdHTTP.Create;
 try
  if f_Sync.UseProxy then
  begin
   // настраиваем тут прокси
   with l_HTTP.ProxyParams do
   begin
    ProxyServer := f_Sync.ProxyServer;
    ProxyPort   := f_Sync.ProxyPort;
    ProxyUsername := f_Sync.ProxyLogin;
    ProxyPassword := f_Sync.ProxyPassword;
    BasicAuthentication := True;
   end;
  end;
  aStream.Seek(0, soBeginning);
  l_HTTP.Post(f_Sync.SyncURL, aStream);
 finally
  FreeAndNil(l_HTTP);
 end;
 {$ENDIF}
//#UC END# *574C39080008_574C0E84031E_impl*
end;//TalcuMdpProtoSyncronizer.PostToGardoc

//#UC START# *574C0E84031Eimpl*
//#UC END# *574C0E84031Eimpl*

end.
