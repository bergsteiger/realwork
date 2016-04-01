unit NOT_COMPLETED_k2ToolPrim;

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_COMPLETED_k2ToolPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2ToolPrim" MUID: (47F5DAEB0007)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Tag
 , l3Variant
;

type
 Tk2ToolPrim = {abstract} class(Tk2Tag, IUnknown)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure AfterFree; override;
    {* функция, вызываемая после каждого уменьшении счетчика ссылок на объект, не приводящего к уничтожению объекта }
  public
   procedure Assign(Source: Tk2ToolPrim); virtual;
   class function StoreToOldCache: Boolean; virtual;
   procedure SetTagQT(aTag: Tl3Variant); virtual; abstract;
 end;//Tk2ToolPrim

implementation

uses
 l3ImplUses
;

procedure Tk2ToolPrim.Assign(Source: Tk2ToolPrim);
//#UC START# *52BC1DD60298_47F5DAEB0007_var*
//#UC END# *52BC1DD60298_47F5DAEB0007_var*
begin
//#UC START# *52BC1DD60298_47F5DAEB0007_impl*
 Assert(false, 'Зачем Assign тут вообще нужен?');
//#UC END# *52BC1DD60298_47F5DAEB0007_impl*
end;//Tk2ToolPrim.Assign

class function Tk2ToolPrim.StoreToOldCache: Boolean;
//#UC START# *49DF4E12001A_47F5DAEB0007_var*
//#UC END# *49DF4E12001A_47F5DAEB0007_var*
begin
//#UC START# *49DF4E12001A_47F5DAEB0007_impl*
 Result := false;
//#UC END# *49DF4E12001A_47F5DAEB0007_impl*
end;//Tk2ToolPrim.StoreToOldCache

{$If NOT Defined(DesignTimeLibrary)}
class function Tk2ToolPrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47F5DAEB0007_var*
//#UC END# *47A6FEE600FC_47F5DAEB0007_var*
begin
//#UC START# *47A6FEE600FC_47F5DAEB0007_impl*
 Result := not StoreToOldCache;
//#UC END# *47A6FEE600FC_47F5DAEB0007_impl*
end;//Tk2ToolPrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure Tk2ToolPrim.AfterFree;
 {* функция, вызываемая после каждого уменьшении счетчика ссылок на объект, не приводящего к уничтожению объекта }
//#UC START# *531EEB8503AE_47F5DAEB0007_var*
//#UC END# *531EEB8503AE_47F5DAEB0007_var*
begin
//#UC START# *531EEB8503AE_47F5DAEB0007_impl*
 inherited;
 if (RefCount <= 1) AND StoreToOldCache then
  Cleanup;
//#UC END# *531EEB8503AE_47F5DAEB0007_impl*
end;//Tk2ToolPrim.AfterFree

end.
