unit F1_Application_Template_InternalOperations_Controls;
 {* Внутренние операции. Кандидаты на превращение в фасеты }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Application_Template_InternalOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "InternalOperations" MUID: (4A8EC95E015F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 ISystem_InitShutdown_Params = interface
  {* Параметры для операции System.InitShutdown }
  ['{DB584516-0B73-41CF-9721-9C57CAF90FDE}']
  function Get_Shotdown: Boolean;
  function Get_CloseInterval: Integer;
  property Shotdown: Boolean
   read Get_Shotdown;
  property CloseInterval: Integer
   read Get_CloseInterval;
 end;//ISystem_InitShutdown_Params

 Op_System_InitShutdown = class
  {* Класс для вызова операции System.InitShutdown }
  public
   class function Call(const aTarget: IvcmEntity;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload;
    {* Вызов операции System.InitShutdown у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload;
    {* Вызов операции System.InitShutdown у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload;
    {* Вызов операции System.InitShutdown у формы }
   class function Call(const aTarget: IvcmContainer;
    aShotdown: Boolean;
    aCloseInterval: Integer): Boolean; overload;
    {* Вызов операции System.InitShutdown у контейнера }
 end;//Op_System_InitShutdown

implementation

uses
 l3ImplUses
 , l3CProtoObject
;

type
 TSystem_InitShutdown_Params = class(Tl3CProtoObject, ISystem_InitShutdown_Params)
  {* Реализация ISystem_InitShutdown_Params }
  private
   f_Shotdown: Boolean;
   f_CloseInterval: Integer;
  protected
   function Get_Shotdown: Boolean;
   function Get_CloseInterval: Integer;
  public
   constructor Create(aShotdown: Boolean;
    aCloseInterval: Integer); reintroduce;
    {* Конструктор TSystem_InitShutdown_Params }
   class function Make(aShotdown: Boolean;
    aCloseInterval: Integer): ISystem_InitShutdown_Params; reintroduce;
    {* Фабрика TSystem_InitShutdown_Params }
 end;//TSystem_InitShutdown_Params

constructor TSystem_InitShutdown_Params.Create(aShotdown: Boolean;
 aCloseInterval: Integer);
 {* Конструктор TSystem_InitShutdown_Params }
//#UC START# *280194009EA3_79B2B4B59E9D_var*
//#UC END# *280194009EA3_79B2B4B59E9D_var*
begin
//#UC START# *280194009EA3_79B2B4B59E9D_impl*
 !!! Needs to be implemented !!!
//#UC END# *280194009EA3_79B2B4B59E9D_impl*
end;//TSystem_InitShutdown_Params.Create

class function TSystem_InitShutdown_Params.Make(aShotdown: Boolean;
 aCloseInterval: Integer): ISystem_InitShutdown_Params;
 {* Фабрика TSystem_InitShutdown_Params }
var
 l_Inst : TSystem_InitShutdown_Params;
begin
 l_Inst := Create(aShotdown, aCloseInterval);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSystem_InitShutdown_Params.Make

function TSystem_InitShutdown_Params.Get_Shotdown: Boolean;
//#UC START# *0ECAF7083D5C_79B2B4B59E9Dget_var*
//#UC END# *0ECAF7083D5C_79B2B4B59E9Dget_var*
begin
//#UC START# *0ECAF7083D5C_79B2B4B59E9Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *0ECAF7083D5C_79B2B4B59E9Dget_impl*
end;//TSystem_InitShutdown_Params.Get_Shotdown

function TSystem_InitShutdown_Params.Get_CloseInterval: Integer;
//#UC START# *B28A9D749C75_79B2B4B59E9Dget_var*
//#UC END# *B28A9D749C75_79B2B4B59E9Dget_var*
begin
//#UC START# *B28A9D749C75_79B2B4B59E9Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *B28A9D749C75_79B2B4B59E9Dget_impl*
end;//TSystem_InitShutdown_Params.Get_CloseInterval

class function Op_System_InitShutdown.Call(const aTarget: IvcmEntity;
 aShotdown: Boolean;
 aCloseInterval: Integer): Boolean;
 {* Вызов операции System.InitShutdown у сущности }
//#UC START# *4D6B3E09D3E6_F534778BCB43_var*
//#UC END# *4D6B3E09D3E6_F534778BCB43_var*
begin
//#UC START# *4D6B3E09D3E6_F534778BCB43_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D6B3E09D3E6_F534778BCB43_impl*
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmAggregate;
 aShotdown: Boolean;
 aCloseInterval: Integer): Boolean;
 {* Вызов операции System.InitShutdown у агрегации }
//#UC START# *306EFAED5E37_F534778BCB43_var*
//#UC END# *306EFAED5E37_F534778BCB43_var*
begin
//#UC START# *306EFAED5E37_F534778BCB43_impl*
 !!! Needs to be implemented !!!
//#UC END# *306EFAED5E37_F534778BCB43_impl*
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmEntityForm;
 aShotdown: Boolean;
 aCloseInterval: Integer): Boolean;
 {* Вызов операции System.InitShutdown у формы }
//#UC START# *ED36492DD020_F534778BCB43_var*
//#UC END# *ED36492DD020_F534778BCB43_var*
begin
//#UC START# *ED36492DD020_F534778BCB43_impl*
 !!! Needs to be implemented !!!
//#UC END# *ED36492DD020_F534778BCB43_impl*
end;//Op_System_InitShutdown.Call

class function Op_System_InitShutdown.Call(const aTarget: IvcmContainer;
 aShotdown: Boolean;
 aCloseInterval: Integer): Boolean;
 {* Вызов операции System.InitShutdown у контейнера }
//#UC START# *8615FDBCBEF7_F534778BCB43_var*
//#UC END# *8615FDBCBEF7_F534778BCB43_var*
begin
//#UC START# *8615FDBCBEF7_F534778BCB43_impl*
 !!! Needs to be implemented !!!
//#UC END# *8615FDBCBEF7_F534778BCB43_impl*
end;//Op_System_InitShutdown.Call

end.
