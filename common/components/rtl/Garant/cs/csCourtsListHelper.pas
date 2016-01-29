unit csCourtsListHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csCourtsListHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::CourtDecisionSabCheckerParams::csCourtsListHelper
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
 CourtsListHelper = interface(IUnknown{, CourtDescriptionTag})
   ['{E39A76B6-04C6-4A36-B818-E4DB65DD387A}']
   procedure Add(anItem: Tl3Tag);
   function Get_Count: Integer;
   function Get_Courts(anIndex: Integer): Tl3Tag;
   property Count: Integer
     read Get_Count;
   property Courts[anIndex: Integer]: Tl3Tag
     read Get_Courts;
 end;//CourtsListHelper

 TCourtsListHelper = class(TevdTagHelper, CourtsListHelper)
 protected
 // realized methods
   function Get_Count: Integer;
   procedure Add(anItem: Tl3Tag);
   function Get_Courts(anIndex: Integer): Tl3Tag;
 public
 // public methods
   class function Make(aValue: Tl3Tag): CourtsListHelper; reintroduce;
     {* Сигнатура фабрики TCourtsListHelper.Make }
 end;//TCourtsListHelper
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CourtDescription_Const
  ;

// start class TCourtsListHelper

class function TCourtsListHelper.Make(aValue: Tl3Tag): CourtsListHelper;
var
 l_Inst : TCourtsListHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TCourtsListHelper.Get_Count: Integer;
//#UC START# *53F1A0C00041_53F19FD5004Bget_var*
//#UC END# *53F1A0C00041_53F19FD5004Bget_var*
begin
//#UC START# *53F1A0C00041_53F19FD5004Bget_impl*
 Result := Value.ChildrenCount;
//#UC END# *53F1A0C00041_53F19FD5004Bget_impl*
end;//TCourtsListHelper.Get_Count

procedure TCourtsListHelper.Add(anItem: Tl3Tag);
//#UC START# *53F1A11B01EF_53F19FD5004B_var*
//#UC END# *53F1A11B01EF_53F19FD5004B_var*
begin
//#UC START# *53F1A11B01EF_53F19FD5004B_impl*
 Assert(anItem.TagType.IsKindOf(k2_typCourtDescription));
 Value.AddChild(anItem);
//#UC END# *53F1A11B01EF_53F19FD5004B_impl*
end;//TCourtsListHelper.Add

function TCourtsListHelper.Get_Courts(anIndex: Integer): Tl3Tag;
//#UC START# *53F1E757017F_53F19FD5004Bget_var*
//#UC END# *53F1E757017F_53F19FD5004Bget_var*
begin
//#UC START# *53F1E757017F_53F19FD5004Bget_impl*
 Result := Value.Child[anIndex];
//#UC END# *53F1E757017F_53F19FD5004Bget_impl*
end;//TCourtsListHelper.Get_Courts
{$IfEnd} //not Nemesis

end.