unit EVDtoRTFRender;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\EVDtoRTFRender.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 THiddenStylesArray = array of LongInt;

 TEVDtoRTFRender = {abstract} class(TBaseTest)
  protected
   function NeedEliminateCommentDecorations: Boolean; virtual;
   function TreatExceptionAsSuccess: Boolean; virtual;
   function GetHiddenStylesLength: Integer; virtual;
   function GetHiddenStyles: THiddenStylesArray; virtual;
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TEVDtoRTFRender
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , eeEVDtoRTF
 , l3Filer
 , SysUtils
 , l3Interfaces
 , evStyleInterfaceEx
 , l3Memory
 , l3Stream
 , l3BaseStream
 , TestFrameWork
;

procedure TEVDtoRTFRender.DoIt;
//#UC START# *52BAFCD800D9_52BAFC960080_var*
var
 l_Buff : array [0..32 * 1024] of AnsiChar;
 l_Sz : Integer;
 l_Check: Boolean;
 l_Raise: Boolean;
 l_EVS : Tl3CustomFiler;
 l_EVD : Tl3CustomFiler;
 l_F : Tl3CustomFiler;
 l_N : String;
 l_Out : IStream;
 l_In : IStream;
 l_SMP : Tl3SizedMemoryPool;
 l_SMPS : TStream;
//#UC END# *52BAFCD800D9_52BAFC960080_var*
begin
//#UC START# *52BAFCD800D9_52BAFC960080_impl*
 l_Raise := TreatExceptionAsSuccess;
 l_EVS := FilerForInput(KPage + '.evs');
 try
  l_EVS.Open;
  try
   l_Sz := l_EVS.Size;                                                  
   Assert(l_Sz < Length(l_Buff));
   l_EVS.Read(@l_Buff, l_Sz);
  finally
   l_EVS.Close;
  end;//try..finally
 finally
  FreeAndNil(l_EVS);
 end;//try..finally
 l_EVD := FilerForInput(KPage + '.evd');
 try
  l_EVD.Open;
  try
   l_In := l_EVD As IStream{.COMStream};
   try
    l_F := FilerForOutput;
    try
     l_F.Open;
     try
      l_Out := l_F.COMStream;
      try
       l_SMP := Tl3SizedMemoryPool.Create;
       try
        l3IStream2Stream(l_SMP As IStream, l_SMPS);
        try
         with TevStyleInterfaceEx.Make do
          try
           Save(l_SMPS);
          finally
           Free;
          end;//try..finally
        finally
         FreeAndNil(l_SMPS);
        end;//try..finally
        try
         Check(eeEVDtoRTF.SetStyleTable(@l_Buff, l_Sz), 'Не удалось установить таблицу стилей');
         try
          if not NeedEliminateCommentDecorations then
          begin
           l_Check := eeEVDtoRTF.EVDtoRTF(l_In,
                                          l_Out,
                                          (*@l_Buff,
                                          l_Sz,*)
                                          @GetHiddenStyles[0],
                                          GetHiddenStylesLength,
                                          'http://www.garant.ru');
           Check(l_Check);
          end // if not NeedEliminateCommentDecorations then
          else
          begin
           l_Check := eeEVDtoRTF.EVDtoRTFWithoutCommentDecor(l_In,
                                                             l_Out,
                                                             (*@l_Buff,
                                                             l_Sz,*)
                                                             @GetHiddenStyles[0],
                                                             GetHiddenStylesLength,
                                                             'http://www.garant.ru');
           Check(l_Check);
          end;
         except
          if l_Raise then Exit else raise;
         end;
        finally
         l3IStream2Stream(l_SMP As IStream, l_SMPS);
         try
          with TevStyleInterfaceEx.Make do
           try
            Load(l_SMPS);
           finally
            Free;
           end;//try..finally
         finally
          FreeAndNil(l_SMPS);
         end;//try..finally
        end;//try..finally 
       finally
        FreeAndNil(l_SMP);
       end;//try..finally
      finally
       l_Out := nil;
      end;//try..finally
     finally
      l_F.Close;
     end;//try..finally
     l_N := ChangeFileExt(ExtractFileName(l_F.Identifier), EtalonSuffix + '.rtf');
    finally
     FreeAndNil(l_F);
    end;//try..finally
   finally
    l_In := nil;
   end;//try..finally
  finally
   l_EVD.Close;
  end;//try..finally
 finally
  FreeAndNil(l_EVD);
 end;//try..finally
 CheckOutputWithInput(l_N);
//#UC END# *52BAFCD800D9_52BAFC960080_impl*
end;//TEVDtoRTFRender.DoIt

function TEVDtoRTFRender.NeedEliminateCommentDecorations: Boolean;
//#UC START# *530C91FB00BD_52BAFC960080_var*
//#UC END# *530C91FB00BD_52BAFC960080_var*
begin
//#UC START# *530C91FB00BD_52BAFC960080_impl*
 Result := False;
//#UC END# *530C91FB00BD_52BAFC960080_impl*
end;//TEVDtoRTFRender.NeedEliminateCommentDecorations

function TEVDtoRTFRender.TreatExceptionAsSuccess: Boolean;
//#UC START# *53DA3E0C019A_52BAFC960080_var*
//#UC END# *53DA3E0C019A_52BAFC960080_var*
begin
//#UC START# *53DA3E0C019A_52BAFC960080_impl*
 Result := False;
//#UC END# *53DA3E0C019A_52BAFC960080_impl*
end;//TEVDtoRTFRender.TreatExceptionAsSuccess

function TEVDtoRTFRender.GetHiddenStylesLength: Integer;
//#UC START# *54BF8A5702E9_52BAFC960080_var*
//#UC END# *54BF8A5702E9_52BAFC960080_var*
begin
//#UC START# *54BF8A5702E9_52BAFC960080_impl*
 Result := 2;
//#UC END# *54BF8A5702E9_52BAFC960080_impl*
end;//TEVDtoRTFRender.GetHiddenStylesLength

function TEVDtoRTFRender.GetHiddenStyles: THiddenStylesArray;
//#UC START# *54BF91620371_52BAFC960080_var*
const
 cHidden : array [0..1] of Integer = (-21, -52);
var
 i: Integer;
//#UC END# *54BF91620371_52BAFC960080_var*
begin
//#UC START# *54BF91620371_52BAFC960080_impl*
 SetLength(Result, GetHiddenStylesLength);
 for i := 0 to GetHiddenStylesLength - 1 do
  Result[i] := cHidden[i];
//#UC END# *54BF91620371_52BAFC960080_impl*
end;//TEVDtoRTFRender.GetHiddenStyles

{$If NOT Defined(NotTunedDUnit)}
function TEVDtoRTFRender.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_52BAFC960080_var*
//#UC END# *4B4F588B0241_52BAFC960080_var*
begin
//#UC START# *4B4F588B0241_52BAFC960080_impl*
 Result := OutputPath + KPage + '.rtf';
//#UC END# *4B4F588B0241_52BAFC960080_impl*
end;//TEVDtoRTFRender.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TEVDtoRTFRender.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RenderEVD';
end;//TEVDtoRTFRender.GetFolder

function TEVDtoRTFRender.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52BAFC960080';
end;//TEVDtoRTFRender.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
