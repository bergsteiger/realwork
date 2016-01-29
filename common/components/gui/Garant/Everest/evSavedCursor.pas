unit evSavedCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evSavedCursor.pas"
// �����: 21.03.2008 19:09
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evSavedCursor
//
// ������ ��� ���������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevTools,
  l3ProtoObject
  ;

type
 TevSavedCursor = class(Tl3ProtoObject)
  {* ������ ��� ���������� �������. }
 private
 // private fields
   f_Cursor : InevBasePoint;
    {* ���� ��� �������� Cursor}
   f_Old : IevSavedCursor;
    {* ���� ��� �������� Old}
   f_New : IevSavedCursor;
    {* ���� ��� �������� New}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
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
     {* ������, ������� ���������. }
   property Old: IevSavedCursor
     read f_Old
     write f_Old;
     {* ������ �������� �������. }
   property New: IevSavedCursor
     read f_New
     write f_New;
     {* ����� �������� �������. }
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