unit ddAnnoKindSortItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/PipeOut/ddAnnoKindSortItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::PipeOut::TddAnnoKindSortItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
  l3Interfaces,
  l3LongintList,
  l3ProtoObject,
  ddPipeOutInterfaces
  ;

type
 TddAnnoKindSortItem = class(Tl3ProtoObject, IddAnnoKindSortItem)
 private
 // private fields
   f_Name : Il3CString;
   f_TopicList : Tl3LongintList;
   f_ID : Integer;
 protected
 // realized methods
   function Get_Name: Il3CString;
   procedure Add(aTopic: Integer);
   function Get_Count: Integer;
   function Get_Topics(aIdx: Integer): Integer;
   function Get_ID: Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aName: AnsiString;
     aID: Integer); reintroduce;
   class function Make(const aName: AnsiString;
     aID: Integer): IddAnnoKindSortItem; reintroduce;
     {* Сигнатура фабрики TddAnnoKindSortItem.Make }
 end;//TddAnnoKindSortItem

implementation

uses
  l3Base,
  SysUtils
  ;

// start class TddAnnoKindSortItem

constructor TddAnnoKindSortItem.Create(const aName: AnsiString;
  aID: Integer);
//#UC START# *564C630F00A3_564C627A03D0_var*
//#UC END# *564C630F00A3_564C627A03D0_var*
begin
//#UC START# *564C630F00A3_564C627A03D0_impl*
 inherited Create;
 f_Name := l3CStr(aName);
 f_ID := aID;
 f_TopicList := Tl3LongintList.MakeSorted;
//#UC END# *564C630F00A3_564C627A03D0_impl*
end;//TddAnnoKindSortItem.Create

class function TddAnnoKindSortItem.Make(const aName: AnsiString;
  aID: Integer): IddAnnoKindSortItem;
var
 l_Inst : TddAnnoKindSortItem;
begin
 l_Inst := Create(aName, aID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TddAnnoKindSortItem.Get_Name: Il3CString;
//#UC START# *564C606E003D_564C627A03D0get_var*
//#UC END# *564C606E003D_564C627A03D0get_var*
begin
//#UC START# *564C606E003D_564C627A03D0get_impl*
 Result := f_Name;
//#UC END# *564C606E003D_564C627A03D0get_impl*
end;//TddAnnoKindSortItem.Get_Name

procedure TddAnnoKindSortItem.Add(aTopic: Integer);
//#UC START# *564C60D40342_564C627A03D0_var*
//#UC END# *564C60D40342_564C627A03D0_var*
begin
//#UC START# *564C60D40342_564C627A03D0_impl*
 f_TopicList.Add(aTopic);
//#UC END# *564C60D40342_564C627A03D0_impl*
end;//TddAnnoKindSortItem.Add

function TddAnnoKindSortItem.Get_Count: Integer;
//#UC START# *564C611801BD_564C627A03D0get_var*
//#UC END# *564C611801BD_564C627A03D0get_var*
begin
//#UC START# *564C611801BD_564C627A03D0get_impl*
 Result := f_TopicList.Count;
//#UC END# *564C611801BD_564C627A03D0get_impl*
end;//TddAnnoKindSortItem.Get_Count

function TddAnnoKindSortItem.Get_Topics(aIdx: Integer): Integer;
//#UC START# *564C61F80097_564C627A03D0get_var*
//#UC END# *564C61F80097_564C627A03D0get_var*
begin
//#UC START# *564C61F80097_564C627A03D0get_impl*
 Result := f_TopicList.Items[aIdx];
//#UC END# *564C61F80097_564C627A03D0get_impl*
end;//TddAnnoKindSortItem.Get_Topics

function TddAnnoKindSortItem.Get_ID: Integer;
//#UC START# *564DA034027A_564C627A03D0get_var*
//#UC END# *564DA034027A_564C627A03D0get_var*
begin
//#UC START# *564DA034027A_564C627A03D0get_impl*
 Result := f_ID;
//#UC END# *564DA034027A_564C627A03D0get_impl*
end;//TddAnnoKindSortItem.Get_ID

procedure TddAnnoKindSortItem.Cleanup;
//#UC START# *479731C50290_564C627A03D0_var*
//#UC END# *479731C50290_564C627A03D0_var*
begin
//#UC START# *479731C50290_564C627A03D0_impl*
 FreeAndNil(f_TopicList);
 f_Name := nil;
 inherited;
//#UC END# *479731C50290_564C627A03D0_impl*
end;//TddAnnoKindSortItem.Cleanup

end.