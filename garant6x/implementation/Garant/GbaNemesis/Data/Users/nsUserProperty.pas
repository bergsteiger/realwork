unit nsUserProperty;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Users/nsUserProperty.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Users$CommonForAdminAndF1::TnsUserProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SecurityUnit,
  l3SimpleObject,
  AdminDomainInterfaces,
  l3Interfaces
  ;

type
 _nsUserPropertyImpl_Parent_ = Tl3SimpleObject;
 {$Include ..\Users\nsUserPropertyImpl.imp.pas}
 TnsUserProperty = class(_nsUserPropertyImpl_, InsUserProperty)
 protected
 // realized methods
   function DefaultGroupID: Integer; override;
 protected
 // protected methods
   constructor Create(const aProfile: IUserProfile); reintroduce;
 public
 // public methods
   class function Make(const aProfile: IUserProfile): InsUserProperty; reintroduce;
 end;//TnsUserProperty

implementation

uses
  DataAdapter,
  nsTypes,
  nsConst,
  IOUnit
  ;

{$Include ..\Users\nsUserPropertyImpl.imp.pas}

// start class TnsUserProperty

class function TnsUserProperty.Make(const aProfile: IUserProfile): InsUserProperty;
var
 l_Inst : TnsUserProperty;
begin
 l_Inst := Create(aProfile);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnsUserProperty.Create(const aProfile: IUserProfile);
//#UC START# *4B503E400115_4B5038B80195_var*
//#UC END# *4B503E400115_4B5038B80195_var*
begin
//#UC START# *4B503E400115_4B5038B80195_impl*
 inherited Create;
 SetProfileData(aProfile, False, False);
//#UC END# *4B503E400115_4B5038B80195_impl*
end;//TnsUserProperty.Create

function TnsUserProperty.DefaultGroupID: Integer;
//#UC START# *4B50439D03B6_4B5038B80195_var*
//#UC END# *4B50439D03B6_4B5038B80195_var*
begin
//#UC START# *4B50439D03B6_4B5038B80195_impl*
 Result := 0;
//#UC END# *4B50439D03B6_4B5038B80195_impl*
end;//TnsUserProperty.DefaultGroupID

end.