unit KBridge;
 {* Мост к К }

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\KBridge.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3ProtoObject
 , orb_int
 , SecuritySrv_int
 , CosNaming_int
 , Contents_int
 , l3Filer
;

type
 TKBridge = class(Tl3ProtoObject)
  {* Мост к К }
  private
   f_orb: IORB;
   f_session: ICoreSrv_SecuritySrv_SessionManager;
   f_NC: INamingContext;
   f_KPageFactory: IServerGate_Contents_KPageFactoryManagerSrv;
  protected
   function pm_GetPage(anID: Integer): IServerGate_Contents_KPage; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   procedure Logout;
   class function Exists: Boolean;
   procedure AttachFile(aPage: Integer;
    const aFile: AnsiString);
   class function Instance: TKBridge;
    {* Метод получения экземпляра синглетона TKBridge }
  public
   property Page[anID: Integer]: IServerGate_Contents_KPage
    read pm_GetPage;
 end;//TKBridge
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , GarORBInitializerImpl
 , Classes
 , CosNaming
 , SysUtils
 , orb
 , SecuritySrv
 , GarClientSecurity
 , Contents
 , tfwKConst
 , l3Base
 , l3FileUtils
 , l3Types
;

var g_TKBridge: TKBridge = nil;
 {* Экземпляр синглетона TKBridge }

procedure TKBridgeFree;
 {* Метод освобождения экземпляра синглетона TKBridge }
begin
 l3Free(g_TKBridge);
end;//TKBridgeFree

function TKBridge.pm_GetPage(anID: Integer): IServerGate_Contents_KPage;
//#UC START# *4CA1D3B10250_4CA0BB8600CFget_var*
//#UC END# *4CA1D3B10250_4CA0BB8600CFget_var*
begin
//#UC START# *4CA1D3B10250_4CA0BB8600CFget_impl*
 Result := f_KPageFactory.get(anID);
//#UC END# *4CA1D3B10250_4CA0BB8600CFget_impl*
end;//TKBridge.pm_GetPage

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
var l_F: Tl3CustomFiler;
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

class function TKBridge.Instance: TKBridge;
 {* Метод получения экземпляра синглетона TKBridge }
begin
 if (g_TKBridge = nil) then
 begin
  l3System.AddExitProc(TKBridgeFree);
  g_TKBridge := Create;
 end;
 Result := g_TKBridge;
end;//TKBridge.Instance

procedure TKBridge.Cleanup;
 {* Функция очистки полей объекта. }
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
begin
 f_orb := nil;
 f_session := nil;
 f_NC := nil;
 f_KPageFactory := nil;
 inherited;
end;//TKBridge.ClearFields
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND Defined(NoKPageTool) AND NOT Defined(NotTunedDUnit)

end.
