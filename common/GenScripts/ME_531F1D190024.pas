unit k2ChildrenPath;

// Модуль: "w:\common\components\rtl\Garant\K2\k2ChildrenPath.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Types
;

type
 Tk2ChildrenPath = class(Tl3ProtoObject)
  private
   f_Path: TLongArray;
    {* Поле для свойства Path }
   f_TagType: Integer;
    {* Поле для свойства TagType }
  protected
  public
   constructor Create(aTagType: Integer;
    const aPath: TLongArray); reintroduce;
  public
   property Path: TLongArray
    read f_Path;
   property TagType: Integer
    read f_TagType;
 end;//Tk2ChildrenPath

implementation

uses
 l3ImplUses
;

constructor Tk2ChildrenPath.Create(aTagType: Integer;
 const aPath: TLongArray);
//#UC START# *531F1FA70253_531F1D190024_var*
//#UC END# *531F1FA70253_531F1D190024_var*
begin
//#UC START# *531F1FA70253_531F1D190024_impl*
 inherited Create;
 f_TagType := aTagType;
 f_Path := aPath;
//#UC END# *531F1FA70253_531F1D190024_impl*
end;//Tk2ChildrenPath.Create

end.
