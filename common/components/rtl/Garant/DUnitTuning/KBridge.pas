unit KBridge;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/KBridge.pas"
// Начат: 27.09.2010 19:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::BridgeToKviaCORBA::TKBridge
//
// Мост к К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3Filer,
  l3ProtoObject,
  SecuritySrv_int,
  Contents_int,
  orb_int,
  CosNaming_int
  ;
{$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit

{$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TKBridge = class(Tl3ProtoObject)
  {* Мост к К }
 private
 // private fields
   f_orb : IORB;
   f_session : ICoreSrv_SecuritySrv_SessionManager;
   f_NC : INamingContext;
   f_KPageFactory : IServerGate_Contents_KPageFactoryManagerSrv;
 protected
 // property methods
   function pm_GetPage(anID: Integer): IServerGate_Contents_KPage; virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   procedure Logout;
   class function Exists: Boolean;
   procedure AttachFile(aPage: Integer;
     const aFile: AnsiString);
 public
 // public properties
   property Page[anID: Integer]: IServerGate_Contents_KPage
     read pm_GetPage;
 public
 // singleton factory method
   class function Instance: TKBridge;
    {- возвращает экземпляр синглетона. }
 end;//TKBridge
{$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit

implementation

{$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3Base {a},
  l3FileUtils,
  SysUtils,
  l3Types,
  GarORBInitializerImpl,
  Classes,
  CosNaming,
  orb,
  SecuritySrv,
  GarClientSecurity,
  Contents,
  tfwKConst
  ;
{$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit

{$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}


// start class TKBridge

var g_TKBridge : TKBridge = nil;

procedure TKBridgeFree;
begin
 l3Free(g_TKBridge);
end;

class function TKBridge.Instance: TKBridge;
begin
 if (g_TKBridge = nil) then
 begin
  l3System.AddExitProc(TKBridgeFree);
  g_TKBridge := Create;
 end;
 Result := g_TKBridge;
end;


procedure TKBridge.Logout;
//#UC START# *4CA1E04300B7_4CA0BB8600CF_var*
//#UC END# *4CA1E04300B7_4CA0BB8600CF_var*
begin
//#UC START# *4CA1E04300B7_4CA0BB8600CF_impl*
 if (f_session <> nil) then
 begin
  f_session.logout;
  f_session := nil;
 end;//f_session <> nil
//#UC END# *4CA1E04300B7_4CA0BB8600CF_impl*
end;//TKBridge.Logout

class function TKBridge.Exists: Boolean;
//#UC START# *4CA335E50024_4CA0BB8600CF_var*
//#UC END# *4CA335E50024_4CA0BB8600CF_var*
begin
//#UC START# *4CA335E50024_4CA0BB8600CF_impl*
 Result := (g_TKBridge <> nil);
//#UC END# *4CA335E50024_4CA0BB8600CF_impl*
end;//TKBridge.Exists

procedure TKBridge.AttachFile(aPage: Integer;
  const aFile: AnsiString);
//#UC START# *4CAC9C6100E7_4CA0BB8600CF_var*
const
 cMaxSize = 9 * 1024 *1024;
var
 l_Size : Int64;
 l_Att : TServerGate_Contents_ByteBuffer;
 l_I   : Integer;
 l_Type : String;
 l_Ext  : String;
//#UC END# *4CAC9C6100E7_4CA0BB8600CF_var*
var
 l_F : Tl3CustomFiler;
begin
//#UC START# *4CAC9C6100E7_4CA0BB8600CF_impl*
 if (aFile <> '') then
 begin
  l_Size := GetFileSize(aFile);
  if (l_Size > 0) AND (l_Size <= cMaxSize) then
  begin
   SetLength(l_Att, l_Size);
   try
    Assert(Length(l_Att) >= l_Size,
           Format('Size = %s, Length = %d',
                  [IntToStr(l_Size), Length(l_Att)]));
    l_F := Tl3CustomDOSFiler.Make(aFile, l3_fmRead, false);
    try
     l_F.Open;
     try
      l_I := 0;
      try
       while not l_F.EOF do
       begin
        l_F.Read(@l_Att[l_I], 1);
        Inc(l_I);
       end;//while not l_F.EOF
      except
       on E : Exception do
       begin
        l3System.Msg2Log('i = %d Length = %d', [l_I, Length(l_Att)]);
        l3System.Exception2Log(E);
       end;//on E : Exception
      end;//try..except
     finally
      l_F.Close;
     end;//try..finally
    finally
     FreeAndNil(l_F);
    end;//try..finally
    try
     l_Ext := ExtractFileExt(aFile);
     if ANSISameText(l_Ext, '.png') OR ANSISameText(l_Ext, '.gif') then
      l_Type := 'image/gif'
     else
     if ANSISameText(l_Ext, '.jpeg') OR ANSISameText(l_Ext, '.jpg') then
      l_Type := 'image/jpeg'
     else
      l_Type := 'text/plain';
     Page[aPage].add_attachment(ExtractFileName(aFile), l_Att, l_Type);
    except
     on E : Exception do
      l3System.Exception2Log(E);
    end;//try..except
   finally
    l_Att := nil;
   end;//try..finally
  end;//l_Size <= cMaxSize
 end;//aFile <> ''
//#UC END# *4CAC9C6100E7_4CA0BB8600CF_impl*
end;//TKBridge.AttachFile

function TKBridge.pm_GetPage(anID: Integer): IServerGate_Contents_KPage;
//#UC START# *4CA1D3B10250_4CA0BB8600CFget_var*
//#UC END# *4CA1D3B10250_4CA0BB8600CFget_var*
begin
//#UC START# *4CA1D3B10250_4CA0BB8600CFget_impl*
 Result := f_KPageFactory.get(anID);
//#UC END# *4CA1D3B10250_4CA0BB8600CFget_impl*
end;//TKBridge.pm_GetPage

procedure TKBridge.Cleanup;
//#UC START# *479731C50290_4CA0BB8600CF_var*
//#UC END# *479731C50290_4CA0BB8600CF_var*
begin
//#UC START# *479731C50290_4CA0BB8600CF_impl*
 Self.Logout;
 inherited;
 WriteLn('TKBridge.Cleanup');
//#UC END# *479731C50290_4CA0BB8600CF_impl*
end;//TKBridge.Cleanup

procedure TKBridge.InitFields;
//#UC START# *47A042E100E2_4CA0BB8600CF_var*
var
 l_Props : TStringList;
 l_Obj   : IORBObject;
 l_Name  : TName;
//#UC END# *47A042E100E2_4CA0BB8600CF_var*
begin
//#UC START# *47A042E100E2_4CA0BB8600CF_impl*
 inherited;
 Assert(KUser <> '');
 l3FillChar(authorized_session, SizeOf(authorized_session));
 l_Props := TStringList.Create;
 try
  l_Props.Add('-ORBINITREF');
  l_Props.Add('NameService=corbaloc::1.2@mdp.garant.ru:5053/NameService');
  //l_Props.Add('NameService=corbaloc::1.2@ses:5053/NameService');
  TGarORBInitializerImpl.Init;
  f_orb := ORB_Init(l_Props);
  WriteLn('ORB_Init(l_Props)');
  Assert(f_orb <> nil);
  l_obj := f_orb.resolve_initial_reference('NameService');
  WriteLn('f_orb.resolve_initial_reference');
  Assert(l_obj <> nil);
  f_NC := TNamingContext._narrow(l_obj);
  WriteLn('TNamingContext._narrow(l_obj)');
  Assert(f_NC <> nil);
  SetLength(l_Name,1);
  l_Name[0].id := 'CoreSrv::SecuritySrv::SessionManager';
  l_Name[0].kind := '';
  l_Obj := f_NC.resolve(l_Name);
  WriteLn('f_NC.resolve');
  Assert(l_Obj <> nil);
  f_session := TCoreSrv_SecuritySrv_SessionManagerFactoryManagerSrv._narrow(l_Obj).get;
  WriteLn('TCoreSrv_SecuritySrv_SessionManagerFactoryManagerSrv._narrow(l_Obj).get');
  Assert(f_session <> nil);
  try
   authorized_session := f_session.login(KUser, KUserPassword);
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    WriteLn(E.Message);
    Self.Logout;
    ClearFields;
    Halt(3);
   end;//Exception
  end;//try..except 
  WriteLn('authorized_session := f_session.login');
  try
   l_Name[0].id := 'ServerGate::Contents::KPage';
   l_Name[0].kind := '';
   l_Obj := f_NC.resolve(l_Name);
   WriteLn('f_NC.resolve(l_Name)');
   Assert(l_obj <> nil);
   f_KPageFactory := TServerGate_Contents_KPageFactoryManagerSrv._narrow(l_Obj);
   WriteLn('TServerGate_Contents_KPageFactoryManagerSrv._narrow(l_Obj)');
   Assert(f_KPageFactory <> nil);
  except
   Self.Logout;
   raise;
  end;//try..except 
 finally
  FreeAndNil(l_Props);
 end;//try..finally
//#UC END# *47A042E100E2_4CA0BB8600CF_impl*
end;//TKBridge.InitFields

procedure TKBridge.ClearFields;
 {-}
begin
 {$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
 f_orb := nil;
 {$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit
 {$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
 f_session := nil;
 {$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit
 {$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
 f_NC := nil;
 {$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit
 {$If defined(MTDORB) AND defined(NoKPageTool) AND defined(nsTest) AND not defined(NotTunedDUnit)}
 f_KPageFactory := nil;
 {$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit
 inherited;
end;//TKBridge.ClearFields

{$IfEnd} //MTDORB AND NoKPageTool AND nsTest AND not NotTunedDUnit

end.