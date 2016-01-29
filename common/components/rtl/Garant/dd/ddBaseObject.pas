unit ddBaseObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddBaseObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddBaseObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  k2Interfaces,
  l3ProtoObject
  ;

type
 TddBaseObject = class(Tl3ProtoObject)
 public
 // public methods
   procedure Assign(anObject: TddBaseObject); virtual;
   constructor Create; reintroduce; virtual;
     {* Сигнатура метода Create }
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aLiteVersion: Boolean); virtual; abstract;
 end;//TddBaseObject

implementation

uses
  ddEVDTypesSupport,
  k2Tags
  ;

// start class TddBaseObject

procedure TddBaseObject.Assign(anObject: TddBaseObject);
//#UC START# *52BACF8A01A9_52BACF040379_var*
//#UC END# *52BACF8A01A9_52BACF040379_var*
begin
//#UC START# *52BACF8A01A9_52BACF040379_impl*
 
//#UC END# *52BACF8A01A9_52BACF040379_impl*
end;//TddBaseObject.Assign

constructor TddBaseObject.Create;
//#UC START# *52BACFBE00D9_52BACF040379_var*
//#UC END# *52BACFBE00D9_52BACF040379_var*
begin
//#UC START# *52BACFBE00D9_52BACF040379_impl*
 inherited Create;
//#UC END# *52BACFBE00D9_52BACF040379_impl*
end;//TddBaseObject.Create

end.