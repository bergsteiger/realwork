unit ncsFileDescHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsFileDescHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::ResultDelivery::ncsFileDescHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3Variant,
  evdTasksHelpers
  ;

type
 FileDescHelper = interface(IUnknown{, FileDescTag})
   ['{80CB6FA6-C4E8-4EEC-B04A-F4EAA6DD7800}']
   procedure Add(anItem: Tl3Tag);
   function Get_Count: Integer;
   function Get_Files(anIndex: Integer): Tl3Tag;
   property Count: Integer
     read Get_Count;
   property Files[anIndex: Integer]: Tl3Tag
     read Get_Files;
 end;//FileDescHelper

 TFileDescHelper = class(TevdTagHelper, FileDescHelper)
 protected
 // realized methods
   function Get_Count: Integer;
   function Get_Files(anIndex: Integer): Tl3Tag;
   procedure Add(anItem: Tl3Tag);
 public
 // public methods
   class function Make(aValue: Tl3Tag): FileDescHelper; reintroduce;
     {* Сигнатура фабрики TFileDescHelper.Make }
 end;//TFileDescHelper
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  FileDesc_Const
  ;

// start class TFileDescHelper

class function TFileDescHelper.Make(aValue: Tl3Tag): FileDescHelper;
var
 l_Inst : TFileDescHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFileDescHelper.Get_Count: Integer;
//#UC START# *546EF5C00189_546EF62900AAget_var*
//#UC END# *546EF5C00189_546EF62900AAget_var*
begin
//#UC START# *546EF5C00189_546EF62900AAget_impl*
 Result := Value.ChildrenCount;
//#UC END# *546EF5C00189_546EF62900AAget_impl*
end;//TFileDescHelper.Get_Count

function TFileDescHelper.Get_Files(anIndex: Integer): Tl3Tag;
//#UC START# *546EF5CC0018_546EF62900AAget_var*
//#UC END# *546EF5CC0018_546EF62900AAget_var*
begin
//#UC START# *546EF5CC0018_546EF62900AAget_impl*
 Result := Value.Child[anIndex];
//#UC END# *546EF5CC0018_546EF62900AAget_impl*
end;//TFileDescHelper.Get_Files

procedure TFileDescHelper.Add(anItem: Tl3Tag);
//#UC START# *546EF5F6032D_546EF62900AA_var*
//#UC END# *546EF5F6032D_546EF62900AA_var*
begin
//#UC START# *546EF5F6032D_546EF62900AA_impl*
 Assert(anItem.TagType.IsKindOf(k2_typFileDesc));
 Value.AddChild(anItem);
//#UC END# *546EF5F6032D_546EF62900AA_impl*
end;//TFileDescHelper.Add
{$IfEnd} //not Nemesis

end.