unit evSavedCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evSavedCursor.pas"
// Начат: 21.03.2008 19:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evSavedCursor
//
// Объект для сохранения курсора.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevTools,
  l3ProtoObject
  ;

type
 TevSavedCursor = class(Tl3ProtoObject)
  {* Объект для сохранения курсора. }
 private
 // private fields
   f_Cursor : InevBasePoint;
    {* Поле для свойства Cursor}
   f_Old : IevSavedCursor;
    {* Поле для свойства Old}
   f_New : IevSavedCursor;
    {* Поле для свойства New}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aCursor: InevBasePoint;
    const aOld: IevSavedCursor;
    const aNew: IevSavedCursor); reintroduce;
 public
 // public properties
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

 PevSavedCursor = ^TevSavedCursor;
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
// start class TevSavedCursor

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
 {-}
begin
 {$If defined(evUseVisibleCursors)}
 Cursor := nil;
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 Old := nil;
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 New := nil;
 {$IfEnd} //evUseVisibleCursors
 inherited;
end;//TevSavedCursor.ClearFields
{$IfEnd} //evUseVisibleCursors

end.