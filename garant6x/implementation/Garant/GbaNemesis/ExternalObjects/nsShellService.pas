unit nsShellService;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsShellService.pas"
// Стереотип: "Service"
// Элемент модели: "TnsShellService" MUID: (57A86F7400E4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

 (*
 MnsShellService = interface
  {* Контракт сервиса TnsShellService }
  function ShellExecute(const aFile: Il3CString;
   aSetReadOnlyToFile: Boolean): Boolean;
 end;//MnsShellService
 *)

type
 InsShellService = interface
  {* Интерфейс сервиса TnsShellService }
  function ShellExecute(const aFile: Il3CString;
   aSetReadOnlyToFile: Boolean): Boolean;
 end;//InsShellService

 TnsShellService = {final} class(Tl3ProtoObject)
  private
   f_Alien: InsShellService;
    {* Внешняя реализация сервиса InsShellService }
  protected
   procedure pm_SetAlien(const aValue: InsShellService);
   procedure ClearFields; override;
  public
   function CallShellExecute(const aFile: Il3CString;
    aSetReadOnlyToFile: Boolean): Boolean;
   function ShellExecute(const aFile: Il3CString;
    aSetReadOnlyToFile: Boolean): Boolean;
   class function Instance: TnsShellService;
    {* Метод получения экземпляра синглетона TnsShellService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: InsShellService
    write pm_SetAlien;
    {* Внешняя реализация сервиса InsShellService }
 end;//TnsShellService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57A86F7400E4impl_uses*
 , Windows
 , ShellAPI
 , afwFacade
 , nsTypes
 //#UC END# *57A86F7400E4impl_uses*
;

var g_TnsShellService: TnsShellService = nil;
 {* Экземпляр синглетона TnsShellService }

procedure TnsShellServiceFree;
 {* Метод освобождения экземпляра синглетона TnsShellService }
begin
 l3Free(g_TnsShellService);
end;//TnsShellServiceFree

procedure TnsShellService.pm_SetAlien(const aValue: InsShellService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TnsShellService.pm_SetAlien

function TnsShellService.CallShellExecute(const aFile: Il3CString;
 aSetReadOnlyToFile: Boolean): Boolean;
//#UC START# *57A870780035_57A86F7400E4_var*
var
 l_ShellExecuteInfo: {$IfDef XE}TShellExecuteInfoA{$Else}TShellExecuteInfo{$EndIf};
 l_Handle: THandle;
 l_FindData: {$IfDef XE}TWin32FindDataA{$Else}TWin32FindData{$EndIf};
//#UC END# *57A870780035_57A86F7400E4_var*
begin
//#UC START# *57A870780035_57A86F7400E4_impl*
 l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
 //http://mdp.garant.ru/pages/viewpage.action?pageId=431371899
 afw.BeginOp;
 try
  with l_ShellExecuteInfo do
  begin
   cbSize := SizeOf(l_ShellExecuteInfo);
   lpFile := PAnsiChar(nsAStr(aFile).S);
   if aSetReadOnlyToFile then
   begin
    l_Handle := Windows.FindFirstFileA(lpFile, l_FindData);
    if l_Handle <> INVALID_HANDLE_VALUE then
    begin
     Windows.FindClose(l_Handle);
     SetFileAttributesA(lpFile, GetFileAttributesA(lpFile) or faReadOnly);
    end;//l_Handle <> INVALID_HANDLE_VALUE
   end;//aSetReadOnlyToFile
   nShow := SW_SHOWNORMAL;
  end;//with l_ShellExecuteInfo
  Result := ShellExecuteExA(@l_ShellExecuteInfo);
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *57A870780035_57A86F7400E4_impl*
end;//TnsShellService.CallShellExecute

function TnsShellService.ShellExecute(const aFile: Il3CString;
 aSetReadOnlyToFile: Boolean): Boolean;
//#UC START# *F7FE987044FC_57A86F7400E4_var*
//#UC END# *F7FE987044FC_57A86F7400E4_var*
begin
//#UC START# *F7FE987044FC_57A86F7400E4_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.ShellExecute(aFile, aSetReadOnlyToFile)
 else
  Result := Self.CallShellExecute(aFile, aSetReadOnlyToFile); 
//#UC END# *F7FE987044FC_57A86F7400E4_impl*
end;//TnsShellService.ShellExecute

class function TnsShellService.Instance: TnsShellService;
 {* Метод получения экземпляра синглетона TnsShellService }
begin
 if (g_TnsShellService = nil) then
 begin
  l3System.AddExitProc(TnsShellServiceFree);
  g_TnsShellService := Create;
 end;
 Result := g_TnsShellService;
end;//TnsShellService.Instance

class function TnsShellService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsShellService <> nil;
end;//TnsShellService.Exists

procedure TnsShellService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TnsShellService.ClearFields

end.
