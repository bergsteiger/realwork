package euml.diagram.edit.policies;

import java.util.Iterator;

import org.eclipse.emf.ecore.EAnnotation;
import org.eclipse.gef.commands.Command;
import org.eclipse.gef.commands.CompoundCommand;
import org.eclipse.gmf.runtime.emf.type.core.commands.DestroyElementCommand;
import org.eclipse.gmf.runtime.emf.type.core.requests.CreateRelationshipRequest;
import org.eclipse.gmf.runtime.emf.type.core.requests.DestroyElementRequest;
import org.eclipse.gmf.runtime.emf.type.core.requests.ReorientRelationshipRequest;
import org.eclipse.gmf.runtime.notation.Node;
import org.eclipse.gmf.runtime.notation.View;

import euml.diagram.edit.commands.DependecyCreateCommand;
import euml.diagram.edit.commands.DependecyReorientCommand;
import euml.diagram.edit.commands.GeneralizationCreateCommand;
import euml.diagram.edit.commands.GeneralizationReorientCommand;
import euml.diagram.edit.commands.RealizationCreateCommand;
import euml.diagram.edit.commands.RealizationReorientCommand;
import euml.diagram.edit.parts.AttributeEditPart;
import euml.diagram.edit.parts.ClassAttributesEditPart;
import euml.diagram.edit.parts.ClassOperationsEditPart;
import euml.diagram.edit.parts.DependecyEditPart;
import euml.diagram.edit.parts.GeneralizationEditPart;
import euml.diagram.edit.parts.OperationEditPart;
import euml.diagram.edit.parts.RealizationEditPart;
import euml.diagram.part.UmlVisualIDRegistry;
import euml.diagram.providers.UmlElementTypes;

/**
 * @generated
 */
public class ClassItemSemanticEditPolicy extends UmlBaseItemSemanticEditPolicy {

	/**
	 * @generated
	 */
	protected Command getDestroyElementCommand(DestroyElementRequest req) {
		CompoundCommand cc = getDestroyEdgesCommand();
		addDestroyChildNodesCommand(cc);
		addDestroyShortcutsCommand(cc);
		View view = (View) getHost().getModel();
		if (view.getEAnnotation("Shortcut") != null) { //$NON-NLS-1$
			req.setElementToDestroy(view);
		}
		cc.add(getGEFWrapper(new DestroyElementCommand(req)));
		return cc.unwrap();
	}

	/**
	 * @generated
	 */
	protected void addDestroyChildNodesCommand(CompoundCommand cmd) {
		View view = (View) getHost().getModel();
		EAnnotation annotation = view.getEAnnotation("Shortcut"); //$NON-NLS-1$
		if (annotation != null) {
			return;
		}
		for (Iterator it = view.getChildren().iterator(); it.hasNext();) {
			Node node = (Node) it.next();
			switch (UmlVisualIDRegistry.getVisualID(node)) {
			case ClassAttributesEditPart.VISUAL_ID:
				for (Iterator cit = node.getChildren().iterator(); cit
						.hasNext();) {
					Node cnode = (Node) cit.next();
					switch (UmlVisualIDRegistry.getVisualID(cnode)) {
					case AttributeEditPart.VISUAL_ID:
						cmd.add(getDestroyElementCommand(cnode));
						break;
					}
				}
				break;
			case ClassOperationsEditPart.VISUAL_ID:
				for (Iterator cit = node.getChildren().iterator(); cit
						.hasNext();) {
					Node cnode = (Node) cit.next();
					switch (UmlVisualIDRegistry.getVisualID(cnode)) {
					case OperationEditPart.VISUAL_ID:
						cmd.add(getDestroyElementCommand(cnode));
						break;
					}
				}
				break;
			}
		}
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
