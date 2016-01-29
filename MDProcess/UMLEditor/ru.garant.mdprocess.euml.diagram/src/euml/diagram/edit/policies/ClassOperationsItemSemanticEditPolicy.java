package euml.diagram.edit.policies;

import org.eclipse.gef.commands.Command;
import org.eclipse.gmf.runtime.emf.type.core.requests.CreateElementRequest;

import euml.EumlPackage;
import euml.diagram.edit.commands.OperationCreateCommand;
import euml.diagram.providers.UmlElementTypes;

/**
 * @generated
 */
public class ClassOperationsItemSemanticEditPolicy extends
		UmlBaseItemSemanticEditPolicy {

	/**
	 * @generated
	 */
	protected Command getCreateCommand(CreateElementRequest req) {
		if (UmlElementTypes.Operation_3002 == req.getElementType()) {
			if (req.getContainmentFeature() == null) {
				req.setContainmentFeature(EumlPackage.eINSTANCE
						.getClass_Operations());
			}
			return getGEFWrapper(new OperationCreateCommand(req));
		}
		return super.getCreateCommand(req);
	}

}
