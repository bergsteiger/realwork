unit ddBaseObject;

// Модуль: "w:\common\components\rtl\Garant\dd\ddBaseObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddBaseObject" MUID: (52BACF040379)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2Interfaces
 , ddTypes
;

type
 TddBaseObject = class(Tl3ProtoObject)
  public
   procedure Assign(anObject: TddBaseObject); virtual;
   constructor Create; reintroduce; virtual;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aLiteVersion: TddLiteVersion); virtual; abstract;
 end;//TddBaseObject

implementation

uses
 l3ImplUses
 , ddEVDTypesSupport
 , k2Tags
 //#UC START# *52BACF040379impl_uses*
 //#UC END# *52BACF040379impl_uses*
;

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
