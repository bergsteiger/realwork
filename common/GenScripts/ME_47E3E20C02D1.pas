unit evSavedCursor;
 {* Объект для сохранения курсора. }

// Модуль: "w:\common\components\gui\Garant\Everest\evSavedCursor.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
;

type
 PevSavedCursor = ^TevSavedCursor;

 TevSavedCursor = class(Tl3ProtoObject)
  {* Объект для сохранения курсора. }
  private
   f_Cursor: InevBasePoint;
    {* Поле для свойства Cursor }
   f_Old: IevSavedCursor;
    {* Поле для свойства Old }
   f_New: IevSavedCursor;
    {* Поле для свойства New }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aCursor: InevBasePoint;
    const aOld: IevSavedCursor;
    const aNew: IevSavedCursor); reintroduce;
  public
   property Cursor: InevBasePoint
    read f_Cursor
    write f_Cursor;
    {* курсор, который изменялся. }
   property Old: IevSavedCursor
    read f_Old
    write f_Old;
    {* старое значение курсора. }
   property New: IevSavedCursor
    read f_New
    write f_New;
    {* новое значение курсора. }
 end;//TevSavedCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;

constructor TevSavedCursor.Create(const aCursor: InevBasePoint;
 const aOld: IevSavedCursor;
 const aNew: IevSavedCursor);
//#UC START# *47E3E1DE01E5_47E3DFD00379_var*
//#UC END# *47E3E1DE01E5_47E3DFD00379_var*
begin
//#UC START# *47E3E1DE01E5_47E3DFD00379_impl*
 inherited Create;
 Cursor := aCursor;
 Old := aOld;
 New := aNew;
//#UC END# *47E3E1DE01E5_47E3DFD00379_impl*
end;//TevSavedCursor.Create

procedure TevSavedCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47E3DFD00379_var*
//#UC END# *479731C50290_47E3DFD00379_var*
begin
//#UC START# *479731C50290_47E3DFD00379_impl*
 Cursor := nil;
 Old := nil;
 New := nil;
 inherited;
//#UC END# *479731C50290_47E3DFD00379_impl*
end;//TevSavedCursor.Cleanup

procedure TevSavedCursor.ClearFields;
begin
 Cursor := nil;
 Old := nil;
 New := nil;
 inherited;
end;//TevSavedCursor.ClearFields
{$IfEnd} // Defined(evUseVisibleCursors)

end.
