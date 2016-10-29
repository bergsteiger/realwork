unit l3FakeServiceImplementation;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeServiceImplementation.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "Tl3FakeServiceImplementation" MUID: (MSMD8227060B6E9)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3FakeProtoObject1
 , l3FakeService
;

type
 Tl3FakeServiceImplementation = class(Tl3ProtoObject, Il3FakeProtoObject1, Il3FakeService)
  public
   function SomeServiceMethod: Integer; overload;
   function SomeServiceMethod: Integer; overload;
   function SomeServiceMethod(aParam: Integer): AnsiString; overload;
   procedure SomeServiceIterator1F(anAction: Ml3FakeService_SomeServiceIterator1F_Action);
   function SomeServiceIterator2F(anAction: Ml3FakeService_SomeServiceIterator2F_Action;
    const aParam: AnsiString): TGUID;
   class function Instance: Tl3FakeServiceImplementation;
    {* Метод получения экземпляра синглетона Tl3FakeServiceImplementation }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3FakeServiceImplementation

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *MSMD8227060B6E9impl_uses*
 //#UC END# *MSMD8227060B6E9impl_uses*
;

var g_Tl3FakeServiceImplementation: Tl3FakeServiceImplementation = nil;
 {* Экземпляр синглетона Tl3FakeServiceImplementation }

procedure Tl3FakeServiceImplementationFree;
 {* Метод освобождения экземпляра синглетона Tl3FakeServiceImplementation }
begin
 l3Free(g_Tl3FakeServiceImplementation);
end;//Tl3FakeServiceImplementationFree

function Tl3FakeServiceImplementation.SomeServiceMethod: Integer;
//#UC START# *MSM46EDDD962C72_MSMD8227060B6E9_var*
//#UC END# *MSM46EDDD962C72_MSMD8227060B6E9_var*
begin
//#UC START# *MSM46EDDD962C72_MSMD8227060B6E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM46EDDD962C72_MSMD8227060B6E9_impl*
end;//Tl3FakeServiceImplementation.SomeServiceMethod

function Tl3FakeServiceImplementation.SomeServiceMethod: Integer;
//#UC START# *MSMA5E097030564_MSMD8227060B6E9_var*
//#UC END# *MSMA5E097030564_MSMD8227060B6E9_var*
begin
//#UC START# *MSMA5E097030564_MSMD8227060B6E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMA5E097030564_MSMD8227060B6E9_impl*
end;//Tl3FakeServiceImplementation.SomeServiceMethod

function Tl3FakeServiceImplementation.SomeServiceMethod(aParam: Integer): AnsiString;
//#UC START# *MSMAB07FEDF57E4_MSMD8227060B6E9_var*
//#UC END# *MSMAB07FEDF57E4_MSMD8227060B6E9_var*
begin
//#UC START# *MSMAB07FEDF57E4_MSMD8227060B6E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMAB07FEDF57E4_MSMD8227060B6E9_impl*
end;//Tl3FakeServiceImplementation.SomeServiceMethod

procedure Tl3FakeServiceImplementation.SomeServiceIterator1F(anAction: Ml3FakeService_SomeServiceIterator1F_Action);
//#UC START# *MSMAFE874E4949A_MSMD8227060B6E9_var*
//#UC END# *MSMAFE874E4949A_MSMD8227060B6E9_var*
begin
//#UC START# *MSMAFE874E4949A_MSMD8227060B6E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMAFE874E4949A_MSMD8227060B6E9_impl*
end;//Tl3FakeServiceImplementation.SomeServiceIterator1F

function Tl3FakeServiceImplementation.SomeServiceIterator2F(anAction: Ml3FakeService_SomeServiceIterator2F_Action;
 const aParam: AnsiString): TGUID;
//#UC START# *MSME189A2F97435_MSMD8227060B6E9_var*
//#UC END# *MSME189A2F97435_MSMD8227060B6E9_var*
begin
//#UC START# *MSME189A2F97435_MSMD8227060B6E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSME189A2F97435_MSMD8227060B6E9_impl*
end;//Tl3FakeServiceImplementation.SomeServiceIterator2F

class function Tl3FakeServiceImplementation.Instance: Tl3FakeServiceImplementation;
 {* Метод получения экземпляра синглетона Tl3FakeServiceImplementation }
begin
 if (g_Tl3FakeServiceImplementation = nil) then
 begin
  l3System.AddExitProc(Tl3FakeServiceImplementationFree);
  g_Tl3FakeServiceImplementation := Create;
 end;
 Result := g_Tl3FakeServiceImplementation;
end;//Tl3FakeServiceImplementation.Instance

class function Tl3FakeServiceImplementation.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3FakeServiceImplementation <> nil;
end;//Tl3FakeServiceImplementation.Exists

initialization
 Tl3FakeProtoObject1.Instance.Alien := Tl3FakeServiceImplementation.Instance;
 Tl3FakeService.Instance.Alien := Tl3FakeServiceImplementation.Instance;
 {* Регистрация Tl3FakeServiceImplementation }

end.
