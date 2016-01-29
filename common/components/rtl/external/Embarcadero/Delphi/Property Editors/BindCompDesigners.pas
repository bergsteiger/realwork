{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompDesigners;

interface

uses System.Classes, System.SysUtils, Data.Bind.Components, ColnEdit,
Generics.Collections, BindCompDsnResStrs, System.Bindings.EvalProtocol;

procedure Register;

type

 TBindCompDesigner = class(TInterfacedObject, IBindCompDesigner)
  private
  protected
     function FormatDisplayText(ABindComponent: TCommonBindComponent;
       const AFormatString: string): string; overload;
     function FormatDisplayText(ABindComponent: TCommonBindComponent;
       const AFormatString: string; const ASourceMemberName: string): string; overload;
     function FormatDisplayText(ABindComponent: TCommonBindComponent;
       const AFormatString: string; ACount: Integer): string; overload;
    function IsReadOnly(ABindComp: TContainedBindComponent; AExpression: TBindCompDesignExpression): Boolean; overload; virtual;
    function IsReadOnly(ABindComp: TContainedBindComponent; AItem: TCollectionItem): Boolean; overload; virtual;
    function IsReadOnly(ABindComp: TContainedBindComponent; ACollection: TCollection): Boolean; overload; virtual;
    function GetDescription(ADataBinding: TContainedBindComponent): string; virtual;
    function CanBindComponent(ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean; virtual;
    function BindsComponent(ADataBinding: TContainedBindComponent; AComponent: TComponent): Boolean; virtual;
    function BindsComponentPropertyName(ADataBinding: TContainedBindComponent; const APropertyName: string): Boolean; virtual;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; virtual;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; virtual;
  end;


  TReadOnlyBindCompDelegateDesigner = class(TBindCompDesigner)
  protected
    procedure DeleteEmptyCollections(AList: TList<TBindCompDesignExpressionCollection>);
    function IsReadOnly(ABindComp: TContainedBindComponent; AExpression: TBindCompDesignExpression): Boolean; overload; override;
    function IsReadOnly(ABindComp: TContainedBindComponent; AItem: TCollectionItem): Boolean; overload;  override;
    function IsReadOnly(ABindComp: TContainedBindComponent; ACollection: TCollection): Boolean; overload;  override;
  end;

  TBindCompDelegateDesigner = class(TReadOnlyBindCompDelegateDesigner)
  private
    function TryGetDelegates(ADataBinding: TContainedBindComponent;
      out ADelegateComponent: TContainedBindComponent;
      out ADelegateDesigner: IBindCompDesigner): Boolean;
  protected
    function GetDelegate(ADataBinding: TContainedBindComponent): TContainedBindComponent; virtual; abstract;
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TBindCompDelegatesDesigner = class(TReadOnlyBindCompDelegateDesigner)
  private
    function TryGetDelegates(ADataBinding: TContainedBindComponent;
      out ADelegateComponents: TArray<TContainedBindComponent>;
      out ADelegateDesigners: TArray<IBindCompDesigner>): Boolean;
  protected
    function GetDelegates(ADataBinding: TContainedBindComponent): TArray<TContainedBindComponent>; virtual; abstract;
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;


  TBindDBFieldLinkDesigner = class(TBindCompDelegateDesigner)
  protected
    function GetDelegate(ADataBinding: TContainedBindComponent): TContainedBindComponent; override;
  end;

  TBindDBFieldLinkDesigner_NoParse = class(TBindDBFieldLinkDesigner)
  protected
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TCommonBindComponentDesigner = class(TBindCompDesigner)
  private
  protected
//     function FormatDisplayText(ABindComponent: TCommonBindComponent;
//       const AFormatString: string): string; overload;
//     function FormatDisplayText(ABindComponent: TCommonBindComponent;
//       const AFormatString: string; const ASourceMemberName: string): string; overload;
//     function FormatDisplayText(ABindComponent: TCommonBindComponent;
//       const AFormatString: string; ACount: Integer): string; overload;
    procedure ExecuteAssignToControlExpression(ABindComp: TCommonBindComponent;
      const AControlExpression, ASourceExpression: string;
      ACallback: TProc<IValue>; AType: TBindCompExpressionType = exprUnspecified);
    procedure ExecuteAssignToSourceExpression(ABindComp: TCommonBindComponent;
      const AControlExpression, ASourceExpression: string;
      ACallback: TProc<IValue>; AType: TBindCompExpressionType = exprUnspecified);
    function ControlScopeName(ABindComp: TCommonBindComponent): string;
    function SourceScopeName(ABindComp: TCommonBindComponent): string;
    function SourceMemberScopeName(ABindComp: TCommonBindComponent): string;

  end;

  TBindLinkDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TQuickBindingDesigner = class(TBindCompDelegateDesigner)
  protected
    function GetDelegate(ADataBinding: TContainedBindComponent): TContainedBindComponent; override;
  end;

  TQuickBindingDesignerMultiDelegates = class(TBindCompDelegatesDesigner)
  protected
    function GetDelegates(ADataBinding: TContainedBindComponent): TArray<TContainedBindComponent>; override;
  end;

  TLinkControlToFieldDesigner = class(TQuickBindingDesigner)
  end;

  TLinkFillControlToFieldDesigner = class(TQuickBindingDesignerMultiDelegates)
  end;

  TLinkControlToPropertyDesigner = class(TQuickBindingDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
  end;

  TLinkFillControlToPropertyDesigner = class(TQuickBindingDesignerMultiDelegates)

  end;

  TLinkListControlToFieldDesigner = class(TQuickBindingDesigner)
  end;

  TLinkPropertyToFieldDesigner = class(TQuickBindingDesigner)
  end;

  TBindExpressionDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TBindExprItemsDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TBindListDesigner = class(TCommonBindComponentDesigner)
  private
  protected
//    function FormatDisplayText(ABindList: TCustomBindList; const AFormatString: string): string;
    procedure AddExpressions(ABindComp: TCustomBindList;
      const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
      AList: TList<TBindCompDesignExpression>); virtual;
    procedure AddExpressionCollections(ABindList: TCustomBindList;
      AList: TList<TBindCompDesignExpressionCollection>); virtual;
    { IBindCompDesigner }
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TBindListLinkDesigner = class(TBindListDesigner)
  protected
    procedure AddExpressions(ABindComp: TCustomBindList;
      const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
      AList: TList<TBindCompDesignExpression>); override;
    procedure AddExpressionCollections(ABindList: TCustomBindList;
      AList: TList<TBindCompDesignExpressionCollection>); override;
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
  end;

  TBindPositionDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TExpressionsBindComponentDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;

  TBindControlValueDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;


  TBindGridListDesigner = class(TCommonBindComponentDesigner)
  protected
    procedure AddExpressions(ABindComp: TCustomBindGridList;
      const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
      AList: TList<TBindCompDesignExpression>); virtual;
    procedure AddExpressionCollections(ABindList: TCustomBindGridList;
      AList: TList<TBindCompDesignExpressionCollection>); virtual;

    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;


  TBindGridListLinkDesigner = class(TBindGridListDesigner)
  protected
    procedure AddExpressions(ABindComp: TCustomBindGridList;
      const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
      AList: TList<TBindCompDesignExpression>); override;
    procedure AddExpressionCollections(ABindList: TCustomBindGridList;
      AList: TList<TBindCompDesignExpressionCollection>); override;
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
  end;

  TBindGridLinkDesigner = class(TCommonBindComponentDesigner)
  protected
    function GetDescription(ADataBinding: TContainedBindComponent): string; override;
    function GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>; override;
    function GetExpressionCollections(ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>; override;
  end;


implementation

uses Data.Bind.DBLinks;

{ TBindCompDesigner }

function TBindCompDesigner.BindsComponent(
  ADataBinding: TContainedBindComponent; AComponent: TComponent): Boolean;
begin
  Assert(AComponent <> nil);
  Result := ADataBinding.ControlComponent = AComponent;
end;

function TBindCompDesigner.BindsComponentPropertyName(
  ADataBinding: TContainedBindComponent; const APropertyName: string): Boolean;
begin
  Result := APropertyName = 'ControlComponent'; // Do not localize
end;

function TBindCompDesigner.CanBindComponent(ADataBindingClass: TContainedBindCompClass; AComponent: TComponent;
    ADesigner: IInterface): Boolean;
begin
  Result := True;
end;

function TBindCompDesigner.GetDescription(ADataBinding: TContainedBindComponent): string;
begin
  Result := '';
end;

function TBindCompDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 0);
end;

function TBindCompDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
begin
  ATypes := [TBindCompDesignerExpressionType.exprSourceToControl];
  SetLength(Result, 0);
end;


function TBindCompDesigner.IsReadOnly(ABindComp: TContainedBindComponent;
  AExpression: TBindCompDesignExpression): Boolean;
begin
  Result := False;
end;

function TBindCompDesigner.IsReadOnly(ABindComp: TContainedBindComponent; AItem: TCollectionItem): Boolean;
begin
  Result := False;
end;

function TBindCompDesigner.IsReadOnly(ABindComp: TContainedBindComponent; ACollection: TCollection): Boolean;
begin
  Result := False;
end;

{ TBindExpressionDesigner }


function TBindExpressionDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
begin
  Assert(ADataBinding is TCustomBindExpression);
  Result := FormatDisplayText(TCommonBindComponent(ADataBinding),
    sBindExpressionDescription);
end;

function TBindExpressionDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 0);
end;

function TBindExpressionDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TCustomBindExpression;
  LControlScope: string;
  LSourceScope: string;
  LExpressionType: TBindCompDesignerExpressionType;
begin
  LBindComp := TCustomBindExpression(ADataBinding);
  Assert(LBindComp is TCustomBindExpression);
  ATypes := [exprSourceToControl, exprControlToSource, exprBidirectional];
  LList := TList<TBindCompDesignExpression>.Create;
  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceScopeName(LBindComp);
  try
    LExpressionType := exprBidirectional;
    case LBindComp.Direction of
      dirSourceToControl:
        LExpressionType := exprSourceToControl;
      dirControlToSource:
        LExpressionType := exprControlToSource;
      dirBidirectional:
        LExpressionType := exprBidirectional;
    else
      Assert(False);
    end;
//    if LBindComp.Bidirectional then
//      LExpressionType := TBindCompDesignerExpressionType.exprBidirectional
//    else
//      LExpressionType := TBindCompDesignerExpressionType.exprSourceToControl;


    LList.Add(TBindCompDesignExpression.Create(
      sFormat, LControlScope, LBindComp.ControlExpression,
      LSourceScope, LBindComp.SourceExpression,
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          Assert((LBindComp.Direction = dirSourceToControl) or
            (LBindComp.Direction = dirBidirectional));
        ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression, ACallback);
//            LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//            begin
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//            if AValue <> nil then
//              LBindComp.EvaluateControlExpression(AControlExpression, ACallback)
//            else
//              ACallback(AValue);
//            end);
      end,
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          //Assert(LBindComp.Bidirectional);
          Assert((LBindComp.Direction = dirControlToSource) or
            (LBindComp.Direction = dirBidirectional));
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression, ACallback);
//           LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//           procedure(AValue: IValue)
//           begin
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//            if AValue <> nil then
//              LBindComp.EvaluateSourceExpression(ASourceExpression, ACallback)
//            else
//              ACallback(AValue)
//           end);
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        LBindComp.EvaluateControlExpression(AExpression, ACallback);
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
      begin
        LBindComp.EvaluateSourceExpression(AExpression, ACallback);
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        LBindComp.ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        LBindComp.SourceExpression := AExpression;
      end,
      nil, // collectionitem);
      sExpression,
      nil, // parent collection item\
      LExpressionType));

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TBindExprItemsDesigner }

function TBindExprItemsDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindComp: TCustomBindExprItems;
  LCount: Integer;
begin
  Assert(ADataBinding is TCustomBindExprItems);
  LBindComp := TCustomBindExprItems(ADataBinding);
  LCount := LBindComp.FormatExpressions.Count + LBindComp.ClearExpressions.Count;
  Result := FormatDisplayText(LBindComp, sBindExprItemsDescription, LCount)
end;

function TBindExprItemsDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 2);
  Assert(ADataBinding is TCustomBindExprItems);
  Result[0] := TBindCompDesignExpressionCollection.Create(sFormat, TCustomBindExprItems(ADataBinding).FormatExpressions);
  Result[1] := TBindCompDesignExpressionCollection.Create(sClear, TCustomBindExprItems(ADataBinding).ClearExpressions);
end;

function TBindExprItemsDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TCustomBindExprItems;
  LControlScope: string;
  LSourceScope: string;
  LIndex: Integer;
  LExpression: TExpressionItemDir;
  LExpressionType: TBindCompDesignerExpressionType;
begin
  LBindComp := TCustomBindExprItems(ADataBinding);
  Assert(LBindComp is TCustomBindExprItems);
  ATypes := [exprSourceToControl, exprControlToSource, exprBidirectional];
  LList := TList<TBindCompDesignExpression>.Create;

  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceScopeName(LBindComp);

  try
    for LIndex := 0 to LBindComp.FormatExpressions.Count - 1 do
    begin
      LExpression := LBindComp.FormatExpressions[LIndex];
      LExpressionType := exprBidirectional;
      case LExpression.Direction of
        dirSourceToControl:
          LExpressionType := exprSourceToControl;
        dirControlToSource:
          LExpressionType := exprControlToSource;
        dirBidirectional:
          LExpressionType := exprBidirectional;
      else
        Assert(False);
      end;

      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
//          Assert((LBindComp.Direction = dirSourceToControl) or
//            (LBindComp.Direction = dirBidirectional));
        ExecuteAssignToControlExpression(LBindComp,   AControlExpression, ASourceExpression,
          ACallback);
//            LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//            begin
//              if AValue <> nil then
//                LBindComp.EvaluateControlExpression(AControlExpression, ACallback)
//              else
//                ACallback(AValue);
//            end);
      end,
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
//          Assert((LBindComp.Direction = dirControlToSource) or
//            (LBindComp.Direction = dirBidirectional));
          ExecuteAssignToSourceExpression(LBindComp,   AControlExpression, ASourceExpression,
          ACallback);
//            LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//            begin  // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              if AValue <> nil then
//                LBindComp.EvaluateSourceExpression(ASourceExpression, ACallback)
//              else
//                ACallback(AValue)
//            end);
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)   // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.FormatExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.FormatExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression, // collectionitem);
        sFormat,
        nil, // parent collection item
        LExpressionType));

    end;
    for LIndex := 0 to LBindComp.ClearExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ClearExpressions[LIndex];

      LExpressionType := exprBidirectional;
      case LExpression.Direction of
        dirSourceToControl,
        dirBidirectional:
          LExpressionType := exprSourceToControl;
        dirControlToSource:
          LExpressionType := exprControlToSource;
      else
        Assert(False);
      end;
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)   // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              begin
//                if AValue <> nil then
//                   LBindComp.EvaluateControlExpression(AControlExpression, ACallback)
//                else
//                  ACallback(AValue);
//              end);
        end,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)   // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.ClearExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ClearExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression, // collectionitem);
        sClear,
        nil, // parent collection item
        LExpressionType));

    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TBindLinkDesigner }

function TBindLinkDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindLink: TCustomBindLink;
begin
  Assert(ADataBinding is TCustomBindLink);
  LBindLink := TCustomBindLink(ADataBinding);
  Result := FormatDisplayText(LBindLink, sBindLinkDescription);
end;

function TBindLinkDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 3);
  Assert(ADataBinding is TCustomBindLink);
  Result[0] := TBindCompDesignExpressionCollection.Create(sFormat, TCustomBindLink(ADataBinding).FormatExpressions);
  Result[1] := TBindCompDesignExpressionCollection.Create(sParse, TCustomBindLink(ADataBinding).ParseExpressions);
  Result[2] := TBindCompDesignExpressionCollection.Create(sClear, TCustomBindLink(ADataBinding).ClearExpressions);
end;

function TBindLinkDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TCustomBindLink;
  LControlScope: string;
  LSourceScope: string;
  LIndex: Integer;
  LExpression: TExpressionItem;
begin
  LBindComp := TCustomBindLink(ADataBinding);
  Assert(LBindComp is TCustomBindLink);
  ATypes := [TBindCompDesignerExpressionType.exprControlToSource, TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;

  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceMemberScopeName(LBindComp);

  try


    for LIndex := 0 to LBindComp.FormatExpressions.Count - 1 do
    begin
      LExpression := LBindComp.FormatExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin  // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression, ACallback)
//                else
//                  ACallback(AValue)
//              end);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.FormatExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.FormatExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SFormat,
      nil, // parent collection item
      exprSourceToControl));

    end;

    for LIndex := 0 to LBindComp.ParseExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ParseExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)   // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
//              LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(ASourceExpression, ACallback)
//                else
//                  ACallback(AValue)
//              end);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SParse,
      nil, // parent collection item
      exprControlToSource));

    end;

    for LIndex := 0 to LBindComp.ClearExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ClearExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        '', LExpression.SourceExpression,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression, ACallback)
//                else
//                  ACallback(AValue)
//              end);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.ClearExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ClearExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SClear,
      nil, // parent collection item
      exprSourceToControl));

    end;

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;


{ TBindListDesigner }

function TBindListDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindList: TCustomBindList;
begin
  Assert(ADataBinding is TCustomBindList);
  LBindList := TCustomBindList(ADataBinding);
  Result := FormatDisplayText(LBindList, sBindListDescription);
end;


procedure TBindListDesigner.AddExpressionCollections(
  ABindList: TCustomBindList; AList: TList<TBindCompDesignExpressionCollection>);
begin
  AList.Add(TBindCompDesignExpressionCollection.Create(sFormatControl, ABindList.FormatControlExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sClearControl, ABindList.ClearControlExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sFormat, ABindList.FormatExpressions));
end;

function TBindListDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
var
  LList: TList<TBindCompDesignExpressionCollection>;
begin
  LList := TList<TBindCompDesignExpressionCollection>.Create;
  try
    AddExpressionCollections(ADataBinding as TCustomBindList, LList);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure TBindListDesigner.AddExpressions(ABindComp: TCustomBindList;
  const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string; AList: TList<TBindCompDesignExpression>);
var
  LExpression: TExpressionItem;
  LIndex: Integer;
begin
  for LIndex := 0 to ABindComp.FormatExpressions.Count - 1 do
  begin
    LExpression := ABindComp.FormatExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index), AControlScopeName, LExpression.ControlExpression,
      ASourceMemberScopeName, LExpression.SourceExpression,
        nil,
      nil,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        ABindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprFill);                        
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
      begin
        ABindComp.EvaluateSourceExpression(AExpression,
          ACallback,
          TBindCompExpressionType.exprFill);                         
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        ABindComp.FormatExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        ABindComp.FormatExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprSourceToControl
));
  end;

  for LIndex := 0 to ABindComp.FormatControlExpressions.Count - 1 do
  begin
    LExpression := ABindComp.FormatControlExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index), AControlScopeName, LExpression.ControlExpression,  // output
      ASourceScopeName, LExpression.SourceExpression,  // value
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          ExecuteAssignToControlExpression(ABindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);
//            ABindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//            begin
//              if AValue <> nil then
//                ABindComp.EvaluateControlExpression(AControlExpression,
//                  ACallback, TBindCompExpressionType.exprPosControl)
//              else
//                ACallback(AValue)
//            end,
//              TBindCompExpressionType.exprPosControl);
      end,
      nil,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        ABindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprFormatControl);                        
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
      begin
        ABindComp.EvaluateSourceExpression(AExpression,
          ACallback, TBindCompExpressionType.exprFormatControl);                         
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        ABindComp.FormatControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        ABindComp.FormatControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprSourceToControl
));
  end;

  for LIndex := 0 to ABindComp.ClearControlExpressions.Count - 1 do
  begin
    LExpression := ABindComp.ClearControlExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index), AControlScopeName, LExpression.ControlExpression,  // output
      ASourceScopeName, LExpression.SourceExpression,  // value
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          ExecuteAssignToControlExpression(ABindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);
//            ABindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//            procedure(AValue:IValue)
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//            begin
//              if AValue <> nil then
//                ABindComp.EvaluateControlExpression(AControlExpression,
//                  ACallback, TBindCompExpressionType.exprPosControl)
//              else
//                ACallback(AValue)
//            end,
//              TBindCompExpressionType.exprPosControl);
      end,
      nil,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        ABindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprFormatControl);                        
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
      begin
        ABindComp.EvaluateSourceExpression(AExpression,
          ACallback,
          TBindCompExpressionType.exprFormatControl);                         
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        ABindComp.ClearControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        ABindComp.ClearControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprSourceToControl
));
  end;

end;

function TBindListDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TCustomBindList;
  LControlScope: string;
  LSourceScope: string;
  LSourceMemberScope: string;
begin
  LBindComp := TCustomBindList(ADataBinding);
  Assert(LBindComp is TCustomBindList);
  ATypes := [TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;
  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceScopeName(LBindComp);
  LSourceMemberScope := SourceMemberScopeName(LBindComp);

  try
    AddExpressions(LBindComp, LControlScope, LSourceScope, LSourceMemberScope, LList);

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TBindPositionDesigner }


function TBindPositionDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindComp: TCustomBindPosition;
begin
  Assert(ADataBinding is TCustomBindPosition);
  LBindComp := TCustomBindPosition(ADataBinding);
  Result := FormatDisplayText(LBindComp, sBindPositionDescription);
end;


function TBindPositionDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 3);
  Assert(ADataBinding is TCustomBindPosition);
  Result[0] := TBindCompDesignExpressionCollection.Create(sPosControl, TCustomBindPosition(ADataBinding).PosControlExpressions);
  Result[1] := TBindCompDesignExpressionCollection.Create(sPosSource, TCustomBindPosition(ADataBinding).PosSourceExpressions);
  Result[2] := TBindCompDesignExpressionCollection.Create(sPosClear, TCustomBindPosition(ADataBinding).PosClearExpressions);
end;

function TBindPositionDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TCustomBindPosition;
  LControlScope: string;
  LSourceScope: string;
  LExpression: TExpressionItem;
  LIndex: Integer;
begin
  LBindComp := TCustomBindPosition(ADataBinding);
  Assert(LBindComp is TCustomBindPosition);
  ATypes := [TBindCompDesignerExpressionType.exprControlToSource, TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;
  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceMemberScopeName(LBindComp);

  SetLength(Result, 0);
  try

    for LIndex := 0 to LBindComp.PosControlExpressions.Count - 1 do
    begin
      LExpression := LBindComp.PosControlExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosControl);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              begin
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                  ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue)
//              end,
//              TBindCompExpressionType.exprPosControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosControl);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprPosControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.PosControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.PosControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl
));
    end;

    for LIndex := 0 to LBindComp.PosClearExpressions.Count - 1 do
    begin
      LExpression := LBindComp.PosClearExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosControl);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                    ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue)
//              end,
//              TBindCompExpressionType.exprPosControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprPosControl);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback,
            TBindCompExpressionType.exprPosControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.PosClearExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.PosClearExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl
));
    end;


    for LIndex := 0 to LBindComp.PosSourceExpressions.Count - 1 do
    begin
      LExpression := LBindComp.PosSourceExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosSource);
//              LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              begin
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(ASourceExpression,
//                    ACallback, TBindCompExpressionType.exprPosSource)
//                else
//                  ACallback(AValue)
//              end,
//              TBindCompExpressionType.exprPosSource);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
              ACallback,
            TBindCompExpressionType.exprPosSource);                         
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprPosSource);                        
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.PosSourceExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.PosSourceExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprControlToSource
));
    end;



    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TExpressionsBindComponentDesigner }

function TExpressionsBindComponentDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 3);
  Assert(ADataBinding is TExpressionsBindComponent);
  Result[0] := TBindCompDesignExpressionCollection.Create(sFormat, TExpressionsBindComponent(ADataBinding).FormatExpressions);
  Result[1] := TBindCompDesignExpressionCollection.Create(sParse, TExpressionsBindComponent(ADataBinding).ParseExpressions);
  Result[2] := TBindCompDesignExpressionCollection.Create(sClear, TExpressionsBindComponent(ADataBinding).ClearExpressions);
end;

function TExpressionsBindComponentDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TExpressionsBindComponent;
  LControlScope: string;
  LSourceScope: string;
  LIndex: Integer;
  LExpression: TExpressionItem;
begin
  LBindComp := TExpressionsBindComponent(ADataBinding);
  Assert(LBindComp is TExpressionsBindComponent);
  ATypes := [TBindCompDesignerExpressionType.exprControlToSource, TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;

  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceMemberScopeName(LBindComp);

  try


    for LIndex := 0 to LBindComp.FormatExpressions.Count - 1 do
    begin
      LExpression := LBindComp.FormatExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.FormatExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.FormatExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SFormat,
      nil, // parent collection item
      exprSourceToControl));

    end;

    for LIndex := 0 to LBindComp.ParseExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ParseExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)   // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SParse,
      nil, // parent collection item
      exprControlToSource));

    end;

    for LIndex := 0 to LBindComp.ClearExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ClearExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        '', LExpression.SourceExpression,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
           LBindComp.EvaluateControlExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression, ACallback);
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.ClearExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ClearExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SClear,
      nil, // parent collection item
      exprSourceToControl));

    end;

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TExpressionsBindComponentDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindComp: TExpressionsBindComponent;
begin
  Assert(ADataBinding is TExpressionsBindComponent);
  LBindComp := TExpressionsBindComponent(ADataBinding);
  Result := FormatDisplayText(LBindComp, sExpressionsBindCompDesc);
end;

{ TBindControlValueDesigner }

function TBindControlValueDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindComp: TCustomBindControlValue;
begin
  Assert(ADataBinding is TCustomBindControlValue);
  LBindComp := TCustomBindControlValue(ADataBinding);
  Result := FormatDisplayText(LBindComp, sBindControlValueDescription);
end;


function TBindControlValueDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
begin
  SetLength(Result, 3);
  Assert(ADataBinding is TCustomBindControlValue);
  Result[0] := TBindCompDesignExpressionCollection.Create(sFormat, TCustomBindControlValue(ADataBinding).FormatExpressions);
  Result[1] := TBindCompDesignExpressionCollection.Create(sParse, TCustomBindControlValue(ADataBinding).ParseExpressions);
  Result[2] := TBindCompDesignExpressionCollection.Create(sClear, TCustomBindControlValue(ADataBinding).ClearExpressions);
end;

function TBindControlValueDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LList: TList<TBindCompDesignExpression>;
  LBindComp: TCustomBindControlValue;
  LControlScope: string;
  LSourceScope: string;
  LExpression: TExpressionItem;
  LIndex: Integer;
begin
  LBindComp := TCustomBindControlValue(ADataBinding);
  Assert(LBindComp is TCustomBindControlValue);
  ATypes := [TBindCompDesignerExpressionType.exprControlToSource, TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;
  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceMemberScopeName(LBindComp);

  SetLength(Result, 0);
  try

    for LIndex := 0 to LBindComp.ParseExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ParseExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormat);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              begin
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                  ACallback, TBindCompExpressionType.exprParse)
//                else
//                  ACallback(AValue)
//              end,
//              TBindCompExpressionType.exprParse);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprParse);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprParse);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.ParseExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl
));
    end;

    for LIndex := 0 to LBindComp.ClearExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ClearExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormat);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              begin
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                  ACallback, TBindCompExpressionType.exprParse)
//                else
//                  ACallback(AValue)
//              end,
//              TBindCompExpressionType.exprParse);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprParse);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprParse);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.ClearExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ClearExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl
));
    end;

//    for LIndex := 0 to LBindComp.PosClearExpressions.Count - 1 do
//    begin
//      LExpression := LBindComp.PosClearExpressions[LIndex];
//      LList.Add(TBindCompDesignExpression.Create(
//        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
//        LSourceScope, LExpression.SourceExpression,  // value
//        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
//        begin
//          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
//            ACallback, TBindCompExpressionType.exprPosControl);
////              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
////              procedure(AValue: IValue)
////              begin
////                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
////                if AValue <> nil then
////                  LBindComp.EvaluateControlExpression(AControlExpression,
////                    ACallback, TBindCompExpressionType.exprPosControl)
////                else
////                  ACallback(AValue)
////              end,
////              TBindCompExpressionType.exprPosControl);
//        end,
//        nil,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
//        begin
//          LBindComp.EvaluateControlExpression(AExpression,
//            ACallback, TBindCompExpressionType.exprPosControl); // TODO: support nested
//        end,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
//        begin
//          LBindComp.EvaluateSourceExpression(AExpression,
//            ACallback,
//            TBindCompExpressionType.exprPosControl);  // TODO: support nested
//        end,
//        procedure(const AName: string; const AExpression: string)  // Save Control
//        begin
//          // Anon capture doesn't seem to work here for LIndex, so use name
//          LBindComp.PosClearExpressions[StrToInt(AName)].ControlExpression := AExpression;
//        end,
//        procedure(const AName: string; const AExpression: string)  // Save Source
//        begin
//          LBindComp.PosClearExpressions[StrToInt(AName)].SourceExpression := AExpression;
//        end,
//        LExpression,
//        '',
//      nil, // parent collection item
//      exprSourceToControl
//));
//    end;


    for LIndex := 0 to LBindComp.FormatExpressions.Count - 1 do
    begin
      LExpression := LBindComp.FormatExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormat);
//              LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              begin
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(ASourceExpression,
//                    ACallback, TBindCompExpressionType.exprFormat)
//                else
//                  ACallback(AValue)
//              end,
//              TBindCompExpressionType.exprFormat);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
              ACallback,
            TBindCompExpressionType.exprFormat);                         
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprFormat);                        
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.FormatExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.FormatExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprControlToSource
));
    end;



    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;




{ TBindColumnListDesigner }


procedure TBindGridListDesigner.AddExpressionCollections(
  ABindList: TCustomBindGridList;
  AList: TList<TBindCompDesignExpressionCollection>);
var
  I: Integer;
  LColumnExpressionItem: TColumnFormatExpressionItem;
begin
  AList.Add(TBindCompDesignExpressionCollection.Create(sFormatControl, ABindList.FormatControlExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sClearControl, ABindList.ClearControlExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create
    (sColumns, ABindList.ColumnExpressions, nil, colCollections));
  for I := 0 to ABindList.ColumnExpressions.Count - 1 do
  begin
    LColumnExpressionItem := TColumnFormatExpressionItem(ABindList.ColumnExpressions[I]);
    AList.Add(TBindCompDesignExpressionCollection.Create
      (sFormatColumn, LColumnExpressionItem.FormatColumnExpressions, LColumnExpressionItem));
    AList.Add(TBindCompDesignExpressionCollection.Create
      (sFormatCell, LColumnExpressionItem.FormatCellExpressions, LColumnExpressionItem));
  end;
end;

procedure TBindGridListDesigner.AddExpressions(ABindComp: TCustomBindGridList;
  const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
  AList: TList<TBindCompDesignExpression>);

  function GetSaveControlExpressionProc(AExpressionItem: TExpressionItem): TBindCompDesignExpression.TSaveDesignExpression;
  begin
    Result :=
      procedure(const AName: string; const AExpressionText: string)  // Save Output
      begin
        AExpressionItem.ControlExpression := AExpressionText;
      end;
  end;

  function GetSaveSourceExpressionProc(AExpressionItem: TExpressionItem): TBindCompDesignExpression.TSaveDesignExpression;
  begin
    Result :=
      procedure(const AName: string; const AExpressionText: string)  // Save Output
      begin
        AExpressionItem.SourceExpression := AExpressionText;
      end;
  end;


  procedure AddExpressions(AList: TList<TBindCompDesignExpression>; AColumnExpressionItem: TColumnFormatExpressionItem;
    const AName: string; AExpressions: TExpressions; AType: TBindCompExpressionType;
    ADirection: TBindCompDesignerExpressionType);
  var
    LControlScope: string;
    LSourceScope: string;
    LExpression: TExpressionItem;
    LIndex: Integer;
    LSaveControl: TBindCompDesignExpression.TSaveDesignExpression;
    LSaveSource: TBindCompDesignExpression.TSaveDesignExpression;
    LAssignToControlProc:  TBindCompDesignExpression.TExecuteDesignExpression2;
    LAssignToSourceProc:  TBindCompDesignExpression.TExecuteDesignExpression2;
  begin
//    if ABindComp.ControlComponent <> nil then
//      LControlScope := ABindComp.ControlComponent.Name
//    else
//      LControlScope := '';
//    if ABindComp.SourceComponent <> nil then
//      LSourceScope := ABindComp.SourceComponent.Name
//    else
//      LSourceScope := '';
    LControlScope := ControlScopeName(ABindComp);
    LSourceScope := SourceScopeName(ABindComp);
    if AColumnExpressionItem.SourceMemberName <> '' then
      LSourceScope := LSourceScope + ', ' + AColumnExpressionItem.SourceMemberName;


    if AType = TBindCompExpressionType.exprFormatColumn then
    begin
      LAssignToControlProc :=
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
              ABindComp.ExecuteAssignToControlExpression(AColumnExpressionItem, AControlExpression, ASourceExpression,
              procedure(AValue: IValue)
              begin
                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
                if AValue <> nil then
                  ABindComp.EvaluateControlExpression(AColumnExpressionItem, AControlExpression,
                  ACallback, AType)
                else
                  ACallback(AValue)
              end, AType);
        end;
      LAssignToSourceProc :=
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
              ABindComp.ExecuteAssignToSourceExpression(AColumnExpressionItem, AControlExpression, ASourceExpression,
              procedure(AValue: IValue)
              begin
                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
                if AValue <> nil then
                  ABindComp.EvaluateSourceExpression(AColumnExpressionItem, ASourceExpression,
                    ACallback, AType)
                else
                  ACallback(AValue)
              end, AType);
        end;
    end
    else
    begin
      LAssignToControlProc := nil;
      LAssignToSourceProc := nil;
    end;

    for LIndex := 0 to AExpressions.Count - 1 do
    begin
      LExpression := AExpressions[LIndex];
      LSaveSource := GetSaveSourceExpressionProc(LExpression);
      LSaveControl := GetSaveControlExpressionProc(LExpression);

      AList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        LAssignToControlProc,
        LAssignToSourceProc,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
            ABindComp.EvaluateControlExpression(AColumnExpressionItem, AExpression,
              ACallback, AType);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
            ABindComp.EvaluateSourceExpression(AColumnExpressionItem, AExpression,
              ACallback, AType);
        end,
        LSaveControl,  // Save Control
        LSaveSource,  // Save Source
        LExpression,
        AName,
      AColumnExpressionItem, // parent collection item
      ADirection));
    end;
  end;

  procedure AddControlExpressions(LList: TList<TBindCompDesignExpression>);
  var
    LIndex: Integer;
    LExpression: TExpressionItem;
    LSourceScope: string;
    LControlScope: string;
  begin
//  if ABindComp.ControlComponent <> nil then
//    LControlScope := ABindComp.ControlComponent.Name
//  else
//    LControlScope := '';
//  if ABindComp.SourceComponent <> nil then
//    LSourceScope := ABindComp.SourceComponent.Name
//  else
//    LSourceScope := '';

    LControlScope := ControlScopeName(ABindComp);
    LSourceScope := SourceScopeName(ABindComp);
    for LIndex := 0 to ABindComp.FormatControlExpressions.Count - 1 do
    begin
      LExpression := ABindComp.FormatControlExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(ABindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);
//              ABindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  ABindComp.EvaluateControlExpression(AControlExpression, ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue)
//              end, TBindCompExpressionType.exprFormatControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          ABindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          ABindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          ABindComp.FormatControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          ABindComp.FormatControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl));
    end;

    for LIndex := 0 to ABindComp.ClearControlExpressions.Count - 1 do
    begin
      LExpression := ABindComp.ClearControlExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(ABindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);
//              ABindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin  // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  ABindComp.EvaluateControlExpression(AControlExpression,
//                    ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue);
//              end, TBindCompExpressionType.exprPosControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          ABindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          ABindComp.EvaluateSourceExpression(AExpression,
            ACallback,
            TBindCompExpressionType.exprPosControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          ABindComp.ClearControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          ABindComp.ClearControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl));
    end;


  end;
var
  I: Integer;
  LColumnExpressionItem: TColumnFormatExpressionItem;
begin
  for I := 0 to ABindComp.ColumnExpressions.Count - 1 do
  begin
    LColumnExpressionItem := TColumnFormatExpressionItem(ABindComp.ColumnExpressions[I]);
    AddExpressions(AList, LColumnExpressionItem, sFormatColumn,
      LColumnExpressionItem.FormatColumnExpressions, TBindCompExpressionType.exprFormatColumn,
      exprSourceToControl);
    AddExpressions(AList, LColumnExpressionItem, sFormatCell,
      LColumnExpressionItem.FormatCellExpressions, TBindCompExpressionType.exprFill,
      exprSourceToControl);
  end;


  AddControlExpressions(AList);

end;

function TBindGridListDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindColumns: TCustomBindGridList;
begin
  Assert(ADataBinding is TCustomBindGridList);
  LBindColumns := TCustomBindGridList(ADataBinding);
  Result := FormatDisplayText(LBindColumns, sBindListDescription);
end;

function TBindGridListDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
var
//  I: Integer;
  LBindComp: TCustomBindGridList;
//  LColumnExpressionItem: TColumnFormatExpressionItem;
  LList: TList<TBindCompDesignExpressionCollection>;
begin
  Assert(ADataBinding is TCustomBindGridList);
  LBindComp := TCustomBindGridList(ADataBinding);
  LList := TList<TBindCompDesignExpressionCollection>.Create;
  try
    AddExpressionCollections(LBindComp, LList);
//    LList.Add(TBindCompDesignExpressionCollection.Create(sFormatControl, LBindComp.FormatControlExpressions));
//    LList.Add(TBindCompDesignExpressionCollection.Create(sClearControl, LBindComp.ClearControlExpressions));
//    LList.Add(TBindCompDesignExpressionCollection.Create
//      (sColumns, LBindComp.ColumnExpressions, nil, colCollections));
//    for I := 0 to LBindComp.ColumnExpressions.Count - 1 do
//    begin
//      LColumnExpressionItem := TColumnFormatExpressionItem(LBindComp.ColumnExpressions[I]);
//      LList.Add(TBindCompDesignExpressionCollection.Create
//        (sFormatColumn, LColumnExpressionItem.FormatColumnExpressions, LColumnExpressionItem));
//      LList.Add(TBindCompDesignExpressionCollection.Create
//        (sFormatCell, LColumnExpressionItem.FormatCellExpressions, LColumnExpressionItem));
//    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TBindGridListDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LBindComp: TCustomBindGridList;

//  function GetSaveControlExpressionProc(AExpressionItem: TExpressionItem): TBindCompDesignExpression.TSaveDesignExpression;
//  begin
//    Result :=
//      procedure(const AName: string; const AExpressionText: string)  // Save Output
//      begin
//        AExpressionItem.ControlExpression := AExpressionText;
//      end;
//  end;
//
//  function GetSaveSourceExpressionProc(AExpressionItem: TExpressionItem): TBindCompDesignExpression.TSaveDesignExpression;
//  begin
//    Result :=
//      procedure(const AName: string; const AExpressionText: string)  // Save Output
//      begin
//        AExpressionItem.SourceExpression := AExpressionText;
//      end;
//  end;

//  procedure AddExpressions(AList: TList<TBindCompDesignExpression>; AColumnExpressionItem: TColumnFormatExpressionItem;
//    const AName: string; AExpressions: TExpressions; AType: TBindCompExpressionType;
//    ADirection: TBindCompDesignerExpressionType);
//  var
//    LControlScope: string;
//    LSourceScope: string;
//    LExpression: TExpressionItem;
//    LIndex: Integer;
//    LSaveControl: TBindCompDesignExpression.TSaveDesignExpression;
//    LSaveSource: TBindCompDesignExpression.TSaveDesignExpression;
//  begin
////    if LBindComp.ControlComponent <> nil then
////      LControlScope := LBindComp.ControlComponent.Name
////    else
////      LControlScope := '';
////    if LBindComp.SourceComponent <> nil then
////      LSourceScope := LBindComp.SourceComponent.Name
////    else
////      LSourceScope := '';
//    LControlScope := ControlScopeName(LBindComp);
//    LSourceScope := SourceScopeName(LBindComp);
//    if AColumnExpressionItem.SourceMemberName <> '' then
//      LSourceScope := LSourceScope + ', ' + AColumnExpressionItem.SourceMemberName;
//
//    for LIndex := 0 to AExpressions.Count - 1 do
//    begin
//      LExpression := AExpressions[LIndex];
//      LSaveSource := GetSaveSourceExpressionProc(LExpression);
//      LSaveControl := GetSaveControlExpressionProc(LExpression);
//
//      AList.Add(TBindCompDesignExpression.Create(
//        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
//        LSourceScope, LExpression.SourceExpression,
//        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
//        begin
//              LBindComp.ExecuteAssignToControlExpression(AColumnExpressionItem, AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AColumnExpressionItem, AControlExpression,
//                  ACallback, AType)
//                else
//                  ACallback(AValue)
//              end, AType);
//        end,
//        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
//        begin
//              LBindComp.ExecuteAssignToSourceExpression(AColumnExpressionItem, AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(AColumnExpressionItem, ASourceExpression,
//                    ACallback, AType)
//                else
//                  ACallback(AValue)
//              end, AType);
//        end,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
//        begin
//            LBindComp.EvaluateControlExpression(AColumnExpressionItem, AExpression,
//              ACallback, AType);
//        end,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
//        begin
//            LBindComp.EvaluateSourceExpression(AColumnExpressionItem, AExpression,
//              ACallback, AType);
//        end,
//        LSaveControl,  // Save Control
//        LSaveSource,  // Save Source
//        LExpression,
//        AName,
//      AColumnExpressionItem, // parent collection item
//      ADirection));
//    end;
//  end;
//
//  procedure AddControlExpressions(LList: TList<TBindCompDesignExpression>);
//  var
//    LIndex: Integer;
//    LExpression: TExpressionItem;
//    LSourceScope: string;
//    LControlScope: string;
//  begin
////  if LBindComp.ControlComponent <> nil then
////    LControlScope := LBindComp.ControlComponent.Name
////  else
////    LControlScope := '';
////  if LBindComp.SourceComponent <> nil then
////    LSourceScope := LBindComp.SourceComponent.Name
////  else
////    LSourceScope := '';
//
//    LControlScope := ControlScopeName(LBindComp);
//    LSourceScope := SourceScopeName(LBindComp);
//    for LIndex := 0 to LBindComp.FormatControlExpressions.Count - 1 do
//    begin
//      LExpression := LBindComp.FormatControlExpressions[LIndex];
//      LList.Add(TBindCompDesignExpression.Create(
//        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
//        LSourceScope, LExpression.SourceExpression,  // value
//        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
//        begin
//          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
//            ACallback, TBindCompExpressionType.exprFormatControl);
////              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
////              procedure(AValue: IValue)
////              begin
////                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
////                if AValue <> nil then
////                  LBindComp.EvaluateControlExpression(AControlExpression, ACallback, TBindCompExpressionType.exprPosControl)
////                else
////                  ACallback(AValue)
////              end, TBindCompExpressionType.exprFormatControl);
//        end,
//        nil,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
//        begin
//          LBindComp.EvaluateControlExpression(AExpression,
//            ACallback, TBindCompExpressionType.exprFormatControl); // TODO: support nested
//        end,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
//        begin
//          LBindComp.EvaluateSourceExpression(AExpression,
//            ACallback, TBindCompExpressionType.exprFormatControl);  // TODO: support nested
//        end,
//        procedure(const AName: string; const AExpression: string)  // Save Control
//        begin
//          // Anon capture doesn't seem to work here for LIndex, so use name
//          LBindComp.FormatControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
//        end,
//        procedure(const AName: string; const AExpression: string)  // Save Source
//        begin
//          LBindComp.FormatControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
//        end,
//        LExpression,
//        '',
//      nil, // parent collection item
//      exprSourceToControl));
//    end;
//
//    for LIndex := 0 to LBindComp.ClearControlExpressions.Count - 1 do
//    begin
//      LExpression := LBindComp.ClearControlExpressions[LIndex];
//      LList.Add(TBindCompDesignExpression.Create(
//        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
//        LSourceScope, LExpression.SourceExpression,  // value
//        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
//        begin
//          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
//            ACallback, TBindCompExpressionType.exprFormatControl);
////              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
////              procedure(AValue: IValue)
////              begin  // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
////                if AValue <> nil then
////                  LBindComp.EvaluateControlExpression(AControlExpression,
////                    ACallback, TBindCompExpressionType.exprPosControl)
////                else
////                  ACallback(AValue);
////              end, TBindCompExpressionType.exprPosControl);
//        end,
//        nil,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
//        begin
//          LBindComp.EvaluateControlExpression(AExpression,
//            ACallback, TBindCompExpressionType.exprFormatControl); // TODO: support nested
//        end,
//        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
//        begin
//          LBindComp.EvaluateSourceExpression(AExpression,
//            ACallback,
//            TBindCompExpressionType.exprPosControl);  // TODO: support nested
//        end,
//        procedure(const AName: string; const AExpression: string)  // Save Control
//        begin
//          // Anon capture doesn't seem to work here for LIndex, so use name
//          LBindComp.ClearControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
//        end,
//        procedure(const AName: string; const AExpression: string)  // Save Source
//        begin
//          LBindComp.ClearControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
//        end,
//        LExpression,
//        '',
//      nil, // parent collection item
//      exprSourceToControl));
//    end;
//
//
//  end;

var
  LList: TList<TBindCompDesignExpression>;
  LControlScope: string;
  LSourceScope: string;
  LSourceMemberScope: string;
begin
  LBindComp := TCustomBindGridList(ADataBinding);
  Assert(LBindComp is TCustomBindGridList);
  ATypes := [TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;
  SetLength(Result, 0);
  LControlScope := ControlScopeName(LBindComp);
  LSourceScope := SourceScopeName(LBindComp);
  LSourceMemberScope := SourceMemberScopeName(LBindComp);
  try

//    for I := 0 to LBindComp.ColumnExpressions.Count - 1 do
//    begin
//      LColumnExpressionItem := TColumnFormatExpressionItem(LBindComp.ColumnExpressions[I]);
//      AddExpressions(LList, LColumnExpressionItem, sFormatColumn,
//        LColumnExpressionItem.FormatColumnExpressions, TBindCompExpressionType.exprFormatColumn,
//        exprSourceToControl);
//      AddExpressions(LList, LColumnExpressionItem, sFormatCell,
//        LColumnExpressionItem.FormatCellExpressions, TBindCompExpressionType.exprFill,
//        exprSourceToControl);
//    end;
//
//
//    AddControlExpressions(LList);
    AddExpressions(LBindComp, LControlScope, LSourceScope, LSourceMemberScope, LList);

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TBindColumnDesigner }

function TBindGridLinkDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindColumns: TCustomBindGridLink;
begin
  Assert(ADataBinding is TCustomBindGridLink);
  LBindColumns := TCustomBindGridLink(ADataBinding);
  Result := FormatDisplayText(LBindColumns, sBindGridLinkDescription);
end;

function TBindGridLinkDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
var
  I: Integer;
  LBindComp: TCustomBindGridLink;
  LColumnExpressionItem: TColumnLinkExpressionItem;
  LList: TList<TBindCompDesignExpressionCollection>;
begin
  Assert(ADataBinding is TCustomBindGridLink);
  LBindComp := TCustomBindGridLink(ADataBinding);
  LList := TList<TBindCompDesignExpressionCollection>.Create;
  try
    LList.Add(TBindCompDesignExpressionCollection.Create(sFormatControl, LBindComp.FormatControlExpressions));
    LList.Add(TBindCompDesignExpressionCollection.Create(sClearControl, LBindComp.ClearControlExpressions));
    LList.Add(TBindCompDesignExpressionCollection.Create(sPosControl, LBindComp.PosControlExpressions));
    LList.Add(TBindCompDesignExpressionCollection.Create(sPosSource, LBindComp.PosSourceExpressions));
    LList.Add(TBindCompDesignExpressionCollection.Create
      (sColumns, LBindComp.ColumnExpressions, nil, colCollections));
    for I := 0 to LBindComp.ColumnExpressions.Count - 1 do
    begin
      LColumnExpressionItem := TColumnLinkExpressionItem(LBindComp.ColumnExpressions[I]);
      LList.Add(TBindCompDesignExpressionCollection.Create
        (sFormatColumn, LColumnExpressionItem.FormatColumnExpressions, LColumnExpressionItem));
      LList.Add(TBindCompDesignExpressionCollection.Create
        (sFormatCell, LColumnExpressionItem.FormatCellExpressions, LColumnExpressionItem));
      LList.Add(TBindCompDesignExpressionCollection.Create
        (sParseCell, LColumnExpressionItem.ParseCellExpressions, LColumnExpressionItem));
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TBindGridLinkDesigner.GetExpressions(ADataBinding: TContainedBindComponent; out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LBindComp: TCustomBindGridLink;

  function GetSaveControlExpressionProc(AExpressionItem: TExpressionItem): TBindCompDesignExpression.TSaveDesignExpression;
  begin
    Result :=
      procedure(const AName: string; const AExpressionText: string)  // Save Output
      begin
        AExpressionItem.ControlExpression := AExpressionText;
      end;
  end;

  function GetSaveSourceExpressionProc(AExpressionItem: TExpressionItem): TBindCompDesignExpression.TSaveDesignExpression;
  begin
    Result :=
      procedure(const AName: string; const AExpressionText: string)  // Save Output
      begin
        AExpressionItem.SourceExpression := AExpressionText;
      end;
  end;

  procedure AddExpressions(AList: TList<TBindCompDesignExpression>; AColumnExpressionItem: TColumnLinkExpressionItem;
    const AName: string; AExpressions: TExpressions; AType: TBindCompExpressionType;
    ADirection: TBindCompDesignerExpressionType);
  var
    LControlScope: string;
    LSourceScope: string;
    LExpression: TExpressionItem;
    LIndex: Integer;
    LSaveControl: TBindCompDesignExpression.TSaveDesignExpression;
    LSaveSource: TBindCompDesignExpression.TSaveDesignExpression;
    LAssignToControlProc:  TBindCompDesignExpression.TExecuteDesignExpression2;
    LAssignToSourceProc:  TBindCompDesignExpression.TExecuteDesignExpression2;
  begin
//    if LBindComp.ControlComponent <> nil then
//      LControlScope := LBindComp.ControlComponent.Name
//    else
//      LControlScope := '';
//    if LBindComp.SourceComponent <> nil then
//      LSourceScope := LBindComp.SourceComponent.Name
//    else
//      LSourceScope := '';
    LControlScope := ControlScopeName(LBindComp);
    LSourceScope := SourceScopeName(LBindComp);
    if AColumnExpressionItem.SourceMemberName <> '' then
      LSourceScope := LSourceScope + ', ' + AColumnExpressionItem.SourceMemberName;

    if AType = TBindCompExpressionType.exprFormatColumn then
    begin
      LAssignToControlProc :=
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
              LBindComp.ExecuteAssignToControlExpression(AColumnExpressionItem, AControlExpression, ASourceExpression,
              procedure(AValue:IValue)
              begin
                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
                if AValue <> nil then
                  LBindComp.EvaluateControlExpression(AColumnExpressionItem, AControlExpression, ACallback, AType)
                else
                  ACallback(AValue)
              end, AType);
        end;
      LAssignToSourceProc :=
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
              LBindComp.ExecuteAssignItemToSourceExpression(AColumnExpressionItem, AControlExpression, ASourceExpression,
              procedure(AValue: IValue)
              begin
                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
                if AValue <> nil then
                  LBindComp.EvaluateSourceExpression(AColumnExpressionItem, ASourceExpression,
                    ACallback, AType)
                else
                  ACallback(AValue)
              end, AType);
        end;
    end
    else
    begin
      LAssignToControlProc := nil;
      LAssignToSourceProc := nil;
    end;
    for LIndex := 0 to AExpressions.Count - 1 do
    begin
      LExpression := AExpressions[LIndex];
        LSaveSource := GetSaveSourceExpressionProc(LExpression);
        LSaveControl := GetSaveControlExpressionProc(LExpression);

      AList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        LAssignToControlProc,
         LAssignToSourceProc,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
            LBindComp.EvaluateControlExpression(AColumnExpressionItem, AExpression,
              ACallback, AType)
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
            LBindComp.EvaluateSourceExpression(AColumnExpressionItem, AExpression,
              ACallback, AType);
        end,
        LSaveControl,  // Save Control
        LSaveSource,  // Save Source
        LExpression,
        AName,
      AColumnExpressionItem, // parent collection item
      ADirection));
    end;
  end;

  procedure AddControlExpressions(LList: TList<TBindCompDesignExpression>);
  var
    LIndex: Integer;
    LExpression: TExpressionItem;
    LSourceScope: string;
    LControlScope: string;
  begin
//  if LBindComp.ControlComponent <> nil then
//    LControlScope := LBindComp.ControlComponent.Name
//  else
//    LControlScope := '';
//  if LBindComp.SourceComponent <> nil then
//    LSourceScope := LBindComp.SourceComponent.Name
//  else
//    LSourceScope := '';
    LControlScope := ControlScopeName(LBindComp);
    LSourceScope := SourceScopeName(LBindComp);

    for LIndex := 0 to LBindComp.FormatControlExpressions.Count - 1 do
    begin
      LExpression := LBindComp.FormatControlExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                    ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue)
//              end,
//                TBindCompExpressionType.exprPosControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
              ACallback,
            TBindCompExpressionType.exprFormatControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.FormatControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.FormatControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl));
    end;


    for LIndex := 0 to LBindComp.ClearControlExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ClearControlExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprFormatControl);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin  // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                   ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue)
//              end,
//                 TBindCompExpressionType.exprPosControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprFormatControl)                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback,
            TBindCompExpressionType.exprFormatControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.ClearControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.ClearControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl));
    end;



  end;


  procedure AddPosExpressions(LList: TList<TBindCompDesignExpression>);
  var
    LIndex: Integer;
    LExpression: TExpressionItem;
    LSourceScope: string;
    LControlScope: string;
  begin
//  if LBindComp.ControlComponent <> nil then
//    LControlScope := LBindComp.ControlComponent.Name
//  else
//    LControlScope := '';
//  if LBindComp.SourceComponent <> nil then
//    LSourceScope := LBindComp.SourceComponent.Name
//  else
//    LSourceScope := '';
    LControlScope := ControlScopeName(LBindComp);
    LSourceScope := SourceScopeName(LBindComp);

    for LIndex := 0 to LBindComp.PosControlExpressions.Count - 1 do
    begin
      LExpression := LBindComp.PosControlExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index), LControlScope, LExpression.ControlExpression,  // output
        LSourceScope, LExpression.SourceExpression,  // value
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosControl);
//              LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateControlExpression(AControlExpression,
//                   ACallback, TBindCompExpressionType.exprPosControl)
//                else
//                  ACallback(AValue)
//              end,
//                 TBindCompExpressionType.exprPosControl);
        end,
        nil,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
           ACallback, TBindCompExpressionType.exprPosControl);                        
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback,
            TBindCompExpressionType.exprPosControl);                         
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.PosControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          LBindComp.PosControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprSourceToControl));
    end;


    for LIndex := 0 to LBindComp.PosSourceExpressions.Count - 1 do
    begin
      LExpression := LBindComp.PosSourceExpressions[LIndex];
      LList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        LControlScope, LExpression.ControlExpression,
        LSourceScope, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosSource);
//              LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(ASourceExpression,
//                  ACallback, TBindCompExpressionType.exprPosSource)
//                else
//                  ACallback(AValue)
//              end, TBindCompExpressionType.exprPosSource);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
            ACallback,
            TBindCompExpressionType.exprPosSource);                         
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
           ACallback, TBindCompExpressionType.exprPosSource);                        
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.PosSourceExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.PosSourceExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        '',
      nil, // parent collection item
      exprControlToSource));
    end;
  end;

var
  LList: TList<TBindCompDesignExpression>;
  I: Integer;
  LColumnExpressionItem: TColumnLinkExpressionItem;

begin
  LBindComp := TCustomBindGridLink(ADataBinding);
  Assert(LBindComp is TCustomBindGridLink);
  ATypes := [TBindCompDesignerExpressionType.exprControlToSource,
    TBindCompDesignerExpressionType.exprSourceToControl];
  LList := TList<TBindCompDesignExpression>.Create;
  SetLength(Result, 0);
  try

    for I := 0 to LBindComp.ColumnExpressions.Count - 1 do
    begin
      LColumnExpressionItem := TColumnLinkExpressionItem(LBindComp.ColumnExpressions[I]);
      AddExpressions(LList, LColumnExpressionItem, sFormatColumn,
        LColumnExpressionItem.FormatColumnExpressions, TBindCompExpressionType.exprFormatColumn,
        exprSourceToControl);
      AddExpressions(LList, LColumnExpressionItem, sFormatCell,
        LColumnExpressionItem.FormatCellExpressions, TBindCompExpressionType.exprFill,
        exprSourceToControl);
      AddExpressions(LList, LColumnExpressionItem, sParseCell,
        LColumnExpressionItem.ParseCellExpressions, TBindCompExpressionType.exprParse,
        exprControlToSource);
    end;


    AddControlExpressions(LList);
    AddPosExpressions(LList);

    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TBindListLinkDesigner }

procedure TBindListLinkDesigner.AddExpressionCollections(
  ABindList: TCustomBindList;
  AList: TList<TBindCompDesignExpressionCollection>);
begin
  inherited;
  AList.Add(TBindCompDesignExpressionCollection.Create(sPosControl, (ABindList as TCustomBindListLink).PosControlExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sPosSource, (ABindList as TCustomBindListLink).PosSourceExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sParse, (ABindList as TCustomBindListLink).ParseExpressions));

end;

procedure TBindListLinkDesigner.AddExpressions(ABindComp: TCustomBindList;
  const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
  AList: TList<TBindCompDesignExpression>);
var
  LBindComp: TCustomBindListLink;
  LIndex: Integer;
  LExpression: TExpressionItem;
begin
  inherited;
  LBindComp := ABindComp as TCustomBindListLink;

  for LIndex := 0 to LBindComp.PosControlExpressions.Count - 1 do
  begin
    LExpression := LBindComp.PosControlExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index), AControlScopeName, LExpression.ControlExpression,  // output
      ASourceScopeName, LExpression.SourceExpression,  // value
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosControl);
//            LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//            begin
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              if AValue <> nil then
//                LBindComp.EvaluateControlExpression(AControlExpression,
//                 ACallback, TBindCompExpressionType.exprPosControl)
//              else
//                ACallback(AValue)
//            end,
//               TBindCompExpressionType.exprPosControl);
      end,
      nil,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosControl);                        
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)   // Execute Source
      begin
        LBindComp.EvaluateSourceExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosControl);                         
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        LBindComp.PosControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        LBindComp.PosControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprSourceToControl));
  end;


  for LIndex := 0 to LBindComp.PosSourceExpressions.Count - 1 do
  begin
    LExpression := LBindComp.PosSourceExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index),
      AControlScopeName, LExpression.ControlExpression,
      ASourceScopeName, LExpression.SourceExpression,
      nil,
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosSource);
//            LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//            begin
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              if AValue <> nil then
//                LBindComp.EvaluateControlExpression(ASourceExpression,
//                  ACallback, TBindCompExpressionType.exprPosSource)
//              else
//                ACallback(AValue)
//            end,
//               TBindCompExpressionType.exprPosSource);
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosSource);                         
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
      begin
        LBindComp.EvaluateSourceExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosSource);                        
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        LBindComp.PosSourceExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        LBindComp.PosSourceExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprControlToSource));
  end;

    for LIndex := 0 to LBindComp.ParseExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ParseExpressions[LIndex];
      AList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        AControlScopeName, LExpression.ControlExpression,
        ASourceScopeName, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprParse);
//              LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(AControlExpression, ACallback,
//                   TBindCompExpressionType.exprParse)
//                else
//                  ACallback(AValue)
//              end,
//                 TBindCompExpressionType.exprParse);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprParse);                         
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprParse);                        
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.ParseExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SParse,
      nil, // parent collection item
      exprSourceToControl));

    end;

end;

function TBindListLinkDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindList: TCustomBindList;
begin
  Assert(ADataBinding is TCustomBindList);
  LBindList := TCustomBindList(ADataBinding);
  Result := FormatDisplayText(LBindList, sBindLinkDescription);
end;

{ TBindGridListLinkDesigner }

procedure TBindGridListLinkDesigner.AddExpressionCollections(
  ABindList: TCustomBindGridList;
  AList: TList<TBindCompDesignExpressionCollection>);
begin
  inherited;
  AList.Add(TBindCompDesignExpressionCollection.Create(sPosControl, (ABindList as TCustomBindGridListLink).PosControlExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sPosSource, (ABindList as TCustomBindGridListLink).PosSourceExpressions));
  AList.Add(TBindCompDesignExpressionCollection.Create(sParse, (ABindList as TCustomBindGridListLink).ParseExpressions));

end;

procedure TBindGridListLinkDesigner.AddExpressions(ABindComp: TCustomBindGridList;
  const AControlScopeName, ASourceScopeName, ASourceMemberScopeName: string;
  AList: TList<TBindCompDesignExpression>);
var
  LBindComp: TCustomBindGridListLink;
  LIndex: Integer;
  LExpression: TExpressionItem;
begin
  inherited;
  LBindComp := ABindComp as TCustomBindGridListLink;

  for LIndex := 0 to LBindComp.PosControlExpressions.Count - 1 do
  begin
    LExpression := LBindComp.PosControlExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index), AControlScopeName, LExpression.ControlExpression,  // output
      ASourceScopeName, LExpression.SourceExpression,  // value
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          ExecuteAssignToControlExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosControl);
//            LBindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//            begin
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              if AValue <> nil then
//                LBindComp.EvaluateControlExpression(AControlExpression,
//                 ACallback, TBindCompExpressionType.exprPosControl)
//              else
//                ACallback(AValue)
//            end,
//               TBindCompExpressionType.exprPosControl);
      end,
      nil,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosControl);                        
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)   // Execute Source
      begin
        LBindComp.EvaluateSourceExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosControl);                         
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        LBindComp.PosControlExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        LBindComp.PosControlExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprSourceToControl));
  end;


  for LIndex := 0 to LBindComp.PosSourceExpressions.Count - 1 do
  begin
    LExpression := LBindComp.PosSourceExpressions[LIndex];
    AList.Add(TBindCompDesignExpression.Create(
      IntToStr(LExpression.Index),
      AControlScopeName, LExpression.ControlExpression,
      ASourceScopeName, LExpression.SourceExpression,
      nil,
      procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
      begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprPosSource);
//            LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//            procedure(AValue: IValue)
//            begin
//              // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//              if AValue <> nil then
//                LBindComp.EvaluateControlExpression(ASourceExpression,
//                  ACallback, TBindCompExpressionType.exprPosSource)
//              else
//                ACallback(AValue)
//            end,
//               TBindCompExpressionType.exprPosSource);
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
      begin
        LBindComp.EvaluateControlExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosSource);                         
      end,
      procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
      begin
        LBindComp.EvaluateSourceExpression(AExpression,
          ACallback, TBindCompExpressionType.exprPosSource);                        
      end,
      procedure(const AName: string; const AExpression: string)  // Save Control
      begin
        LBindComp.PosSourceExpressions[StrToInt(AName)].ControlExpression := AExpression;
      end,
      procedure(const AName: string; const AExpression: string)  // Save Source
      begin
        // Anon capture doesn't seem to work here for LIndex, so use name
        LBindComp.PosSourceExpressions[StrToInt(AName)].SourceExpression := AExpression;
      end,
      LExpression,
      '',
    nil, // parent collection item
    exprControlToSource));
  end;

    for LIndex := 0 to LBindComp.ParseExpressions.Count - 1 do
    begin
      LExpression := LBindComp.ParseExpressions[LIndex];
      AList.Add(TBindCompDesignExpression.Create(
        IntToStr(LExpression.Index),
        AControlScopeName, LExpression.ControlExpression,
        ASourceScopeName, LExpression.SourceExpression,
        nil,
        procedure(const AName: string; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>)    // Execute
        begin
          ExecuteAssignToSourceExpression(LBindComp, AControlExpression, ASourceExpression,
            ACallback, TBindCompExpressionType.exprParse);
//              LBindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
//              procedure(AValue: IValue)
//              begin
//                // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
//                if AValue <> nil then
//                  LBindComp.EvaluateSourceExpression(AControlExpression, ACallback,
//                   TBindCompExpressionType.exprParse)
//                else
//                  ACallback(AValue)
//              end,
//                 TBindCompExpressionType.exprParse);
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Control
        begin
          LBindComp.EvaluateControlExpression(AExpression,
            ACallback, TBindCompExpressionType.exprParse);                         
        end,
        procedure(const AName: string; const AExpression: string; ACallback: TProc<IValue>)    // Execute Source
        begin
          LBindComp.EvaluateSourceExpression(AExpression,
            ACallback, TBindCompExpressionType.exprParse);                        
        end,
        procedure(const AName: string; const AExpression: string)  // Save Control
        begin
          LBindComp.ParseExpressions[StrToInt(AName)].ControlExpression := AExpression;
        end,
        procedure(const AName: string; const AExpression: string)  // Save Source
        begin
          // Anon capture doesn't seem to work here for LIndex, so use name
          LBindComp.ParseExpressions[StrToInt(AName)].SourceExpression := AExpression;
        end,
        LExpression,
        SParse,
      nil, // parent collection item
      exprSourceToControl));

    end;

end;

function TBindGridListLinkDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBindList: TCustomBindGridListLink;
begin
  Assert(ADataBinding is TCustomBindGridListLink);
  LBindList := TCustomBindGridListLink(ADataBinding);
  Result := FormatDisplayText(LBindList, sBindLinkDescription);
end;

{ TBindCompDelegateDesigner }


function TBindCompDelegateDesigner.TryGetDelegates(ADataBinding: TContainedBindComponent;
  out ADelegateComponent: TContainedBindComponent; out ADelegateDesigner: IBindCompDesigner): Boolean;
begin
  ADelegateComponent := GetDelegate(ADataBinding);
  if ADelegateComponent <> nil then
    ADelegateDesigner := Data.Bind.Components.GetBindCompDesigner(TContainedBindCompClass(ADelegateComponent.ClassType))
  else
    ADelegateDesigner := nil;
  Result := (ADelegateComponent <> nil) and (ADelegateDesigner <> nil);
end;

function TBindCompDelegateDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LDelegateDesigner: IBindCompDesigner;
  LDelegateComponent: TContainedBindComponent;
begin
  if TryGetDelegates(ADataBinding, LDelegateComponent, LDelegateDesigner) then
    Result := LDelegateDesigner.GetDescription(LDelegateComponent)
  else
    Result := '';
end;

function TBindCompDelegateDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
var
  LDelegateDesigner: IBindCompDesigner;
  LDelegateComponent: TContainedBindComponent;
  LCollections: TList<TBindCompDesignExpressionCollection>;
begin
  LCollections := TList<TBindCompDesignExpressionCollection>.Create;
  try
    if TryGetDelegates(ADataBinding, LDelegateComponent, LDelegateDesigner) then
    begin
      LCollections.AddRange(LDelegateDesigner.GetExpressionCollections(LDelegateComponent));
      DeleteEmptyCollections(LCollections);
    end;
    Result := LCollections.ToArray;
  finally
    LCollections.Free;
  end;
end;

function TBindCompDelegateDesigner.GetExpressions(
  ADataBinding: TContainedBindComponent;
  out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LDelegateDesigner: IBindCompDesigner;
  LDelegateComponent: TContainedBindComponent;
begin
  if TryGetDelegates(ADataBinding, LDelegateComponent, LDelegateDesigner) then
    Result := LDelegateDesigner.GetExpressions(LDelegateComponent, ATypes)
  else
    SetLength(Result, 0);
end;

{ TReadOnlyBindCompDelegateDesigner }

function TReadOnlyBindCompDelegateDesigner.IsReadOnly(ABindComp: TContainedBindComponent;
  AExpression: TBindCompDesignExpression): Boolean;
begin
  Result := True;
end;

function TReadOnlyBindCompDelegateDesigner.IsReadOnly(ABindComp: TContainedBindComponent; AItem: TCollectionItem): Boolean;
begin
  Result := True;
end;

procedure TReadOnlyBindCompDelegateDesigner.DeleteEmptyCollections(
  AList: TList<TBindCompDesignExpressionCollection>);
var
  I: Integer;
begin
  for I := AList.Count - 1 downto 0 do // Remove empty collections
    if AList[I].Collection.Count = 0 then
      AList.Delete(I);
end;

function TReadOnlyBindCompDelegateDesigner.IsReadOnly(ABindComp: TContainedBindComponent;
  ACollection: TCollection): Boolean;
begin
  Result := True;
end;

{ TBindCompDelegatesDesigner }


function TBindCompDelegatesDesigner.TryGetDelegates(ADataBinding: TContainedBindComponent;
  out ADelegateComponents: TArray<TContainedBindComponent>; out ADelegateDesigners: TArray<IBindCompDesigner>): Boolean;
var
  LComponent: TContainedBindComponent;
  LDesigners: TList<IBindCompDesigner>;
begin
  LDesigners := TList<IBindCompDesigner>.Create;
  try
    ADelegateComponents := GetDelegates(ADataBinding);
    for LComponent in ADelegateComponents do
      if LComponent <> nil then
        LDesigners.Add(Data.Bind.Components.GetBindCompDesigner(TContainedBindCompClass(LComponent.ClassType)));
    ADelegateDesigners := LDesigners.ToArray;
    Result := (Length(ADelegateComponents) <> 0) and (Length(ADelegateDesigners) <> 0);
  finally
    LDesigners.Free;
  end;
end;

function TBindCompDelegatesDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LDelegateDesigners: TArray<IBindCompDesigner>;
  LDelegateComponents: TArray<TContainedBindComponent>;
begin
  if TryGetDelegates(ADataBinding, LDelegateComponents, LDelegateDesigners) and
    (LDelegateDesigners[0] <> nil) then
    Result := LDelegateDesigners[0].GetDescription(LDelegateComponents[0])
  else
    Result := '';
end;

function TBindCompDelegatesDesigner.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
var
  LDelegateDesigners: TArray<IBindCompDesigner>;
  LDelegateComponents: TArray<TContainedBindComponent>;
  LCollections: TList<TBindCompDesignExpressionCollection>;
  I: Integer;
begin
  if TryGetDelegates(ADataBinding, LDelegateComponents, LDelegateDesigners) then
  begin
    LCollections := TList<TBindCompDesignExpressionCollection>.Create;
    try
      Assert(Length(LDelegateDesigners) = Length(LDelegateComponents));
      for I := 0 to Length(LDelegateDesigners) - 1 do
        if LDelegateDesigners[I] <> nil then
          LCollections.AddRange(LDelegateDesigners[I].GetExpressionCollections(LDelegateComponents[I]));
      DeleteEmptyCollections(LCollections);
//      for I := LCollections.Count - 1 downto 0 do // Remove empty collections
//        if LCollections[I].Collection.Count = 0 then
//          if IsReadOnly(ADataBinding, LCollections[I].Collection) then
//            LCollections.Delete(I);
      Result := LCollections.ToArray;
    finally
      LCollections.Free;
    end;
  end
  else
    SetLength(Result, 0);
end;

function TBindCompDelegatesDesigner.GetExpressions(
  ADataBinding: TContainedBindComponent;
  out ATypes: TBindCompDesignerExpressionTypes): TArray<TBindCompDesignExpression>;
var
  LDelegateDesigners: TArray<IBindCompDesigner>;
  LDelegateComponents: TArray<TContainedBindComponent>;
  LExpressions: TList<TBindCompDesignExpression>;
  I: Integer;
begin
  if TryGetDelegates(ADataBinding, LDelegateComponents, LDelegateDesigners) then
  begin
    LExpressions := TList<TBindCompDesignExpression>.Create;
    try
      Assert(Length(LDelegateDesigners) = Length(LDelegateComponents));
      for I := 0 to Length(LDelegateDesigners) - 1 do
        if LDelegateDesigners[I] <> nil then
          LExpressions.AddRange(LDelegateDesigners[I].GetExpressions(LDelegateComponents[I], ATypes));
      Result := LExpressions.ToArray;
    finally
      LExpressions.Free;
    end;
  end
  else
    SetLength(Result, 0);
end;


{ TCustomBindDBFieldLinkDesigner }

function TBindDBFieldLinkDesigner.GetDelegate(
  ADataBinding: TContainedBindComponent): TContainedBindComponent;
var
  LComponent: TBaseBindDBControlLink;
begin
  LComponent := ADataBinding as TBaseBindDBControlLink;
  Result := LComponent.GetDelegates[0];
end;

{ TBindDBFieldLinkDesigner_NoParse }

function TBindDBFieldLinkDesigner_NoParse.GetExpressionCollections(
  ADataBinding: TContainedBindComponent): TArray<TBindCompDesignExpressionCollection>;
var
  LCollection: TBindCompDesignExpressionCollection;
  LList:  TList<TBindCompDesignExpressionCollection>;
begin
  Result := inherited;
  // Exclude Parse collection because can't write label text to field
  LList := TList<TBindCompDesignExpressionCollection>.Create;
  try
    for LCollection in Result do
    begin
      if LCollection.Name = sParse then
        continue;
      LList.Add(LCollection);
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;


end;

procedure Register;
begin
  RegisterBindCompDesigner(TCustomBindExpression, TBindExpressionDesigner.Create);
  RegisterBindCompDesigner(TCustomBindExprItems, TBindExprItemsDesigner.Create);

  RegisterBindCompDesigner(TCustomBindLink, TBindLinkDesigner.Create);
  RegisterBindCompDesigner(TCustomLinkControlToField, TLinkControlToFieldDesigner.Create);
  RegisterBindCompDesigner(TCustomLinkFillControlToField, TLinkFillControlToFieldDesigner.Create);
  RegisterBindCompDesigner(TCustomLinkControlToProperty, TLinkControlToPropertyDesigner.Create);
  RegisterBindCompDesigner(TCustomLinkFillControlToProperty, TLinkFillControlToPropertyDesigner.Create);
  RegisterBindCompDesigner(TCustomLinkListControlToField, TLinkListControlToFieldDesigner.Create);
  RegisterBindCompDesigner(TCustomLinkPropertyToField, TLinkPropertyToFieldDesigner.Create);
  RegisterBindCompDesigner(TCustomBindList, TBindListDesigner.Create);
  RegisterBindCompDesigner(TCustomBindGridLink, TBindGridLinkDesigner.Create);
  RegisterBindCompDesigner(TCustomBindListLink, TBindListLinkDesigner.Create);
  RegisterBindCompDesigner(TCustomBindGridList, TBindGridListDesigner.Create);
  RegisterBindCompDesigner(TCustomBindGridListLink, TBindGridListLinkDesigner.Create);
  RegisterBindCompDesigner(TCustomBindPosition, TBindPositionDesigner.Create);
  RegisterBindCompDesigner(TCustomBindControlValue, TBindControlValueDesigner.Create);
  RegisterBindCompDesigner(TExpressionsBindComponent, TExpressionsBindComponentDesigner.Create);
end;

{ TCommonBindComponentDesigner }

function TBindCompDesigner.FormatDisplayText(
  ABindComponent: TCommonBindComponent; const AFormatString: string): string;
begin
  Result := FormatDisplayText(ABindComponent, AFormatString,
    ABindComponent.SourceMemberName);
end;

function TBindCompDesigner.FormatDisplayText(
  ABindComponent: TCommonBindComponent; const AFormatString: string;
  const ASourceMemberName: string): string;
var
  LControlScope: string;
  LSourceScope: string;
begin
  if ABindComponent.SourceComponent <> nil then
    LSourceScope := ABindComponent.SourceComponent.Name;
  if ASourceMemberName <> '' then
    LSourceScope := LSourceScope + ', ' + ASourceMemberName;
  if ABindComponent.ControlComponent <> nil then
    LControlScope := ABindComponent.ControlComponent.Name;
  Result := Format(AFormatString (*sBindListDescription*), [LControlScope, LSourceScope]);
end;

function TBindCompDesigner.FormatDisplayText(
  ABindComponent: TCommonBindComponent; const AFormatString: string; ACount: Integer): string;
var
  LControlScope: string;
  LSourceScope: string;
begin
  if ABindComponent.SourceComponent <> nil then
    LSourceScope := ABindComponent.SourceComponent.Name;
  if ABindComponent.SourceMemberName <> '' then
    LSourceScope := LSourceScope + ', ' + ABindComponent.SourceMemberName;
  if ABindComponent.ControlComponent <> nil then
    LControlScope := ABindComponent.ControlComponent.Name;
  Result := Format(AFormatString (*sBindListDescription*), [LControlScope, LSourceScope, ACount]);
end;

function TCommonBindComponentDesigner.ControlScopeName(
  ABindComp: TCommonBindComponent): string;
begin
  if ABindComp.ControlComponent <> nil then
    Result := ABindComp.ControlComponent.Name
  else
    Result := '';
end;

function TCommonBindComponentDesigner.SourceScopeName(
  ABindComp: TCommonBindComponent): string;
begin
  if ABindComp.SourceComponent <> nil then
    Result := ABindComp.SourceComponent.Name
  else
    Result := '';
end;

function TCommonBindComponentDesigner.SourceMemberScopeName(
  ABindComp: TCommonBindComponent): string;
begin
  Result := SourceScopeName(ABindComp);
  if ABindComp.SourceMemberName <> '' then
    Result := Result + ', ' + ABindComp.SourceMemberName;
end;

procedure TCommonBindComponentDesigner.ExecuteAssignToControlExpression(
  ABindComp: TCommonBindComponent; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
begin
  ABindComp.ExecuteAssignToControlExpression(AControlExpression, ASourceExpression,
  procedure(AValue: IValue)
  begin
    // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
  if AValue <> nil then
    ABindComp.EvaluateControlExpression(AControlExpression, ACallback)
  else
    ACallback(AValue);
  end);
end;

procedure TCommonBindComponentDesigner.ExecuteAssignToSourceExpression(
  ABindComp: TCommonBindComponent; const AControlExpression, ASourceExpression: string; ACallback: TProc<IValue>;
  AType: TBindCompExpressionType);
begin
   ABindComp.ExecuteAssignToSourceExpression(AControlExpression, ASourceExpression,
   procedure(AValue: IValue)
   begin
      // Display value of output expression in case it is a TObject.  This allows visualizers work on TObject
    if AValue <> nil then
      ABindComp.EvaluateSourceExpression(ASourceExpression, ACallback, AType)
    else
      ACallback(AValue)
   end, AType);
end;

{ TQuickBindLinkDesigner }

function TQuickBindingDesigner.GetDelegate(
  ADataBinding: TContainedBindComponent): TContainedBindComponent;
var
  LComponent: TBindComponentDelegate;
begin
  LComponent := ADataBinding as TBindComponentDelegate;
  Result := LComponent.GetDelegates[0];
end;

{ TBindControlToPropertyDesigner }

function TLinkControlToPropertyDesigner.GetDescription(
  ADataBinding: TContainedBindComponent): string;
var
  LBinding: TCustomLinkControlToProperty;
begin
  Assert(ADataBinding is TCustomLinkControlToProperty);
  LBinding := TCustomLinkControlToProperty(ADataBinding);
  Result := FormatDisplayText(LBinding.GetDelegates[0], sBindControlValueDescription,
    LBinding.ComponentProperty);
end;

{ TQuickBindingDesignerMultiDelegates }

function TQuickBindingDesignerMultiDelegates.GetDelegates(
  ADataBinding: TContainedBindComponent): TArray<TContainedBindComponent>;
var
  LComponents: TArray<TCommonBindComponent>;
  LComponent: TContainedBindComponent;
  LResult: TList<TContainedBindComponent>;
begin
  LResult := TList<TContainedBindComponent>.Create;
  try
    LComponents := (ADataBinding as TBindComponentDelegate).GetDelegates;
    for LComponent in LComponents do
    begin
      LResult.Add(LComponent);
    end;
    Result := LResult.ToArray;
  finally
    LResult.Free;
  end;
end;

end.
