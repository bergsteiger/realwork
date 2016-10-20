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
var
 l_P, l_S : Il3CString;
 l_W : TtfwWord;
 l_Index : Integer;
 l_A : TtfwArray;
//#UC END# *57E553EC01EB_57E457780235_var*
begin
//#UC START# *57E553EC01EB_57E457780235_impl*
 Result := nil;
 //Self.FindWord(aName);
 TmsmWaitCursor.Make;
 if l3Starts(TtfwCStringFactory.C('U '), aName)
    OR l3Starts(TtfwCStringFactory.C('UID '), aName)
    OR l3Starts(TtfwCStringFactory.C('u '), aName)
    OR l3Starts(TtfwCStringFactory.C('uid '), aName)
    then
 begin
  l3Split(aName, ' ', l_P, l_S);
  l_S := l3LTrim(l3Trim(l_S));
  if TmsmModelElementMethodCaller.Call([TtfwStackValue_C(l_S),
                                        TtfwStackValue_C(TtfwCStringFactory.C(TmsmModelService.Instance.ModelRoot))],
                                        'TryLoadWordByUID').AsBoolean then
   ;
  with TmsmWordsCache.Instance do
  begin
   Lock;
   try
    l_W := nil;
    if FindData(TtfwCStringFactory.Cat(TtfwCStringFactory.C('ME_'), l_S), l_Index) then
    begin
     l_W := Items[l_index];
     l_A := TtfwArray.Create;
     try
      l_A.Add(TtfwStackValue_C(l_W));
      Result := l_A;
     finally
      FreeAndNil(l_A);
     end;//try..finally
    end;//FindData(TtfwCStringFactory.Cat(TtfwCStringFactory.C('ME_'), l_S), l_Index)
   finally
    Unlock;
   end;//try..finally
  end;//with TmsmWordsCache.Instance
 end//l3Starts('U ', aName)
 else
 begin
  if TmsmModelElementMethodCaller.Call([TtfwStackValue_C(aName),
                                        TtfwStackValue_C(TtfwCStringFactory.C(TmsmModelService.Instance.ModelRoot))],
                                        'TryLoadWord').AsBoolean then
   ;
  Result := TmsmWordsByUserNameIndex.Instance.FindWords(aName);
 end;//l3Starts('U ', aName)
//#UC END# *57E553EC01EB_57E457780235_impl*
end;//TmsmWordsManaging.FindWords

end.
