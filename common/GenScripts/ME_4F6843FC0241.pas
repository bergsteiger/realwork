unit ddPropertyObject;

// Модуль: "w:\common\components\rtl\Garant\dd\ddPropertyObject.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Base
 , k2Interfaces
;

type
 TddPropertyObject = class(Tl3Base)
  private
   f_IsDefault: Boolean;
    {* Поле для свойства IsDefault }
  public
   procedure Clear; virtual;
   procedure MergeWith(P: TddPropertyObject); virtual; abstract;
   procedure InheriteFrom(P: TddPropertyObject); virtual; abstract;
   procedure Write2Generator(const Generator: Ik2TagGenerator); virtual; abstract;
   procedure Reset; virtual; abstract;
   function JoinWith(P: TObject): LongInt; virtual;
   function Diff(P: TddPropertyObject;
    aForReader: Boolean): TddPropertyObject; virtual; abstract;
   procedure AssignFrom(anOther: TddPropertyObject); virtual;
   function Clone: Pointer;
   constructor Create; override;
    {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
  public
   property IsDefault: Boolean
    read f_IsDefault
    write f_IsDefault;
 end;//TddPropertyObject

implementation

uses
 l3ImplUses
;

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
 {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
//#UC START# *47914F960008_4F6843FC0241_var*
//#UC END# *47914F960008_4F6843FC0241_var*
begin
//#UC START# *47914F960008_4F6843FC0241_impl*
 inherited Create;
 f_IsDefault := True;
//#UC END# *47914F960008_4F6843FC0241_impl*
end;//TddPropertyObject.Create

end.
