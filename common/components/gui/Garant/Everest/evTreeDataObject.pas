unit evTreeDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evTreeDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTreeDataObject" MUID: (48FC8B3D01BC)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evTreeStorable
 , nevTools
 , evPersistentDataObjectEx
 , l3Interfaces
;

type
 _DataType_ = TevTreeStorableData;
 _StorableClass_ = TevTreeStorable;
 {$Include w:\common\components\gui\Garant\Everest\evDataObjectFromStorable.imp.pas}
 TevTreeDataObject = class(_evDataObjectFromStorable_)
  public
   class function MakeStorable(const aData: TevTreeStorableData): InevDataObjectPrim2; reintroduce;
 end;//TevTreeDataObject

implementation

uses
 l3ImplUses
 , evFormats
 , evTypes
 , l3Base
 //#UC START# *48FC8B3D01BCimpl_uses*
 //#UC END# *48FC8B3D01BCimpl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\evDataObjectFromStorable.imp.pas}

class function TevTreeDataObject.MakeStorable(const aData: TevTreeStorableData): InevDataObjectPrim2;
var
 l_Inst : TevTreeDataObject;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevTreeDataObject.MakeStorable

end.
