unit l3FakeService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3FakeService" MUID: (MSMBCDA1CC34343)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 // Tl3FakeService_SomeServiceIterator_Action

type
 Ml3FakeService_SomeServiceIterator1F_Action = function(const anItem: AnsiString): Boolean;
  {* Тип подитеративной функции для Ml3FakeService.SomeServiceIterator1F }

 Ml3FakeService_SomeServiceIterator2F_Action = function(anItem: Integer;
  anIndex: Integer): Boolean;
  {* Тип подитеративной функции для Ml3FakeService.SomeServiceIterator2F }

 (*
 Ml3FakeService = interface
  {* Контракт сервиса Tl3FakeService }
  function SomeServiceMethod: Integer; overload;
  function SomeServiceMethod(aParam: Integer): AnsiString; overload;
  procedure SomeServiceIterator1F(anAction: Ml3FakeService_SomeServiceIterator1F_Action);
  function SomeServiceIterator2F(anAction: Ml3FakeService_SomeServiceIterator2F_Action;
   const aParam: AnsiString): TGUID;
 end;//Ml3FakeService
 *)

 Il3FakeService = interface
  {* Интерфейс сервиса Tl3FakeService }
  function SomeServiceMethod: Integer; overload;
  function SomeServiceMethod(aParam: Integer): AnsiString; overload;
  procedure SomeServiceIterator1F(anAction: Ml3FakeService_SomeServiceIterator1F_Action);
  function SomeServiceIterator2F(anAction: Ml3FakeService_SomeServiceIterator2F_Action;
   const aParam: AnsiString): TGUID;
 end;//Il3FakeService

 _l3FakeImpurity_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity.imp.pas}
 _l3FakeImpurity1_Parent_ = _l3FakeImpurity_;
 {$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity1.imp.pas}
 _l3FakeImpurity2_Parent_ = _l3FakeImpurity1_;
 {$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity2.imp.pas}
 _l3FakeImpurity3_Parent_ = _l3FakeImpurity2_;
 {$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity3.imp.pas}
 Tl3FakeService = class(_l3FakeImpurity3_)
  private
   f_Alien: Il3FakeService;
    {* Внешняя реализация сервиса Il3FakeService }
  protected
   procedure pm_SetAlien(const aValue: Il3FakeService);
   procedure ClearFields; override;
  public
   function MixInAbstractMethod: AnsiString; override;
   function SomeServiceMethod: Integer; overload;
   function SomeServiceMethod(aParam: Integer): AnsiString; overload;
   procedure SomeServiceIterator1F(anAction: Ml3FakeService_SomeServiceIterator1F_Action);
   function SomeServiceIterator2F(anAction: Ml3FakeService_SomeServiceIterator2F_Action;
    const aParam: AnsiString): TGUID;
   class function Instance: Tl3FakeService;
    {* Метод получения экземпляра синглетона Tl3FakeService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3FakeService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3FakeService }
 end;//Tl3FakeService

function L2Ml3FakeServiceSomeServiceIterator1FAction(anAction: Pointer): Ml3FakeService_SomeServiceIterator1F_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ml3FakeService.SomeServiceIterator1F }
function L2Ml3FakeServiceSomeServiceIterator2FAction(anAction: Pointer): Ml3FakeService_SomeServiceIterator2F_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ml3FakeService.SomeServiceIterator2F }

implementation

uses
 l3ImplUses
 , l3FakeUtilityPack
 , SysUtils
 , l3Base
 //#UC START# *MSMBCDA1CC34343impl_uses*
 //#UC END# *MSMBCDA1CC34343impl_uses*
;

var g_Tl3FakeService: Tl3FakeService = nil;
 {* Экземпляр синглетона Tl3FakeService }

function L2Ml3FakeServiceSomeServiceIterator1FAction(anAction: Pointer): Ml3FakeService_SomeServiceIterator1F_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ml3FakeService.SomeServiceIterator1F }
asm
 jmp l3LocalStub
end;//L2Ml3FakeServiceSomeServiceIterator1FAction

function L2Ml3FakeServiceSomeServiceIterator2FAction(anAction: Pointer): Ml3FakeService_SomeServiceIterator2F_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для Ml3FakeService.SomeServiceIterator2F }
asm
 jmp l3LocalStub
end;//L2Ml3FakeServiceSomeServiceIterator2FAction

procedure Tl3FakeServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3FakeService }
begin
 l3Free(g_Tl3FakeService);
end;//Tl3FakeServiceFree

function MixInInline(aParam: TObject = nil): TObject;
//#UC START# *MSM498090CE48DF_MSMBCDA1CC34343_var*
//#UC END# *MSM498090CE48DF_MSMBCDA1CC34343_var*
begin
//#UC START# *MSM498090CE48DF_MSMBCDA1CC34343_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM498090CE48DF_MSMBCDA1CC34343_impl*
end;//MixInInline

{$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity1.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity2.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3FakeImpurity3.imp.pas}

procedure Tl3FakeService.pm_SetAlien(const aValue: Il3FakeService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3FakeService.pm_SetAlien

function Tl3FakeService.MixInAbstractMethod: AnsiString;
//#UC START# *MSMD4AAD8DF5865_MSMBCDA1CC34343_var*
//#UC END# *MSMD4AAD8DF5865_MSMBCDA1CC34343_var*
begin
//#UC START# *MSMD4AAD8DF5865_MSMBCDA1CC34343_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMD4AAD8DF5865_MSMBCDA1CC34343_impl*
end;//Tl3FakeService.MixInAbstractMethod

function Tl3FakeService.SomeServiceMethod: Integer;
//#UC START# *MSMA5E097030564_MSMBCDA1CC34343_var*
//#UC END# *MSMA5E097030564_MSMBCDA1CC34343_var*
begin
//#UC START# *MSMA5E097030564_MSMBCDA1CC34343_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMA5E097030564_MSMBCDA1CC34343_impl*
end;//Tl3FakeService.SomeServiceMethod

function Tl3FakeService.SomeServiceMethod(aParam: Integer): AnsiString;
//#UC START# *MSMAB07FEDF57E4_MSMBCDA1CC34343_var*
//#UC END# *MSMAB07FEDF57E4_MSMBCDA1CC34343_var*
begin
//#UC START# *MSMAB07FEDF57E4_MSMBCDA1CC34343_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMAB07FEDF57E4_MSMBCDA1CC34343_impl*
end;//Tl3FakeService.SomeServiceMethod

procedure Tl3FakeService.SomeServiceIterator1F(anAction: Ml3FakeService_SomeServiceIterator1F_Action);
//#UC START# *MSMAFE874E4949A_MSMBCDA1CC34343_var*
//#UC END# *MSMAFE874E4949A_MSMBCDA1CC34343_var*
begin
//#UC START# *MSMAFE874E4949A_MSMBCDA1CC34343_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMAFE874E4949A_MSMBCDA1CC34343_impl*
end;//Tl3FakeService.SomeServiceIterator1F

function Tl3FakeService.SomeServiceIterator2F(anAction: Ml3FakeService_SomeServiceIterator2F_Action;
 const aParam: AnsiString): TGUID;
//#UC START# *MSME189A2F97435_MSMBCDA1CC34343_var*
//#UC END# *MSME189A2F97435_MSMBCDA1CC34343_var*
begin
//#UC START# *MSME189A2F97435_MSMBCDA1CC34343_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSME189A2F97435_MSMBCDA1CC34343_impl*
end;//Tl3FakeService.SomeServiceIterator2F

class function Tl3FakeService.Instance: Tl3FakeService;
 {* Метод получения экземпляра синглетона Tl3FakeService }
begin
 if (g_Tl3FakeService = nil) then
 begin
  l3System.AddExitProc(Tl3FakeServiceFree);
  g_Tl3FakeService := Create;
 end;
 Result := g_Tl3FakeService;
end;//Tl3FakeService.Instance

class function Tl3FakeService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3FakeService <> nil;
end;//Tl3FakeService.Exists

procedure Tl3FakeService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3FakeService.ClearFields

end.
