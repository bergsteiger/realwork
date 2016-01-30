unit m4WordList;
 {* Список слов }

// Модуль: "w:\common\components\rtl\Garant\m4\m4WordList.pas"
// Стереотип: "SimpleClass"

{$Include m4Define.inc}

interface

uses
 l3IntfUses
 , l3StringList
 , m4DictTypes
 , m4Word
 , l3Interfaces
;

type
 Tm4WordList = class(Tl3StringList)
  {* Список слов }
  private
   f_NextID: Tm4WordID;
  protected
   procedure InitFields; override;
  public
   function AddWord(const aStr: Tl3WString): Tm4WordID;
   constructor Create; reintroduce;
 end;//Tm4WordList

implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
;

function Tm4WordList.AddWord(const aStr: Tl3WString): Tm4WordID;
//#UC START# *4AB38FE40091_4AB37F2003B6_var*
//#UC END# *4AB38FE40091_4AB37F2003B6_var*
begin
//#UC START# *4AB38FE40091_4AB37F2003B6_impl*
 if not FindData(aStr, l_Index, l3_siCaseUnSensitive) then
 begin
  Result := f_NextID;
  l_Item := Tm4Word.Create(aStr, f_NextID);
  try
   Inc(f_NextID);
   DirectInsert(l_Index, l_Item);
  finally
   FreeAndNil(l_Item);
  end;//try..finally
 end//not Find(aStr, l_Index)
 else
  Result := Items[l_Index].StringID;
//#UC END# *4AB38FE40091_4AB37F2003B6_impl*
end;//Tm4WordList.AddWord

constructor Tm4WordList.Create;
//#UC START# *4AB38F9800B8_4AB37F2003B6_var*
//#UC END# *4AB38F9800B8_4AB37F2003B6_var*
begin
//#UC START# *4AB38F9800B8_4AB37F2003B6_impl*
 MakeSorted;
 SortIndex := l3_siCaseUnSensitive;
//#UC END# *4AB38F9800B8_4AB37F2003B6_impl*
end;//Tm4WordList.Create

procedure Tm4WordList.InitFields;
//#UC START# *47A042E100E2_4AB37F2003B6_var*
//#UC END# *47A042E100E2_4AB37F2003B6_var*
begin
//#UC START# *47A042E100E2_4AB37F2003B6_impl*
 inherited;
 f_NextID := 1;
//#UC END# *47A042E100E2_4AB37F2003B6_impl*
end;//Tm4WordList.InitFields

end.
