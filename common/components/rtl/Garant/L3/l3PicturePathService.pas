unit l3PicturePathService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3PicturePathService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3PicturePathService" MUID: (552406830331)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3PicturePathService = interface
  {* Контракт сервиса Tl3PicturePathService }
  procedure SetEnableSave(aValue: Boolean);
  procedure SetPDF4Etalon(aValue: Boolean);
  procedure AddPicturePath(const aPath: AnsiString);
  procedure SetTestName(const aName: AnsiString);
 end;//Ml3PicturePathService
 *)

type
 Il3PicturePathService = interface
  {* Интерфейс сервиса Tl3PicturePathService }
  ['{24FE9416-AB0D-4F8E-94A1-DCBC9F50CD65}']
  procedure SetEnableSave(aValue: Boolean);
  procedure SetPDF4Etalon(aValue: Boolean);
  procedure AddPicturePath(const aPath: AnsiString);
  procedure SetTestName(const aName: AnsiString);
 end;//Il3PicturePathService

 Tl3PicturePathService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3PicturePathService;
    {* Внешняя реализация сервиса Il3PicturePathService }
  protected
   procedure pm_SetAlien(const aValue: Il3PicturePathService);
   procedure ClearFields; override;
  public
   procedure SetTestName(const aName: AnsiString);
   procedure AddPicturePath(const aPath: AnsiString);
   procedure SetEnableSave(aValue: Boolean);
   procedure SetPDF4Etalon(aValue: Boolean);
   class function Instance: Tl3PicturePathService;
    {* Метод получения экземпляра синглетона Tl3PicturePathService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3PicturePathService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3PicturePathService }
 end;//Tl3PicturePathService

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , PictureEtalonsWorkingPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
;

var g_Tl3PicturePathService: Tl3PicturePathService = nil;
 {* Экземпляр синглетона Tl3PicturePathService }

procedure Tl3PicturePathServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3PicturePathService }
begin
 l3Free(g_Tl3PicturePathService);
end;//Tl3PicturePathServiceFree

procedure Tl3PicturePathService.pm_SetAlien(const aValue: Il3PicturePathService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3PicturePathService.pm_SetAlien

procedure Tl3PicturePathService.SetTestName(const aName: AnsiString);
//#UC START# *2DCD42915D2E_552406830331_var*
//#UC END# *2DCD42915D2E_552406830331_var*
begin
//#UC START# *2DCD42915D2E_552406830331_impl*
 if (f_Alien <> nil) then
  f_Alien.SetTestName(aName); 
//#UC END# *2DCD42915D2E_552406830331_impl*
end;//Tl3PicturePathService.SetTestName

procedure Tl3PicturePathService.AddPicturePath(const aPath: AnsiString);
//#UC START# *3FB12D269858_552406830331_var*
//#UC END# *3FB12D269858_552406830331_var*
begin
//#UC START# *3FB12D269858_552406830331_impl*
 if (f_Alien <> nil) then
  f_Alien.AddPicturePath(aPath); 
//#UC END# *3FB12D269858_552406830331_impl*
end;//Tl3PicturePathService.AddPicturePath

procedure Tl3PicturePathService.SetEnableSave(aValue: Boolean);
//#UC START# *4706AFD6D823_552406830331_var*
//#UC END# *4706AFD6D823_552406830331_var*
begin
//#UC START# *4706AFD6D823_552406830331_impl*
 if (f_Alien <> nil) then
  f_Alien.SetEnableSave(aValue); 
//#UC END# *4706AFD6D823_552406830331_impl*
end;//Tl3PicturePathService.SetEnableSave

procedure Tl3PicturePathService.SetPDF4Etalon(aValue: Boolean);
//#UC START# *86EACEE128F2_552406830331_var*
//#UC END# *86EACEE128F2_552406830331_var*
begin
//#UC START# *86EACEE128F2_552406830331_impl*
 if (f_Alien <> nil) then
  f_Alien.SetPDF4Etalon(aValue); 
//#UC END# *86EACEE128F2_552406830331_impl*
end;//Tl3PicturePathService.SetPDF4Etalon

class function Tl3PicturePathService.Instance: Tl3PicturePathService;
 {* Метод получения экземпляра синглетона Tl3PicturePathService }
begin
 if (g_Tl3PicturePathService = nil) then
 begin
  l3System.AddExitProc(Tl3PicturePathServiceFree);
  g_Tl3PicturePathService := Create;
 end;
 Result := g_Tl3PicturePathService;
end;//Tl3PicturePathService.Instance

class function Tl3PicturePathService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3PicturePathService <> nil;
end;//Tl3PicturePathService.Exists

procedure Tl3PicturePathService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3PicturePathService.ClearFields

end.
