unit msmOperations;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperations.pas"
// Стереотип: "InternalInterfaces"
// Элемент модели: "msmOperations" MUID: (57CEABF60269)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmEvents
 , Classes
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmOperationParams = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rCaption: AnsiString;
   rEnabled: Boolean;
   rImageIndex: Integer;
   rShortCut: TShortCut;
  public
   procedure SetShortCut(const aString: AnsiString);
 end;//TmsmOperationParams

 ImsmOperation = interface
  ['{09BB18A4-33A4-4074-9845-273279C761A7}']
  function Get_Action: TAction;
  function Get_Params: TmsmOperationParams;
  function Caption: AnsiString;
  procedure DoIt;
  function Enabled: Boolean;
  property Action: TAction
   read Get_Action;
  property Params: TmsmOperationParams
   read Get_Params;
 end;//ImsmOperation

 ImsmOperationsList = interface
  ['{0DB0874B-D6F3-44CD-A483-083C7D487BFB}']
  function Get_Count: Integer;
  function Get_Items(anIndex: Integer): ImsmOperation;
  property Count: Integer
   read Get_Count;
  property Items[anIndex: Integer]: ImsmOperation
   read Get_Items;
   default;
 end;//ImsmOperationsList

 (*
 MmsmOperationsManaging = interface
  function Get_Operations: ImsmOperationsList;
  procedure AddOperation(const anOp: ImsmOperation);
  property Operations: ImsmOperationsList
   read Get_Operations;
 end;//MmsmOperationsManaging
 *)

function TmsmOperationParams_C(const aCaption: AnsiString;
 anEnabled: Boolean): TmsmOperationParams; overload;
function TmsmOperationParams_C(const aCaption: AnsiString): TmsmOperationParams; overload;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
;

function TmsmOperationParams_C(const aCaption: AnsiString;
 anEnabled: Boolean): TmsmOperationParams;
//#UC START# *57EBAD6A0303_57EBACBA00FA_var*
//#UC END# *57EBAD6A0303_57EBACBA00FA_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57EBAD6A0303_57EBACBA00FA_impl*
 Result.rCaption := aCaption;
 Result.rEnabled := anEnabled;
 Result.rImageIndex := -1;
 Result.rShortCut := 0;
//#UC END# *57EBAD6A0303_57EBACBA00FA_impl*
end;//TmsmOperationParams_C

function TmsmOperationParams_C(const aCaption: AnsiString): TmsmOperationParams;
//#UC START# *57EBBC4903B7_57EBACBA00FA_var*
//#UC END# *57EBBC4903B7_57EBACBA00FA_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57EBBC4903B7_57EBACBA00FA_impl*
 Result := TmsmOperationParams_C(aCaption, true);
//#UC END# *57EBBC4903B7_57EBACBA00FA_impl*
end;//TmsmOperationParams_C

procedure TmsmOperationParams.SetShortCut(const aString: AnsiString);
//#UC START# *57F4F67103C4_57EBACBA00FA_var*
//#UC END# *57F4F67103C4_57EBACBA00FA_var*
begin
//#UC START# *57F4F67103C4_57EBACBA00FA_impl*
 Self.rShortCut := TextToShortCut(aString);
//#UC END# *57F4F67103C4_57EBACBA00FA_impl*
end;//TmsmOperationParams.SetShortCut

end.
