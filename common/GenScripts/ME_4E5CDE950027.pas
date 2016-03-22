unit l3SearchNodePrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3SearchNodePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3SearchNodePrim" MUID: (4E5CDE950027)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 Tl3SearchNodePrim = class(Tl3ProtoObject)
  private
   f_Data: IUnknown;
   f_Text: Il3CString;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aText: Il3CString;
    const aData: IUnknown); reintroduce;
  public
   property Data: IUnknown
    read f_Data
    write f_Data;
   property Text: Il3CString
    read f_Text
    write f_Text;
 end;//Tl3SearchNodePrim

implementation

uses
 l3ImplUses
;

constructor Tl3SearchNodePrim.Create(const aText: Il3CString;
 const aData: IUnknown);
//#UC START# *4E5CEE3601A1_4E5CDE950027_var*
//#UC END# *4E5CEE3601A1_4E5CDE950027_var*
begin
//#UC START# *4E5CEE3601A1_4E5CDE950027_impl*
 inherited Create;
 f_Text := aText;
 f_Data := aData;
//#UC END# *4E5CEE3601A1_4E5CDE950027_impl*
end;//Tl3SearchNodePrim.Create

procedure Tl3SearchNodePrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E5CDE950027_var*
//#UC END# *479731C50290_4E5CDE950027_var*
begin
//#UC START# *479731C50290_4E5CDE950027_impl*
 f_Text := nil;
 f_Data := nil;
 inherited;
//#UC END# *479731C50290_4E5CDE950027_impl*
end;//Tl3SearchNodePrim.Cleanup

procedure Tl3SearchNodePrim.ClearFields;
begin
 Data := nil;
 Text := nil;
 inherited;
end;//Tl3SearchNodePrim.ClearFields

end.
