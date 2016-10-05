unit msmWordsManaging;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordsManaging.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWordsManaging" MUID: (57E457780235)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
;

type
 TmsmWordsManaging = class
  public
   class function FindWord(const aName: Il3CString): TtfwWord;
   class function FindWords(const aName: Il3CString): ItfwArray;
 end;//TmsmWordsManaging

implementation

uses
 l3ImplUses
 , msmWordsCache
 , msmModelElementMethodCaller
 , msmWordsByUserNameIndex
 , msmModelService
 //#UC START# *57E457780235impl_uses*
 , SysUtils
 , l3String
 , msmWaitCursor
 , tfwArray
 //#UC END# *57E457780235impl_uses*
;

class function TmsmWordsManaging.FindWord(const aName: Il3CString): TtfwWord;
//#UC START# *57E457A50292_57E457780235_var*
var
 l_O : TObject;
//#UC END# *57E457A50292_57E457780235_var*
begin
//#UC START# *57E457A50292_57E457780235_impl*
 Result := nil;
 TmsmWaitCursor.Make;
 l_O := TmsmWordsByUserNameIndex.Instance.FindWord(aName);
 //l_O := TmsmModelElementMethodCaller.Call([TtfwStackValue_C(TmsmWordsCache.Instance.AsArray), TtfwStackValue_C(aName)], 'FindWord').AsObject;
 if (l_O = nil) then
 begin
  if TmsmModelElementMethodCaller.Call([TtfwStackValue_C(aName),
                                        TtfwStackValue_C(TtfwCStringFactory.C(TmsmModelService.Instance.ModelRoot))],
                                        'TryLoadWord').AsBoolean then
   l_O := TmsmWordsByUserNameIndex.Instance.FindWord(aName);
 end;//l_O = nil
 if (l_O <> nil) then
  Result := l_O As TtfwWord;
//#UC END# *57E457A50292_57E457780235_impl*
end;//TmsmWordsManaging.FindWord

class function TmsmWordsManaging.FindWords(const aName: Il3CString): ItfwArray;
//#UC START# *57E553EC01EB_57E457780235_var*
//#UC END# *57E553EC01EB_57E457780235_var*
begin
//#UC START# *57E553EC01EB_57E457780235_impl*
 Result := nil;
 //Self.FindWord(aName);
 TmsmWaitCursor.Make;
 if TmsmModelElementMethodCaller.Call([TtfwStackValue_C(aName),
                                       TtfwStackValue_C(TtfwCStringFactory.C(TmsmModelService.Instance.ModelRoot))],
                                       'TryLoadWord').AsBoolean then
  ;                                     
 Result := TmsmWordsByUserNameIndex.Instance.FindWords(aName);
//#UC END# *57E553EC01EB_57E457780235_impl*
end;//TmsmWordsManaging.FindWords

end.
