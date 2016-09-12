unit msmBaseModelElement;

// Модуль: "w:\common\components\gui\Garant\msm\msmBaseModelElement.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmBaseModelElement" MUID: (57AB17E6022C)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , msmModelElements
 {$If NOT Defined(NoScripts)}
 , tfwDictionaryEx
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
;

type
 TmsmBaseModelElement = class;

 ITmsmBaseModelElementWrap = interface
  ['{D348035F-F7EF-47FB-9853-454DCCB77A3D}']
  function GetSelf: TmsmBaseModelElement;
 end;//ITmsmBaseModelElementWrap

 TmsmBaseModelElement = {abstract} class(Tl3CProtoObject, ImsmBaseModelElement, ITmsmBaseModelElementWrap)
  private
   f_Name: Il3CString;
   f_Dictionary: TtfwDictionaryEx;
   f_MainWord: TtfwWord;
  protected
   function Get_Name: Il3CString;
   function Get_UID: Il3CString;
   function GetSelf: TmsmBaseModelElement;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aMainWord: TtfwWord); reintroduce;
  public
   property Dictionary: TtfwDictionaryEx
    read f_Dictionary;
   property MainWord: TtfwWord
    read f_MainWord;
 end;//TmsmBaseModelElement

implementation

uses
 l3ImplUses
 , msmModelElementMethodCaller
 //#UC START# *57AB17E6022Cimpl_uses*
 , SysUtils
 , l3InterfacesMisc
 //#UC END# *57AB17E6022Cimpl_uses*
;

constructor TmsmBaseModelElement.Create(aMainWord: TtfwWord);
//#UC START# *57AA08D80358_57AB17E6022C_var*
var
 l_KW : TtfwKeyWord;
//#UC END# *57AA08D80358_57AB17E6022C_var*
begin
//#UC START# *57AA08D80358_57AB17E6022C_impl*
 inherited Create;
 aMainWord.SetRefTo(f_MainWord);
 l_KW := f_MainWord.Key As TtfwKeyWord;
 if (l_KW = nil) then
 begin
 // - возможно это UP (IsSummoned) трансформированное в переменную
  f_Dictionary := nil;
  Assert(false, 'Элемент без словаря');
 end//l_KW = nil
 else
 if (l_KW.Dictionary Is TtfwDictionaryEx) then
  (l_KW.Dictionary As TtfwDictionaryEx).SetRefTo(f_Dictionary)
 else
  f_Dictionary := nil;
//#UC END# *57AA08D80358_57AB17E6022C_impl*
end;//TmsmBaseModelElement.Create

function TmsmBaseModelElement.Get_Name: Il3CString;
//#UC START# *57A9FE9400E7_57AB17E6022Cget_var*
//#UC END# *57A9FE9400E7_57AB17E6022Cget_var*
begin
//#UC START# *57A9FE9400E7_57AB17E6022Cget_impl*
 if (f_Name = nil) then
  f_Name := TmsmModelElementMethodCaller.CallAndGetString(f_MainWord, 'NameInModel');
 Result := f_Name; 
//#UC END# *57A9FE9400E7_57AB17E6022Cget_impl*
end;//TmsmBaseModelElement.Get_Name

function TmsmBaseModelElement.Get_UID: Il3CString;
//#UC START# *57AADF560165_57AB17E6022Cget_var*
//#UC END# *57AADF560165_57AB17E6022Cget_var*
begin
//#UC START# *57AADF560165_57AB17E6022Cget_impl*
 Result := TmsmModelElementMethodCaller.CallAndGetString(f_MainWord, 'UID');
//#UC END# *57AADF560165_57AB17E6022Cget_impl*
end;//TmsmBaseModelElement.Get_UID

function TmsmBaseModelElement.GetSelf: TmsmBaseModelElement;
//#UC START# *57AC39FE00B8_57AB17E6022C_var*
//#UC END# *57AC39FE00B8_57AB17E6022C_var*
begin
//#UC START# *57AC39FE00B8_57AB17E6022C_impl*
 Result := Self;
//#UC END# *57AC39FE00B8_57AB17E6022C_impl*
end;//TmsmBaseModelElement.GetSelf

procedure TmsmBaseModelElement.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AB17E6022C_var*
//#UC END# *479731C50290_57AB17E6022C_var*
begin
//#UC START# *479731C50290_57AB17E6022C_impl*
 FreeAndNil(f_Dictionary);
 FreeAndNil(f_MainWord);
 inherited;
//#UC END# *479731C50290_57AB17E6022C_impl*
end;//TmsmBaseModelElement.Cleanup

procedure TmsmBaseModelElement.ClearFields;
begin
 f_Name := nil;
 inherited;
end;//TmsmBaseModelElement.ClearFields

end.
