{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Bindings.ManagerDefaults;

interface

uses
  System.SysUtils, System.Classes, System.Rtti, System.Generics.Collections,

  System.Bindings.EvalProtocol, System.Bindings.NotifierContracts,
  System.Bindings.Manager, System.Bindings.Factories;

type
  /// <summary>
  /// Manager that supports incoming change notifications from bindable objects
  /// or other binding managers that might have further dispatched the notification.</summary>
  /// <remarks>Implements the default behaviour for the binding managers.</remarks>
  TBindingManagerDefault = class(TBindingManager, IBindingNotification)
  private
    FNotifHandler: IBindingNotification;
  protected
    /// <summary>Handles the incoming notifications from bindable objects.</summary>
    property NotifHandler: IBindingNotification read FNotifHandler implements IBindingNotification;
  public
    constructor Create(Owner: TBindingManager = nil);
    destructor Destroy; override;
  end;

implementation

uses
  System.Bindings.NotifierDefaults, System.Bindings.Expression, System.Bindings.Search, System.Bindings.Graph;

type
  { TBindingManagerNotification

    Notification interceptor for binding managers that handles:
    * the dispatching of the message to submanagers
    * the changes inside a manager when it is notified }

  TBindingManagerNotification = class(TBindingNotification)
  private
    FCounter: Integer;
  protected
    procedure NotifyExpressions(Notifier: IBindingNotifier; const PropertyName: String); virtual;
    // dispatches further the notification to the submanagers
    procedure NotifyManagers(Notifier: IBindingNotifier; const PropertyName: String); virtual;

    // entry point for receiving notifications
    procedure Notification(Notifier: IBindingNotifier; const PropertyName: String); override;
  end;

{ TBindingManagerDefault }

constructor TBindingManagerDefault.Create(Owner: TBindingManager);
begin
  inherited;

  FNotifHandler := TBindingManagerNotification.Create(Self);
end;

destructor TBindingManagerDefault.Destroy;
begin
  FNotifHandler := nil;

  inherited;
end;

{ TBindingManagerNotification }

procedure TBindingManagerNotification.Notification(Notifier: IBindingNotifier;
  const PropertyName: String);
var
  LFurtherNotif: Boolean; // True - the notification is further sent to the depenendent expressions
  LExpr: TBindingExpression; // a binding expression
  LExprScope: IScope; // scope of the expression
  LExprWrprs: TWrapperDictionary; // input wrappres of a binding expression
  LWrpr: IInterface; // input wrapper
  LWrprChild: IChild; // child support for the input wrapper
  LWrprPlaceholder: IPlaceholder; // placeholder support for the input wrapper
  LCanEvaluate: Boolean; // indicates if an expression can be evaluated
begin
  if Assigned(Notifier) then
  begin
    Inc(FCounter);
    try
    LFurtherNotif := True;

    case Notifier.Reserved of
      bnrtExternal:
        begin
          // scan the subgraph to mark the object properties and expressions
          // where the notification must later be propagated
          TBindingGraph.ClearTopology;
          TBindingGraph.ScanTopology(Notifier.Owner, PropertyName, Owner as TBindingManager);

          // jump to the next iteration
          TBindingGraph.ClearIteration;
          TBindingGraph.IncIteration;
          // iteration mark the object member that changed
          TBindingGraph.MarkIteration(Notifier.Owner, PropertyName);
        end;
      bnrtInternal:
        begin
          // can notify further if the object property is not iteration marked
          LFurtherNotif := not TBindingGraph.IsIterationMarked(Notifier.Owner, PropertyName);
          if LFurtherNotif then
            TBindingGraph.MarkIteration(Notifier.Owner, PropertyName);
        end;
    end;

    // notify to expressions and submanagers that the value of this object property
    // has changed only if it hasn't been marked already
    if LFurtherNotif then
    begin
      NotifyExpressions(Notifier, PropertyName);
      NotifyManagers(Notifier, PropertyName);
    end;

    // it's the start point of the notification wave;
    // handle the expressions that are on the wait queue
    if Notifier.Reserved = bnrtExternal then
      while not TBindingGraph.IsWaitQueueEmpty do
      begin
        // get the first expression from the wait queue
        LExprWrprs := nil;
        LExpr := TBindingGraph.DequeueWait;
        if Supports(LExpr, IScope, LExprScope) then
          try
            // get all the input wrappers of the expression and mark the
            // input object properties from the input wrappers only if all
            // the wrappers are attached to objects
            LCanEvaluate := True;
            LExprWrprs := TBindingSearch.DepthGetWrappers(LExprScope);
            for LWrpr in LExprWrprs.Keys do
              if Supports(LWrpr, IChild, LWrprChild) then
              begin
                LCanEvaluate := Supports(LWrpr, IPlaceholder, LWrprPlaceholder) and
                                (LWrprPlaceholder.Attached or LWrprPlaceholder.EvalTimeOnly);

                                                                                                    
// of object types so that the expression would also need a recompilation or better said a reattachment of
// those wrappers. It needs a reattachment of the wrappers becaue some of the wrappers that are already
// marked may have been marked in previous phases of the notification process. That means the objects
// have new values and the wrappers need to reattach to those objects again.
// Take a look at the reattachment done in the NotifyExpressions().

                // if at most one wrapper is not attached, we cannot evaluate the expression
                if LCanEvaluate then
                  TBindingGraph.MarkIteration(LWrprChild.Parent, LWrprChild.MemberName)
                else
                  Break;
              end;

            // iteration-mark the expression and execute it to continue the notification wave
            if LCanEvaluate then
            begin
              TBindingGraph.MarkIteration(LExpr);
              LExpr.EvaluateOutputs;
            end;
          finally
            LExprWrprs.Free;
          end;
      end;
    finally
      Dec(FCounter);
      if FCounter = 0 then
        TBindingGraph.ClearIteration;
    end;
  end;
end;

procedure TBindingManagerNotification.NotifyExpressions(
  Notifier: IBindingNotifier; const PropertyName: String);
var
  LExprsWrprs: TBindingGraph.TExprWrappersDict; // relates expressions with all their input wrappers
  LExprWrprsPair: TBindingGraph.TExprWrappersPair; // single relation between expression and its input wrappers
  LWrpr: IInterface; // input wrapper
  LWrprChild: IChild; // wrapper child support
  LWrprPlaceholder: IPlaceholder; // wrapper placeholder support
  LWrprScopeEnum: IScopeEnumerable; // wrapper enumerable support
  LWrprDups: TWrapperDictionary; // stores wrappers that point to the same object member
  LWrprGroup: IGroup; // wrapper group support
  LPermitsObjWrpr: Boolean;
  LObjectOnly: Boolean; // the whole object is signaled to be changed (meaning PropertyName = '')
  LFound: Boolean;
begin
  LWrprDups := nil;
  LExprsWrprs := nil;

                                                                          
// the group is iterated first, before its instances. Using a structure similar
// to the dictionary for lookups, but which assures us that the group is enumerated
// before the instances will improve speed, considering the conditions in the
// loops below

  try
    LWrprDups := TWrapperDictionary.Create;

    // determine whether the changed object property is of an object type and
    // thus accepts an object wrapper around it
    LObjectOnly := PropertyName = '';
    LPermitsObjWrpr := LObjectOnly or TBindingSearch.PermitsObjectWrapper(Notifier.Owner, PropertyName);

    // the main purpose of the these loops is to iteration-mark the independent inputs;
    // they are not topologically scanned because there is no way to get to them;
    // for properties that are of object types, it reattaches the wrappers to the new value;
    // it also generates the list of wrappers that wrap around the triggering object property
    LExprsWrprs := TBindingGraph.GetDependentExprsWrappers(Notifier.Owner, PropertyName, Owner as TBindingManager);
    for LExprWrprsPair in LExprsWrprs do
    begin
      // attach the wrappers for the triggering object property to Notifier.Owner; despite
      // they are already attached to that, it triggers a chain reaction to their subwrappers;
      // among the rest of the expression wrappers may be subwrappers of the wrappers for
      // Owner.Property and this way they will be attached to the new value of Owner.Property
      if LPermitsObjWrpr then
      begin
        // preallocate space in the duplicates list
        LWrprDups.Clear;

        for LWrpr in LExprWrprsPair.Value.Keys do
        begin
          // determine if the current wrapper is wrapping the changed object or object member
          case LObjectOnly of
            True: // it is an object wrapper
              LFound := TBindingSearch.IsObjectWrapper(LWrpr, Notifier.Owner);
            False: // it is an object member wrapper
              LFound := TBindingSearch.IsMemberWrapper(LWrpr, Notifier.Owner, PropertyName);
            else
              LFound := False;
          end;

          // wrapper group instances are added to the duplicates wrapper list to avoid the
          // same reattachment multiple times; reattaching the group is sufficient because
          // it reattaches the instances, too
          if LFound and (not LWrprDups.ContainsKey(LWrpr)) and
             Supports(LWrpr, IPlaceholder, LWrprPlaceholder) and // it must be able to reattach
             Supports(LWrpr, IScopeEnumerable, LWrprScopeEnum) then // and cycle through its subwrappers
          begin
            // groups contain wrapper instances that point to the same object
            // member and they are considered duplicates;
            if Supports(LWrpr, IGroup, LWrprGroup) then
              TBindingSearch.CollectGroupInstWrprs(LWrprGroup, LWrprDups);

            // reset the arguments of the subwrappers of this wrapper and
            // reattach the wrapper to the new parent
            TBindingSearch.ResetWrappersArguments(LWrprScopeEnum);
            LWrprPlaceholder.Attach(Notifier.Owner);
          end;
        end;
      end;

      // iteration-mark all the input objects and object properties that haven't
      // been topologically scanned
      LWrprDups.Clear;
      for LWrpr in LExprWrprsPair.Value.Keys do
      begin
        if Supports(LWrpr, IChild, LWrprChild) and
           Supports(LWrpr, IPlaceholder, LWrprPlaceholder) and
           not LWrprDups.ContainsKey(LWrpr) then
        begin
          if Supports(LWrpr, IGroup, LWrprGroup) then
            TBindingSearch.CollectGroupInstWrprs(LWrprGroup, LWrprDups);

          // we can iteration-mark the wrapper if the notification is done by the user at this stage (external)
          // or if the wrapper is attached (which is clear that the wrapper can be queried for a valid value)
          // or if the wrapper can have its value determined only at evaluation time
          // and the object member wrapped hasn't been iteration-marked yet
          if (Notifier.Reserved = bnrtExternal) or
             ((LWrprPlaceholder.Attached or LWrprPlaceholder.EvalTimeOnly) and
              not TBindingGraph.IsTopologicMarked(LWrprChild.Parent, LWrprChild.MemberName)) then
            TBindingGraph.MarkIteration(LWrprChild.Parent, LWrprChild.MemberName);
        end;
      end;
    end;

    // evalute all the expressions dependent on the current object property
    // that <have all their inputs iteration-marked> and <the expressions are
    // not iteration-marked>
    for LExprWrprsPair in LExprsWrprs do
    begin
      if not TBindingGraph.IsIterationMarked(LExprWrprsPair.Key) then
        // all the inputs of the expression are iteration-marked; evaluate it
        if TBindingGraph.AreAllIterationMarked(LExprWrprsPair.Value) then
        begin
          // an expression that is iteration-marked is ready for evaluation because
          // all its inputs are iteration-marked; so if the expression is in the wait
          // queue, it must not be there anymore
          TBindingGraph.MarkIteration(LExprWrprsPair.Key);
          TBindingGraph.DequeueWait(LExprWrprsPair.Key);

                                                                                                                       
// because the property is an object actually and it might add to the subgraph another subgraph that must be
// scanned before execution
          if LPermitsObjWrpr then
          begin
          end;

          // evaluate the expression; wrappers are attached to objects as soon as they can
          // in the process of evaluation
          LExprWrprsPair.Key.EvaluateOutputs;
        end
        // there are inputs that must be marked in some later steps of the notification
        else
          TBindingGraph.EnqueueWait(LExprWrprsPair.Key);
    end;
  finally
    LExprsWrprs.Free;
    LWrprDups.Free;
  end;
end;

procedure TBindingManagerNotification.NotifyManagers(Notifier: IBindingNotifier;
  const PropertyName: String);
var
  LManager: TBindingManager;
  LBindingNotif: IBindingNotification;
  i: Integer;
begin
  LManager := Owner as TBindingManager;

  // dispatch the notification information further to the submanagers
  for i := 0 to LManager.ManagerCount - 1 do
    if Supports(LManager.Managers[i], IBindingNotification, LBindingNotif) then
      LBindingNotif.Notification(Notifier, PropertyName)
end;

end.
