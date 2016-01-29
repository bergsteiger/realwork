package euml.diagram.edit.commands;

import org.eclipse.core.commands.ExecutionException;
import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.gmf.runtime.common.core.command.CommandResult;
import org.eclipse.gmf.runtime.emf.type.core.commands.EditElementCommand;
import org.eclipse.gmf.runtime.emf.type.core.requests.ReorientRelationshipRequest;

import euml.Class;
import euml.Dependecy;
import euml.NamedElement;
import euml.diagram.edit.policies.UmlBaseItemSemanticEditPolicy;

/**
 * @generated
 */
public class DependecyReorientCommand extends EditElementCommand {

	/**
	 * @generated
	 */
	private final int reorientDirection;

	/**
	 * @generated
	 */
	private final EObject oldEnd;

	/**
	 * @generated
	 */
	private final EObject newEnd;

	/**
	 * @generated
	 */
	public DependecyReorientCommand(ReorientRelationshipRequest request) {
		super(request.getLabel(), request.getRelationship(), request);
		reorientDirection = request.getDirection();
		oldEnd = request.getOldRelationshipEnd();
		newEnd = request.getNewRelationshipEnd();
	}

	/**
	 * @generated
	 */
	public boolean canExecute() {
		if (false == getElementToEdit() instanceof Dependecy) {
			return false;
		}
		if (reorientDirection == ReorientRelationshipRequest.REORIENT_SOURCE) {
			return canReorientSource();
		}
		if (reorientDirection == ReorientRelationshipRequest.REORIENT_TARGET) {
			return canReorientTarget();
		}
		return false;
	}

	/**
	 * @generated
	 */
	protected boolean canReorientSource() {
		if (!(oldEnd instanceof Class && newEnd instanceof Class)) {
			return false;
		}
		NamedElement target = getLink().getTarget();
		return UmlBaseItemSemanticEditPolicy.LinkConstraints
				.canExistDependecy_4001(getNewSource(), target);
	}

	/**
	 * @generated
	 */
	protected boolean canReorientTarget() {
		if (!(oldEnd instanceof NamedElement && newEnd instanceof NamedElement)) {
			return false;
		}
		if (!(getLink().eContainer() instanceof Class)) {
			return false;
		}
		Class source = (Class) getLink().eContainer();
		return UmlBaseItemSemanticEditPolicy.LinkConstraints
				.canExistDependecy_4001(source, getNewTarget());
	}

	/**
	 * @generated
	 */
	protected CommandResult doExecuteWithResult(IProgressMonitor monitor,
			IAdaptable info) throws ExecutionException {
		if (!canExecute()) {
			throw new ExecutionException(
					"Invalid arguments in reorient link command"); //$NON-NLS-1$
		}
		if (reorientDirection == ReorientRelationshipRequest.REORIENT_SOURCE) {
			return reorientSource();
		}
		if (reorientDirection == ReorientRelationshipRequest.REORIENT_TARGET) {
			return reorientTarget();
		}
		throw new IllegalStateException();
	}

	/**
	 * @generated
	 */
	protected CommandResult reorientSource() throws ExecutionException {
		getOldSource().getDependencies().remove(getLink());
		getNewSource().getDependencies().add(getLink());
		return CommandResult.newOKCommandResult(getLink());
	}

	/**
	 * @generated
	 */
	protected CommandResult reorientTarget() throws ExecutionException {
		getLink().setTarget(getNewTarget());
		return CommandResult.newOKCommandResult(getLink());
	}

	/**
	 * @generated
	 */
	protected Dependecy getLink() {
		return (Dependecy) getElementToEdit();
	}

	/**
	 * @generated
	 */
	protected Class getOldSource() {
		return (Class) oldEnd;
	}

	/**
	 * @generated
	 */
	protected Class getNewSource() {
		return (Class) newEnd;
	}

	/**
	 * @generated
	 */
	protected NamedElement getOldTarget() {
		return (NamedElement) oldEnd;
	}

	/**
	 * @generated
	 */
	protected NamedElement getNewTarget() {
		return (NamedElement) newEnd;
	}
}
