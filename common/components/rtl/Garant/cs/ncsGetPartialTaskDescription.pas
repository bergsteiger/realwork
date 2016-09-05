unit ncsGetPartialTaskDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetPartialTaskDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetPartialTaskDescription" MUID: (54B66DB30346)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsGetTaskDescription
 , k2Base
;

type
 TncsGetPartialTaskDescription = class(TncsGetTaskDescription)
  protected
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property FileName: AnsiString
    read pm_GetFileName
    write pm_SetFileName;
 end;//TncsGetPartialTaskDescription
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetPartialTaskDescription_Const
 //#UC START# *54B66DB30346impl_uses*
 //#UC END# *54B66DB30346impl_uses*
;

function TncsGetPartialTaskDescription.pm_GetFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileName]);
end;//TncsGetPartialTaskDescription.pm_GetFileName

procedure TncsGetPartialTaskDescription.pm_SetFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrFileName, nil] := (aValue);
end;//TncsGetPartialTaskDescription.pm_SetFileName

class function TncsGetPartialTaskDescription.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetPartialTaskDescription;
end;//TncsGetPartialTaskDescription.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
