package euml.diagram.edit.policies;

import org.eclipse.gef.commands.Command;
import org.eclipse.gef.commands.CompoundCommand;
import org.eclipse.gmf.runtime.emf.type.core.commands.DestroyElementCommand;
import org.eclipse.gmf.runtime.emf.type.core.requests.CreateRelationshipRequest;
import org.eclipse.gmf.runtime.emf.type.core.requests.DestroyElementRequest;
import org.eclipse.gmf.runtime.emf.type.core.requests.ReorientRelationshipRequest;

import euml.diagram.edit.commands.DependecyCreateCommand;
import euml.diagram.edit.commands.DependecyReorientCommand;
import euml.diagram.edit.commands.GeneralizationCreateCommand;
import euml.diagram.edit.commands.GeneralizationReorientCommand;
import euml.diagram.edit.commands.RealizationCreateCommand;
import euml.diagram.edit.commands.RealizationReorientCommand;
import euml.diagram.edit.parts.DependecyEditPart;
import euml.diagram.edit.parts.GeneralizationEditPart;
import euml.diagram.edit.parts.RealizationEditPart;
import euml.diagram.providers.UmlElementTypes;

/**
 * @generated
 */
public class OperationItemSemanticEditPolicy extends
		UmlBaseItemSemanticEditPolicy {

	/**
	 * @generated
	 */
	protected Command getDestroyElementCommand(DestroyElementRequest req) {
		CompoundCommand cc = getDestroyEdgesCommand();
		addDestroyShortcutsCommand(cc);
		cc.add(getGEFWrapper(new DestroyElementCommand(req)));
		return cc.unwrap();
	}

	/**
	 * @generated
	 */
	protected Command getCreateRelationshipCommand(CreateRelationshipRequest req) {
		Command command = req.getTarget() == null ? getStartCreateRelationshipCommand(req)
				: getCompleteCreateRelationshipCommand(req);
		return command != null ? command : super
				.getCreateRelationshipCommand(req);
	}

	/**
	 * @generated
	 */
	protected Command getStartCreateRelationshipCommand(
			CreateRelationshipRequest req) {
		if (UmlElementTypes.Dependecy_4001 == req.getElementType()) {
			return null;
		}
		if (UmlElementTypes.Realization_4002 == req.getElementType()) {
			return null;
		}
		if (UmlElementTypes.Generalization_4003 == req.getElementType()) {
			return null;
		}
		return null;
	}

	/**
	 * @generated
	 */
	protected Command getCompleteCreateRelationshipCommand(
			CreateRelationshipRequest req) {
		if (UmlElementTypes.Dependecy_4001 == req.getElementType()) {
			return getGEFWrapper(new DependecyCreateCommand(req, req
					.getSource(), req.getTarget()));
		}
		if (UmlElementTypes.Realization_4002 == req.getElementType()) {
			return getGEFWrapper(new RealizationCreateCommand(req, req
					.getSource(), req.getTarget()));
		}
		if (UmlElementTypes.Generalization_4003 == req.getElementType()) {
			return getGEFWrapper(new GeneralizationCreateCommand(req, req
					.getSource(), req.getTarget()));
		}
		return null;
	}

	/**
	 * Returns command to reorient EClass based link. New link target or source
	 * should be the domain model element associated with this node.
	 * 
	 * @generated
	 */
	protected Command getReorientRelationshipCommand(
			ReorientRelationshipRequest req) {
		switch (getVisualID(req)) {
		case DependecyEditPart.VISUAL_ID:
			return getGEFWrapper(new DependecyReorientCommand(req));
		case RealizationEditPart.VISUAL_ID:
			return getGEFWrapper(new RealizationReorientCommand(req));
		case GeneralizationEditPart.VISUAL_ID:
			return getGEFWrapper(new GeneralizationReorientCommand(req));
		}
		return super.getReorientRelationshipCommand(req);
	}

}
