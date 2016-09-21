unit msmElementSelectionDataObject;

// Модуль: "w:\common\components\gui\Garant\msm\msmElementSelectionDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmElementSelectionDataObject" MUID: (57E2605E0153)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , msmConcreteModels
 , l3DataObject
 , l3IID
;

type
 _DataType_ = ImsmElementSelection;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedDataObject.imp.pas}
 TmsmElementSelectionDataObject = class(_l3InterfacedDataObject_, Il3DataObjectInfo)
  protected
   function pm_GetIsQuestionNeedBeforeFlush: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetData(const aFormatEtcIn: TFormatEtc;
    var medium: Tl3StoragePlace): HResult; override;
  public
   constructor Create(const aSelection: ImsmElementSelection); reintroduce;
   class function Make(const aSelection: ImsmElementSelection): IDataObject; reintroduce;
   class function CF_msmSelection: Tl3ClipboardFormat;
   function AcceptableTymed: Integer; override;
 end;//TmsmElementSelectionDataObject

implementation

uses
 l3ImplUses
 , l3Base
 //#UC START# *57E2605E0153impl_uses*
 , Windows
 , SysUtils
 //#UC END# *57E2605E0153impl_uses*
;

var g_CF_msmSelection: Tl3ClipboardFormat;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacedDataObject.imp.pas}

constructor TmsmElementSelectionDataObject.Create(const aSelection: ImsmElementSelection);
//#UC START# *57E2612002BE_57E2605E0153_var*
//#UC END# *57E2612002BE_57E2605E0153_var*
begin
//#UC START# *57E2612002BE_57E2605E0153_impl*
 Assert(aSelection <> nil);
 //inherited Create(nil, l3FormatArray([{CF_Text, }CF_msmSelection]));
 inherited Create(aSelection.Clone, l3FormatArray([{CF_Text, }CF_msmSelection]));
 //inherited Create(aSelection.Clone, l3FormatArray([CF_Text{, CF_msmSelection}]));
//#UC END# *57E2612002BE_57E2605E0153_impl*
end;//TmsmElementSelectionDataObject.Create

class function TmsmElementSelectionDataObject.Make(const aSelection: ImsmElementSelection): IDataObject;
var
 l_Inst : TmsmElementSelectionDataObject;
begin
 l_Inst := Create(aSelection);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmElementSelectionDataObject.Make

class function TmsmElementSelectionDataObject.CF_msmSelection: Tl3ClipboardFormat;
//#UC START# *57E262A40242_57E2605E0153_var*
//#UC END# *57E262A40242_57E2605E0153_var*
begin
//#UC START# *57E262A40242_57E2605E0153_impl*
 if (g_CF_msmSelection = 0) then
  g_CF_msmSelection := Windows.RegisterClipboardFormat('msmSelection');
 Result := g_CF_msmSelection; 
//#UC END# *57E262A40242_57E2605E0153_impl*
end;//TmsmElementSelectionDataObject.CF_msmSelection

function TmsmElementSelectionDataObject.pm_GetIsQuestionNeedBeforeFlush: Boolean;
//#UC START# *4680FC190114_57E2605E0153get_var*
//#UC END# *4680FC190114_57E2605E0153get_var*
begin
//#UC START# *4680FC190114_57E2605E0153get_impl*
 Result := false;
//#UC END# *4680FC190114_57E2605E0153get_impl*
end;//TmsmElementSelectionDataObject.pm_GetIsQuestionNeedBeforeFlush

procedure TmsmElementSelectionDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E2605E0153_var*
//#UC END# *479731C50290_57E2605E0153_var*
begin
//#UC START# *479731C50290_57E2605E0153_impl*
 inherited;
//#UC END# *479731C50290_57E2605E0153_impl*
end;//TmsmElementSelectionDataObject.Cleanup

function TmsmElementSelectionDataObject.DoGetData(const aFormatEtcIn: TFormatEtc;
 var medium: Tl3StoragePlace): HResult;
//#UC START# *48F3495D0398_57E2605E0153_var*
//type
// PmsmElementSelection = ^ImsmElementSelection;
var
 l_Handle : THandle;
 l_Data   : PmsmElementSelection;
 l_Selection : ImsmElementSelection;
//#UC END# *48F3495D0398_57E2605E0153_var*
begin
//#UC START# *48F3495D0398_57E2605E0153_impl*
 Result := inherited DoGetData(aFormatEtcIn, medium);
 if (Result <> S_Ok) then
 begin
  with aFormatEtcIn do
  begin
   if (cfFormat = CF_msmSelection) then
   begin
    l_Selection := Data;
    if (l_Selection <> nil) then
    //if Supports(Data, ImsmElementSelection, l_Selection) then
     try
      if (tymed AND TYMED_HGLOBAL <> 0) then
      begin
       medium.tymed := TYMED_HGLOBAL;
       l_Handle := l3System.GlobalAlloc(GMEM_SHARE, SizeOf(ImsmElementSelection));
       try
        l_Data := GlobalLock(l_Handle);
        try
         l3FillChar(l_Data^, SizeOf(l_Data^), 0);
         PPointer(l_Data)^ := Pointer(l_Selection);
        finally
         GlobalUnlock(l_Handle);
        end;//try..finally
        medium.hGlobal := l3System.ReleaseHandle(l_Handle);
        Result := S_Ok;
       except
        l3System.GlobalFree(l_Handle);
        Result := E_OutOfMemory;
       end;//try..except
      end;//tymed AND TYMED_HGLOBAL <> 0
     finally
      l_Selection := nil;
     end;//try..finally
   end;//cfFormat = CF_msmSelection
  end;//with aFormatEtcIn
 end;//Result <> S_Ok
//#UC END# *48F3495D0398_57E2605E0153_impl*
end;//TmsmElementSelectionDataObject.DoGetData

function TmsmElementSelectionDataObject.AcceptableTymed: Integer;
//#UC START# *48F351BE0015_57E2605E0153_var*
//#UC END# *48F351BE0015_57E2605E0153_var*
begin
//#UC START# *48F351BE0015_57E2605E0153_impl*
 Result := inherited AcceptableTymed or TYMED_HGLOBAL;
 //Result := Result or TYMED_ISTREAM;
//#UC END# *48F351BE0015_57E2605E0153_impl*
end;//TmsmElementSelectionDataObject.AcceptableTymed

end.
