unit ddPropertyObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddPropertyObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddPropertyObject
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
  l3Base
  ;

type
 TddPropertyObject = class(Tl3Base)
 private
 // private fields
   f_IsDefault : Boolean;
    {* Поле для свойства IsDefault}
 public
 // overridden public methods
   constructor Create; override;
     {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
 public
 // public methods
   procedure Clear; virtual;
   procedure MergeWith(P: TddPropertyObject); virtual; abstract;
   procedure InheriteFrom(P: TddPropertyObject); virtual; abstract;
   procedure Write2Generator(const Generator: Ik2TagGenerator); virtual; abstract;
   procedure Reset; virtual; abstract;
   function JoinWith(P: TObject): LongInt; virtual;
   function Diff(P: TddPropertyObject): TddPropertyObject; virtual; abstract;
   procedure AssignFrom(anOther: TddPropertyObject); virtual;
   function Clone: Pointer;
 public
 // public properties
   property IsDefault: Boolean
     read f_IsDefault
     write f_IsDefault;
 end;//TddPropertyObject

implementation

// start class TddPropertyObject

procedure TddPropertyObject.Clear;
//#UC START# *518A13330058_4F6843FC0241_var*
//#UC END# *518A13330058_4F6843FC0241_var*
begin
//#UC START# *518A13330058_4F6843FC0241_impl*
//#UC END# *518A13330058_4F6843FC0241_impl*
end;//TddPropertyObject.Clear

function TddPropertyObject.JoinWith(P: TObject): LongInt;
//#UC START# *525E47BE030D_4F6843FC0241_var*
//#UC END# *525E47BE030D_4F6843FC0241_var*
begin
//#UC START# *525E47BE030D_4F6843FC0241_impl*
 Result := -1;
//#UC END# *525E47BE030D_4F6843FC0241_impl*
end;//TddPropertyObject.JoinWith

procedure TddPropertyObject.AssignFrom(anOther: TddPropertyObject);
//#UC START# *5301DFE6002C_4F6843FC0241_var*
//#UC END# *5301DFE6002C_4F6843FC0241_var*
begin
//#UC START# *5301DFE6002C_4F6843FC0241_impl*
 Assert(false, 'Надо реализовывать в потомках');
//#UC END# *5301DFE6002C_4F6843FC0241_impl*
end;//TddPropertyObject.AssignFrom

function TddPropertyObject.Clone: Pointer;
//#UC START# *5302150D006B_4F6843FC0241_var*
type
 RddPropertyObject = class of TddPropertyObject;
//#UC END# *5302150D006B_4F6843FC0241_var*
begin
//#UC START# *5302150D006B_4F6843FC0241_impl*
 Result := RddPropertyObject(ClassType).Create;
 TddPropertyObject(Result).AssignFrom(Self);
//#UC END# *5302150D006B_4F6843FC0241_impl*
end;//TddPropertyObject.Clone

constructor TddPropertyObject.Create;
//#UC START# *47914F960008_4F6843FC0241_var*
//#UC END# *47914F960008_4F6843FC0241_var*
begin
//#UC START# *47914F960008_4F6843FC0241_impl*
 inherited Create;
 f_IsDefault := True;
//#UC END# *47914F960008_4F6843FC0241_impl*
end;//TddPropertyObject.Create

end.