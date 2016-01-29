package euml.diagram.edit.policies;

import org.eclipse.gef.commands.Command;
import org.eclipse.gmf.runtime.emf.type.core.requests.CreateElementRequest;

import euml.EumlPackage;
import euml.diagram.edit.commands.AttributeCreateCommand;
import euml.diagram.providers.UmlElementTypes;

/**
 * @generated
 */
public class ClassAttributesItemSemanticEditPolicy extends
		UmlBaseItemSemanticEditPolicy {

	/**
	 * @generated
	 */
	protected Command getCreateCommand(CreateElementRequest req) {
		if (UmlElementTypes.Attribute_3001 == req.getElementType()) {
			if (req.getContainmentFeature() == null) {
				req.setContainmentFeature(EumlPackage.eINSTANCE
						.getClass_Attributes());
			}
			return getGEFWrapper(new AttributeCreateCommand(req));
		}
		return super.getCreateCommand(req);
	}

}
